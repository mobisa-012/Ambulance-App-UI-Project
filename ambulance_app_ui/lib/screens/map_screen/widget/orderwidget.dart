import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  final CollectionReference ambulancesCollection =
      FirebaseFirestore.instance.collection('Ambulances');
  final PanelController panelController = PanelController();
  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: panelController,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      minHeight: 50,
      maxHeight: MediaQuery.of(context).size.height * 0.5,
      panel:  Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            'Enter your location',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          // TextField(
          //   controller: locationController,
          //   decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.location_on,
          //           color: Color.fromARGB(200, 115, 64, 255)),
          //       hintText: 'e.g harambee Avenue Nairobi',
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(15)))),
          // ),
          const SizedBox(
            height: 6,
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(200, 115, 64, 255),
                  minimumSize: Size(100, 50)),
              onPressed: () {},
              child: Text(
                'Search',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(200, 115, 64, 255),
                  minimumSize: Size(200, 50)),
              onPressed: () {},
              child: Text(
                'Order',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
