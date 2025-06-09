import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../models/api_response_model.dart';

class ApiService {
  static Future<ApiResponseModel?> uploadAudio({
    required File audioFile,
    required String mode,
  }) async {
    final uri = Uri.parse("https://appnest.pro/audio/api/upload"); // رابط API الصحيح هنا

    final request = http.MultipartRequest('POST', uri)
      ..fields['mode'] = mode
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        audioFile.path,
        contentType: MediaType('audio', 'aac'),
      ));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = jsonDecode(respStr);
        return ApiResponseModel.fromJson(data);
      } else {
        print("❌ Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("⚠️ Exception: $e");
      return null;
    }
  }

  static Future<ApiResponseModel?> sendAudio({
    required File audioFile,
    required String type,
  }) async {
    return await uploadAudio(audioFile: audioFile, mode: type);
  }
}
