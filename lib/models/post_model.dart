import 'dart:convert';

// Decode
List<PostModel> postFromJson(String jsonData) {
  final results = json.decode(jsonData);
  return List<PostModel>.from(
      results.map((result) => PostModel.fromJson(result)));
}

// Encode
String postToJson(PostModel postModel) {
  final results = postModel.toJson();
  return json.encode(results);
}

class PostModel {
  int? id;
  int userId;
  String name;
  String prodi;
  String nim;
  String alamat;
  DateTime? createAt;

  PostModel(
      {this.id,
      required this.userId,
      required this.name,
      required this.prodi,
        required this.alamat,
        required this.nim,
      this.createAt});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        prodi: json["prodi"],
        nim: json["nim"],
        alamat: json["alamat"],
        createAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "prodi": prodi,
        "nim": nim,
        "alamat": alamat,
      };

  // Debug
  // @override
  // String toString() {
  //   return 'PostModel{id: $id, title: $title, description: $description, created_at: $createdAt, updated_at: $updatedAt}';
  // }
}
