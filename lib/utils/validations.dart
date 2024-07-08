String? emailTextFieldValidator(String? email) {
  if (email == null || email.isEmpty) return "Email cannot be empty";
  if (!isValidEmail(email)) return "Please enter a valid email";
  return null;
}

String? passwordTextFieldValidator(String? password) {
  if (password == null || password.isEmpty) return "password cannot be empty";
  if (!isValidPasswordPattern(password)) return "Your password should have at least one upper case, number and special characters";
  return null;
}

bool isValidPassword(String? password) {
  return password != null && password.isNotEmpty && password.length >= 8 && isValidPasswordPattern(password);
}

bool isValidEmail(String? email) {
  return email != null && email.isNotEmpty && isValidEmailPattern(email);
}

bool isValidPasswordPattern(String password) {
  Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
  RegExp regex = RegExp(pattern.toString());
  return regex.hasMatch(password);
}

bool isValidEmailPattern(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  return regex.hasMatch(email);
}

String maskCardNumber(String cardNumber) {
  final parts = cardNumber.split(" ");
  return List.filled(parts.length - 1, '.... ').join() + parts.last;
}
