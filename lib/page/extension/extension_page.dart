import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../components/curve_path.dart';
import '../../components/swiper.dart';
import '../../model/data/local_asset.dart';

class ExtensionPage extends StatefulWidget with NavigationState {
  @override
  createState() => _ExtensionPageState();
}

class _ExtensionPageState extends State<ExtensionPage> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: Stack(
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
                      padding: EdgeInsets.only(bottom: 26.0),
                      itemColor: Colors.black26,
                      itemActiveColor: Colors.lightBlue),
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {},
                      child: Image.network(covers[index], fit: BoxFit.cover)),
                  childCount: covers.length ?? 0,
                ),
              ),
              clipper: BTMCurve(42.0),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 120.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    width: 120.0,
                    child: FloatingActionButton(
                      elevation: 99.0,
                      isExtended: true,
                      onPressed: () {},
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withAlpha(10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Android'),
                        ),
                        radius: 54.0,
                        backgroundImage: NetworkImage(
                          'https://raw.githubusercontent.com/Mr-Cai/Util-Res/master/pic/img/android.png',
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
