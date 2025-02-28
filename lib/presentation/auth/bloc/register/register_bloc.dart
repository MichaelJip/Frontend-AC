import 'package:astro_front/data/datasources/auth_remote_datasources.dart';
import 'package:astro_front/data/models/register_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDataSources authRemoteDataSources;
  RegisterBloc(this.authRemoteDataSources) : super(_Initial()) {
    on<_Register>((event, emit) async {
      emit(_Loading());
      final result = await authRemoteDataSources.register(
        event.username,
        event.email,
        event.password,
        event.confirmPassword,
      );
      result.fold(
        (err) => emit(_Error(err)),
        (success) => emit(_Success(success)),
      );
    });
  }
}
