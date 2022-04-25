import 'dart:io';
import 'package:chat_room/widget/user_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username, File? image,
      bool islogin, BuildContext ctx) submitAuthForm;
  final bool isLoad;

  AuthForm(this.submitAuthForm, this.isLoad);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _islogin = true;
  String _email = '';
  String _password = '';
  String _userName = '';
   File? _userImage ;


   _pickImage (File pickedimage){
    _userImage = pickedimage;
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(!_islogin && _userImage == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please Select Image',
            style: TextStyle(fontSize: 20, color: Colors.teal),
          ),
          backgroundColor: Colors.black,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitAuthForm(_email.trim(), _password.trim(), _userName.trim(),_userImage,_islogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:SingleChildScrollView(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    color: Color(0xFF00061a),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft:Radius.circular(30),
                        bottomRight:Radius.circular(30)
                    )
                ),
                child: Center(
                    child: Image.asset('images/chat.png',height: MediaQuery.of(context).size.height * 0.6 ,width: MediaQuery.of(context).size.width * 0.6 ,),
                  ),
                ),
              const SizedBox(height: 20),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 14),
                          if (!_islogin)  UserImagePicker(_pickImage),
                          const SizedBox(height: 14),
                          TextFormField(
                            autocorrect: false,
                            enableSuggestions: false,
                            textCapitalization: TextCapitalization.none,
                            key: const ValueKey('email'),
                            validator: (val) {
                              if (val!.isEmpty || !val.contains('@')) {
                                return 'Please Enter a Vaild Email Address';
                              }
                              return null;
                            },
                            onSaved: (val) => _email = val!,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(labelText: 'Email Addres'),
                          ),
                          if (!_islogin)
                            TextFormField(
                              autocorrect: true,
                              enableSuggestions: false,
                              textCapitalization: TextCapitalization.words,
                              key: const ValueKey('username'),
                              validator: (val) {
                                if (val!.isEmpty || val.length < 3) {
                                  return 'Please add least 3 character';
                                }
                                return null;
                              },
                              onSaved: (val) => _userName = val!,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(labelText: 'User Name'),
                            ),
                          TextFormField(
                            autocorrect: false,
                            enableSuggestions: false,
                            textCapitalization: TextCapitalization.none,
                            key: const ValueKey('password'),
                            validator: (val) {
                              if (val!.isEmpty || val.length < 8) {
                                return 'Please add least 8 character';
                              }
                              return null;
                            },
                            onSaved: (val) => _password = val!,
                            decoration: const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                          ),
                          if(widget.isLoad)
                            const CircularProgressIndicator(),
                          const SizedBox(
                              height: 20
                          ),
                          if(!widget.isLoad)
                            ElevatedButton(
                              onPressed: _submit,
                              child: _islogin ? const Text('Login') : const Text('Sign Up'),
                            ),
                          if(!widget.isLoad)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _islogin = !_islogin;
                                });
                              },
                              child: Text(_islogin
                                  ? 'Create New Account'
                                  : 'I already have an account'),
                            )
                        ],
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
