class Message {
  String id;
  String fromUID;
  String toUID;
  String message;

  Message(
      {required this.id,
      required this.fromUID,
      required this.message,
      required this.toUID});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json["id"],
        fromUID: json["fromuserid"] != null ? json["fromuserid"] : "",
        toUID: json["touserid"],
        message: json["message"]);
  }
}
