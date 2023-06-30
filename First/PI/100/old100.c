#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//1ª Parte

//1)
int maiorseq (){
    int x, res=0;
    scanf ("%d", &x);

    while (x!=0){
        if(x>res)res=x;
        scanf ("%d", &x);
    }
    printf ("%d\n", res);
}

//2)
int mediaseq (){
    int x, res=0, i=0;
    scanf ("%d", &x);

    while (x!=0){
        res+=x;
        i++;
        scanf ("%d", &x);
    }
    res/=i;
    printf ("%d\n", res);
}

//3)
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
    printf ("%d\n", maior2);
}

//4)
int bitsUm (unsigned int x){
    int i=1;
    
    while(x!=1){
        if(x%2==1)i++;
        x/=2;
    }
    return i;
}

//5)
int trailingZ (unsigned int n){
    int i=0;
    if(n==0)i=32;
    while(n!=0){
        if(n%2==0)i++;
        n/=2;
    }
    return i;
}

//6)
int qDig (int n) {
    int r = 0;
    while (n!=0){
        r++;
        n/=10;
    }
    return r;
}

//7)
char *mystrcat(char s1[], char s2[]) {
    int i, j;
    for(i=0; s1[i]!='\0'; i++);
    for(j=0; s2[j]!='\0'; j++){
        s1[i]=s2[j];
        i++;
    }
    s1[i]='\0';
    return s1;
}

//8)
char *mystrcpy(char s1[], const char s2[]) {
    int i, j;
    for(i=0, j=0; s2[i]!='\0'; i++, j++){
        s1[j]=s2[i];
    }
    s1[j]='\0';
    return s1;
}

//9)
int mystrcmp(char s1[], char s2[]) {
    int i;
    for(i=0; s1[i]!='\0' || s2[i]!='\0'; i++){
        if(s1[i]==s2[i]);
        else if (s1[i]>s2[i])return 1;
        else if (s1[i]<s2[i])return -1;
    }
    return 0;
}

//10)
char *mystrstr (char s1[], char s2[]) {
    int i=0, j=0;
    
    while (s1[i]!='\0' && s2[j]!='\0'){
        if (s1[i]==s2[j]){
            i++;
            j++;
        }
        else{
            i++;
            j=0;
        }
    }
    i-=j;
    if(s2[j]=='\0') return s1+i;
    else return NULL;
}

//11)
void strrev (char s[]) {
    int i=0, j, c;

    while(s[i]!='\0') i++;
    char aux[i];
    
    for(j=0,c=i-1;j!=i;j++,c--){
        aux[j] = s[c];
    }
    for(j=0;j<i;j++){
        s[j] = aux[j];
    }
    s[j] = '\0';
}

//12)
void eliminachar (char *t){
    for(; *t; t++) 
        *t = *(t+1);
}

void strnoV (char s[]){
    while(*s){
        if(*s=='a' || *s=='e' || *s=='i' || *s=='o' || *s=='u' ||
        *s=='A' || *s=='E' || *s=='I' || *s=='O' || *s=='U') eliminachar(s);
        else s++;
    }
}

