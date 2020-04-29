import 'package:flutter/material.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({this.args});

  final Map args;

  @override
  State<StatefulWidget> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  bool isSlide = false;
  bool isHide = false;

  @override
  void initState() {
    statusBar(status: 1, isHide: true);
    super.initState();
  }

  @override
  void dispose() {
    statusBar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(
              widget.args['data'],
            ),
            minScale: PhotoViewComputedScale.contained * .3,
            maxScale: PhotoViewComputedScale.covered * 2,
            enableRotation: true,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            loadingBuilder: (_, __) => Center(
              child: RefreshProgressIndicator(),
            ),
            scaleStateChangedCallback: (state) {
              setState(() {
                switch (state) {
                  case PhotoViewScaleState.zoomedIn:
                  case PhotoViewScaleState.covering:
                  case PhotoViewScaleState.originalSize:
                    isHide = true;
                    break;
                  case PhotoViewScaleState.zoomedOut:
                    isHide = false;
                    break;
                  default:
                    isHide = false;
                }
              });
            },
          ),
          menuIcon(
            context,
            left: 12.0,
            top: 32.0,
            icon: 'back',
            size: 25.0,
            color: isHide ? Colors.transparent : Colors.black,
          ),
        ],
      ),
    );
  }

  String getPic() {
    return widget.args['data'][widget.args['index'] + 1];
  }
}
