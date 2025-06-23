import 'package:flutter/material.dart';
import 'package:e_library/components/my_button.dart';
import 'package:e_library/components/my_text_field.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({super.key});

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Invoice",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 185, 57, 10),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 40,
              // ),
              Image.asset(
                "assets/logo4.jpg",
                width: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  // color:
                  // const Color.fromARGB(255, 203, 202, 202).withOpacity(0.5),
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownMenu(
                        // controller: iconController,
                        width: double.maxFinite,
                        enableFilter: true,
                        requestFocusOnTap: true,
                        label: Text('Select The User'),
                        inputDecorationTheme: InputDecorationTheme(
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 3.0),
                        ),
                        dropdownMenuEntries: [],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const MyTextField(
                hintText: "Date",
                keyboardType: TextInputType.datetime,
                icon: Icons.date_range,
              ),
              const SizedBox(height: 10),
              const MyTextField(
                hintText: "Total",
              ),
              const SizedBox(height: 10),
              const MyTextField(
                hintText: "credit Card",
                icon: Icons.credit_card,
              ),
              // DatePickerDialog(firstDate: , lastDate: 9999),
              const SizedBox(height: 10),
              // const MyTextField(
              //   icon: Icons.price_change,
              //   hintText: "Price",
              //   keyboardType: TextInputType.number,
              // ),
              const SizedBox(height: 10),

              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 25),
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              //   decoration: BoxDecoration(
              //     // color:
              //     // const Color.fromARGB(255, 203, 202, 202).withOpacity(0.5),
              //     borderRadius: BorderRadius.circular(12),
              //     boxShadow: [
              //       BoxShadow(
              //         color: const Color.fromARGB(255, 203, 202, 202)
              //             .withOpacity(0.5),
              //         spreadRadius: 1,
              //         blurRadius: 1,
              //       ),
              //     ],
              //   ),
              //   child: const Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: DropdownMenu(
              //           // controller: iconController,
              //           width: double.maxFinite,
              //           enableFilter: true,
              //           requestFocusOnTap: true,
              //           label: Text('Select an Author'),
              //           inputDecorationTheme: InputDecorationTheme(
              //             filled: true,
              //             contentPadding: EdgeInsets.symmetric(vertical: 3.0),
              //           ),
              //           dropdownMenuEntries: [],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: DropdownMenu(
              //         // controller: iconController,
              //         enableFilter: true,
              //         requestFocusOnTap: true,
              //         // leadingIcon: Icon(Icons.s),
              //         label: Text('Select an Author'),
              //         inputDecorationTheme: InputDecorationTheme(
              //           filled: true,
              //           contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              //         ),
              //         dropdownMenuEntries: [],
              //         // onSelected: () {},
              //         // dropdownMenuEntries:
              //         //   IconLabel.values.map<DropdownMenuEntry>(
              //         // (IconLabel icon) {
              //         // return DropdownMenuEntry(
              //         // value: icon,
              //         // label: icon.label,
              //         //   leadingIcon: Icon(icon.icon),
              //         // );
              //         // },
              //         // ).toList(),
              //       ),
              //     ),
              //   ],
              // ),

              const SizedBox(
                height: 12,
              ),

              MyButton(
                customColor: const Color.fromARGB(255, 185, 57, 10),
                text: "Add",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
