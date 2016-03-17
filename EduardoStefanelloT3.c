#include <stdio.h>
#include <stdlib.h>

typedef struct{
  	int x, y;
} ponto;

int sinal(ponto p1, ponto p2, ponto p3){
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}

int PontoNoTriangulo(ponto pt, ponto v1, ponto v2, ponto v3){
    int b1, b2, b3;

    b1 = (sinal(pt, v1, v2) < 0) ? 1 : 0;
    b2 = (sinal(pt, v2, v3) < 0) ? 1 : 0;
    b3 = (sinal(pt, v3, v1) < 0) ? 1 : 0;

    return ((b1 == b2) && (b2 == b3)) ? 1 : 0;
}
 
int main(){
  	ponto v1, v2, v3, pnt;

  	scanf("%d %d", &v1.x, &v1.y);
  	scanf("%d %d", &v2.x, &v2.y);
  	scanf("%d %d", &v3.x, &v3.y);
  	scanf("%d %d", &pnt.x, &pnt.y);

  	if(PontoNoTriangulo(pnt, v1, v2, v3))
  		printf("Dentro\n");
  	else
  		printf ("Fora\n");
  
  	return 0;
}