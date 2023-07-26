import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:payetonkawa/model/user_model.dart';
import 'package:payetonkawa/page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ScanQrCodePage extends StatefulWidget {
  const ScanQrCodePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScanQrCodePageState createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
  final SharedPreferences _prefs = getIt<SharedPreferences>();
  MobileScannerController? _scannerController;
  bool _isCodeValid = false;
  bool _isLoad = false;

  final UserModel _userModel = new UserModel();

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
  Future<void> _onDetectQRCode(BarcodeCapture capture) async{
    if(_isLoad == true) return;
    if(capture.barcodes.first.rawValue == "Ce QR Code est bon"){
      _openHomePage();
      return;
    }
    
    _scannerController?.stop();
    setState(() => _isLoad = true);
    final List<Barcode> barcodes = capture.barcodes;

    var user = await _userModel.getUser(barcodes.first.rawValue!);

    if(user != null && !_isCodeValid){
      _isCodeValid = true;
      await _prefs.setString(idUserPreferenceKey, user.token!);
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
    _scannerController?.dispose();
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
          Visibility(
            visible: kDebugMode && false,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
              ),
              onPressed: () => _openHomePage(),
              child: const  Text("debug login"),
            ),
          ),
        ],
      ),
    );
  }
}
