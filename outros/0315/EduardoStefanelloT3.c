#include <stdio.h>
#include <stdlib.h>

typedef struct{
  	int x, y;
} ponto;

int sinal(ponto p1, ponto p2, ponto p3){
    return abs((p1.x*(p2.y-p3.y) + p2.x*(p3.y-p1.y)+ p3.x*(p1.y-p2.y)));
}

int PontoNoTriangulo(ponto pt, ponto v1, ponto v2, ponto v3){
    int  A = sinal(v1, v2, v3);
    int A1 = sinal(pt, v2, v3);
    int A2 = sinal(v1, pt, v3);
    int A3 = sinal(v1, v2, pt);
   
   return (A == A1 + A2 + A3);
}
 
int main(){
  	ponto v1, v2, v3, pnt;
    int i, j;

  	scanf("%d %d", &v1.x, &v1.y);
  	scanf("%d %d", &v2.x, &v2.y);
  	scanf("%d %d", &v3.x, &v3.y);
  	scanf("%d %d", &pnt.x, &pnt.y);

  	if(PontoNoTriangulo(pnt, v1, v2, v3))
  		printf("Dentro\n");
  	else
  		printf("Fora\n");

    ponto tmp;

    for(i = 0; i < 121; i++){
        printf("|");
        for(j = 0; j < 121; j++){
            tmp.x = j;
            tmp.y = i;
            if(tmp.x == pnt.x && tmp.y == pnt.y) printf("@");
            else if(PontoNoTriangulo(tmp, v1, v2, v3)) printf("#");
            else printf(" ");
        }
        printf("|\n");
    }
  
  	return 0;
}