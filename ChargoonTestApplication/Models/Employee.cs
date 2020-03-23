
namespace Models
{
    public class Employee : BaseEntity
    {
        public Employee()
        {

        }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string NationalCode { get; set; }

        public System.DateTime BirthDate { get; set; }

    }
}