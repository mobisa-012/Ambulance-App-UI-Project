import 'package:ambulance_app_ui/core/data/doc_appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DocAppointment extends StatefulWidget {
  const DocAppointment({super.key});

  @override
  State<DocAppointment> createState() => _DocAppointmentState();
}

class _DocAppointmentState extends State<DocAppointment> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController docNameController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  // final homeController = TextEditingController();
  // String address = '';

  @override
  void dispose() {
    docNameController.dispose();
    dateController.dispose();
    timeController.dispose();
    // homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('Book appointment'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 22, left: 10, right: 10),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: docNameController,
                  decoration: InputDecoration(
                      labelText: 'Enter doc name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter doc name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
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
                  height: 20,
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
                  height: 30,
                ),
                // TextField(
                //   controller: homeController,
                // ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Appointment appointment = Appointment(
                          date: dateController.text,
                          time: timeController.text,
                          doc: docNameController.text);
                      FirebaseFirestore.instance
                          .collection('doc_appointments')
                          .add(appointment.toJson())
                          .then((value) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Appointment status'),
                                content: Text(
                                  'Appointment added successfully',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
