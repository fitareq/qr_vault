import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
        return UrlQRForm(onValidData: setData);
      case QRType.email:
        return EmailQRForm(onValidData: setData);
      case QRType.phone:
        return PhoneQRForm(onValidData: setData);
      case QRType.sms:
        return SmsQRForm(onValidData: setData);
      case QRType.wifi:
        return WifiQRForm(onValidData: setData);
      case QRType.geo:
        return GeoQRForm(onValidData: setData);
      case QRType.contact:
        return ContactQRForm(onValidData: setData);
      case QRType.event:
        return EventQRForm(onValidData: setData);
    }
  }

  void _showQRPreview(BuildContext context, String data) {
    showDialog(context: context, builder: (_) => QRPreview(data: data));
  }
}
