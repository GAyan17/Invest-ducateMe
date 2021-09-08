import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.lightGreen,
              Colors.lightBlue,
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocProvider<LoginFormCubit>(
          create: (_) => LoginFormCubit(),
          child: const _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _EmailInputField(),
        const SizedBox(
          height: 10.0,
        ),
        const _PasswordInputField(),
        const SizedBox(
          height: 10.0,
        ),
        const _LoginButton(),
        const Text('OR'),
        const SizedBox(
          height: 10.0,
        ),
        const _SignUpButton(),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormCubitState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: context.read<LoginFormCubit>().isValid
              ? () {
                  context
                      .read<AuthBloc>()
                      .add(LogIn(state.email.value, state.password.value));
                }
              : null,
          child: const Text('Login'),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      )),
      child: const Text('Sign Up'),
    );
  }
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width < 500
            ? MediaQuery.of(context).size.width * 0.75
            : 450,
        child: BlocBuilder<LoginFormCubit, LoginFormCubitState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (_, state) {
            return TextField(
              onChanged: (value) =>
                  context.read<LoginFormCubit>().emailChanged(value),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                // helperText: 'Enter your Email',
                errorText: state.email.invalid ? 'Invalid Email' : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PasswordInputField extends StatelessWidget {
  const _PasswordInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width < 500
            ? MediaQuery.of(context).size.width * 0.75
            : 450,
        child: BlocBuilder<LoginFormCubit, LoginFormCubitState>(
          buildWhen: (previous, current) =>
              previous.password != current.password,
          builder: (_, state) {
            return TextField(
              onChanged: (value) =>
                  context.read<LoginFormCubit>().passwordChange(value),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                // helperText: 'Enter your Password',

                errorText: state.password.invalid ? 'Invalid Password' : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            );
          },
        ),
      ),
    );
  }
}
