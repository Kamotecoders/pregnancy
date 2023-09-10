import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pregnancy/blocs/auth2/auth_bloc.dart';
import 'package:pregnancy/blocs/user/bloc/user_bloc.dart';
import 'package:pregnancy/models/user.dart';
import 'package:pregnancy/repositories/auth_repository.dart';
import 'package:pregnancy/repositories/user_repository.dart';
import 'package:pregnancy/styles/color_pallete.dart';
import 'package:pregnancy/widgets/loading.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passwordIsHidden = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  UserBloc(userRepository: context.read<UserRepository>()),
            ),
          ],
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is UserSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Successfully saved!")));
                context.go('/home');
              }
            },
            builder: (context, state) {
              return state is UserLoadingState
                  ? const Center(
                      child: LoadingDialog(
                        message: "Saving User info",
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Sign up!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35,
                                          color: ColorStyle.primary),
                                    ),
                                    Text(
                                      "This is your first step with us!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: ColorStyle.primary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Image.asset('lib/images/big_baby.png'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Fullname',
                                    hintText: 'Enter your fullname',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your fullname.';
                                    }
                                    return null; // Return null to indicate no error
                                  },
                                ),
                                TextFormField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone #',
                                    hintText: 'Enter your phone',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !value.startsWith("09") ||
                                        value.length != 11) {
                                      return 'Invalid phone number.';
                                    }
                                    return null; // Return null to indicate no error
                                  },
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter your email',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email.';
                                    }
                                    if (RegExp(
                                            r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+//$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email address.';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: passwordIsHidden,
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password.';
                                    }
                                    if (value.length < 7) {
                                      return 'Password too short add atleast 8 characters.';
                                    }

                                    return null; // Return null to indicate no error
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthErrorState) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(state.message)));
                                    }
                                    if (state is AuthSuccessState<Users>) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Successfully signed up'),
                                        ),
                                      );
                                      context
                                          .read<UserBloc>()
                                          .add(CreateUser(state.data));
                                    }
                                  },
                                  builder: (context, state) {
                                    return state is AuthLoadingState
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      ColorStyle.primary),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  String name =
                                                      _nameController.text;
                                                  String phone =
                                                      _phoneController.text;
                                                  String email =
                                                      _emailController.text;
                                                  String password =
                                                      _passwordController.text;
                                                  context.read<AuthBloc>().add(
                                                        SignUpEvent(name, phone,
                                                            email, password),
                                                      );
                                                }
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Text(
                                                  "Sign up",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: const Text(
                                      "Already Have an account ? Sign in",
                                      style: TextStyle(
                                        color: ColorStyle.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
