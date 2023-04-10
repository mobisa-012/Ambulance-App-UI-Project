class HospitalAppointment {
  String hospital;
  String date;
  String time;
  String department;
  String wing;
  HospitalAppointment(
      {required this.date, required this.hospital, required this.time,
      required this.department,required this.wing});
  Map<String, dynamic> toJson() {
    return {'date': date, 'hospital': hospital, 'time': time,'department':department, 'wing':wing};
  }
}
