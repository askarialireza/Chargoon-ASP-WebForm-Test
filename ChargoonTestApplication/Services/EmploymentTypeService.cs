namespace Services
{
    public static class EmploymentTypeService : System.Object
    {
        static EmploymentTypeService()
        {

        }

        public static string GetNameById(int id)
        {
            string result = string.Empty;

            if (Infrastructure.DatabaseConnection.Connection.State == System.Data.ConnectionState.Closed)
            {
                Infrastructure.DatabaseConnection.Connection.Open();
            }

            System.Data.SqlClient.SqlCommand oSqlCommand =
                new System.Data.SqlClient.SqlCommand("GetEmploymentTypeNameById", Infrastructure.DatabaseConnection.Connection);

            oSqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

            oSqlCommand.Parameters.AddWithValue("@Id", id);

            System.Data.SqlClient.SqlDataReader oSqlDataReader = oSqlCommand.ExecuteReader();

            if (oSqlDataReader.HasRows)
            {
                while (oSqlDataReader.Read())
                {
                    result = oSqlDataReader["Name"].ToString();
                }
            }

            oSqlCommand.Dispose();

            Infrastructure.DatabaseConnection.Connection.Close();

            return result;
        }

        public static int GetIdByName(string name)
        {
            int result = 0;

            if (Infrastructure.DatabaseConnection.Connection.State == System.Data.ConnectionState.Closed)
            {
                Infrastructure.DatabaseConnection.Connection.Open();
            }

            System.Data.SqlClient.SqlCommand oSqlCommand =
                new System.Data.SqlClient.SqlCommand("GetEmploymentTypeIdByName", Infrastructure.DatabaseConnection.Connection);

            oSqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

            oSqlCommand.Parameters.AddWithValue("@Name", name);

            System.Data.SqlClient.SqlDataReader oSqlDataReader = oSqlCommand.ExecuteReader();

            if (oSqlDataReader.HasRows)
            {
                while (oSqlDataReader.Read())
                {
                    result = System.Convert.ToInt32(oSqlDataReader["Id"].ToString());
                }
            }

            oSqlCommand.Dispose();

            Infrastructure.DatabaseConnection.Connection.Close();

            return result;
        }

        public static System.Collections.Generic.List<Models.EmploymentType> GetAll()
        {
            System.Collections.Generic.List<Models.EmploymentType> employmentTypes = new System.Collections.Generic.List<Models.EmploymentType>();

            if (Infrastructure.DatabaseConnection.Connection.State == System.Data.ConnectionState.Closed)
            {
                Infrastructure.DatabaseConnection.Connection.Open();
            }


            System.Data.SqlClient.SqlCommand oSqlCommand =
                new System.Data.SqlClient.SqlCommand("GetEmploymentTypes", Infrastructure.DatabaseConnection.Connection);

            oSqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

            System.Data.SqlClient.SqlDataReader oSqlDataReader = oSqlCommand.ExecuteReader();

            Models.EmploymentType oEmploymentType = null;

            if (oSqlDataReader.HasRows)
            {
                while (oSqlDataReader.Read())
                {
                    oEmploymentType = new Models.EmploymentType();

                    oEmploymentType.Id = System.Convert.ToInt32(oSqlDataReader["Id"]);
                    oEmploymentType.IsActive = System.Convert.ToBoolean(oSqlDataReader["IsActive"]);
                    oEmploymentType.Name = oSqlDataReader["Name"].ToString();

                    employmentTypes.Add(oEmploymentType);
                }
            }

            oSqlCommand.Dispose();

            Infrastructure.DatabaseConnection.Connection.Close();

            return employmentTypes;

        }
    }
}