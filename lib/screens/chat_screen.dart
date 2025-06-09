import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../core/constants/colors.dart';

class SimpleChatScreen extends StatefulWidget {
  const SimpleChatScreen({super.key});

  @override
  State<SimpleChatScreen> createState() => _SimpleChatScreenState();
}

class _SimpleChatScreenState extends State<SimpleChatScreen> {
  final record = AudioRecorder();
  bool isRecording = false;

  late stt.SpeechToText _speech;
  String _spokenText = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> toggleRecording() async {
    if (await record.hasPermission()) {
      if (!isRecording) {
        final fileName = '${const Uuid().v4()}.m4a';
        print('🎤 بدء التسجيل: $fileName');
        await record.start(const RecordConfig(), path: '');
      } else {
        final path = await record.stop();
        print('🛑 تم إيقاف التسجيل. تم حفظه في: $path');
      }

      setState(() {
        isRecording = !isRecording;
      });
    } else {
      print('❌ مفيش صلاحيات للتسجيل!');
    }
  }

  Future<void> convertSpeechToText() async {
    bool available = await _speech.initialize();

    if (available) {
      await _speech.listen(
        onResult: (result) {
          setState(() {
            _spokenText = result.recognizedWords;
          });
          print("📄 النص: $_spokenText");
        },
      );

      Future.delayed(const Duration(seconds: 5), () async {
        await _speech.stop();
      });
    } else {
      print('❌ Speech recognition unavailable');
    }
  }

  List<String> getSignImages(String text) {
    final words = text.toLowerCase().split(' ');
    return words.map((word) => 'assets/signs/$word.png').toList();
  }

  void showSignsDialog(BuildContext context, List<String> images) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("لغة الإشارة"),
        content: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: images.map((img) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(img, height: 100),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
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
          )),
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
          )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'GloSign Chat',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: toggleRecording,
                  icon: Icon(isRecording ? Icons.stop : Icons.mic),
                  label: Text(isRecording ? 'إيقاف التسجيل' : 'تسجيل الصوت'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: convertSpeechToText,
                  icon: const Icon(Icons.text_fields),
                  label: const Text("تحويل إلى نص"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    final images = getSignImages(_spokenText);
                    showSignsDialog(context, images);
                  },
                  icon: const Icon(Icons.sign_language),
                  label: const Text("تحويل إلى لغة إشارة"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.white ,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                if (_spokenText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "📝 النص المكتشف:\n$_spokenText",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
