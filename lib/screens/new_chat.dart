import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled1/screens/recorded_chat_screen.dart';

import '../core/constants/colors.dart';


class NewChatPage extends StatefulWidget {
  const NewChatPage({Key? key}) : super(key: key);

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _recordedFilePath;
  bool _isLoadingGesture = false;
  bool _isRecordingGesture = false;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
  }

  Future<void> _startRecording() async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/recorded_audio.aac';
    await _recorder.startRecorder(toFile: filePath);
    setState(() {
      _isRecording = true;
      _recordedFilePath = filePath;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() => _isRecording = false);
    _handleRecordedAudio();
  }

  void _handleRecordedAudio() async {
    final transcribedText = 'Hello, this is the transcribed audio text.';

    bool sendAsSignLanguage = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Transcribed Text'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(transcribedText),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Convert to Sign Language'),
                      Switch(
                        value: sendAsSignLanguage,
                        onChanged: (val) => setStateDialog(() => sendAsSignLanguage = val),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _startRecording();
                  },
                  child: const Text('Record Again'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecordedChatPage(
                          initialMessage: transcribedText,
                          isSignLanguage: sendAsSignLanguage,
                          isGestureMessage: false,  // لأنها صوت
                        ),
                      ),
                    );

                  },
                  child: const Text('Continue'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _handleGestureRecording() async {
    if (!_isRecordingGesture) {
      // بدء التسجيل
      setState(() => _isRecordingGesture = true);
    } else {
      // إيقاف التسجيل وبدء المعالجة
      setState(() {
        _isRecordingGesture = false;
        _isLoadingGesture = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      const gestureText = "This is a gesture message interpreted as text.";

      setState(() => _isLoadingGesture = false);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RecordedChatPage(
            initialMessage: gestureText,
            isSignLanguage: true, // غالباً true لأنها إيماءة / لغة إشارة
            isGestureMessage: true,  // لأنها إيماءة
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('New Chat', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const Center(
            child: Text(
              'Start a new chat by recording audio or gesture.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isLoadingGesture)
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.white,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 12),
                        Text('Processing gesture...'),
                      ],
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                        label: Text(_isRecording ? 'Stop Voice' : 'Record Voice'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        ),
                        onPressed: _isRecording ? _stopRecording : _startRecording,
                      ),
                      ElevatedButton.icon(
                        icon: Icon(_isRecordingGesture ? Icons.stop : Icons.back_hand),
                        label: Text(_isRecordingGesture ? "Stop Gesture" : "Record Gesture"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isRecordingGesture ? Colors.red : Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        ),
                        onPressed: _isLoadingGesture ? null : _handleGestureRecording,
                      ),
                    ],
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