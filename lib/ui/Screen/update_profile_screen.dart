

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_managenent/data/models/user-models.dart';
import 'package:task_managenent/data/services/apiCaller.dart';
import 'package:task_managenent/data/utils/urls.dart';
import 'package:task_managenent/ui/controllers/auth-controller.dart';
import 'package:task_managenent/ui/widgets/snack_bar_message.dart';
import 'package:task_managenent/ui/widgets/tm_appbar.dart';
import 'package:file_picker/file_picker.dart';


import '../widgets/photo_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = '/profileUpdate';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _fnameEditingController = TextEditingController();
  final TextEditingController _lnameEditingController = TextEditingController();
  final TextEditingController _numberEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();

  bool _updateProfileInProgress = false ;

  final ImagePicker _imagePicker = ImagePicker();
   XFile? _selectedImage ;

   @override
  void initState() {
    super.initState();
    UserModel user = AuthController.userModel!;

    _emailEditingController.text = user.email;
    _fnameEditingController.text = user.firstname;
    _lnameEditingController.text = user.lastname;
    _numberEditingController.text = user.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        fromUpdateProfile: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24,),
                Text('Update Profile', style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(height: 24,),
                photoPicker(onTap: _pickImage,
                selectedPhoto: _selectedImage,),
                SizedBox(height: 8,),
                TextFormField(
                  controller: _emailEditingController,
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Email'
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _fnameEditingController,
                  validator: (String? value) {
                    if(value?.trim().isEmpty ?? true){
                      return "Please Inter Your Value";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'First Name'
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _lnameEditingController,
                  validator: (String? value) {
                    if(value?.trim().isEmpty ?? true){
                      return "Please Inter Your Value";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Last Name'
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _numberEditingController,
                  validator: (String? value) {
                    if(value?.trim().isEmpty ?? true){
                      return "Please Inter Your Value";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Phone'
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _passwordEditingController,
                  obscureText: true,
                  validator: (String? value) {
                    if((value != null && value.isNotEmpty) && value.length <6 ){
                      return "Please Inter Valid Password";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Password (optional)'
                  ),
                ),
                const SizedBox(height: 8,),
                const SizedBox(height: 8,),
                Visibility(
                  visible: _updateProfileInProgress == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: FilledButton(onPressed: _onTapUpdateButton,
                      child: Icon(Icons.arrow_circle_right_outlined)),
                ),
              ],
                    
            ),
          ),
        ),
      ),
    );
  }

  void _onTapUpdateButton() {
     if(_formKey.currentState!.validate()) {
        _updateProfile();
     }
  }

  Future<void> _updateProfile() async {
     _updateProfileInProgress = true;
     setState(() { });

     final Map<String, dynamic> requestBody ={
       "email":_emailEditingController.text,
       "firstName":_fnameEditingController.text.trim(),
       "lastName":_lnameEditingController.text.trim(),
       "mobile":_numberEditingController.text.trim(),
     };
     if( _passwordEditingController.text.isNotEmpty) {
       requestBody['password'] = _passwordEditingController.text;
     }

     String ? encodedPhoto;
     if(_selectedImage != null) {
       List<int> bytes = await _selectedImage!.readAsBytes();
       encodedPhoto= jsonEncode(bytes);
       requestBody['photo'] = encodedPhoto;
     }

     final ApiResponse response = await apiCaller.postRequest(
         url: Urls.updateProfile, body: requestBody);
     _updateProfileInProgress = false;
     setState(() {});

     if (response.isSuccess) {
       _passwordEditingController.clear();
       UserModel model = UserModel(
           id: AuthController.userModel!.id,
           email: _emailEditingController.text,
           firstname: _fnameEditingController.text,
           lastname: _lnameEditingController.text,
           mobile: _numberEditingController.text,
           photo: encodedPhoto ?? AuthController.userModel!.photo,
       );
       AuthController.updateUserdata(model);
       showSnakbarMessage(context, "Profile has been updated !");
     } else {
       showSnakbarMessage(context, response.errorMessage!);
     }
  }

  Future<void> _pickImage() async {
    try {
      // For mobile
      if (Theme.of(context).platform == TargetPlatform.android ||
          Theme.of(context).platform == TargetPlatform.iOS) {
        XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedImage != null) {
          _selectedImage = pickedImage;
          setState(() {});
        }
      } else {
        // For desktop (Windows/macOS/Linux)
        final result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null && result.files.single.path != null) {
          _selectedImage = XFile(result.files.single.path!);
          setState(() {});
        }
      }
    } catch (e) {
      print('Image pick error: $e');
    }
  }


  @override
  void dispose() {
    _emailEditingController.dispose();
    _fnameEditingController.dispose();
    _lnameEditingController.dispose();
    _numberEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }
}
