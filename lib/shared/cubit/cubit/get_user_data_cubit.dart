import 'dart:io';
import 'package:chat_us/models/message_model.dart';
import 'package:chat_us/models/posts_model.dart';
import 'package:chat_us/models/user_model.dart';
import 'package:chat_us/shared/componets/constants.dart';
import 'package:chat_us/shared/cubit/states/get_user_data_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class GetUserDataCubit extends Cubit<GetUserDataStates> {
  GetUserDataCubit() : super(GetUserDataInitialState());

  static GetUserDataCubit getContext(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error));
    });
  } //end getUserData()

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(GetUserProfileImageSuccessState());
    } else {
      print('no image selected');
      emit(GetUserProfileImageErrorState());
    } //end else
  } //end getProfileImage()

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(GetUserCoverImageSuccessState());
    } else {
      print('no image selected');
      emit(GetUserCoverImageErrorState());
    } //end else
  } //end getProfileImage()

  void uploadProfileImage({required String name, required String bio}) {
    emit(UploadNewUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(name: name, bio: bio, profile: value);
        // emit(UploadUserProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadUserProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadUserProfileImageErrorState());
    });
  }

  void uploadCoverImage({required String name, required String bio}) {
    emit(UploadNewUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(name: name, bio: bio, cover: value);
        // emit(UploadUserCoverImageSuccessState());
      }).catchError((error) {
        emit(UploadUserCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadUserCoverImageErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String bio,
    String? profile,
    String? cover,
  }) {
    UserModel userData = UserModel(
      name: name,
      bio: bio,
      image: profile ?? userModel!.image,
      coverImage: cover ?? userModel!.coverImage,
      email: userModel!.email,
      phone: userModel!.phone,
      password: userModel!.password,
      isVerify: false,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(userData.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateNewUserDataErrorState());
    });
  } //end updateUserDate()

  File? postImage;

  Future<void> getPostImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(CreateNewPostImageSuccessState());
    } else {
      print('no image selected');
      emit(CreateNewPostImageErrorState());
    } //end else
  } //end getProfileImage()

  void removeImageSelected() {
    postImage = null;
    emit(RemoveImagePostSelected());
  }

  void uploadNewPostImage(
      {required String postDate, required String postText}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(
          postDate: postDate,
          postText: postText,
          postImage: value,
        );
      }).catchError((error) {
        emit(CreateNewPostImageSuccessState());
      });
    }).catchError((error) {
      emit(CreateNewPostImageErrorState());
    });
  } //end uploadNewPostImage()

  void createNewPost({
    required String postDate,
    required String postText,
    String? postImage,
  }) {
    PostsModel postsModel = PostsModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      postDate: postDate,
      postText: postText,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postsModel.toMap())
        .then((value) {
      emit(CreateNewPostSuccessState());
    }).catchError((error) {
      emit(CreateNewPostErrorState());
    });
  } //end createNewPost()

  List<PostsModel> posts = [];
  List<String> postId = [];
  List<int> postsLikesNo = [];
  List<int> postsCommentsNo = [];

  void getAllPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          postsCommentsNo.add(value.docs.length);
          emit(PostsCommentSuccessState());
        }).catchError((error) {
          emit(PostsCommentErrorState(error.toString()));
        });
        element.reference.collection('likes').get().then((value) {
          postId.add(element.id);
          posts.add(PostsModel.fromJson(element.data()));
          postsLikesNo.add(value.docs.length);
          emit(GetAllUserPostsSuccessState());
        }).catchError((error) {
          emit(GetAllUserPostsErrorState(error.toString()));
        });
      });
    }).catchError((error) {
      emit(GetAllUserPostsErrorState(error.toString()));
    });
  } //end getAllPosts()

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(PostsLikeSuccessState());
    }).catchError((error) {
      emit(PostsLikeErrorState(error.toString()));
    });
  } // end likePosts()

  void commentPost({required String postId, required String comment}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      'comment': comment,
    }).then((value) {
      emit(PostsCommentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PostsCommentErrorState(error.toString()));
    });
  } //end commentPost()

  List<UserModel> users = [];

  void getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
          emit(GetAllUserSuccessState());
        });
      }).catchError((error) {
        emit(GetAllUserErrorState(error.toString()));
      });
    }
  } //end getAllUsers()

  void sendMessages({
    required String message,
    required String receiverId,
    required messageDate,
  }) {
    MessageModel messageModel = MessageModel(
      message: message,
      receiverId: receiverId,
      messageDate: messageDate,
      senderId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });
  } //end sendMessages()

  List<MessageModel> messages = [];

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('messageDate')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  } //end getMessages()

  File? imageMessage;

  Future<void> chooseMessageImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageMessage = File(pickedImage.path);
      emit(ChooseMessageImageSuccessState());
    } else {
      print('no image selected');
      emit(ChooseMessageImageErrorState());
    } //end else
  } //end getProfileImage()

  void removeMessageImageSelected() {
    imageMessage = null;
    emit(RemoveMessageImageSelected());
  }
} //end class
