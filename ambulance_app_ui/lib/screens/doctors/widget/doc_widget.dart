import 'package:ambulance_app_ui/screens/doctors/widget/doc_listview.dart';
import 'package:flutter/material.dart';


class DoctorWidget extends StatelessWidget {
  const DoctorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          docContainers(context),
          const SizedBox(
            height: 20,
          ),
          docText(),
          const SizedBox(
            height: 15,
          ),
          DoctorsListView(),
        ],
      ),
    );
  }

  Widget docContainers(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          height: 145,
          width: 180,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(color: Colors.white, blurRadius: 4.0, spreadRadius: 1.1)
            ],
            color: Color.fromARGB(200, 115, 64, 255),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(
                Icons.local_hospital_rounded,
                size: 45,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Clinic Visit',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Make an appointment',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
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
              borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Call the doc home',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget docText() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: 'Let\'s find you a doc...',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black))
      ]),
    );
  }
}
