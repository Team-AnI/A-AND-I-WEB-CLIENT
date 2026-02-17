import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  final double? width;
  const LogoImage({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      child: Image.asset("assets/logo.webp"),
    );
  }
}
