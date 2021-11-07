class Email {
  Email(this.emailAddress);

  String emailAddress;

  static bool validate(String emailAddress, {bool allowEmpty = true}) {
    final validEmail = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (emailAddress != '') {
      return validEmail.hasMatch(emailAddress);
    }
    return allowEmpty;
  }
}

class Password {
  Password(this.password);

  String password;

  static bool validate(String password, {bool allowEmpty = true}) {
    if (password != '') {
      if (password.length >= 6) {
        return true;
      }
      return false;
    }
    return allowEmpty;
  }
}

class Username {
  Username(this.username);

  String username;

  static bool validate(String username, {bool allowEmpty = true}) {
    if (username != '') {
      if (username.length >= 3) {
        return true;
      }
      return false;
    }
    return allowEmpty;
  }
}

String capitalize(String str) {
  return str.toUpperCase().substring(0, 1) + str.toLowerCase().substring(1);
}
