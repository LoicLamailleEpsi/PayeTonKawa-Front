import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:payetonkawa/page/list_product_page.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  _ScanQrCodeState createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  @override
  Widget build(BuildContext context) {
    bool isCodeValid = false;
    return Scaffold(
      appBar: AppBar(title: const Text('Scannez votre QR Code d\'accès')),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          facing: CameraFacing.back,
          //torchEnabled: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
            if (barcode.rawValue == 'Ce QR Code est bon' && !isCodeValid) {
              isCodeValid = true;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListProductPage()),
              );
              break;
            } else {
              debugPrint('Access denied !');
              barcodes.remove(barcode);
            }
          }
        },
      ),
    );
  }
}
