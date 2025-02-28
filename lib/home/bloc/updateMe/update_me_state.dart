part of 'update_me_bloc.dart';

@freezed
class UpdateMeState with _$UpdateMeState {
  const factory UpdateMeState.initial() = _Initial;
  const factory UpdateMeState.loading() = _Loading;
  const factory UpdateMeState.success(
    UpdateProfileResponseModel updateProfileResponseModel,
  ) = _Success;
  const factory UpdateMeState.error(String message) = _Error;
}
