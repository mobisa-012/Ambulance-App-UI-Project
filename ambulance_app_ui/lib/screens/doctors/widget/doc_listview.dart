import 'package:ambulance_app_ui/screens/doctors/bloc/doc_bloc.dart';
import 'package:ambulance_app_ui/screens/doctors/panel/doc_details.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListView extends StatelessWidget {
  const DoctorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorBloc, DoctorState>(
      builder: (context, state) {
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
                                  image: NetworkImage(doctors[a].imageUrl)),),
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
                                  image: NetworkImage(doctors[b].imageUrl))),
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
        }
        else {
          return Center(
          child: CircularProgressIndicator(),
        );
        }
      },
    );
  }
}
