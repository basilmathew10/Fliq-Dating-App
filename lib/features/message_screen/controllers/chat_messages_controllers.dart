import 'package:get/get.dart';
import 'package:machine_test_lilac/features/message_screen/services/chat_messages_services.dart';
import '../models/chat_messages_model.dart';

class ChatMessagesController extends GetxController {
  final ChatMessagesService _chatMessagesService = ChatMessagesService();
  
  // Observable variables
  var isLoading = false.obs;
  var chatMessages = Rxn<ChatMessagesModel>();
  var chats = <Map<String, dynamic>>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChatMessages();
  }

  Future<void> fetchChatMessages() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await _chatMessagesService.getChatMessages();
      
      if (result != null) {
        chatMessages.value = result;
        _processChatData(result);
      } else {
        errorMessage.value = 'Failed to fetch chat messages';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print('Error in fetchChatMessages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _processChatData(ChatMessagesModel chatMessagesModel) {
    chats.clear();
    
    // Create a map of included data for quick lookup
    Map<String, IncludedAttributes> includedMap = {};
    if (chatMessagesModel.included != null) {
      for (var included in chatMessagesModel.included!) {
        if (included.id != null && included.attributes != null) {
          includedMap[included.id!] = included.attributes!;
        }
      }
    }

    // Process each chat message
    if (chatMessagesModel.data != null) {
      for (var datum in chatMessagesModel.data!) {
        if (datum.attributes != null) {
          // Get sender information from included data
          String? senderId = datum.attributes!.senderId?.toString();
          IncludedAttributes? senderInfo = senderId != null ? includedMap[senderId] : null;
          
          // Get receiver information from included data
          String? receiverId = datum.attributes!.receiverId?.toString();
          IncludedAttributes? receiverInfo = receiverId != null ? includedMap[receiverId] : null;
          
          // Create chat data
          Map<String, dynamic> chatData = {
            'id': datum.id ?? '',
            'name': senderInfo?.name ?? receiverInfo?.name ?? 'Unknown User',
            'username': senderInfo?.username ?? receiverInfo?.username ?? '',
            'email': senderInfo?.email ?? receiverInfo?.email ?? '',
            'profilePhotoUrl': senderInfo?.profilePhotoUrl ?? receiverInfo?.profilePhotoUrl ?? '',
            'square100ProfilePhotoUrl': senderInfo?.square100ProfilePhotoUrl ?? receiverInfo?.square100ProfilePhotoUrl ?? '',
            'square300ProfilePhotoUrl': senderInfo?.square300ProfilePhotoUrl ?? receiverInfo?.square300ProfilePhotoUrl ?? '',
            'square500ProfilePhotoUrl': senderInfo?.square500ProfilePhotoUrl ?? receiverInfo?.square500ProfilePhotoUrl ?? '',
            'message': datum.attributes!.message ?? '',
            'sentAt': datum.attributes!.sentAt,
            'deliveredAt': datum.attributes!.deliveredAt,
            'createdAt': datum.attributes!.createdAt,
            'mediaUrl': datum.attributes!.mediaUrl,
            'hasTime': datum.attributes!.sentAt != null,
            'time': datum.attributes!.sentAt != null ? _formatTime(datum.attributes!.sentAt!) : '',
            'senderId': datum.attributes!.senderId,
            'receiverId': datum.attributes!.receiverId,
            'chatThreadId': datum.attributes!.chatThreadId,
            'isOneTimeView': datum.attributes!.isOneTimeView ?? false,
            'isOnVanishMode': datum.attributes!.isOnVanishMode ?? false,
          };
          
          chats.add(chatData);
        }
      }
    }
  }

  String _formatTime(DateTime dateTime) {
    // Format time as needed (e.g., "2:30 PM" or "2 hours ago")
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  // Get user profile photo URL with fallback
  String? getUserProfilePhoto(Map<String, dynamic> chat) {
    return chat['square300ProfilePhotoUrl'] ?? 
           chat['square500ProfilePhotoUrl'] ?? 
           chat['square100ProfilePhotoUrl'] ?? 
           chat['profilePhotoUrl'];
  }

  // Refresh data
  Future<void> refresh() async {
    await fetchChatMessages();
  }

  // Clear data
  void clearData() {
    chats.clear();
    chatMessages.value = null;
    errorMessage.value = '';
  }
}