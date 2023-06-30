#include <stdio.h>

//EStado e Atribuições
//Pergunta 1)
void f1 (int n){
    int x, y;
    x = n;
    y = x+1;
    x = x*y; y = x + y;
    printf("%d %d\n", x, y);
}

//Pergunta 2)
void f2(int n){
    int x, y;
    x = n;
    printf ("%d %d\n", x, y);
    printf("Como «y» nao teve nenhum valor declarado, é lhe atribuido um valor qualquer\n");
}

//Pergunta 3)
void f3 (int n){
    char a, b, c;
    a = 'A'; b = ' '; c = '0';
    printf ("%c %d\n", a, a);
    a = a+1; c = c+2;
    printf ("%c %d %c %d\n", a, a, c, c);
    c = a + b;
    printf ("%c %d\n", c, c);
}

//Pergunta 4)
void f4 (int a, int b){
    int x, y;
    x = a; y = b;
    x = x+y; y = x-y; x = x-y;
    printf ("%d %d\n", x, y);
}

//EStruturas de Controlo
//Pergunta 1)
void fum (int a, int b){
    int x, y;
    x = a; y = b;
    if (x > y)
        y = 6;
    printf ("%d %d\n", x, y);
}

//Pergunta 2)
void fdois (int n) {
    int x, y;
    x = y = n;
    while (x != 11) {
        x = x+1; y += x;
    }
    printf ("%d %d\n", x, y);
}

//Pergunta 3)
void ftres (int n){
    int i;
    for (i=0; i<n ; i++){
        if (i%2 == 0) putchar ('_');
        else putchar ('#');
    }
    printf ("\n");
}

//Pergunta 4)
void fquatro (int n) {
    while (n>0) {
        if (n%2 == 0) putchar ('0');
        else putchar ('1');
        n = n/2;
    }
    putchar ('\n');
}

//Programas Iterativos
//Pergunta 1)
void quadrado (int n){
    int i, j;
    for(i=0; i<n; i++){
        for(j=0; j<n; j++)putchar('#');
        putchar('\n');
    }
}

//Pergunta 2)
void xadrez (int n){
    int i, j;
    for(i=0; i<n; i++){
        if(i%2==0){
            for(j=0; j<n; j++){
                if (j%2==0)putchar('#');
                else putchar('_');
            }
        }

        else{
            for(j=0; j<n; j++){
                if(j%2==0)putchar('_');
                else putchar('#');
            }
        }
        
        putchar('\n');
    }
}

//Pergunta 3)
//a)
void triangulo1 (int n){
    int i=0, j=0;
    for(i; i<n; i++){
        for(j=0; j<=i; j++)putchar('#');
        putchar('\n');
    }

    for(i=0; i<n; i++){
        for(j=n-1; j>i; j--)putchar('#');
        putchar('\n');
    }
}

//b)
void triangulo2 (int n){
    int i=0, j, k;
    for (i; i<n; i++){
        for(j=i; j<n; j++)putchar(' ');
        for(k=0; k<2*i+1; k++)putchar('#');
        putchar('\n');
    }
}

//Pergunta 4)
int circulo (int raio){
    int i=0, j,conta=0;
    int diametro = 2*raio+1;
    int esp = raio-3;
    int hash = 7;

    while(i<diametro){
        if(i==0){
            for(j=0; j<raio; j++){
                putchar(' ');
            }
            putchar('#');
        }

        else if (i==1){
            for(j=0; j<raio-2; j++){
                putchar(' ');
            }
            for(j=0; j<5; j++)putchar('#');
        }

        else if(i<=raio-1){
            for(j=0; j<esp; j++)putchar(' ');
            for(j=0; j<hash; j++)putchar('#');
            if(i!=raio-2){
                esp--;
                hash+=2;
            }
        }

        else if(i==raio){
            for(j=0; j<diametro; j++)putchar('#');
            esp=1;
            hash-=2;
        }

        else if(i<diametro-2){
            for(j=0; j<esp; j++)putchar(' ');
            for(j=0; j<hash; j++)putchar('#');
            if(i!=raio+1){
                esp++;
                hash-=2;
            }
        }

        else if(i==diametro-2){
            for(j=0; j<raio-2; j++){
                putchar(' ');
            }
            for(j=0; j<5; j++)putchar('#');            
        }

        else{
            for(j=0; j<raio; j++){
                putchar(' ');
            }
            putchar('#');            
        }

        putchar('\n');
        i++;
    }
}

