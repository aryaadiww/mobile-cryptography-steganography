import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:enkridekrib_app/API/models/modes_dekrip.dart';
import 'package:http/http.dart' as http;

class ApiServiceDekrip {
  final String baseUrl = 'http://13.250.38.115:5000/api/decode/upload';

  // take all data with json
  Future<DekripResult> fetchDataDenkrip(Map<String, dynamic> parameters) async {
    try {
      // Create multipart request
      final request = http.MultipartRequest('POST', Uri.parse(baseUrl));

      // Add file if it exists
      if (parameters['image_url'] != null && parameters['image_url'] is File) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            (parameters['image_url'] as File).path,
          ),
        );
      }

      // Create JSON data excluding the image
      final Map<String, dynamic> jsonData = {
        'alphabet': parameters['alphabet'],
        'case_strategy': parameters['case_strategy'],
        'ignore_foreign': parameters['ignore_foreign'],
      };

      // Add the JSON data as a field
      request.fields['data'] = json.encode(jsonData);

      // Send the request
      final streamedResponse = await request.send().timeout(
            const Duration(seconds: 10),
          );

      // Get the response
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return DekripResult.fromJson(json.decode(response.body));
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
}
