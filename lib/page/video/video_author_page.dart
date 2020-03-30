import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/model/mock/video/eye_channel.dart';
import 'package:fun_refresh/model/mock/video/eye_video.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/net_tool.dart';

class VideoAuthorPage extends StatefulWidget {
  const VideoAuthorPage({this.args});

  final Map args;

  @override
  State<StatefulWidget> createState() => _VideoAuthorPageState();
}

class _VideoAuthorPageState extends State<VideoAuthorPage> {
  InnerData data;

  @override
  void initState() {
    data = widget.args['data'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<EyeChannel>(
        stream: netool.pullEyeChannel(id: data.author.id).asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    iconSize: 1.0,
                    icon: SvgPicture.asset(
                      path('back', 5),
                      width: 22.0,
                      height: 22.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pop(context);
                    },
                  ),
                  floating: true,
                  elevation: 0.0,
                  flexibleSpace: Stack(
                    children: [
                      netPic(pic: picDemo),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: sizeW(context) * .1,
                          height: sizeW(context) * .1,
                          child: netPic(pic: data.author.icon),
                        ),
                      ),
                    ],
                  ),
                  expandedHeight: sizeH(context) * .28,
                  backgroundColor: Colors.grey[50],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(sizeH(context) * .1),
                    child: Container(
                      child: Icon(
                        Icons.change_history,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    Text('${data.author.id}'),
                    Text('${snapshot.data.pgcInfo.name}'),
                  ]),
                ),
              ],
            );
          }
          return flareAnim(context, height: sizeH(context));
        },
      ),
    );
  }
}
