#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(){
	int x[4], y[4];
	int area[4];

	int i;

	for(i = 0; i < 4; i++)
		scanf("%d %d", &x[i], &y[i]);

	area[0] = abs(x[0] * (y[1] - y[2])) + (x[1] * (y[2] - y[0])) + (x[2] * (y[0] - y[1]));
	
	area[1] = abs(x[0] * (y[1] - y[3])) + (x[1] * (y[3] - y[0])) + (x[3] * (y[0] - y[1]));
	
	area[2] = abs(x[1] * (y[2] - y[3])) + (x[2] * (y[3] - y[1])) + (x[3] * (y[1] - y[2]));
	
	area[3] = abs(x[0] * (y[3] - y[2])) + (x[3] * (y[2] - y[0])) + (x[2] * (y[0] - y[3]));

	if(area[1] + area[0] + area[3] == area[2])
		printf("Dentro\n");
	else
		printf("Fora\n");
}