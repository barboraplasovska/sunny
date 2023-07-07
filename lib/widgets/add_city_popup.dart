import 'package:flutter/material.dart';
import 'package:sunny/services/shared_prefs_service.dart';

class AddCityPopup extends StatefulWidget {
  const AddCityPopup({super.key});

  @override
  State<AddCityPopup> createState() => _AddCityPopupState();
}

class _AddCityPopupState extends State<AddCityPopup> {
  TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a City'),
      content: TextField(
        controller: _cityController,
        decoration: const InputDecoration(
          hintText: 'Enter city name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async => {
            await addCity(_cityController.text),
            Navigator.of(context).pop(),
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
