// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:e_library/components/my_button.dart';
import 'package:e_library/components/my_text_field.dart';
import 'package:e_library/screens/admin_page.dart';
import 'package:e_library/screens/user.dart';
// import 'package:e_library/screens/displaybook_screen.dart';
import 'package:e_library/screens/signup_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPass = false;
  showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }

  bool chekTheBox = false;
  check() {
    setState(() {
      chekTheBox = !chekTheBox;
    });
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _loginuser(String username, String password) async {
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
      final url = Uri.parse(
          'https://e_librarydb.000webhostapp.com/API/verifyLogin.php');
      final response = await http.post(url, body: {
        'username': username,
        'password': password,
      });
      if (mounted) {
        Navigator.of(context).pop();
      }

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var getData = json.decode(response.body);
          if (getData['status'] == 'successAdminLogin') {
            final ID = getData['ID'];
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Admin successful!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                ),
              );
              usernameController.text = '';
              passwordController.text = '';
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AdminPage()));
            }
          } else if (getData['status'] == 'successLogin') {
            final ID = getData['ID'];
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login successful!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                ),
              );
              var userName = usernameController.text;
              usernameController.text = '';
              passwordController.text = '';
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserPage(
                            username: userName,
                            ID: getData['ID'].toString(),
                          )));
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Username, Email or Password are Incorrect!'),
                  backgroundColor: Colors.aqua,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Empty response body:  ${response.body}'),
                backgroundColor: Colors.aqua,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${response.statusCode}'),
              backgroundColor: Colors.aqua,
              duration: const Duration(seconds: 3),
            ),
          );
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Log In",
          style: TextStyle(color: Colors.white),
        ),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/logo4.jpg",
                width: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: usernameController,
                hintText: "Email or User Name",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                onPressed: showPassword,
                obsecureText: showPass ? false : true,
                icon: showPass ? Icons.visibility_off : Icons.visibility,
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                customColor: const Color.fromARGB(255, 185, 57, 10),
                text: "Sign IN",
                onTap: () {
                  final username = usernameController.text;
                  final password = passwordController.text;

                  if (password != '' && username != '') {
                    _loginuser(username, password);
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
                    "Don't have an account?",
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
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color.fromARGB(255, 238, 130, 6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
