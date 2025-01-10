import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:enkridekrib_app/contents/decrypt/result_decrypt.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DecryptProcess extends StatefulWidget {
  const DecryptProcess({super.key});

  static const routeName = 'decrypt';

  @override
  State<DecryptProcess> createState() => __DecryptProcessState();
}

class __DecryptProcessState extends State<DecryptProcess> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _selectedImage;
  String? selectedValueCS;
  String? selectedValueIF;
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
          'Decrypt your image here',
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
                      if (selectedValueCS == null ||
                          selectedValueCS!.isEmpty ||
                          selectedValueIF == null ||
                          selectedValueIF!.isEmpty ||
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
                            builder: (context) => ResultDecrypt(
                              caseStrategy: selectedValueCS,
                              ignoreForeign: selectedValueIF,
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
                      'Decrypt!',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
