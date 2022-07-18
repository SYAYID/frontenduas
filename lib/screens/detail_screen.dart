import 'package:flutter/material.dart';

import 'package:cruduas3/utils/contants.dart';
import 'package:cruduas3/models/post_model.dart';
import 'package:cruduas3/services/post_service.dart';

class DetailScreen extends StatefulWidget {
  final int? id;
  final int? userId;

  DetailScreen({required this.id, required this.userId});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late PostService _postService;
  int _userId = 0;

  @override
  void initState() {
    super.initState();
    _postService = PostService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          title: Text(
            'Detail',
            style: primaryText.copyWith(color: secondaryColor),
          ),
          backgroundColor: primaryColor,
        ),
        body: FutureBuilder(
          future: _postService.getPost(widget.id),
          builder: (BuildContext context,
                  AsyncSnapshot<List<PostModel>?> snapshot) =>
              _checkData(snapshot),
        ));
  }

  // Check data
  dynamic _checkData(snapshot) {
    if (snapshot.hasData) {
      // Success
      List<PostModel> posts = snapshot.data!;

      return _buildView(posts);
    } else if (snapshot.hasError) {
      // Error
      return Center(
        child: Text("Something wrong with message: ${snapshot.error}"),
      );
    }

    // Loading
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildView(List<PostModel> posts) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          PostModel post = posts[index];
          _userId = post.userId;

          return Container(
            padding: EdgeInsets.all(24.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.name,
                  style:
                      primaryText.copyWith(fontSize: 24, color: primaryColor),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Created at ' +
                      post.createAt!.day.toString() +
                      " - " +
                      post.createAt!.month.toString() +
                      " - " +
                      post.createAt!.year.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  post.prodi,
                  style: TextStyle(height: 1.4),
                ),
                Text(
                  post.nim,
                  style: TextStyle(height: 1.4),
                ),
                Text(
                  post.alamat,
                  style: TextStyle(height: 1.4),
                ),

              ],
            ),
          );
        });
  }
}
