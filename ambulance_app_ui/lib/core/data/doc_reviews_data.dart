class DoctorReviews {
  String review;

  DoctorReviews({required this.review});
  Map<String, dynamic> toJson() {
    return {'review':review};
  }
}
