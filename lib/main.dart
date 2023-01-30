import 'package:chat_us/layouts/main_layout.dart';
import 'package:chat_us/modules/login/login_screen.dart';
import 'package:chat_us/modules/onboarding/onboarding_screen.dart';
import 'package:chat_us/shared/componets/components.dart';
import 'package:chat_us/shared/componets/constants.dart';
import 'package:chat_us/shared/cubit/cubit/get_user_data_cubit.dart';
import 'package:chat_us/shared/cubit/obsesrver.dart';
import 'package:chat_us/shared/data/cache_helper.dart';
import 'package:chat_us/style/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> firebaseMessagingBackgroundHandler(message) async {
  print(message.data.toString());
  showToast(
      toastText: 'onBackgroundMessage', state: ToastBackgroundColor.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(toastText: 'onMessage', state: ToastBackgroundColor.SUCCESS);
    // print(event.notification!.title.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(
        toastText: 'onMessageOpenedApp', state: ToastBackgroundColor.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(
      (message) => firebaseMessagingBackgroundHandler(message));

  print(token);

  Widget widget;

  var isBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');

  if (isBoarding != null) {
    if (uId != null) {
      widget = const MainLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => GetUserDataCubit()
              ..getUserData()
              ..getAllPosts()
              ..getAllUsers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        theme: lightTheme,
      ),
    );
  } //end build()
} //end class
