class WebRTCMessage {
  String to;
  String from;
  String type; //can be offer, answer,candidate,hung-up
  Map<dynamic, dynamic> sdp;
  Map<dynamic, dynamic> candidate;
  WebRTCMessage._({required this.to, required this.from, required this.type, required this.sdp, required this.candidate});

  factory WebRTCMessage.fromJson(Map<String, dynamic> json) {
    return WebRTCMessage._(
      candidate: json["candidate"],
       to: json['to'],
       from: json["from"],
       type: json["type"],
       sdp: json["sdp"],
       );
  }
}
