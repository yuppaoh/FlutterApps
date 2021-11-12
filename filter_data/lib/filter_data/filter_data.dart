import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'employee.dart';
import 'services.dart';

class FilterData extends StatefulWidget {
  final String title = 'DataTableDemo';

  @override
  _FilterDataState createState() => _FilterDataState();
}

class _FilterDataState extends State<FilterData> {
  List<Employee>? _employees;
  List<Employee>? _filterEmployees;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  String? _titleProgress;
  bool? _isUpdating;
  Employee? _selectedEmployee;

  final _debouncer = Debouncer(milliseconds: 2000);
  @override
  initState(){
    super.initState();
    _employees = [];
    _filterEmployees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getEmployees();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }
  _showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        // Table is created successfully.
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  _addEmployee() {
    if (_firstNameController!.text.isEmpty || _lastNameController!.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Employee...');
    Services.addEmployee(_firstNameController!.text, _lastNameController!.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _getEmployees() {
    _showProgress('Loading Employees...');
    Services.getEmployees().then((value) {
      setState(() {
        _employees = value;
        // Initialize to the list from Server when reloading...
        _filterEmployees = value;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${value.length}");
    });
  }

  _updateEmployee(Employee employee) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    Services.updateEmployee(
        employee.id, _firstNameController!.text, _lastNameController!.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteEmployee(Employee employee) {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee(employee.id).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh after delete...
      }
    });
  }

  _clearValues() {
    _firstNameController!.text = '';
    _lastNameController!.text = '';
  }

  _showValues(Employee employee) {
    _firstNameController!.text = employee.firstName;
    _lastNameController!.text = employee.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress!), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'First Name',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Last Name',
                  ),
                ),
              ),
            ),

            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            _isUpdating!
            ? Row(
              children: <Widget>[
                OutlinedButton(
                  child: Text('UPDATE'),
                  onPressed: () {
                    _updateEmployee(_selectedEmployee!);
                  },
                ),
                OutlinedButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      _isUpdating = false;
                    });
                    _clearValues();
                  },
                ),
              ],
            )
            : Container(),
            searchField(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('ID'),),
            DataColumn(label: Text('FIRST NAME'),),
            DataColumn(label: Text('LAST NAME'),),
            // Lets add one more column to show a delete button
            DataColumn(label: Text('DELETE'),)
          ],
          // the list should show the filtered list now
          rows:
          _filterEmployees!.map((e) => DataRow(
            cells: [
              DataCell(
                Text(e.id),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {
                  _showValues(e);
                  // Set the Selected employee to Update
                  _selectedEmployee = e;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  e.firstName.toUpperCase(),
                ),
                onTap: () {
                  _showValues(e);
                  // Set the Selected employee to Update
                  _selectedEmployee = e;
                  // Set flag updating to true to indicate in Update Mode
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  e.lastName.toUpperCase(),
                ),
                onTap: () {
                  _showValues(e);
                  // Set the Selected employee to Update
                  _selectedEmployee = e;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteEmployee(e);
                },
              ))
            ]
          ),).toList(),
        ),
      ),
    );
  }

  searchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          hintText: 'Filter by First name or Last name',
          fillColor: Colors.amberAccent[100],
          filled: true,
          // border: InputBorder.none,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.circular(25.0),
          ),

        ),
        onChanged: (string) {
          // We will start filtering when the user types in the textfield.
          // Run the debouncer and start searching
          _debouncer.run(() {
            // Filter the original List and update the Filter list
            setState(() {
              _filterEmployees = _employees!
                  .where(
                    (u) => (
                      u.firstName.toLowerCase().contains(string.toLowerCase()) ||
                      u.lastName.toLowerCase().contains(string.toLowerCase())
                    ),
                  ).toList();
            });
          });
        },
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel(); // when the user is continuosly typing, this cancels the timer
    }
    // then we will start a new timer looking for the user to stop
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
