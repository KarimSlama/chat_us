import 'package:chat_us/models/user_model.dart';
import 'package:chat_us/shared/cubit/states/sign_up_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit getContext(context) => BlocProvider.of(context);

  UserModel? signUpUserModel;

  signUpUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(SignUpLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      createNewUser(
        name: name,
        email: email,
        phone: phone,
        password: password,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
    });
  } //end signUpUser()

  createNewUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String uId,
  }) {
    signUpUserModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      password: password,
      uId: uId,
      isVerify: false,
      image:
          'https://img.freepik.com/free-photo/medium-shot-man-wearing-vr-glasses_23-2149126949.jpg?w=740&t=st=1674919631~exp=1674920231~hmac=e3cc2d2043dbb8a28482c85e828dd6809e3149ff56c1398e726cd3f1925ba283',
      coverImage:
          'https://img.freepik.com/free-photo/aerial-view-business-team_53876-124515.jpg?w=740&t=st=1674919580~exp=1674920180~hmac=9aca53ac77944352d07304c704161425b9fd536350a2e002ec1a3764f8381353',
      bio: 'type your bio.....',
    );
    emit(SignUpLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(signUpUserModel!.toMap())
        .then((value) {
      emit(SignUpCreateNewSuccessState());
    }).catchError((error) {
      emit(SignUpCreateNewErrorState(error));
    });
  } //end createNewUser()

  bool isPassword = true;
  IconData suffixIcon = Icons.remove_red_eye_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_outlined;
    emit(SignUpChangePasswordVisibilityStates());
  } //end changePasswordVisibility()
} //end class
