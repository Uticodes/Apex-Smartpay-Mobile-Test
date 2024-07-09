String? emailTextFieldValidator(String? email) {
  if (email == null || email.isEmpty) return "Email cannot be empty";
  if (!isValidEmail(email)) return "Please enter a valid email";
  return null;
}

String? usernameTextFieldValidator(String? username) {
  if (username == null || username.isEmpty) return "Username cannot be empty";
  return null;
}

String? fullNameTextFieldValidator(String? fullName) {
  if (fullName == null || fullName.trim().isEmpty) {
    return 'Full name is required';
  }
  final nameParts = fullName.trim().split(' ');
  if (nameParts.length < 2) {
    return 'Please enter your full name';
  }
  return null;
}


String? passwordTextFieldValidator(String? password) {
  if (password == null || password.isEmpty) return "password cannot be empty";
  if (!isValidPasswordPattern(password)) return "Your password should have at least one upper case, number and special characters";
  return null;
}

bool isValidFullName(String? fullName) {
  if (fullName == null || fullName.isEmpty) {
    return false;
  }

  final nameParts = fullName.trim().split(' ');
  return nameParts.length >= 2;
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
