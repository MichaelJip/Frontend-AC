import 'package:astro_front/core/constants/variables.dart';
import 'package:astro_front/data/datasources/auth_local_datasources.dart';
import 'package:astro_front/data/datasources/auth_remote_datasources.dart';
import 'package:astro_front/data/datasources/get_user_datasources.dart';
import 'package:astro_front/home/bloc/alluser/all_user_bloc.dart';
import 'package:astro_front/home/bloc/deleteMe/deleteme_bloc.dart';
import 'package:astro_front/home/bloc/me/me_bloc.dart';
import 'package:astro_front/home/bloc/updateMe/update_me_bloc.dart';
import 'package:astro_front/home/pages/main_page.dart';
import 'package:astro_front/presentation/auth/bloc/forgetpassword/forget_password_bloc.dart';
import 'package:astro_front/presentation/auth/bloc/login/login_bloc.dart';
import 'package:astro_front/presentation/auth/bloc/register/register_bloc.dart';
import 'package:astro_front/presentation/auth/bloc/verify/verify_bloc.dart';
import 'package:astro_front/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authLocalDatasource =
      AuthLocalDatasource(); // Instantiate AuthLocalDatasource

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => LoginBloc(
                AuthRemoteDataSources(http.Client(), authLocalDatasource),
              ),
        ),
        BlocProvider(
          create:
              (context) => RegisterBloc(
                AuthRemoteDataSources(http.Client(), authLocalDatasource),
              ),
        ),
        BlocProvider(
          create:
              (context) => ForgetPasswordBloc(
                AuthRemoteDataSources(http.Client(), authLocalDatasource),
              ),
        ),
        BlocProvider(
          create:
              (context) => VerifyBloc(
                AuthRemoteDataSources(http.Client(), authLocalDatasource),
              ),
        ),
        BlocProvider(
          create:
              (context) => AllUserBloc(
                GetUserDataSources(http.Client(), authLocalDatasource),
              ),
        ),
        BlocProvider(
          create:
              (context) => MeBloc(
                GetUserDataSources(http.Client(), authLocalDatasource),
              ),
        ),
        BlocProvider(
          create:
              (context) => UpdateMeBloc(
                AuthRemoteDataSources(http.Client(), authLocalDatasource),
              ),
        ),
        BlocProvider(
          create:
              (context) => DeletemeBloc(
                AuthRemoteDataSources(http.Client(), authLocalDatasource),
              ),
        ),
      ],
      child: MaterialApp(
        title: Variables.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: FutureBuilder<bool>(
          future: AuthLocalDatasource().isAuthExists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return MainPage();
              } else {
                return const LoginPage();
              }
            }
            return const Scaffold(body: Center(child: Text('Error')));
          },
        ),
      ),
    );
  }
}
