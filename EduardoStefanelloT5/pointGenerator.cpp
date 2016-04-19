#include <stdio.h>
#include <stdlib.h>

int main(){
    int p1x[6], p1y[6], p2x[6], p2y[6], p3x[6], p3y[6], ptx, pty;
  
    p1x[0] =  10, p1y[0] =  60, p2x[0] =  40, p2y[0] = 140, p3x[0] = 170, p3y[0] =  50;
    p1x[1] = 180, p1y[1] = 130, p2x[1] = 100, p2y[1] = 120, p3x[1] = 130, p3y[1] = 190;
    p1x[2] =  90, p1y[2] = 190, p2x[2] =  50, p2y[2] = 160, p3x[2] =  40, p3y[2] = 210;
    p1x[3] = 180, p1y[3] = 190, p2x[3] = 150, p2y[3] = 180, p3x[3] = 160, p3y[3] = 210;
    p1x[4] = 130, p1y[4] = 220, p2x[4] = 100, p2y[4] = 220, p3x[4] = 100, p3y[4] = 250;
    p1x[5] =  60, p1y[5] = 250, p2x[5] =  20, p2y[5] = 230, p3x[5] =  10, p3y[5] = 250;
  
    for(int k = 0; k < 6; k++){
        int j = 25;
            while(j--){
                ptx = rand()%640;
                pty = rand()%480;
                printf("%d %d %d %d %d %d %d %d\n", p1x[k], p1y[k], p2x[k], p2y[k], p3x[k], p3y[k], ptx, pty);
            }
        }
        
    return 0;
}
