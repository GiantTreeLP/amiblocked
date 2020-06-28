import 'dart:convert';

class BlockedResult {
  final String username;
  final String snowflake;
  final String note;
  final bool blocked;
  final DateTime blockedAt;

  BlockedResult(
      {this.username, this.snowflake, this.note, this.blocked, this.blockedAt});

  factory BlockedResult.fromJson(Map<String, dynamic> json) {
    return BlockedResult(
        username: json["username"],
        snowflake: json["snowflake"],
        note: json["note"],
        blocked: json["blocked"],
        blockedAt: json["blockedAt"]);
  }
}

BlockedResult parseResult(String response) {
  final parsed = json.decode(response)?.cast<Map<String, dynamic>>();
  if (parsed != null) {
    return BlockedResult.fromJson(parsed);
  } else {
    return parsed;
  }
}