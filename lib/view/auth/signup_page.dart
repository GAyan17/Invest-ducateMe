import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
        child: BlocProvider<SignUpFormCubit>(
          create: (_) => SignUpFormCubit(),
          child: const _SignUpForm(),
        ),
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        _NameInputField(),
        SizedBox(
          height: 10.0,
        ),
        _EmailInputField(),
        SizedBox(
          height: 10.0,
        ),
        _PasswordInputField(),
        SizedBox(
          height: 10.0,
        ),
        _ConfirmPasswordInputField(),
        SizedBox(
          height: 10.0,
        ),
        _SignUpButton(),
      ],
    );
  }
}

class _NameInputField extends StatelessWidget {
  const _NameInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width < 500
            ? MediaQuery.of(context).size.width * 0.75
            : 450,
        child: BlocBuilder<SignUpFormCubit, SignUpFormCubitState>(
          buildWhen: (previous, current) => previous.name != current.name,
          builder: (_, state) {
            return TextField(
              onChanged: (value) =>
                  context.read<SignUpFormCubit>().nameChanged(value),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Name',
                // helperText: 'Enter your Name',
                errorText: state.email.invalid ? 'Name cannot be empty' : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width < 500
            ? MediaQuery.of(context).size.width * 0.75
            : 450,
        child: BlocBuilder<SignUpFormCubit, SignUpFormCubitState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (_, state) {
            return TextField(
              onChanged: (value) =>
                  context.read<SignUpFormCubit>().emailChanged(value),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                // helperText: 'Enter your Email',
                errorText: state.email.invalid ? 'Invalid Email' : null,
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
      child: Container(
        width: MediaQuery.of(context).size.width < 500
            ? MediaQuery.of(context).size.width * 0.75
            : 450,
        child: BlocBuilder<SignUpFormCubit, SignUpFormCubitState>(
          buildWhen: (previous, current) =>
              previous.password != current.password,
          builder: (_, state) {
            return TextField(
              onChanged: (value) =>
                  context.read<SignUpFormCubit>().passwordChanged(value),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                // helperText: 'Enter your Password',
                errorText: state.password.invalid
                    ? 'Password must be atleast 8 characters long'
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ConfirmPasswordInputField extends StatelessWidget {
  const _ConfirmPasswordInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width < 500
            ? MediaQuery.of(context).size.width * 0.75
            : 450,
        child: BlocBuilder<SignUpFormCubit, SignUpFormCubitState>(
          buildWhen: (previous, current) =>
              previous.password != current.password ||
              previous.confirmPassword != current.confirmPassword,
          builder: (_, state) {
            return TextField(
              onChanged: (value) =>
                  context.read<SignUpFormCubit>().confirmPasswordChange(value),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                // helperText: 'Enter your Password again ',
                errorText:
                    state.password.invalid ? 'Passwords Do Not Match' : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormCubit, SignUpFormCubitState>(
      builder: (ctx, state) {
        return ElevatedButton(
          onPressed: ctx.read<SignUpFormCubit>().isValid
              ? () {
                  ctx.read<AuthBloc>().add(SignUp(
                        state.name.value,
                        state.email.value,
                        state.password.value,
                      ));
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                }
              : null,
          child: const Text('Sign Up'),
        );
      },
    );
  }
}
