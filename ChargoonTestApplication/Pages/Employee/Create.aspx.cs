using System.Linq;

namespace ChargoonTestApplication.Pages.Employee
{
    public partial class Create : System.Web.UI.Page
    {

        public bool NoEmploymentType { get; set; }

        public System.Collections.Generic.List<string> errorMessages = new System.Collections.Generic.List<string>();

        public Create()
        {

        }
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (IsPostBack != true)
            {
                Infrastructure.Validation.ErrorMessages.Clear();

                Infrastructure.Validation.ModelIsValid = true;

                EmploymentType.DataSource = Services.EmploymentTypeService.GetActives();

                EmploymentType.DataBind();

                if (Services.EmploymentTypeService.GetActives().Count() == 0)
                {
                    NoEmploymentType = true;
                }
                else
                {
                    NoEmploymentType = false;
                }
            }
        }

        protected void SubmitButton_Click(object sender, System.EventArgs e)
        {

            ViewModels.CreateEmployeeViewModel oViewModel = new ViewModels.CreateEmployeeViewModel
            {
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
                int result = Services.EmployeeService.CreateEmployee(oViewModel);

                switch (result)
                {
                    case 3:
                        {
                            Infrastructure.Validation.ErrorMessages.Add(Resources.Messages.SubmitErrorMessage);
                            break;
                        }
                    case 2:
                        {
                            Infrastructure.Validation.ErrorMessages.Add(Resources.EmployeeCreate.DateNotValid);
                            break;
                        }
                    case 1:
                        {
                            Infrastructure.Validation.ErrorMessages.Add(Resources.EmployeeCreate.NationalCodeNotValid);
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