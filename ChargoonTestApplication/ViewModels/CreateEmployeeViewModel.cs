
namespace ViewModels
{
    public class CreateEmployeeViewModel : System.Object
    {
        public CreateEmployeeViewModel() : base()
        {
        }

        //********************************************************

        [System.ComponentModel.DataAnnotations.Display
            (ResourceType = typeof(Resources.Employee),
            Name = "FirstName")]

        [System.ComponentModel.DataAnnotations.Required(AllowEmptyStrings = false,
            ErrorMessageResourceType = typeof(Resources.Messages),
            ErrorMessageResourceName = "ReqiuredErrorMessage")]
        public string FirstName { get; set; }

        //********************************************************

        [System.ComponentModel.DataAnnotations.Display
            (ResourceType = typeof(Resources.Employee),
            Name = "LastName")]

        [System.ComponentModel.DataAnnotations.Required(AllowEmptyStrings = false,
            ErrorMessageResourceType = typeof(Resources.Messages),
            ErrorMessageResourceName = "ReqiuredErrorMessage")]
        public string LastName { get; set; }

        //********************************************************

        [System.ComponentModel.DataAnnotations.Display
            (ResourceType = typeof(Resources.Employee),
            Name = "NationalCode")]

        [System.ComponentModel.DataAnnotations.RegularExpression
            (pattern: Infrastructure.RegularExpressions.Patterns.NationalCode,
            ErrorMessageResourceType = typeof(Resources.Messages),
            ErrorMessageResourceName = "RegularExpressionErrorMessage")]

        [System.ComponentModel.DataAnnotations.Required(AllowEmptyStrings = false,
            ErrorMessageResourceType = typeof(Resources.Messages),
            ErrorMessageResourceName = "ReqiuredErrorMessage")]
        public string NationalCode { get; set; }

        //********************************************************

        [System.ComponentModel.DataAnnotations.Display
            (ResourceType = typeof(Resources.Employee),
            Name = "BirthDate")]

        [System.ComponentModel.DataAnnotations.Required(AllowEmptyStrings = false,
            ErrorMessageResourceType = typeof(Resources.Messages),
            ErrorMessageResourceName = "ReqiuredErrorMessage")]
        public string BirthDate { get; set; }

        //********************************************************

        [System.ComponentModel.DataAnnotations.Display
            (ResourceType = typeof(Resources.Employment),
            Name = "Date")]

        [System.ComponentModel.DataAnnotations.Required(AllowEmptyStrings = false,
            ErrorMessageResourceType = typeof(Resources.Messages),
            ErrorMessageResourceName = "ReqiuredErrorMessage")]

        public string EmploymentDate { get; set; }

        //********************************************************

        [System.ComponentModel.DataAnnotations.Display
            (ResourceType = typeof(Resources.Employment),
            Name = "Type")]

        public int EmploymentType { get; set; }

        //********************************************************
    }
}