namespace OrdersAPI.Data.Helpers
{
    public static class Encrypt
    {
        public static string EncryptPassword(string userName, string password)
        {
            return BCrypt.Net.BCrypt.HashPassword(userName + password);
        }

        public static bool VerifyHashedPassword(string userName, string providedPassword, string hashedPassword)
        {
            var isValid = BCrypt.Net.BCrypt.Verify(userName + providedPassword, hashedPassword);

            if (isValid)
            {
                return true;
            }

            return false;
        }
    }
}