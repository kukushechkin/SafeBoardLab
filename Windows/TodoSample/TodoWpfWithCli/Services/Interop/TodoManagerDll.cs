using System.Runtime.InteropServices;

namespace TodoWpf.Services.Interop
{
    public static class TodoManagerDll
    {
        [DllImport(TodoManagerLib)]
        public static extern bool Connect();

        [DllImport(TodoManagerLib)]
        public static extern void Close();

        [DllImport(TodoManagerLib, CallingConvention = CallingConvention.Cdecl)]
        public static extern void CreateItem(ref TodoItem todoItem);

        [DllImport(TodoManagerLib, CallingConvention = CallingConvention.Cdecl)]
        public static extern int GetItems([MarshalAs(UnmanagedType.LPArray)][Out] TodoItem[] todoItems, long itemsLength);

        private const string TodoManagerLib = "todo.dll";
    }
}
