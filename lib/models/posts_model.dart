class PostsModel {
  String? name;
  String? uId;
  String? image;
  String? postDate;
  String? postText;
  String? postImage;

  PostsModel({
    this.name,
    this.uId,
    this.image,
    this.postDate,
    this.postImage,
    this.postText,
  });

  PostsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    postDate = json['postDate'];
    postText = json['postText'];
    postImage = json['postImage'];
  } //end .fromJson()

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'postDate': postDate,
      'postText': postText,
      'postImage': postImage,
    };
  } //end toMap()
} //end class
