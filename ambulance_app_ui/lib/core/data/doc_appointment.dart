class Appointment {
  String doc;
  String date;
  String time; 
  Appointment({required this.date, required this.time,required this.doc});
  Map<String, dynamic> toJson() {
    return {'doc': doc, 'date': date,'time':time};
  }
}
