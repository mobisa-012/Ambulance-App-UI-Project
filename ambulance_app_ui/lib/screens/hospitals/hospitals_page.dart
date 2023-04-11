// ignore_for_file: deprecated_member_use
import 'package:ambulance_app_ui/screens/hospitals/hos__book_appointment.dart';
import 'package:ambulance_app_ui/screens/hospitals/hos_appointment_form.dart';
import 'package:ambulance_app_ui/screens/hospitals/hospital_container.dart';
import 'package:ambulance_app_ui/screens/map_screen/page/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(200, 115, 64, 255),
        title: Text(
          'Let us find you a hospital',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => HomeScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => HosAppointment()));
                  },
                  // should open to allown client book an appointmetn
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: 180,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(200, 115, 64, 255),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 4.0,
                              spreadRadius: 1.1)
                        ]),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.local_hospital_rounded,
                          size: 50,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          'Book an appointment',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ClinicVisitAppointmentForm()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 145,
                    width: 180,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5.0,
                              spreadRadius: 1.1)
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: const Color.fromARGB(255, 254, 254, 255)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.home_filled,
                          color: Colors.deepPurple.withOpacity(0.1),
                          size: 45,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Home Visit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Call the doc home',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Hospitals')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot hospital = snapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: HospitalContainer(
                          name: hospital['name'],
                          link: hospital['lng'],
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
