class ChatbotTemplates {
  // CHAT SCREEN UI WITH BLOC
  static String generateChatScreen(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/features/chatbot/bloc/chatbot_bloc.dart';
import 'package:$projectName/features/chatbot/bloc/chatbot_event.dart';
import 'package:$projectName/features/chatbot/bloc/chatbot_state.dart';
import 'package:$projectName/features/chatbot/models/chat_message_model.dart';
import 'package:$projectName/features/chatbot/services/chatbot_service.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(BuildContext context) {
    if (_messageController.text.trim().isEmpty) return;

    final message = _messageController.text.trim();
    _messageController.clear();

    context.read<ChatbotBloc>().add(SendMessageEvent(message));
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => ChatbotBloc(
        chatbotService: ChatbotService(),
      )..add(InitializeChatEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.smart_toy_outlined,
                  color: theme.colorScheme.onPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Assistant',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.greenAccent.withOpacity(0.5),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Online',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: theme.colorScheme.surface,
        ),
        body: BlocConsumer<ChatbotBloc, ChatbotState>(
          listener: (context, state) {
            if (state is ChatbotMessageSent || state is ChatbotResponseReceived) {
              _scrollToBottom();
            }
            if (state is ChatbotError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: theme.colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: state.messages.isEmpty
                      ? _buildEmptyState(theme)
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            final message = state.messages[index];
                            return _buildMessageBubble(
                              context,
                              message,
                              theme,
                            );
                          },
                        ),
                ),
                if (state is ChatbotLoading) _buildTypingIndicator(theme),
                _buildMessageInput(context, theme, state is ChatbotLoading),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.1),
                  theme.colorScheme.primary.withOpacity(0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              size: 60,
              color: theme.colorScheme.primary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Start a conversation',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Ask me anything! I\\'m here to help you with information, ideas, and solutions.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildSuggestionChip('Tell me a joke', theme),
              _buildSuggestionChip('Explain quantum physics', theme),
              _buildSuggestionChip('Creative writing tips', theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text, ThemeData theme) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        _messageController.text = text;
      },
      backgroundColor: theme.colorScheme.surfaceVariant,
      labelStyle: TextStyle(
        color: theme.colorScheme.onSurfaceVariant,
        fontSize: 12,
      ),
      side: BorderSide.none,
    );
  }

  Widget _buildMessageBubble(
    BuildContext context,
    ChatMessage message,
    ThemeData theme,
  ) {
    final isUser = message.isUser;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.smart_toy_outlined,
                size: 20,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                gradient: isUser
                    ? LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withOpacity(0.8),
                        ],
                      )
                    : null,
                color: isUser ? null : theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isUser
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurfaceVariant,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                size: 20,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              Icons.smart_toy_outlined,
              size: 20,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(theme, 0),
                const SizedBox(width: 4),
                _buildDot(theme, 1),
                const SizedBox(width: 4),
                _buildDot(theme, 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(ThemeData theme, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        final delay = index * 0.2;
        final animValue = (value - delay).clamp(0.0, 1.0);
        final scale = 0.5 + (animValue * 0.5);
        
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
      onEnd: () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  Widget _buildMessageInput(
    BuildContext context,
    ThemeData theme,
    bool isLoading,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceVariant,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  prefixIcon: Icon(
                    Icons.edit_outlined,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(context),
                enabled: !isLoading,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.send_rounded,
                  color: theme.colorScheme.onPrimary,
                ),
                onPressed: isLoading ? null : () => _sendMessage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';
  }

  // CHATBOT SERVICE
  static String generateChatbotService(String projectName) {
    return '''
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:$projectName/features/chatbot/models/chat_message_model.dart';
import 'package:$projectName/core/constants/app_constants.dart';

class ChatbotService {
  final Dio _dio = Dio();

  Future<String> sendMessage(List<ChatMessageModel> messages) async {
    try {
      final response = await _dio.post(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\${AppConstants.geminiApiKey}",
        data: {
          "contents": messages.map((e) => e.toMap()).toList(),
          "generationConfig": {
            "temperature": 0.9,
            "topK": 1,
            "topP": 1,
            "maxOutputTokens": 2048,
            "stopSequences": []
          },
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_HARASSMENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_HATE_SPEECH",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            }
          ]
        },
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      }
      
      throw Exception('Failed to get response from Gemini API');
    } catch (e) {
      log('Chatbot Service Error: \$e');
      rethrow;
    }
  }
}
''';
  }

  // CHAT MESSAGE MODEL
  static String generateChatMessageModel() {
    return '''
class ChatMessageModel {
  final String role;
  final List<ChatPartModel> parts;

  ChatMessageModel({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'parts': parts.map((part) => part.toMap()).toList(),
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      role: map['role'] ?? '',
      parts: List<ChatPartModel>.from(
        (map['parts'] as List).map((x) => ChatPartModel.fromMap(x)),
      ),
    );
  }
}

class ChatPartModel {
  final String text;

  ChatPartModel({required this.text});

  Map<String, dynamic> toMap() {
    return {'text': text};
  }

  factory ChatPartModel.fromMap(Map<String, dynamic> map) {
    return ChatPartModel(text: map['text'] ?? '');
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  ChatMessageModel toGeminiModel() {
    return ChatMessageModel(
      role: isUser ? 'user' : 'model',
      parts: [ChatPartModel(text: text)],
    );
  }
}
''';
  }

  // CHATBOT BLOC
  static String generateChatbotBloc() {
    return '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'chatbot_event.dart';
import 'chatbot_state.dart';
import '../services/chatbot_service.dart';
import '../models/chat_message_model.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  final ChatbotService chatbotService;

  ChatbotBloc({required this.chatbotService}) : super(const ChatbotInitial()) {
    on<InitializeChatEvent>(_onInitializeChat);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onInitializeChat(
    InitializeChatEvent event,
    Emitter<ChatbotState> emit,
  ) async {
    final welcomeMessage = ChatMessage(
      text: 'Hello! I\\'m your AI assistant powered by Google Gemini. How can I help you today?',
      isUser: false,
    );
    
    emit(ChatbotInitial(messages: [welcomeMessage]));
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatbotState> emit,
  ) async {
    final currentMessages = List<ChatMessage>.from(state.messages);
    
    // Add user message
    final userMessage = ChatMessage(
      text: event.message,
      isUser: true,
    );
    currentMessages.add(userMessage);
    
    emit(ChatbotMessageSent(messages: currentMessages));
    emit(ChatbotLoading(messages: currentMessages));

    try {
      // Convert to Gemini format
      final geminiMessages = currentMessages
          .map((msg) => msg.toGeminiModel())
          .toList();

      // Get response from service
      final response = await chatbotService.sendMessage(geminiMessages);

      // Add AI response
      final aiMessage = ChatMessage(
        text: response,
        isUser: false,
      );
      currentMessages.add(aiMessage);

      emit(ChatbotResponseReceived(messages: currentMessages));
    } catch (e) {
      emit(ChatbotError(
        message: 'Sorry, I encountered an error. Please try again.',
        messages: currentMessages,
      ));
    }
  }
}
''';
  }

  // CHATBOT EVENT
  static String generateChatbotEvent() {
    return '''
import 'package:equatable/equatable.dart';

abstract class ChatbotEvent extends Equatable {
  const ChatbotEvent();

  @override
  List<Object?> get props => [];
}

class InitializeChatEvent extends ChatbotEvent {}

class SendMessageEvent extends ChatbotEvent {
  final String message;

  const SendMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}
''';
  }

  // CHATBOT STATE
  static String generateChatbotState() {
    return '''
import 'package:equatable/equatable.dart';
import '../models/chat_message_model.dart';

abstract class ChatbotState extends Equatable {
  final List<ChatMessage> messages;

  const ChatbotState({this.messages = const []});

  @override
  List<Object?> get props => [messages];
}

class ChatbotInitial extends ChatbotState {
  const ChatbotInitial({super.messages});
}

class ChatbotLoading extends ChatbotState {
  const ChatbotLoading({required super.messages});
}

class ChatbotMessageSent extends ChatbotState {
  const ChatbotMessageSent({required super.messages});
}

class ChatbotResponseReceived extends ChatbotState {
  const ChatbotResponseReceived({required super.messages});
}

class ChatbotError extends ChatbotState {
  final String message;

  const ChatbotError({
    required this.message,
    required super.messages,
  });

  @override
  List<Object?> get props => [message, messages];
}
''';
  }

  // APP CONSTANTS
  static String generateAppConstants() {
    return '''
class AppConstants {
  // Gemini AI API Key
  // Get your API key from: https://makersuite.google.com/app/apikey
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';
  
  // TODO: Add your Gemini API key above
  // Steps to get API key:
  // 1. Go to https://makersuite.google.com/app/apikey
  // 2. Sign in with your Google account
  // 3. Click "Create API Key"
  // 4. Copy the key and paste it above
  
  // Other app constants
  static const String appName = 'My App';
  static const String appVersion = '1.0.0';
}
''';
  }

  // .ENV FILE
  static String generateEnvFile() {
    return '''
# Environment Variables
# Add your sensitive keys here
# Never commit this file to version control

# Gemini AI API Key
# Get your key from: https://makersuite.google.com/app/apikey
GEMINI_API_KEY=your_api_key_here

# Firebase Configuration (if using Firebase)
# FIREBASE_API_KEY=your_firebase_key_here

# Other API Keys
# Add other API keys as needed
''';
  }

  // .ENV.EXAMPLE FILE
  static String generateEnvExampleFile() {
    return '''
# Environment Variables Template
# Copy this file to .env and add your actual keys

# Gemini AI API Key
GEMINI_API_KEY=your_gemini_api_key_here

# Firebase Configuration
# FIREBASE_API_KEY=your_firebase_key_here
''';
  }

  // .GITIGNORE ADDITION
  static String generateGitignoreAddition() {
    return '''

# Environment files
.env
.env.local
.env.production

# API Keys - Sensitive files
**/app_constants.dart
''';
  }
}