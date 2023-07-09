import 'package:flutter/material.dart';

class WeatherWidget extends StatefulWidget {
  final IconData icon;
  final String widgetTitle;
  final String title;
  final String? description;
  const WeatherWidget({
    super.key,
    required this.icon,
    required this.widgetTitle,
    required this.title,
    this.description,
  });

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.secondary,
      ),
      padding: const EdgeInsets.all(15),
      height: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.widgetTitle.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          const Spacer(),
          widget.description != null ? Text(widget.description!) : Container()
        ],
      ),
    );
  }
}
