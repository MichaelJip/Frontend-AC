import 'package:astro_front/data/datasources/auth_remote_datasources.dart';
import 'package:astro_front/data/models/delete_user_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deleteme_event.dart';
part 'deleteme_state.dart';
part 'deleteme_bloc.freezed.dart';

class DeletemeBloc extends Bloc<DeletemeEvent, DeletemeState> {
  final AuthRemoteDataSources authRemoteDataSources;
  DeletemeBloc(this.authRemoteDataSources) : super(_Initial()) {
    on<_Delete>((event, emit) async {
      emit(const _Loading());
      final result = await authRemoteDataSources.delete(event.id);
      result.fold(
        (err) => emit(_Error(err)),
        (success) => emit(_Success(success)),
      );
    });
  }
}
