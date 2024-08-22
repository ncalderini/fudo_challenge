import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState({
    this.isMailValid = false,
    this.isPasswordValid = false,
    this.isValid = false,
  });

  final bool isMailValid;
  final bool isPasswordValid;
  final bool isValid;

  LoginState copyWith({
    bool? isMailValid,
    bool? isPasswordValid,
  }) {
    return LoginState(
        isMailValid: isMailValid ?? this.isMailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isValid: (isMailValid ?? this.isMailValid) &&
            (isPasswordValid ?? this.isPasswordValid));
  }

  @override
  List<Object> get props => [isMailValid, isPasswordValid, isValid];
}
