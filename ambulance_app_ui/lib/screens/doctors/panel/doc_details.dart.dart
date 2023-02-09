import 'package:ambulance_app_ui/screens/doctors/panel/doctor_panel_details.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DoctorDetailsPage extends StatefulWidget {
  const DoctorDetailsPage({super.key});

  @override
  State<DoctorDetailsPage> createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  final panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
        //replace with white
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                    child: Icon(
                  Icons.account_circle_rounded,
                  size: 180,
                )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Dr.Mobisa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Therapist',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.call,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.message_sharp,
                        size: 40,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SlidingUpPanel(
              backdropOpacity: 0.1,
              backdropEnabled: true,
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              isDraggable: true,
              maxHeight: MediaQuery.of(context).size.height * 0.55,
              minHeight: MediaQuery.of(context).size.height * 0.50,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              panel: DoctorPanelDetails(
                panelController: panelController,
              ))
        ],
      ),
    );
  }
}
