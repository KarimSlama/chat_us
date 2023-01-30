class MessageModel {
  String? message;
  String? messageDate;
  String? senderId;
  String? receiverId;

  MessageModel(
      {this.message, this.messageDate, this.receiverId, this.senderId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageDate = json['messageDate'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
  } //end .fromJson()

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'messageDate': messageDate,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  } //end toMap()
} //end class
