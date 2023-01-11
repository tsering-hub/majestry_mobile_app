import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateprofileModel extends StatefulWidget {
  const UpdateprofileModel({Key? key}) : super(key: key);

  @override
  State<UpdateprofileModel> createState() => _UpdateprofileModelState();
}

class _UpdateprofileModelState extends State<UpdateprofileModel> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _contactnoController = TextEditingController();
  final _genderController = TextEditingController();

  String selectedDate = "Select Date";

  DateTime _date = DateTime.now();

  datePicker() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2024, 1),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        selectedDate = DateFormat('yyyy-MM-dd').format(_date).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 640,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 195, 205, 255)),
                  ),
                  onPressed: () {
                    datePicker();
                  },
                  child: Text(
                    selectedDate,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // if (_formKey.currentState!
                      //     .validate()) {
                      //   UserModel patient =
                      //       UserModel(
                      //     firstname:
                      //         _firstController.text,
                      //     lastname:
                      //         _lastController.text,
                      //     email: _emailController.text,
                      //     address:
                      //         _addressController.text,
                      //     phone: _phoneController.text,
                      //   );
                      //   _updatePatientProfile(patient);
                      // }
                    });
                  },
                  child: const Text("Update")),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          ),
        ),
      ),
    );
  }
}
