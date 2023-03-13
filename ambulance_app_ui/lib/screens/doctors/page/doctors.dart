import 'package:ambulance_app_ui/screens/doctors/bloc/doc_bloc.dart';
import 'package:ambulance_app_ui/screens/doctors/widget/doc_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Find a doctor..',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  BlocProvider<DoctorBloc> _body(BuildContext context) {
    return BlocProvider<DoctorBloc>(
      create: (BuildContext context) => DoctorBloc(),
      child: BlocConsumer<DoctorBloc, DoctorState>(
        listenWhen: (_, currState) => currState is DoctorLoadState,
        listener: (context, state) {},
        builder: (context, state) {
          return DoctorWidget();
        },
        buildWhen: (_, currState) => currState is DoctorInitial,
      ),
    );
  }
}
