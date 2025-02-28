part of 'deleteme_bloc.dart';

@freezed
class DeletemeEvent with _$DeletemeEvent {
  const factory DeletemeEvent.started() = _Started;
  const factory DeletemeEvent.delete({required String id}) = _Delete;
}
