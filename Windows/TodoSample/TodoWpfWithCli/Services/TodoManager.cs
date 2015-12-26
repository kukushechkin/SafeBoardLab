using System;
using System.Threading.Tasks;
using TodoInterop;

namespace TodoWpf.Services
{
    public sealed class TodoManager : IDisposable
    {
        public TodoManager(TodoManagerInterop nativeTodoManager)
        {
            _nativeTodoManager = nativeTodoManager;
        }

        public Task<bool> Connect()
        {
            return Task.Factory.StartNew(() => _nativeTodoManager.Connect());
        }

        public TodoItem CreateItem()
        {
            return _nativeTodoManager.CreateItem();
        }

        public TodoItem[] GetItems()
        {
            return _nativeTodoManager.GetItems();
        }

        public void Dispose()
        {
            if (_isDisposed)
                return;

            _isDisposed = true;
            _nativeTodoManager.Close();
        }

        private bool _isDisposed;
        private TodoManagerInterop _nativeTodoManager;
    }
}
