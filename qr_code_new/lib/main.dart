import 'package:flutter/material.dart';
import 'package:qr_code_new/qr_generate.dart';
import 'package:qr_code_new/qr_scan.dart';
// import 'package:textfield_demo/scan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => QRScan()));
              },
              icon: Icon(Icons.qr_code_scanner))
        ],
      ),
      body: Container(
        margin:
            EdgeInsets.only(top: MediaQuery.of(context).size.height / 2 - 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QRGenerate(title: 'QR Generate')));
              },
              child: Text('QR Generate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => QRScan()));
              },
              child: Text('QR Scan'),
            )
          ],
        ),
      ),
    );
  }
}
