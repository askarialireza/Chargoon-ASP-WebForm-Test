

namespace Infrastructure
{
    public static class DatabaseConnection : System.Object
    {
        static DatabaseConnection()
        {
            ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ChargoonTestDB"].ConnectionString;
        }

        public static string ConnectionString { get; set; }

    }
}