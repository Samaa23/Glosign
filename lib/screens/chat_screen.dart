import 'dart:io';
import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../models/api_response_model.dart';
import '../services/api_service.dart';
import '../widgets/record_button.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? textResult;
  String? signImageUrl;
  File? recordedFile;
  bool isLoading = false;

  void _handleRecordingComplete(File file) {
    setState(() {
      recordedFile = file;
      textResult = null;
      signImageUrl = null;
    });
  }

  Future<void> _handleConvert(String type) async {
    if (recordedFile == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService.sendAudio(
        audioFile: recordedFile!,
        type: type,
      );

      if (response == null) {
        _showError("فشل في الاتصال بالخادم");
      } else {
        setState(() {
          textResult = response.resultText;
          signImageUrl = response.signUrl;
        });
      }
    } catch (e) {
      _showError("حدث خطأ أثناء المعالجة");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _resetRecording() {
    setState(() {
      recordedFile = null;
      textResult = null;
      signImageUrl = null;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // الدوائر على جهة اليسار
          Positioned(
            top: -60,
            left: -10,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryOpacity50,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: -60,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryOpacity50,
              ),
            ),
          ),

          // محتوى الشاشة الرئيسي
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // زر التسجيل في منتصف الشاشة بالضبط
                    RecordButtons(
                      onRecordingComplete: _handleRecordingComplete,
                    ),

                    const SizedBox(height: 30),

                    if (recordedFile != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: isLoading ? null : () => _handleConvert("text"),
                            child: isLoading
                                ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                                : const Text("تحويل إلى نص"),
                          ),
                          ElevatedButton(
                            onPressed: isLoading ? null : () => _handleConvert("sign"),
                            child: isLoading
                                ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                                : const Text("تحويل إلى إشارة"),
                          ),
                          ElevatedButton(
                            onPressed: isLoading ? null : _resetRecording,
                            child: const Text("إعادة تسجيل"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 20),

                    if (textResult != null)
                      Text(
                        "📜 النص: $textResult",
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),

                    if (signImageUrl != null)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "🧏 لغة الإشارة:",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Image.network(
                            signImageUrl!,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.broken_image,
                              size: 100,
                              color: Colors.grey,
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const SizedBox(
                                height: 100,
                                child: Center(child: CircularProgressIndicator()),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),

          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black45,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
