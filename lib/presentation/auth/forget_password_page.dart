import 'package:astro_front/core/components/buttons.dart';
import 'package:astro_front/core/components/custom_text_field.dart';
import 'package:astro_front/core/components/spaces.dart';
import 'package:astro_front/core/constants/colors.dart';
import 'package:astro_front/core/constants/variables.dart';
import 'package:astro_front/presentation/auth/bloc/forgetpassword/forget_password_bloc.dart';
import 'package:astro_front/presentation/auth/verify_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        children: [
          const SpaceHeight(80.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130.0),
            child: Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
          ),
          const SpaceHeight(1.0),
          const Center(
            child: Text(
              Variables.appName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(controller: emailController, label: 'Email'),
          const SpaceHeight(24.0),
          BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (forgetPasswordResponseModel) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => VerifyPage(email: emailController.text),
                    ),
                  );
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: AppColors.red,
                    ),
                  );
                },
              );
            },
            child: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.filled(
                      onPressed: () {
                        context.read<ForgetPasswordBloc>().add(
                          ForgetPasswordEvent.forgetPassword(
                            email: emailController.text,
                          ),
                        );
                      },
                      label: 'Kirim',
                    );
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
