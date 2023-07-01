#include "tracer.h"

void runCommand(char *command[])
{
    char *buffer = malloc(sizeof(char)*MAX);

    struct timeval start_time, end_time;
    gettimeofday(&start_time, NULL);

    pid_t f = fork();

    int tracer_to_monitor = open("tracer_to_monitor", O_WRONLY);

    if (tracer_to_monitor == -1){
        perror("Erro: Servidor nao foi Inicializado");
        _exit(-1);
    }

    if (f == 0)
    {	
		printf("\nRunning PID: %d\n\n", getpid());

		int nnbytes = sprintf(buffer, "Pid: %d\nProgram: %s\nStart: %lu\n", getpid(), command[0], start_time.tv_sec);
		write(tracer_to_monitor, buffer, nnbytes);
		free(buffer);

        sleep(1);

        execvp(command[0],command);

        
        printf("Exec correu mal\n");

        _exit(1);
    }

    int status;
    
    wait(&status);

    if (WIFEXITED(status))
    {

		gettimeofday(&end_time, NULL);

    	int time_elapsed_ms = (int)((end_time.tv_sec - start_time.tv_sec) * 1000 + (end_time.tv_usec - start_time.tv_usec) / 1000);
		printf("\nEnded in: %d ms\n", time_elapsed_ms);
    	putchar('\n');

    	int time_elapsed = (int)(end_time.tv_sec - start_time.tv_sec);
		printf("Tempo decorrido: %d segundos\n", time_elapsed);

		int fd = open("tmp/ficheiro.txt", O_WRONLY | O_CREAT | O_APPEND, 0600);
        int nbytes = sprintf(buffer, "Pid: %d\nProgram: %s\nTime: %d\n\n", getpid(), command[0], time_elapsed_ms);
		write(fd, buffer, MAX);
        write(tracer_to_monitor, buffer, nbytes);
		close(fd);
		
    }
    else
    {
        perror("Program Interrupted.\n");
    }

    free(buffer);
    close(tracer_to_monitor);
	
}


/* __________________________________________________________________________________________________ */
/* MAIN */
/* __________________________________________________________________________________________________ */


int main(int argc, char *argv[])
{

	char *buffer = malloc(sizeof(char)*MAX);
	//char *program_to_monitor = malloc(sizeof(char)*MAX);
	//pid_t pid_to_monitor;

	if (argc == 1)
	{
		int nbytes = sprintf(buffer,"Erro. Insira um comando válido\n");
		write(1, buffer, nbytes);
		return -1;
	}
	
	if(strcmp(argv[1],"execute") == 0)
	{
		if(strcmp(argv[2],"-u") == 0){
			runCommand(&argv[3]);
		}

	}

	else if(strcmp(argv[1],"status") == 0)
	{
		int tracer_to_monitor = open("tracer_to_monitor", O_WRONLY);
		write(tracer_to_monitor, argv[1], strlen(argv[1]));
		close(tracer_to_monitor);


		int monitor_to_tracer = open("monitor_to_tracer", O_RDONLY);
    	if (monitor_to_tracer == -1) {
    	    perror("Erro: Servidor nao foi Inicializado");
    	    return -1;
    	}

    	char *buffer = malloc(sizeof(char) * MAX);
    	int bytes_read;
    	while ((bytes_read = read(monitor_to_tracer, buffer, MAX)) > 0) {
    	    write(1, buffer, bytes_read);
    	}

    	close(monitor_to_tracer);
    	free(buffer);
	}

	else if(strcmp(argv[1],"stats-time") == 0)
	{
		
		int tracer_to_monitor = open("tracer_to_monitor", O_WRONLY);
		write(tracer_to_monitor, argv[1], strlen(argv[1]));
		//printf("\nARGV[1] -> %s\n", argv[1]);

		int argumentos = open("argumentos", O_WRONLY);
		int i=2;
		char *args = malloc(sizeof(char)*MAX);
		//printf("chegou aqui\n");
		while(i<argc){
			//printf("entrou\n");
			//printf("%s\n", argv[i]);
			strcat(args, argv[i]);
			strcat(args, " ");
			i++;
			//printf("%s\n", argv[i]);
		}
		//printf("\nARGS -> %s\n", args);
		write(argumentos,args,MAX);

		char *num = malloc(sizeof(char)*2);

		sprintf(num, "%d\n", argc-2);
		//printf("\nNUM -> %s", num);

		int argc_fifo = open("argc_fifo", O_WRONLY);
		//printf("entro fifo argc\n");
		write(argc_fifo, num, sizeof(char)*2);


		close(argc_fifo);
		close(tracer_to_monitor);
		close(argumentos);

		int monitor_to_tracer = open("monitor_to_tracer", O_RDONLY);
    	if (monitor_to_tracer == -1) {
    	    perror("Erro: Servidor nao foi Inicializado");
    	    return -1;
    	}

    	char *buffer = malloc(sizeof(char) * MAX);
    	int bytes_read;
    	while ((bytes_read = read(monitor_to_tracer, buffer, MAX)) > 0) {
    	    write(1, buffer, bytes_read);
    	}

    	close(monitor_to_tracer);
    	free(buffer);
	}

	else
	{
		write(1,"Comando desconhecido\n", 22);
	}

	return 0;
}

