import 'package:event_app/view/pages/anaSayfa.dart';
import 'package:event_app/view/pages/aramaSayfa.dart';
import 'package:event_app/view/pages/biletlerimSayfa.dart';
import 'package:event_app/view/pages/profilSayfa.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabBarMain extends StatefulWidget {
  final String? aktifKullaniciId;
  const TabBarMain({Key? key, this.aktifKullaniciId}) : super(key: key);

  @override
  _TabBarMainState createState() => _TabBarMainState();
}

class _TabBarMainState extends State<TabBarMain> {
  int _currentIndex = 0;
  // final _controller = PageController();

  // void _onChange(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  //   _controller.animateToPage(_currentIndex,
  //       duration: Duration(milliseconds: 400), curve: Curves.decelerate);
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
          bottomNavigationBar: _bottomAppBar,
          body: _tabbarViews(widget.aktifKullaniciId)),
    );
  }

  Widget _tabbarViews(String? aktifKullaniciId) {
    return TabBarView(
      // index: _currentIndex, indexedstack için
      // controller: _controller, Pageview için
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        AnaSayfa(
          aktifKullaniciId: widget.aktifKullaniciId,
        ),
        AramaSayfa(),
        BiletlerimSayfa(profilSahibiId: widget.aktifKullaniciId),
        ProfilSayfa(
          profilSahibiId: widget.aktifKullaniciId,
        )
      ],
    );
  }

  Widget get _bottomAppBar => BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 5,
        shape: CircularNotchedRectangle(),
        child: _tabbarItems,
      );

  Widget get _tabbarItems => TabBar(
        automaticIndicatorColorAdjustment: false,
        enableFeedback: false,
        isScrollable: false,
        indicatorColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        tabs: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tab(
                icon: FaIcon(
              FontAwesomeIcons.solidPaperPlane,
              color: _currentIndex == 0
                  ? Theme.of(context).primaryColor
                  : Color(0xffe0dffa),
            )),
          ),
          Tab(
              icon: FaIcon(
            FontAwesomeIcons.search,
            color: _currentIndex == 1
                ? Theme.of(context).primaryColor
                : Color(0xffe0dffa),
          )),
          Tab(
              icon: FaIcon(
            FontAwesomeIcons.tag,
            color: _currentIndex == 2
                ? Theme.of(context).primaryColor
                : Color(0xffe0dffa),
          )),
          Tab(
              icon: FaIcon(
            FontAwesomeIcons.userAlt,
            color: _currentIndex == 3
                ? Theme.of(context).primaryColor
                : Color(0xffe0dffa),
          )),
        ],
      );
}
