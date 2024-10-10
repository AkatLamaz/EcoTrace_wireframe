import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart'; // Dodaj import GetX

class SettingsController extends GetxController {
  final name = 'Jan Kowalski'.obs;
  final birthDate = DateTime.now().obs;
  final gender = 'Mężczyzna'.obs;
  final email = 'mail@mail.com'.obs;
  final phone = '111111111'.obs;
  final Rx<XFile?> profileImage = Rx<XFile?>(null);

  void updateName(String value) {
    if (value.length <= 50) {
      name.value = value;
    } else {
      Get.snackbar('Błąd', 'Imię i nazwisko nie może przekraczać 50 znaków');
    }
  }

  void updateBirthDate(DateTime value) => birthDate.value = value;
  void updateGender(String value) => gender.value = value;
  void updateEmail(String value) {
    if (_isValidEmail(value)) {
      email.value = value;
    } else {
      Get.snackbar('Błąd', 'Nieprawidłowy adres e-mail');
    }
  }
  void updatePhone(String value) {
    if (value.length <= 11 && value.contains(RegExp(r'^[0-9]+$'))) {
      phone.value = value;
    } else {
      Get.snackbar('Błąd', 'Numer telefonu musi składać się z maksymalnie 11 cyfr');
    }
  }
  void updateProfileImage(XFile? value) => profileImage.value = value;

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();
  final SettingsController controller = Get.put(SettingsController());

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
              _buildProfileImage(context),
              Obx(() => _buildEditableListTile('Imię i nazwisko', controller.name.value, _editName)),
              Obx(() => _buildEditableListTile('Data urodzenia', controller.birthDate.value.toString().split(' ')[0], _editBirthDate)),
              Obx(() => _buildEditableListTile('Płeć', controller.gender.value, _editGender)),
              const SizedBox(height: 16),
              _buildSectionTitle('Informacje kontaktowe'),
              Obx(() => _buildEditableListTile('E-mail', controller.email.value, _editEmail)),
              Obx(() => _buildEditableListTile('Telefon', controller.phone.value, _editPhone)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveChanges,
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

  Widget _buildProfileImage(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Obx(() => CircleAvatar(
        radius: 40,
        backgroundImage: controller.profileImage.value != null
            ? FileImage(File(controller.profileImage.value!.path))
            : null,
        child: controller.profileImage.value == null
            ? const Icon(Icons.person_outline, size: 40, color: Colors.grey)
            : null,
      )),
    );
  }

  Widget _buildEditableListTile(String title, String value, Function() onEdit) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: onEdit,
      ),
    );
  }

  void _pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.updateProfileImage(pickedFile);
    }
  }

  void _editName() {
    final TextEditingController nameController = TextEditingController(text: controller.name.value);
    String? errorText;
    Get.defaultDialog(
      title: 'Edytuj imię i nazwisko',
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              TextField(
                controller: nameController,
                onChanged: (value) {
                  setState(() {
                    errorText = value.length > 50 ? 'Imię i nazwisko nie może przekraczać 50 znaków' : null;
                  });
                },
                maxLength: 50,
                decoration: InputDecoration(
                  counterText: '${nameController.text.length}/50',
                  errorText: errorText,
                ),
              ),
              if (errorText != null) Text(errorText!, style: TextStyle(color: Colors.red)),
            ],
          );
        },
      ),
      confirm: TextButton(
        onPressed: () {
          if (errorText == null) {
            controller.updateName(nameController.text);
            Get.back();
          }
        },
        child: const Text('OK'),
      ),
    );
  }

  void _editBirthDate() {
    Get.defaultDialog(
      title: 'Edytuj datę urodzenia',
      content: Obx(() => Text(controller.birthDate.value.toString().split(' ')[0])),
      confirm: TextButton(
        onPressed: () async {
          final date = await showDatePicker(
            context: Get.context!,
            initialDate: controller.birthDate.value,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            controller.updateBirthDate(date);
          }
          Get.back();
        },
        child: const Text('Wybierz datę'),
      ),
    );
  }

  void _editGender() {
    Get.defaultDialog(
      title: 'Wybierz płeć',
      content: Column(
        children: ['Mężczyzna', 'Kobieta', 'Inna'].map((gender) => 
          RadioListTile<String>(
            title: Text(gender),
            value: gender,
            groupValue: controller.gender.value,
            onChanged: (value) {
              controller.updateGender(value!);
              Get.back();
            },
          ),
        ).toList(),
      ),
    );
  }

  void _editEmail() {
    final TextEditingController emailController = TextEditingController(text: controller.email.value);
    String? errorText;
    Get.defaultDialog(
      title: 'Edytuj e-mail',
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              TextField(
                controller: emailController,
                onChanged: (value) {
                  setState(() {
                    errorText = controller._isValidEmail(value) ? null : 'Nieprawidłowy adres e-mail';
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: errorText,
                ),
              ),
              if (errorText != null) Text(errorText!, style: TextStyle(color: Colors.red)),
            ],
          );
        },
      ),
      confirm: TextButton(
        onPressed: () {
          if (errorText == null) {
            controller.updateEmail(emailController.text);
            Get.back();
          }
        },
        child: const Text('OK'),
      ),
    );
  }

  void _editPhone() {
    final TextEditingController phoneController = TextEditingController(text: controller.phone.value);
    String? errorText;
    Get.defaultDialog(
      title: 'Edytuj numer telefonu',
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              TextField(
                controller: phoneController,
                onChanged: (value) {
                  setState(() {
                    errorText = (value.length >= 9 && value.length <= 11) ? null : 'Numer musi mieć od 9 do 11 cyfr';
                  });
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: InputDecoration(
                  counterText: '${phoneController.text.length}/11',
                  errorText: errorText,
                ),
              ),
              if (errorText != null) Text(errorText!, style: TextStyle(color: Colors.red)),
            ],
          );
        },
      ),
      confirm: TextButton(
        onPressed: () {
          if (errorText == null) {
            controller.updatePhone(phoneController.text);
            Get.back();
          }
        },
        child: const Text('OK'),
      ),
    );
  }

  void _saveChanges() {
    if (_validateData()) {
      Get.snackbar('Sukces', 'Zmiany zostały zapisane');
    }
  }

  bool _validateData() {
    if (controller.name.value.isEmpty || controller.name.value.length > 50) {
      Get.snackbar('Błąd', 'Imię i nazwisko musi mieć od 1 do 50 znaków');
      return false;
    }
    if (!controller._isValidEmail(controller.email.value)) {
      Get.snackbar('Błąd', 'Nieprawidłowy adres e-mail');
      return false;
    }
    if (controller.phone.value.length < 9 || controller.phone.value.length > 11) {
      Get.snackbar('Błąd', 'Numer telefonu musi mieć od 9 do 11 cyfr');
      return false;
    }
    return true;
  }
}