#pragma once
#include <ctime>

namespace todo_sample
{

typedef size_t TodoItemId;

struct TodoItem
{
	TodoItemId id;

	char title[256];
	char description[1024];

	std::time_t dueDateUtc;
};

}