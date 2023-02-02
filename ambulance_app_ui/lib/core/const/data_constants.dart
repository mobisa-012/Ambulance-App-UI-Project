import 'package:ambulance_app_ui/core/const/path_constants.dart';
import 'package:ambulance_app_ui/core/const/text_constants.dart';
import 'package:ambulance_app_ui/screens/onboarding/widgets/onboarding_tiles.dart';


class DataConstants {
  static final onboardingTiles = [
    const OnboardingTile(
      title: TextConstants.needAnAmbulance,
      imagePath: PathConstants.ambulance,
      mainText: TextConstants.onboardingTile1,
    ),
    const OnboardingTile(
      title: TextConstants.needDoctor,
      imagePath: PathConstants.doctor,
      mainText: TextConstants.onboardingTile2,
    ),
    const OnboardingTile(
      title: TextConstants.alwaysReady,
      imagePath: PathConstants.emergency,
      mainText: TextConstants.onboardingTile3,
    )
  ];
}
