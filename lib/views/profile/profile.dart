import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pregnancy/blocs/auth2/auth_bloc.dart';
import 'package:pregnancy/blocs/user/bloc/user_bloc.dart';
import 'package:pregnancy/models/user.dart';
import 'package:pregnancy/repositories/auth_repository.dart';
import 'package:pregnancy/repositories/user_repository.dart';
import 'package:pregnancy/styles/color_pallete.dart';

import 'package:pregnancy/styles/text_styles.dart';
import 'package:pregnancy/widgets/loading.dart';

import 'package:pregnancy/widgets/profile.dart';
import 'package:pregnancy/widgets/profile_action_buttons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(authRepository: context.read<AuthRepository>())
                ..add(UserChangedEvent()),
        ),
        BlocProvider(
          create: (context) =>
              UserBloc(userRepository: context.read<UserRepository>()),
        ),
      ],
      child: Container(
        color: ColorStyle.primary,
        height: double.maxFinite,
        width: double.infinity,
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticatedState) {
                context.go("/");
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return const Center(
                  child: LoadingDialog(
                    message: "Loading",
                  ),
                );
              }
              if (state is AuthErrorState) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is AuthSuccessState<User>) {
                return ProfileInfo(
                  userID: state.data.uid,
                );
              }
              return const Center(
                child: Text("PROFILE PAGE: unknown error"),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<void> _imagePicker(ScaffoldMessengerState scaffoldMessenger) async {
  print("Image picker clicked");
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image != null) {
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('Image Picked'),
      ),
    );
  } else {
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('Error Picking image'),
      ),
    );
  }
}

class ProfileInfo extends StatefulWidget {
  final String userID;
  const ProfileInfo({super.key, required this.userID});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  void initState() {
    context.read<UserBloc>().add(
          GetUserProfile(widget.userID),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState) {
          return const LoadingDialog(
            message: "Getting User Profile",
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is UserSuccessState<Users>) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfileImageWithButton(
                      imageUrl: state.data.photo,
                      onTap: () {
                        _imagePicker(
                          ScaffoldMessenger.of(context),
                        );
                      }),
                ),
                Text(
                  state.data.name,
                  style: MyTextStyles.header,
                ),
                ProfileActionButtons(
                  title: "Edit Profile",
                  onTap: () {
                    context.pushNamed('edit-profile',
                        pathParameters: {'users': json.encode(state.data)});
                  },
                ),
                ProfileActionButtons(
                  title: "Change Password",
                  onTap: () {
                    context.pushNamed('change-password',
                        pathParameters: {'users': json.encode(state.data)});
                  },
                ),
                ProfileActionButtons(
                  title: "My Health Info",
                  onTap: () {},
                ),
                ProfileActionButtons(
                  title: "Notifications",
                  onTap: () {},
                ),
                ProfileActionButtons(
                  title: "Settings",
                  onTap: () {},
                ),
                ProfileActionButtons(
                  title: "Technical Support",
                  onTap: () {},
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    print(state);
                    if (state is AuthSuccessState<String>) {}
                    if (state is AuthErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ProfileActionButtons(
                        title: "Logout",
                        onTap: () {
                          context.read<AuthBloc>().add(
                                LogoutEvent(),
                              );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          );
        }
        return Center(
          child: Text("PROFILE INFO: unkown error"),
        );
      },
    );
  }
}
