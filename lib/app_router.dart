import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:pregnancy/models/user.dart';

import 'package:pregnancy/views/auth/forgot_password.dart';
import 'package:pregnancy/views/auth/get_started.dart';

import 'package:pregnancy/views/auth/login.dart';
import 'package:pregnancy/views/auth/sign_up.dart';

import 'package:pregnancy/views/profile/change_password.dart';
import 'package:pregnancy/views/profile/edit_profile.dart';

import 'package:pregnancy/widgets/navigation.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const GetStarted();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPasswordPage();
        },
      ),
      GoRoute(
        name: 'edit-profile',
        path: '/edit-profile/:users',
        builder: (BuildContext context, GoRouterState state) {
          print(state.pathParameters['users']);
          Map<String, dynamic> pathParameters =
              json.decode(state.pathParameters['users']!);

          return EditProfilePage(users: Users.fromJson(pathParameters));
        },
      ),
      GoRoute(
        name: 'change-password',
        path: '/change-password/:users',
        builder: (BuildContext context, GoRouterState state) {
          print(state.pathParameters['users']);
          Map<String, dynamic> pathParameters =
              json.decode(state.pathParameters['users']!);
          return ChangePasswordPage(users: Users.fromJson(pathParameters));
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const MainNavigation();
        },
      ),
    ],
  );
}


  // redirect: (BuildContext context, GoRouterState state) {
  //     final authBloc = context.read<AuthBloc>();
  //     final authState = authBloc.state;
  //     print(authState);
  //     final bool matchedLocation = state.matchedLocation == '/login';
  //     if (authState is UnAuthenticatedState) {
  //       return matchedLocation ? null : '/login';
  //     }
  //     if (matchedLocation) {
  //       if (authState is AuthenticatedState) {
  //         return "/home";
  //       }
  //       if (authState is UnAuthenticatedState) {
  //         return "/login";
  //       }
  //     }
  //     return null;
  //   },