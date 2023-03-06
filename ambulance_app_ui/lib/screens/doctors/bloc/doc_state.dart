part of 'doc_bloc.dart';

abstract class DoctorState {}

class DoctorInitial extends DoctorState{}

class DoctorLoadState extends DoctorState {
  final List<DoctorData> doctors;

  DoctorLoadState(this.doctors);
}

