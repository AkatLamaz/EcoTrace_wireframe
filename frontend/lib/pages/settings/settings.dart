import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart'; // Dodaj import GetX

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedFile;
    });
  }

  void _navigateTo(String route) {
    Get.toNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSectionTitle('Podstawowe informacje'),
              _buildProfileImage(),
              _buildListTile('Imię i nazwisko', 'Jan Kowalski', '/profile'),
              _buildListTile('Data urodzenia', '12.12.2012', '/birthdate'),
              _buildListTile('Płeć', 'Mężczyzna', '/gender'),
              const SizedBox(height: 16),
              _buildSectionTitle('Informacje kontaktowe'),
              _buildListTile('E-mail', 'mail@mail.com', '/email'),
              _buildListTile('Telefon', '111 111 111', '/phone'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _navigateTo('/manage-google-emails');
                },
                child: const Text('Zapisz zmiany'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 40,
        backgroundImage: _profileImage != null
            ? FileImage(File(_profileImage!.path))
            : null,
        child: _profileImage == null
            ? const Icon(Icons.person_outline, size: 40, color: Colors.grey)
            : const Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.camera_alt, size: 15, color: Colors.black),
                ),
              ),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, String route) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        _navigateTo(route);
      },
    );
  }
}
