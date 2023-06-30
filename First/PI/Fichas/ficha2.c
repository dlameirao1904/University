#include <stdio.h>
#include <stdlib.h>

//Pergunta 1
float multInt1 (int n, float m){
    int i=n; 
    float res=0;
    for(i; i>0; i--)res+=m;
    return res;
}

//Pergunta 2
float multInt2 (int n, float m){
    float res=0;
    while (n>0){
        if(n%2==1)res+=m;
        n/=2;
        m*=2;
    }
    return res;
}

//Pergunta 3
int mdc1 (int a, int b){
    int r, i;
    if(a<b && b%a==0)return a;
    else if(a<b){
        for(i=1; i<=b; i++)
            if(a%i==0 && b%i==0)r=i;
    }
    else{
        for(i=1; i<a; i++)
            if(b%i==0 && a%i==0)r=i;
    }
    return r;
}

//Pergunta 4
int mdc2 (int a, int b){
    while (a!=0 && b!=0){
        if(a>b)a-=b;
        else if(b>a)b-=a;
        else return a;
    }
    if (a==0 && b!=0)return b;
    else return a;
}

//Pergunta 5
int mdc3 (int a, int b){
    while(a!=0 && b!=0){
        if(a>b)a%=b;
        else if(b>a)b%=a;
        else return a;
    }
    if (a==0 && b!=0)return b;
    else return a;
}

//Pergunta 6
//a)
int fibrec(int n){
    if(n<=2)return 1;
    else return fibrec(n-1)+fibrec(n-2);
}

//b)
int fib(int n){
    int f[n+2];
    f[0]=0;
    f[1]=1;
    for(int i=2; i<=n; i++){
        f[i]=f[i-1]+f[i-2];
    }
    return f[n];
}

void main(){
    printf("__________________\nInicio dos Testes!\n__________________\n\n");
    printf("Insere o nº da pergunta: ");
    int pergunta;
    scanf("%d", &pergunta);
    switch(pergunta){
        case 1:
            printf("\nPergunta 1 selecionada\nCalcula o produto de dois numeros atraves dum somatorio.\n");
            printf("Introduz dois numeros:\n→");
            int um_1, dois_1;
            scanf("%d %d", &um_1, &dois_1);
            float respostaUm = multInt1(um_1, dois_1);
            printf("\nO produto dos numeros escolhidos é: %f\n", respostaUm);
            break;
        
        case 2:
            printf("\nPergunta 2 selecionada\nCalcula o produto de dois numeros atraves de divisoes e multiplicaçoes sucessivas.\n");
            printf("Introduz dois numeros:\n→");
            int um_2, dois_2;
            scanf("%d %d", &um_2, &dois_2);
            float respostaDois = multInt2(um_2, dois_2);
            printf("\nO produto dos numeros escolhidos é: %f\n", respostaDois);
            break;
        
        case 3:
            printf("\nPergunta 3 selecionada\nCalcula o mdc de dois numeros por procura de divisores comuns do menor numero introduzido\n");
            printf("Introduz dois numeros:\n→");
            int um_3, dois_3;
            scanf("%d %d", &um_3, &dois_3);
            int respostaTres = mdc1(um_3, dois_3);
            printf("O mdc dos numeros selecionados é: %d", respostaTres);
            break;

        case 4:
            printf("\nPergunta 4 selecionada\nCalcula o mdc de dois numeros por subtraçoes sucessivas.\n");
            printf("Introduz dois numeros:\n→");
            int um_4, dois_4;
            scanf("%d %d", &um_4, &dois_4);
            int respostaQuatro = mdc2(um_4, dois_4);
            printf("O mdc dos numeros selecionados é: %d", respostaQuatro);
            break;

        case 5:
            printf("\nPergunta 5 selecionada\nCalcula o mdc de dois numeros por modulos sucessivos.\n");
            printf("Introduz dois numeros:\n→");
            int um_5, dois_5;
            scanf("%d %d", &um_5, &dois_5);
            int respostaCinco = mdc3(um_5, dois_5);
            printf("O mdc dos numeros selecionados é: %d", respostaCinco);
            break;

        case 6:
            printf("\nPergunta 6 selecionada\nSequencia de Fibbonaci.\n");
            printf("Introduz a alinea:\n1==a)\n2==b)\n→");
            int alinea;
            scanf("%d", &alinea);
            switch(alinea){
                case 1:
                    printf("Definiçao recursiva selecionada.\nIntroduz um inteiro:\n→");
                    int um_6;
                    scanf("%d", &um_6);
                    int respostaSeisA = fibrec(um_6);
                    printf("O numero, correspondente ao n-esimo elemento selecionado, desta sequencia é: %d", respostaSeisA);
                    break;

                case 2:
                    printf("Definiçao iterativa selecionada.\nIntroduz um inteiro:\n→");
                    int dois_6;
                    scanf("%d", &dois_6);
                    int respostaSeisB = fib(dois_6);
                    printf("O numero, correspondente ao n-esimo elemento selecionado, desta sequencia é: %d", respostaSeisB);
                    break;

                default:
                    printf("Nao existe tal alinea");
                    break;

            }
            break;

            default:
                printf("\nERROR!\nO numero introduzido nao corresponde a nenhuma pergunta da ficha!\n");
                break;
    }
    printf("\n__________________\nFIm dos Testes!\n__________________\n");
}