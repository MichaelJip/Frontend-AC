import 'package:astro_front/data/models/me_response_model.dart';
import 'package:astro_front/home/bloc/me/me_bloc.dart';
import 'package:astro_front/home/bloc/deleteme/deleteme_bloc.dart';
import 'package:astro_front/home/bloc/updateme/update_me_bloc.dart';
import 'package:astro_front/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  String? userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MeBloc>().add(const MeEvent.fetchMe());
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Delete Account"),
            content: const Text(
              "Are you sure you want to delete this account? This action is irreversible.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (userId != null) {
                    context.read<DeletemeBloc>().add(
                      DeletemeEvent.delete(id: userId!),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: BlocBuilder<MeBloc, MeState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (meResponseModel) => _buildProfileUI(meResponseModel),
            error:
                (error) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Failed to load profile data"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed:
                            () => context.read<MeBloc>().add(
                              const MeEvent.fetchMe(),
                            ),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
          );
        },
      ),
    );
  }

  Widget _buildProfileUI(MeResponseModel me) {
    final user = me.data!;
    userId = user.id;
    if (_usernameController.text.isEmpty) {
      _usernameController.text = user.username ?? "No Name";
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              user.username!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Logout"),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _confirmDeleteAccount,
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Delete Account",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
