import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_vault/feature/generate/presentation/widget/forms/forms.dart';
import 'package:qr_vault/feature/generate/presentation/widget/qr_type_card.dart';

import '../provider/generator_provider.dart';
import '../utils/generator_utils.dart';

class GeneratorScreen extends StatelessWidget {
  const GeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QRGeneratorProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Generator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              children:
                  QRType.values.map((type) {
                    return QRTypeCard(
                      type: type,
                      selected: provider.selectedType == type,
                      onTap: () => provider.selectType(type),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
            QRFormSwitcher(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
