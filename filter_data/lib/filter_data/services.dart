import 'dart:convert';

import 'package:http/http.dart' as http;

import 'employee.dart';

class Services {
  static var url = Uri.parse('http://10.0.2.2:1000/flutter_connect/employee_actionsf.php');
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  static List<Employee> empList = [];

  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      // final response = await http.post(Uri.parse(ROOT), body: map);
      final response = await http.post(url, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Employee>> getEmployees() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      // final response = await http.post(Uri.parse(ROOT), body: map);
      final response = await http.post(url, body: map);
      print('getEmployees Response: ${response.body}');
      if (200 == response.statusCode) {
        print('response.statusCode == 200');
        List<Employee> list = parseResponse(response.body);
        return list;
      } else {
        // return <Employee>[];
        return empList;
      }
    } catch (e) {
      // return <Employee>[]; // return an empty list on exception/error
      return empList;
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  static Future<String> addEmployee(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      // final response = await http.post(Uri.parse(ROOT), body: map);
      final response = await http.post(url, body: map);
      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateEmployee(
      String empId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      // final response = await http.post(Uri.parse(ROOT), body: map);
      final response = await http.post(url, body: map);
      print('updateEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> deleteEmployee(String empId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      // final response = await http.post(Uri.parse(ROOT), body: map);
      final response = await http.post(url, body: map);
      print('deleteEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}