import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_managenent/ui/widgets/tm_appbar.dart';

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

  final ImagePicker _imagePicker = ImagePicker();
   XFile? _selectedImage ;

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
                  decoration: InputDecoration(
                      hintText: 'Email'
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _fnameEditingController,
                  decoration: InputDecoration(
                      hintText: 'First Name'
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _lnameEditingController,
                  decoration: InputDecoration(
                      hintText: 'Last Name'
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _numberEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Phone'
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _passwordEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password'
                  ),
                ),
                const SizedBox(height: 8,),
                const SizedBox(height: 8,),
                FilledButton(onPressed: (){},
                    child: Icon(Icons.arrow_circle_right_outlined)),
              ],
                    
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = pickedImage ;
      setState(() {});

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
