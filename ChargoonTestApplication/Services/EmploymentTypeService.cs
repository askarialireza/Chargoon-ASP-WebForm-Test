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

        public static System.Collections.Generic.IEnumerable<Models.EmploymentType> GetActives()
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                var varList = connection.Query<Models.EmploymentType>
                    ("GetActiveEmploymentTypes", commandType: System.Data.CommandType.StoredProcedure);

                return varList;
            }
        }

        public static int CreateEmploymentType(Models.EmploymentType model)
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                int result = 2;

                Dapper.DynamicParameters parameters = new Dapper.DynamicParameters();

                parameters.Add("@Name", model.Name);
                parameters.Add("@IsActive", model.IsActive);
                parameters.Add("@ResultCode", result, direction: System.Data.ParameterDirection.Output);

                connection.Execute("CreateEmploymentType", param: parameters, commandType: System.Data.CommandType.StoredProcedure);

                result = parameters.Get<int>("@ResultCode");

                return result;
            }
        }

        public static int UpdateEmploymentType(Models.EmploymentType employmentType)
        {

            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                int result = 1;

                Dapper.DynamicParameters parameters = new Dapper.DynamicParameters();

                parameters.Add("@Id", employmentType.Id);
                parameters.Add("@Name", employmentType.Name);
                parameters.Add("@IsActive", employmentType.IsActive);
                parameters.Add("@ResultCode", result, direction: System.Data.ParameterDirection.Output);

                connection.Execute("UpdateEmploymentType", param: parameters, commandType: System.Data.CommandType.StoredProcedure);

                result = parameters.Get<int>("@ResultCode");

                return result;
            }
        }

        public static bool DeleteEmploymentType(int employmentTypeId)
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                int rows = connection.Execute("DeleteEmploymentType", param: new { Id = employmentTypeId }, commandType: System.Data.CommandType.StoredProcedure);

                if (rows != 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }
    }
}