import 'package:astro_front/data/datasources/get_user_datasources.dart';
import 'package:astro_front/data/models/all_user_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_user_event.dart';
part 'all_user_state.dart';
part 'all_user_bloc.freezed.dart';

class AllUserBloc extends Bloc<AllUserEvent, AllUserState> {
  final GetUserDataSources getUserDataSources;
  List<Datum> users = []; // Store fetched users
  int currentPage = 1;
  int totalPages = 1;
  bool isLoadingMore = false;
  String currentSearch = '';

  AllUserBloc(this.getUserDataSources) : super(const _Initial()) {
    on<_FetchAllUsers>((event, emit) async {
      if (isLoadingMore) return;
      isLoadingMore = true;

      if (event.page == 1 || event.search != currentSearch) {
        users.clear();
        currentSearch = event.search ?? "";
        emit(const AllUserState.loading());
      }

      final result = await getUserDataSources.getAllUsers(
        page: event.page,
        search: currentSearch,
      );
      isLoadingMore = false;

      result.fold((error) => emit(AllUserState.error(error)), (allUsers) {
        users.addAll(allUsers.data ?? []);
        currentPage = allUsers.pagination?.current ?? event.page;
        totalPages = allUsers.pagination?.totalPages ?? 1;

        emit(AllUserState.success(users, currentPage, totalPages));
      });
    });
  }
}
