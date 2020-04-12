import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(SudokuGame());

class SudokuGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SudokuPage(),
    );
  }
}

const double RADIUS_CORNER = 12;
const int VALUE_NONE = 0;

const int COUNT_ROW_SUB_TABLE = 3;
const int COUNT_COL_SUB_TABLE = 3;

class SudokuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {
  // 主题颜色配置
  Color colorBorderTable = Colors.white;
  Color colorBackgroundApp = Colors.blue[100];
  Color colorBackgroundChannelEmpty1 = Color(0xffe3e3e3);
  Color colorBackgroundChannelEmpty2 = Colors.white30;
  Color colorBackgroundNumberTab = Colors.white;
  Color colorTextNumber = Colors.white;
  Color colorBackgroundChannelValue = Colors.blue[700];
  Color colorBackgroundChannelValueFixed = Colors.teal[400];

  SudokuTable sudokuTable;
  bool conflictMode = false;
  double channelSize = 0;
  double fontScale = 1;

  Orientation orientation;
  Size size;

  @override
  void initState() {
    initSudokuTable();
    initTableFixed();
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  void initSudokuTable() {
    sudokuTable = SudokuTable();
    sudokuTable.init();
  }

  void initTableFixed() {
    SudokuSubTable subTableLeftTop = sudokuTable.table[0][0];
    subTableLeftTop.setValue(row: 0, col: 2, value: 5, enableMove: false);
    subTableLeftTop.setValue(row: 1, col: 0, value: 1, enableMove: false);
    subTableLeftTop.setValue(row: 1, col: 2, value: 2, enableMove: false);

    SudokuSubTable subTableTop = sudokuTable.table[0][1];
    subTableTop.setValue(row: 0, col: 0, value: 9, enableMove: false);
    subTableTop.setValue(row: 1, col: 1, value: 6, enableMove: false);
    subTableTop.setValue(row: 1, col: 2, value: 8, enableMove: false);
    subTableTop.setValue(row: 2, col: 0, value: 2, enableMove: false);

    SudokuSubTable subTableRightTop = sudokuTable.table[0][2];
    subTableRightTop.setValue(row: 0, col: 1, value: 1, enableMove: false);
    subTableRightTop.setValue(row: 1, col: 0, value: 4, enableMove: false);
    subTableRightTop.setValue(row: 2, col: 0, value: 7, enableMove: false);

    SudokuSubTable subTableLeft = sudokuTable.table[1][0];
    subTableLeft.setValue(row: 0, col: 0, value: 2, enableMove: false);
    subTableLeft.setValue(row: 0, col: 1, value: 1, enableMove: false);
    subTableLeft.setValue(row: 1, col: 1, value: 4, enableMove: false);
    subTableLeft.setValue(row: 1, col: 2, value: 8, enableMove: false);
    subTableLeft.setValue(row: 2, col: 1, value: 5, enableMove: false);

    SudokuSubTable subTableCenter = sudokuTable.table[1][1];
    subTableCenter.setValue(row: 0, col: 0, value: 8, enableMove: false);
    subTableCenter.setValue(row: 0, col: 2, value: 6, enableMove: false);
    subTableCenter.setValue(row: 1, col: 1, value: 9, enableMove: false);
    subTableCenter.setValue(row: 2, col: 0, value: 4, enableMove: false);
    subTableCenter.setValue(row: 2, col: 2, value: 3, enableMove: false);

    SudokuSubTable subTableRight = sudokuTable.table[1][2];
    subTableRight.setValue(row: 0, col: 1, value: 3, enableMove: false);
    subTableRight.setValue(row: 1, col: 0, value: 6, enableMove: false);
    subTableRight.setValue(row: 1, col: 1, value: 5, enableMove: false);
    subTableRight.setValue(row: 2, col: 1, value: 7, enableMove: false);
    subTableRight.setValue(row: 2, col: 2, value: 8, enableMove: false);

    SudokuSubTable subTableBottomLeft = sudokuTable.table[2][0];
    subTableBottomLeft.setValue(row: 0, col: 2, value: 4, enableMove: false);
    subTableBottomLeft.setValue(row: 1, col: 2, value: 3, enableMove: false);
    subTableBottomLeft.setValue(row: 2, col: 1, value: 6, enableMove: false);

    SudokuSubTable subTableBottom = sudokuTable.table[2][1];
    subTableBottom.setValue(row: 0, col: 2, value: 2, enableMove: false);
    subTableBottom.setValue(row: 1, col: 0, value: 6, enableMove: false);
    subTableBottom.setValue(row: 1, col: 1, value: 8, enableMove: false);
    subTableBottom.setValue(row: 2, col: 2, value: 4, enableMove: false);

    SudokuSubTable subTableBottomRight = sudokuTable.table[2][2];
    subTableBottomRight.setValue(row: 1, col: 0, value: 5, enableMove: false);
    subTableBottomRight.setValue(row: 1, col: 2, value: 1, enableMove: false);
    subTableBottomRight.setValue(row: 2, col: 0, value: 3, enableMove: false);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.top,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double shortestSize = size.shortestSide;
    double width = size.width;
    double height = size.height;
    orientation = MediaQuery.of(context).orientation;

    // Tablet case
    if (shortestSize >= 600) {
      fontScale = 1.7;
      if (width > height) {
        // Tablet landscape
        channelSize = shortestSize / 9 - 30;
      } else {
        // tablet portrait
        channelSize = shortestSize / 9 - 10;
      }
    } else {
      // phone case (portrait only)
      channelSize = shortestSize / 9 - 10;
    }
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: colorBackgroundApp,
        child: orientation == Orientation.landscape
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: buildContent(),
              )
            : Column(children: buildContent()),
      ),
    );
  }

  List<Widget> buildContent() {
    return [
      orientation == Orientation.landscape ? Container() : buildMenu(),
      orientation == Orientation.landscape
          ? Container(
              padding: const EdgeInsets.all(12),
              color: colorBackgroundNumberTab,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: buildNumberListTab(),
              ),
            )
          : Container(),
      Container(
        height: orientation == Orientation.landscape ? size.height : 8,
        width: orientation == Orientation.landscape ? 8 : size.width,
        color: Colors.blue[300],
      ),
      orientation == Orientation.landscape
          ? Align(
              alignment: Alignment.topCenter,
              child: settingIcon(),
            )
          : Container(),
      orientation == Orientation.landscape
          ? Container(
              child: Text(
                '数',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 88,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Container(),
      Expanded(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: colorBorderTable,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildSubTable(sudokuTable.table[0][0],
                              colorBackgroundChannelEmpty1),
                          buildSubTable(sudokuTable.table[0][1],
                              colorBackgroundChannelEmpty2),
                          buildSubTable(sudokuTable.table[0][2],
                              colorBackgroundChannelEmpty1),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildSubTable(sudokuTable.table[1][0],
                              colorBackgroundChannelEmpty2),
                          buildSubTable(sudokuTable.table[1][1],
                              colorBackgroundChannelEmpty1),
                          buildSubTable(sudokuTable.table[1][2],
                              colorBackgroundChannelEmpty2),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildSubTable(sudokuTable.table[2][0],
                              colorBackgroundChannelEmpty1),
                          buildSubTable(sudokuTable.table[2][1],
                              colorBackgroundChannelEmpty2),
                          buildSubTable(sudokuTable.table[2][2],
                              colorBackgroundChannelEmpty1),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      orientation == Orientation.landscape
          ? Container(
              child: Text(
                '独',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 88,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Container(),
      orientation == Orientation.landscape
          ? Align(
              alignment: Alignment.topCenter,
              child: restartIcon(),
            )
          : Container(),
      Container(
          height: orientation == Orientation.landscape ? size.height : 8,
          width: orientation == Orientation.landscape ? 8 : size.width,
          color: Colors.blue[200]),
      Container(
        padding: const EdgeInsets.all(12),
        color: colorBackgroundNumberTab,
        child: orientation == Orientation.landscape
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: buildNumberListTab(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: buildNumberListTab(),
              ),
      ),
    ];
  }

  Widget restartIcon() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          padding: EdgeInsets.all(
            orientation == Orientation.landscape ? 12.0 : 0.0,
          ),
          iconSize: orientation == Orientation.landscape ? 40.0 : 32.0,
          splashColor: Colors.teal.withOpacity(0.3),
          color: orientation == Orientation.landscape
              ? Colors.white
              : Colors.blue[700],
          icon: Icon(Icons.refresh),
          onPressed: () {
            restart();
          },
        ),
      ),
    );
  }

  Widget buildMenu() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      constraints: BoxConstraints.expand(
        height: 80.0,
        width: double.infinity,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          settingIcon(),
          Align(
            child: Text(
              '数独',
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          restartIcon(),
        ],
      ),
    );
  }

  Widget settingIcon() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          iconSize: orientation == Orientation.landscape ? 40.0 : 32.0,
          padding: EdgeInsets.all(
            orientation == Orientation.landscape ? 12.0 : 0.0,
          ),
          splashColor: Colors.teal.withOpacity(0.3),
          color: orientation == Orientation.landscape
              ? Colors.white
              : Colors.blue[700],
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget buildSubTable(SudokuSubTable subTable, Color color) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildRowChannel(subTable, 0, color),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildRowChannel(subTable, 1, color),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildRowChannel(subTable, 2, color),
          ),
        ],
      ),
    );
  }

  List<Widget> buildRowChannel(
    SudokuSubTable subTable,
    int rowChannel,
    Color color,
  ) {
    List<SudokuChannel> dataRowChanel = subTable.subTable[rowChannel];
    List<Widget> listWidget = List();
    for (int col = 0; col < 3; col++) {
      Widget widget = buildChannel(rowChannel, dataRowChanel[col], color,
          onNumberAccept: (data) {
        setState(() {
          sudokuTable.table[subTable.indexRowInTable][subTable.indexColInTable]
              .subTable[rowChannel][col] = SudokuChannel(value: data);
        });
      }, onRemove: () {
        setState(() {
          sudokuTable.table[subTable.indexRowInTable][subTable.indexColInTable]
              .subTable[rowChannel][col] = SudokuChannel();
        });
      }, onHover: (value) {
        setState(() {
          showWaringConflictChannel(subTable.indexRowInTable,
              subTable.indexColInTable, rowChannel, col, value);
        });
      }, onHoverEnd: () {
        clearWaringConflictChannel();
      });
      listWidget.add(widget);
    }
    return listWidget;
  }

  Widget buildChannel(int rowChannel, SudokuChannel channel, Color color,
      {Function(int) onNumberAccept,
      Function() onRemove,
      Function(int) onHover,
      Function onHoverEnd}) {
    if (channel.value == 0) {
      return DragTarget(builder: (BuildContext context, List<int> candidateData,
          List<dynamic> rejectedData) {
        dev.log('$candidateData');
        return buildChannelEmpty();
      }, onWillAccept: (data) {
        bool accept = data >= 0 && data <= 9;
        if (accept) {
          if (!conflictMode) {
            onHover(data);
          }
        }
        return accept;
      }, onAccept: (data) {
        onNumberAccept(data);
        onHoverEnd();
      }, onLeave: (data) {
        onHoverEnd();
      });
    } else {
      if (channel.enableMove) {
        return DragTarget(builder: (BuildContext context,
            List<int> candidateData, List<dynamic> rejectedData) {
          return Draggable(
            child: buildChannelValue(channel),
            feedback: Material(
                type: MaterialType.transparency,
                child: buildChannelValue(channel)),
            childWhenDragging: buildChannelEmpty(),
            onDragCompleted: () {
              onRemove();
            },
            onDraggableCanceled: (v, o) {
              onRemove();
            },
            data: channel.value,
          );
        }, onWillAccept: (data) {
          return data >= 0 && data <= 9;
        }, onAccept: (data) {
          onNumberAccept(data);
        });
      } else {
        return buildChannelValueFixed(channel);
      }
    }
  }

  Widget buildChannelEmpty() {
    return Container(
      margin: const EdgeInsets.all(1),
      width: channelSize,
      height: channelSize,
      decoration: BoxDecoration(
          color: colorBackgroundChannelEmpty1,
          borderRadius: BorderRadius.all(Radius.circular(4))),
    );
  }

  Widget buildChannelValue(SudokuChannel channel) {
    return Container(
      margin: const EdgeInsets.all(1),
      width: channelSize,
      height: channelSize,
      decoration: BoxDecoration(
          color: getColorIfWarning(channel, colorBackgroundChannelValue),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Center(
          child: Text(channel.value.toString(),
              textScaleFactor: fontScale,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900))),
    );
  }

  Color getColorIfWarning(SudokuChannel channel, Color colorDefault) {
    if (channel.enableWarning) {
      return Colors.pink[400];
    }
    return colorDefault;
  }

  Widget buildChannelValueFixed(SudokuChannel channel) {
    return Container(
      margin: const EdgeInsets.all(1),
      width: channelSize,
      height: channelSize,
      decoration: BoxDecoration(
          color: getColorIfWarning(channel, colorBackgroundChannelValueFixed),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Center(
        child: Text(
          channel.value.toString(),
          textScaleFactor: fontScale,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  List<Widget> buildNumberListTab() {
    List<Widget> listWidget = List();
    for (int i = 1; i <= 9; i++) {
      Widget widget = buildNumberBoxWithDraggable(i);
      listWidget.add(widget);
    }
    return listWidget;
  }

  Widget buildNumberBoxWithDraggable(int i) {
    return Draggable(
      child: buildNumberBox(i),
      feedback:
          Material(type: MaterialType.transparency, child: buildNumberBox(i)),
      data: i,
      onDragEnd: (d) {
        setState(() {
          clearWaringConflictChannel();
        });
      },
    );
  }

  Widget buildNumberBox(int i) {
    return Container(
        width: channelSize,
        height: channelSize,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
            color: colorBackgroundChannelValue,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text('$i',
                textScaleFactor: fontScale,
                style: TextStyle(
                    fontSize: 22,
                    color: colorTextNumber,
                    fontWeight: FontWeight.w900))));
  }

  void showWaringConflictChannel(int rowSubTable, int colSubTable,
      int rowChannel, int colChannel, int value) {
    // Check horizontal
    for (int i = 0; i < COUNT_ROW_SUB_TABLE; i++) {
      for (int j = 0; j < COUNT_ROW_SUB_TABLE; j++) {
        SudokuChannel channel =
            sudokuTable.table[rowSubTable][i].subTable[rowChannel][j];
        sudokuTable.table[rowSubTable][i].subTable[rowChannel][j]
            .enableWarning = channel.value == value;
        dev.log('${channel.value}');
      }
    }

    // Check vertical
    for (int i = 0; i < COUNT_COL_SUB_TABLE; i++) {
      for (int j = 0; j < COUNT_COL_SUB_TABLE; j++) {
        SudokuChannel channel =
            sudokuTable.table[i][colSubTable].subTable[j][colChannel];
        sudokuTable.table[i][colSubTable].subTable[j][colChannel]
            .enableWarning = channel.value == value;
        dev.log('${channel.value}');
      }
    }

    conflictMode = true;
  }

  void clearWaringConflictChannel() {
    // Check horizontal
    for (int i = 0; i < COUNT_ROW_SUB_TABLE; i++) {
      for (int j = 0; j < COUNT_ROW_SUB_TABLE; j++) {
        for (int k = 0; k < COUNT_ROW_SUB_TABLE; k++) {
          for (int m = 0; m < COUNT_ROW_SUB_TABLE; m++) {
            sudokuTable.table[i][j].subTable[k][m].enableWarning = false;
          }
        }
      }
    }
    conflictMode = false;
  }

  void restart() {
    setState(() {
      initSudokuTable();
      initTableFixed();
    });
  }
}

class SudokuChannel {
  bool enableMove;
  bool enableWarning;
  int value;

  SudokuChannel({
    this.value = 0,
    this.enableMove = true,
    this.enableWarning = false,
  });
}

class SudokuSubTable {
  int indexRowInTable;
  int indexColInTable;
  List<List<SudokuChannel>> subTable;

  SudokuSubTable({this.indexRowInTable, this.indexColInTable});

  init() {
    subTable = List();
    for (int row = 1; row <= COUNT_ROW_SUB_TABLE; row++) {
      List<SudokuChannel> list = List();
      for (int col = 1; col <= COUNT_COL_SUB_TABLE; col++) {
        list.add(SudokuChannel(value: 0));
      }
      subTable.add(list);
    }
  }

  setValue({int row = 0, int col = 0, int value = 0, bool enableMove = true}) {
    subTable[row][col] = SudokuChannel(value: value, enableMove: enableMove);
  }

  int randomNumber() {
    Random r = Random();
    return r.nextInt(10);
  }
}

class SudokuTable {
  List<List<SudokuSubTable>> table;

  init() {
    table = List();
    for (int row = 0; row < COUNT_ROW_SUB_TABLE; row++) {
      List<SudokuSubTable> list = List();
      for (int col = 0; col < COUNT_COL_SUB_TABLE; col++) {
        SudokuSubTable subTable =
            SudokuSubTable(indexRowInTable: row, indexColInTable: col);
        subTable.init();
        list.add(subTable);
      }
      table.add(list);
    }
  }
}
