import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:pregnancy/models/modules.dart';
import 'package:pregnancy/models/quiz.dart';
import 'package:pregnancy/models/user.dart';
import 'package:pregnancy/views/admin/pdf_viewer.dart';

import 'package:pregnancy/views/auth/forgot_password.dart';
import 'package:pregnancy/views/auth/get_started.dart';

import 'package:pregnancy/views/auth/login.dart';
import 'package:pregnancy/views/auth/sign_up.dart';

import 'package:pregnancy/views/profile/change_password.dart';
import 'package:pregnancy/views/profile/edit_profile.dart';
import 'package:pregnancy/views/profile/features/assessment.dart';
import 'package:pregnancy/views/profile/features/bump.dart';
import 'package:pregnancy/views/profile/features/growth.dart';
import 'package:pregnancy/views/profile/features/lesson.dart';
import 'package:pregnancy/views/profile/features/names.dart';
import 'package:pregnancy/views/profile/features/quiz.dart';
import 'package:pregnancy/views/profile/features/tools.dart';
import 'package:pregnancy/views/profile/features/view_assessments.dart';
import 'package:pregnancy/views/score/score.dart';

import 'package:pregnancy/widgets/navigation.dart';
import 'package:pregnancy/widgets/view_pdf.dart';

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
      GoRoute(
        path: '/names',
        builder: (BuildContext context, GoRouterState state) {
          return const Names();
        },
      ),
      GoRoute(
        path: '/bump',
        builder: (BuildContext context, GoRouterState state) {
          return const BumpChart();
        },
      ),
      GoRoute(
        path: '/module',
        builder: (BuildContext context, GoRouterState state) {
          final Module module =
              Module.fromJson(state.extra as Map<String, dynamic>);

          return ViewPDF(
            module: module,
          );
        },
      ),
      GoRoute(
        path: '/lesson',
        builder: (BuildContext context, GoRouterState state) {
          return const LessonPage();
        },
      ),
      GoRoute(
        path: '/assessment',
        builder: (BuildContext context, GoRouterState state) {
          return const AssessmentPage();
        },
      ),
      GoRoute(
        path: '/growth',
        builder: (BuildContext context, GoRouterState state) {
          return const GrowthPage();
        },
      ),
      GoRoute(
        path: '/view-assessment',
        builder: (BuildContext context, GoRouterState state) {
          return const ViewAssessmentPage();
        },
      ),
      GoRoute(
        path: '/scores',
        builder: (BuildContext context, GoRouterState state) {
          final extras = state.extra as Map<String, dynamic>;
          final score = extras['score'] ?? 0;
          final List<int> answers =
              extras['answers'] ?? List.generate(20, (index) => -1);
          final List<QuizQuestion> questions = extras['questions'] ?? [];
          return ScorePage(
              score: score, answers: answers, questions: questions);
        },
      ),
      GoRoute(
        path: '/tools',
        builder: (BuildContext context, GoRouterState state) {
          return const ToolsPage();
        },
      ),
      GoRoute(
        path: '/quiz',
        builder: (BuildContext context, GoRouterState state) {
          return const QuizPage();
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