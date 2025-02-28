part of 'all_user_bloc.dart';

@freezed
class AllUserState with _$AllUserState {
  const factory AllUserState.initial() = _Initial;
  const factory AllUserState.loading() = _Loading;
  const factory AllUserState.success(
    List<Datum> users,
    int currentPage,
    int totalPages,
  ) = _Success;
  const factory AllUserState.error(String message) = _Error;
}
