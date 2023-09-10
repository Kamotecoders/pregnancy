import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pregnancy/blocs/user/bloc/user_bloc.dart';
import 'package:pregnancy/models/user.dart';
import 'package:pregnancy/repositories/user_repository.dart';
import 'package:pregnancy/styles/color_pallete.dart';

class EditProfilePage extends StatefulWidget {
  final Users users;
  const EditProfilePage({super.key, required this.users});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = "";
  String email = '';
  String phone = '';
  @override
  Widget build(BuildContext context) {
    name = widget.users.name;
    email = widget.users.email;
    phone = widget.users.phone;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.users.email,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  return null;
                },
                onSaved: (value) {
                  email = value ?? "";
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                initialValue: widget.users.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value ?? "";
                  widget.users.name = name;
                },
              ),
              TextFormField(
                initialValue: widget.users.phone,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }

                  return null;
                },
                onSaved: (value) {
                  phone = value ?? "";
                  widget.users.phone = phone;
                },
              ),
              const SizedBox(height: 20.0),
              BlocProvider(
                create: (context) =>
                    UserBloc(userRepository: context.read<UserRepository>()),
                child: BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserSuccessState<String>) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.data),
                        ),
                      );
                      context.pop();
                    }
                    if (state is UserErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UserLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorStyle.primary,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              print(widget.users);
                              context.read<UserBloc>().add(
                                    UpdateUserInfo(widget.users),
                                  );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }
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
