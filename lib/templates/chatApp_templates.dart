class ChatAppTemplates {
  // ============================================================
  // CHAT MESSAGE MODEL
  // ============================================================
  static String generateChatMessageModel() {
    return '''
import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, file, audio }
enum MessageStatus { sent, delivered, read }

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String chatId;
  final String content; // Encrypted content
  final MessageType type;
  final MessageStatus status;
  final DateTime timestamp;
  final bool isDeleted;
  final String? mediaUrl;
  final String? fileName;
  final int? fileSize;
  final String? replyToMessageId;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.chatId,
    required this.content,
    required this.type,
    required this.status,
    required this.timestamp,
    this.isDeleted = false,
    this.mediaUrl,
    this.fileName,
    this.fileSize,
    this.replyToMessageId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'chatId': chatId,
      'content': content,
      'type': type.name,
      'status': status.name,
      'timestamp': Timestamp.fromDate(timestamp),
      'isDeleted': isDeleted,
      'mediaUrl': mediaUrl,
      'fileName': fileName,
      'fileSize': fileSize,
      'replyToMessageId': replyToMessageId,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      chatId: map['chatId'] ?? '',
      content: map['content'] ?? '',
      type: MessageType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => MessageType.text,
      ),
      status: MessageStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => MessageStatus.sent,
      ),
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      isDeleted: map['isDeleted'] ?? false,
      mediaUrl: map['mediaUrl'],
      fileName: map['fileName'],
      fileSize: map['fileSize'],
      replyToMessageId: map['replyToMessageId'],
    );
  }

  ChatMessage copyWith({
    MessageStatus? status,
    bool? isDeleted,
  }) {
    return ChatMessage(
      id: id,
      senderId: senderId,
      receiverId: receiverId,
      chatId: chatId,
      content: content,
      type: type,
      status: status ?? this.status,
      timestamp: timestamp,
      isDeleted: isDeleted ?? this.isDeleted,
      mediaUrl: mediaUrl,
      fileName: fileName,
      fileSize: fileSize,
      replyToMessageId: replyToMessageId,
    );
  }
}
''';
  }

  // ============================================================
  // CHAT USER MODEL
  // ============================================================
  static String generateChatUserModel() {
    return '''
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserStatus { online, offline, away }

class ChatUser {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? bio;
  final UserStatus status;
  final DateTime? lastSeen;
  final bool isTyping;
  final String? typingInChatId;
  final List<String> blockedUsers;
  final String publicKey; // For encryption

  ChatUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.bio,
    this.status = UserStatus.offline,
    this.lastSeen,
    this.isTyping = false,
    this.typingInChatId,
    this.blockedUsers = const [],
    required this.publicKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'status': status.name,
      'lastSeen': lastSeen != null ? Timestamp.fromDate(lastSeen!) : null,
      'isTyping': isTyping,
      'typingInChatId': typingInChatId,
      'blockedUsers': blockedUsers,
      'publicKey': publicKey,
    };
  }

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    return ChatUser(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      bio: map['bio'],
      status: UserStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => UserStatus.offline,
      ),
      lastSeen: map['lastSeen'] != null ? (map['lastSeen'] as Timestamp).toDate() : null,
      isTyping: map['isTyping'] ?? false,
      typingInChatId: map['typingInChatId'],
      blockedUsers: List<String>.from(map['blockedUsers'] ?? []),
      publicKey: map['publicKey'] ?? '',
    );
  }

  ChatUser copyWith({
    String? name,
    String? photoUrl,
    String? bio,
    UserStatus? status,
    DateTime? lastSeen,
    bool? isTyping,
    String? typingInChatId,
  }) {
    return ChatUser(
      id: id,
      name: name ?? this.name,
      email: email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      status: status ?? this.status,
      lastSeen: lastSeen ?? this.lastSeen,
      isTyping: isTyping ?? this.isTyping,
      typingInChatId: typingInChatId ?? this.typingInChatId,
      blockedUsers: blockedUsers,
      publicKey: publicKey,
    );
  }
}
''';
  }

  // ============================================================
  // CHAT CONVERSATION MODEL
  // ============================================================
  static String generateChatConversationModel() {
    return '''
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatConversation {
  final String id;
  final List<String> participants;
  final String? lastMessage;
  final DateTime lastMessageTime;
  final Map<String, int> unreadCount;
  final Map<String, bool> deletedFor;
  final bool isGroup;
  final String? groupName;
  final String? groupIcon;

  ChatConversation({
    required this.id,
    required this.participants,
    this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = const {},
    this.deletedFor = const {},
    this.isGroup = false,
    this.groupName,
    this.groupIcon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': Timestamp.fromDate(lastMessageTime),
      'unreadCount': unreadCount,
      'deletedFor': deletedFor,
      'isGroup': isGroup,
      'groupName': groupName,
      'groupIcon': groupIcon,
    };
  }

  factory ChatConversation.fromMap(Map<String, dynamic> map) {
    return ChatConversation(
      id: map['id'] ?? '',
      participants: List<String>.from(map['participants'] ?? []),
      lastMessage: map['lastMessage'],
      lastMessageTime: (map['lastMessageTime'] as Timestamp).toDate(),
      unreadCount: Map<String, int>.from(map['unreadCount'] ?? {}),
      deletedFor: Map<String, bool>.from(map['deletedFor'] ?? {}),
      isGroup: map['isGroup'] ?? false,
      groupName: map['groupName'],
      groupIcon: map['groupIcon'],
    );
  }

  int getUnreadCount(String userId) {
    return unreadCount[userId] ?? 0;
  }

  bool isDeletedFor(String userId) {
    return deletedFor[userId] ?? false;
  }
}
''';
  }

  // ============================================================
  // ENCRYPTION SERVICE
  // ============================================================
  static String generateEncryptionService() {
    return '''
import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';

class EncryptionService {
  // Generate a random encryption key
  static String generateKey() {
    final key = encrypt.Key.fromSecureRandom(32);
    return base64.encode(key.bytes);
  }

  // Encrypt message content
  static String encryptMessage(String message, String keyString) {
    try {
      final key = encrypt.Key(base64.decode(keyString));
      final iv = encrypt.IV.fromSecureRandom(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      
      final encrypted = encrypter.encrypt(message, iv: iv);
      
      // Combine IV and encrypted data
      final combined = base64.encode(iv.bytes + encrypted.bytes);
      return combined;
    } catch (e) {
      throw Exception('Encryption failed: \$e');
    }
  }

  // Decrypt message content
  static String decryptMessage(String encryptedMessage, String keyString) {
    try {
      final key = encrypt.Key(base64.decode(keyString));
      final combined = base64.decode(encryptedMessage);
      
      // Extract IV and encrypted data
      final iv = encrypt.IV(Uint8List.fromList(combined.sublist(0, 16)));
      final encryptedData = combined.sublist(16);
      
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final decrypted = encrypter.decrypt64(base64.encode(encryptedData), iv: iv);
      
      return decrypted;
    } catch (e) {
      throw Exception('Decryption failed: \$e');
    }
  }

  // Generate chat ID from two user IDs (always same order)
  static String generateChatId(String userId1, String userId2) {
    final sortedIds = [userId1, userId2]..sort();
    return sha256.convert(utf8.encode(sortedIds.join('_'))).toString();
  }

  // Hash for secure storage
  static String hashString(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}
''';
  }

  // ============================================================
  // CHAT SERVICE
  // ============================================================
  static String generateChatService(String projectName) {
    return '''
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:$projectName/features/chat/models/chat_message_model.dart';
import 'package:$projectName/features/chat/models/chat_user_model.dart';
import 'package:$projectName/features/chat/models/chat_conversation_model.dart';
import 'package:$projectName/features/chat/services/encryption_service.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String get currentUserId => _auth.currentUser?.uid ?? '';

  // ============================================================
  // USER MANAGEMENT
  // ============================================================

  /// Initialize user profile for chat
  Future<void> initializeUserProfile(String name, String email) async {
    final userId = currentUserId;
    if (userId.isEmpty) throw Exception('User not authenticated');

    final encryptionKey = EncryptionService.generateKey();

    final chatUser = ChatUser(
      id: userId,
      name: name,
      email: email,
      status: UserStatus.online,
      publicKey: encryptionKey,
    );

    await _firestore.collection('chat_users').doc(userId).set(chatUser.toMap());
  }

  /// Update user status
  Future<void> updateUserStatus(UserStatus status) async {
    final userId = currentUserId;
    if (userId.isEmpty) return;

    await _firestore.collection('chat_users').doc(userId).update({
      'status': status.name,
      'lastSeen': FieldValue.serverTimestamp(),
    });
  }

  /// Update typing status
  Future<void> updateTypingStatus(String chatId, bool isTyping) async {
    final userId = currentUserId;
    if (userId.isEmpty) return;

    await _firestore.collection('chat_users').doc(userId).update({
      'isTyping': isTyping,
      'typingInChatId': isTyping ? chatId : null,
    });
  }

  /// Search users
  Future<List<ChatUser>> searchUsers(String query) async {
    final snapshot = await _firestore
        .collection('chat_users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\\uf8ff')
        .limit(20)
        .get();

    return snapshot.docs
        .map((doc) => ChatUser.fromMap(doc.data()))
        .where((user) => user.id != currentUserId)
        .toList();
  }

  /// Get user by ID
  Future<ChatUser?> getUserById(String userId) async {
    final doc = await _firestore.collection('chat_users').doc(userId).get();
    if (!doc.exists) return null;
    return ChatUser.fromMap(doc.data()!);
  }

  /// Stream user data
  Stream<ChatUser?> streamUser(String userId) {
    return _firestore
        .collection('chat_users')
        .doc(userId)
        .snapshots()
        .map((doc) => doc.exists ? ChatUser.fromMap(doc.data()!) : null);
  }

  // ============================================================
  // CONVERSATION MANAGEMENT
  // ============================================================

  /// Get or create conversation
  Future<String> getOrCreateConversation(String otherUserId) async {
    final userId = currentUserId;
    final chatId = EncryptionService.generateChatId(userId, otherUserId);

    final doc = await _firestore.collection('conversations').doc(chatId).get();

    if (!doc.exists) {
      final conversation = ChatConversation(
        id: chatId,
        participants: [userId, otherUserId],
        lastMessageTime: DateTime.now(),
        unreadCount: {userId: 0, otherUserId: 0},
      );

      await _firestore.collection('conversations').doc(chatId).set(conversation.toMap());
    }

    return chatId;
  }

  /// Get user conversations
  Stream<List<ChatConversation>> streamConversations() {
    final userId = currentUserId;

    return _firestore
        .collection('conversations')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatConversation.fromMap(doc.data()))
            .where((conv) => !conv.isDeletedFor(userId))
            .toList());
  }

  // ============================================================
  // MESSAGE MANAGEMENT
  // ============================================================

  /// Send text message
  Future<void> sendMessage({
    required String receiverId,
    required String content,
    String? replyToMessageId,
  }) async {
    final userId = currentUserId;
    final chatId = await getOrCreateConversation(receiverId);

    // Get encryption key
    final receiverUser = await getUserById(receiverId);
    if (receiverUser == null) throw Exception('Receiver not found');

    // Encrypt message
    final encryptedContent = EncryptionService.encryptMessage(
      content,
      receiverUser.publicKey,
    );

    final message = ChatMessage(
      id: _firestore.collection('messages').doc().id,
      senderId: userId,
      receiverId: receiverId,
      chatId: chatId,
      content: encryptedContent,
      type: MessageType.text,
      status: MessageStatus.sent,
      timestamp: DateTime.now(),
      replyToMessageId: replyToMessageId,
    );

    // Save message
    await _firestore
        .collection('messages')
        .doc(message.id)
        .set(message.toMap());

    // Update conversation
    await _updateConversation(chatId, content, receiverId);
  }

  /// Send image message
  Future<void> sendImageMessage({
    required String receiverId,
    required File imageFile,
  }) async {
    final userId = currentUserId;
    final chatId = await getOrCreateConversation(receiverId);

    // Upload image
    final fileName = '\${DateTime.now().millisecondsSinceEpoch}.jpg';
    final storageRef = _storage.ref().child('chat_images/\$chatId/\$fileName');
    
    await storageRef.putFile(imageFile);
    final imageUrl = await storageRef.getDownloadURL();

    final message = ChatMessage(
      id: _firestore.collection('messages').doc().id,
      senderId: userId,
      receiverId: receiverId,
      chatId: chatId,
      content: 'Image',
      type: MessageType.image,
      status: MessageStatus.sent,
      timestamp: DateTime.now(),
      mediaUrl: imageUrl,
    );

    await _firestore.collection('messages').doc(message.id).set(message.toMap());
    await _updateConversation(chatId, '📷 Image', receiverId);
  }

  /// Send file message
  Future<void> sendFileMessage({
    required String receiverId,
    required File file,
    required String fileName,
  }) async {
    final userId = currentUserId;
    final chatId = await getOrCreateConversation(receiverId);

    // Upload file
    final storageRef = _storage.ref().child('chat_files/\$chatId/\$fileName');
    await storageRef.putFile(file);
    final fileUrl = await storageRef.getDownloadURL();

    final message = ChatMessage(
      id: _firestore.collection('messages').doc().id,
      senderId: userId,
      receiverId: receiverId,
      chatId: chatId,
      content: 'File',
      type: MessageType.file,
      status: MessageStatus.sent,
      timestamp: DateTime.now(),
      mediaUrl: fileUrl,
      fileName: fileName,
      fileSize: await file.length(),
    );

    await _firestore.collection('messages').doc(message.id).set(message.toMap());
    await _updateConversation(chatId, '📎 \$fileName', receiverId);
  }

  /// Update conversation after sending message
  Future<void> _updateConversation(
    String chatId,
    String lastMessage,
    String receiverId,
  ) async {
    final userId = currentUserId;

    await _firestore.collection('conversations').doc(chatId).update({
      'lastMessage': lastMessage,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'unreadCount.\$receiverId': FieldValue.increment(1),
    });
  }

  /// Stream messages
  Stream<List<ChatMessage>> streamMessages(String chatId) {
    return _firestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('timestamp', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList());
  }

  /// Mark messages as read
  Future<void> markMessagesAsRead(String chatId, String senderId) async {
    final userId = currentUserId;

    final messages = await _firestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .where('receiverId', isEqualTo: userId)
        .where('senderId', isEqualTo: senderId)
        .where('status', isNotEqualTo: MessageStatus.read.name)
        .get();

    final batch = _firestore.batch();

    for (var doc in messages.docs) {
      batch.update(doc.reference, {'status': MessageStatus.read.name});
    }

    await batch.commit();

    // Reset unread count
    await _firestore.collection('conversations').doc(chatId).update({
      'unreadCount.\$userId': 0,
    });
  }

  /// Delete message
  Future<void> deleteMessage(String messageId) async {
    await _firestore.collection('messages').doc(messageId).update({
      'isDeleted': true,
      'content': 'This message was deleted',
    });
  }
}
''';
  }
}