import 'package:astro_front/data/datasources/auth_remote_datasources.dart';
import 'package:astro_front/data/models/login_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDataSources authRemoteDataSources;
  LoginBloc(this.authRemoteDataSources) : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      final result = await authRemoteDataSources.login(
        event.identifier,
        event.password,
      );
      result.fold(
        (err) => emit(_Error(err)),
        (success) => emit(_Success(success)),
      );
    });
  }
}
