import 'package:fun_refresh/tools/global.dart';

import './bloc/bloc_provider.dart';
import './bloc/game_bloc.dart';
import './pages/home_page.dart';
import 'package:flutter/material.dart';

import 'helpers/audio.dart';

class Bejeweled extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BejeweledState();
}

class _BejeweledState extends State<Bejeweled> {
  @override
  void initState() {
    statusBar(isHide: true);
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Audio.init(); // 初始化音效
    });
    super.initState();
  }

  @override
  void dispose() {
    statusBar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      bloc: GameBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage(),
      ),
    );
  }
}
