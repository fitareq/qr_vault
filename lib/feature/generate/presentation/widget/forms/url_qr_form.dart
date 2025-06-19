part of 'forms.dart';

class UrlQRForm extends StatefulWidget {
  final void Function(String) onValidData;

  const UrlQRForm({required this.onValidData});

  @override
  State<UrlQRForm> createState() => _UrlQRFormState();
}

class _UrlQRFormState extends State<UrlQRForm> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final text = _controller.text.trim();
    if (_formKey.currentState!.validate()) {
      widget.onValidData(text.startsWith('http') ? text : 'https://$text');
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
              labelText: 'Website URL',
              prefixIcon: Icon(Icons.link),
              hintText: 'https://example.com',
            ),
            validator:
                (val) => val == null || val.trim().isEmpty ? 'Required' : null,
            keyboardType: TextInputType.url,
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _submit, child: const Text('Generate QR')),
        ],
      ),
    );
  }
}
