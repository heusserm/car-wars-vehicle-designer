import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'design_vehicle_screen.dart';
import 'vehicle_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car Wars Vehicle Designer')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.directions_car, size: 96),
              const SizedBox(height: 16),
              const Text(
                'Design and manage your Car Wars vehicles.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const VehicleListScreen()),
                ),
                icon: const Icon(Icons.list),
                label: const Text('View My Vehicles'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DesignVehicleScreen()),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Design New Vehicle'),
              ),
              const SizedBox(height: 40),
              const _AttributionNotice(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AttributionNotice extends StatelessWidget {
  const _AttributionNotice();

  static final Uri _policyUrl = Uri.parse('https://www.sjgames.com/general/online_policy.html');
  static final Uri _storeUrl = Uri.parse('https://warehouse23.com/collections/car-wars-classic');

  Future<void> _open(Uri url) async {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    const baseStyle = TextStyle(fontSize: 12, color: Colors.grey, height: 1.4);
    final linkStyle = baseStyle.copyWith(
      color: Theme.of(context).colorScheme.primary,
      decoration: TextDecoration.underline,
    );

    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(
            text: 'Car Wars Vehicle Designer is a free game aid for the Car Wars '
                'Compendium and prior versions of the game, used with permission (',
          ),
          TextSpan(
            text: 'SJG Online Policy',
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = () => _open(_policyUrl),
          ),
          const TextSpan(
            text: '). This app does not provide a standalone game. You can purchase '
                'the classic versions of the game that this aid supports at ',
          ),
          TextSpan(
            text: 'Warehouse 23',
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = () => _open(_storeUrl),
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
