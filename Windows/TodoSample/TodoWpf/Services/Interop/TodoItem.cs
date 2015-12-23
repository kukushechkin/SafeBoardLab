using System;
using System.Runtime.InteropServices;
using TodoWpf.Common;

namespace TodoWpf.Services.Interop
{
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct TodoItem
    {
        public int Id;

        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 256)]
        public string Title;

        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 1024)]
        public string Description;

        public long DueDateUtcRaw;

        public DateTime DueDate
        {
            get { return DateTimeConversion.ToCSharpTime(DueDateUtcRaw); }
            set { DueDateUtcRaw = DateTimeConversion.ToUnixtime(value); }
        }

        public override string ToString()
        {
            return string.Format("[Id: {0}; Title: \"{1}\"; Description: \"{2}\"; DueDate: {3}]", Id, Title, Description, DueDate);
        }
    }
}
