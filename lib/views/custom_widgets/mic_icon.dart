import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class GlowAvatarIcon extends StatefulWidget {
  const GlowAvatarIcon({super.key, this.onPressed, required this.icon});

  final Future<void> Function(bool enabled)? onPressed;
  final IconData icon;

  @override
  State<GlowAvatarIcon> createState() => _GlowAvatarIconState();
}

class _GlowAvatarIconState extends State<GlowAvatarIcon> {
  late bool enabled;

  @override
  void initState() {
    enabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        enabled = !enabled;
        setState(() {});
        await widget.onPressed?.call(enabled);
      },
      child: SizedBox(
        height: 50,
        width: 50,
        child: AvatarGlow(
          repeat: true,
          animate: enabled,
          glowColor: const Color(0xff11c8ea),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(widget.icon, color: const Color(0xff11c8ea)),
          ),
        ),
      ),
    );
  }
}
