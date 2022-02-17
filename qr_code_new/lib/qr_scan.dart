import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScan extends StatefulWidget {
  const QRScan({ Key? key }) : super(key: key);

  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  QrCode? qrcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(bottom: 70, child: buildResult()),
          Positioned(right: 10, bottom: 10, child: buildControlButtons()),
        ],
        
      ),
    );
  }

  Widget buildControlButtons() => Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            await controller?.toggleFlash();
            setState(() {
              
            });
          },
          icon: 
          // Icon(Icons.flash_off)
          FutureBuilder<bool?>(
            future: controller?.getFlashStatus(),
            builder: (context, snapshot){
              if(snapshot.data != null) {
                return Icon(
                  snapshot.data! ? Icons.flash_on : Icons.flash_off
                );
              } else {
                return Container();
              }
            }
          )
        ),
        IconButton(
          onPressed: () async {
            await controller?.flipCamera();
            setState(() {
              
            });
          },
          icon: 
          // Icon(Icons.switch_camera),
          FutureBuilder(
            future: controller?.getCameraInfo(),
            builder: (context, snapshot){
              if(snapshot.data != null) {
                return Icon(Icons.switch_camera);
              } else {
                return Container();
              }
            }
          )
        )
      ],
    ),
  );  

  Widget buildResult() => Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24
    ),
    child: Text(
      // barcode != null ? 'Result: ${barcode!.code}' : 'Scan a code!',
      qrcode != null ? 'Result: ${qrcode!.toString()}' : 'Scan a code!',
      maxLines: 3,
    ),
  );

  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderColor: Theme.of(context).accentColor,
      borderRadius: 5,
      borderWidth: 8,
      borderLength: 30,
      cutOutSize: MediaQuery.of(context).size.width * 0.8,
    ),
  );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen(
      // (barcode) => setState(() => this.barcode = barcode)
      
      (scanData) async {
      controller.pauseCamera();
      if (await canLaunch(scanData.code)) {
        await launch(scanData.code);
        controller.resumeCamera();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Could not find viable url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Barcode Type: ${describeEnum(scanData.format)}'),
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    }

    );
  }

  
}