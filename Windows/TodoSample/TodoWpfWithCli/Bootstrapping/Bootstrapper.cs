using System.Windows;
using Microsoft.Practices.Unity;
using Prism.Unity;
using TodoWpf.Services;
using TodoWpf.View;
using TodoWpf.ViewModel;
using TodoInterop;

namespace TodoWpf.Bootstrapping
{
    public sealed class Bootstrapper : UnityBootstrapper
    {
        protected override DependencyObject CreateShell()
        {
            var shell = Container.Resolve<MainWindow>();
            shell.Show();

            return shell;
        }
        
        protected override void ConfigureContainer()
        {
            base.ConfigureContainer();

            Container.RegisterType<TodoManagerInterop>();
            Container.RegisterType<TodoManager>(new ContainerControlledLifetimeManager(),
                new InjectionFactory(c => new TodoManager(c.Resolve<TodoManagerInterop>())));
            Container.RegisterType<MainWindowViewModel>();
            Container.RegisterType<MainWindow>(new InjectionFactory(c => new MainWindow { DataContext = c.Resolve<MainWindowViewModel>() }));
        }
    }
}
