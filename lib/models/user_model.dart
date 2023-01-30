class UserModel {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? uId;
  bool? isVerify;
  String? image;
  String? coverImage;
  String? bio;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.uId,
    this.isVerify,
    this.image,
    this.coverImage,
    this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    uId = json['uId'];
    isVerify = json['isVerify'];
    image = json['image'];
    coverImage = json['coverImage'];
    bio = json['bio'];
  } //end .fromJson()

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'uId': uId,
      'isVerify': isVerify,
      'image': image,
      'coverImage': coverImage,
      'bio': bio,
    };
  } //end toMap()
} //end class
