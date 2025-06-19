part of 'forms.dart';

class GeoQRForm extends StatefulWidget {
  final void Function(String) onValidData;
  const GeoQRForm({super.key, required this.onValidData});

  @override
  State<GeoQRForm> createState() => _GeoQRFormState();
}

class _GeoQRFormState extends State<GeoQRForm> {
  final _lat = TextEditingController();
  final _lng = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onValidData('geo:${_lat.text.trim()},${_lng.text.trim()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _lat,
            decoration: const InputDecoration(
              labelText: 'Latitude',
              prefixIcon: Icon(Icons.location_on),
            ),
            validator: (v) => v!.isEmpty ? 'Required' : null,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _lng,
            decoration: const InputDecoration(
              labelText: 'Longitude',
              prefixIcon: Icon(Icons.location_on),
            ),
            validator: (v) => v!.isEmpty ? 'Required' : null,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _submit, child: const Text('Generate QR')),
        ],
      ),
    );
  }
}
