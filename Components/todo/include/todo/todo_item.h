#pragma once
#include <string>
#include <chrono>
#include <ctime>


namespace todo_sample
{

typedef size_t TodoItemId;

const size_t MaxTitle = 256;
const size_t MaxDescription = 1024;

struct TodoItem
{
	TodoItemId id;

	char title[MaxTitle];
	char description[MaxDescription];

	std::time_t dueDateUtc;
};

}