#include "todo_manager.h"

#include <algorithm>
#include <thread>

#include <ctime>
#include <chrono>

typedef std::lock_guard<std::mutex> LockGuard;

namespace todo_sample
{

namespace
{

void Notify(ItemModifiedCallback* callback, const TodoItemId& id)
{
	if (callback)
	{
		std::this_thread::sleep_for(std::chrono::milliseconds(500));
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
	std::this_thread::sleep_for(std::chrono::seconds(2));
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
	//::Sleep(200);
	return m_todoItems;
}

bool TodoManager::GetItem(const TodoItemId& id, TodoItem& item) const
{
	LockGuard lock(m_mutex);
	//::Sleep(200);
	auto itemInCollection = FindItemById(id);
	
	if (itemInCollection != std::cend(m_todoItems))
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
	TodoItem item;
	item.id = m_todoItems.size();
	strcpy_s(item.title, 255, "New todo item");
	strcpy_s(item.description, 1024, "Fill me");

	auto now = std::chrono::system_clock::now();
	now += std::chrono::hours(24);
	item.dueDateUtc = std::chrono::system_clock::to_time_t(now);

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
		strcpy_s(itemInCollection->title, 255, item.title);
		strcpy_s(itemInCollection->description, 1024, item.description);
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
	return std::find_if(std::cbegin(m_todoItems), std::cend(m_todoItems),
		[&id](const TodoItem& item){return item.id == id; });
}

}