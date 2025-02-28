part of 'me_bloc.dart';

@freezed
class MeEvent with _$MeEvent {
  const factory MeEvent.started() = _Started;
  const factory MeEvent.fetchMe() = _FetchMe;
}