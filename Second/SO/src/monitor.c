#include "monitor.h"

void signal_handler_C(int signum){
    unlink("tracer_to_monitor");
    unlink("monitor_to_tracer");
    unlink("argumentos");
    unlink("argc");
    printf("\nServidor terminou!\n");
    exit(0);
}

long int stringToLong(const char* str) {
    char* endptr;
    long int value = strtol(str, &endptr, 10);

    if (endptr == str) {
        fprintf(stderr, "Erro: Nenhum número foi convertido.\n");
        exit(EXIT_FAILURE);
    } else if (*endptr != '\0') {
        fprintf(stderr, "Erro: Conversão parou no caractere '%c'.\n", *endptr);
        exit(EXIT_FAILURE);
    }

    return value;
}


void runStatus (Process_Executing *processo, int fd){
    struct timeval current_time;
    gettimeofday(&current_time, NULL);
    int nbytes=0;
    char *buffer = malloc(sizeof(char)*MAX);

    Process_Executing atual = *processo;

    if (atual == NULL){
        write(fd, "Não existem processos em execução.\n", MAX);
        return;
    }

    while(atual != NULL){
        int pid_int = atoi(atual->pid);
        long long unsigned start = stringToLong(atual->start);
        int dec = (int)(current_time.tv_sec - start)*1000;
        nbytes=sprintf(buffer, "Pid: %d, Program: %s, Tempo Decorrido: %d\n", pid_int, atual->program, dec);
        write(fd, buffer, nbytes);
        free(buffer);
        nbytes=0;

        atual=atual->next;
    }
}

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int binary_search(int arr[], int size, int target, int* index) {
    int left = 0;
    int right = size - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] == target) {
            *index = mid;
            return 1; // Encontrou o elemento
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return 0; // Não encontrou o elemento
}

int runStatusTime(Process *processo, int fd, int pid[], int max) {
    char *buffer = malloc(sizeof(char) * MAX);
    int contador = 0;

    Process atual = *processo;

    qsort(pid, max, sizeof(int), cmpfunc);

    while (atual != NULL) {
        int pid_int = atoi(atual->pid);
        int time_int = atoi(atual->time_ms);
        int index;
        //printf("pid: %s, pid_int: %d, time: %d\n", atual->pid, pid_int, time_int);
        if (binary_search(pid, max, pid_int, &index)) {
            contador += time_int;
        }
        atual = atual->next;
    }

    int nbytes = sprintf(buffer, "Tempo total dos processos: %d\n", contador);
    write(fd, buffer, nbytes);
    free(buffer);
    return contador;
}

    

char* getPID(char* s) {

    char* pid_start = strstr(s, "Pid: ");
    if (pid_start == NULL) {
        return NULL;  // PID não encontrado
    }

    pid_start += strlen("Pid: ");  // avança o ponteiro para o início do PID

    char* pid_end = strchr(pid_start, '\n');  // procura o fim do PID
    if (pid_end == NULL) {
        return NULL;  // fim do PID não encontrado
    }

    size_t pid_len = pid_end - pid_start;  // calcula o comprimento do PID

    char* pid = (char*) malloc(pid_len + 1);  // aloca memória para a string do PID

    strncpy(pid, pid_start, pid_len);  // copia os caracteres do PID

    pid[pid_len] = '\0';  // adiciona o caracter nulo final

    return pid;
}

char* getPROGRAM(char* s) {

    char* program_start = strstr(s, "Program: ");
    if (program_start == NULL) {
        return NULL;  // PID não encontrado
    }

    program_start += strlen("Program: ");  // avança o ponteiro para o início do PROGRAM

    char* program_end = strchr(program_start, '\n');  // procura o fim do PROGRAM
    if (program_end == NULL) {
        return NULL;  // fim do PROGRAM não encontrado
    }

    size_t program_len = program_end - program_start;  // calcula o comprimento do PROGRAM

    char* program = (char*) malloc(program_len + 1);  // aloca memória para a string do PROGRAM

    strncpy(program, program_start, program_len);  // copia os caracteres do PROGRAM

    program[program_len] = '\0';  // adiciona o caracter nulo final
    
    return program;
}

char* getTIME_MS(char* s) {

    char* time_ms_start = strstr(s, "Time: ");
    if (time_ms_start == NULL) {
        return NULL;  // TIME_MS não encontrado
    }

    time_ms_start += strlen("Time: ");  // avança o ponteiro para o início do TIME_MS

    char* time_ms_end = strchr(time_ms_start, '\n');  // procura o fim do TIME_MS
    if (time_ms_end == NULL) {
        return NULL;  // fim do TIME_MS não encontrado
    }

    size_t time_ms_len = time_ms_end - time_ms_start;  // calcula o comprimento do TIME_MS

    char* time_ms = (char*) malloc(time_ms_len + 1);  // aloca memória para a string do TIME_MS

    strncpy(time_ms, time_ms_start, time_ms_len);  // copia os caracteres do TIME_MS

    time_ms[time_ms_len] = '\0';  // adiciona o caracter nulo final

    return time_ms;
}

