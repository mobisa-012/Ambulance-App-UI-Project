import 'package:ambulance_app_ui/core/data/doc_reviews_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DocReview extends StatefulWidget {
  const DocReview({super.key});

  @override
  State<DocReview> createState() => _DocReviewState();
}

class _DocReviewState extends State<DocReview> {
  final formKey = GlobalKey<FormState>();
  final reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2))]),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
            controller: reviewController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              labelText: 'Review doc...',
              ),
              keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent
            ),
              onPressed: () {
                DoctorReviews doctorReviews =
                    DoctorReviews(review: reviewController.text);
                FirebaseFirestore.instance
                    .collection('doc_reviews')
                    .add(doctorReviews.toJson())
                    .then((value) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Review status'),
                        content: Text(
                          'Thank you',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurpleAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ))
                        ],
                      );
                    },
                  );
                });
              },
              child: Text(
                'Submit',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }
}
