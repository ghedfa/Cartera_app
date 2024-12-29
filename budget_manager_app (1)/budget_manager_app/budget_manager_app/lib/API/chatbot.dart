import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../models/chat_message.dart';
import '../widgets/typing_indicator.dart';
import '/notifications.dart';

const apiKey = 'AIzaSyAcCgC8nhq52Yg4js_cN3Co5eE7blp8QuQ';

class GeminiChatScreen extends StatefulWidget {
  const GeminiChatScreen({super.key});

  @override
  _GeminiChatScreenState createState() => _GeminiChatScreenState();
}

class _GeminiChatScreenState extends State<GeminiChatScreen> {
  final TextEditingController _promptController = TextEditingController();
  late final ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    Gemini.init(apiKey: apiKey, enableDebugging: true);
    _chatBloc = ChatBloc(gemini: Gemini.instance);
  }

  @override
  void dispose() {
    _promptController.dispose();
    _chatBloc.close();
    super.dispose();
  }

  void _sendMessage() {
    if (_promptController.text.trim().isEmpty) return;
    _chatBloc.add(SendMessageEvent(_promptController.text));
    _promptController.clear();
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Row(
      mainAxisAlignment:
          message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!message.isUser) ...[
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF3A72E8),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              IconData(0xe0ab, fontFamily: 'MaterialIcons'),
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: message.isUser ? const Color(0xFF3A72E8) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: message.isUser
                    ? const Radius.circular(16)
                    : const Radius.circular(4),
                bottomRight: message.isUser
                    ? const Radius.circular(4)
                    : const Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
        if (message.isUser) ...[
          Container(
            margin: const EdgeInsets.only(left: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF3A72E8),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: const BoxDecoration(
            color: Color(0xFF3A72E8),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(
            IconData(0xe0ab, fontFamily: 'MaterialIcons'),
            color: Colors.white,
            size: 20,
          ),
        ),
        TypingIndicator(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _chatBloc,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              top: MediaQuery.of(context).size.height * 0.2,
              child: Container(
                color: const Color(0x0052c0cc),
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatInitial) {
                      return const Center(child: Text('Start a conversation!'));
                    }

                    if (state is ChatError) {
                      return Center(child: Text(state.error));
                    }

                    final messages = state is ChatLoaded
                        ? state.messages
                        : state is ChatLoading
                            ? state.messages
                            : [];
                    final isTyping = state is ChatLoading;

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            itemCount: messages.length + (isTyping ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == messages.length && isTyping) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: _buildTypingIndicator(),
                                );
                              }

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: _buildMessageBubble(messages[index]),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            // Wavy Blue Area
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.27,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF5A92F5),
                      Color(0xFF3A72E8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Expanded(
                        child: Text(
                          'AI Assistant',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationsPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Input Field
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _promptController,
                        decoration: InputDecoration(
                          hintText: 'Message AI Assistant...',
                          filled: true,
                          fillColor: const Color(0xFFF2F3F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    BlocBuilder<ChatBloc, ChatState>(
                      builder: (context, state) {
                        return FloatingActionButton(
                          backgroundColor: const Color(0xFF3A72E8),
                          onPressed: state is ChatLoading ? null : _sendMessage,
                          child: state is ChatLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.send, color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
