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


void printArray(int* arr, int length) {
	for (int i = 0; i < length; i = i + 1) {
		printNum(arr[i]);
	}
}

void swap(int* elem1, int* elem2) {
	int tmp = *elem1;
	*elem1 = *elem2;
	*elem2 = tmp;
}

int partition(int* arr, int low, int high) {
	int pivot = arr[low];	
	int p = low;
	
	int l = low + 1;
	int r = high;
	
	while (l < r) {
		while (arr[l] < pivot)	l = l + 1;	
		while (arr[r] > pivot)  r = r - 1;		
		
		if (l >= r) {
			break;
		}
		
		swap(&arr[l], &arr[r]);
		l = l + 1;
		r = r - 1;
	}
	
	if (arr[r] < pivot) {
		swap(&arr[p], &arr[r]);
		p = r;
	} else if (arr[l] >= pivot) {
		swap(&arr[p], &arr[l - 1]);
		p = l - 1;
	}

	return p;
}

void quicksort(int* arr, int low, int high) {
	if (low >= high) {
		return;
	}
	
	int p = partition(arr, low, high);
	quicksort(arr, low, p - 1);
	quicksort(arr, p + 1, high);
}

int main() {
	int arr[10] = {10, 8, 9, 1, 5, 2, 2, 3, 4, 4};
	
	quicksort(&arr, 0, 9);
	printArray(&arr, 10);

	return 0;	
}
