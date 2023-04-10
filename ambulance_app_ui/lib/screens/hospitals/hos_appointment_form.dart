import 'package:ambulance_app_ui/core/data/hos_appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HosAppointment extends StatefulWidget {
  const HosAppointment({super.key});

  @override
  State<HosAppointment> createState() => _HosAppointmentState();
}

class _HosAppointmentState extends State<HosAppointment> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController hosNameController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final deptController = TextEditingController();
  final wingController = TextEditingController();

  @override
  void dispose() {
    hosNameController.dispose();
    dateController.dispose();
    timeController.dispose();
    deptController.dispose();
    wingController.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(                  
                  controller: hosNameController,
                  decoration: InputDecoration(
                      labelText: 'Enter hospital name',
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
                  controller: deptController,
                  decoration: InputDecoration(
                      labelText: 'Enter department name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter department name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: wingController,
                  decoration: InputDecoration(
                      labelText: 'Enter wing',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter wing name';
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
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      HospitalAppointment appointment = HospitalAppointment(
                          date: dateController.text,
                          time: timeController.text,
                          hospital: hosNameController.text,
                          department: deptController.text,
                          wing: wingController.text);
                      FirebaseFirestore.instance
                          .collection('hos_appointments')
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
