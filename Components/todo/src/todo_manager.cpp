#include "todo_manager.h"

#include <algorithm>
#include <thread>
#include <chrono>
#include <mutex>



namespace todo_sample
{

namespace
{
	
void Sleep(size_t seconds)
{
	std::this_thread::sleep_for(std::chrono::seconds(seconds));
}

void Notify(std::function<void()> callback)
{
    new std::thread (callback);
}

}

class CriticalSection
{
public:
	void lock()
	{
		m_mutex.lock();
	}
	void unlock()
	{
		m_mutex.unlock();
	}
private:
	std::mutex m_mutex;
};

typedef std::lock_guard<CriticalSection> LockGuard;

TodoManager::TodoManager()
	: m_cs(new CriticalSection)
{

}

TodoManager::~TodoManager()
{
	Close();
}

void TodoManager::Connect(IConnectCallback* callback)
{
    Notify([this, callback](){
        Sleep(2);
        LockGuard lock(*m_cs.get());
        this->m_isConnected = true;
        if (callback)
            callback->OnConnect(true);
    });
}

void TodoManager::Close()
{
	LockGuard lock(*m_cs.get());
	m_isConnected = false;
}

TodoItemsCollection TodoManager::GetItems() const
{
	LockGuard lock(*m_cs.get());
	//Sleep(1);
	return m_todoItems;
}

bool TodoManager::GetItem(const TodoItemId& id, TodoItem& item) const
{
	LockGuard lock(*m_cs.get());
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
	LockGuard lock(*m_cs.get());
	TodoItem item = {0};
	item.id = m_todoItems.size();
	strncpy(item.title, "New todo item", MaxTitle);
	strncpy(item.description, "Fill me", MaxDescription);

	auto now = std::chrono::system_clock::now();
	item.dueDateUtc = std::chrono::system_clock::to_time_t(now + std::chrono::hours(24));

	m_todoItems.push_back(item);

	return item;
}

bool TodoManager::UpdateItem(const TodoItem& item)
{
	LockGuard lock(*m_cs.get());
	auto itemInCollection = FindItemById(item.id);
	if (itemInCollection != std::end(m_todoItems))
	{
		strncpy(itemInCollection->title, item.title, MaxTitle);
		strncpy(itemInCollection->description, item.description, MaxDescription);
		itemInCollection->dueDateUtc = item.dueDateUtc;

		return true;
	}
	else
	{
		return false;
	}
}

bool TodoManager::DeleteItem(const TodoItemId& id)
{
	LockGuard lock(*m_cs.get());
	auto itemInCollection = FindItemById(id);
	if (itemInCollection != std::end(m_todoItems))
	{
		const TodoItemId id = itemInCollection->id;
		m_todoItems.erase(itemInCollection);

		return true;
	}
	else
	{
		return false;
	}
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
