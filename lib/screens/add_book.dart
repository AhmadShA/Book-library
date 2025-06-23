// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:e_library/components/my_button.dart';
import 'package:e_library/components/my_text_field.dart';
import 'package:http/http.dart' as http;

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  List authorNames = [];

  Future getAuthors() async {
    try {
      var url = "https://e_librarydb.000webhostapp.com/API/getAuthors.php";
      var responseauthor = await http.get(Uri.parse(url));
      if (responseauthor.statusCode == 200) {
        var items = json.decode(responseauthor.body);
        setState(() {
          authorNames = items;
        });
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

  var NameselectedAuthor;
  var IDselectedAuthor;

  @override
  void initState() {
    super.initState();
    getAuthors();
  }

  final TextEditingController TitleBookController = TextEditingController();
  final TextEditingController TypeBookController = TextEditingController();
  final TextEditingController PriceBookController = TextEditingController();

  Future<void> _addBook(
      String Title, String Type, String Price, String IDauthor) async {
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
          Uri.https('e_librarydb.000webhostapp.com', '/API/AddBook.php');
      final response = await http.post(url, body: {
        'Title': Title,
        'Type': Type,
        'Price': Price,
        'ID_author': IDauthor,
      });
      if (mounted) {
        Navigator.of(context).pop();
      }

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added Book successful!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
        }

        TitleBookController.text = '';
        TypeBookController.text = '';
        PriceBookController.text = '';
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const AddBook()));
        Navigator.pushReplacementNamed(context, '/AddBook');
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added failed: ${response.body}'),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text(
          "Add Book",
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
                width: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(controller: TitleBookController, hintText: "Title"),
              const SizedBox(height: 10),
              MyTextField(controller: TypeBookController, hintText: "Type"),
              const SizedBox(height: 10),
              MyTextField(
                controller: PriceBookController,
                icon: Icons.price_change,
                hintText: "Price",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 203, 202, 202)
                          .withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          hint: const Text("select an author"),
                          // value: NameselectedAuthor ?? emptySelect,
                          items: authorNames.map((author) {
                            return DropdownMenuItem(
                                value: author['ID_author'],
                                child: Text(
                                    author['Fname'] + ' ' + author['Lname']));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              NameselectedAuthor = authorNames.firstWhere(
                                      (author) =>
                                          author['ID_author'] ==
                                          value)['Fname'] +
                                  ' ' +
                                  authorNames.firstWhere((author) =>
                                      author['ID_author'] == value)['Lname'];
                              IDselectedAuthor = value;
                            });
                            // IDAuthorController = IDselectedAuthor;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IDselectedAuthor != null
                  ? Text(
                      "Author Selected is:  $NameselectedAuthor \n his/her Id is: $IDselectedAuthor",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 185, 57, 10),
                      ),
                    )
                  : const Text(""),
              const SizedBox(
                height: 12,
              ),
              MyButton(
                customColor: const Color.fromARGB(255, 185, 57, 10),
                text: "Add",
                onTap: () {
                  final TitleBook = TitleBookController.text;
                  final TypeBook = TypeBookController.text;
                  final PriceBook = PriceBookController.text;
                  final AuthorofBook = IDselectedAuthor;

                  if (TitleBook != '' &&
                      TypeBook != '' &&
                      PriceBook != '' &&
                      IDselectedAuthor != null &&
                      AuthorofBook != '') {
                    _addBook(TitleBook, TypeBook, PriceBook,
                        AuthorofBook.toString());
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
            ],
          ),
        ),
      ),
    );
  }
}
