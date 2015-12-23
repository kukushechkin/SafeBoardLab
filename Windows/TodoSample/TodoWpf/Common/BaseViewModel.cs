using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace TodoWpf.Common
{
    public abstract class BaseViewModel : INotifyPropertyChanged
    {
        protected void RaisePropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
        }

        public event PropertyChangedEventHandler PropertyChanged = (sender, args) => { };
    }
}
