import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';


import '../core/constants/colors.dart';

class RecordedChatPage extends StatefulWidget {
  final String initialMessage;
  final bool isSignLanguage;
  final bool isGestureMessage; // أضفنا هذا المتغير

  const RecordedChatPage({
    Key? key,
    required this.initialMessage,
    required this.isSignLanguage,
    this.isGestureMessage = false, // القيمة الافتراضية false
  }) : super(key: key);

  @override
  State<RecordedChatPage> createState() => _RecordedChatPageState();
}

class _RecordedChatPageState extends State<RecordedChatPage> {
  List<Map<String, dynamic>> chatMessages = [];
  bool isLoading = false;

  late FlutterSoundRecorder _recorder;
  bool _isRecording = false;
  String? _recordedFilePath;

  bool _sendAsVideo = false;

  bool _isGestureRecording = false;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initRecorder();
    _addInitialMessage();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
  }

  void _addInitialMessage() {
    if (widget.initialMessage.isNotEmpty) {
      if (widget.isSignLanguage) {
        if (widget.isGestureMessage) {
          chatMessages.add({
            'message': widget.initialMessage,
            'fromUser': false,  // هنا نضع false للإيماءة
            'isSign': true,
            'isVideo': false,
          });
        } else {
          chatMessages.add({
            'message': "Watch Sign Language Video",
            'fromUser': true,   // هنا true لأن صوت (أو فيديو)
            'isSign': false,
            'isVideo': true,
            'videoUrl': "https://example.com/sign_language_video.mp4",
          });
        }
      } else {
        chatMessages.add({
          'message': widget.initialMessage,
          'fromUser': true,   // صوت عادي = true
          'isSign': false,
          'isVideo': false,
        });
      }
    }
  }


  Future<void> _startRecording() async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/recorded_voice.aac';
    await _recorder.startRecorder(toFile: filePath);
    setState(() {
      _isRecording = true;
      _recordedFilePath = filePath;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() => _isRecording = false);

    const convertedText = "Hello, this is the voice message converted to text.";

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        bool sendAsVideoInDialog = false;

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Voice Transcription"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(convertedText),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text("Send as Video"),
                      Switch(
                        value: sendAsVideoInDialog,
                        onChanged: (val) => setStateDialog(() => sendAsVideoInDialog = val),
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
                  child: const Text("Record Again"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _sendAsVideo = sendAsVideoInDialog;
                      if (_sendAsVideo) {
                        chatMessages.add({
                          'message': "Watch Sign Language Video",
                          'fromUser': true,
                          'isSign': false,
                          'isVideo': true,
                          'videoUrl': "https://example.com/sign_language_video.mp4",
                        });
                      } else {
                        chatMessages.add({
                          'message': convertedText,
                          'fromUser': true,
                          'isSign': false,
                          'isVideo': false,
                        });
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("Continue"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _toggleGestureRecording() async {
    if (_isGestureRecording) {
      // Stop recording
      setState(() {
        _isGestureRecording = false;
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      chatMessages.add({
        'message': "This is a gesture message interpreted as text.",
        'fromUser': false,
        'isSign': true,
        'isVideo': false,
      });

      setState(() => isLoading = false);
    } else {
      // Start gesture recording
      setState(() => _isGestureRecording = true);
    }
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    final isUser = msg['fromUser'] as bool;
    final content = msg['message'] as String;
    final isSign = msg['isSign'] as bool;
    final isVideo = msg['isVideo'] as bool;
    final videoUrl = msg['videoUrl'] as String?;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primary.withOpacity(0.8) : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: isVideo
            ? GestureDetector(
          onTap: () {
            if (videoUrl != null) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Sign Language Video"),
                  content: Text("Open video: $videoUrl"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              );
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.videocam, color: isUser ? Colors.white : Colors.black),
              const SizedBox(width: 8),
              Text(
                content,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: isUser ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        )
            : isSign
            ? Text('🤟 Gesture: $content', style: TextStyle(color: isUser ? Colors.white : Colors.black))
            : Text(content, style: TextStyle(color: isUser ? Colors.white : Colors.black)),
      ),
    );
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
        title: const Text('Chat'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: chatMessages.isEmpty
                ? const Center(child: Text('No messages yet.'))
                : ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) => _buildMessageBubble(chatMessages[index]),
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: CircularProgressIndicator(),
            ),
          if (!isLoading)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                    label: Text(_isRecording ? "Stop & Send" : "Record Voice"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    onPressed: _isRecording ? _stopRecording : _startRecording,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(_isGestureRecording ? Icons.stop : Icons.back_hand),
                    label: Text(_isGestureRecording ? "Stop Gesture" : "Record Gesture"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isGestureRecording ? Colors.red : Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    onPressed: _toggleGestureRecording,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}