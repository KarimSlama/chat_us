import 'package:chat_us/layouts/main_layout.dart';
import 'package:chat_us/modules/sign_up/sign_up_screen.dart';
import 'package:chat_us/shared/componets/components.dart';
import 'package:chat_us/shared/cubit/cubit/login_cubit.dart';
import 'package:chat_us/shared/cubit/states/login_state.dart';
import 'package:chat_us/shared/data/cache_helper.dart';
import 'package:chat_us/style/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
              state: ToastBackgroundColor.ERROR,
              toastText: state.error,
            );
          } //end if()

          if (state is LoginSuccessState) {
            showToast(
              state: ToastBackgroundColor.SUCCESS,
              toastText: 'done',
            );
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, const MainLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              'continue log in to start chatting',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            textForm(
                              inputType: TextInputType.emailAddress,
                              controller: emailController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'email is required';
                                }
                                return null;
                              },
                              color: Colors.black,
                              label: 'email address',
                              prefixIcon: IconBroken.Message,
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            textForm(
                                inputType: TextInputType.visiblePassword,
                                controller: passwordController,
                                isPassword:
                                    LoginCubit.getContext(context).isPassword,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'password is too short';
                                  }
                                  return null;
                                },
                                label: 'password',
                                prefixIcon: Icons.password_outlined,
                                color: Colors.black,
                                suffixIcon:
                                    LoginCubit.getContext(context).suffixIcon,
                                suffixPressed: () {
                                  LoginCubit.getContext(context)
                                      .changePasswordVisibility();
                                },
                                onSubmit: (value) {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.getContext(context).loginUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  } //end if()
                                } //end onSubmit()
                                ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              'forgot the password',
                              style: TextStyle(
                                fontSize: 16.0,
                                decoration: TextDecoration.underline,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginSuccessState,
                              builder: (context) => mainButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.getContext(context).loginUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  } //end if()
                                },
                                color: Colors.deepPurple,
                                textColor: Colors.white,
                                width: 250.0,
                                height: 60.0,
                                text: 'LOGIN',
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'if you don\'t have any account',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, const SignUpScreen());
                                  },
                                  child: const Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  } //end build()
} //end class
