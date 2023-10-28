abstract class SignInEvent {}

class SingInTextChangedEvent extends SignInEvent {
  final String emailValue;
  final String passwordValue;

  SingInTextChangedEvent(this.emailValue, this.passwordValue);
}

class SignInSubmittedEvent extends SignInEvent {
  final String email;
  final String password;

  SignInSubmittedEvent(this.email, this.password);

  
}
