import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pregnancy/blocs/auth2/auth_bloc.dart';
import 'package:pregnancy/models/user.dart';
import 'package:pregnancy/repositories/auth_repository.dart';

class ChangePasswordPage extends StatefulWidget {
  final Users users;
  const ChangePasswordPage({super.key, required this.users});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Current Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }

                  return null;
                },
                onChanged: (value) {
                  oldPassword = value;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                },
                onChanged: (value) {
                  newPassword = value;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != newPassword) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onChanged: (value) {
                  confirmPassword = value;
                },
              ),
              const SizedBox(height: 20.0),
              BlocProvider(
                create: (context) =>
                    AuthBloc(authRepository: context.read<AuthRepository>()),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccessState<String>) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.data),
                        ),
                      );
                      context.pop();
                    }
                    if (state is AuthErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is AuthLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(ReauthenticateUser(
                                    oldPassword, newPassword));
                              }
                            },
                            child: const Text('Change Password'),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
