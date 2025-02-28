import 'package:astro_front/data/datasources/get_user_datasources.dart';
import 'package:astro_front/data/models/me_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'me_event.dart';
part 'me_state.dart';
part 'me_bloc.freezed.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  final GetUserDataSources getUserDataSources;
  MeBloc(this.getUserDataSources) : super(_Initial()) {
    on<_FetchMe>((event, emit) async {
      emit(const MeState.loading());
      final result = await getUserDataSources.getMe();

      result.fold(
        (error) => emit(MeState.error(error)),
        (success) => emit(MeState.success(success)),
      );
    });
  }
}
