import 'package:flutter/material.dart';
import 'package:mvp_idr_corner/models/model.dart';
import 'package:mvp_idr_corner/presenters/presenter.dart';
import 'package:mvp_idr_corner/views/view.dart';

// https://www.youtube.com/watch?v=N2ul7YGz_xE&t=551s

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.appPresenter, {Key? key}) : super(key: key);
  final AppPresenter appPresenter;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements AppView{
  AppModel? _appModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MVP Demo'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            TextField(
              controller: _appModel!.textController1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              controller: _appModel!.textController2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () => this.widget.appPresenter.btnClick(),
              child: Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(100, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                )
              ),
            ),
            SizedBox(height: 20.0,),
            Text('Result: ${_appModel!.result}', style: TextStyle(fontSize: 25.0),),
          ],
        ),
      ),
    );
  }

  @override
  void refreshData(AppModel model) {
    setState(() {
      this._appModel = model;
    });
  }

  @override
  void initState() {
    super.initState();
    this.widget.appPresenter.view = this;
  }
}
