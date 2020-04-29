import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _filterTxTCtrl = TextEditingController();

  String _searchText = '';

  List names = List();

  List filteredNames = List();

  Icon _searchIcon = Icon(
    Icons.search,
    color: Colors.black,
  );

  Widget _appBarTitle = Text('搜索案例');

  @override
  void initState() {
    _getNames();
    _filterTxTCtrl.addListener(() {
      if (_filterTxTCtrl.text.isEmpty) {
        setState(() {
          _searchText = '';
          filteredNames.addAll(names);
        });
      } else {
        setState(() {
          _searchText = _filterTxTCtrl.text;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: StreamBuilder<List>(
          stream: _getNames().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (_searchText.isNotEmpty) {
                var tempList = List();
                for (var item in filteredNames) {
                  if ('${item['name']}'
                      .toLowerCase()
                      .contains(_searchText.toLowerCase())) {
                    tempList.add(item);
                  }
                }
                filteredNames = tempList;
                names.shuffle();
              }
              return ListView.builder(
                itemCount:
                    snapshot.data.length == null ? 0 : filteredNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(filteredNames[index]['name']),
                  );
                },
              );
            }
            return Center(child: RefreshProgressIndicator());
          }),
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: _appBarTitle,
      actions: [
        IconButton(
          icon: _searchIcon,
          onPressed: () {
            setState(() {
              if (_searchIcon.icon == Icons.search) {
                _searchIcon = Icon(
                  Icons.close,
                  color: Colors.black,
                );
                _appBarTitle = TextField(
                  controller: _filterTxTCtrl,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16.0),
                    border: OutlineInputBorder(),
                  ),
                );
              } else {
                _searchIcon = Icon(
                  Icons.search,
                  color: Colors.black,
                );
                _appBarTitle = Text('Search Example');
                filteredNames = names;
                _filterTxTCtrl.clear();
              }
            });
          },
        ),
      ],
    );
  }

  Future<List> _getNames() async {
    final Response<List> response =
        await Dio().get('https://5ea61f8284f6290016ba64fc.mockapi.io/v1/hello');
    List tempList = List();
    for (var item in response.data) {
      tempList.add(item);
    }
    setState(() {
      names = tempList;
      filteredNames = names;
    });
    return response.data;
  }
}
