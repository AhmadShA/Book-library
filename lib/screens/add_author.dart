// import 'dart:convert';
import 'package:csc_picker/csc_picker.dart';
// import 'package:csc_picker/model/select_status_model.dart';
import 'package:flutter/material.dart';
import 'package:music_site/components/my_button.dart';
import 'package:music_site/components/my_text_field.dart';
import 'package:http/http.dart' as http;

class AddAuthor extends StatefulWidget {
  const AddAuthor({super.key});

  @override
  State<AddAuthor> createState() => _AddAuthorState();
}

class _AddAuthorState extends State<AddAuthor> {
  List<String> items = ['Select your gender', 'Male', 'Female'];
  String selectedItem = 'Select your gender';
  late String selectedCountry;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  late String genderController;
  late String countryController;

  Future<void> _addAuthor(
      String firstName, String lastName, String gender, String country) async {
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
          Uri.https('e_librarydb.000webhostapp.com', '/API/AddAuthor.php');
      final response = await http.post(url, body: {
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'country': country,
      });
      if (mounted) {
        Navigator.of(context).pop();
      }
      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added Author successful!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );

          firstNameController.text = '';
          lastNameController.text = '';
          genderController = '';
          selectedItem = 'Select your gender';
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const AddAuthor()));
          // Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/AddAuthor');
        }
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
      // }
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
          "Add Author",
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
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        controller: firstNameController,
                        hintText: "First Name"),
                  ),
                  Expanded(
                    child: MyTextField(
                      controller: lastNameController,
                      hintText: "Last Name",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
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
                          // controller: genderController,
                          value: selectedItem,
                          items: items
                              .map((item) => DropdownMenuItem(
                                  value: item, child: Text(item)))
                              .toList(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedItem = newValue!;
                            });
                            genderController = selectedItem;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
                      color: const Color.fromARGB(255, 237, 235, 235)
                          .withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: CSCPicker(
                  dropdownDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  selectedItemStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  // layout: Layout.vertical,
                  showCities: false,
                  showStates: false,
                  flagState: CountryFlag.DISABLE,
                  onCountryChanged: (String? country) {
                    setState(() {
                      selectedCountry = country!;
                    });
                    countryController = selectedCountry;
                  },
                  onStateChanged: (state) {},
                  onCityChanged: (city) {},
                  dropdownDialogRadius: 30,
                  searchBarRadius: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                customColor: const Color.fromARGB(255, 185, 57, 10),
                text: "Add",
                onTap: () {
                  final firstName = firstNameController.text;
                  final lastName = lastNameController.text;
                  final gender = genderController;
                  final country = countryController;

                  // print("firstName= ${firstName} ");
                  // print("lastName = ${lastName} ");
                  // print("gender  =  ${gender} ");
                  // print("country =  ${country} ");

                  if (firstName != '' &&
                      lastName != '' &&
                      gender != '' &&
                      gender != 'Select your gender' &&
                      country != '') {
                    _addAuthor(firstName, lastName, gender, country);
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
