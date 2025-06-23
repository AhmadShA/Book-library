// ignore_for_file: unnecessary_string_interpolations, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchOfAuthors extends StatefulWidget {
  const SearchOfAuthors({super.key});

  @override
  State<SearchOfAuthors> createState() => _SearchOfAuthorsState();
}

class _SearchOfAuthorsState extends State<SearchOfAuthors> {
  int pressedItemIndex = -1;
  bool showCardForItem = false;
  List authorList = [];
  Future getAuthors() async {
    try {
      var url =
          "https://e_librarydb.000webhostapp.com/API/getAllauthorWithDetails.php";
      var responseauthor = await http.get(Uri.parse(url));
      if (responseauthor.statusCode == 200) {
        var items = json.decode(responseauthor.body);
        setState(() {
          authorList = items;
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

  List _filteredItems = [];
  List filterItems(String query) {
    if (query == null || query.isEmpty) {
      return authorList;
    }
    return authorList
        .where((element) =>
            element['Fname'].contains(query) ||
            element['Lname'].contains(query))
        .toList();
  }

  @override
  void initState() {
    getAuthors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text(
          "Search of Authors",
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search",
                icon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                setState(() {
                  _filteredItems = filterItems(value);
                });
              },
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _filteredItems.length,
                  itemBuilder: (cts, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Author Name: ${_filteredItems[i]["Fname"]} ${_filteredItems[i]["Lname"]}",
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Color.fromARGB(255, 73, 47, 7),
                                  fontFamily: 'Times New Roman'),
                            ),
                            subtitle: Text(
                                "Author gender: ${_filteredItems[i]["gender"]}"),
                            leading: CircleAvatar(
                              radius: 20,
                              child: Text(
                                  "${_filteredItems[i]["Fname"].toString().substring(0, 2)}"),
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
                            selectedTileColor:
                                const Color.fromARGB(179, 255, 153, 0),
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Author country: ${_filteredItems[i]["country"]}",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        "Author's books: ${_filteredItems[i]["Title"]}",
                                        style: const TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
