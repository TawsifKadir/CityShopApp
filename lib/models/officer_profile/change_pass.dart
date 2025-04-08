class ChangePass {
  String? type;
  String? messageEn;
  String? messageBn;

  ChangePass({this.type, this.messageEn, this.messageBn});

  ChangePass.fromJson(json) {
    type = json['type'];
    messageEn = json['message_en'];
    messageBn = json['message_bn'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['message_en'] = messageEn;
    map['message_bn'] = messageBn;
    return map;
  }
}
