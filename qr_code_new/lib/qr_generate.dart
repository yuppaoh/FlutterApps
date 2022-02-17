import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGenerate extends StatefulWidget {
  QRGenerate({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _QRGenerateState createState() => _QRGenerateState();
}

class _QRGenerateState extends State<QRGenerate> {
  final textController = TextEditingController();
  String? qrtext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: textController.text,
              // data: qrtext ?? 'guest',
              version: QrVersions.auto,
              size: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: textController,
                onChanged: (txt) {
                  print('text: ${textController.text}');
                  setState(() {
                    qrtext = txt;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'username',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
