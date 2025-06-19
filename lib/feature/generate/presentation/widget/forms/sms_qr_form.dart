part of 'forms.dart';

class SmsQRForm extends StatefulWidget {
  final void Function(String) onValidData;
  const SmsQRForm({required this.onValidData});

  @override
  State<SmsQRForm> createState() => _SmsQRFormState();
}

class _SmsQRFormState extends State<SmsQRForm> {
  final _number = TextEditingController();
  final _message = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onValidData('SMSTO:${_number.text.trim()}:${_message.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _number,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
            ),
            validator: (v) => v!.isEmpty ? 'Required' : null,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _message,
            decoration: const InputDecoration(
              labelText: 'Message',
              prefixIcon: Icon(Icons.message),
            ),
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _submit, child: const Text('Generate QR')),
        ],
      ),
    );
  }
}
