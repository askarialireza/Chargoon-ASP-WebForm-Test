using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ChargoonTestApplication.Pages.Employee
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod]
        public static bool DeleteEmployee(int id)
        {
            if(Services.EmployeeService.DeleteEmployee(id) == true)
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