#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#define MAXLINE 1024

char buffer [MAXLINE];

//Pergunta 1
int le_maior (){
    int res=0, x;
    scanf("%d", &x);
    while(x!=0){
        if(x>res)res=x;
        scanf("%d", &x);
    }
    return res;
}

//Pergunta 2
int media (){
    int num=0, res=0, x;
    scanf("%d", &x);
    while(x!=0){
        res+=x;
        num++;
        scanf("%d", &x);
    }
    res/=num;
    return res;
}

//Pergunta 3
int secseq (){
    int x, maior=0, maior2=0;
    scanf ("%d", &x);
    maior = x;
    while (x!=0){
        if (x>maior){
            maior2=maior;
            maior=x;
        }
        else if (x>maior2 && x<maior)maior2=x;
        scanf ("%d", &x);
    }
    return maior2;
}

//Pergunta 4
int bitsUm (unsigned int n){
    int res=0;
    while(n>0){
        if(n%2==1)res++;
        n/=2;
    }
    return res;
}

//Pergunta 5
int trailingZ (unsigned int n){
    int res=0;
    if(n==0)return 32; //representaçao de 32 bits
    while(n>0){
        if(n%2==0)res++;
        n/=2;
    }
    return res;
}

//Pergunta 6
int qDig (unsigned int n){
    int res=0;
    while(n>0){n/=10;res++;}
    return res;
}

//Pergunta 7
char *mystrcat (char s1[], char s2[]){
    int i=0, j=0;
    for(i; s1[i]!='\0'; i++);
    for(j; s2[j]!='\0'; j++,i++){
        s1[i]=s2[j];
    }
    s1[i]='\0';
    return s1;
}

//Pergunta 8
char *mystrcpy (char *dest, char source[]){
    int i=0, j=0;
    for(i, j; source[i]!='\0'; i++, j++){
        dest[j]=source[i];
    }
    dest[j]='\0';
    return dest;
}

//Pergunta 9
int mystrcmp(char s1[], char s2[]) {
    int i;
    for(i=0; s1[i]!='\0' || s2[i]!='\0'; i++){
        if(s1[i]==s2[i]);
        else if(s1[i]>s2[i])return 1;
        else if(s1[i]<s2[i])return -1;
    }
    return 0;
}

//Pergunta 10
char *mystrstr (char s1[], char s2[]) {
    int i=0, j=0;
    while (s1[i]!='\0' && s2[j]!='\0'){
        if(s1[i]==s2[j]){
            i++; j++;
        }
        else {
            i++;
            j=0;
        }
    }
    i-=j;
    if(s2[j]=='\0') return s1+i;
    else return NULL;
}

//Pergunta 11
void strrev (char s[]) {
    int i=0, j=0, c, k;
    while(s[i]!='\0')i++;
    char aux[i];
    for(j, c=i-1; j!=i; j++, c--)aux[j]=s[c];
    for(k=0; k<i; k++)s[k]=aux[k];
    s[k]='\0';
}

//Pergunta 12
int verVogal(char s[], int i){
    if(s[i]=='a' || s[i]=='e' || s[i]=='i' || s[i]=='o' || s[i]=='u' || s[i]=='A' || s[i]=='E' || s[i]=='I' || s[i]=='O' || s[i]=='U') return 1;
    else return 0;
}

void elimina (char *t){
    for(; *t; t++) 
        *t = *(t+1);
}

void strnoV (char s[]){
    int i=0;
    while(*s){
        if(verVogal(s, i))elimina(s);
        else s++;
    }
}

//Pergunta 13
void truncW (char s[], int n){
    int i=0, j=0, conta=0, k=0;
    for(k; s[k]!='\0'; k++);
    char aux[k];
    while(s[i]!='\0'){
        if(s[i]!=' ' && conta<n){
            aux[j]=s[i];
            j++;
            conta++;
        }

        else if(s[i]==' '){
            conta=0;
            aux[j]=' ';
            j++;
        }

        i++;
    }
    aux[j]='\0';
    for(k=0; aux[k]!='\0'; k++)s[k]=aux[k];
    s[k]='\0';
}

//Pergunta 14
char charMaisfreq (char s[]){
    int i, j, conta=0, accum=0;
    char res='O';

    for(i=0; s[i]!='\0'; i++){
        for(j=0; s[j]; j++){
            if(s[j]==s[i])conta++;
        }
        if(conta>accum){
            accum=conta;
            res=s[i];
        }
        conta=0;
    }
    return res;
}

