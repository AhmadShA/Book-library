// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyBooks extends StatefulWidget {
  final String IDCust;
  const MyBooks({super.key, required this.IDCust});

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  int pressedItemIndex = -1;
  bool showCardForItem = false;
  List mybooksList = [];
  Future<void> getMyBooks(String myID) async {
    try {
      var url =
          Uri.parse("https://e_librarydb.000webhostapp.com/API/myBooks.php");
      final responseauthor = await http.post(url, body: {
        'ID_user': myID,
      });
      if (responseauthor.statusCode == 200) {
        var items = json.decode(responseauthor.body);
        setState(() {
          mybooksList = items;
          // filteredBooksList = items;
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

  @override
  void initState() {
    getMyBooks(widget.IDCust);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: const Text(
            "My Books ",
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
        body: ListView.builder(
            itemCount: mybooksList.length,
            itemBuilder: (cts, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Title Book: ${mybooksList[i]["Title"]}",
                        style: const TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 73, 47, 7),
                            fontFamily: 'Times New Roman'),
                      ),
                      subtitle: Text("Type of Book: ${mybooksList[i]["Type"]}"),
                      leading: CircleAvatar(
                        radius: 20,
                        child: Text(
                            "${mybooksList[i]["Title"].toString().substring(0, 2)}"),
                      ),
                      trailing: IconButton.filled(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            pressedItemIndex = i;
                            showCardForItem = !showCardForItem;
                          });
                        },
                        icon: const Icon(Icons.info),
                      ),
                      dense: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      tileColor: const Color.fromARGB(136, 202, 91, 50),
                      selected: pressedItemIndex == i && showCardForItem,
                      selectedTileColor: const Color.fromARGB(179, 255, 153, 0),
                      enabled: true,
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      splashColor: Colors.white,
                    ),
                    if (showCardForItem && pressedItemIndex == i)
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5.0,
                          margin: const EdgeInsets.all(16.0),
                          color: Colors.white,
                          shadowColor: Colors.black,
                          clipBehavior: Clip.antiAlias,
                          surfaceTintColor: Colors.orange,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Price of book is: ${mybooksList[i]["Total"]}\$",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      "The Author is: ${mybooksList[i]["Fname"]} ${mybooksList[i]["Lname"]}",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      "Downloaded at: ${mybooksList[i]["Date"]}",
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }));
  }
}
