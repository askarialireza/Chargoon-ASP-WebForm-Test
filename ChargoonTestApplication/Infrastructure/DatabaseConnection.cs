

namespace Infrastructure
{
    public static class DatabaseConnection : System.Object
    {
        static DatabaseConnection()
        {
            ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ChargoonTestDB"].ConnectionString;

            if (Connection == null)
            {
                Connection = new System.Data.SqlClient.SqlConnection(ConnectionString);
            }
        }

        public static string ConnectionString { get; set; }


        public static System.Data.SqlClient.SqlConnection Connection { get; set; }
    }
}