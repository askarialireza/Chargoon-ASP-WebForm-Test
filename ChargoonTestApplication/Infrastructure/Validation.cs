
namespace Infrastructure
{
    public static class Validation
    {
        static Validation()
        {
            ErrorMessages = new System.Collections.Generic.List<string>();
            ModelIsValid = true;
        }

        public static System.Collections.Generic.List<string> ErrorMessages { get; set; }

        public static bool ModelIsValid { get; set; }
        public static void ValidateModel(object model)
        {
            ErrorMessages.Clear();
            ModelIsValid = true;

            var context =
                new System.ComponentModel.DataAnnotations.ValidationContext(model, serviceProvider: null, items: null);

            var results =
                new System.Collections.Generic.List<System.ComponentModel.DataAnnotations.ValidationResult>();

            ModelIsValid = System.ComponentModel.DataAnnotations.Validator.TryValidateObject(model, context, results, true);

            if (!ModelIsValid)
            {
                foreach (var validationResult in results)
                {
                    ErrorMessages.Add(validationResult.ErrorMessage.ToString());
                }

                return;
            }
        }
    }
}