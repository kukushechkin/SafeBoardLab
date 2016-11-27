#pragma once
#include "todo_exports.h"
#include "todo_item.h"
#include <vector>
#include <memory>

namespace todo_sample
{
    
class IConnectCallback
{
public:
    virtual ~IConnectCallback() {}
    virtual void OnConnect(bool success) = 0;
};
 
typedef std::vector<TodoItem> TodoItemsCollection;
    
class CriticalSection;

class TODO_API TodoManager
{
public:
	TodoManager();
	~TodoManager();

	void Connect(IConnectCallback* callback = 0);
	void Close();

	TodoItemsCollection GetItems() const;

	TodoItem CreateItem();
	bool GetItem(const TodoItemId& id, TodoItem& item) const;
	bool UpdateItem(const TodoItem& item);
	bool DeleteItem(const TodoItemId& id);

private:
	TodoItemsCollection m_todoItems;

    bool m_isConnected;

	TodoItemsCollection::iterator FindItemById(const TodoItemId& id);
	TodoItemsCollection::const_iterator FindItemById(const TodoItemId& id) const;

	mutable std::unique_ptr<CriticalSection> m_cs;
};

}
