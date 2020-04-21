import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import 'package:fun_refresh/tools/api.dart' show kugou;
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/net_tool.dart';

class CloudMusicPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CloudMusicPageState();
}

class _CloudMusicPageState extends State<CloudMusicPage> {
  final audioPlayer = AudioPlayer();
  final saved = Set<int>();

  @override
  void dispose() {
    audioPlayer.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Chillhop Music',
        themeColor: Colors.black,
        actions: [
          InkWell(
            onTap: () {
              pushName(context, web_view,
                  args: {'url': 'https://www.kugou.com'});
            },
            child: Container(
              width: 28.0,
              height: 28.0,
              child: netPic(pic: kugou),
            ),
          ),
          menuIcon(context, icon: 'search', onTap: () {}, size: 26.0),
        ],
      ),
      body: StreamBuilder<List>(
        stream: netool.requestMusic(count: 100).asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                bool isPlay = saved.contains(index);
                bool isPlaying = false;
                return ListTile(
                  trailing: InkWell(
                    customBorder: corner(),
                    onTap: () {
                      setState(() {
                        isPlay ? saved.remove(index) : saved.add(index);
                      });
                      netool
                          .searchMusic(playID: snapshot.data[index]['id'])
                          .then((value) {
                        isPlay
                            ? audioPlayer.pause().then((value) =>
                                value == 1 ? isPlaying = true : false)
                            : isPlaying
                                ? audioPlayer.resume()
                                : play(value['url']);
                      });
                    },
                    child: Container(
                      width: sizeW(context) * .12,
                      height: sizeH(context) * .1,
                      child: Icon(
                        isPlay
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline,
                        color: Colors.lightBlue.withOpacity(0.6),
                      ),
                    ),
                  ),
                  title: Text(snapshot.data[index]['name']),
                  onTap: () {},
                );
              },
            );
          }
          return Center(child: flareAnim(context));
        },
      ),
    );
  }

  Future<int> play(String url) async {
    int result = await audioPlayer.play(url);
    return result;
  }
}
