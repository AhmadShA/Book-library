import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_library/components/my_button.dart';
import 'package:e_library/components/my_text_field.dart';
import 'package:e_library/screens/login_screen.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showPass = false;
  bool showConfirm = false;
  showConfPass() {
    setState(() {
      showConfirm = !showConfirm;
    });
  }

  showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> _registerUser(String username, String password, String firstName,
      String lastName, String address, String email) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
                child: CircularProgressIndicator(
              color: const Color.fromARGB(255, 185, 57, 10),
              backgroundColor:
                  const Color.fromARGB(255, 203, 202, 202).withOpacity(0.5),
            ));
          });

      final url =
          Uri.https('e_librarydb.000webhostapp.com', '/API/AddUser.php');
      final response = await http.post(url, body: {
        'username': username,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'email': email,
      });
      if (mounted) {
        Navigator.of(context).pop();
      }

      var getData = json.decode(response.body);
      if (getData == 'errorExiste') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('This user name or email already existe, try another'),
              backgroundColor: Color.fromARGB(255, 255, 28, 7),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        if (response.statusCode == 200) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration successful!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
            usernameController.text = '';
            passwordController.text = '';
            confirmpasswordController.text = '';
            firstNameController.text = '';
            lastNameController.text = '';
            addressController.text = '';
            emailController.text = '';
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registration failed: ${response.body}'),
                backgroundColor: Colors.aqua,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No internet connection'),
            backgroundColor: Color.fromARGB(255, 255, 28, 7),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.white),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.logout),
        //     onPressed: () {
        //       Navigator.pushReplacementNamed(context, '/login');
        //     },
        //   ),
        // ],
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 185, 57, 10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo4.jpg",
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  controller: usernameController, hintText: "User Name"),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        controller: firstNameController,
                        hintText: "First Name"),
                  ),
                  Expanded(
                    child: MyTextField(
                        controller: lastNameController, hintText: "Last Name"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                onPressed: showPassword,
                obsecureText: showPass ? false : true,
                icon: showPass ? Icons.visibility_off : Icons.visibility,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: confirmpasswordController,
                hintText: "Confirm Password",
                onPressed: showConfPass,
                obsecureText: showConfirm ? false : true,
                icon: showConfirm ? Icons.visibility_off : Icons.visibility,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: addressController,
                hintText: "Address",
                keyboardType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                customColor: const Color.fromARGB(255, 185, 57, 10),
                text: "Sign Up",
                onTap: () {
                  final username = usernameController.text;
                  final pwd = passwordController.text;
                  final confirmpwd = confirmpasswordController.text;
                  final firstName = firstNameController.text;
                  final lastName = lastNameController.text;
                  final address = addressController.text;
                  final email = emailController.text;

                  if (pwd == confirmpwd &&
                      username != '' &&
                      firstName != '' &&
                      lastName != '' &&
                      address != '' &&
                      email != '') {
                    final password = passwordController.text;
                    _registerUser(username, password, firstName, lastName,
                        address, email);
                  } else if (pwd != confirmpwd) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password does not match'),
                        backgroundColor: Colors.aqua,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Verify the input'),
                        backgroundColor: Colors.aqua,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 238, 48, 6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color.fromARGB(255, 238, 130, 6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
