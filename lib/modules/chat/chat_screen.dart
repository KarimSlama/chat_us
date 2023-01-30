import 'package:chat_us/models/user_model.dart';
import 'package:chat_us/modules/chat_details/chat_details_screen.dart';
import 'package:chat_us/shared/componets/components.dart';
import 'package:chat_us/shared/cubit/cubit/get_user_data_cubit.dart';
import 'package:chat_us/shared/cubit/states/get_user_data_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserDataCubit, GetUserDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: GetUserDataCubit.getContext(context).users.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => buildChatItems(
                  GetUserDataCubit.getContext(context).users[index],
                  context,
                  index),
              separatorBuilder: (context, index) => divider(),
              itemCount: GetUserDataCubit.getContext(context).users.length,
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  } //end build()

  Widget buildChatItems(UserModel userModel, context, index) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(userModel: userModel));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 27.0,
                backgroundImage: NetworkImage(
                  '${userModel.image}',
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text(
                '${userModel.name}',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
}
