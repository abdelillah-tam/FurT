import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furt/services/auth/auth_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _rewriterPasswordController;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _rewriterPasswordController = TextEditingController();
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
              children: [
                Flexible(
                  flex: 5,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _firstNameController,
                          cursorColor: const Color.fromRGBO(205, 24, 79, 1.0),
                          style: const TextStyle(fontSize: 13.0),
                          expands: false,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: const TextStyle(fontSize: 13.0),
                            isDense: false,
                            contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(205, 24, 79, 1.0),
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            constraints: BoxConstraints(
                                maxHeight: (height >= 480 && height < 720
                                    ? 40.0
                                    : 60.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _lastNameController,
                          cursorColor: const Color.fromRGBO(205, 24, 79, 1.0),
                          style: TextStyle(fontSize: 13.0),
                          decoration: InputDecoration(
                              hintText: 'Last Name',
                              hintStyle: const TextStyle(fontSize: 13.0),
                              isDense: false,
                              contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(205, 24, 79, 1.0),
                                    width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                              constraints: BoxConstraints(
                                  maxHeight: (height >= 480 && height < 720
                                      ? 40.0
                                      : 60.0))),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
                Flexible(
                  flex: 5,
                  child: TextField(
                    controller: _emailController,
                    cursorColor: const Color.fromRGBO(205, 24, 79, 1.0),
                    style: const TextStyle(fontSize: 13.0),
                    decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        hintStyle: const TextStyle(fontSize: 13.0),
                        isDense: false,
                        contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(205, 24, 79, 1.0),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        constraints: BoxConstraints(
                            maxHeight:
                                (height >= 480 && height < 720 ? 40.0 : 60.0))),
                  ),
                ),
                const Spacer(flex: 2),
                Flexible(
                  flex: 5,
                  child: TextField(
                    controller: _passwordController,
                    cursorColor: const Color.fromRGBO(205, 24, 79, 1.0),
                    style: const TextStyle(fontSize: 13.0),
                    keyboardType: TextInputType.visiblePassword,
                    enableSuggestions: false,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Create a New Password',
                        hintStyle: const TextStyle(fontSize: 13.0),
                        isDense: false,
                        contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(205, 24, 79, 1.0),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        constraints: BoxConstraints(
                            maxHeight:
                                (height >= 480 && height < 720 ? 40.0 : 60.0))),
                  ),
                ),
                const Spacer(flex: 2),
                Flexible(
                  flex: 5,
                  child: TextField(
                    controller: _rewriterPasswordController,
                    cursorColor: const Color.fromRGBO(205, 24, 79, 1.0),
                    style: const TextStyle(fontSize: 13.0),
                    keyboardType: TextInputType.visiblePassword,
                    enableSuggestions: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Rewrite Your Password',
                      hintStyle: const TextStyle(fontSize: 13.0),
                      isDense: false,
                      contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(205, 24, 79, 1.0),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      constraints: BoxConstraints(
                          maxHeight:
                              (height >= 480 && height < 720 ? 40.0 : 60.0)),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 8,
                ),
                Flexible(
                  flex: 5,
                  child: ElevatedButton(
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      context
                          .read<AuthCubit>()
                          .signUp(email: email, password: password);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(205, 24, 79, 1.0),
                        minimumSize: (height >= 480 && height < 720)
                            ? const Size(double.infinity, 50.0)
                            : const Size(double.infinity, 60.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        )),
                    child: const Text('Create Profile'),
                  ),
                ),
                const Spacer(flex: 1),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Flexible(
                        child: Divider(
                          endIndent: 10.0,
                          thickness: 1.5,
                          color: Color.fromRGBO(113, 113, 113, 1.0),
                        ),
                      ),
                      Text('Or'),
                      Flexible(
                        child: Divider(
                          indent: 10.0,
                          thickness: 1.5,
                          color: Color.fromRGBO(113, 113, 113, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.facebook_rounded,
                          size: 40.0,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.apple_rounded,
                          size: 40.0,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(flex: 4),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Color.fromRGBO(113, 113, 113, 1.0)),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(205, 24, 79, 0.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                    child: const Text(
                      'Log In',
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
