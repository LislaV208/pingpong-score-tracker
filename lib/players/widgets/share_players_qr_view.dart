import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SharePlayersQrView extends StatelessWidget {
  const SharePlayersQrView({
    Key? key,
    required this.playersJsonData,
  }) : super(key: key);

  final String playersJsonData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: playersJsonData,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Udostępnij listę graczy',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                const Text(
                  '1. Na drugim urządzeniu wybierz opcję "Importuj"\n2. Zeskanuj widoczny obok kod QR',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
