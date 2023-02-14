import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OrderScreenDetails extends StatelessWidget {
  final PanelController panelController;
  const OrderScreenDetails({super.key, required this.panelController});

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDragHandle(),
          const SizedBox(
            height: 25,
          ),
          _buildAboutText(),
          const SizedBox(
            height: 25,
          ),
          _buildMoreDocInfo(),
          const SizedBox(
            height: 25,
          ),
          _createLocationDetails(context),
          const SizedBox(
            height: 25,
          ),
          _createConsultationPrice(),
          const SizedBox(
            height: 25,
          ),
          _createCallButton(context)
        ],
      ),
    );
  }
  Widget buildDragHandle() {
    return GestureDetector(
      onTap: togglePanel,
      child: Center(
        child: Container(
          height: 10,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
  Widget _buildAboutText() {
    return Row(
      children: const [
        Text(
          'About Doctor',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget _buildMoreDocInfo() {
    return const Text(
      'Dr.Mobisa is an experienced specialist who is constantly working on improving her skills',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }

  Widget _createLocationDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, left: 25, right: 30),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(0.2))
              ]),
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.location_on,
                size: 30,
                color: Colors.deepPurpleAccent,
              ),
              const SizedBox(
                width: 80,
              ),
              Column(
                children: const [
                  Text(
                    'Lotus Medical Center',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('3516 W. Gray St Utica, Nairobi')
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _createConsultationPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Consultation price',
          style: TextStyle(
              color: Color.fromARGB(225, 119, 107, 107),
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        Text(
          'sh.10,000',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
        )
      ],
    );
  }

  Widget _createCallButton(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(80),
      ),
      child: GestureDetector(
          child: const Center(
              child: Text(
            'Call',
            style: TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.w600),
          )),
          onTap: () {}),
    );
  }
}
