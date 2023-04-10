import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstPanel extends StatefulWidget {
  final ScrollController controller; 
  FirstPanel({super.key, required this.controller});

  @override
  State<FirstPanel> createState() => _FirstPanelState();
}

class _FirstPanelState extends State<FirstPanel> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Ambulances').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ambulance = snapshot.data!.docs[index];
              return ListTile(
                onTap: () {
                  launch('tel:${ambulance.get('phoneNumber')}');
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(ambulance['image']),
                ),
                trailing: Text(ambulance['plateNo']),
                title: Text(ambulance['ambType']),
                subtitle: Text(ambulance['cost']),
              );
            },
          ),
        );
      },
    );
  }
}
