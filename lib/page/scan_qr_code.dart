import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:payetonkawa/model/customer_model.dart';
import 'package:payetonkawa/page/home_page.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScanQrCodeState createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  MobileScannerController? _scannerController;
  bool _isCodeValid = false;
  bool _isLoad = false;

  final CustomerModel _customerModel = new CustomerModel();

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController();
  }

  @override
  void dispose() {
    super.dispose();
    _scannerController?.dispose();
  }

  Future<void> _onDetectQRCode(capture) async{
    _scannerController?.stop();
    setState(() => _isLoad = true);
    final List<Barcode> barcodes = capture.barcodes;

    var customer = await _customerModel.getCustomer(barcodes.first.rawValue!);

    if(customer != null && !_isCodeValid){
      _isCodeValid = true;
      _openHomePage();
    }else{
      await _showDialogError();
      _scannerController?.start();
    }
   
    setState(() => _isLoad = false);
  }

  Future<void> _showDialogError() async {
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Erreur de connexion"),
        content: const Text("Le QRCode n'est pas reconnu"),
        actions: [
          TextButton(
            child: const Text("Fermer"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }


  void _openHomePage(){
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (route) => route.isCurrent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scannez votre QR Code d'accès")),
      body: Stack(
        children: [
          MobileScanner(
            controller: _scannerController,
            onDetect: (capture) => _onDetectQRCode(capture),
          ),
          Visibility(
            visible: _isLoad,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 25),
                  Text("Veuillez patienter ...", style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            onPressed: () => _openHomePage(),
            child: const  Text("Login"),
          ),
        ],
      ),
    );
  }
}
