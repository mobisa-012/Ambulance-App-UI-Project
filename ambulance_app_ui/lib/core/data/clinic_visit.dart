class ClinicVisit {
  String name;
  String date;
  String condition;
  String address;
  String time;
  String phoneNumber;
  String payment;

  ClinicVisit(
      {required this.address,
      required this.condition,
      required this.date,
      required this.name,
      required this.payment,
      required this.phoneNumber,
      required this.time});
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'address': address,
      'condition': condition,
      'name': name,
      'time': time,
      'payment': payment,
      'phoneNumber' : phoneNumber
    };
  }
}
