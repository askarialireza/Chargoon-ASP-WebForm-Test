namespace Infrastructure.RegularExpressions
{
    public static class Patterns
    {
        static Patterns()
        {

        }

        // |     ==> Or
        // \d    ==> Digit

        // {n}   ==> n times
        // {n,m} ==> n to m times

        // a+    ==> One or more a
        // a*    ==> Zero or more a

        // $     ==> End of string
        // ^     ==> Start of string

        public const string IranMobilePhoneNumber = @"(^(09|9)[1][1-9]\d{7}$)|(^(09|9)[3][0-9]\d{7}$)|(^(09|9)[0][1-3]\d{7}$)|(^(09|9)[2][0-3]\d{7}$)";

        public const string PersianDate = @"[1-4]\d{3}\/((0?[1-6]\/((3[0-1])|([1-2][0-9])|(0?[1-9])))|((1[0-2]|(0?[7-9]))\/(30|([1-2][0-9])|(0?[1-9]))))";

        public const string NumbersOnly = "^[0-9]*$";

        public const string Integer = @"(\+|-)?\d+";

        public const string NationalCode = @"\d{10}";

        public const string Money = @"\d+(.\d{0,2})?";

        public const string CellPhoneNumber = @"\d{14}";

        public const string ZeroOrUnsignedInteger = @"\d+";

        public const string Password = @"[a-zA-Z0-9_]{8,40}";

        public const string Username = @"[a-zA-Z0-9_]{3,20}";

        public const string FileName = @"[a-zA-Z0-9_]{1,100}";

        public const string Percentage = @"100(.0{0,2})?|\d{1,2}(.\d{1,2})?";

        public const string Email = @"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*";
    }
}