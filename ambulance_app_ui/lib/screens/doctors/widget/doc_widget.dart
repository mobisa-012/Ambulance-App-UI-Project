import 'package:ambulance_app_ui/screens/doctors/bloc/doc_bloc.dart';
import 'package:ambulance_app_ui/screens/doctors/panel/doc_details.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          docListView(context),
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

  BlocBuilder<DoctorBloc, DoctorState> docListView(BuildContext context) {
    return BlocBuilder(builder: (context, state) {
      if (state is DoctorLoadState) {
        final doctors = state.doctors;
        return Expanded(
          child: OverflowBox(
            maxWidth: MediaQuery.of(context).size.width,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                itemCount: doctors.length.toDouble() ~/ 2, // returns 2
                itemBuilder: (_, i) {
                  int a = 2 * i; //0,2
                  int b = 2 * i + 1; //0+1,3
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const DoctorDetailsPage()));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          height: 150,
                          margin: const EdgeInsets.only(
                              left: 30, bottom: 2, top: 15),
                          width: (MediaQuery.of(context).size.width - 90) / 2,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 254, 254, 255),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: const Offset(5, 5),
                                    color: Colors.black.withOpacity(0.1)),
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: const Offset(-5, -5),
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(doctors[a].image)),),
                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  Text(
                                    doctors[a].name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.deepPurpleAccent),
                                  ),
                                  Text(
                                    doctors[a].title,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const DoctorDetailsPage()));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          height: 150,
                          margin: const EdgeInsets.only(
                              left: 30, bottom: 2, top: 15),
                          width: (MediaQuery.of(context).size.width - 90) / 2,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 254, 254, 255),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: const Offset(5, 5),
                                    color: Colors.black.withOpacity(0.1)),
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: const Offset(-5, -5),
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(doctors[b].image))),
                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  Text(
                                    doctors[b].name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.deepPurpleAccent),
                                  ),
                                  Text(
                                    doctors[b].title,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
