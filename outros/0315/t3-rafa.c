#include <stdio.h>
#include <stdlib.h>

typedef struct{
  int x, y;
} ponto;

int area(ponto a,ponto b,ponto c){
  return abs((a.x*(b.y-c.y) + b.x*(c.y-a.y)+ c.x*(a.y-b.y)));
}
 
int verificacao(ponto a, ponto b, ponto c,ponto r){   
   int A = area(a,b,c);
   int A1 = area(r,b,c);
   int A2 = area(a,r,c);
   int A3 = area(a,b,r);
   
   return (A == A1 + A2 + A3);
}
 
int main(){
  int x, i, j, k, l, m, c;
  ponto pontos[4];

  for(k = 0; k < 4; k++){
    scanf("%d",&x);
    m = x;
    l = 0;
    c = x;
    while(x >= 600){
      x -= 600;
      l++;
    }
    j = c -(600*l);
    pontos[k].x = l;
    pontos[k].y = j;
  }

  if(verificacao(pontos[0],pontos[1],pontos[2],pontos[3])) printf("Dentro\n");
  else printf ("Fora\n");
  
  return 0;
}