//Pergunta 15
int iguaisConsecutivos (char s[]){
    int i=0, conta=1, accum=0;
    for(i; s[i]!='\0'; i++){
        if(s[i]==s[i+1])conta++;
        else if(conta>accum){
            accum=conta;
            conta=1;;
        }
    }
    return accum;
}

//Pergunta 16 
int naoaparece (char s[], int i, int j){
    for(; i<j; i++)if(s[i]==s[j])return 0;
    return 1;
}

int difConsecutivos(char s[]) {
    int i=0, j=1, conta, accum=0;
    for (i; s[i]; i++){
    conta=1;
    for (j=i+1; s[i]!=s[j] && naoaparece(s, i, j) && s[j]; j++)conta++;
    if(conta>accum)accum=conta;
    }
    return accum;
}

//Pergunta 17
int maiorPrefixo (char s1 [], char s2 []){
    int i=0, conta=0;
    for(i; s1[i] && s2[i] && s1[i]==s2[i]; i++)conta++;
    return conta;
}

//Pergunta 18
int maiorSufixo (char s1 [], char s2 []){
    int N1, N2, i, j, conta=0;
    N1=strlen(s1); N2=strlen(s2);
    for(i=N1-1, j=N2-1; s1[i] && s2[j] && s1[i]==s2[j]; i--, j--)conta++;
    return conta;
}

//Pergunta 19
int sufPref (char s1[], char s2[]) {
    int i=0, j=0, res=0;
    
    while(s1[i] && s2[j]){
        if(s1[i]==s2[j]){
            i++;
            j++;
            res++;
        }
        
        else{
            i++;
            j=0;
            res=0;
        }
    }
    if (s1[i]!='\0')return 0;
    else return res;
}


//Pergunta 20
int contaPal (char s[]) {
    int accum=0;
    int i;
    int space=1;
    
    for(i=0; s[i]!='\0'; i++){
        if(s[i]==' ' || s[i]=='\n')space=1;
        else if(space){
            accum++;
            space=0;
        }
    }
    
    return accum;
}

//Pergunta 21
int contaVogais (char s[]) {
    int accum=0, i=0;
    for(i; s[i]!='\0'; i++){
        if(s[i]=='a' || s[i]=='e' || s[i]=='i' || s[i]=='o' || s[i]=='u' || s[i]=='A' || s[i]=='E' || s[i]=='I' || s[i]=='O' || s[i]=='U')accum++;
    }
    return accum;
}

//Pergunta 22
int contida (char a[], char b[]){
    int i, j, flag=0;
    for(i=0; a[i]!='\0'; i++){
        for(j=0; b[j]!='\0'; j++){
            if(a[i]==b[j]){
                flag=1;
                break;
            };
        }
        if(flag==0)return flag
    }
    return flag;
}

//Pergunta 23
int palindroma (char s[]){
    int length;
    for(length=0; s[length]!='\0'; length++);
    char aux[length];
    
    int i, j, res=1;

    for(i=0; s[i]!='\0'; i++)aux[i]=s[i];
    aux[i]='\0';

    strrev(aux);

    for(j=0; s[j]!='\0'; j++)
            if(aux[j]!=s[j])res=0;

    return res;
}

//Pergunta 24
void elimina(char *x, int i){
    for(i; x; i++) *x+i= *x+i+1;
}

int remRep (char x[]){
    int i=0;
    for(i; x[i]!='\0'; i++){
        if(x[i]==x[i+1])elimina(x, i+1);
    }
}

















/*
MAIN -> nao me esta a ler as strings a partir do case 7: verificar casos
*/

char *getLine (char string[MAXLINE]){
    int i=0;
    int r = 1; //TRUE
    while(r){
        string[i]=getchar();
        if(string[i] == '\n')break;
        i++;
    }
    for(int j=0; j<MAXLINE; j++){
        if(string[j]=='\n'){
            for(int n=j+1; n<MAXLINE; n++)string[j]=string[n];
        }
    }
    return string;
}

