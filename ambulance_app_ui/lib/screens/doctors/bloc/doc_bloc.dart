import 'package:ambulance_app_ui/core/data/doctor_data.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'doc_event.dart';
part 'doc_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  DoctorBloc() : super(DoctorInitial());

  Stream<DoctorState> mapEventToState(DoctorEvent event) async* {
    if (event is LoadDoctors) {
      yield* mapLoadDoctorsEventToState();
    }
  }

  Stream<DoctorState> mapLoadDoctorsEventToState() async* {
    final querySnapshot = await firebaseFirestore.collection('Doctors').get();
    final doctors =
        querySnapshot.docs.map((doc) => DoctorData.fromSnapshot(doc)).toList();
    yield DoctorLoadState(doctors);
  }
}
