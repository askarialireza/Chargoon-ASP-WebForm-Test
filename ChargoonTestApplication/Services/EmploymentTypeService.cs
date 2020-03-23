using Dapper;

namespace Services
{
    public static class EmploymentTypeService : System.Object
    {
        static EmploymentTypeService()
        {

        }

        public static string GetNameById(int id)
        {

            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                string result = string.Empty;

                result = connection.QueryFirstOrDefault<string>
                    ("GetEmploymentTypeNameById", param: new { Id = id }, commandType: System.Data.CommandType.StoredProcedure);

                return result;
            }
        }

        public static int GetIdByName(string name)
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                int result = 0;

                result = connection.QueryFirstOrDefault<int>
                    ("GetEmploymentTypeIdByName", param: new { Name = name }, commandType: System.Data.CommandType.StoredProcedure);

                return result;
            }
        }

        public static System.Collections.Generic.IEnumerable<Models.EmploymentType> GetAll()
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                var varList = connection.Query<Models.EmploymentType>
                    ("GetEmploymentTypes", commandType: System.Data.CommandType.StoredProcedure);

                return varList;
            }
        }
    }
}