void main (){
    printf("\nInicio dos Testes\n__________________\n\n");
    printf("\nInsere \"a matéria\" que pretendes testar nesta ficha\n1 : Estados e Atribuiçoes;\n2 : Estruturas de controlo;\n3 : Programas iterativos.\nIntroduz o valor: \n");
    int materia;
    scanf("%d", &materia);

    switch(materia){
        case 1:
            printf("\nEstado e Atribuições\n___________________\n\n");
            printf("Introduz o numero da pergunta: ");
            int perguntaEA;
            scanf("%d", &perguntaEA);
            switch(perguntaEA){
                case 1:
                printf("\nPergunta 1:\n");
                f1(3);
                break;

                case 2:
                printf("\nPergunta 2:\n");
                f2(0);
                break;

                case 3:
                printf("\nPergunta 3:\n");
                f3(0);
                break;

                case 4:
                printf("\nPergunta 4:\n");
                f4(200, 100);
                break;

                default:
                printf("\nERROR!\nO numero introduzido nao corresponde a nenhuma pergunta!\n");
                break;
            }
            break;

        case 2:
            printf("\nEstruturas de Controlo\n___________________\n\n");
            printf("Introduz o numero da pergunta: ");
            int perguntaEC;
            scanf("%d", &perguntaEC);
            switch (perguntaEC){
                case 1:
                    printf("\nPergunta 1:\n");
                    fum(3, 5);
                    break;

                case 2:
                    printf("\nPergunta 2:\n");
                    fdois(0);
                    break;

                case 3:
                    printf("\nPergunta 3:\n");
                    ftres(20);
                    break;

                case 4:
                    printf("\nPergunta 4:\n");
                    int i;
                    for (i=0; i<16; i++)
                    fquatro(i);
                    break;
                
                default:
                    printf("\nERROR!\nO numero introduzido nao corresponde a nenhuma pergunta!\n");
                    break;
            }
            break;

        case 3:
            printf("\nProgramas Iterativos\n___________________\n\n");
            printf("Introduz o numero da Pergunta: ");
            int perguntaPI;
            scanf("%d", &perguntaPI);
            switch(perguntaPI){
                case 1:
                    printf("\nPergunta 1: Desenha um quadrado com N «#» na sua aresta\nN: ");
                    int tresum;
                    scanf("%d", &tresum);
                    quadrado(tresum);
                    break;

                case 2:
                    printf("\nPergunta 2: Desenha um quadro de xadrez (com «#» e «_») com N linhas e N elementos nessa linha\nN: ");
                    int tresdois;
                    scanf("%d", &tresdois);
                    xadrez(tresdois);
                    break;

                case 3:
                    printf("\nPergunta 3:\n");
                    printf("Introduz a alinea: \n1==a)\n2==b)\n→ ");
                    int alinea;
                    scanf("%d", &alinea);
                    switch(alinea){
                        case 1:
                        printf("\nAlinea b) Desenhas um triangulo lateralmente em que a sua altura é N\nN: ");
                        int trestresa;
                        scanf("%d", &trestresa);
                        triangulo1(trestresa);
                        break;

                        case 2:
                        printf("\nAlinea a) Desenha um triangulo com N linhas\nN: ");
                        int trestresb;
                        scanf("%d", &trestresb);
                        triangulo2(trestresb);
                        break;

                        default:
                        printf("\nERROR!\nO numero introduzido nao corresponde a nenhuma pergunta!\n");
                        break;
                    }
                    break;

                case 4:
                    printf("\nPergunta 4: Desenha um circulo em que o seu raio é N\nN: ");
                    int tresquatro;
                    scanf("%d", &tresquatro);
                    circulo(tresquatro);
                    break;

                default:
                    printf("\nERROR!\nO numero introduzido nao corresponde a nenhuma pergunta!\n");
                    break;
                }
            break;

            default:
                printf("\nERROR!\nO numero introduzido nao corresponde a nenhuma materia da ficha!\n");
                break;
    }

    printf("\n____________________\nFim dos Testes\n");
}