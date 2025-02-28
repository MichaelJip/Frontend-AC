import 'package:astro_front/data/datasources/auth_remote_datasources.dart';
import 'package:astro_front/data/models/forget_password_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';
part 'forget_password_bloc.freezed.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final AuthRemoteDataSources authRemoteDataSources;
  ForgetPasswordBloc(this.authRemoteDataSources) : super(_Initial()) {
    on<_ForgetPassword>((event, emit) async {
      emit(const _Loading());
      final result = await authRemoteDataSources.forgetPassword(event.email);
      result.fold(
        (err) => emit(_Error(err)),
        (success) => emit(_Success(success)),
      );
    });
  }
}
