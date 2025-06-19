part of 'forms.dart';

class EmailQRForm extends StatefulWidget {
  final void Function(String) onValidData;

  const EmailQRForm({super.key, required this.onValidData});

  @override
  State<EmailQRForm> createState() => _EmailQRFormState();
}

class _EmailQRFormState extends State<EmailQRForm> {
  final _email = TextEditingController();
  final _subject = TextEditingController();
  final _body = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final mail =
          'mailto:${_email.text}?subject=${Uri.encodeComponent(_subject.text)}&body=${Uri.encodeComponent(_body.text)}';
      widget.onValidData(mail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: FocusScope(
        child: Column(
          children: [
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (v) => v!.isEmpty ? 'Required' : null,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _subject,
              decoration: const InputDecoration(
                labelText: 'Subject',
                prefixIcon: Icon(Icons.subject),
              ),
              validator: (v) => v!.isEmpty ? 'Required' : null,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _body,
              decoration: const InputDecoration(
                labelText: 'Body',
                prefixIcon: Icon(Icons.message),
              ),
              validator: (v) => v!.isEmpty ? 'Required' : null,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Generate QR'),
            ),
          ],
        ),
      ),
    );
  }
}
