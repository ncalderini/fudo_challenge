import 'package:bloc/bloc.dart';
import 'package:fudo_challenge/presentation/login/bloc/login_event.dart';
import 'package:fudo_challenge/presentation/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<Submitted>(_onSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        isMailValid: event.email == "challenge@fudo.com",
      ),
    );
}

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        isPasswordValid: event.password == "password",
      ),
    );
  }

  Future<void> _onSubmitted(Submitted event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      try {
        // set authenticated = true
        // emit success state
      } catch (_) {
        // emit error state
      }
    }
  }
}
