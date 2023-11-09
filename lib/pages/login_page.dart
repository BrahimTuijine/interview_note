import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_note_app/blocs/login/login_bloc.dart';
import 'package:interview_note_app/core/animated_navigation/bouncy_page_route.dart';
import 'package:interview_note_app/pages/notes_page.dart';
import 'package:interview_note_app/widget/login_btn.dart';

import 'package:interview_note_app/widget/login_text_field.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final formKey = GlobalKey<FormState>();
  static String userName = '';
  static String password = '';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.43,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF182B3A), Color(0xFF20A4F3)]),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height * .1),
                      Image.asset(
                        "assets/images/logo.png",
                        height: MediaQuery.of(context).size.height * .3,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 10),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MyTextForm(
                                  onsaved: (value) => userName = value!,
                                  texthint: 'Username',
                                  validator: (newValue) {
                                    if (newValue == null || newValue.isEmpty) {
                                      return 'Username is required';
                                    } else if (newValue.length < 5) {
                                      return 'Username > 5';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .1 / 3,
                              ),
                              MyTextForm(
                                onsaved: (String? newValue) =>
                                    password = newValue!,
                                texthint: 'Password',
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'password is required';
                                  } else if (value.length < 5) {
                                    return 'Password > 5';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: height * .1 / 3,
                              ),
                              BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginLoaded) {
                                    Navigator.pushReplacement(
                                      context,
                                      BouncyPageRoute(
                                        page: const NotesPage(),
                                      ),
                                    );
                                  } else if (state is LoginError) {
                                    AwesomeDialog(
                                      dialogBackgroundColor: Colors.white,
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      headerAnimationLoop: false,
                                      title: 'Error',
                                      btnOkOnPress: () {},
                                      btnOkIcon: Icons.cancel,
                                      btnOkColor: Colors.red,
                                    ).show();
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LoginLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return OriginalButton(
                                    bgColor: Colors.lightBlue,
                                    onpressed: () {
                                      final form = formKey.currentState!;
                                      if (form.validate()) {
                                        form.save();
                                        context.read<LoginBloc>().add(
                                            TryLoginEvent(
                                                userName: userName,
                                                password: password));
                                      }
                                    },
                                    text: 'Login',
                                  );
                                },
                              ),
                              SizedBox(
                                height: height * .1 / 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
