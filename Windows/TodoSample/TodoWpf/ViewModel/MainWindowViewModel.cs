using System.Collections.ObjectModel;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using Prism.Commands;
using TodoWpf.Common;
using TodoWpf.Services;
using TodoWpf.Services.Interop;

namespace TodoWpf.ViewModel
{
    public sealed class MainWindowViewModel : BaseViewModel
    {
        public MainWindowViewModel(TodoManager todoManager)
        {
            Items = new ObservableCollection<TodoItem>();

            _addCommand = new DelegateCommand(() =>
            {
                todoManager.CreateItem();
                
                Items.Clear();
                Items.AddRange(todoManager.GetItems());
            }, () => !IsBusy);

            IsBusy = true;
            todoManager.Connect().ContinueWith(task =>
            {
                IsConnected = task.Result;
                IsBusy = false;
            }, TaskScheduler.FromCurrentSynchronizationContext());
        }

        public ICommand AddCommand { get { return _addCommand; }}
        private readonly DelegateCommand _addCommand;

        public bool IsBusy
        {
            get { return _isBusy; }
            private set
            {
                _isBusy = value; 
                RaisePropertyChanged();

                _addCommand.RaiseCanExecuteChanged();
            }
        }
        private bool _isBusy;

        public bool IsConnected
        {
            get { return _isConnected; }
            private set
            {
                _isConnected = value; 
                RaisePropertyChanged();
            }
        }
        private bool _isConnected;

        public ObservableCollection<TodoItem> Items { get; private set; }
    }
}
