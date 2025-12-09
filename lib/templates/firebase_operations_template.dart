class FirebaseOperationsTemplate {
  static String generate(List<String> modules) {
    final hasAuth = modules.contains('auth');
    final hasFirestore = modules.contains('firestore');
    final hasStorage = modules.contains('storage');
    final hasFCM = modules.contains('fcm');

    return '''
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
${hasAuth ? "import 'package:firebase_auth/firebase_auth.dart';" : ''}
${hasFirestore ? "import 'package:cloud_firestore/cloud_firestore.dart';" : ''}
${hasStorage ? "import 'package:firebase_storage/firebase_storage.dart';" : ''}
${hasFCM ? "import 'package:firebase_messaging/firebase_messaging.dart';" : ''}
import 'dart:io';

/// Firebase Operations Service
/// Handles all Firebase CRUD operations for the app
class FirebaseOperations {
${hasAuth ? _generateAuthOperations() : ''}
${hasFirestore ? _generateFirestoreOperations() : ''}
${hasStorage ? _generateStorageOperations() : ''}
${hasFCM ? _generateFCMOperations() : ''}
}

// Custom Exception Classes
class FirebaseOperationException implements Exception {
  final String message;
  final String? code;

  FirebaseOperationException(this.message, {this.code});

  @override
  String toString() => 'FirebaseOperationException: \$message (Code: \$code)';
}
''';
  }

  static String _generateAuthOperations() {
    return '''
  // ============================================================
  // AUTHENTICATION OPERATIONS
  // ============================================================

  /// Get current user
  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  /// Check if user is logged in
  static bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  /// Sign up with email and password
  static Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseOperationException(
        _getAuthErrorMessage(e.code),
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Sign in with email and password
  static Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseOperationException(
        _getAuthErrorMessage(e.code),
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Sign in anonymously
  static Future<UserCredential> signInAnonymously() async {
    try {
      return await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw FirebaseOperationException(
        _getAuthErrorMessage(e.code),
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Send password reset email
  static Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseOperationException(
        _getAuthErrorMessage(e.code),
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Update user profile
  static Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw FirebaseOperationException('No user logged in');
      }

      await user.updateDisplayName(displayName);
      await user.updatePhotoURL(photoURL);
      await user.reload();
    } on FirebaseAuthException catch (e) {
      throw FirebaseOperationException(
        _getAuthErrorMessage(e.code),
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Change user password
  static Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.email == null) {
        throw FirebaseOperationException('No user logged in');
      }

      // Re-authenticate user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw FirebaseOperationException(
        _getAuthErrorMessage(e.code),
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Delete user account
  static Future<void> deleteAccount({required String password}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.email == null) {
        throw FirebaseOperationException('No user logged in');
      }

      // Re-authenticate user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      // Delete account
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw FirebaseOperationException(
        _getAuthErrorMessage(e.code),
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Sign out
  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw FirebaseOperationException('Failed to sign out: \$e');
    }
  }

  /// Get auth error message
  static String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password is too weak.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
''';
  }

  static String _generateFirestoreOperations() {
    return '''
  // ============================================================
  // FIRESTORE OPERATIONS
  // ============================================================

  /// Create a document in a collection
  static Future<String> createDocument({
    required String collection,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();

      if (documentId != null) {
        await FirebaseFirestore.instance
            .collection(collection)
            .doc(documentId)
            .set(data);
        return documentId;
      } else {
        final docRef = await FirebaseFirestore.instance
            .collection(collection)
            .add(data);
        return docRef.id;
      }
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to create document: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Read a single document
  static Future<Map<String, dynamic>?> readDocument({
    required String collection,
    required String documentId,
  }) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(collection)
          .doc(documentId)
          .get();

      if (!doc.exists) return null;

      return {
        'id': doc.id,
        ...doc.data()!,
      };
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to read document: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Read all documents in a collection
  static Future<List<Map<String, dynamic>>> readCollection({
    required String collection,
    int? limit,
    String? orderBy,
    bool descending = false,
  }) async {
    try {
      Query query = FirebaseFirestore.instance.collection(collection);

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to read collection: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Query documents with conditions
  static Future<List<Map<String, dynamic>>> queryDocuments({
    required String collection,
    required String field,
    required dynamic value,
    String? orderBy,
    int? limit,
  }) async {
    try {
      Query query = FirebaseFirestore.instance
          .collection(collection)
          .where(field, isEqualTo: value);

      if (orderBy != null) {
        query = query.orderBy(orderBy);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to query documents: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Update a document
  static Future<void> updateDocument({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      data['updatedAt'] = FieldValue.serverTimestamp();

      await FirebaseFirestore.instance
          .collection(collection)
          .doc(documentId)
          .update(data);
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to update document: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Delete a document
  static Future<void> deleteDocument({
    required String collection,
    required String documentId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(documentId)
          .delete();
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to delete document: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Stream a single document (real-time updates)
  static Stream<Map<String, dynamic>?> streamDocument({
    required String collection,
    required String documentId,
  }) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return {
        'id': doc.id,
        ...doc.data()!,
      };
    });
  }

  /// Stream a collection (real-time updates)
  static Stream<List<Map<String, dynamic>>> streamCollection({
    required String collection,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) {
    Query query = FirebaseFirestore.instance.collection(collection);

    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

  /// Batch write operations
  static Future<void> batchWrite({
    required List<Map<String, dynamic>> operations,
  }) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      for (final operation in operations) {
        final type = operation['type'] as String;
        final collection = operation['collection'] as String;
        final documentId = operation['documentId'] as String?;
        final data = operation['data'] as Map<String, dynamic>?;

        final docRef = documentId != null
            ? FirebaseFirestore.instance.collection(collection).doc(documentId)
            : FirebaseFirestore.instance.collection(collection).doc();

        switch (type) {
          case 'set':
            batch.set(docRef, data!);
            break;
          case 'update':
            batch.update(docRef, data!);
            break;
          case 'delete':
            batch.delete(docRef);
            break;
        }
      }

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Batch operation failed: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }
''';
  }

  static String _generateStorageOperations() {
    return '''
  // ============================================================
  // STORAGE OPERATIONS
  // ============================================================

  /// Upload a file to Firebase Storage
  static Future<String> uploadFile({
    required File file,
    required String path,
    Function(double)? onProgress,
  }) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress?.call(progress);
      });

      await uploadTask;
      final downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to upload file: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Upload bytes to Firebase Storage
  static Future<String> uploadBytes({
    required List<int> bytes,
    required String path,
    String? contentType,
    Function(double)? onProgress,
  }) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      
      final metadata = contentType != null
          ? SettableMetadata(contentType: contentType)
          : null;

      final uploadTask = metadata != null
          ? ref.putData(bytes as Uint8List, metadata)
          : ref.putData(bytes as Uint8List);

      uploadTask.snapshotEvents.listen((snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress?.call(progress);
      });

      await uploadTask;
      final downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to upload bytes: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Download a file from Firebase Storage
  static Future<File> downloadFile({
    required String path,
    required String localPath,
  }) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      final file = File(localPath);

      await ref.writeToFile(file);

      return file;
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to download file: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Get download URL for a file
  static Future<String> getDownloadUrl({required String path}) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to get download URL: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Delete a file from Firebase Storage
  static Future<void> deleteFile({required String path}) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.delete();
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to delete file: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// List all files in a directory
  static Future<List<String>> listFiles({required String path}) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      final result = await ref.listAll();

      return result.items.map((item) => item.fullPath).toList();
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to list files: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }

  /// Get file metadata
  static Future<Map<String, dynamic>> getFileMetadata({
    required String path,
  }) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      final metadata = await ref.getMetadata();

      return {
        'name': metadata.name,
        'bucket': metadata.bucket,
        'fullPath': metadata.fullPath,
        'size': metadata.size,
        'contentType': metadata.contentType,
        'timeCreated': metadata.timeCreated,
        'updated': metadata.updated,
      };
    } on FirebaseException catch (e) {
      throw FirebaseOperationException(
        'Failed to get metadata: \${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw FirebaseOperationException('An unexpected error occurred: \$e');
    }
  }
''';
  }

  static String _generateFCMOperations() {
    return '''
  // ============================================================
  // FIREBASE CLOUD MESSAGING OPERATIONS
  // ============================================================

  /// Initialize FCM and request permissions
  static Future<void> initializeFCM() async {
    try {
      final messaging = FirebaseMessaging.instance;

      // Request permission for notifications
      final settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    } catch (e) {
      throw FirebaseOperationException('Failed to initialize FCM: \$e');
    }
  }

  /// Get FCM token
  static Future<String?> getFCMToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      print('FCM Token: \$token');
      return token;
    } catch (e) {
      throw FirebaseOperationException('Failed to get FCM token: \$e');
    }
  }

  /// Subscribe to a topic
  static Future<void> subscribeToTopic({required String topic}) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      print('Subscribed to topic: \$topic');
    } catch (e) {
      throw FirebaseOperationException('Failed to subscribe to topic: \$e');
    }
  }

  /// Unsubscribe from a topic
  static Future<void> unsubscribeFromTopic({required String topic}) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: \$topic');
    } catch (e) {
      throw FirebaseOperationException('Failed to unsubscribe from topic: \$e');
    }
  }

  /// Handle foreground messages
  static void handleForegroundMessages(
    void Function(RemoteMessage) onMessage,
  ) {
    FirebaseMessaging.onMessage.listen(onMessage);
  }

  /// Handle background messages
  static void handleBackgroundMessages(
    void Function(RemoteMessage) onBackgroundMessage,
  ) {
    FirebaseMessaging.onBackgroundMessage(
      (message) async => onBackgroundMessage(message),
    );
  }

  /// Handle notification tap when app is in background
  static void handleMessageOpenedApp(
    void Function(RemoteMessage) onMessageOpenedApp,
  ) {
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
  }

  /// Get initial message if app was opened from notification
  static Future<RemoteMessage?> getInitialMessage() async {
    return await FirebaseMessaging.instance.getInitialMessage();
  }
''';
  }
}