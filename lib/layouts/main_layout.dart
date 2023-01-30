import 'package:chat_us/modules/add_new_post/add_new_post_screen.dart';
import 'package:chat_us/modules/chat/chat_screen.dart';
import 'package:chat_us/modules/home/home_screen.dart';
import 'package:chat_us/modules/notifications/notifications_screen.dart';
import 'package:chat_us/modules/profile/profile_screen.dart';
import 'package:chat_us/modules/setting/setting_screen.dart';
import 'package:chat_us/shared/componets/components.dart';
import 'package:chat_us/shared/cubit/cubit/get_user_data_cubit.dart';
import 'package:chat_us/shared/cubit/cubit/sign_up_cubit.dart';
import 'package:chat_us/shared/cubit/states/get_user_data_states.dart';
import 'package:chat_us/style/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserDataCubit, GetUserDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ConditionalBuilder(
                        condition:
                            GetUserDataCubit.getContext(context).userModel !=
                                null,
                        builder: (context) => Row(
                          children: [
                            CircleAvatar(
                                backgroundImage: NetworkImage(
                                  '${GetUserDataCubit.getContext(context).userModel!.image}',
                                ),
                                radius: 25),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hey!',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 7.0,
                                ),
                                Text(
                                  '${GetUserDataCubit.getContext(context).userModel!.name}',                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    navigateTo(
                                        context, const AddNewPostScreen());
                                  },
                                  icon: const Icon(
                                    color: Colors.black,
                                    IconBroken.Edit,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    color: Colors.black,
                                    IconBroken.Search,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    navigateTo(context, const ProfileScreen());
                                  },
                                  icon: const Icon(
                                    color: Colors.black,
                                    IconBroken.Profile,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        fallback: (context) => CircularProgressIndicator(),
                      ),
                    ),
                    const TabBar(
                      indicatorColor: Colors.deepOrange,
                      labelPadding: EdgeInsetsDirectional.all(16.0),
                      tabs: [
                        Tab(
                          icon: Icon(
                            IconBroken.Home,
                            color: Colors.black,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            IconBroken.Chat,
                            color: Colors.black,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            IconBroken.Notification,
                            color: Colors.black,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            IconBroken.Setting,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        HomeScreen(),
                        const ChatScreen(),
                        const NotificationsScreen(),
                        const SettingScreen(),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
