import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';

class CredButton extends StatelessWidget {
  final String buttonText;
  final Function()? onTap;
  final Color? bgColor;
  final Color? borderColor;
  final Color plunkColor;
  final bool? shimmer;
  final double? borderWidth;

  const CredButton({
    super.key,
    required this.buttonText,
    this.onTap,
    this.bgColor,
    this.borderColor,
    required this.plunkColor,
    this.shimmer,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return NeoPopTiltedButton(
      isFloating: true,
      onTapUp: onTap ?? () {},
      decoration: NeoPopTiltedButtonDecoration(
        color: bgColor ?? const Color(0xFF0D0D0D),
        plunkColor: plunkColor, // Color.fromARGB(255, 200, 62, 227),
        shadowColor: Colors.black,
        border: Border.fromBorderSide(
          BorderSide(
            color: borderColor ?? const Color(0xFF8DD04A),
            width: borderWidth ?? 1,
          ),
        ),
        showShimmer: shimmer ?? false,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 15),
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
