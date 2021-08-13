
import 'package:eevent/servisler/firestoreServisi.dart';
import 'package:eevent/view/pages/anaSayfa.dart';
import 'package:eevent/view/pages/aramaSayfa.dart';
import 'package:eevent/view/pages/biletlerimSayfa.dart';
import 'package:eevent/view/pages/profilSayfa.dart';
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
  // StreamSubscription? _connectionChangeStream;

  // bool isOffline = false;

  // @override
  // void initState() {
  //   super.initState();

  //   ConnectionStatusSingleton connectionStatus =
  //       ConnectionStatusSingleton.getInstance();
  //   connectionStatus.initialize();

  //   _connectionChangeStream =
  //       connectionStatus.connectionChange.listen(connectionChanged);
  // }

  // void connectionChanged(dynamic hasConnection) {
  //   setState(() {
  //     isOffline = !hasConnection;
  //   });
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
        AramaSayfa(
          aktifKullaniciId: widget.aktifKullaniciId,
        ),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tab(
                icon: FaIcon(
              FontAwesomeIcons.search,
              color: _currentIndex == 1
                  ? Theme.of(context).primaryColor
                  : Color(0xffe0dffa),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tab(
                icon: FaIcon(
              FontAwesomeIcons.tag,
              color: _currentIndex == 2
                  ? Theme.of(context).primaryColor
                  : Color(0xffe0dffa),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tab(
                icon: FaIcon(
              FontAwesomeIcons.userAlt,
              color: _currentIndex == 3
                  ? Theme.of(context).primaryColor
                  : Color(0xffe0dffa),
            )),
          ),
        ],
      );
}
