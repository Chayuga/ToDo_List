import 'package:eltodo/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitle = TextEditingController();
  var _todoDescription = TextEditingController();
  var _todoDate = TextEditingController();

  var _categories = List<DropdownMenuItem>();

  var _selectedValue;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoriesScreen();
    var categories = await _categoryService.getCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  DateTime _date = DateTime.now();

  _selectTodoDate(BuildContext context) async {
    var _pickerDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2099));
    if (_pickerDate != null) {
      setState(() {
        _date = _pickerDate;
        _todoDate.text = DateFormat('yyyy-MM-dd').format(_pickerDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _todoTitle,
            decoration: InputDecoration(
              hintText: 'ToDo Title',
              labelText: 'Cook food',
            ),
          ),
          TextField(
            controller: _todoDescription,
            decoration: InputDecoration(
                hintText: 'ToDo description', labelText: 'Cook rice and curry'),
          ),
          TextField(
            controller: _todoDate,
            decoration: InputDecoration(
                hintText: 'YY-MM-DD',
                labelText: 'YY-MM-DD',
                prefixIcon: InkWell(
                    onTap: () {
                      _selectTodoDate(context);
                    },
                    child: Icon(Icons.calendar_today))),
          ),
          DropdownButtonFormField(
            value: _selectedValue,
            items: _categories,
            hint: Text('Select one category'),
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
            },
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('Save'),
          )
        ],
      ),
    );
  }
}
