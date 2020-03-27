namespace Models
{
    public class EmploymentType : BaseEntity
    {
        public EmploymentType() : base()
        {

        }


        [System.ComponentModel.DataAnnotations.Display
            (ResourceType = typeof(Resources.Models.EmploymentType),
            Name = "Name")]

        [System.ComponentModel.DataAnnotations.Required(AllowEmptyStrings = false,
            ErrorMessageResourceType = typeof(Resources.Messages),
            ErrorMessageResourceName = "ReqiuredErrorMessage")]
        public string Name { get; set; }

        public bool IsActive { get; set; }
    }
}