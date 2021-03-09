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
	long i = 0;
	char dumb = 234;
	short numb = 235;
	short* shortptr = &numb;
	int* ptr = shortptr + 1;

	void*** ptrptr = &ptr;

	printNum(**ptrptr);
	return 0;	
}
