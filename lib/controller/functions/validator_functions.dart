bool isAlphabet(String input) {
  final alphabetsRegex = RegExp(r'^[a-zA-Z]+$');
  return alphabetsRegex.hasMatch(input);
}

bool isValidAge(String input) {
  final ageRegex = RegExp(r'^[1-9][0-9]{0,2}$');
  return ageRegex.hasMatch(input);
}

bool isValidPhoneNumber(String input) {
  final phoneNumberRegex = RegExp(r'^[0-9]{10}$');
  return phoneNumberRegex.hasMatch(input);
}


bool functionValidator(function,String input){
   if (function == isValidPhoneNumber) {
      return isValidPhoneNumber(input);
    } else if (function == isAlphabet) {
      return isAlphabet(input);
    } else{
      return isValidAge(input);
    }
}