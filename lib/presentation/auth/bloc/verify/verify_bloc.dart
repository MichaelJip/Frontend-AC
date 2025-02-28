import 'package:astro_front/data/datasources/auth_remote_datasources.dart';
import 'package:astro_front/data/models/verify_otp_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_event.dart';
part 'verify_state.dart';
part 'verify_bloc.freezed.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final AuthRemoteDataSources authRemoteDataSources;
  VerifyBloc(this.authRemoteDataSources) : super(_Initial()) {
    on<_Verify>((event, emit) async {
      emit(const _Loading());
      final result = await authRemoteDataSources.verify(
        event.email,
        event.otp,
        event.newPassword,
      );
      result.fold(
        (err) => emit(_Error(err)),
        (success) => emit(_Success(success)),
      );
    });
  }
}
