#ifndef MONITOR_H
#define MONITOR_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <limits.h>
#include <stdbool.h>
#include <signal.h>
#include <sys/time.h>
#include <time.h>


#define MAX 1024

pid_t getpid(void);
pid_t getppid(void);
pid_t fork(void);
void _exit(int status);
pid_t wait(int *status);
pid_t waitPID(pid_t pid, int *status, int options); 

typedef struct process
{
    char *pid;
    char *program;
    char *time_ms;
    struct process *next;
} *Process;

typedef struct process_executing
{
    char *pid;
    char *program;
    char *start;
    struct process_executing *next;
} *Process_Executing;

void signal_handler_C(int signum);

char* getPID(char *s);
char* getPROGRAM(char *s);
char* getTIME_MS(char *s);
char* getSTART(char *s); 

void addProcessoExecuted(Process *processo, char *program, char *pid, char *time_ms);
void addProcessoExecuting(Process_Executing *processo, char *pid, char *program, char *start);
void removeProcessoExecuting(Process_Executing *processo, char *pid);
void runStatus (Process_Executing *processo, int fd);
int runStatusTime(Process *processo, int fd, int pid[], int max);

#endif