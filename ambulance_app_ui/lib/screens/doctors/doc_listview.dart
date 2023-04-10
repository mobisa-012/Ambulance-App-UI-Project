import 'package:ambulance_app_ui/screens/doctors/doc_appointment_form.dart';
import 'package:ambulance_app_ui/screens/doctors/doc_review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocListView extends StatelessWidget {
  const DocListView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Doctors').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot doctor = snapshot.data!.docs[index];
              return ListTile(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (
                        BuildContext context,
                      ) {
                        return SingleChildScrollView(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Doctors')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }
                                DocumentSnapshot<Map<String, dynamic>> doc =
                                    snapshot.data!.docs[index];
                                if (!doc.exists ||
                                    !doc.data()!.containsKey('name') ||
                                    !doc.data()!.containsKey('aboutDoc') ||
                                    !doc.data()!.containsKey('image') ||
                                    !doc.data()!.containsKey('price') ||
                                    !doc.data()!.containsKey('location') ||
                                    !doc.data()!.containsKey('phone') ||
                                    !doc.data()!.containsKey('title')) {
                                  return CircularProgressIndicator();
                                }
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1.1,
                                            spreadRadius: 1.2,
                                            color:
                                                Colors.white.withOpacity(0.3))
                                      ]),
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(doc.data()!['image']),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Center(
                                        child: Text(
                                          doc.data()!['name'],
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  launch(
                                                      'tel:${doc.get('phone')}');
                                                },
                                                icon: Icon(
                                                  Icons.call,
                                                  size: 20,
                                                )),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                    Icons.message_outlined))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'About doctor',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        doc.data()!['aboutDoc'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Reviews',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      DocReview(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Location',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            doc.data()!['location'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Consultaion',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            doc.data()!['price'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(500, 60),
                                              backgroundColor:
                                                  Colors.deepPurpleAccent),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            DocAppointment()));
                                          },
                                          child: Text(
                                            'Book appointment',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ))
                                    ],
                                  ),
                                );
                              }),
                        );
                      });
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(doctor['image']),
                ),
                title: Text(doctor['name']),
                subtitle: Text(doctor['title']),
                trailing: Text(doctor['location']),
              );
            },
          ),
        );
      },
    );
  }
}
