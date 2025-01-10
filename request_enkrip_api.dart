import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:enkridekrib_app/API/models/model_enkrip.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ApiServiceEnkrip {
  final String baseUrl = 'http://13.250.38.115:5000/api/encode/upload';
  File? _downloadedImage;

  File? get downloadedImage => _downloadedImage;

  // take all data with json
  Future<EnkripResult> fetchDataEnkrip(Map<String, dynamic> parameters) async {
    try {
      // Create multipart request
      final request = http.MultipartRequest('POST', Uri.parse(baseUrl));

      // Add file
      if (parameters['image_url'] != null && parameters['image_url'] is File) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            (parameters['image_url'] as File).path,
          ),
        );
      }

      // Create JSON data
      final Map<String, dynamic> jsonData = {
        'message': parameters['message'],
        'alphabet': parameters['alphabet'],
        'key': parameters['key'],
        'case_strategy': parameters['case_strategy'],
        'ignore_foreign': parameters['ignore_foreign'],
      };

      // Add the JSON
      request.fields['data'] = json.encode(jsonData);

      // Send request
      final streamedResponse = await request.send().timeout(
            const Duration(seconds: 10),
          );

      // Get response
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return EnkripResult.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Failed to load data. Status code: ${response.statusCode}. Response: ${response.body}',
        );
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Request timed out. Please try again.');
      }
      throw Exception('Error: $e');
    }
  }

  // for download and share image
  Future<File> downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final contentLength = response.headers['content-length'];
        final originalSize =
            contentLength != null ? int.parse(contentLength) : null;

        final tempDir = await getTemporaryDirectory();
        final tempImageFile =
            File('${tempDir.path}/downloaded_image${path.extension(imageUrl)}');

        // whrite bytes
        await tempImageFile.writeAsBytes(response.bodyBytes,
            flush: true, mode: FileMode.writeOnly);

        // Verifications Size
        final savedFileSize = await tempImageFile.length();

        // Verifications size
        if (originalSize != null && savedFileSize != originalSize) {}

        return tempImageFile;
      } else {
        throw Exception('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading image: $e');
    }
  }
}
