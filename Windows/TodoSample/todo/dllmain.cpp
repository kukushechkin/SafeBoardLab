// dllmain.cpp : Defines the entry point for the DLL application.
#include "todo_manager.h"

static todo_sample::TodoManager g_todoManager;

extern "C"
{
	bool __declspec(dllexport) Connect()
	{
		return g_todoManager.Connect();
	}

	void __declspec(dllexport) Close()
	{
		g_todoManager.Close();
	}

	void __declspec(dllexport) __cdecl CreateItem(todo_sample::TodoItem* item)
	{
		*item = g_todoManager.CreateItem();
	}

	int __declspec(dllexport) __cdecl GetItems(todo_sample::TodoItem* items, int maxItemsLength)
	{
		auto itemsVector = g_todoManager.GetItems();
		
		if (itemsVector.size() <= static_cast<size_t>(maxItemsLength))
		{
			memset(items, 0, sizeof(todo_sample::TodoItem) * maxItemsLength);
			memcpy(items, &itemsVector[0], sizeof(todo_sample::TodoItem) * itemsVector.size());
		}

		return itemsVector.size();
	}
}