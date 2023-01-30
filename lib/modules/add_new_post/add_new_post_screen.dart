import 'package:chat_us/layouts/main_layout.dart';
import 'package:chat_us/shared/componets/components.dart';
import 'package:chat_us/shared/cubit/cubit/get_user_data_cubit.dart';
import 'package:chat_us/shared/cubit/states/get_user_data_states.dart';
import 'package:chat_us/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewPostScreen extends StatelessWidget {
  const AddNewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserDataCubit, GetUserDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var postController = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            title:
                const Text('New Post', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.black,
              ),
              onPressed: () {
                navigateTo(context, const MainLayout());
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if (GetUserDataCubit.getContext(context).postImage != null) {
                    GetUserDataCubit.getContext(context).uploadNewPostImage(
                      postDate: now.toString(),
                      postText: postController.text,
                    );
                    Navigator.pop(context);
                  } else {
                    GetUserDataCubit.getContext(context).createNewPost(
                        postDate: now.toString(),
                        postText: postController.text);
                    Navigator.pop(context);
                  }
                },
                child: const Icon(IconBroken.Send),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${GetUserDataCubit.getContext(context).userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${GetUserDataCubit.getContext(context).userModel!.name}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'public',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black26,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: postController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'what about your thinking .......?',
                        fillColor: Colors.black,
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontSize: 14.0,
                        ),
                      ),
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                ),
                if (GetUserDataCubit.getContext(context).postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                              image: FileImage(
                                  GetUserDataCubit.getContext(context)
                                      .postImage!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          GetUserDataCubit.getContext(context)
                              .removeImageSelected();
                        },
                        icon: const Icon(
                          IconBroken.Close_Square,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          GetUserDataCubit.getContext(context).getPostImage();
                        },
                        child: Row(
                          children: const [
                            Icon(
                              IconBroken.Image,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'Add photos',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: const [
                            Text(
                              '#tags',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
