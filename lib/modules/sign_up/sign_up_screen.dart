import 'package:chat_us/layouts/main_layout.dart';
import 'package:chat_us/modules/login/login_screen.dart';
import 'package:chat_us/shared/componets/components.dart';
import 'package:chat_us/shared/cubit/cubit/sign_up_cubit.dart';
import 'package:chat_us/shared/cubit/states/sign_up_state.dart';
import 'package:chat_us/style/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpErrorState) {
            showToast(
              toastText: state.error,
              state: ToastBackgroundColor.ERROR,
            );
          }
          if (state is SignUpCreateNewSuccessState) {
            showToast(toastText: 'done', state: ToastBackgroundColor.SUCCESS);
            navigateAndFinish(context, const MainLayout());
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
                              'SIGN UP',
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
                              'sign up to continue',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            textForm(
                              inputType: TextInputType.text,
                              controller: nameController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'name is required';
                                }
                                return null;
                              },
                              label: 'name',
                              prefixIcon: IconBroken.Profile,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 25.0,
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
                              label: 'email address',
                              color: Colors.black,
                              prefixIcon: IconBroken.Message,
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            textForm(
                              inputType: TextInputType.phone,
                              controller: phoneController,
                              color: Colors.black,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'phone is required';
                                }
                                return null;
                              },
                              label: 'phone',
                              maxLength: 11,
                              prefixIcon: IconBroken.Call,
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            textForm(
                              inputType: TextInputType.visiblePassword,
                              controller: passwordController,
                              color: Colors.black,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'password is too short';
                                }
                                return null;
                              },
                              label: 'password',
                              prefixIcon: Icons.password_outlined,
                              isPassword:
                                  SignUpCubit.getContext(context).isPassword,
                              suffixIcon:
                                  SignUpCubit.getContext(context).suffixIcon,
                              suffixPressed: () {
                                SignUpCubit.getContext(context)
                                    .changePasswordVisibility();
                              },
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! SignUpLoadingState,
                              builder: (context) => mainButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    SignUpCubit.getContext(context).signUpUser(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'SIGN UP',
                                textColor: Colors.white,
                                width: 250.0,
                                height: 60.0,
                                color: Colors.deepPurple,
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
                                  'already have an account',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, const LoginScreen());
                                  },
                                  child: const Text(
                                    'LOGIN',
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
