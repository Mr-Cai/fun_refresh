import 'dart:async';

class BoolValueBloc {
  bool _value = false;
  final _boolCtrl = StreamController<bool>.broadcast();

  Stream<bool> get stream => _boolCtrl.stream;
  bool get value => _value;

  void toggle(bool value) {
    value = !value;
    _value = value;
    _boolCtrl.sink.add(_value);
  }

  void close() {
    _boolCtrl.close();
  }
}
