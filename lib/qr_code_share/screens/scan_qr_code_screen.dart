import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pingpong_score_tracker/qr_code_share/qr_scan_result.dart';

typedef OnQrCodeScanned = Future<QrScanResult> Function(String? qrCodeData);

class ScanQrCodeScreenArguments {
  const ScanQrCodeScreenArguments({
    required this.onQrCodeScanned,
  });

  final OnQrCodeScanned onQrCodeScanned;
}

class ScanQrCodeScreen extends StatelessWidget {
  const ScanQrCodeScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ScanQrCodeScreenArguments arguments;

  static const route = 'scan-qr-code';

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zeskanuj kod QR'),
      ),
      body: Center(
        child: RotatedBox(
          quarterTurns: isLandscape ? 3 : 0,
          child: MobileScanner(
            onDetect: (barcode, args) async {
              final navigator = Navigator.of(context);
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              final result = await arguments.onQrCodeScanned(barcode.rawValue);

              final snackbarText = result == QrScanResult.success
                  ? 'Kod QR zeskanowany pomyślnie'
                  : result == QrScanResult.invalidQrCode
                      ? 'Zeskanowany kod QR jest niepoprawny'
                      : 'Wystąpił błąd podczas skanowania kodu QR';

              scaffoldMessenger.showSnackBar(
                SnackBar(content: Text(snackbarText)),
              );

              navigator.pop();
            },
          ),
        ),
      ),
    );
  }
}
