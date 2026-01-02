class ChatAppScreens {
  // ============================================================
  // CHAT LIST SCREEN
  // ============================================================
  static String generateChatListScreen(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:$projectName/features/chat/models/chat_conversation_model.dart';
import 'package:$projectName/features/chat/models/chat_user_model.dart';
import 'package:$projectName/features/chat/services/chat_service.dart';
import 'package:$projectName/features/chat/services/encryption_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<ChatUser> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _chatService.updateUserStatus(UserStatus.online);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);
    final results = await _chatService.searchUsers(query);
    setState(() {
      _searchResults = results;
      _isSearching = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: UserSearchDelegate(_chatService),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _searchUsers('');
                        },
                      )
                    : null,
              ),
              onChanged: _searchUsers,
            ),
          ),
          Expanded(
            child: _isSearching
                ? _buildSearchResults()
                : StreamBuilder<List<ChatConversation>>(
                    stream: _chatService.streamConversations(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: \${snapshot.error}'));
                      }

                      final conversations = snapshot.data ?? [];

                      if (conversations.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 80,
                                color: theme.colorScheme.primary.withOpacity(0.3),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No conversations yet',
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Search for users to start chatting',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: conversations.length,
                        itemBuilder: (context, index) {
                          return _buildConversationTile(conversations[index]);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(child: Text('No users found'));
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final user = _searchResults[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
            child: user.photoUrl == null ? Text(user.name[0].toUpperCase()) : null,
          ),
          title: Text(user.name),
          subtitle: Text(user.email),
          trailing: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: user.status == UserStatus.online ? Colors.green : Colors.grey,
            ),
          ),
          onTap: () async {
            final chatId = await _chatService.getOrCreateConversation(user.id);
            if (context.mounted) {
              context.push('/chat/\$chatId', extra: user);
            }
          },
        );
      },
    );
  }

  Widget _buildConversationTile(ChatConversation conversation) {
    final otherUserId = conversation.participants
        .firstWhere((id) => id != _chatService.currentUserId);

    return StreamBuilder<ChatUser?>(
      stream: _chatService.streamUser(otherUserId),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) return const SizedBox.shrink();

        final unreadCount = conversation.getUnreadCount(_chatService.currentUserId);

        return ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                child: user.photoUrl == null ? Text(user.name[0].toUpperCase()) : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: user.status == UserStatus.online ? Colors.green : Colors.grey,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            user.name,
            style: TextStyle(
              fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          subtitle: Row(
            children: [
              if (user.isTyping && user.typingInChatId == conversation.id)
                const Text(
                  'typing...',
                  style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),
                )
              else
                Expanded(
                  child: Text(
                    conversation.lastMessage ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                timeago.format(conversation.lastMessageTime),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (unreadCount > 0) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unreadCount > 99 ? '99+' : unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          onTap: () {
            context.push('/chat/\${conversation.id}', extra: user);
          },
        );
      },
    );
  }
}

// User Search Delegate
class UserSearchDelegate extends SearchDelegate<ChatUser?> {
  final ChatService chatService;

  UserSearchDelegate(this.chatService);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return const Center(child: Text('Search for users'));
    }

    return FutureBuilder<List<ChatUser>>(
      future: chatService.searchUsers(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = snapshot.data ?? [];

        if (users.isEmpty) {
          return const Center(child: Text('No users found'));
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                child: user.photoUrl == null ? Text(user.name[0].toUpperCase()) : null,
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              onTap: () async {
                final chatId = await chatService.getOrCreateConversation(user.id);
                if (context.mounted) {
                  close(context, user);
                  context.push('/chat/\$chatId', extra: user);
                }
              },
            );
          },
        );
      },
    );
  }
}
''';
  }

  // ============================================================
  // CHAT SCREEN
  // ============================================================
  static String generateChatScreen(String projectName) {
    return '''
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:$projectName/features/chat/models/chat_message_model.dart';
import 'package:$projectName/features/chat/models/chat_user_model.dart';
import 'package:$projectName/features/chat/services/chat_service.dart';
import 'package:$projectName/features/chat/widgets/message_bubble.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  final String chatId;
  final ChatUser otherUser;

  const ChatScreen({
    Key? key,
    required this.chatId,
    required this.otherUser,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _typingTimer;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _chatService.markMessagesAsRead(widget.chatId);
    _messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    _scrollController.dispose();
    _typingTimer?.cancel();
    _chatService.updateTypingStatus(widget.chatId, false);
    super.dispose();
  }

  void _onTextChanged() {
    if (_messageController.text.isNotEmpty && !_isTyping) {
      _isTyping = true;
      _chatService.updateTypingStatus(widget.chatId, true);
    } else if (_messageController.text.isEmpty && _isTyping) {
      _isTyping = false;
      _chatService.updateTypingStatus(widget.chatId, false);
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (_isTyping) {
        _isTyping = false;
        _chatService.updateTypingStatus(widget.chatId, false);
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    _chatService.updateTypingStatus(widget.chatId, false);
    _isTyping = false;

    await _chatService.sendMessage(
      chatId: widget.chatId,
      text: text,
      receiverId: widget.otherUser.id,
    );

    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _deleteMessage(ChatMessage message) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Message'),
        content: const Text('Are you sure you want to delete this message?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _chatService.deleteMessage(widget.chatId, message.id);
    }
  }

  void _showMessageOptions(ChatMessage message) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy'),
              onTap: () {
                Clipboard.setData(ClipboardData(text: message.text));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Message copied')),
                );
              },
            ),
            if (message.senderId == _chatService.currentUserId)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _deleteMessage(message);
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: StreamBuilder<ChatUser?>(
          stream: _chatService.streamUser(widget.otherUser.id),
          builder: (context, snapshot) {
            final user = snapshot.data ?? widget.otherUser;
            return Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                  child: user.photoUrl == null ? Text(user.name[0].toUpperCase()) : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      if (user.isTyping && user.typingInChatId == widget.chatId)
                        const Text(
                          'typing...',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      else
                        Text(
                          user.status == UserStatus.online
                              ? 'Online'
                              : 'Last seen \${timeago.format(user.lastSeen)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Show user info
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: _chatService.streamMessages(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: \${snapshot.error}'));
                }

                final messages = snapshot.data ?? [];

                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.message_outlined,
                          size: 80,
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No messages yet',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start the conversation!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _chatService.markMessagesAsRead(widget.chatId);
                });

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId == _chatService.currentUserId;
                    final showDateHeader = index == messages.length - 1 ||
                        !_isSameDay(message.timestamp, messages[index + 1].timestamp);

                    return Column(
                      children: [
                        if (showDateHeader) _buildDateHeader(message.timestamp),
                        MessageBubble(
                          message: message,
                          isMe: isMe,
                          onLongPress: () => _showMessageOptions(message),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    String dateText;
    if (messageDate == today) {
      dateText = 'Today';
    } else if (messageDate == yesterday) {
      dateText = 'Yesterday';
    } else {
      dateText = '\${date.day}/\${date.month}/\${date.year}';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          dateText,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
                  hintText: 'Type a message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 24,
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
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
}