//13)
void truncW (char s[], int n){
    int i=0, j=0, conta=0;
    int k=0;
    for(k; s[k]!='\0'; k++);
    char aux[k];
    while (s[i]!='\0'){
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
    for(i=0; aux[i]!='\0'; i++)s[i]=aux[i];
    s[i]='\0';
}

//14)
char charMaisfreq (char s[]) {
    int i, j, conta=0, accum=0;
    char res='O', comp;

    for(i=0; s[i]!='\0';i++){
        comp=s[i];
        for(j=0; s[j];j++){
            if(s[j]==comp)conta++;
        }
        if(conta>accum){
            accum=conta;
            res=comp;
        }
        conta=0;
    }
    return res;
}

//15)
int iguaisConsecutivos (char s[]) {
    int i, res=0, freq=1;
    for(i=0; s[i]!='\0'; i++){
        if(s[i]==s[i+1])freq++;
        else if(freq>res){
            res=freq;
            freq=1;
        }
    }
    return res;
}

//16)
int diferentes (char s[], int i, int j){
    int k=0;
    for(; i<j; i++){
        if(s[i]==s[j])return 0;
    }
    return 1;
}

int difConsecutivos (char s[]){
    int i, res=0, j;
    for(i=0; s[i]; i++){
        int accum = 1;
        for(j=i+1; s[j] != s[i] && diferentes(s,i,j) && s[j]; j++) accum++;
        if(accum>res)res=accum;
    }
    return res;
}


//17)
int maiorPrefixo (char s1 [], char s2 []) {
    int i=0, pre=0;
    for(i; s1[i]!='\0'||s2[i]!='\0'; i++){
        if(s1[i]==s2[i])pre++;
        else break;
    }
    return pre;
}

//18)
int maiorSufixo (char s1 [], char s2 []) {
    int i, j, res=-1;
    
    for(i=0; s1[i]!='\0'; i++);
    for(j=0; s2[j]!='\0'; j++);
    
    for(i, j; s1[i]==s2[j]; i--, j--){
        res++;
    }
    return res;
}

//19)
int sufPref (char s1[], char s2[]) {
    int i=0, j=0, res=0;
    
    while(s1[i]!='\0' && s2[j]!='\0'){
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

//20)
int contaPal (char s[]){
    int r=0, i=0, cont=1;
    while (s[i]!='\0')
    {
        if(s[i]==' ' || s[i]=='\n') cont=1;
        else if (cont){
            r++;
            cont=0;
        }
        i++;
    }
    return r;
}

//21)
int contaVogais (char s[]) {
    int i, res=0;
    for(i=0; s[i]!='\0'; i++){
        if(s[i]=='a' || s[i]=='e' || s[i]=='i' || s[i]=='o' || s[i]=='u' ||
           s[i]=='A' || s[i]=='E' || s[i]=='I' || s[i]=='O' || s[i]=='U') res++;
    }
    return res;
}

//22)
int contida (char a[], char b[]) {
    int i,j, c, r=0;
    for(i=0; a[i] != '\0'; i++){
        for(j=0; b[j] != '\0'; j++) {
            if(b[j] == a[i]) r=1;
        }
    if (r==0) return r;
    else{c=1;r=0;}
    }
    return c;
}

//23)
int palindroma (char s[]) {
    int i, tam, c=1;
    for(tam=0; s[tam]!='\0'; tam++);
    for(i=0; s[i]!='\0'; i++)
        if(s[i]!=s[tam-i-1])return 0;
    return c;
}

//24)
int remRep (char s []) {
    int tam, i, c;
    for(i=0; s[i]!='\0'; i++){
        while(s[i]==s[i+1]){
            for(c=i; s[c]!='\0'; c++) s[c]=s[c+1];
        }
    }
    for(tam=0; s[tam]!='\0'; tam++);
    return tam;
}

//25)
int limpaEspacos (char s[]) {
    int tam, i, c;
    for(i=0; s[i]!='\0'; i++){
        if(s[i]==' '){
            while(s[i]==s[i+1]){
                for(c=i; s[c]!='\0'; c++) s[c]=s[c+1];
            }
        }
    }
    for(tam=0; s[tam]!='\0'; tam++);
    return tam;
}

//26)
void insere (int v[], int N, int x){
        int i, j;
        for(i=0; v[i]<x;i++);
        N+=1;
        for(j=N; j>i; j--){
            v[j]=v[j-1];
        }
        v[i]=x;
}

//27)
void swap(int v[], int i, int j){
    int temp;
    temp = v[i];
    v[i]=v[j];
    v[j]=temp;
}

void ordena(int v[], int N){
    int i, j;
    for(i=0; i<N; i++){
        for(j=i+1; j<N; j++){
            if(v[i]>v[j]) swap(v, i, j);
        }
    }
}

void merge (int r [], int a[], int b[], int na, int nb){
    int i, j;
    int x=na+nb;
    
    for(i=0; i<na; i++){
        r[i]=a[i];
    }
    for(j=0; j<nb; j++){
        r[i+j]=b[j];
    }
    ordena(r, x);
}

//28)
int crescente (int a[], int i, int j){
    int r=1;
    for(i; i<j; i++){
        if(a[i]>a[i+1])return 0;
    }
    return r;
}

//29)
int retiraNeg (int v[], int N){
    int i=0, j;
    while(i<N){
        if(v[i]<0){
            for(j=i; j<N-1; j++) v[j]=v[j+1];
            N--;
        }
        
        else i++;
    }
    return N;
}

//30)
int menosFreq (int v[], int N){
    int i=0, freq=1, res=v[0], accum=N;
    for(i; i<N-1; i++){
        if(v[i]==v[i+1])freq++;
        
        else{
            if(freq<accum){
                accum=freq;
                res=v[i];
            }
            freq=1;
        }
    }
    if(freq<accum){
        accum=freq;
        res=v[i];
    }
    return res;
}

//31)
int maisFreq (int v[], int N){
    int i=0, freq=1, res=v[0], accum=0;
    for(i; i<N-1; i++){
        if(v[i]==v[i+1])freq++;
        
        else{
            if(freq>accum){
                accum=freq;
                res=v[i];
            }
            freq=1;
        }
    }
    if(freq>accum){
        accum=freq;
        res=v[i];
    }
    return res;
}

//32)
int maxCresc (int v[], int N) {
    int i=0;
    int accum=1;
    int res=0;
       
   for(i; i<N-1; i++){
       if(v[i]<=v[i+1])accum++;
           
       else{
           if(accum>res) res=accum;
               accum=1;
       }
   }
   if(accum>res)res=accum;
   return res;
}

//33)
int elimRep (int v[], int n) {
    int i=1;
    int j;
    int belongs;

    while(i<n) {
        belongs=0;
        for(j=0; j<i; j++) if(v[i]==v[j]) belongs=1;
        if(belongs){
            for(j=i; j<n; j++) v[j]=v[j+1];
            n--;
        } 
        
        else i++;
    }
    return n;
}

//34)
int elimRepOrd (int v[], int n) {return elimRep(v,n);}

//35)
int comunsOrd (int a[], int na, int b[], int nb){
    int i=0, j=0, accum=0;
    
    while (i<na && j<nb){
        if(a[i]==b[j]){
            accum++;
            j++;
            i++;
        }
        else if (a[i]>b[j])j++;
        else i++;
    }
    return accum;
}

//36)
int comuns (int a[], int na, int b[], int nb){
      int i, j, accum=0;
      for(i=0; i<na; i++){
          for(j=0; j<nb; j++){
              if(a[i]==b[j]){
                  accum++;
                  break;
              }
          }
      }
      return accum;
}

//37)
int minInd (int v[], int n) {
    int i=0, in=v[0], comp=0;;
    while(i<n){
        if(v[i]<in){
            in=v[i];
            comp=i;
        }
        i++;
    }
    return comp;
}

//38)
void somasAc (int v[], int Ac [], int N){
    int i;
    Ac[0]=v[0];
    for(i=1; i<N; i++){
        Ac[i]=v[i]+Ac[i-1];
    }
}

//39)
int triSup (int N, int m [N][N]) {
    int i, j, x=1;
    
    for(i=0; i<N; i++){
        for(j=0; j<i; j++){
            if (m[i][j]!=0)return 0;
        }
    }
    return x;
}

//40)
void transposta (int N, float m [N][N]) {
    int i, j;
    float aux [N][N];
    
    for(i=0; i<N; i++){
        for(j=0; j<N; j++){
            aux[j][i] = m[i][j];
        }
    }
    for(i=0; i<N; i++){
        for(j=0; j<N; j++){
            m[i][j]=aux[i][j];
        }
    }
}

//41)
void addTo(int N, int M, int a [N][M], int b[N][M]) {
    int i, j;
    
    for(i=0; i<N; i++){
        for(j=0; j<M; j++){
            a[i][j]+=b[i][j];
        }
    }
}

//42)
int unionSet (int N, int v1[N], int v2[N], int r[N]){
       int i, len=0;
       for(i=0; i<N; i++){
           r[i]=v1[i] || v2[i];
           len+=r[i];
       }
       return len;
}

//43)
int intersectSet (int N, int v1[N], int v2[N], int r[N]){
       int i, len=0;
       for(i=0; i<N; i++){
           r[i]=v1[i] && v2[i];
           len+=r[i];
       }
       return len;
}

//44)
int intersectMSet (int N, int v1[N], int v2[N], int r[N]){
       int i, len=0;
       
       for(i=0; i<N; i++){
           if(v1[i]<v2[i])r[i]=v1[i];
           else r[i]=v2[i];
           
           len+=r[i];
       }
       return len;
}

//45)
int unionMSet (int N, int v1[N], int v2[N], int r[N]){
       int i, len=0;
       
       for(i=0; i<N; i++){
           if(v1[i]>v2[i])r[i]=v1[i];
           else r[i]=v2[i];
           
           len+=r[i];
       }
       return len;
}

//46)
int cardinalMSet (int N, int v[N]){
   	  int c=0, i;
   	  for(i=0; i<N; i++)c+=v[i];
   	  return c;
}

//47)
typedef enum movimento {Norte, Oeste, Sul, Este} Movimento;
typedef struct posicao {
int x, y;
} Posicao;

Posicao posFinal (Posicao inicial, Movimento mov[], int N){
    int i;
    
    for(i=0; i<N; i++){
        if(mov[i]==Norte)inicial.y++;
        else if(mov[i]==Sul)inicial.y--;
        else if(mov[i]==Este)inicial.x++;
        else inicial.x--;
    }
    return inicial;
}

//48)
int caminho (Posicao inicial, Posicao final, Movimento mov[], int N){
    int i;
    for(i=0; (inicial.x != final.x) || (inicial.y != final.y); i++){
        if (inicial.x < final.x) {
            mov[i] = Este;
            inicial.x++;
        }
        else if(inicial.x > final.x) {
            mov[i] = Oeste;
            inicial.x--;
        }
        else if(inicial.y < final.y) {
            mov[i] = Norte;
            inicial.y++;
        }
        else if(inicial.y > final.y) {
            mov[i] = Sul;
            inicial.y--;
        }
    }
    //if (r>N) return -1;
    return i;
}

//49)
typedef struct posicao {
int x, y;
} Posicao;

int maiscentral (Posicao pos[], int N) {
    int res=0, i;
    float accum = 1000.000; // so para ter termo de comparaçao
    float num=0;
    for(i=0; i<N; i++){
        num = sqrt(pow(pos[i].x, 2) + pow(pos[i].y, 2));
        if(num<accum){
            res=i;
            accum=num;
        }
    }
    return res;
}

//50)
int vizinhos (Posicao p, Posicao pos[], int N) {
    int i, c=0;
    for(i=0; i<N; i++){
        if((abs(pos[i].x-p.x) == 1 && abs(pos[i].y-p.y) == 0) || (abs(pos[i].x-p.x) == 0 && abs(pos[i].y-p.y) == 1) ) c++;
    }
    return c;
}

//2ª Parte

typedef struct lligada {
int valor;
struct lligada *prox;
} *LInt;

//1)
int length (LInt l){
    int tam=0;
    
    while(l){
        tam++;
        l=l->prox;
    }
    
    return tam;
}

//2)
void freeL (LInt l){
    LInt lib;
    while(l){
        lib=l;
        l=l->prox;
        free(lib);
    }
}

//3)
void imprimeL (LInt l){
    LInt aux;
    while(l){
        aux=l;
        printf("%d\n", aux->valor);
        aux=aux->prox;
    }
}

//4)
LInt newLInt (int v, LInt t){
    LInt new = (LInt) malloc (sizeof (struct lligada));
    
    if (new!=NULL) {
        new->valor = v;
        new->prox  = t;
    }
    return new;
}

LInt reverseL (LInt l){
    LInt aux=NULL;
    while(l){
        aux=newLInt(l->valor, aux);
        //aux=aux->prox;
        l=l->prox;
    }
    return aux;
}

//5)
LInt newLInt (int v, LInt t){
    LInt new = (LInt) malloc (sizeof (struct lligada));
    
    if (new!=NULL) {
        new->valor = v;
        new->prox  = t;
    }
    return new;
}

void insertOrd (LInt *l, int x){
    while((*l) && (*l)->valor<x) l=&((*l)->prox);
    *l=newLInt(x,(*l));
}

//6)
int removeOneOrd (LInt *l, int x){
    while((*l)){
        if((*l)->valor==x){
            (*l)=(*l)->prox;
            return 0;
        }
        
        else l=&((*l)->prox);
    }
    return 1;
}

//7)
void merge (LInt *r, LInt l1, LInt l2){
    while(l1 && l2){
        if(l1->valor < l2->valor){
            (*r)=malloc(sizeof (struct lligada));
            (*r)->valor=l1->valor;
            l1=l1->prox;
            r=&((*r)->prox);
        }
        else{
            (*r)=malloc(sizeof (struct lligada));
            (*r)->valor=l2->valor;
            l2=l2->prox;
            r=&((*r)->prox);
        }
    }
    if(l1==NULL)(*r)=l2;
    else if (l2==NULL)(*r)=l1;
}

//8)
void splitQS (LInt l, int x, LInt *mx, LInt *Mx){
    while(l){
        if(l->valor < x){
            (*mx)=malloc(sizeof(struct lligada));
            (*mx)->valor=l->valor;
            mx=&((*mx)->prox);
            l=l->prox;
        }
        else{
            (*Mx)=malloc(sizeof(struct lligada));
            (*Mx)->valor=l->valor;
            Mx=&((*Mx)->prox);
            l=l->prox;
        }
    }
}

//9)
LInt parteAmeio (LInt *l){
    LInt aux = *l; 

    int tam=length(aux);
    tam/=2;

    LInt res;
    res=*l;

    LInt *aux2;
    aux2 = &res;

    while(tam>0){
        aux2=&((*aux2)->prox);
        *l=(*l)->prox;
        tam--;
    }
    
    (*aux2)=NULL;
    return res;
}

//10)
int removeAll (LInt *l, int x){
    int conta=0;
    while(*l){
        if((*l)->valor==x){
            (*l)=(*l)->prox;
            conta++;
        }
        else l=&((*l)->prox);
    }
    return conta;
}

//11)
int removeDups (LInt *l){
    int num=0, x=0;
    while(*l){
        x=(*l)->valor;
        l=&((*l)->prox);
        num += removeAll(l, x);
    }
    return num;
}

//12)
int removeMaiorL (LInt *l){
    int x=0, conta=0;
    LInt *aux;
    aux=l;
    while(*aux){
        x=(*aux)->valor;
        if(x>conta)conta=x;
        aux=&((*aux)->prox);
    }
    
    while(*l){
        if ((*l)->valor==conta){
            (*l)=(*l)->prox;
            break;
        }
        else l=&((*l)->prox);
    }
    return conta;
}

//13)
void init (LInt *l){
	if ((*l) == NULL);
	else{
		while ((*l)->prox != NULL) l= &((*l)->prox);
		
		free((*l));
		(*l) = NULL;
	}
} 

//14)
void appendL (LInt *l, int x){
    while((*l) != NULL) l=&((*l)->prox);
    
    (*l)=malloc(sizeof (struct lligada));
    (*l)->valor=x;
    (*l)->prox=NULL;
}

//15)
void concatL (LInt *a, LInt b){
    while(*a) a=&((*a)->prox);
    (*a)=b;
}

//16)
LInt cloneL (LInt l){
    LInt clone=NULL;    
     while(l){
         clone=malloc(sizeof (struct lligada));
         clone->valor = l->valor;
         l=l->prox;
         clone=clone->prox;
     }
     clone=NULL;
     return clone;
}

//17)
LInt cloneRev (LInt l){
    LInt rever=NULL;

    while(l){
        rever=newLInt(l->valor, l->prox);
        l=l->prox;
    }
    return rever;
}

//18)
int maximo (LInt l){
    int x=0, conta=0;
    LInt aux;
    aux=l;
    while(aux){
        x=aux->valor;
        if(x>conta)conta=x;
        aux=aux->prox;
    }
    return conta;
}

//19)
int take (int n, LInt *l){
    int i=0;
    while(n>0 && (*l)){l=&((*l)->prox); n--; i++;}
    if((*l)!=NULL)
        (*l)=(*l)->prox;
    (*l)=NULL;
    return i;
}

//20)
int drop (int n, LInt *l){
    int i=0, x=0;
    while((*l)){
        if(x<n){
            i++;
            (*l)=(*l)->prox;
        }
        else l=&((*l)->prox);
        x++;
    }
    return i;
}

//21)
LInt NForward (LInt l, int N){
    while(N>0){
        l=l->prox;
        N--;
    }
    return l;
}

//22)
int listToArray (LInt l, int v[], int N){
    int i=0;
    while(l && i<N){
        v[i]=l->valor;
        l=l->prox;
        i++;
    }
    return i;
}

//23)
LInt arrayToList (int v[], int N){
    LInt nova=NULL;
    int i;
    for(i=N-1; i>=0; i--){
        nova=newLInt(v[i], nova);
    }
    return nova;
}

//24)
LInt somasAcL (LInt l) {
    LInt aux=l;
    int tam=length(aux);
    LInt somaList;
    int vetor[tam];
    int x[tam];
    listToArray(l, vetor,tam);
    somasAc(vetor, x, tam);
    somaList=arrayToList(x, tam);
}

//25)
void remreps (LInt l){
   if(l != NULL){
        while(l->prox != NULL){
            if(l->valor==l->prox->valor){
                LInt aux=l->prox;
                l->prox=aux->prox;
                free(aux);
            }
            else l=l->prox;
        }
    }
}

//26)
LInt rotateL (LInt l){
    if(!l || !(l->prox)) return l;
    LInt temp = l;
    LInt list = l->prox;
    while(temp->prox) temp = temp->prox; 
    temp->prox = l;
    l->prox = NULL;
    return list;
}

//27)
LInt parte (LInt l){
    int x=0;
    LInt *aux = &l;
    LInt newl = NULL;
    LInt *celula=&newl;
    
    while(*aux){
        if(x%2!=0){
            while(*celula)celula=&((*celula)->prox);
            (*celula)=malloc(sizeof (struct lligada));
            (*celula)->valor = (*aux)->valor;
            (*celula)->prox=NULL;
            (*aux)=(*aux)->prox;
        }
        else aux=&((*aux)->prox);
        x++;
    }
    return newl;
}

//28)
typedef struct nodo {
int valor;
struct nodo *esq, *dir;
} *ABin;

int altura (ABin a){
    int alt=0;
    if(a){
        if(a->esq > a->dir) alt=1+altura(a->esq);
        else alt=1+altura(a->dir);
    }
    return alt;
}

//29)
ABin cloneAB (ABin a) {
    ABin clone=NULL;
    if(a){
        clone=malloc (sizeof (struct nodo));
        clone->valor = a->valor;
        clone->esq = cloneAB(a->esq);
        clone->dir = cloneAB(a->dir);
    }
    return clone;
}

//30)
void mirror (ABin *a) {
    ABin aux;
    if(*a){
        aux=((*a)->dir);
        (*a)->dir = (*a)->esq;
        (*a)->esq = aux;
        mirror(&((*a)->dir));
        mirror(&((*a)->esq));
    }
}

//31)
void auxinorder (ABin a, LInt * l) {
    //1º -> esq
    //2º -> meio
    //3º -> dir
    if(a==NULL);
    else{
        auxinorder(a->esq, l);
        while(*l) l=&((*l)->prox);
        (*l) = malloc (sizeof (struct lligada));
        (*l)->valor = a->valor;
        (*l)->prox = NULL;
        auxinorder(a->dir, l);
    }
}

void inorder (ABin a, LInt *l){
    (*l)=NULL;
    auxinorder (a, l);
}

//32)
void auxpreorder (ABin a, LInt * l) {
    //1º -> valor
    //2º -> esq
    //3º -> dir
    if(a==NULL);
    else{
        while(*l) l=&((*l)->prox);
        (*l) = malloc (sizeof (struct lligada));
        (*l)->valor = a->valor;
        (*l)->prox = NULL;
        auxpreorder(a->esq, l);
        auxpreorder(a->dir, l);
    }
}

void preorder (ABin a, LInt * l){
    (*l)=NULL;
    auxpreorder(a, l);
}

//33)
 void auxposorder (ABin a, LInt * l) {
    //1º -> esq
    //2º -> dir
    //3º -> valor
    if(a==NULL);
    else{
        
        auxposorder(a->esq, l);
        auxposorder(a->dir, l);
        while(*l) l=&((*l)->prox);
        (*l) = malloc (sizeof (struct lligada));
        (*l)->valor = a->valor;
        (*l)->prox = NULL;
    }    
}

 void posorder (ABin a, LInt * l){
     (*l)=NULL;
     auxposorder(a, l);
 }

//34)
int depth (ABin a, int x){
	int r=1, esq, dir;
	if ( a == NULL) r = -1;
	else if ( a -> valor == x) return 1;
	else{
		esq = depth ( a->esq, x);
		dir = depth ( a->dir, x);

		if ( esq == -1 && dir == -1) r = -1;
		else if ( esq == -1 )  r+=dir;
		else if ( dir == -1 )  r+=esq;
		else if ( esq > dir ) r+= dir;
		else r += esq;

	}
	return r;
}

//35)
int freeAB (ABin a) {
    int n=0;
    if(!a) return 0;
    if(a){
        n += 1 + freeAB(a->esq) + freeAB(a->dir);
        free(a);
    }
    return n;
}

//36)
int pruneAB (ABin *a, int l) {
     int n=0;
     if(!(*a))return 0;
     else if(l==0){
         n = freeAB(*a);  
         (*a)=NULL;}
     else{
         n = pruneAB(&((*a)->esq), l-1) + pruneAB(&((*a)->dir), l-1);
     }
     return n;
}

//37)
int iguaisAB (ABin a, ABin b) {
    if((!a && b) || (a && !b)) return 0;
    else if ((!a && !b) || (a == b)) return 1;
    else if(a->valor != b->valor) return 0;
    int r = (a->valor == b->valor) && (iguaisAB(a->esq, b->esq)) && (iguaisAB(a->dir, b->dir));
    return r;
}

//38)
void auxnivelL (ABin a, int n, LInt *nova) {
    //*nova = NULL;
    if(!a)return;
    if(n==1){
        while(*nova) nova=&((*nova)->prox);
        (*nova) = malloc (sizeof (struct lligada));
        (*nova)->valor = a->valor;
        (*nova)->prox = NULL;
    }
    else{
        auxnivelL(a->esq, n-1, nova);
        auxnivelL(a->dir, n-1, nova);
    }
    //return *nova;
}

LInt nivelL (ABin a, int n){
    LInt nova = NULL;
    auxnivelL(a, n, &nova);
    return nova;
}

//39)
int auxnivel (ABin a, int n, int v[], int *i){
    if(!a) return;
    if(n==1){
        v[*i]=a->valor;
        (*i)++;
    }
    else{
        auxnivel(a->esq, n-1, v, i);
        auxnivel(a->dir, n-1, v, i);
    }
    return *i;
}

int nivelV (ABin a, int n, int v[]) {
    int i=0;
    return auxnivel(a, n, v, &i);
}

//40)
int auxdump (ABin a, int N, int *i, int v[]){
    if (!a) (*i)+=0;
    
    else{
        (*i)=auxdump(a->esq, N, i, v);
        
        if((*i)<N){
            v[*i]=a->valor;
            (*i)++;
        }
        
        (*i)=auxdump(a->dir, N, i, v);
    }
    return (*i);
} 
 
int dumpAbin (ABin a, int v[], int N) {
    int i=0;
    return auxdump(a, N, &i, v);
}

//41)
ABin somasAcA (ABin a) {
    
    if(!a)return NULL;
    
    ABin nova = malloc (sizeof (struct nodo));
        
    nova->dir = somasAcA(a->dir);
    nova->esq = somasAcA(a->esq);
        
    nova->valor = a->valor + (nova->esq ? nova->esq->valor : 0) + (nova->dir ? nova->dir->valor : 0);

    return nova;
}

//42)
int contaFolhas (ABin a) {
    int x=0;
    if (!a)return 0;
    if (!(a->dir) && !(a->esq)) x = 1 + contaFolhas(a->dir) + contaFolhas(a->esq);
    else x = contaFolhas(a->dir) + contaFolhas(a->esq);
    return x;
}

//43)
ABin cloneMirror (ABin a) {
    if(!a)return NULL;
    ABin nova = malloc (sizeof (struct nodo));
    nova->valor = a->valor;
    nova->dir = cloneMirror(a->esq);
    nova->esq = cloneMirror(a->dir);
    return nova;
}

//44)
int addOrd (ABin *a, int x) {
    while(*a){
        if((*a)->valor == x) return 1;
        else if ((*a)->valor > x) a=&((*a)->esq);
        else a=&((*a)->dir);
    }
    ABin nova = malloc (sizeof (struct nodo));
    nova->valor=x;
    nova->esq = NULL;
    nova->dir = NULL;
    (*a) = nova;
    return 0;
}

//45)
int lookupAB (ABin a, int x) {
    while(a){
        if(a->valor == x) return 1;
        else if(a->valor > x) a=a->esq;
        else a=a->dir;
    }
    return 0;
}

//46)
int depthOrd (ABin a, int x) {
    int c=1;
    
    if(!(lookupAB(a, x)))return -1;
    
    while(a){
        if(a->valor == x) return c;
        else if(a->valor > x){
            a=a->esq;
            c++;
        }
        else{
            a=a->dir;
            c++;
        }
    }
    return c;
}

//47)
int maiorAB (ABin a) {
    while(a->dir)a=a->dir;
    int x = a->valor;
    return x;
}

//48)
void removeMaiorA (ABin *a) {
    ABin aux;
    while ((*a)->dir) a = &((*a)->dir);
    aux = (*a);
    free(*a);
    (*a) = aux->esq;
}

//49)
void listToBTree (LInt l, ABin *a) {
    while(l){
        addOrd(a, l->valor);
        l=l->prox;
    }
}

//50)
int deProcuraAux(ABin tree, int x, int maior) {
    if(!tree) return 1;
    if((maior && tree->valor < x) || (!maior && tree->valor > x)) return 0;
    return deProcuraAux(tree->esq,x,maior) && deProcuraAux(tree->dir,x,maior);
}

int deProcura (ABin tree) {
    if(!tree) return 1;
    int b = deProcuraAux(tree->esq,tree->valor, 0) && deProcura(tree->esq);
    int c = deProcuraAux(tree->dir,tree->valor, 1) && deProcura(tree->dir);
    return b && c;
}