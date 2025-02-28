import 'package:astro_front/data/datasources/auth_remote_datasources.dart';
import 'package:astro_front/data/models/update_profile_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_me_event.dart';
part 'update_me_state.dart';
part 'update_me_bloc.freezed.dart';

class UpdateMeBloc extends Bloc<UpdateMeEvent, UpdateMeState> {
  final AuthRemoteDataSources authRemoteDataSources;
  UpdateMeBloc(this.authRemoteDataSources) : super(_Initial()) {
    on<_Update>((event, emit) async {
      emit(const _Loading());
      final result = await authRemoteDataSources.update(
        event.id,
        event.username,
      );
      result.fold(
        (err) => emit(_Error(err)),
        (success) => emit(_Success(success)),
      );
    });
  }
}
