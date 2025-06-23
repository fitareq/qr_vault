import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_vault/core/constants/app_strings.dart';

import '../../../../../shared/widgets/qr_preview.dart';
import '../../../provider/generator_provider.dart';
import '../../../utils/generator_utils.dart';

part 'contact_qr_form.dart';
part 'email_qr_form.dart';
part 'event_qr_form.dart';
part 'geo_qr_form.dart';
part 'phone_qr_form.dart';
part 'sms_qr_form.dart';
part 'text_qr_form.dart';
part 'url_qr_form.dart';
part 'wifi_qr_form.dart';

class QRFormSwitcher extends StatelessWidget {
  const QRFormSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QRGeneratorProvider>(context);
    final setData = provider.setGeneratedData;

    switch (provider.selectedType) {
      case QRType.text:
        return TextQRForm(
          onValidData: (data) {
            setData;
            _showQRPreview(context, data);
          },
        );
      case QRType.url:
        return UrlQRForm(
          onValidData: (data) {
            setData;
            _showQRPreview(context, data);
          },
        );
      case QRType.email:
        return EmailQRForm(
          onValidData: (data) {
            setData;
            _showQRPreview(context, data);
          },
        );
      case QRType.phone:
        return PhoneQRForm(
          onValidData: (data) {
            setData;
            _showQRPreview(context, data);
          },
        );
      case QRType.sms:
        return SmsQRForm(
          onValidData: (data) {
            setData;
            _showQRPreview(context, data);
          },
        );
      case QRType.wifi:
        return WifiQRForm(
          onValidData: (data) {
            setData;
            _showQRPreview(context, data);
          },
        );
      case QRType.geo:
        return GeoQRForm(
          onValidData: (data) {
            setData;
            _showQRPreview(context, data);
          },
        );
      case QRType.contact:
        return ContactQRForm(
          onValidData: (data) {
            setData;
            _showQRPreview(context, data);
          },
        );
      case QRType.event:
        return EventQRForm(
          onValidData: (data) {
            setData;
            _showQRPreview(context, data);
          },
        );
    }
  }

  void _showQRPreview(BuildContext context, String data) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            insetPadding: EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(child: QRPreview(data: data)),
            ),
          ),
    );
  }
}
