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

long sum(void* ptr1, void* ptr2) {
	int* num1 = ptr1;
	int* num2 = ptr2;
	
	return *num1 + *num2; 
}

int main() {
	int num1 = 52;
	int num2 = 423;

	long (*funcPtr) (void*, void*);
	funcPtr = &sum;

	printNum(funcPtr(&num1, &num2));

	return 0;
}

