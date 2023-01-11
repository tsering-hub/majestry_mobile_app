import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:majestry_mobile_app/model/user_model.dart';
import 'package:majestry_mobile_app/repository/user_repository.dart';
import 'package:majestry_mobile_app/utils/show_message.dart';

class UpdateprofileModel extends StatefulWidget {
  final String? name;

  const UpdateprofileModel({Key? key, this.name}) : super(key: key);

  @override
  State<UpdateprofileModel> createState() => _UpdateprofileModelState();
}

class _UpdateprofileModelState extends State<UpdateprofileModel> {
  final _nameController = TextEditingController();
  final _contactnoController = TextEditingController();

  String selectedDate = "Select Date";
  DateTime _date = DateTime(2010, 1);

  // Initial Selected Value
  String dropdownvalue = 'Male';

  // List of items in our dropdown menu
  var items = [
    'Male',
    'Female',
    'Others',
  ];

  datePicker() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1960, 1),
      lastDate: DateTime(2010, 1),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        selectedDate = DateFormat('yyyy-MM-dd').format(_date).toString();
      });
    }
  }

  _updatePatientProfile(UserModel user) async {
    bool isUpdated = await UserRepository().updateProfile(user);
    _displayMessage(isUpdated);
  }

  _displayMessage(bool isUpdated) {
    if (isUpdated) {
      Navigator.pushNamed(context, "/dashboardScreen");
      displaySuccessMessage(context, "Updated Success");
    } else {
      displayErrorMessage(context, "Update Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _nameController.text = widget.name!;
    });
    return SizedBox(
      height: 550,
      child: SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _contactnoController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Phone Number",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("Gender : "),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Date of Birth : "),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        datePicker();
                      },
                      child: Text(
                        selectedDate,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green[700])),
                    onPressed: () {
                      setState(() {
                        UserModel user = UserModel(
                            name: _nameController.text,
                            contactno: _contactnoController.text,
                            gender: dropdownvalue,
                            dob: selectedDate);
                        _updatePatientProfile(user);
                      });
                    },
                    child: const Text("Update")),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[700])),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
