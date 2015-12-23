#include "todo_manager.h"

#include <algorithm>
#include <thread>
#include <chrono>


typedef std::lock_guard<std::mutex> LockGuard;

namespace todo_sample
{

namespace
{
	
void Sleep(size_t seconds)
{
	std::this_thread::sleep_for(std::chrono::seconds(seconds));
}

void Notify(ItemModifiedCallback* callback, const TodoItemId& id)
{
	if (callback)
	{
		Sleep(1);
		std::thread(callback, id);
	}
}

}

TodoManager::TodoManager()
{

}

TodoManager::~TodoManager()
{
	Close();
}

bool TodoManager::Connect()
{
	LockGuard lock(m_mutex);
	m_isConnected = true;
	Sleep(2);
	return m_isConnected;
}

void TodoManager::Close()
{
	LockGuard lock(m_mutex);
	m_isConnected = false;
}

TodoItemsCollection TodoManager::GetItems() const
{
	LockGuard lock(m_mutex);
	//Sleep(1);
	return m_todoItems;
}

bool TodoManager::GetItem(const TodoItemId& id, TodoItem& item) const
{
	LockGuard lock(m_mutex);
	//Sleep(1);
	auto itemInCollection = FindItemById(id);
	
	if (itemInCollection != std::end(m_todoItems))
	{
		item = *itemInCollection;
		return true;
	}
	else
	{
		return false;
	}
}

TodoItem TodoManager::CreateItem()
{
	LockGuard lock(m_mutex);
	TodoItem item = {0};
	item.id = m_todoItems.size();
	strncpy_s(item.title, MaxTitle, "New todo item", MaxTitle);
	strncpy_s(item.description, MaxDescription, "Fill me", MaxDescription);

	auto now = std::chrono::system_clock::now();
	item.dueDateUtc = std::chrono::system_clock::to_time_t(now + std::chrono::hours(24));

	m_todoItems.push_back(item);

	Notify(m_addedCallback, item.id);

	return item;
}

bool TodoManager::UpdateItem(const TodoItem& item)
{
	LockGuard lock(m_mutex);
	auto itemInCollection = FindItemById(item.id);
	if (itemInCollection != std::end(m_todoItems))
	{
		strncpy_s(itemInCollection->title, MaxTitle, item.title, MaxTitle);
		strncpy_s(itemInCollection->description, MaxDescription, item.description, MaxDescription);
		itemInCollection->dueDateUtc = item.dueDateUtc;

		Notify(m_updatedCallback, item.id);

		return true;
	}
	else
	{
		return false;
	}
}

bool TodoManager::DeleteItem(const TodoItemId& id)
{
	LockGuard lock(m_mutex);
	auto itemInCollection = FindItemById(id);
	if (itemInCollection != std::end(m_todoItems))
	{
		const TodoItemId id = itemInCollection->id;
		m_todoItems.erase(itemInCollection);

		Notify(m_deletedCallback, id);

		return true;
	}
	else
	{
		return false;
	}
}

void TodoManager::SetAddCallback(ItemModifiedCallback* func)
{
	LockGuard lock(m_mutex);
	m_addedCallback = func;
}

void TodoManager::SetUpdatedCallback(ItemModifiedCallback* func)
{
	LockGuard lock(m_mutex);
	m_updatedCallback = func;
}

void TodoManager::SetDeletedCallback(ItemModifiedCallback* func)
{
	LockGuard lock(m_mutex);
	m_deletedCallback = func;
}

TodoItemsCollection::iterator TodoManager::FindItemById(const TodoItemId& id)
{
	return std::find_if(std::begin(m_todoItems), std::end(m_todoItems),
		[&id](const TodoItem& item){return item.id == id; });
}

TodoItemsCollection::const_iterator TodoManager::FindItemById(const TodoItemId& id) const
{
	return std::find_if(std::begin(m_todoItems), std::end(m_todoItems),
		[&id](const TodoItem& item){return item.id == id; });
}

}