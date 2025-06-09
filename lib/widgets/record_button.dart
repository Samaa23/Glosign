import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class RecordButtons extends StatefulWidget {
  final Function(File file) onRecordingComplete;

  const RecordButtons({super.key, required this.onRecordingComplete});

  @override
  State<RecordButtons> createState() => _RecordButtonsState();
}

class _RecordButtonsState extends State<RecordButtons> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool isRecording = false;
  String? filePath;

  // الحالة الجديدة: هل نعرض خيارات بعد التسجيل؟
  bool showOptions = false;
  File? recordedFile;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
  }

  Future<void> _startRecording() async {
    final dir = await getTemporaryDirectory();
    filePath = '${dir.path}/recorded.aac';
    await _recorder.startRecorder(toFile: filePath);
    setState(() {
      isRecording = true;
      showOptions = false; // بداية التسجيل نخبّي الخيارات
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      isRecording = false;
      showOptions = true; // بعد التسجيل نظهر الخيارات
    });

    if (filePath != null) {
      recordedFile = File(filePath!);
      widget.onRecordingComplete(recordedFile!);
    }
  }

  void _convertToText(File file) {
    // هنا تضيف الكود اللي يرسل الملف لتحويل الصوت لنص
    print("تحويل الملف إلى نص");
    // مثلاً: استدعاء API ثم تنقل المستخدم أو تعرض النتيجة
  }

  void _convertToSignLanguage(File file) {
    // هنا تضيف الكود اللي يرسل الملف لتحويل الصوت إلى لغة إشارة
    print("تحويل الملف إلى لغة إشارة");
    // مثلاً: استدعاء API ثم تنقل المستخدم أو تعرض النتيجة
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (showOptions) {
      // نعرض الخيارات بعد التسجيل
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("تم التسجيل، ماذا تريد أن تفعل؟"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (recordedFile != null) {
                _convertToText(recordedFile!);
              }
            },
            child: const Text("تحويل إلى نص"),
          ),
          ElevatedButton(
            onPressed: () {
              if (recordedFile != null) {
                _convertToSignLanguage(recordedFile!);
              }
            },
            child: const Text("تحويل إلى لغة إشارة"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showOptions = false;
                recordedFile = null;
              });
            },
            child: const Text("إعادة تسجيل"),
          ),
        ],
      );
    }

    // عرض زر التسجيل / الإيقاف في الوضع الطبيعي
    return ElevatedButton.icon(
      icon: Icon(isRecording ? Icons.stop : Icons.mic),
      label: Text(isRecording ? "إيقاف" : "تسجيل"),
      onPressed: isRecording ? _stopRecording : _startRecording,
    );
  }
}
