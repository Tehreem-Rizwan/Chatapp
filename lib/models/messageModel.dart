class MessageModel {
  String? sender;
  String? text;
  DateTime? createdon;
  bool? seen;
  MessageModel({this.sender, this.createdon, this.seen, this.text});
  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map['sender'];
    text = map['text'];
    createdon = map['createdon'].toDate();
    seen = map['seen'];
  }
  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'text': text,
      'createdon': createdon,
      'seen': seen
    };
  }
}
