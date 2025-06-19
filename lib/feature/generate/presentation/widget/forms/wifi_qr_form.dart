part of 'forms.dart';

class WifiQRForm extends StatefulWidget {
  final void Function(String) onValidData;

  const WifiQRForm({required this.onValidData});

  @override
  State<WifiQRForm> createState() => _WifiQRFormState();
}

class _WifiQRFormState extends State<WifiQRForm> {
  final _ssid = TextEditingController();
  final _password = TextEditingController();
  bool _isHidden = false;
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final data =
          'WIFI:S:${_ssid.text};T:WPA;P:${_password.text};H:${_isHidden.toString()};';
      widget.onValidData(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _ssid,
            decoration: const InputDecoration(
              labelText: 'SSID',
              prefixIcon: Icon(Icons.wifi),
              hintText: 'Wi-Fi Name',
            ),
            validator: (v) => v!.isEmpty ? 'Required' : null,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _password,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (v) => v!.isEmpty ? 'Required' : null,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 10),
          SwitchListTile(
            title: const Text('Hidden Network'),
            value: _isHidden,
            onChanged: (v) => setState(() => _isHidden = v),
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _submit, child: const Text('Generate QR')),
        ],
      ),
    );
  }
}
