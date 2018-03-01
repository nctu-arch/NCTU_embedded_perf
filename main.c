#include HEADER
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main(void)
{
#if defined(PI)
    printf("pid: %d\n", getpid());
    sleep(10);
    compute_pi_baseline(50000000);
#elif defined(MATRIX)
    static int array[10000][10000] = {0};
    matrix(10000,10000,array);

#endif
    return 0;

}


