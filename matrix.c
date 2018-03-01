#include <stdlib.h>
#include "matrix.h"

void matrix(int row,int col,int array[row][col])
{
    int i, j;
    for (i = 0; i < row; i++)
        for (j = 0; j < col; j++)
            array[j][i]++;
}
