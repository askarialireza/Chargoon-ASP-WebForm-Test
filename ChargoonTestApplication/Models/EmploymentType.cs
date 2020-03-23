namespace Models
{
    public class EmploymentType : BaseEntity
    {
        public EmploymentType() : base()
        {

        }

        public string Name { get; set; }

        public bool IsActive { get; set; }
    }
}