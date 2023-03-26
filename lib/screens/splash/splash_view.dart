import 'package:flutter/material.dart';

import '../../constants/app_fonts.dart';
import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future(() {
      setState(() {
        isLoading = true;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return screen(
      children: [
        appName,
        animatedProgressIndigator,
      ],
    );
  }

  Material screen({required List<Widget> children}) {
    return Material(
      color: ColorConstants.primary[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  Hero get appName {
    return Hero(
      tag: 'app-name',
      child: Material(
        color: Colors.transparent,
        child: Text(
          StringConstants.appName,
          style: AppFonts.headingMedium,
        ),
      ),
    );
  }

  AnimatedOpacity get animatedProgressIndigator {
    return AnimatedOpacity(
      opacity: isLoading ? 1 : 0,
      duration: const Duration(milliseconds: 1500),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CircularProgressIndicator(
          color: ColorConstants.primary[100],
        ),
      ),
    );
  }
}
