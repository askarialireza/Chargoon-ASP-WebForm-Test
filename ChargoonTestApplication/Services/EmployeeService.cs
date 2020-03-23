using Dapper;
namespace Services
{
    public static class EmployeeService : System.Object
    {
        static EmployeeService()
        {
        }

        public static System.Collections.Generic.IEnumerable<Models.Employee> GetAll()
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                var varList =
                  connection.Query<Models.Employee>("GetEmployees", commandType: System.Data.CommandType.StoredProcedure);

                return varList;
            }
        }

        public static System.Collections.Generic.IEnumerable<ViewModels.ListEmployeesViewModel> GetAllWithFullDetails()
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                var varList =
                  connection.Query<ViewModels.ListEmployeesViewModel>("GetEmployeesWithFullDetails", commandType: System.Data.CommandType.StoredProcedure);

                return varList;
            }
        }

        public static ViewModels.EditEmployeeViewModel GetWithFullDetails(int id)
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                ViewModels.EditEmployeeViewModel model = null;

                model = connection.QueryFirstOrDefault<ViewModels.EditEmployeeViewModel>
                        ("GetEmployeeWithFullDetails", param: new { Id = id }, commandType: System.Data.CommandType.StoredProcedure);

                return model;
            }
        }

        public static int CreateEmployee(ViewModels.CreateEmployeeViewModel oViewModel)
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                int result = 3;

                Dapper.DynamicParameters parameters = new Dapper.DynamicParameters();

                parameters.Add("@FirstName", oViewModel.FirstName);
                parameters.Add("@LastName", oViewModel.LastName);
                parameters.Add("@NationalCode", oViewModel.NationalCode);
                parameters.Add("@BirthDate", System.Convert.ToDateTime(oViewModel.BirthDate));
                parameters.Add("@EmploymentDate", System.Convert.ToDateTime(oViewModel.EmploymentDate));
                parameters.Add("@EmploymentTypeId", oViewModel.EmploymentType);
                parameters.Add("@ResultCode", result, direction: System.Data.ParameterDirection.Output);

                connection.Execute("CreateEmployee", param: parameters, commandType: System.Data.CommandType.StoredProcedure);

                result = parameters.Get<int>("@ResultCode");

                return result;
            }
        }


        public static int UpdateEmployee(ViewModels.UpdateEmployeeViewModel oViewModel)
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                int result = 2;

                Dapper.DynamicParameters parameters = new Dapper.DynamicParameters();

                parameters.Add("@Id", oViewModel.Id);
                parameters.Add("@FirstName", oViewModel.FirstName);
                parameters.Add("@LastName", oViewModel.LastName);
                parameters.Add("@NationalCode", oViewModel.NationalCode);
                parameters.Add("@BirthDate", System.Convert.ToDateTime(oViewModel.BirthDate));
                parameters.Add("@EmploymentDate", System.Convert.ToDateTime(oViewModel.EmploymentDate));
                parameters.Add("@EmploymentTypeId", oViewModel.EmploymentType);
                parameters.Add("@ResultCode", result, direction: System.Data.ParameterDirection.Output);

                connection.Execute("UpdateEmployee", param: parameters, commandType: System.Data.CommandType.StoredProcedure);

                result = parameters.Get<int>("@ResultCode");

                return result;
            }
        }


        public static bool DeleteEmployee(int EmployeeId)
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Infrastructure.DatabaseConnection.ConnectionString))
            {
                int rows = connection.Execute("DeleteEmployee", param: new { Id = EmployeeId }, commandType: System.Data.CommandType.StoredProcedure);

                if(rows != 0)
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