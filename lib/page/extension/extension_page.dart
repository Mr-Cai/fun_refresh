import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import '../../tools/global.dart';
import '../../model/i18n/i18n.dart';
import '../../components/top_bar.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../components/curve_path.dart';
import '../../components/swiper.dart';
import '../../model/data/local_asset.dart';

class ExtensionPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _ExtensionPageState();
}

class _ExtensionPageState extends State<ExtensionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: true,
        title: I18n.of(context).more,
      ),
      body: ListView(
        children: [
          ClipSwiper(),
        ],
      ),
    );
  }
}

class ClipSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          child: AspectRatio(
            aspectRatio:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 3 / 1
                    : 16 / 10,
            child: Swiper.builder(
              autoStart: true,
              circular: true,
              indicator: RectangleSwiperIndicator(
                padding: const EdgeInsets.only(bottom: 26.0),
                itemColor: Colors.black26,
                itemActiveColor: Colors.lightBlue,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  switch (index) {
                    case 0:
                      pushNamed(context, game2048);
                      break;
                    case 1:
                      pushNamed(context, game_tetris);
                      break;
                    case 2:
                      pushNamed(context, game_snake);
                      break;
                  }
                },
                child: Image.network(
                  covers[index],
                  loadingBuilder: (context, child, event) {
                    if (event == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: event.expectedTotalBytes != null
                            ? event.cumulativeBytesLoaded /
                                event.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
              childCount: covers.length ?? 0,
            ),
          ),
          clipper: BTMCurve(42.0),
        ),
      ],
    );
  }
}
