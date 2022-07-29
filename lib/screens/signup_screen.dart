import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/screens_layout/all.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

// stateful cos image changing
class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  // clear the controllers as soon as the widgets got cleared
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(
      () {
        _image = im;
      },
    );
  }

  void signUpUser() async {
    setState(() {
      // tell user in the midst of signing-up!
      _isLoading = true;
    });

    // ! asynchronous
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image == null
          ? (await rootBundle.load('assets/images/default_user.jpeg'))
              .buffer
              .asUint8List()
          : _image!,
    );

    setState(() {
      // done signing-up!
      _isLoading = false;
    });
    if (res != 'success') {
      // "success" decided in auth_methods.dart
      showSnackBar(res, context);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                )),
      );
    }
  }

  /*
  Brings user to sign up screen when clicked
  */
  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // accounts for OS interface
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
          ),
          width: double.infinity, // full width of device
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // display image
              SvgPicture.asset(
                'assets/images/ig_logo.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              // circular widget to accept and show our selected file
              Stack(
                children: [
                  // ternary operator to check if image is null
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage('assets/images/default_user.jpeg'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              //* textfield input for username
              TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: "Enter username",
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              //* textfield input for email
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Enter email address",
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 24,
              ),
              //* textfield input for password
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter password",
                textInputType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(
                height: 24,
              ),
              //* textfield input for bio
              TextFieldInput(
                  textEditingController: _bioController,
                  hintText: "Enter bio",
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),

              ElevatedButton(
                  // inkwell not suitable because applying color may cover the effects of inkwell
                  onPressed: signUpUser,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            'SIGN UP',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                  )),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already Have An Account?"),
                  ),
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Login Here!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
