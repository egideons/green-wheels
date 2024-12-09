import '../../../src/constants/assets.dart';
import '../../../src/models/onboard/onboard_model.dart';

class OnboardContent {
  List<OnboardModel> items = [
    OnboardModel(
      title: "No Service Denials",
      description:
          "Our network of reliable drivers ensures you're never left waiting, with zero cancellations as our drivers are always on duty.",
      image: Assets.onboarding1Svg,
    ),
    OnboardModel(
      title: "Ride with Confidence",
      description:
          "Forget surprise charges! We offer upfront pricing, so you know exactly what you'll pay before you book.",
      image: Assets.onboarding2Svg,
    ),
    OnboardModel(
      title: "Safety First",
      description:
          "We take your safety seriously.  Our drivers undergo rigorous background checks, and our vehicles are equipped with the latest safety technology to keep you protected on the road.",
      image: Assets.onboarding3Svg,
    ),
  ];
}
