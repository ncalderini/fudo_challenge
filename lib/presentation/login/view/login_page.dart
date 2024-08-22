import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_challenge/domain/usecase/login_user.dart';
import 'package:fudo_challenge/presentation/login/bloc/login_bloc.dart';
import 'package:fudo_challenge/presentation/login/bloc/login_event.dart';
import 'package:fudo_challenge/presentation/login/bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(loginUserUseCase: const LoginUserUseCase()),
        child: const LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: const Text('Login Success',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade600,
            ));
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(state.error,
                  style: const TextStyle(color: Colors.white)),
              backgroundColor: Colors.red.shade600,
            ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 32),
              SizedBox(
                height: 150,
                width: 250,
                child: Image.asset('assets/images/fudo_logo.png'),
              ),
              const SizedBox(height: 32),
              const EmailInput(),
              const PasswordWidget(),
              const SizedBox(height: 32),
              const LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isFormValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      onPressed: isFormValid
          ? () => context.read<LoginBloc>().add(const Submitted())
          : null,
      child: const Text('Login'),
    );
  }
}

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({super.key});

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  late bool _obscurePassword;

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    final validPassword =
        context.select((LoginBloc bloc) => bloc.state.isPasswordValid);

    return TextFormField(
      onChanged: (value) =>
          context.read<LoginBloc>().add(PasswordChanged(password: value)),
      decoration: InputDecoration(
        icon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon:
              Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        labelText: 'Password',
      ),
      obscureText: _obscurePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: false,
      validator: (_) {
        return validPassword ? null : "Invalid Password";
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final emailValid =
        context.select((LoginBloc bloc) => bloc.state.isMailValid);

    return TextFormField(
        onChanged: (value) =>
            context.read<LoginBloc>().add(EmailChanged(email: value)),
        decoration: const InputDecoration(
          icon: Icon(Icons.email),
          labelText: 'Email',
        ),
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        validator: (_) {
          return emailValid ? null : "Invalid Email";
        });
  }
}
