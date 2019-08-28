class Validation {
  static String validatePass(String pass) {
    if (pass == null) return 'Password invaild';
    if (pass.length < 6) return 'password require minium 6 characters';
    return null;
  }

  static String validateEmail(String email) {
    if (email == null) return 'email invaild';
    var isValid = RegExp(r"^[a-zA-Z0-9]+@+[a-zA-Z0-9]+\.[a-zA-Z0-9]+").hasMatch(email);
    print(isValid);
    return null;
  }

}
