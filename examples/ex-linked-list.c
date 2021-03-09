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

typedef struct Node {
	int* data;
	struct Node* next;
};

typedef struct LL {
	struct Node* head;
	struct Node* tail;
};


void addNode(struct LL* list, struct Node* new_node_ptr) {
	if (list->head == 0) {
		list->head = new_node_ptr;
		list->tail = new_node_ptr;
		
		struct Node* head = list->head;
		head->next = 0;
	} else {
		new_node_ptr->next = list->head;
		list->head = new_node_ptr;
	}
}

void printList(struct LL* list) {
	struct Node* cur_node_ptr = list->head;
	
	while (cur_node_ptr != 0) {
		printNum(cur_node_ptr->data);
		cur_node_ptr = cur_node_ptr->next;
	}
}

int main() {
	struct LL list;
	
	list.head = 0;
	list.tail = 0;
	
	struct Node new_nodes[10];
	
	for (int i = 0; i < 10; i = i + 1) {
		new_nodes[i].data = 10 - i;
		addNode(&list, &new_nodes[i]);
	}
	
	printList(&list);
}
