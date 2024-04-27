import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QR extends StatelessWidget {
  final String? upiID;
  final double? size;
  final String? fullName;
  const QR({
    super.key,
    required this.upiID,
    required this.size,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    String data = "upi://pay?pa=$upiID";
    if (fullName != null && fullName!.isNotEmpty) {
      data += "&pn=$fullName";
    }
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: 320,
      gapless: false,
      backgroundColor: Colors.white,
      eyeStyle: const QrEyeStyle(
        color: Colors.teal,
        eyeShape: QrEyeShape.circle,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        color: Colors.teal,
        dataModuleShape: QrDataModuleShape.circle,
      ),
    );
  }
}
