import 'package:astro_front/data/models/all_user_response_model.dart';
import 'package:astro_front/home/bloc/alluser/all_user_bloc.dart';
import 'package:astro_front/home/pages/detail_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController =
      TextEditingController(); // Add search controller
  String currentSearch = "";

  @override
  void initState() {
    super.initState();
    _fetchAllUsers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        _fetchNextPage();
      }
    });
  }

  void _fetchAllUsers() {
    context.read<AllUserBloc>().add(
      AllUserEvent.fetchAllUsers(page: 1, search: currentSearch),
    );
  }

  void _fetchNextPage() {
    final state = context.read<AllUserBloc>().state;
    state.maybeWhen(
      success: (users, currentPage, totalPages) {
        if (currentPage < totalPages) {
          context.read<AllUserBloc>().add(
            AllUserEvent.fetchAllUsers(
              page: currentPage + 1,
              search: currentSearch,
            ),
          );
        }
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Dashboard")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search users...",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        currentSearch = _searchController.text;
                      });
                      _fetchAllUsers(); // Fetch users with search term
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<AllUserBloc, AllUserState>(
                builder: (context, state) {
                  return state.when(
                    initial:
                        () => const Center(child: Text("Enter a search query")),
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    success: (users, _, __) => _buildUserList(users),
                    error: (error) => Center(child: Text("Error: $error")),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(List<Datum> users) {
    final blocState = context.read<AllUserBloc>().state;
    bool isLastPage = blocState.maybeWhen(
      success: (_, currentPage, totalPages) => currentPage >= totalPages,
      orElse: () => true,
    );

    return ListView.builder(
      controller: _scrollController,
      itemCount: isLastPage ? users.length : users.length + 1,
      itemBuilder: (context, index) {
        if (index < users.length) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(user.username?[0].toUpperCase() ?? "?"),
            ),
            title: Text(user.username ?? "No name"),
            subtitle: Text(user.email ?? "No email"),
            onTap: () {
              // Navigate to DetailUser with user data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => DetailUser(
                        username: user.username ?? "No name",
                        email: user.email ?? "No email",
                      ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
