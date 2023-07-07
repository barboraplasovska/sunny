import 'package:flutter/material.dart';
import 'package:sunny/services/shared_prefs_service.dart';

class AddCityPopup extends StatefulWidget {
  const AddCityPopup({super.key});

  @override
  State<AddCityPopup> createState() => _AddCityPopupState();
}

class _AddCityPopupState extends State<AddCityPopup> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text('Add a City'),
      content: TextField(
        controller: _cityController,
        decoration: const InputDecoration(
          hintText: 'Enter city name',
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
          onPressed: () async => {
            await addCity(_cityController.text),
            Navigator.of(context).pop(),
          },
          child: Text(
            'OK',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
