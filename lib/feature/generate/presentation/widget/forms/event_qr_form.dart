part of 'forms.dart';

class EventQRForm extends StatefulWidget {
  final void Function(String) onValidData;

  const EventQRForm({super.key, required this.onValidData});

  @override
  State<EventQRForm> createState() => _EventQRFormState();
}

class _EventQRFormState extends State<EventQRForm> {
  final _title = TextEditingController();
  final _location = TextEditingController();
  final _start = TextEditingController();
  final _end = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String startDate = "";
  String endDate = "";

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final ics = '''
BEGIN:VEVENT
SUMMARY:${_title.text}
LOCATION:${_location.text}
DTSTART:${startDate}
DTEND:${endDate}
END:VEVENT
''';
      widget.onValidData(ics.trim());
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
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Event Title',
                prefixIcon: Icon(Icons.event),
              ),
              validator: (v) => v!.isEmpty ? 'Required' : null,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _location,
              decoration: const InputDecoration(
                labelText: 'Location',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (v) => v!.isEmpty ? 'Required' : null,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.streetAddress,
            ),
            SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              controller: _start,
              decoration: const InputDecoration(
                labelText: 'Start',
                prefixIcon: Icon(Icons.calendar_month),
              ),
              onTap: () async {
                final picked = await _pickDateTime(context);
                if (picked != null) {
                  _start.text = _formatReadableDate(picked);
                  startDate = _formatICalendarDate(picked);
                }
              },
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              onTap: () async {
                final picked = await _pickDateTime(context);
                if (picked != null) {
                  _end.text = _formatReadableDate(picked);
                  endDate = _formatICalendarDate(picked);
                }
              },
              controller: _end,
              decoration: const InputDecoration(
                labelText: 'End',
                prefixIcon: Icon(Icons.calendar_month),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Generate QR'),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date == null) {
      return null;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  String _formatICalendarDate(DateTime dt) {
    final utc = dt.toUtc();
    return '${_twoDigits(utc.year)}'
        '${_twoDigits(utc.month)}'
        '${_twoDigits(utc.day)}T'
        '${_twoDigits(utc.hour)}'
        '${_twoDigits(utc.minute)}'
        '${_twoDigits(utc.second)}Z';
  }

  String _formatReadableDate(DateTime dt) {
    return DateFormat('MMM d, y hh:mm a').format(dt);
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
