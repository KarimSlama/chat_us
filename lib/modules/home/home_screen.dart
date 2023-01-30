import 'package:chat_us/models/posts_model.dart';
import 'package:chat_us/shared/componets/components.dart';
import 'package:chat_us/shared/cubit/cubit/get_user_data_cubit.dart';
import 'package:chat_us/shared/cubit/states/get_user_data_states.dart';
import 'package:chat_us/style/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserDataCubit, GetUserDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: GetUserDataCubit.getContext(context).posts.isNotEmpty,
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        GetUserDataCubit.getContext(context).posts[index],
                        context,
                        index),
                    itemCount:
                        GetUserDataCubit.getContext(context).posts.length,
                  ),
                ),
              ),
            ],
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  } //end build()

  Widget buildPostItem(PostsModel postsModel, context, index) => Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 27.0,
                        backgroundImage: NetworkImage(
                          '${postsModel.image}',
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${postsModel.name}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            '${postsModel.postDate}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          IconBroken.More_Circle,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  divider(),
                  const SizedBox(height: 10.0),
                  Text(
                    '${postsModel.postText}',
                    style: const TextStyle(
                      height: 1.4,
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  if (postsModel.postImage != '')
                    Container(
                      height: 200.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                            image: NetworkImage(
                              '${postsModel.postImage}',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  Row(
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                color: Colors.red,
                                size: 22.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${GetUserDataCubit.getContext(context).postsLikesNo[index]}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13.0),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                      const Spacer(),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                color: Colors.amber,
                                size: 22.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${GetUserDataCubit.getContext(context).postsCommentsNo[index]}'
                                ' comments',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13.0),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                          '${GetUserDataCubit.getContext(context).userModel!.image}',
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        width: 180.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50.0,
                          ),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: commentController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'write a comment',
                            fillColor: Colors.black,
                            hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 14.0,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            GetUserDataCubit.getContext(context).commentPost(
                                postId: GetUserDataCubit.getContext(context)
                                    .postId[index],
                                comment: commentController.text);
                          },
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsetsDirectional.zero,
                        onPressed: () {
                          GetUserDataCubit.getContext(context).likePosts(
                              GetUserDataCubit.getContext(context)
                                  .postId[index]);
                        },
                        icon: const Icon(IconBroken.Heart),
                        color: Colors.red,
                      ),
                      const Text('Like', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
} //end class
