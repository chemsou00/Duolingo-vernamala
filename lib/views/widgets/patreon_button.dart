// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PatreonButton extends StatefulWidget {
  const PatreonButton({Key? key}) : super(key: key);

  @override
  State<PatreonButton> createState() => _PatreonButtonState();
}

class _PatreonButtonState extends State<PatreonButton> {
  // Use a unique key to restart animations
  Key _animateKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        const url = 'https://www.patreon.com'; // TODO: Update with your Patreon URL
        try {
          final uri = Uri.parse(url);
          // Try launching directly without checking canLaunchUrl first
          // This avoids issues with query intent configuration on newer Android/iOS
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } catch (e) {
             if (context.mounted) {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Could not launch Patreon: $e')),
              );
             }
        }
      },
      icon: const FaIcon(
        FontAwesomeIcons.patreon,
        color: Color(0xFFFF424D), // Patreon Brand Color
        size: 20,
      )
      .animate(
        key: _animateKey,
        onComplete: (controller) async {
          // Wait for random duration between 10s and 30s
          final delay = 10 + (DateTime.now().microsecond % 20);
          await Future.delayed(Duration(seconds: delay));
          if (mounted) {
            setState(() {
              _animateKey = UniqueKey(); // Rebuild to restart animation
            });
          }
        },
      )
      .scale(
        duration: 200.ms,
        begin: const Offset(1, 1),
        end: const Offset(1.2, 1.2),
        curve: Curves.easeInOut,
      )
      .then()
      .scale(
        duration: 200.ms,
        begin: const Offset(1.2, 1.2),
        end: const Offset(1, 1),
        curve: Curves.easeInOut,
      )
      .then()
      .scale( // Double beat
        duration: 200.ms,
        begin: const Offset(1, 1),
        end: const Offset(1.2, 1.2),
        curve: Curves.easeInOut,
      )
      .then()
      .scale(
        duration: 200.ms,
        begin: const Offset(1.2, 1.2),
        end: const Offset(1, 1),
        curve: Curves.easeInOut,
      ),
    );
  }
}
