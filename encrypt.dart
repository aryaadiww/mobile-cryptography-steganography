import 'dart:io';

import 'package:enkridekrib_app/contents/encrypt/result_encrypt.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EncryptProcess extends StatefulWidget {
  const EncryptProcess({super.key});

  static const routeName = 'encrypt';

  @override
  State<EncryptProcess> createState() => _EncryptProcessState();
}

class _EncryptProcessState extends State<EncryptProcess> {
  String? selectedValueCS;
  String? selectedValueIF;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controllerkunci = TextEditingController();
  final TextEditingController controllerplain = TextEditingController();
  File? _selectedImage;
  String? selectedImageAPI;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF8B83FA),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        backgroundColor: const Color(0xFF19F5B7),
        title: const Text(
          'Encrypt Your Words Here',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // input user for key
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  width: width,
                  height: 67,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB4AEFF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controllerkunci,
                    decoration: const InputDecoration(
                      label: Text(
                        'Insert your key here',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Keyboard Type
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.centerLeft,
                  width: width,
                  height: 67,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Dvork',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),

                // choose case strategy
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  width: width,
                  height: 67,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB4AEFF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: DropDownTextField(
                    listSpace: 20,
                    textFieldDecoration: const InputDecoration(
                      label: Text(
                        'Choose Case Strategy',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    listPadding: ListPadding(top: 10),
                    enableSearch: false,
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownList: const [
                      DropDownValueModel(name: 'maintain', value: "maintain"),
                      DropDownValueModel(name: 'ignore', value: "ignore"),
                      DropDownValueModel(name: 'strict', value: "strict"),
                    ],
                    listTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    dropDownItemCount: 3,
                    onChanged: (val) {
                      setState(() {
                        if (val is DropDownValueModel) {
                          selectedValueCS = val.value;
                        } else {
                          selectedValueCS = null;
                        }
                      });
                    },
                  ),
                ),

                // choose ignore foreign
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  width: width,
                  height: 67,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB4AEFF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: DropDownTextField(
                    listSpace: 20,
                    textFieldDecoration: const InputDecoration(
                      label: Text(
                        'Choose Ignore Foreign',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    listPadding: ListPadding(top: 10),
                    enableSearch: false,
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownList: const [
                      DropDownValueModel(name: 'true', value: "true"),
                      DropDownValueModel(name: 'false', value: "false"),
                    ],
                    listTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    dropDownItemCount: 2,
                    onChanged: (val) {
                      setState(() {
                        if (val is DropDownValueModel) {
                          selectedValueIF = val.value;
                        } else {
                          selectedValueIF = null;
                        }
                      });
                    },
                  ),
                ),

                // input user plaintext
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  width: width,
                  height: 67,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB4AEFF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: TextFormField(
                    controller: controllerplain,
                    decoration: const InputDecoration(
                      label: Text(
                        'Insert your secret plaintext here',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Chooser User Image
                Row(
                  children: [
                    const Text(
                      'Choose your image',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        try {
                          final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery,
                            requestFullMetadata: true,
                          );

                          if (image != null) {
                            setState(() {
                              _selectedImage = File(image.path);
                              selectedImageAPI = basename(image.path);
                            });
                          }
                        } catch (e) {
                          // Handle any errors silently or show a snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to pick image'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0XFFD9D9D9),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.insert_photo_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                // image field
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 200, // Set appropriate height
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Center(
                          child: Text(
                            'No image selected',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                ),
                const SizedBox(height: 30),
                // button submit check
                SizedBox(
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controllerkunci.text.isEmpty ||
                          (selectedValueCS ?? '').isEmpty ||
                          (selectedValueIF ?? '').isEmpty ||
                          controllerplain.text.isEmpty ||
                          _selectedImage == null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Peringatan'),
                            content: const Text(
                                'Semua data harus diisi sebelum melanjutkan.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Menutup popup
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultEncrypt(
                              kunci: controllerkunci.text,
                              caseStrategy: selectedValueCS ?? '',
                              ignoreForeign: selectedValueIF ?? '',
                              plaintext: controllerplain.text,
                              image: _selectedImage,
                            ),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFF6860D7),
                      ),
                    ),
                    child: const Text(
                      'Encrypt!',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
