import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/core/const/text_constants.dart';
import 'package:ambulance_app_ui/screens/doctors/doctor_info.dart';
import 'package:flutter/material.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 80),
        child: Column(
          children: [
            _findADoctor(context),
            const SizedBox(
              height: 30,
            ),
            _doctorInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _findADoctor(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            TextConstants.hello,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            TextConstants.letsFindDoctor,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _doctorInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.grayColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.account_circle,
                size: 80,
              ),
              Text(
                'Dr.Mobisa',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DoctorInfo()));
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.grayColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.account_circle,
                size: 80,
              ),
              Text(
                'Dr.Mobisa',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DoctorInfo()));
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.grayColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.account_circle,
                size: 80,
              ),
              Text(
                'Dr.Mobisa',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DoctorInfo()));
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.grayColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.account_circle,
                size: 80,
              ),
              Text(
                'Dr.Mobisa',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DoctorInfo()));
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.grayColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.account_circle,
                size: 80,
              ),
              Text(
                'Dr.Mobisa',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DoctorInfo()));
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.grayColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.account_circle,
                size: 80,
              ),
              Text(
                'Dr.Mobisa',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DoctorInfo()));
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
