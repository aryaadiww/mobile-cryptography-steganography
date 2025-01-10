import 'dart:io';

import 'package:enkridekrib_app/API/models/modes_dekrip.dart';
import 'package:enkridekrib_app/API/eksternal/request_dekrip_api.dart';
import 'package:flutter/material.dart';

class ResultDecrypt extends StatefulWidget {
  final String? caseStrategy;
  final String? ignoreForeign;
  final File? image;

  const ResultDecrypt(
      {super.key, required this.image, this.caseStrategy, this.ignoreForeign});

  @override
  State<ResultDecrypt> createState() => _ResultDecryptState();
}

class _ResultDecryptState extends State<ResultDecrypt> {
  final result = 'PPN 12% Moment';
  bool _isLoading = false;
  final ApiServiceDekrip _apiService = ApiServiceDekrip();
  DekripResult? _apiResponse;

  @override
  void initState() {
    super.initState();
    fetchResultEnkrip();
  }

  Future<void> fetchResultEnkrip() async {
    setState(() {
      _isLoading = true;
    });

    bool ignoredbool = widget.ignoreForeign?.toLowerCase() == 'true';

    final parameters = {
      "image_url": widget.image,
      "alphabet": "`,.pyfgcrl/=\\aoeuidhtns-;qjkxbmwvz",
      "case_strategy": widget.caseStrategy,
      "ignore_foreign": ignoredbool
    };

    try {
      final response = await _apiService.fetchDataDenkrip(parameters);
      setState(() {
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF8B83FA),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'decrypt');
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
          'decrypt Succesful!',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            // Hasilnya
            const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Encrypted Message :'),
            ),
            const SizedBox(height: 10),
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
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : _apiResponse != null
                      ? Text(
                          _apiResponse!.encryptedMessage,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        )
                      : const Text(
                          'No data available',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
            ),
            const SizedBox(height: 30),
            // Hasilnya
            const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Shift Key :'),
            ),
            const SizedBox(height: 10),
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
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : _apiResponse != null
                      ? Text(
                          _apiResponse!.shiftKey.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        )
                      : const Text(
                          'No data available',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
            ),
            const SizedBox(height: 30),
            // Hasilnya
            const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Decrypted Message :'),
            ),
            const SizedBox(height: 10),
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
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : _apiResponse != null
                      ? Text(
                          _apiResponse!.decryptedMessage,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        )
                      : const Text(
                          'No data available',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
            ),
            const SizedBox(height: 50),
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
            const SizedBox(height: 20),
            SizedBox(
              width: width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'decrypt');
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color(0xFF6860D7),
                  ),
                ),
                child: const Text(
                  'decrypt Another?',
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
      )),
    );
  }
}
