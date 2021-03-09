int putchar(int c);

void printNum(int num) {
	if (num < 0) {
		putchar(69);
	} else if (num == 0) {
		putchar(48);
	}
	
	char buffer[100];
	int length = 0;
	
	while (num > 0) {
		int mod = num % 10;
		num = num / 10;
		buffer[length] = mod + 48;
		length = length + 1;
	}
	
	for (int i = length - 1; i >= 0; i = i - 1) {
		putchar(buffer[i]);
	}

	putchar(10);	
	return;
}

int sumNumbers(int n1, int n2, int n3, int n4, int n5, int n6, int n7, int n8,
			   int n9, int n10, int n11, int n12) 
{
	printNum(n1);
	printNum(n2);
	printNum(n3);
	printNum(n4);
	printNum(n5);
	printNum(n6);
	printNum(n7);
	printNum(n8);
	printNum(n9);
	printNum(n10);
	printNum(n11);
	printNum(n12);
	return n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8 + n9 + n10 + n11 + n12;			   
}

char func(int* number) {
	return *number;
}

int abs(int num) {
	if (num < 0) {
		return -num;
	}
	
	return num;
}

int main() {
	int newline = 10;
	
	int num = 127;
	char result = func(&num);
	printNum(result);
	putchar(newline);
	

	int numbers[12] = {1, -2, -3, 4, 5, -6, 7, -8, -9, -10, 11, 12};

	int sum = sumNumbers(abs(numbers[0]), abs(numbers[1]), 
						 abs(numbers[2]), abs(numbers[3]), 
						 abs(numbers[4]), abs(numbers[5]),
						 abs(numbers[6]), abs(numbers[7]),
						 abs(numbers[8]), abs(numbers[9]),
						 abs(numbers[10]), abs(numbers[11]));
	putchar(newline);
	printNum(sum);

	return 0;	
}


