import 'package:chat_us/modules/login/login_screen.dart';
import 'package:chat_us/shared/componets/components.dart';
import 'package:chat_us/shared/data/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/on_boarding_1.jpg',
      title: 'chat us chat',
      body: 'chat us app allows you to chat with anyone you might be want',
    ),
    BoardingModel(
      image: 'assets/images/on_boarding_2.jpg',
      title: 'chat us chat',
      body: 'chat us app allows you to chat with anyone you might be want',
    ),
    BoardingModel(
      image: 'assets/images/on_boarding_3.jpg',
      title: 'chat us chat',
      body: 'chat us app allows you to chat with anyone you might be want',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                'skip',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18.0,
                ),
              )),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 550.0,
            child: PageView.builder(
              onPageChanged: (value) {
                if (value == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildBoardingItems(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: boarding.length,
            effect: const ExpandingDotsEffect(
                dotWidth: 12.0,
                dotHeight: 12.0,
                spacing: 5.0,
                expansionFactor: 3.0,
                dotColor: Colors.deepOrange,
                activeDotColor: Colors.deepPurple),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    }
                    pageController.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: isLast
                      ? const Text(
                          'start',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18.0,
                          ),
                        )
                      : const Text(
                          'next',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18.0,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  } //end build()

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value!) navigateAndFinish(context, const LoginScreen());
    });
  }

  Widget buildBoardingItems(BoardingModel model) => Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Image(
              image: AssetImage(model.image),
              width: double.infinity,
              height: 400.0,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              model.title,
              style: const TextStyle(
                fontSize: 26.0,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              model.body,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
} //end class

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}
