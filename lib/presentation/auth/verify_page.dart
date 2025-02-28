import 'package:astro_front/core/components/buttons.dart';
import 'package:astro_front/core/components/custom_text_field.dart';
import 'package:astro_front/core/components/spaces.dart';
import 'package:astro_front/core/constants/colors.dart';
import 'package:astro_front/core/constants/variables.dart';
import 'package:astro_front/presentation/auth/bloc/verify/verify_bloc.dart';
import 'package:astro_front/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPage extends StatefulWidget {
  final String email;

  const VerifyPage({super.key, required this.email});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    newPasswordController.dispose();
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
          const SpaceHeight(12.0),
          const Center(
            child: Text(
              "Check your email for the OTP",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: TextEditingController(text: widget.email),
            label: 'Email',
            readOnly: true,
          ),
          const SpaceHeight(12.0),
          CustomTextField(controller: otpController, label: 'OTP'),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: newPasswordController,
            label: 'New Password',
            obscureText: true,
          ),
          const SpaceHeight(24.0),
          BlocListener<VerifyBloc, VerifyState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (verifyResponseModel) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
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
            child: BlocBuilder<VerifyBloc, VerifyState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.filled(
                      onPressed: () {
                        context.read<VerifyBloc>().add(
                          VerifyEvent.verify(
                            email: widget.email,
                            otp: otpController.text,
                            newPassword: newPasswordController.text,
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
