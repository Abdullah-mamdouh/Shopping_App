

class Menu {
  String _title;
  Function _function;
  Menu(this._title,this._function);

  Function get function => _function;

  set function(Function value) {
    _function = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }


}