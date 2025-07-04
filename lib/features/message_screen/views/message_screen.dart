import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_lilac/features/chat_screen/chat_screen.dart';
import 'package:machine_test_lilac/features/message_screen/controllers/chat_messages_controllers.dart';
import 'package:machine_test_lilac/features/message_screen/controllers/contact_users_controllers.dart';
import 'package:machine_test_lilac/shared/utils/constants.dart';
import 'package:machine_test_lilac/shared/utils/theme.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _searchController = TextEditingController();
  MessageController messageController = Get.put(MessageController());
  final ChatMessagesController chatMessagesController =
      Get.put(ChatMessagesController());

  @override
  void initState() {
    super.initState();
    // Initialize the controller
    messageController = Get.put(MessageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Messages',
          style: AppTheme.headingText(darkTextColor),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Contact avatars section
          Obx(() {
            if (messageController.isLoading.value) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (messageController.errorMessage.value.isNotEmpty) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Center(
                  child: Text(
                    messageController.errorMessage.value,
                    style: AppTheme.smallText(Colors.red),
                  ),
                ),
              );
            }

            if (messageController.contactUsers.isEmpty) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Center(
                  child: Text(
                    'No contacts found',
                    style: AppTheme.smallText(darkTextColor),
                  ),
                ),
              );
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: messageController.contactUsers.map((contact) {
                    return Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(ChatScreen(
                                name: contact.attributes.name.toString(),
                                profileUrl: contact.attributes.profilePhotoUrl
                                    .toString(),
                              ));
                            },
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.grey[300],
                              child: ClipOval(
                                child: contact.attributes.profilePhotoUrl !=
                                            null &&
                                        contact.attributes.profilePhotoUrl!
                                            .isNotEmpty
                                    ? Image.network(
                                        contact.attributes.profilePhotoUrl!,
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[400],
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 60,
                            child: Text(
                              contact.attributes.name ?? 'Unknown',
                              style: AppTheme.smallText(darkTextColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 60, // Reduced from 60 to 50 for better proportions
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: AppTheme.bodyText(greyTextColor),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      "assets/images/search-favorite.png",
                      height: 20,
                      width: 20,
                      fit: BoxFit.contain,
                      color: Colors.grey[600],
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                ),
              ),
            ),
          ),

          // Chat label
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Chat',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Chat list
          Expanded(
            child: Obx(() {
              if (chatMessagesController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (chatMessagesController.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(
                    chatMessagesController.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (chatMessagesController.chats.isEmpty) {
                return const Center(
                  child: Text('No chat messages found'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: chatMessagesController.chats.length,
                itemBuilder: (context, index) {
                  final chat = chatMessagesController.chats[index];
                  final profilePhotoUrl =
                      chatMessagesController.getUserProfilePhoto(chat);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Row(
                      children: [
                        // Avatar
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey[300],
                          child: ClipOval(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                              child: profilePhotoUrl != null &&
                                      profilePhotoUrl.isNotEmpty
                                  ? Image.network(
                                      profilePhotoUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 25,
                                        );
                                      },
                                    )
                                  : const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Name and content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat['name'] ?? 'Unknown User',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              if (chat['message'] != null &&
                                  chat['message'].isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    chat['message'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // Time
                        if (chat['hasTime'])
                          Text(
                            chat['time'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
