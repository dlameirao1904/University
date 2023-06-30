#include <stdio.h>

//Pergunta 1
//a)
void pergunta_1_a () {
    int x [15] = {1, 2, 3, 4, 5,
                  6, 7, 8, 9,10,
                  11,12,13,14,15};
    int *y, *z, i;
    y = x;
    z = x+3;
    for (i=0; i<5; i++) {
        printf ("%d %d %d\n", x[i], *y, *z);
        y = y+1; z = z+2;
    }
}

//b)
void pergunta_1_b () {
    int i, j, *a, *b;
    i=3; j=5;
    //a = b = 42;
    a = &i; b = &j;
    i++;
    j = i + *b;
    b = a;
    j = j + *b;
    printf ("%d\n", j);
}

//Pergunta 2
void swapM (int *x, int *y){
    int temp;
    temp=*x;
    *x=*y;
    *y=temp;
}

//Pergunta 3
void swap (int v[], int i, int j){
    int temp=v[i];
    v[i]=v[j];
    v[j]=temp;
}

//Pergunta 4
int soma (int v[], int N){
    int res=0, i;
    for(i=0; i<N; i++){
        res+=v[i];
    }
    return res;
}

//Pergunta 5
//a)
void inverteArray1 (int v[], int N){
    int i=0, j=N-1;
    for(i, j; i<N/2; i++, j--)swap(v,i,j);
}

//b)
void inverteArray2 (int v[], int N){
    int i=0, j=N-1;
    for(i, j; i<N/2; i++, j--)swapM(&v[i], &v[j]);
}

//MAIN
void main (){
    printf("__________________\nInicio dos Testes!\n__________________\n");
    printf("\nInsere o numero da pergunta: ");
    int pergunta;
    scanf("%d", &pergunta);

    switch(pergunta){
        case 1:
        printf("\nPergunta 1 selecionada\nImprime o output dos excertos dados na ficha\n");
            printf("\nInsere o numero da alinea\n1==a)\n2==b)\n→ ");
            int alinea;
            scanf("%d", &alinea);
            switch(alinea){
                case 1:
                    printf("\nO output da alinea a) é:\n");
                    pergunta_1_a();
                    break;

                case 2:
                    printf("\nO output da alinea b) é:\n");
                    pergunta_1_b();
                    break;
                
                default:
                    printf("\nO numero da alinea inserida é invalido!");
                    break;
            }
        
        case 2:
            printf("\nPergunta 2 selecionada\nTroca o valor de duas variaveis\n");
            int x, y;
            printf("\nIntroduz dois valores para as respetivas variaveis x e y\n→");
            scanf("%d %d",&x, &y);
            printf("\nx = %d, y = %d\n", x,y);
            swapM(&x, &y); printf("\nAfter swapM\n");
            printf("\nx = %d, y = %d\n", x,y);
            break;

        case 3:
            printf("\nPergunta 3 selecionada\nTroca o valor de duas posiçoes num array.\n");
            int vetor[10];
            printf("\nIntroduza 10 valores para formar um array:\n→");
            int x_3;
            for(int i=0; i<10; i++){
                scanf("%d", &x_3);
                vetor[i]=x_3;
            }
            printf("\nIndique agora duas posiçoes (de 0 a 9) para trocarmos o valor destas no array:\n→");
            int ii, jj;
            scanf("%d %d", &ii, &jj);
            printf("\nFicamos assim:\n→");
            swap(vetor, ii, jj);
            for (int k=0; k<10; k++){
                printf("%d(i=%d)  ", vetor[k], k);
            }
            printf("\n"); 
            break;

        case 4:
            printf("\nPergunta 4 selecionada\nSomatorio dos elementos de um array\n");
            int vetor_4[10];
            int x_4;
            printf("Introduza 10 valores para formar um array:\n→");
            for(int i=0; i<10; i++){
                scanf("%d", &x_4);
                vetor_4[i]=x_4;
            }
            int somatorio = soma(vetor_4, 10);
            printf("O somatorio do vetor é: %d", somatorio);
            break;

        case 5:
            printf("\nPergunta 5 selecionada\nInverte array:");
            int alinea_5;
            printf("Insira o nº da alinea\n1==a)\n2==b)\n→ ");
            scanf("%d", &alinea_5);
            switch(alinea_5){
                case 1:
                    printf("\nInsira 10 valores para criar um array: \n");
                    int vetor_5_a[10]; int x_5_a;
                    for(int i=0; i<10; i++){
                        scanf("%d", &x_5_a);
                        vetor_5_a[i]=x_5_a;
                    }
                    inverteArray1(vetor_5_a, 10);
                    printf("\nO array invertido fica: \n");
                    for(int i=0; i<10; i++){
                        printf("%d ", vetor_5_a[i]);
                    }
                    break;
                
                case 2:
                    printf("\nInsira 10 valores para criar um array: \n");
                    int vetor_5_b[10]; int x_5_b;
                    for(int i=0; i<10; i++){
                        scanf("%d", &x_5_b);
                        vetor_5_b[i]=x_5_b;
                    }
                    inverteArray1(vetor_5_b, 10);
                    printf("\nO array invertido fica: \n");
                    for(int i=0; i<10; i++){
                        printf("%d ", vetor_5_b[i]);
                    }
                    break;

                default:
                    printf("\nA alinea inserida nao é valida\n");
                    break;
            }
            break;

        
        default:
            printf("\nO numero da pergunta inserido é invalido!\n");
            break;
    }
    printf("\n_______________\nFim dos Testes!\n_______________\n");
}