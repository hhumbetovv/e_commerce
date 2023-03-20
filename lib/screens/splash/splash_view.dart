import 'package:e_commerce/constants/color_constants.dart';
import 'package:e_commerce/constants/string_constants.dart';
import 'package:e_commerce/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    Future.delayed(const Duration(milliseconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstants.primary[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appName,
          animatedProgressIndigator,
        ],
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

  Text get appName {
    return Text(
      StringConstants.appName,
      style: GoogleFonts.poppins(
        color: ColorConstants.black,
        fontWeight: FontWeight.w600,
        fontSize: 32,
      ),
    );
  }
}
