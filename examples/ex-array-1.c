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

int main() {
	int arr[3][4] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};


	for (int i = 0; i < 3; i = i + 1) {
		for (int j = 0; j < 4; j = j + 1) {
			printNum(arr[i][j]);
		}
	}
	

	return 0;	
}
