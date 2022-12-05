class MessageModel {
  String? messageid;
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdon;

  MessageModel({
    this.createdon,
    this.seen,
    this.sender,
    this.text,
    this.messageid,
  });

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageid = map['messageid'];
    sender = map['sender'];
    text = map['text'];
    seen = map['seen'];
    createdon = map['createdon'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'messageid': messageid,
      'sender': sender,
      'text': text,
      'seen': seen,
      'createdon': createdon
    };
  }
}
