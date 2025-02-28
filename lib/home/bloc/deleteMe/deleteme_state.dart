part of 'deleteme_bloc.dart';

@freezed
class DeletemeState with _$DeletemeState {
  const factory DeletemeState.initial() = _Initial;
  const factory DeletemeState.loading() = _Loading;
  const factory DeletemeState.success(
    DeleteProfileResponseModel deleteProfileResponseModel,
  ) = _Success;
  const factory DeletemeState.error(String message) = _Error;
}
