import 'package:flutter/material.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({this.args});

  final Map args;

  @override
  State<StatefulWidget> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  void initState() {
    statusBar();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: widget.args['data'].length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                  widget.args['data'][index],
                ),
                minScale: PhotoViewComputedScale.contained * 0.4,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            loadingBuilder: (_, ImageChunkEvent event) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: Icon(Icons.touch_app, size: 38.0),
            ),
          ),
        ],
      ),
    );
  }
}
