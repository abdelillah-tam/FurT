import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furt/services/auth/auth_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailOrPhoneController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailOrPhoneController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Flexible(
                  flex: 6,
                  child: TextField(
                    controller: _emailOrPhoneController,
                    cursorColor: const Color.fromRGBO(205, 24, 79, 1.0),
                    style: const TextStyle(fontSize: 13.0),
                    decoration: InputDecoration(
                      hintText: 'Email Or Phone Number',
                      hintStyle: const TextStyle(fontSize: 13.0),
                      isDense: false,
                      contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(205, 24, 79, 1.0),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                      constraints: BoxConstraints(
                          maxHeight:
                              (height >= 480 && height < 720 ? 40.0 : 60.0)),
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                Flexible(
                  flex: 6,
                  child: TextField(
                    controller: _passwordController,
                    cursorColor: const Color.fromRGBO(205, 24, 79, 1.0),
                    enableSuggestions: false,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(fontSize: 13.0),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(fontSize: 13.0),
                      isDense: false,
                      contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(205, 24, 79, 1.0),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                      constraints: BoxConstraints(
                          maxHeight:
                              (height >= 480 && height < 720 ? 40.0 : 60.0)),
                    ),
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(205, 24, 79, 0.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Forgotten Password',
                        style: TextStyle(
                          color: Color.fromRGBO(113, 113, 113, 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 23,
                  child: ElevatedButton(
                    onPressed: () {
                      final email = _emailOrPhoneController.text;
                      final password = _passwordController.text;

                      context
                          .read<AuthCubit>()
                          .logIn(email: email, password: password);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(205, 24, 79, 1.0),
                        minimumSize: (height >= 480 && height < 720)
                            ? const Size(double.infinity, 50.0)
                            : const Size(double.infinity, 60.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                        )),
                    child: const Text('Log In'),
                  ),
                ),
                const Spacer(flex: 28),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.facebook_rounded,
                              color: Colors.black,
                              size: 40.0,
                            )),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.apple_rounded,
                            color: Colors.black,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't Have An Account?",
                    style: TextStyle(color: Color.fromRGBO(113, 113, 113, 1.0)),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthCubit>().shoudRegister();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(205, 24, 79, 0.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(9.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
