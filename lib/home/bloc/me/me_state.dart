part of 'me_bloc.dart';

@freezed
class MeState with _$MeState {
  const factory MeState.initial() = _Initial;
  const factory MeState.loading() = _Loading;
  const factory MeState.success(MeResponseModel meResponseModel) = _Success;
  const factory MeState.error(String message) = _Error;
}
