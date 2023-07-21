import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/signup/signup_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nuevo usuario'),
        ),
        body: BlocProvider(
          create: (context) => SignupCubit(),
          child: const _SignupView(),
        ));
  }
}

class _SignupView extends StatelessWidget {
  const _SignupView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlutterLogo(size: 100),
              _SignupForm(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignupForm extends StatelessWidget {
  const _SignupForm();

  @override
  Widget build(BuildContext context) {
    final signupCubit = context.watch<SignupCubit>();
    final username = signupCubit.state.username;
    final email = signupCubit.state.email;
    final password = signupCubit.state.password;
    //password.value;

    return Form(
        child: Column(
      children: [
        CustomTextFormField(
          label: 'Nombre de usuario',
          onChanged: signupCubit.usernameChanged,
          errorText: signupCubit.state.neverPosted ? null : username.errorMessage,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          label: 'Correo electrónico',
          onChanged: signupCubit.emailChanged,
          errorText: signupCubit.state.neverPosted ? null : email.errorMessage,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          label: 'Contraseña',
          obscureText: true,
          onChanged: signupCubit.passwordChanged,
          errorText: signupCubit.state.neverPosted ? null : password.errorMessage,
        ),
        const SizedBox(height: 20),
        FilledButton.tonalIcon(
          onPressed: () {
            signupCubit.onSubmit();
          },
          icon: const Icon(Icons.save),
          label: const Text('Crear usuario'),
        ),
      ],
    ));
  }
}
