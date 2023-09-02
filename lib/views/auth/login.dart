import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pregnancy/blocs/auth/login_bloc.dart';
import 'package:pregnancy/repositories/auth_repository.dart';
import 'package:pregnancy/styles/color_pallete.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordIsHidden = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  hideThePassword() {
    setState(() {
      passwordIsHidden = !passwordIsHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                          "Hello",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: ColorStyle.primary),
                        ),
                        Text(
                          "Welcome!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: ColorStyle.primary),
                        ),
                      ],
                    ),
                  ), // Add your content here
                ),
                Image.asset('lib/images/big_baby.png'),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: passwordIsHidden,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocProvider(
                    create: (context) => LoginBloc(
                      authRepository: context.read<AuthRepository>(),
                    ),
                    child: BlocListener<LoginBloc, LoginBlocState>(
                      listener: (context, state) {
                        if (state is LoginBlocError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        }
                        if (state is LoginBlocAuthenticated) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Successfully logged in')));
                          context.go('/home');
                        }
                      },
                      child: BlocBuilder<LoginBloc, LoginBlocState>(
                          builder: (context, state) {
                        return state is LoginBlocLoading
                            ? const CircularProgressIndicator()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      var email = _emailController.text;
                                      var password = _passwordController.text;
                                      print('$email $password');
                                      context
                                          .read<LoginBloc>()
                                          .add(SignInEvent(email, password));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 35.0),
                                      child: Text('Login'),
                                    ),
                                  ),
                                ],
                              );
                      }),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        context.push("/signup");
                      },
                      child: const Text(
                        "Sign up?",
                        style: TextStyle(
                            color: ColorStyle.text_primary,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
