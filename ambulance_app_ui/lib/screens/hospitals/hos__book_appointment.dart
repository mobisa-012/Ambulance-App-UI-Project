import 'package:ambulance_app_ui/core/data/clinic_visit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClinicVisitAppointmentForm extends StatefulWidget {
  const ClinicVisitAppointmentForm({super.key});

  @override
  State<ClinicVisitAppointmentForm> createState() =>
      _ClinicVisitAppointmentFormState();
}

class _ClinicVisitAppointmentFormState
    extends State<ClinicVisitAppointmentForm> {
  final formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final conditionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final paymentController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    nameController.dispose();
    addressController.dispose();
    conditionController.dispose();
    dateController.dispose();
    timeController.dispose();
    paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home visit',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 126, 96, 207),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: 'Enter your full name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: 'Enter your phone number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18,),
                TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      labelText: 'Enter your physical address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your physical address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: conditionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'How do you feel?',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your condition details';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: Icon(Icons.calendar_month_outlined),
                      labelText: 'Date'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2027));
                    if (pickedDate != null) {
                      setState(() {
                        dateController.text =
                            DateFormat('yyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter date';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      prefixIcon: const Icon(Icons.punch_clock),
                      labelText: 'Select Time'),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 00, minute: 00),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        String formattedTime =
                            '${pickedTime.hour.toString().padLeft(2, '0')}: ${pickedTime.minute.toString().padLeft(2, '0')}';
                        timeController.text = formattedTime;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: paymentController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'payment mode e.g. M-pesa, cash, insurance..,',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter payment mode';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ClinicVisit cLinicVisit = ClinicVisit(
                          address: addressController.text,
                          condition: conditionController.text,
                          date: dateController.text,
                          name: nameController.text,
                          payment: paymentController.text,
                          phoneNumber: phoneNumberController.text,
                          time: timeController.text,
                        );
                        FirebaseFirestore.instance
                            .collection('home_visit_appointments')
                            .add(cLinicVisit.toJson())
                            .then((value) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Appointment status'),
                                  content: Text(
                                    'Appointment received. You will recieve a call shortly to confirm',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.deepPurpleAccent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Ok',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ))
                                  ],
                                );
                              });
                        }).catchError((e) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Appointment status'),
                                  content: Text(
                                    'Failed to add appointment $e.\n Contact support.',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.deepPurpleAccent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok'))
                                  ],
                                );
                              });
                        });
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 2,
                        backgroundColor: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
