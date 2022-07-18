import 'package:http/http.dart' as client;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';

class PostService {
  // Base URL API
  final String baseURL = 'http://10.0.2.2:8000';
  late SharedPreferences sharedPreferences;

  // Get all posts
  Future<List<PostModel>?> getPosts() async {
    final response = await client.get(Uri.parse(baseURL + '/api/posts'));

    if (response.statusCode == 200) return postFromJson(response.body);
    return null;
  }

  // Get post
  Future<List<PostModel>?> getPost(int? id) async {
    final response =
        await client.get(Uri.parse(baseURL + '/api/post/' + id.toString()));

    if (response.statusCode == 200) return postFromJson(response.body);
    return null;
  }

  // Get my posts
  Future<List<PostModel>?> getMyPost(int? id) async {
    final response =
        await client.get(Uri.parse(baseURL + '/api/my_post/' + id.toString()));

    if (response.statusCode == 200) return postFromJson(response.body);
    return null;
  }

  // Create post
  Future<bool> createPost(PostModel postModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("token");

    final response = await client.post(
      Uri.parse(baseURL + '/api/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: postToJson(postModel),
    );

    if (response.statusCode == 201) return true;
    return false;
  }

  // Update post
  Future<bool> updatePost(PostModel postModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("token");

    final response = await client.put(
      Uri.parse(baseURL + '/api/posts/${postModel.id.toString()}'),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: postToJson(postModel),
    );

    if (response.statusCode == 200) return true;
    return false;
  }

  // Delete post
  Future<bool> deletePost(int? id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("token");

    final response = await client.delete(
      Uri.parse(baseURL + '/api/posts/${id.toString()}'),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) return true;
    return false;
  }
}
