part of 'forms.dart';

class PhoneQRForm extends StatefulWidget {
  final void Function(String) onValidData;

  const PhoneQRForm({required this.onValidData});

  @override
  State<PhoneQRForm> createState() => _PhoneQRFormState();
}

class _PhoneQRFormState extends State<PhoneQRForm> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onValidData('tel:${_controller.text.trim()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
            ),
            validator: (v) => v!.isEmpty ? 'Required' : null,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _submit, child: const Text('Generate QR')),
        ],
      ),
    );
  }
}