char* getSTART(char* s) {

    char* start_start = strstr(s, "Start: ");
    if (start_start == NULL) {
        return NULL;  // START não encontrado
    }

    start_start += strlen("Start: ");  // avança o ponteiro para o início do START

    char* start_end = strchr(start_start, '\n');  // procura o fim do START
    if (start_end == NULL) {
        return NULL;  // fim do START não encontrado
    }

    size_t start_len = start_end - start_start;  // calcula o comprimento do START

    char* start = (char*) malloc(start_len + 1);  // aloca memória para a string do START

    strncpy(start, start_start, start_len);  // copia os caracteres do START

    start[start_len] = '\0';  // adiciona o caracter nulo final

    return start;
}

void addProcessoExecuted(Process *processo, char *program, char *pid, char *time_ms){
	Process novoProcesso = malloc(sizeof(struct process));
    novoProcesso->pid = strdup(pid);
    novoProcesso->program = strdup(program);
    novoProcesso->time_ms = strdup(time_ms);
    novoProcesso->next = *processo; 
    *processo = novoProcesso;
}

void addProcessoExecuting(Process_Executing *processo, char *pid, char *program, char *start){
    Process_Executing novoProcesso = malloc(sizeof(struct process_executing));

    novoProcesso->pid = strdup(pid);
    novoProcesso->program = strdup(program);
    novoProcesso->start = strdup(start);
    novoProcesso->next = *processo;
    *processo = novoProcesso;
}

void removeProcessoExecuting(Process_Executing *processo, char *pid) {
    if (*processo == NULL) {
        return;
    }

    if (strcmp((*processo)->pid, pid) == 0) {
        Process_Executing temp = *processo;
        *processo = (*processo)->next;
        free(temp);
        return;
    }

    Process_Executing current = *processo;
    Process_Executing previous = NULL;

    while (current != NULL && strcmp(current->pid, pid) != 0) {
        previous = current;
        current = current->next;
    }

    if (current == NULL) {
        return;
    }

    previous->next = current->next;
    free(current);
}

void parteString(char *s, int pids[]) {
    int count = 0;
    char *token = strtok(s, " ");
    while (token != NULL) {
        pids[count++] = atoi(token);
        token = strtok(NULL, " ");
    }
}


/* __________________________________________________________________________________________________ */
/* MAIN */
/* __________________________________________________________________________________________________ */



int main(int argc, char *argv[])
{	

	Process *processo  = malloc(sizeof(struct process));

    Process_Executing *processo_executing = malloc(sizeof(struct process_executing));

	mkfifo("tracer_to_monitor", 0666);
	mkfifo("monitor_to_tracer", 0666);
    mkfifo("argumentos", 0666);
    mkfifo("argc_fifo", 0666);
    //mkfifo("requests", 0666);

	//termina o servidor com ctrl+c
	signal(SIGINT,signal_handler_C);


	while(1)
	{
		write(1, "Novo Pedido:\n", 14);

		
        
        int tracer_to_monitor = open("tracer_to_monitor", O_RDONLY);
		
        if (tracer_to_monitor == -1){
			perror("Erro: Servidor nao foi Inicializado");
            return -1;
		}

        
		char *buf = malloc(sizeof(char)*MAX);
		read(tracer_to_monitor, buf, MAX);
		
		
        if(strcmp(buf,"status")==0)
	    {	
	    	write(1,"running status\n",16);
            int monitor_to_tracer = open("monitor_to_tracer", O_WRONLY);
            runStatus(processo_executing, monitor_to_tracer);
            close(monitor_to_tracer);
            write(1,"status completed\n\n",24);
	    }
        else if(strstr(buf,"stats-time")){
            write(1,"running stats-time\n",21);
	    	int argumentos = open("argumentos", O_RDONLY);
            //printf("chegou aqui 1\n");
            //printf("chegou aqui\n");
            char *args = malloc(sizeof(char)*MAX);
            read(argumentos,args,MAX);
            //printf("\nARGS -> %s\n", args);
            int argc_fifo = open("argc_fifo", O_RDONLY);
            char *num = malloc(sizeof(char));
            read(argc_fifo, num, sizeof(char));
            int n = atoi(num);
            //printf("\nNUM -> %d\n", n);
            int pids[n];
            parteString(args, pids);
            int monitor_to_tracer = open("monitor_to_tracer", O_WRONLY);
	    	runStatusTime(processo, monitor_to_tracer, pids, n);
	    	write(1,"stats-time completed\n\n",24);
            close(monitor_to_tracer);
            close(argumentos);
            close(argc_fifo);
        }
        else{
	    	char *pid = malloc(sizeof(char)*MAX);
	    	char *program = malloc(sizeof(char)*MAX);
	    	char *time_ms = malloc(sizeof(char)*MAX);
            char *start = malloc(sizeof(char)*MAX);

	    	pid = getPID(buf);
	    	program = getPROGRAM(buf);
	    	time_ms = getTIME_MS(buf);
            start = getSTART(buf);

            if(start==NULL){
                addProcessoExecuted(processo, program, pid, time_ms);
                removeProcessoExecuting(processo_executing, pid);
                write(1, buf, MAX);
            }

            else{
                addProcessoExecuting(processo_executing, pid, program, start);
            }
	    	free(pid);
            free(program);
            free(time_ms);
            free(start);
	    }
    
		free(buf);
        close(tracer_to_monitor);
	}
	
	return 0;
}


