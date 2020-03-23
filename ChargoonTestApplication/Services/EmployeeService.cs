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
            //System.Collections.Generic.List<Models.Employee> employees = new System.Collections.Generic.List<Models.Employee>();

            //Infrastructure.DatabaseConnection.Connection.Open();

            //System.Data.SqlClient.SqlCommand oSqlCommand =
            //    new System.Data.SqlClient.SqlCommand("GetEmployees", Infrastructure.DatabaseConnection.Connection);

            //oSqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

            //System.Data.SqlClient.SqlDataReader oSqlDataReader = oSqlCommand.ExecuteReader();

            //Models.Employee oEmployee = null;

            //if (oSqlDataReader.HasRows)
            //{
            //    while (oSqlDataReader.Read())
            //    {
            //        oEmployee = new Models.Employee();

            //        oEmployee.Id = System.Convert.ToInt32(oSqlDataReader["Id"]);
            //        oEmployee.FirstName = oSqlDataReader["FirstName"].ToString();
            //        oEmployee.LastName = oSqlDataReader["LastName"].ToString();
            //        oEmployee.NationalCode = oSqlDataReader["NationalCode"].ToString();
            //        oEmployee.BirthDate = System.Convert.ToDateTime(oSqlDataReader["BirthDate"]);

            //        employees.Add(oEmployee);
            //    }
            //}

            //oSqlCommand.Dispose();

            //Infrastructure.DatabaseConnection.Connection.Close();


            //return employees;
        }

        public static System.Collections.Generic.List<ViewModels.ListEmployeesViewModel> GetAllWithFullDetails()
        {
            System.Collections.Generic.List<ViewModels.ListEmployeesViewModel> employees = new System.Collections.Generic.List<ViewModels.ListEmployeesViewModel>();

            Infrastructure.DatabaseConnection.Connection.Open();

            System.Data.SqlClient.SqlCommand oSqlCommand =
                new System.Data.SqlClient.SqlCommand("GetEmployeesWithFullDetails", Infrastructure.DatabaseConnection.Connection);

            oSqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

            System.Data.SqlClient.SqlDataReader oSqlDataReader = oSqlCommand.ExecuteReader();

            ViewModels.ListEmployeesViewModel oEmployee = null;

            if (oSqlDataReader.HasRows)
            {
                while (oSqlDataReader.Read())
                {
                    oEmployee = new ViewModels.ListEmployeesViewModel();

                    oEmployee.Id = System.Convert.ToInt32(oSqlDataReader["Id"]);
                    oEmployee.FirstName = oSqlDataReader["FirstName"].ToString();
                    oEmployee.LastName = oSqlDataReader["LastName"].ToString();
                    oEmployee.NationalCode = oSqlDataReader["NationalCode"].ToString();
                    oEmployee.BirthDate = System.Convert.ToDateTime(oSqlDataReader["BirthDate"]);
                    oEmployee.EmploymentDate = System.Convert.ToDateTime(oSqlDataReader["EmploymentDate"]);
                    oEmployee.EmploymentType = oSqlDataReader["EmploymentType"].ToString();

                    employees.Add(oEmployee);
                }
            }

            oSqlCommand.Dispose();

            Infrastructure.DatabaseConnection.Connection.Close();


            return employees;

        }

        public static ViewModels.EditEmployeeViewModel GetWithFullDetails(int id)
        {
            Infrastructure.DatabaseConnection.Connection.Open();

            System.Data.SqlClient.SqlCommand oSqlCommand =
                new System.Data.SqlClient.SqlCommand("GetEmployeeWithFullDetails", Infrastructure.DatabaseConnection.Connection);

            oSqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

            oSqlCommand.Parameters.AddWithValue("@Id", id);

            System.Data.SqlClient.SqlDataReader oSqlDataReader = oSqlCommand.ExecuteReader();

            ViewModels.EditEmployeeViewModel oEmployee = null;

            
            if (oSqlDataReader.HasRows)
            {
                oEmployee = new ViewModels.EditEmployeeViewModel();
                
                while(oSqlDataReader.Read())
                {
                    oEmployee.Id = System.Convert.ToInt32(oSqlDataReader["Id"]);
                    oEmployee.FirstName = oSqlDataReader["FirstName"].ToString();
                    oEmployee.LastName = oSqlDataReader["LastName"].ToString();
                    oEmployee.NationalCode = oSqlDataReader["NationalCode"].ToString();
                    oEmployee.BirthDate = System.Convert.ToDateTime(oSqlDataReader["BirthDate"]);
                    oEmployee.EmploymentDate = System.Convert.ToDateTime(oSqlDataReader["EmploymentDate"]);
                    oEmployee.EmploymentType = oSqlDataReader["EmploymentType"].ToString();
                }
            }

            oSqlCommand.Dispose();

            Infrastructure.DatabaseConnection.Connection.Close();

            return oEmployee;
        }

        public static int CreateEmployee(ViewModels.CreateEmployeeViewModel oViewModel)
        {
            try
            {
                Infrastructure.DatabaseConnection.Connection.Open();

                System.Data.SqlClient.SqlCommand oSqlCommand =
                    new System.Data.SqlClient.SqlCommand("CreateEmployee", Infrastructure.DatabaseConnection.Connection);

                oSqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                oSqlCommand.Parameters.AddWithValue("@FirstName", oViewModel.FirstName);
                oSqlCommand.Parameters.AddWithValue("@LastName", oViewModel.LastName);
                oSqlCommand.Parameters.AddWithValue("@NationalCode", oViewModel.NationalCode);
                oSqlCommand.Parameters.AddWithValue("@BirthDate", System.Convert.ToDateTime(oViewModel.BirthDate));
                oSqlCommand.Parameters.AddWithValue("@EmploymentDate", System.Convert.ToDateTime(oViewModel.EmploymentDate));
                oSqlCommand.Parameters.AddWithValue("@EmploymentTypeId", oViewModel.EmploymentType);              

                System.Data.SqlClient.SqlParameter oSqlParameter = 
                    oSqlCommand.Parameters.Add(new System.Data.SqlClient.SqlParameter("@ResultCode", System.Data.DbType.Int32));

                oSqlParameter.Direction = System.Data.ParameterDirection.Output;

                oSqlCommand.ExecuteNonQuery();

                oSqlCommand.Dispose();

                int result = System.Convert.ToInt32(oSqlCommand.Parameters["@ResultCode"].Value);

                return result;
            }
            catch (System.Exception ex)
            {
                return 3;
            }
            finally
            {
                Infrastructure.DatabaseConnection.Connection.Close();
            }
        }


        public static int UpdateEmployee(ViewModels.UpdateEmployeeViewModel oViewModel)
        {
            try
            {
                Infrastructure.DatabaseConnection.Connection.Open();

                System.Data.SqlClient.SqlCommand oSqlCommand =
                    new System.Data.SqlClient.SqlCommand("UpdateEmployee", Infrastructure.DatabaseConnection.Connection);

                oSqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                oSqlCommand.Parameters.AddWithValue("@Id", oViewModel.Id);
                oSqlCommand.Parameters.AddWithValue("@FirstName", oViewModel.FirstName);
                oSqlCommand.Parameters.AddWithValue("@LastName", oViewModel.LastName);
                oSqlCommand.Parameters.AddWithValue("@NationalCode", oViewModel.NationalCode);
                oSqlCommand.Parameters.AddWithValue("@BirthDate", System.Convert.ToDateTime(oViewModel.BirthDate));
                oSqlCommand.Parameters.AddWithValue("@EmploymentDate", System.Convert.ToDateTime(oViewModel.EmploymentDate));
                oSqlCommand.Parameters.AddWithValue("@EmploymentTypeId", oViewModel.EmploymentType);

                System.Data.SqlClient.SqlParameter oSqlParameter =
                    oSqlCommand.Parameters.Add(new System.Data.SqlClient.SqlParameter("@ResultCode", System.Data.DbType.Int32));

                oSqlParameter.Direction = System.Data.ParameterDirection.Output;

                oSqlCommand.ExecuteNonQuery();

                oSqlCommand.Dispose();

                int result = System.Convert.ToInt32(oSqlCommand.Parameters["@ResultCode"].Value);

                return result;
            }
            catch (System.Exception ex)
            {
                return 3;
            }
            finally
            {
                Infrastructure.DatabaseConnection.Connection.Close();
            }
        }


        public static bool DeleteEmployee(int EmployeeId)
        {
            bool isSucces = false;

            try
            {
                Infrastructure.DatabaseConnection.Connection.Open();

                System.Data.SqlClient.SqlCommand oSqlCommand =
                    new System.Data.SqlClient.SqlCommand("DeleteEmployee", Infrastructure.DatabaseConnection.Connection);

                oSqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                oSqlCommand.Parameters.AddWithValue("@Id", EmployeeId);

                oSqlCommand.ExecuteNonQuery();

                oSqlCommand.Dispose();

                Infrastructure.DatabaseConnection.Connection.Close();
            }
            catch (System.Exception ex)
            {
                isSucces = false;
            }

            isSucces = true;

            return isSucces;
        }

        public static bool IsNationalCodeExists(string NationalCode)
        {
            Infrastructure.DatabaseConnection.Connection.Open();

            System.Data.SqlClient.SqlCommand oSqlCommand =
                new System.Data.SqlClient.SqlCommand("GetEmployeeByNationalCode", Infrastructure.DatabaseConnection.Connection);

            oSqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

            oSqlCommand.Parameters.AddWithValue("@NationalCode", NationalCode);


            System.Data.SqlClient.SqlDataReader oSqlDataReader = oSqlCommand.ExecuteReader();

            if (oSqlDataReader.HasRows)
            {
                oSqlCommand.Dispose();
                Infrastructure.DatabaseConnection.Connection.Close();
                return true;
            }
            else
            {
                oSqlCommand.Dispose();
                Infrastructure.DatabaseConnection.Connection.Close();
                return false;
            }
        }
    }
}