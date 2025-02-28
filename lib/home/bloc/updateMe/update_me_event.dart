part of 'update_me_bloc.dart';

@freezed
class UpdateMeEvent with _$UpdateMeEvent {
  const factory UpdateMeEvent.started() = _Started;
  const factory UpdateMeEvent.update({
    required String id,
    required String username,
  }) = _Update;
}
