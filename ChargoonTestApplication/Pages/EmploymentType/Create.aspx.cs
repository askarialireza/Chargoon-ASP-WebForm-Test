using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ChargoonTestApplication.Pages.EmploymentType
{
    public partial class Create : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack != true)
            {
                Infrastructure.Validation.ErrorMessages.Clear();

                Infrastructure.Validation.ModelIsValid = true;
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            Models.EmploymentType employmentType = new Models.EmploymentType()
            {
                IsActive = System.Convert.ToBoolean(IsActiveRadioButtonList.SelectedValue),
                Name = NameTextBox.Text.Trim(),
            };

            Infrastructure.Validation.ValidateModel(employmentType);

            if (IsPostBack == true && Infrastructure.Validation.ModelIsValid == true)
            {
                int result = Services.EmploymentTypeService.CreateEmploymentType(employmentType);

                switch (result)
                {
                    case 0:
                        {
                            {
                                System.Web.HttpContext.Current.Response.RedirectToRoute("IndexEmploymentTypes");
                                break;
                            }
                        }
                    case 1:
                        {
                            Infrastructure.Validation.ErrorMessages.Add(Resources.EmploymentTypeCreate.NameNotValid);
                            break;
                        }
                    default:
                        break;
                }
            }
        }
    }
}