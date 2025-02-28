part of 'all_user_bloc.dart';

@freezed
class AllUserEvent with _$AllUserEvent {
  const factory AllUserEvent.started() = _Started;
  const factory AllUserEvent.fetchAllUsers({
    required int page,
    String? search,
  }) = _FetchAllUsers;
}
