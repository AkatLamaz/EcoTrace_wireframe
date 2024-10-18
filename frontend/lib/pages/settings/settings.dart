import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart'; // Dodaj import GetX
import 'package:provider/provider.dart';
import '../../constants/style.dart';
import '../../theme_provider.dart';


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
  SettingsPage({super.key});

  final ImagePicker _picker = ImagePicker();
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
  return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
            iconTheme: IconThemeData(
              color: themeProvider.isDarkMode ? light(context) : dark(context), // Change arrow color based on theme
            ),
            titleTextStyle: TextStyle(
              color: themeProvider.isDarkMode ? light(context) : dark(context), // Change title text color based on theme
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSectionTitle(context, 'Podstawowe informacje', themeProvider),
                  _buildProfileImage(context, themeProvider),
                  const SizedBox(height: 5),
                  Obx(() => _buildEditableListTile(context, 'Imię i nazwisko', controller.name.value, () => _editName(context), themeProvider)),
                  const SizedBox(height: 5),
                  Obx(() => _buildEditableListTile(context, 'Data urodzenia', controller.birthDate.value.toString().split(' ')[0], () => _editBirthDate(context), themeProvider)),
                  const SizedBox(height: 5),
                  Obx(() => _buildEditableListTile(context, 'Płeć', controller.gender.value, () => _editGender(context), themeProvider)),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Informacje kontaktowe', themeProvider),
                  const SizedBox(height: 5),
                  Obx(() => _buildEditableListTile(context, 'E-mail', controller.email.value, () => _editEmail(context), themeProvider)),
                  const SizedBox(height: 5),
                  Obx(() => _buildEditableListTile(context, 'Telefon', controller.phone.value, () => _editPhone(context), themeProvider)),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Appearance', themeProvider),
                  const SizedBox(height: 5),
                  _buildThemeToggle(context, themeProvider),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      iconColor: shadowColor(context),
                      elevation: 4,
                    ),
                    child: const Text('Zapisz zmiany'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, ThemeProvider themeProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: themeProvider.isDarkMode ? light(context) : dark(context),
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context, ThemeProvider themeProvider) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Obx(() => CircleAvatar(
        radius: 40,
        backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
        backgroundImage: controller.profileImage.value != null
            ? FileImage(File(controller.profileImage.value!.path))
            : null,
        child: controller.profileImage.value == null
            ? const Icon(Icons.person_outline, size: 40, color: Colors.grey)
            : null,
      )),
    );
  }

  Widget _buildEditableListTile(BuildContext context, String title, String value, Function() onTap, ThemeProvider themeProvider) {
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? dark(context) : light(context),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: themeProvider.isDarkMode ? lightGrey(context) : shadowColor(context),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor(context),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: themeProvider.isDarkMode ? light(context) : dark(context),
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            color: themeProvider.isDarkMode ? lightGrey(context) : dark(context),
          ),
        ),
        trailing: Icon(
          Icons.edit,
          color: themeProvider.isDarkMode ? lightGrey(context) : dark(context),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }

  void _pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.updateProfileImage(pickedFile);
    }
  }

  void _editName(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: controller.name.value);
    String? errorText;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    Get.defaultDialog(
      title: 'Edytuj imię i nazwisko',
      titleStyle: TextStyle(
        color: themeProvider.isDarkMode ? light(context) : dark(context),
      ),
      backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
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
                  fillColor: themeProvider.isDarkMode ? dark(context) : light(context),
                  filled: true,
                ),
                style: TextStyle(
                  color: themeProvider.isDarkMode ? light(context) : dark(context),
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

  Widget _buildThemeToggle(BuildContext context, ThemeProvider themeProvider) {
    return SwitchListTile(
      title: Text(
        'Dark Mode',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        themeProvider.toggleTheme(value);
      },
    );
  }

void _editBirthDate(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false); // Access the ThemeProvider using Provider

  Get.defaultDialog(
    title: 'Edytuj datę urodzenia',
    titleStyle: TextStyle(
      color: themeProvider.isDarkMode ? light(context) : dark(context),
    ),
    backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
    content: Obx(() => Text(
      controller.birthDate.value.toString().split(' ')[0],
      style: TextStyle(
        color: themeProvider.isDarkMode ? lightGrey(context) : dark(context),
      ),
    )),
    confirm: TextButton(
      onPressed: () async {
        final date = await showDatePicker(
          context: context, // Use the passed context here
          initialDate: controller.birthDate.value,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: themeProvider.isDarkMode
                    ? const ColorScheme.dark()
                    : const ColorScheme.light(),
              ),
              child: child!,
            );
          },
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

  void _editGender(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    Get.defaultDialog(
      title: 'Wybierz płeć',
      titleStyle: TextStyle(
        color: themeProvider.isDarkMode ? light(context) : dark(context),
      ),
      backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
      content: Column(
        children: ['Mężczyzna', 'Kobieta', 'Inna'].map((gender) => 
          RadioListTile<String>(
            title: Text(
              gender,
              style: TextStyle(
                color: themeProvider.isDarkMode ? lightGrey(context) : dark(context),
              ),
            ),
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

  void _editEmail(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final TextEditingController emailController = TextEditingController(text: controller.email.value);
    String? errorText;

    Get.defaultDialog(
      title: 'Edytuj e-mail',
      titleStyle: TextStyle(
        color: themeProvider.isDarkMode ? light(context) : dark(context),
      ),
      backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
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
                  fillColor: themeProvider.isDarkMode ? dark(context) : light(context),
                  filled: true,
                ),
                style: TextStyle(
                  color: themeProvider.isDarkMode ? light(context) : dark(context),
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

  void _editPhone(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final TextEditingController phoneController = TextEditingController(text: controller.phone.value);
    String? errorText;

    Get.defaultDialog(
      title: 'Edytuj numer telefonu',
      titleStyle: TextStyle(
        color: themeProvider.isDarkMode ? light(context) : dark(context),
      ),
      backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
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
                  fillColor: themeProvider.isDarkMode ? dark(context) : light(context),
                  filled: true,
                ),
                style: TextStyle(
                  color: themeProvider.isDarkMode ? light(context) : dark(context),
                ),
              ),
              if (errorText != null) Text(errorText!, style: const TextStyle(color: Colors.red)),
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
