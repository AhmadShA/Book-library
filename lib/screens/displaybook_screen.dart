// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_string_interpolations, file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DisplayBookPage extends StatefulWidget {
  final String IDCust;
  const DisplayBookPage({super.key, required this.IDCust});

  @override
  State<DisplayBookPage> createState() => _DisplayBookPageState();
}

class _DisplayBookPageState extends State<DisplayBookPage> {
  int pressedItemIndex = -1;
  bool showCardForItem = false;
  List booksList = [];
  List mybooksList = [];
  // List filteredBooksList = [];
  // final TextEditingController _searchController = TextEditingController();
  Future getBooks() async {
    try {
      var url = "https://e_librarydb.000webhostapp.com/API/getBooks.php";
      var responseauthor = await http.get(Uri.parse(url));
      if (responseauthor.statusCode == 200) {
        var items = json.decode(responseauthor.body);
        setState(() {
          booksList = items;
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

  final TextEditingController CreditCardController = TextEditingController();
  late String totalPrice;
  late String ID_book;

  Future<void> _buyBook(
      String CreditCard, String Total, String ID, String BookID) async {
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
          Uri.parse('https://e_librarydb.000webhostapp.com/API/buyBook.php');
      final response = await http.post(url, body: {
        'Total': Total.toString(),
        'CreditCard': CreditCard,
        'IDUser': ID,
        'ID_book': BookID,
      });
      if (mounted) {
        Navigator.of(context).pop();
      }

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          try {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('The book successful buy it!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                ),
              );
              CreditCardController.text = '';
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Congratulations, the book has been downloaded',
                      style: TextStyle(
                        color: Colors.greenAccent,
                      ),
                    ),
                    actions: <Widget>[
                      Text(
                        "The amount of ${totalPrice.toString()}\$ has been withdrawn from your balance ",
                        style: const TextStyle(
                          color: Colors.aqua,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            getMyBooks(widget.IDCust);
                            getBooks();
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            }
          } catch (e) {
            if (e is FormatException) {
              print('FormatException: $e');
            } else {
              print('Unknown exception: $e');
            }
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

  Future<void> getMyBooks(String myID) async {
    try {
      var url =
          Uri.parse("https://e_librarydb.000webhostapp.com/API/myBooks.php");
      final responseauthormyBook = await http.post(url, body: {
        'ID_user': myID,
      });
      if (responseauthormyBook.statusCode == 200) {
        var myBookItems = json.decode(responseauthormyBook.body);
        setState(() {
          mybooksList = myBookItems;
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

  String id = '';
  @override
  void initState() {
    getMyBooks(widget.IDCust);
    getBooks();
    id = widget.IDCust;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: const Text(
            "All Books ",
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
            itemCount: booksList.length,
            itemBuilder: (cts, i) {
              final item = booksList[i]['Title'];
              // final isDownloaded = mybooksList.contains(item);
              final isDownloaded =
                  mybooksList.any((element) => element['Title'] == item);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Title Book: ${booksList[i]["Title"]}",
                        style: const TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 73, 47, 7),
                            fontFamily: 'Times New Roman'),
                      ),
                      subtitle: Text("Type of Book: ${booksList[i]["Type"]}"),
                      leading: CircleAvatar(
                        radius: 20,
                        child: Text(
                            "${booksList[i]["Title"].toString().substring(0, 2)}"),
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
                            totalPrice = booksList[i]["Price"].toString();
                            ID_book = booksList[i]["ID_book"].toString();
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
                                      "Price of book is: ${booksList[i]["Price"]}\$",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      "The Author is: ${booksList[i]["Fname"]} ${booksList[i]["Lname"]}",
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                isDownloaded == false
                                    ? IconButton(
                                        icon: const Icon(Icons.download),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Enter Credit Card Number'),
                                                content: TextField(
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText:
                                                        'Credit Card Number',
                                                  ),
                                                  controller:
                                                      CreditCardController,
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child:
                                                        const Text('Download'),
                                                    onPressed: () {
                                                      final creditCard =
                                                          CreditCardController
                                                              .text;
                                                      final TotalPrice =
                                                          totalPrice.toString();
                                                      final IDbook =
                                                          ID_book.toString();

                                                      if (creditCard != '') {
                                                        _buyBook(
                                                            creditCard,
                                                            TotalPrice,
                                                            id,
                                                            IDbook);
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                'Verify the input'),
                                                            backgroundColor:
                                                                Colors.aqua,
                                                            duration: Duration(
                                                                seconds: 1),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      )
                                    : IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.download_done))
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
