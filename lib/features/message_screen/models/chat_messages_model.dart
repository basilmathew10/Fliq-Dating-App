class ChatMessagesModel {
    List<Datum>? data;
    List<Included>? included;
    Meta? meta;
    Links? links;

    ChatMessagesModel({
        this.data,
        this.included,
        this.meta,
        this.links,
    });

    factory ChatMessagesModel.fromJson(Map<String, dynamic> json) => ChatMessagesModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        included: json["included"] == null ? [] : List<Included>.from(json["included"]!.map((x) => Included.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "included": included == null ? [] : List<dynamic>.from(included!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
        "links": links?.toJson(),
    };
}

class Datum {
    String? type;
    String? id;
    DatumAttributes? attributes;
    Relationships? relationships;

    Datum({
        this.type,
        this.id,
        this.attributes,
        this.relationships,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        id: json["id"],
        attributes: json["attributes"] == null ? null : DatumAttributes.fromJson(json["attributes"]),
        relationships: json["relationships"] == null ? null : Relationships.fromJson(json["relationships"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes?.toJson(),
        "relationships": relationships?.toJson(),
    };
}

class DatumAttributes {
    int? chatThreadId;
    int? chatMessageTypeId;
    int? senderId;
    int? receiverId;
    String? message;
    dynamic mediaMeta;
    bool? isOneTimeView;
    bool? isOnVanishMode;
    dynamic scheduledAt;
    DateTime? sentAt;
    DateTime? deliveredAt;
    dynamic viewedAt;
    dynamic stickerId;
    dynamic giftOrderId;
    dynamic senderCoinTransactionId;
    dynamic receiverCoinTransactionId;
    dynamic transferCoins;
    dynamic deletedForSenderBy;
    dynamic deletedForSenderAt;
    dynamic deletedForReceiverBy;
    dynamic deletedForReceiverAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    dynamic mediaUrl;

    DatumAttributes({
        this.chatThreadId,
        this.chatMessageTypeId,
        this.senderId,
        this.receiverId,
        this.message,
        this.mediaMeta,
        this.isOneTimeView,
        this.isOnVanishMode,
        this.scheduledAt,
        this.sentAt,
        this.deliveredAt,
        this.viewedAt,
        this.stickerId,
        this.giftOrderId,
        this.senderCoinTransactionId,
        this.receiverCoinTransactionId,
        this.transferCoins,
        this.deletedForSenderBy,
        this.deletedForSenderAt,
        this.deletedForReceiverBy,
        this.deletedForReceiverAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.mediaUrl,
    });

    factory DatumAttributes.fromJson(Map<String, dynamic> json) => DatumAttributes(
        chatThreadId: json["chat_thread_id"],
        chatMessageTypeId: json["chat_message_type_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        mediaMeta: json["media_meta"],
        isOneTimeView: json["is_one_time_view"],
        isOnVanishMode: json["is_on_vanish_mode"],
        scheduledAt: json["scheduled_at"],
        sentAt: json["sent_at"] == null ? null : DateTime.parse(json["sent_at"]),
        deliveredAt: json["delivered_at"] == null ? null : DateTime.parse(json["delivered_at"]),
        viewedAt: json["viewed_at"],
        stickerId: json["sticker_id"],
        giftOrderId: json["gift_order_id"],
        senderCoinTransactionId: json["sender_coin_transaction_id"],
        receiverCoinTransactionId: json["receiver_coin_transaction_id"],
        transferCoins: json["transfer_coins"],
        deletedForSenderBy: json["deleted_for_sender_by"],
        deletedForSenderAt: json["deleted_for_sender_at"],
        deletedForReceiverBy: json["deleted_for_receiver_by"],
        deletedForReceiverAt: json["deleted_for_receiver_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        mediaUrl: json["media_url"],
    );

    Map<String, dynamic> toJson() => {
        "chat_thread_id": chatThreadId,
        "chat_message_type_id": chatMessageTypeId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "media_meta": mediaMeta,
        "is_one_time_view": isOneTimeView,
        "is_on_vanish_mode": isOnVanishMode,
        "scheduled_at": scheduledAt,
        "sent_at": sentAt?.toIso8601String(),
        "delivered_at": deliveredAt?.toIso8601String(),
        "viewed_at": viewedAt,
        "sticker_id": stickerId,
        "gift_order_id": giftOrderId,
        "sender_coin_transaction_id": senderCoinTransactionId,
        "receiver_coin_transaction_id": receiverCoinTransactionId,
        "transfer_coins": transferCoins,
        "deleted_for_sender_by": deletedForSenderBy,
        "deleted_for_sender_at": deletedForSenderAt,
        "deleted_for_receiver_by": deletedForReceiverBy,
        "deleted_for_receiver_at": deletedForReceiverAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "media_url": mediaUrl,
    };
}

class Relationships {
    GiftOrder? sender;
    GiftOrder? sticker;
    GiftOrder? giftOrder;

    Relationships({
        this.sender,
        this.sticker,
        this.giftOrder,
    });

    factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        sender: json["sender"] == null ? null : GiftOrder.fromJson(json["sender"]),
        sticker: json["sticker"] == null ? null : GiftOrder.fromJson(json["sticker"]),
        giftOrder: json["giftOrder"] == null ? null : GiftOrder.fromJson(json["giftOrder"]),
    );

    Map<String, dynamic> toJson() => {
        "sender": sender?.toJson(),
        "sticker": sticker?.toJson(),
        "giftOrder": giftOrder?.toJson(),
    };
}

class GiftOrder {
    Data? data;

    GiftOrder({
        this.data,
    });

    factory GiftOrder.fromJson(Map<String, dynamic> json) => GiftOrder(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        id: json["id"],
    );

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

    factory Included.fromJson(Map<String, dynamic> json) => Included(
        type: json["type"],
        id: json["id"],
        attributes: json["attributes"] == null ? null : IncludedAttributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes?.toJson(),
    };
}

class IncludedAttributes {
    String? name;
    String? username;
    String? email;
    String? profilePhotoUrl;
    String? square100ProfilePhotoUrl;
    String? square300ProfilePhotoUrl;
    String? square500ProfilePhotoUrl;
    dynamic age;

    IncludedAttributes({
        this.name,
        this.username,
        this.email,
        this.profilePhotoUrl,
        this.square100ProfilePhotoUrl,
        this.square300ProfilePhotoUrl,
        this.square500ProfilePhotoUrl,
        this.age,
    });

    factory IncludedAttributes.fromJson(Map<String, dynamic> json) => IncludedAttributes(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        profilePhotoUrl: json["profile_photo_url"],
        square100ProfilePhotoUrl: json["square100_profile_photo_url"],
        square300ProfilePhotoUrl: json["square300_profile_photo_url"],
        square500ProfilePhotoUrl: json["square500_profile_photo_url"],
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "profile_photo_url": profilePhotoUrl,
        "square100_profile_photo_url": square100ProfilePhotoUrl,
        "square300_profile_photo_url": square300ProfilePhotoUrl,
        "square500_profile_photo_url": square500ProfilePhotoUrl,
        "age": age,
    };
}

class Links {
    String? self;
    String? first;
    String? next;
    String? last;

    Links({
        this.self,
        this.first,
        this.next,
        this.last,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        first: json["first"],
        next: json["next"],
        last: json["last"],
    );

    Map<String, dynamic> toJson() => {
        "self": self,
        "first": first,
        "next": next,
        "last": last,
    };
}

class Meta {
    Pagination? pagination;

    Meta({
        this.pagination,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
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

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
    };
}