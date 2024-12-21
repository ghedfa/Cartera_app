import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '../models/chat_message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Gemini gemini;
  final List<ChatMessage> _messages = [];

  ChatBloc({required this.gemini}) : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<ClearMessagesEvent>(_onClearMessages);
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // Add user message
      _messages.add(ChatMessage(
        text: event.message,
        isUser: true,
      ));
      
      // Emit loading state with typing indicator
      emit(ChatLoading(messages: List.from(_messages)));

      // Get AI response
      final response = await gemini.prompt(parts: [
        Part.text(event.message),
      ]);

      // Add AI response
      _messages.add(ChatMessage(
        text: response?.output ?? 'No response',
        isUser: false,
      ));
      
      // Emit loaded state without typing indicator
      emit(ChatLoaded(messages: List.from(_messages)));
    } catch (e) {
      emit(ChatError(
        error: e.toString(),
        messages: List.from(_messages),
      ));
    }
  }

  void _onClearMessages(
    ClearMessagesEvent event,
    Emitter<ChatState> emit,
  ) {
    _messages.clear();
    emit(ChatLoaded(messages: List.from(_messages)));
  }
}
