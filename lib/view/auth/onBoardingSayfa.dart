import 'package:eevent/view/viewModel/onBoardingModel.dart';
import 'package:eevent/view/viewModel/widthAndHeight.dart';
import 'package:eevent/view/auth/girisSayfa.dart';
import 'package:flutter/material.dart';

class OnBoardingSayfa extends StatefulWidget {
  const OnBoardingSayfa({Key? key}) : super(key: key);

  @override
  _OnBoardingSayfaState createState() => _OnBoardingSayfaState();
}

class _OnBoardingSayfaState extends State<OnBoardingSayfa> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          boslukHeight(context, 0.1),
          _pageViewBuilder,
          _noktalar,
          boslukHeight(context, 0.04),
          _btn,
          boslukHeight(context, 0.07)
        ],
      ),
    );
  }

  Widget get _pageViewBuilder => Expanded(
        child: PageView.builder(
          controller: _controller,
          itemCount: contents.length,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (_, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  Image.asset('${contents[i].image}',
                      height: MediaQuery.of(context).size.height * 0.4),
                  Text(
                    '${contents[i].title}',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.of(context).size.height * 0.04,
                      color: Color(0xff252745),
                    ),
                  ),
                  boslukHeight(context, 0.03),
                  Text(
                    '${contents[i].discription}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      color: Color(0xff252745).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

  Widget get _noktalar => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            contents.length,
            (index) => buildDot(index, context),
          ),
        ),
      );

  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: 10,
      width: currentIndex == index ? 30 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _colorPicker(currentIndex),
      ),
    );
  }

  Color _colorPicker(int currentIndex) {
    if (currentIndex == 0) {
      return Theme.of(context).primaryColor;
    } else if (currentIndex == 1) {
      return Color(0xffFFC232);
    } else if (currentIndex == 2) {
      return Color(0xffF8B1C2);
    } else if (currentIndex == 3) {
      return Color(0xffEF2E5B);
    }
    return Colors.white;
  }

  Widget get _btn => InkWell(
        onTap: () {
          if (currentIndex == contents.length - 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => GirisSayfa(),
              ),
            );
          }
          _controller.nextPage(
            duration: Duration(milliseconds: 100),
            curve: Curves.bounceIn,
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Theme.of(context).primaryColor, Color(0xff6aa9c2)])),
          child: Center(
              child: Text(
            currentIndex == contents.length - 1 ? "Geç" : "Sıradaki",
            style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.025,
                color: Theme.of(context).scaffoldBackgroundColor),
          )),
        ),
      );
}
