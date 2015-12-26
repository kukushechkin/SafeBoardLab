#pragma once
#include "todo_exports.h"
#include "todo_item.h"
#include <vector>
#include <memory>

namespace std
{
    inline namespace __1
    {
        class mutex;
    }
}

namespace todo_sample
{

typedef std::vector<TodoItem> TodoItemsCollection;
typedef void ItemModifiedCallback(const TodoItemId& id);

class TODO_API TodoManager
{
public:
	TodoManager();
	~TodoManager();

	bool Connect();
	void Close();

	TodoItemsCollection GetItems() const;

	TodoItem CreateItem();
	bool GetItem(const TodoItemId& id, TodoItem& item) const;
	bool UpdateItem(const TodoItem& item);
	bool DeleteItem(const TodoItemId& id);

	void SetAddCallback(ItemModifiedCallback* func);
	void SetUpdatedCallback(ItemModifiedCallback* func);
	void SetDeletedCallback(ItemModifiedCallback* func);

private:
	TodoItemsCollection m_todoItems;

	ItemModifiedCallback* m_addedCallback;
	ItemModifiedCallback* m_updatedCallback;
	ItemModifiedCallback* m_deletedCallback;

	bool m_isConnected;

	TodoItemsCollection::iterator FindItemById(const TodoItemId& id);
	TodoItemsCollection::const_iterator FindItemById(const TodoItemId& id) const;

	mutable std::unique_ptr<std::mutex> m_mutex;
};

}
