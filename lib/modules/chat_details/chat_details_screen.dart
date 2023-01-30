import 'package:chat_us/models/message_model.dart';
import 'package:chat_us/models/user_model.dart';
import 'package:chat_us/shared/cubit/cubit/get_user_data_cubit.dart';
import 'package:chat_us/shared/cubit/states/get_user_data_states.dart';
import 'package:chat_us/style/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      GetUserDataCubit.getContext(context)
          .getMessages(receiverId: userModel.uId!);
      return BlocConsumer<GetUserDataCubit, GetUserDataStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                    color: Colors.black,
                  )),
              title: Row(
                children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                      radius: 20),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    children: [
                      Text(
                        '${userModel.name}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconBroken.More_Circle,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var messageCubit =
                              GetUserDataCubit.getContext(context)
                                  .messages[index];
                          if (GetUserDataCubit.getContext(context)
                                  .userModel!
                                  .uId ==
                              messageCubit.receiverId)
                            return getMessage(messageCubit);
                          return sendMessage(messageCubit, context);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15.0,
                        ),
                        itemCount: GetUserDataCubit.getContext(context)
                            .messages
                            .length,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: messageController,
                            maxLines: null,
                            minLines: 1,
                            style: const TextStyle(height: 1.4),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message',
                              fillColor: Colors.black,
                              hintStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                GetUserDataCubit.getContext(context)
                                    .chooseMessageImage();
                              },
                              icon: const Icon(
                                IconBroken.Plus,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                GetUserDataCubit.getContext(context)
                                    .sendMessages(
                                  message: messageController.text,
                                  receiverId: userModel.uId!,
                                  messageDate: DateTime.now().toString(),
                                );
                                messageController.text = '';
                              },
                              icon: const Icon(
                                IconBroken.Send,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
    });
  } //end build()

  Widget getMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
                backgroundImage: NetworkImage(
                  '${userModel.image}',
                ),
                radius: 20),
            const SizedBox(
              width: 10.0,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Text(
                '${messageModel.message}',
                style: const TextStyle(height: 1.4),
              ),
            ),
          ],
        ),
      );

  Widget sendMessage(MessageModel messageModel, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.withOpacity(.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    ),
                  ),
                  child: Text(
                    '${messageModel.message}',
                    style: const TextStyle(height: 1.4),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    '${GetUserDataCubit.getContext(context).userModel!.image}',
                  ),
                  radius: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            if (GetUserDataCubit.getContext(context).imageMessage != null)
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                          image: FileImage(GetUserDataCubit.getContext(context)
                              .imageMessage!),
                          fit: BoxFit.cover),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      GetUserDataCubit.getContext(context)
                          .removeMessageImageSelected();
                    },
                    icon: const Icon(
                      IconBroken.Close_Square,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
}
