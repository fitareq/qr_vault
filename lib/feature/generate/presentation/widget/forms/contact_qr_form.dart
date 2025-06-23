part of 'forms.dart';

class ContactQRForm extends StatefulWidget {
  final void Function(String) onValidData;

  const ContactQRForm({super.key, required this.onValidData});

  @override
  State<ContactQRForm> createState() => _ContactQRFormState();
}

class _ContactQRFormState extends State<ContactQRForm> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final vCard =
          'MECARD:N:${_name.text};TEL:${_phone.text};EMAIL:${_email.text};;';
      widget.onValidData(vCard);
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
              controller: _name,
              decoration: InputDecoration(
                labelText: AppStrings.contactNameLabel,
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (v) => v!.isEmpty ? AppStrings.required : null,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phone,
              decoration: const InputDecoration(
                labelText: AppStrings.contactPhoneLabel,
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              validator: (v) => v!.isEmpty ? AppStrings.required : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: AppStrings.contactEmailLabel,
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submit,
              child: const Text(AppStrings.generateQr),
            ),
          ],
        ),
      ),
    );
  }
}
