part of 'forms.dart';

class TextQRForm extends StatefulWidget {
  final void Function(String) onValidData;
  const TextQRForm({super.key, required this.onValidData});

  @override
  State<TextQRForm> createState() => _TextQRFormState();
}

class _TextQRFormState extends State<TextQRForm> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onValidData(_controller.text.trim());
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
              labelText: 'Enter text',
              prefixIcon: Icon(Icons.text_fields),
            ),
            validator:
                (val) => val == null || val.trim().isEmpty ? 'Required' : null,
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _submit, child: const Text('Generate QR')),
        ],
      ),
    );
  }
}
