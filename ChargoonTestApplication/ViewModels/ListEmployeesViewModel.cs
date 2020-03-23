namespace ViewModels
{
    public class ListEmployeesViewModel
    {
        public ListEmployeesViewModel()
        {

        }

        public int Id { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string NationalCode { get; set; }

        public System.DateTime BirthDate { get; set; }

        public System.DateTime EmploymentDate { get; set; }

        public string EmploymentType { get; set; }

    }
}