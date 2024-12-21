import 'package:equatable/equatable.dart';
import '../models/chat_message.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {
  final List<ChatMessage> messages;

  const ChatLoading({
    required this.messages,
  });

  @override
  List<Object?> get props => [messages];
}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;

  const ChatLoaded({
    required this.messages,
  });

  @override
  List<Object?> get props => [messages];
}

class ChatError extends ChatState {
  final String error;
  final List<ChatMessage> messages;

  const ChatError({
    required this.error,
    required this.messages,
  });

  @override
  List<Object?> get props => [error, messages];
}
