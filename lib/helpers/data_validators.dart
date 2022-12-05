
// Data Validations for forms,like email validation,password rules,phone numbers

class DataValidator{

  // If the value is null or empty
 static String? isNullOrEmpty(String? value){ // "" Empty String
    bool isNullOrEmpty=(value ==null) || value.trim().isEmpty;
    if(isNullOrEmpty) {
      return "Please enter a value";
    }
    return null;
    }

    static String? isValidEmail(String? value){ //We need to check if it's email
       // 1. If it's null or empty
       // 2. It's format is correct == @,[.com/.in/.ae}
     String? isEmptyEmail = isNullOrEmpty(value);
     if(isEmptyEmail != null){
       return isEmptyEmail;
     }
     // Regular Expression
     //
     bool isemailValid = RegExp(
         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
     .hasMatch(value!);
     if(!isemailValid){
       return "Invalid email";
     }
     return null;
    }
   static String? isValidPassword(String? value){
     String? isEmptyPassword = isNullOrEmpty(value);
     if(isEmptyPassword != null){
       return isEmptyPassword;
          }
     bool isPasswordValid = RegExp(
         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,}$')
         .hasMatch(value!);
     if(!isPasswordValid){
       return "Requires one capital,one lower,one number and one special character and min 5";
     }
     return null;

        }
        static String? isMobileValid(String? value){
   String? isEmptyMobile = isNullOrEmpty(value);
   if(isEmptyMobile != null) {
     return isEmptyMobile;
   }
          bool isValidMobile = value!.length ==10;
          if(!isValidMobile){
            return "Mobile number should be 10 character";
          }
          return null;
      }
    }
