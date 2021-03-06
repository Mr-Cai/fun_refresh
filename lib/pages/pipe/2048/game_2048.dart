import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/tools/global.dart';
import 'mycolor.dart';
import 'tile.dart';
import 'grid.dart';
import 'game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Game2048 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Game2048State();
}

class _Game2048State extends State<Game2048> {
  List<List<int>> grid = [];
  List<List<int>> gridNew = [];
  SharedPreferences sharedPreferences;
  int score = 0;
  bool isgameOver = false;
  bool isgameWon = false;

  int _coins = 0;

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    childDirected: false,
  );

  bool loaded = false;

  List<Widget> getGrid(double width, double height) {
    List<Widget> grids = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        int num = grid[i][j];
        String number;
        int color;
        if (num == 0) {
          color = MyColor.emptyGridBackground;
          number = '';
        } else if (num == 2 || num == 4) {
          color = MyColor.gridColorTwoFour;
          number = '$num';
        } else if (num == 8 || num == 64 || num == 256) {
          color = MyColor.gridColorEightSixtyFourTwoFiftySix;
          number = '$num';
        } else if (num == 16 || num == 32 || num == 1024) {
          color = MyColor.gridColorSixteenThirtyTwoOneZeroTwoFour;
          number = '$num';
        } else if (num == 128 || num == 512) {
          color = MyColor.gridColorOneTwentyEightFiveOneTwo;
          number = '$num';
        } else {
          color = MyColor.gridColorWin;
          number = '$num';
        }
        double size;
        String n = '$number';
        switch (n.length) {
          case 1:
          case 2:
            size = 40.0;
            break;
          case 3:
            size = 30.0;
            break;
          case 4:
            size = 20.0;
            break;
        }
        grids.add(Tile(number, width, height, color, size));
      }
    }
    return grids;
  }

  void handleGesture(int direction) {
    /*
    
      0 = up
      1 = down
      2 = left
      3 = right

    */
    bool flipped = false;
    bool played = true;
    bool rotated = false;
    if (direction == 0) {
      setState(() {
        grid = transposeGrid(grid);
        grid = flipGrid(grid);
        rotated = true;
        flipped = true;
      });
    } else if (direction == 1) {
      setState(() {
        grid = transposeGrid(grid);
        rotated = true;
      });
    } else if (direction == 2) {
    } else if (direction == 3) {
      setState(() {
        grid = flipGrid(grid);
        flipped = true;
      });
    } else {
      played = false;
    }

    if (played) {
      print('playing');
      List<List<int>> past = copyGrid(grid);
      print('past $past');
      for (int i = 0; i < 4; i++) {
        setState(() {
          List result = operate(grid[i], score, sharedPreferences);
          score = result[0];
          print('score in set state $score');
          grid[i] = result[1];
        });
      }
      setState(() {
        grid = addNumber(grid, gridNew);
      });
      bool changed = compare(past, grid);
      print('changed $changed');
      if (flipped) {
        setState(() {
          grid = flipGrid(grid);
        });
      }

      if (rotated) {
        setState(() {
          grid = transposeGrid(grid);
        });
      }

      if (changed) {
        setState(() {
          grid = addNumber(grid, gridNew);
          print('is changed');
        });
      } else {
        print('not changed');
      }

      bool gameover = isGameOver(grid);
      if (gameover) {
        print('game over');
        setState(() {
          isgameOver = true;
        });
        RewardedVideoAd.instance.show().catchError((e) {
          print('🍎🍎🍎 激励视频报错: $e');
        });
      }

      bool gamewon = isGameWon(grid);
      if (gamewon) {
        print('GAME WON');
        setState(() {
          isgameWon = true;
        });
      }
      print(grid);
      print(score);
    }
  }

  final bannerAd = createBannerAd(size: AdSize.mediumRectangle);

  @override
  void initState() {
    grid = blankGrid();
    gridNew = blankGrid();
    addNumber(grid, gridNew);
    addNumber(grid, gridNew);
    bannerAd
      ..load()
      ..show();
    statusBar(isHide: true);
    loadRewardAd().catchError((e) {
      print('🍎🍎🍎 激励视频报错: $e');
    }).then(
      (value) => setState(() => loaded = value),
    );

    RewardedVideoAd.instance.listener = (event, {rewardAmount, rewardType}) {
      if (event == RewardedVideoAdEvent.rewarded) {
        statusBar(isHide: true);
        setState(() {
          _coins += rewardAmount;
          print('🍎🍎🍎 $_coins');
        });
      }
      if (event == RewardedVideoAdEvent.closed) {
        statusBar(isHide: true);
        loadRewardAd().catchError((e) => print('🍎🍎🍎 激励视频报错: $e')).then(
              (value) => setState(() => loaded = value),
            );
      }
    };
    super.initState();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    statusBar();
    super.dispose();
  }

  Future<String> getHighScore() async {
    sharedPreferences = await SharedPreferences.getInstance();
    int score = sharedPreferences.getInt('high_score');
    if (score == null) {
      score = 0;
    }
    return score.toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double gridWidth = (width - 80) / 4;
    double gridHeight = gridWidth;
    double height = 30 + (gridHeight * 4) + 10;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'StarJedi'),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.square(72.0),
          child: Column(
            children: [
              Container(
                height: 8.0,
                color: Color(MyColor.gridBackground),
              ),
              AppBar(
                leading: Transform.scale(
                  scale: 0.6,
                  child: menuIcon(
                    context,
                    icon: 'back',
                    color: Colors.white,
                  ),
                ),
                elevation: 0.0,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Text(
                  '2048',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Color(MyColor.gridBackground),
              ),
              Container(
                height: 8.0,
                color: Color(MyColor.gridBackground),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    width: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(MyColor.gridBackground),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '得分',
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            '$score',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: GestureDetector(
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 4,
                            children: getGrid(gridWidth, gridHeight),
                          ),
                          onVerticalDragEnd: (DragEndDetails details) {
                            HapticFeedback.lightImpact();
                            //primaryVelocity -ve up +ve down
                            if (details.primaryVelocity < 0) {
                              handleGesture(0);
                            } else if (details.primaryVelocity > 0) {
                              handleGesture(1);
                            }
                          },
                          onHorizontalDragEnd: (details) {
                            HapticFeedback.lightImpact();
                            //-ve right, +ve left
                            if (details.primaryVelocity > 0) {
                              handleGesture(2);
                            } else if (details.primaryVelocity < 0) {
                              handleGesture(3);
                            }
                          },
                        ),
                      ),
                      isgameOver
                          ? Container(
                              height: height,
                              color: Color(MyColor.transparentWhite),
                              child: Center(
                                child: Text(
                                  'Game over!',
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(MyColor.gridBackground)),
                                ),
                              ),
                            )
                          : SizedBox(),
                      isgameWon
                          ? Container(
                              height: height,
                              color: Color(MyColor.transparentWhite),
                              child: Center(
                                child: Text(
                                  'You Won!',
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(MyColor.gridBackground)),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  color: Color(MyColor.gridBackground),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(MyColor.gridBackground),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: IconButton(
                            iconSize: 35.0,
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                grid = blankGrid();
                                gridNew = blankGrid();
                                grid = addNumber(grid, gridNew);
                                grid = addNumber(grid, gridNew);
                                score = 0;
                                isgameOver = false;
                                isgameWon = false;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(MyColor.gridBackground),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                '最高得分',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold),
                              ),
                              FutureBuilder<String>(
                                future: getHighScore(),
                                builder: (ctx, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    );
                                  } else {
                                    return Text(
                                      '0',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
