import 'dart:io';

import 'package:enkridekrib_app/API/models/model_enkrip.dart';
import 'package:enkridekrib_app/API/eksternal/request_enkrip_api.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;

class ResultEncrypt extends StatefulWidget {
  final String kunci;
  final String? caseStrategy;
  final String? ignoreForeign;
  final String plaintext;
  final File? image;

  const ResultEncrypt(
      {super.key,
      required this.kunci,
      required this.plaintext,
      required this.image,
      this.caseStrategy,
      this.ignoreForeign});

  @override
  State<ResultEncrypt> createState() => _ResultEncryptState();
}

class _ResultEncryptState extends State<ResultEncrypt> {
  File? _selectedImage;
  bool _isLoading = true;
  final ApiServiceEnkrip _apiService = ApiServiceEnkrip();
  EnkripResult? _apiResponse;

  @override
  void initState() {
    super.initState();
    fetchResultEnkrip();
  }

  Future<void> fetchResultEnkrip() async {
    setState(() {
      _isLoading = true;
    });

    final parameters = {
      "image_url": widget.image,
      "message": widget.plaintext,
      "alphabet": "`,.pyfgcrl/=\\aoeuidhtns-;qjkxbmwvz",
      "key": int.parse(widget.kunci),
      "case_strategy": widget.caseStrategy,
      "ignore_foreign": widget.ignoreForeign
    };

    try {
      final response = await _apiService.fetchDataEnkrip(parameters);
      final responseimage = await _apiService.downloadImage(response.imageUrl);
      setState(() {
        _selectedImage = responseimage;
        _apiResponse = response;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _downloadImage() async {
    if (_selectedImage == null) return;
    try {
      final directory = Directory('/storage/emulated/0/Download');
      if (!directory.existsSync()) {
        directory.createSync();
      }

      final originalFile = _selectedImage!;

      // Gunakan mode copy binary untuk memastikan tidak ada kompresi
      final savedImage = await originalFile.copy(
          '${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}${path.extension(originalFile.path)}');

      final savedSize = await savedImage.length();

      if (mounted) {
        _showSnackBar(
            'Image saved to: ${savedImage.path}\nSize: $savedSize bytes');
      }
    } catch (e) {
      debugPrint('Error downloading image: $e');
      if (mounted) {
        _showSnackBar('Failed to download image');
      }
    }
  }

  Future<void> _shareImage() async {
    if (_selectedImage == null) return;

    try {
      await Share.shareXFiles(
        [XFile(_selectedImage!.path)],
        text: 'Sharing image',
      );
    } catch (e) {
      debugPrint('Error sharing image: $e');
      if (mounted) {
        _showSnackBar('Failed to share image');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF8B83FA),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'encrypt');
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
          'Encrypt Succesful!',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: RefreshIndicator(
        onRefresh: fetchResultEnkrip,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Enkripsi Text
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
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : _apiResponse != null // Tambahkan pengecekan null
                        ? Text(
                            _apiResponse!.encryptedMessage,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          )
                        : const Text(
                            // Tampilkan pesan default jika data null
                            'No data available',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
              ),
              const SizedBox(height: 20),
              // Download Image
              Row(
                children: [
                  const Text(
                    'Result',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: _downloadImage,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF6860D7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.file_download_outlined,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: _shareImage,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF6860D7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.share,
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
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _selectedImage != null
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
                    Navigator.pushNamed(context, 'home');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color(0xFF6860D7),
                    ),
                  ),
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'encrypt');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color(0xFF6860D7),
                    ),
                  ),
                  child: const Text(
                    'Encrypt Another Image?',
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
    );
  }
}