void main(){

    char *string1 = NULL;
    char *string2 = NULL;
    char s1[MAXLINE]; for (int i=0; i<MAXLINE; i++)s1[i]='\0';
    char s2[MAXLINE]; for (int j=0; j<MAXLINE; j++)s2[j]='\0';
    printf("\nInício dos Testes!\n_____________________\n\n>>>Memória Automática\n_____________________\n\n");

    printf("\nInsere o numero da questão que pretendes observar: \n");
    int selecionado;
    scanf("%d", &selecionado);

    switch(selecionado){

        case 1:
            printf("\nPergunta 1 selecionada: Imprime no ecran o maior elemento duma sequência.\n\nInsere a tua sequencia de numeros:\n!NOTA! A sequência deve terminar com o inteiro 0\n");
            printf("\n"); int maior_seq = le_maior();
            printf("O maior desta sequencia é o %d", maior_seq);
            break;

        case 2:
            printf("\nPergunta 2 selecionada: Imprime no ecran a média da sequência\n\nInsere a tua sequencia de numeros:\n!NOTA! A sequência deve terminar com o inteiro 0\n");                                  
            printf("\n"); int media_seq = media();
            printf("A média desta sequência é: %d\n", media_seq);
            break;

        case 3:
            printf("\nPergunta 3 selecionada: Imprime no ecran o segundo maior elemento\n\nInsere a tua sequencia de numeros:\n!NOTA! A sequência deve terminar com o inteiro 0\n");
            printf("\n"); int seg_maior = secseq();
            printf("O segundo maior desta sequência é: %d\n", seg_maior);

        case 4:
            printf("Pergunta 4 selecionada: Calcula o número de bits iguais a 1 usados na representação binária de um inteiro n\n\nInsere o teu numero: \n");
            int bitsigualaum;
            scanf("%d", &bitsigualaum);
            int resposta4 = bitsUm(bitsigualaum);
            printf("O número de bits iguais a 1 usados na representação binária de %d é %d\n", bitsigualaum, resposta4);
            break;

        case 5:
            printf("Pergunta 5 selecionada: Calcula o número de bits iguais a 0 usados na representação binária de um inteiro n\n\nInsere o teu numero: \n");
            int bitsigualazero;
            scanf("%d", &bitsigualazero);
            int resposta5 = trailingZ(bitsigualazero);
            printf("O número de bits iguais a 0 usados na representação binária de %d é %d\n", bitsigualazero, resposta5);
            break;

        case 6:
            printf("Pergunta 6 selecionada: Calcula o número de digitos necessários para a representação de um inteiro n na sua base decimal\n\nInsere o teu numero: \n");
            int digitos;
            scanf("%d", &digitos);
            int num_digitos = qDig(digitos);
            printf("O número total de dígitos é de: %d\n", num_digitos);
            break;

        case 7:
            printf("Pergunta 7 selecionada: Concatena duas strings\n\nInsere duas palavras/strings: ");
            printf("\nString/Palavra 1: ");
            string1 = getLine(s1);
            printf("\nString/Palavra 2: ");
            string2 = getLine(s2);
            mystrcat(string1, string2);
            printf("\nA string final fica com o formato: \n%s", s1);
            string1 = NULL;
            string2 = NULL;
            free(string1);
            free(string2);
            break;

        case 8:
            printf("Pergunta 8 selecionada: Copia uma string para outra\n\nInsere a tua string: \n");
            char *dest=NULL;
            char source[MAXLINE]; for (int i=0; i<MAXLINE; i++)source[i]='\0';
            char *aux = NULL;
            aux = getLine(source);
            printf("\n%s\n", source);
            mystrcpy(aux, source);
            printf("Assim *dest = %s", aux);
            dest = NULL;
            aux = NULL;
            free(dest);
            free(aux);
            break;

        case 9:
            printf("Pergunta 9 selecionada: Compara lexicograficamente duas strings\n\nInsere duas strings: ");
            printf("\nString 1: ");
            string1 = getLine(s1);
            printf("\nString 2: ");
            getLine(s2);
            int x = mystrcmp(string1, string2);
            if(x==0)printf("\nString1 == String2");
            else if (x==-1)printf("\nString1 < String2");
            else printf("\nString1 > String2");
            string1 = NULL;
            string2 = NULL;
            free(string1);
            free(string2);
            break;

        case 10:
            printf("Pergunta 10 selecionada: Determina a posição onde a string2 ocorre na string1\n\nInsere duas strings: ");
            printf("\nString 1: ");
            string1 = getLine(s1);
            printf("\nString 2: ");
            getLine(s2);
            mystrstr(string1, string2);
            printf("\nString2 em String1: %s", string1);
            string1 = NULL;
            string2 = NULL;
            free(string1);
            free(string2);
            break;

        case 11:
            printf("Pergunta 11 selecionada: Inverte uma string\n\nInsere uma string: \n");
            string1 = getLine(s1);
            strrev(string1);
            printf("\nA string revertida: %s", string1);
            string1 = NULL;
            free(string1);
            break;

        //case 12:
            
    }
    printf("\n_____________________\nFim dos Testes!\n");
}


