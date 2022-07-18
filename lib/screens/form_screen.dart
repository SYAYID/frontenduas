import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cruduas3/utils/contants.dart';
import 'package:cruduas3/models/post_model.dart';
import 'package:cruduas3/services/post_service.dart';

class FormScreen extends StatefulWidget {
  final PostModel? postModel;

  FormScreen({this.postModel});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // Declaration
  PostService _postService = PostService();

  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerProdi = TextEditingController();
  TextEditingController _controllerNim = TextEditingController();
  TextEditingController _controllerAlamat = TextEditingController();


  @override
  void initState() {
    if (widget.postModel != null) {
      _controllerName.text = widget.postModel!.name;
      _controllerProdi.text = widget.postModel!.prodi;
      _controllerNim.text = widget.postModel!.nim;
      _controllerAlamat.text = widget.postModel!.alamat;

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(widget.postModel == null ? 'Form Create' : 'Form Update',
            style: primaryText.copyWith(color: secondaryColor)),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _controllerName,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required title';
                    }

                    return null;
                  },
                  autofocus: true,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'Enter post name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  controller: _controllerProdi,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required title';
                    }

                    return null;
                  },
                  autofocus: true,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Jurusan',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'Enter your major',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _controllerNim,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required title';
                    }

                    return null;
                  },
                  autofocus: true,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'NIM',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'Enter your ID',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _controllerAlamat,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required title';
                    }

                    return null;
                  },
                  autofocus: true,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'Enter your Address',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),

                SizedBox(
                  height: size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Check validate
                    if (_formKey.currentState!.validate()) {
                      // Declartion loading, controller, & model
                      setState(() => _isLoading = true);

                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      PostModel postModel = PostModel(
                        userId: (sharedPreferences.getInt("userId"))!,
                        name: _controllerName.text.toString(),
                        prodi: _controllerProdi.text.toString(),
                        nim: _controllerNim.text.toString(),
                        alamat: _controllerAlamat.text.toString(),
                      );
                      PostModel _postModel = postModel;

                      if (widget.postModel == null) {
                        // Create post
                        _postService.createPost(_postModel).then((isSuccess) {
                          setState(() => _isLoading = false);

                          if (isSuccess) {
                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Create Post Failed')),
                            );
                          }
                        }).onError((error, stackTrace) {
                          print(error);
                        });
                      } else {
                        // Update post
                        _postModel.id = widget.postModel!.id;

                        _postService.updatePost(_postModel).then((isSuccess) {
                          setState(() => _isLoading = false);

                          if (isSuccess) {
                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Update Post Failed')),
                            );
                          }
                        }).onError((error, stackTrace) {
                          print(error);
                        });
                      }
                    }
                  },
                  // Loading or text
                  child: _isLoading
                      ? Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: secondaryColor),
                          child: SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator()),
                        )
                      : Text('Save'),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    tapTargetSize: MaterialTapTargetSize.padded,
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 18, horizontal: 28),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
