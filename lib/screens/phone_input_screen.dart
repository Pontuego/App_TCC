import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'otp_screen.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _raController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void _goToOtpScreen() {
    if (_nameController.text.isEmpty ||
        _raController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos e selecione uma foto")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpScreen(
          verificationId: 'test_verification_id',
          name: _nameController.text,
          ra: _raController.text,
          phone: _phoneController.text,
          imagePath: _image!.path,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: _raController,
              decoration: const InputDecoration(labelText: "RA"),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: "Telefone"),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: const Text("Tirar Foto"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text("Galeria"),
                ),
              ],
            ),
            if (_image != null) ...[
              const SizedBox(height: 10),
              Image.network(_image!.path, height: 150, width: 150),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _goToOtpScreen,
              child: const Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}
