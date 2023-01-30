import 'dart:io';

import 'package:chat_us/shared/componets/components.dart';
import 'package:chat_us/shared/cubit/cubit/get_user_data_cubit.dart';
import 'package:chat_us/shared/cubit/states/get_user_data_states.dart';
import 'package:chat_us/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();

    return BlocConsumer<GetUserDataCubit, GetUserDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var editProfileCubit = GetUserDataCubit.getContext(context).userModel;
        var editProfilePicture =
            GetUserDataCubit.getContext(context).profileImage;
        var editCoverPicture = GetUserDataCubit.getContext(context).coverImage;

        nameController.text = editProfileCubit!.name!;
        bioController.text = editProfileCubit.bio!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile',
                style: TextStyle(color: Colors.black)),
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
            actions: [
              IconButton(
                  onPressed: () {
                    if (editProfileCubit != null) {
                      GetUserDataCubit.getContext(context).updateUserData(
                        name: nameController.text,
                        bio: bioController.text,
                      );
                    }
                    if (editProfilePicture != null) {
                      GetUserDataCubit.getContext(context).uploadProfileImage(
                          name: nameController.text, bio: bioController.text);
                    }
                    if (editCoverPicture != null) {
                      GetUserDataCubit.getContext(context).uploadCoverImage(
                          name: nameController.text, bio: bioController.text);
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Bookmark,
                    color: Colors.black,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 215.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: 170.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: DecorationImage(
                                      image: editCoverPicture == null
                                          ? NetworkImage(
                                              '${editProfileCubit.coverImage}',
                                            )
                                          : FileImage(
                                                  File(editCoverPicture.path))
                                              as ImageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  GetUserDataCubit.getContext(context)
                                      .getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.deepPurple,
                                  child: Icon(
                                    IconBroken.Edit_Square,
                                    color: Colors.white,
                                    size: 17.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 62,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: (editProfilePicture == null)
                                    ? NetworkImage(
                                        '${editProfileCubit.image}',
                                      )
                                    : FileImage(File(editProfilePicture.path))
                                        as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                GetUserDataCubit.getContext(context)
                                    .getProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.deepPurple,
                                child: Icon(
                                  IconBroken.Edit_Square,
                                  color: Colors.white,
                                  size: 17.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
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
                    label: 'user name',
                    color: Colors.black,
                    prefixIcon: IconBroken.Profile,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  textForm(
                    inputType: TextInputType.text,
                    controller: bioController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'bio is required';
                      }
                      return null;
                    },
                    label: 'bio',
                    color: Colors.black,
                    prefixIcon: IconBroken.Paper,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
