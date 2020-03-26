using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ChargoonTestApplication.Pages.EmploymentType
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod]
        public static int EditEmploymentType(int id, string name, bool isActive)
        {
            Models.EmploymentType employmentType = new Models.EmploymentType
            {
                Id = id,
                Name = name,
                IsActive = isActive
            };

            if (string.IsNullOrWhiteSpace(employmentType.Name) == true)
            {
                return 1;
            }
            else
            {
                return (Services.EmploymentTypeService.UpdateEmploymentType(employmentType));
            }
        }

        [System.Web.Services.WebMethod]
        public static bool DeleteEmploymentType(int id)
        {
            if (Services.EmploymentTypeService.DeleteEmploymentType(id) == true)
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