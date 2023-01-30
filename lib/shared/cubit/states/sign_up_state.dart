abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {}

class SignUpErrorState extends SignUpStates {
  final String error;

  SignUpErrorState(this.error);
}

class SignUpCreateNewSuccessState extends SignUpStates {}

class SignUpCreateNewErrorState extends SignUpStates {
  final String error;

  SignUpCreateNewErrorState(this.error);
}

class SignUpChangePasswordVisibilityStates extends SignUpStates {}
