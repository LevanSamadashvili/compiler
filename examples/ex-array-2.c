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


void printArray(short* arr, int length) {
	for (int i = 0; i < length; i = i + 1) {
		short* elemPtr = arr + i;
		printNum(*elemPtr);
		printNum(arr[i]);
	}
}

int main() {
	short arr[5] = {1, 2, 3, 4, 5};

	printArray(&arr, 5);	

	arr[2] = 4;
	arr[1] = 4;
	
	putchar(10);
	printArray(&arr, 5);
	
	return 0;	
}
