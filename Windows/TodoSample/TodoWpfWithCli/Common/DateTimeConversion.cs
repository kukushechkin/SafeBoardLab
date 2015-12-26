using System;

namespace TodoWpf.Common
{
    public static class DateTimeConversion
    {
        public static DateTime ToCSharpTime(long unixTime)
        {
            var unixStartTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);

            return unixStartTime.AddSeconds(Convert.ToDouble(unixTime));
        }

        public static long ToUnixtime(DateTime date)
        {
            var unixStartTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
            var timeSpan = date - unixStartTime;

            return Convert.ToInt64(timeSpan.TotalSeconds);
        }
    }
}
