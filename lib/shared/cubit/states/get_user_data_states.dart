import 'package:chat_us/shared/cubit/cubit/get_user_data_cubit.dart';

abstract class GetUserDataStates {}

class GetUserDataInitialState extends GetUserDataStates {}

class GetUserDataLoadingState extends GetUserDataStates {}

class GetUserDataSuccessState extends GetUserDataStates {}

class GetUserDataErrorState extends GetUserDataStates {
  final String error;

  GetUserDataErrorState(this.error);
}

class GetUserProfileImageSuccessState extends GetUserDataStates {}

class GetUserProfileImageErrorState extends GetUserDataStates {}

class GetUserCoverImageSuccessState extends GetUserDataStates {}

class GetUserCoverImageErrorState extends GetUserDataStates {}

class UploadUserProfileImageSuccessState extends GetUserDataStates {}

class UploadUserProfileImageErrorState extends GetUserDataStates {}

class UploadUserCoverImageSuccessState extends GetUserDataStates {}

class UploadUserCoverImageErrorState extends GetUserDataStates {}

class UpdateNewUserDataErrorState extends GetUserDataStates {}

class UploadNewUserDataLoadingState extends GetUserDataStates {}

class CreateNewPostLoadingState extends GetUserDataStates {}

class CreateNewPostSuccessState extends GetUserDataStates {}

class CreateNewPostErrorState extends GetUserDataStates {}

class CreateNewPostImageSuccessState extends GetUserDataStates {}

class CreateNewPostImageErrorState extends GetUserDataStates {}

class RemoveImagePostSelected extends GetUserDataStates {}

class GetAllUserPostsSuccessState extends GetUserDataStates {}

class GetAllUserPostsErrorState extends GetUserDataStates {
  final String error;

  GetAllUserPostsErrorState(this.error);
}

//like posts
class PostsLikeSuccessState extends GetUserDataStates {}

class PostsLikeErrorState extends GetUserDataStates {
  final String error;

  PostsLikeErrorState(this.error);
}

//comment posts
class PostsCommentSuccessState extends GetUserDataStates {}

class PostsCommentErrorState extends GetUserDataStates {
  final String error;

  PostsCommentErrorState(this.error);
}

class GetAllUserSuccessState extends GetUserDataStates {}

class GetAllUserErrorState extends GetUserDataStates {
  final String error;

  GetAllUserErrorState(this.error);
}

// chat states

class SendMessageSuccessState extends GetUserDataStates {}

class SendMessageErrorState extends GetUserDataStates {
  final String error;

  SendMessageErrorState(this.error);
}

class GetMessageSuccessState extends GetUserDataStates {}

class GetMessageErrorState extends GetUserDataStates {
  final String error;

  GetMessageErrorState(this.error);
}

class ChooseMessageImageSuccessState extends GetUserDataStates {}

class ChooseMessageImageErrorState extends GetUserDataStates {}

class RemoveMessageImageSelected extends GetUserDataStates {}
