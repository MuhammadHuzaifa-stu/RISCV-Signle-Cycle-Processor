int main(void){
    int j = 0, i = 0, sum = 0;
    int n1 = 5, n2 = n1-1;

    while (n2 != 0){
        while (j < n2){
            sum += n1;
            j++;
        }
        j = 0;
        n2 = n2 -1;
        n1 = sum;
        sum = 0;
    }
	while(1){}
}