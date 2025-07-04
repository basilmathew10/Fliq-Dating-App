import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_lilac/features/message_screen/services/contact_users_services.dart';
import '../models/contact_user_model.dart';

class MessageController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  
  // Observable variables
  var isLoading = false.obs;
  var contactUsers = <Datum>[].obs;
  var filteredContacts = <Datum>[].obs;
  var chatMessages = <Map<String, dynamic>>[].obs;
  var selectedContactId = ''.obs;
  var selectedContactName = ''.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContactUsers();
    
    // Listen to search input changes
    searchController.addListener(() {
      filterContacts(searchController.text);
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Fetches contact users from API
  Future<void> fetchContactUsers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      
      final contactUserModel = await ContactUserService.getContactUsers();
      
      if (contactUserModel != null) {
        
        // Debug: Print each contact's details
        for (var i = 0; i < contactUserModel.data.length; i++) {
          final contact = contactUserModel.data[i];
          print('Contact $i:');
          print('  ID: ${contact.id}');
          print('  Name: ${contact.attributes.name}');
          print('  Profile Photo URL: ${contact.attributes.profilePhotoUrl}');
        }
        
        // IMPORTANT: Clear the list first, then assign new data
        contactUsers.clear();
        contactUsers.addAll(contactUserModel.data);
        
        filteredContacts.clear();
        filteredContacts.addAll(contactUserModel.data);
        
        // Force UI update
        update();
        
        // If no contact is selected, select the first one by default
        if (contactUsers.isNotEmpty && selectedContactId.value.isEmpty) {
          selectContact(contactUsers.first);
        }
      } else {
        errorMessage.value = 'Failed to load contacts - No data received';
      }
    } catch (e, stackTrace) {
      print('Stack trace: $stackTrace');
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;

    }
  }

  /// Filters contacts based on search query
  void filterContacts(String query) {
    if (query.isEmpty) {
      filteredContacts.clear();
      filteredContacts.addAll(contactUsers);
    } else {
      final filtered = contactUsers.where((contact) {
        final name = contact.attributes.name?.toLowerCase() ?? '';
        final username = contact.attributes.username?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        
        return name.contains(searchQuery) || username.contains(searchQuery);
      }).toList();
      
      filteredContacts.clear();
      filteredContacts.addAll(filtered);
    }
    print('Filtered contacts count: ${filteredContacts.length}');
  }

  /// Selects a contact and loads their chat messages
  Future<void> selectContact(Datum contact) async {
    try {
      selectedContactId.value = contact.id;
      selectedContactName.value = contact.attributes.name ?? 'Unknown';
      
      print('Selected contact: ${selectedContactName.value}');
      
      // // Load chat messages for selected contact
      // await loadChatMessages(contact.id);
    } catch (e) {
      errorMessage.value = 'Error selecting contact: ${e.toString()}';
    }
  }

  bool isSelected(String contactId) {
    return selectedContactId.value == contactId;
  }

  /// Manual refresh method
  Future<void> refreshContacts() async {
    await fetchContactUsers();
  }
}