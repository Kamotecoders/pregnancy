import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pregnancy/blocs/auth/login_bloc.dart';
import 'package:pregnancy/views/auth/get_started.dart';
import 'package:pregnancy/views/auth/login.dart';
import 'package:pregnancy/views/auth/sign_up.dart';
import 'package:pregnancy/views/home/home.dart';

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
        redirect: (BuildContext context, GoRouterState state) {
          final authBloc = context.read<LoginBloc>();
          final authState = authBloc.state;
          final bool matchedLocation = state.matchedLocation == '/login';
          if (authState is LoginBlocUnAuthenticated) {
            return matchedLocation ? null : '/login';
          }
          if (matchedLocation) {
            if (authState is LoginBlocAuthenticated) {
              return "/home";
            }
            if (authState is LoginBlocUnAuthenticated) {
              return "/login";
            }
          }
          return null;
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
    ],
  );
}
