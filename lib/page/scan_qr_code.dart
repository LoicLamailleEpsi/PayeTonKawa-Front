import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:payetonkawa/page/list_product_page.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({Key? key}) : super(key: key);

  @override
  _ScanQrCodeState createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  MobileScannerController? _scannerController;
  bool isCodeValid = false;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
    );
  }

  @override
  void dispose() {
    _scannerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scannez votre QR Code d'accès")),
      body: MobileScanner(
        controller: _scannerController!,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          List<Barcode> validBarcodes = barcodes
              .where((barcode) => barcode.rawValue == 'Ce QR Code est bon')
              .toList();

          if (validBarcodes.isNotEmpty && !isCodeValid) {
            isCodeValid = true;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const ListProductPage(),
              ),
              (route) => route.isFirst,
            );
            // Fermer la caméra après vérification du QR code
            _scannerController?.stop();
          } else {
            debugPrint('Access denied !');
          }
        },
      ),
    );
  }
}
