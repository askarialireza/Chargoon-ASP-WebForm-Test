using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ChargoonTestApplication.Pages.Employee
{
    public partial class Edit : System.Web.UI.Page
    {

        public ViewModels.EditEmployeeViewModel Model { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            int employeeId = System.Convert.ToInt32(Page.RouteData.Values["id"]);

            if (Page.IsPostBack != true)
            {
                Infrastructure.Validation.ErrorMessages.Clear();

                Infrastructure.Validation.ModelIsValid = true;

                EmploymentType.DataSource = Services.EmploymentTypeService.GetActives();

                EmploymentType.DataBind();

                Model = Services.EmployeeService.GetWithFullDetails(employeeId);


                if (Model != null)
                {
                    Model.Id = employeeId;
                    FirstName.Text = Model.FirstName;
                    LastName.Text = Model.LastName;
                    BirthDate.Text = Model.BirthDate.ToString("yyyy-MM-dd");
                    NationalCode.Text = Model.NationalCode;
                    EmploymentDate.Text = Model.EmploymentDate.ToString("yyyy-MM-dd");
                    EmploymentType.SelectedValue = Services.EmploymentTypeService.GetIdByName(Model.EmploymentType).ToString();
                }
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {

            ViewModels.UpdateEmployeeViewModel oViewModel = new ViewModels.UpdateEmployeeViewModel
            {
                Id = System.Convert.ToInt32(Page.RouteData.Values["id"]),
                FirstName = FirstName.Text,
                LastName = LastName.Text,
                NationalCode = NationalCode.Text,
                BirthDate = BirthDate.Text,
                EmploymentDate = EmploymentDate.Text,
                EmploymentType = System.Convert.ToInt32(EmploymentType.SelectedValue)
            };

            Infrastructure.Validation.ValidateModel(oViewModel);

            if (IsPostBack == true && Infrastructure.Validation.ModelIsValid == true)
            {
                int result = Services.EmployeeService.UpdateEmployee(oViewModel);

                switch (result)
                {
                    case 2:
                        {
                            Infrastructure.Validation.ErrorMessages.Add(Resources.Messages.DatabaseErrorMessage);
                            break;
                        }
                    case 1:
                        {
                            Infrastructure.Validation.ErrorMessages.Add(Resources.EmployeeEdit.DateNotValid);
                            break;
                        }
                    case 0:
                        {
                            System.Web.HttpContext.Current.Response.RedirectToRoute("IndexEmployees");
                            break;
                        }
                    default:
                        break;
                }
            }
        }
    }
}