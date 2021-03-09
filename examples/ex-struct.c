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

typedef struct Car {
	char length;
	char width;
	char arr[30];
	short prod_year;
	long score;
	int price;
	struct Car* next;
};

void alterCar(struct Car* ptr) {
	ptr->length = 10;
	ptr->width = 30;
}


int main() {
	char newline = 10;
	
	struct Car car_1;
	struct Car car_2 = car_1;

	struct Car car_park[30] = {car_1};
	
	car_1.length = 3 * 1 * 1;
	car_1.width = 2 * (2 - 1);
	car_1.prod_year = 1998 * 1;
	car_1.score = 242340 * (3 - 2 / 2);
	car_1.price = 3000;
	car_1.arr[1] = 25;
	
	
	car_park[0].price = 5;
	car_park[0].arr[1] = 25;
	
	alterCar(&car_1);
	
	printNum(car_1.length);
	printNum(car_1.width);
	printNum(car_1.prod_year);
	printNum(car_1.score);
	printNum(car_1.price);
	printNum(car_1.arr[1]);

	putchar(newline);
	
	car_2.length = 2;
	car_2.width = 3;
	car_2.prod_year = 1968;
	car_2.score = 24234023;
	car_2.price = 3250;
	
	printNum(car_2.length);
	printNum(car_2.width);
	printNum(car_2.prod_year);
	printNum(car_2.score);
	printNum(car_2.price);
	
	putchar(newline);
	
	car_park[0] = car_1;
	car_park[1] = car_2;
	
	int car_price = car_park[0].price;
	printNum(car_price);
	car_price = car_park[1].price;
	printNum(car_price);
	putchar(newline);
	
	struct Car* car_ptr = &car_1;
	car_ptr->length = 4;
	car_ptr->prod_year = car_ptr->prod_year - 2;
	
	printNum(car_1.length);
	printNum(car_1.width);
	printNum(car_1.prod_year);
	printNum(car_1.score);
	printNum(car_1.price);
	
	putchar(newline);
	
	car_ptr = &car_2;
	car_ptr->price = 5000;
	car_ptr->price = car_ptr->price * 2;
	
	printNum(car_2.length);
	printNum(car_2.width);
	printNum(car_2.prod_year);
	printNum(car_2.score);
	printNum(car_2.price);

	putchar(newline);
	
	car_ptr->next = &car_1;
	int pp = car_ptr->next->price;
	printNum(pp);
}
