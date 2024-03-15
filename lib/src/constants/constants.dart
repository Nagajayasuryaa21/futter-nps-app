import 'package:flutter/material.dart';

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}
class Constants {
  static String baseUrl = 'https://democrm.kapturecrm.com/ms/feedback/survey/ai/save-associate-data';
  static List<Choice> choices = const <Choice>[
    const Choice(title: 'Life Insurance', icon: Icons.spa),
    const Choice(title: 'Financial Product', icon: Icons.request_quote),
    const Choice(title: 'Health Insurance', icon: Icons.health_and_safety),
    const Choice(title: 'Housing Finance', icon: Icons.house),
    const Choice(title: 'Digital Gold', icon: Icons.diamond),
  ];
}
