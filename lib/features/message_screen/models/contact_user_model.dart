class ContactUserModel {
  List<Datum> data;
  List<Included> included;
  Meta meta;
  Links links;

  ContactUserModel({
    required this.data,
    required this.included,
    required this.meta,
    required this.links,
  });

  factory ContactUserModel.fromJson(Map<String, dynamic> json) {
    return ContactUserModel(
      data: json["data"] != null
          ? List<Datum>.from(json["data"]
              .where((x) =>
                  x["attributes"] !=
                  null) // This might be filtering out your data
              .map((x) => Datum.fromJson(x)))
          : [],
      included: json["included"] != null
          ? List<Included>.from(
              json["included"].map((x) => Included.fromJson(x)))
          : [],
      meta: json["meta"] != null
          ? Meta.fromJson(json["meta"])
          : Meta(
              pagination: Pagination(
                  total: 0,
                  count: 0,
                  perPage: 0,
                  currentPage: 0,
                  totalPages: 0)),
      links: json["links"] != null
          ? Links.fromJson(json["links"])
          : Links(self: "", first: "", last: ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "included": List<dynamic>.from(included.map((x) => x.toJson())),
        "meta": meta.toJson(),
        "links": links.toJson(),
      };
}

class Datum {
  String type;
  String id;
  DatumAttributes attributes;
  Relationships? relationships;

  Datum({
    required this.type,
    required this.id,
    required this.attributes,
    this.relationships,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      type: json["type"] ?? "",
      id: json["id"] ?? "",
      attributes: json["attributes"] != null
          ? DatumAttributes.fromJson(json["attributes"])
          : throw Exception("Attributes cannot be null"),
      relationships: json["relationships"] != null
          ? Relationships.fromJson(json["relationships"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes.toJson(),
        "relationships": relationships?.toJson(),
      };
}

class DatumAttributes {
  DateTime? messageReceivedFromPartnerAt;
  int? authUserId;
  String? name;
  String? username;
  String? email;
  dynamic profilePhotoPath;
  dynamic profilePhotoId;
  String? phone;
  String? gender;
  int? countryId;
  String? countryName;
  int? stateId;
  String? stateName;
  int? cityId;
  String? cityName;
  dynamic customCityName;
  bool? isActive;
  String? customerCode;
  bool? isPremiumCustomer;
  bool? isOnline;
  dynamic bioIntroText;
  DateTime? lastActiveAt;
  String? address;
  DateTime? dateOfBirth;
  int? nativeLanguageId;
  String? nativeLanguageName;
  String? referralCode;
  dynamic referredBy;
  dynamic referredId;
  bool? isVanishModeEnabled;
  bool? isChatInitiated;
  DateTime? likebackCreatedAt;
  String? profilePhotoUrl;
  String? square100ProfilePhotoUrl;
  String? square300ProfilePhotoUrl;
  String? square500ProfilePhotoUrl;
  int? age;

  DatumAttributes({
    this.messageReceivedFromPartnerAt,
    this.authUserId,
    this.name,
    this.username,
    this.email,
    this.profilePhotoPath,
    this.profilePhotoId,
    this.phone,
    this.gender,
    this.countryId,
    this.countryName,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.customCityName,
    this.isActive,
    this.customerCode,
    this.isPremiumCustomer,
    this.isOnline,
    this.bioIntroText,
    this.lastActiveAt,
    this.address,
    this.dateOfBirth,
    this.nativeLanguageId,
    this.nativeLanguageName,
    this.referralCode,
    this.referredBy,
    this.referredId,
    this.isVanishModeEnabled,
    this.isChatInitiated,
    this.likebackCreatedAt,
    this.profilePhotoUrl,
    this.square100ProfilePhotoUrl,
    this.square300ProfilePhotoUrl,
    this.square500ProfilePhotoUrl,
    this.age,
  });

  factory DatumAttributes.fromJson(Map<String, dynamic> json) {
    return DatumAttributes(
      messageReceivedFromPartnerAt:
          json["message_received_from_partner_at"] != null
              ? DateTime.tryParse(json["message_received_from_partner_at"])
              : null,
      authUserId: json["auth_user_id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      profilePhotoPath: json["profile_photo_path"],
      profilePhotoId: json["profile_photo_id"],
      phone: json["phone"],
      gender: json["gender"],
      countryId: json["country_id"],
      countryName: json["country_name"],
      stateId: json["state_id"],
      stateName: json["state_name"],
      cityId: json["city_id"],
      cityName: json["city_name"],
      customCityName: json["custom_city_name"],
      isActive: json["is_active"],
      customerCode: json["customer_code"],
      isPremiumCustomer: json["is_premium_customer"],
      isOnline: json["is_online"],
      bioIntroText: json["bio_intro_text"],
      lastActiveAt: json["last_active_at"] != null
          ? DateTime.tryParse(json["last_active_at"])
          : null,
      address: json["address"],
      dateOfBirth: json["date_of_birth"] != null
          ? DateTime.tryParse(json["date_of_birth"])
          : null,
      nativeLanguageId: json["native_language_id"],
      nativeLanguageName: json["native_language_name"],
      referralCode: json["referral_code"],
      referredBy: json["referred_by"],
      referredId: json["referred_id"],
      isVanishModeEnabled: json["is_vanish_mode_enabled"],
      isChatInitiated: json["is_chat_initiated"],
      likebackCreatedAt: json["likeback_created_at"] != null
          ? DateTime.tryParse(json["likeback_created_at"])
          : null,
      profilePhotoUrl: json["profile_photo_url"],
      square100ProfilePhotoUrl: json["square100_profile_photo_url"],
      square300ProfilePhotoUrl: json["square300_profile_photo_url"],
      square500ProfilePhotoUrl: json["square500_profile_photo_url"],
      age: json["age"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message_received_from_partner_at":
            messageReceivedFromPartnerAt?.toIso8601String(),
        "auth_user_id": authUserId,
        "name": name,
        "username": username,
        "email": email,
        "profile_photo_path": profilePhotoPath,
        "profile_photo_id": profilePhotoId,
        "phone": phone,
        "gender": gender,
        "country_id": countryId,
        "country_name": countryName,
        "state_id": stateId,
        "state_name": stateName,
        "city_id": cityId,
        "city_name": cityName,
        "custom_city_name": customCityName,
        "is_active": isActive,
        "customer_code": customerCode,
        "is_premium_customer": isPremiumCustomer,
        "is_online": isOnline,
        "bio_intro_text": bioIntroText,
        "last_active_at": lastActiveAt?.toIso8601String(),
        "address": address,
        "date_of_birth": dateOfBirth != null
            ? "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}"
            : null,
        "native_language_id": nativeLanguageId,
        "native_language_name": nativeLanguageName,
        "referral_code": referralCode,
        "referred_by": referredBy,
        "referred_id": referredId,
        "is_vanish_mode_enabled": isVanishModeEnabled,
        "is_chat_initiated": isChatInitiated,
        "likeback_created_at": likebackCreatedAt?.toIso8601String(),
        "profile_photo_url": profilePhotoUrl,
        "square100_profile_photo_url": square100ProfilePhotoUrl,
        "square300_profile_photo_url": square300ProfilePhotoUrl,
        "square500_profile_photo_url": square500ProfilePhotoUrl,
        "age": age,
      };
}

class Relationships {
  BlockedContacts? blockedContacts;
  UserSettings? userSettings;

  Relationships({
    this.blockedContacts,
    this.userSettings,
  });

  factory Relationships.fromJson(Map<String, dynamic> json) {
    return Relationships(
      blockedContacts: json["blockedContacts"] != null
          ? BlockedContacts.fromJson(json["blockedContacts"])
          : null,
      userSettings: json["userSettings"] != null
          ? UserSettings.fromJson(json["userSettings"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "blockedContacts": blockedContacts?.toJson(),
        "userSettings": userSettings?.toJson(),
      };
}

class BlockedContacts {
  List<dynamic> data;

  BlockedContacts({
    required this.data,
  });

  factory BlockedContacts.fromJson(Map<String, dynamic> json) {
    return BlockedContacts(
      data: json["data"] != null
          ? List<dynamic>.from(json["data"].map((x) => x))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}

class UserSettings {
  Data? data;

  UserSettings({
    this.data,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  String? type;
  String? id;

  Data({
    this.type,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      type: json["type"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
      };
}

class Included {
  String? type;
  String? id;
  IncludedAttributes? attributes;

  Included({
    this.type,
    this.id,
    this.attributes,
  });

  factory Included.fromJson(Map<String, dynamic> json) {
    return Included(
      type: json["type"],
      id: json["id"],
      attributes: json["attributes"] != null
          ? IncludedAttributes.fromJson(json["attributes"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes?.toJson(),
      };
}

class IncludedAttributes {
  int? userId;
  bool? isRealGiftsAccepted;
  bool? isGenderRevealed;
  bool? isHeightRevealed;
  bool? isReligionRevealed;
  bool? isDrinkingHabitRevealed;
  bool? isSmokingHabitRevealed;
  bool? isSexualOrientationRevealed;
  bool? isEducationalQualificationRevealed;
  bool? isPersonalityTraitsRevealed;
  bool? isLifestyleActivitiesRevealed;
  bool? isContactDiscoveryEnabled;
  bool? isGhostModeEnabled;
  bool? isDarkModeEnabled;
  bool? isReceivingPushNotifications;
  bool? isReceivingFlashMessages;
  bool? isLastSeenEnabled;
  bool? isOnlineStatusEnabled;
  bool? isReadReceiptsEnabled;

  IncludedAttributes({
    this.userId,
    this.isRealGiftsAccepted,
    this.isGenderRevealed,
    this.isHeightRevealed,
    this.isReligionRevealed,
    this.isDrinkingHabitRevealed,
    this.isSmokingHabitRevealed,
    this.isSexualOrientationRevealed,
    this.isEducationalQualificationRevealed,
    this.isPersonalityTraitsRevealed,
    this.isLifestyleActivitiesRevealed,
    this.isContactDiscoveryEnabled,
    this.isGhostModeEnabled,
    this.isDarkModeEnabled,
    this.isReceivingPushNotifications,
    this.isReceivingFlashMessages,
    this.isLastSeenEnabled,
    this.isOnlineStatusEnabled,
    this.isReadReceiptsEnabled,
  });

  factory IncludedAttributes.fromJson(Map<String, dynamic> json) {
    return IncludedAttributes(
      userId: json["user_id"],
      isRealGiftsAccepted: json["is_real_gifts_accepted"],
      isGenderRevealed: json["is_gender_revealed"],
      isHeightRevealed: json["is_height_revealed"],
      isReligionRevealed: json["is_religion_revealed"],
      isDrinkingHabitRevealed: json["is_drinking_habit_revealed"],
      isSmokingHabitRevealed: json["is_smoking_habit_revealed"],
      isSexualOrientationRevealed: json["is_sexual_orientation_revealed"],
      isEducationalQualificationRevealed:
          json["is_educational_qualification_revealed"],
      isPersonalityTraitsRevealed: json["is_personality_traits_revealed"],
      isLifestyleActivitiesRevealed: json["is_lifestyle_activities_revealed"],
      isContactDiscoveryEnabled: json["is_contact_discovery_enabled"],
      isGhostModeEnabled: json["is_ghost_mode_enabled"],
      isDarkModeEnabled: json["is_dark_mode_enabled"],
      isReceivingPushNotifications: json["is_receiving_push_notifications"],
      isReceivingFlashMessages: json["is_receiving_flash_messages"],
      isLastSeenEnabled: json["is_last_seen_enabled"],
      isOnlineStatusEnabled: json["is_online_status_enabled"],
      isReadReceiptsEnabled: json["is_read_receipts_enabled"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "is_real_gifts_accepted": isRealGiftsAccepted,
        "is_gender_revealed": isGenderRevealed,
        "is_height_revealed": isHeightRevealed,
        "is_religion_revealed": isReligionRevealed,
        "is_drinking_habit_revealed": isDrinkingHabitRevealed,
        "is_smoking_habit_revealed": isSmokingHabitRevealed,
        "is_sexual_orientation_revealed": isSexualOrientationRevealed,
        "is_educational_qualification_revealed":
            isEducationalQualificationRevealed,
        "is_personality_traits_revealed": isPersonalityTraitsRevealed,
        "is_lifestyle_activities_revealed": isLifestyleActivitiesRevealed,
        "is_contact_discovery_enabled": isContactDiscoveryEnabled,
        "is_ghost_mode_enabled": isGhostModeEnabled,
        "is_dark_mode_enabled": isDarkModeEnabled,
        "is_receiving_push_notifications": isReceivingPushNotifications,
        "is_receiving_flash_messages": isReceivingFlashMessages,
        "is_last_seen_enabled": isLastSeenEnabled,
        "is_online_status_enabled": isOnlineStatusEnabled,
        "is_read_receipts_enabled": isReadReceiptsEnabled,
      };
}

class Links {
  String? self;
  String? first;
  String? last;

  Links({
    this.self,
    this.first,
    this.last,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json["self"],
      first: json["first"],
      last: json["last"],
    );
  }

  Map<String, dynamic> toJson() => {
        "self": self,
        "first": first,
        "last": last,
      };
}

class Meta {
  Pagination pagination;

  Meta({
    required this.pagination,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination: json["pagination"] != null
          ? Pagination.fromJson(json["pagination"])
          : Pagination(
              total: 0, count: 0, perPage: 0, currentPage: 0, totalPages: 0),
    );
  }

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json["total"],
      count: json["count"],
      perPage: json["per_page"],
      currentPage: json["current_page"],
      totalPages: json["total_pages"],
    );
  }

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}
