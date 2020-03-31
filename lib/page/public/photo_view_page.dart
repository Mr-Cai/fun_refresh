import 'package:flutter/material.dart';
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
      body: PhotoView(
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
      ),
    );
  }

  String getPic() {
    return widget.args['data'][widget.args['index'] + 1];
  }
}
