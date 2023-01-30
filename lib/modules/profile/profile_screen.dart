import 'package:chat_us/layouts/main_layout.dart';
import 'package:chat_us/modules/edit_profile/edit_profile_screen.dart';
import 'package:chat_us/shared/componets/components.dart';
import 'package:chat_us/shared/cubit/cubit/get_user_data_cubit.dart';
import 'package:chat_us/shared/cubit/states/get_user_data_states.dart';
import 'package:chat_us/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserDataCubit, GetUserDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileCubit = GetUserDataCubit.getContext(context).userModel!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 215.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 170.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${profileCubit.coverImage}',
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 62,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                            '${profileCubit.image}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      '${profileCubit.name}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    mainButton(
                      onPressed: () {
                        navigateTo(context, const EditProfileScreen());
                      },
                      text: 'Edit Profile',
                      fontSize: 14.0,
                      color: Colors.deepOrange,
                      height: 35.0,
                      radius: 12.0,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(
                  '${profileCubit.bio}',
                  style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              '100',
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.grey),
                            ),
                            const SizedBox(height: 7.0),
                            const Text(
                              'Posts',
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              '120',
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.grey),
                            ),
                            const SizedBox(height: 7.0),
                            const Text(
                              'Followers',
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              '320',
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.grey),
                            ),
                            const SizedBox(height: 7.0),
                            const Text(
                              'Following',
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[100],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'Recent Sharing',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
