import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_locgfxa_assignment/constants.dart';
import 'package:intern_locgfxa_assignment/pageIndicator/image_slider.dart';
import 'package:intern_locgfxa_assignment/widgets/rounded_button.dart';

void main() {
  var mySystemTheme = SystemUiOverlayStyle.light
      .copyWith(systemNavigationBarColor: Colors.white);
  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();
  List<String> images = [kP1Image, kP2Image, kP3Image];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: currentPageIndex != 0
            ? BackButton(
                onPressed: (() => _pageController.previousPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear,
                    )),
                color: Colors.black,
              )
            : const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: images.length,
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPageIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return TopImages(
                    image: images[currentPageIndex],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox.shrink(),
                ImageIndexIndicator(currentPage: currentPageIndex, length: 3),
                currentPageIndex == images.length - 1
                    ? Flexible(child: RoundedButton(onPressed: () {}))
                    : const SizedBox.shrink(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TopImages extends StatelessWidget {
  final String image;
  const TopImages({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(
        //   height: 130,
        // ),
        Center(
          child: Image.asset(
            image,
            height: 320,
          ),
        ),
        const SizedBox(
          height: 66,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 34.0, right: 14),
          child: Text(
            "Select Services",
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 31,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 34.0, right: 14),
          child: Text(
            kLoremIp,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                letterSpacing: -0.408,
                height: 1.83,
                color: const Color.fromRGBO(0, 0, 0, 60)),
            textAlign: TextAlign.justify,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
