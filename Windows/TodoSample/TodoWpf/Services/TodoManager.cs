using System;
using System.Threading.Tasks;
using TodoWpf.Services.Interop;

namespace TodoWpf.Services
{
    public sealed class TodoManager : IDisposable
    {
        public Task<bool> Connect()
        {
            return Task.Factory.StartNew(() => TodoManagerDll.Connect());
        }

        public TodoItem CreateItem()
        {
            TodoItem item = default(TodoItem);
            TodoManagerDll.CreateItem(ref item);
            return item;
        }

        public TodoItem[] GetItems()
        {
            var todoItems = new TodoItem[0];
            var length = TodoManagerDll.GetItems(todoItems, todoItems.Length);
            
            while (length > todoItems.Length)
            {
                todoItems = new TodoItem[length];
                length = TodoManagerDll.GetItems(todoItems, todoItems.Length);
            }

            return todoItems;
        }

        public void Dispose()
        {
            if (_isDisposed)
                return;

            _isDisposed = true;
            TodoManagerDll.Close();
        }

        private bool _isDisposed;
    }
}
