#include <stdio.h>
#include <stdlib.h>

int op1(int ya, int yb, int x){
	return (ya - yb) * x;
}

int op2(int ya, int yb, int x, int t1){
	return op1(ya, yb, x) + t1;
}

int area(int p1x, int p1y, int p2x, int p2y, int p3x, int p3y){
	int t1 = op1(p2y, p3y, p1x);
	int t2 = op2(p3y, p1y, p2x, t1);
	int t3 = op2(p1y, p2y, p3x, t2);
	if(t3 < 0)
		return t3 * (-1);
	return t3;
}

int main(){
	int p1x, p1y, p2x, p2y, p3x, p3y, ptx, pty;
	while(scanf("%d %d %d %d %d %d %d %d",
				&p1x, &p1y, &p2x, &p2y, &p3x, &p3y, &ptx, &pty) != EOF){
		int s1 = area(p1x, p1y, p2x, p2y, p3x, p3y),
			s2 = area(p1x, p1y, p2x, p2y, ptx, pty),
			s3 = area(p2x, p2y, p3x, p3y, ptx, pty),
			s4 = area(p3x, p3y, p1x, p1y, ptx, pty);
		printf("[%d] %d %d %d %d %d %d %d %d\n",(s1 == s2 + s3 + s4),p1x,p1y,p2x,p2y,p3x,p3y,ptx,pty);
	}
	return 0;
}