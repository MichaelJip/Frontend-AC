part of 'verify_bloc.dart';

@freezed
class VerifyState with _$VerifyState {
  const factory VerifyState.initial() = _Initial;
  const factory VerifyState.loading() = _Loading;
  const factory VerifyState.success(
    VerifyOtpResponseModel verifyOtpResponseModel,
  ) = _Success;
  const factory VerifyState.error(String message) = _Error;
}
