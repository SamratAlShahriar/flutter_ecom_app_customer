import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';

const String collectionUsers = 'Users';
const String userFieldUserId = 'user_id';
const String userFieldUserDisplayName = 'user_display_name';
const String userFieldUserAddress = 'user_address';
const String userFieldUserCreationTime = 'user_creation_time';
const String userFieldUserImageUrl = 'user_image_url';
const String userFieldUserGender = 'user_gender';
const String userFieldUserDOB = 'user_dob';
const String userFieldUserPhone = 'user_phone';
const String userFieldUserEmail = 'user_email';

class UserModel {
  String? userId;
  String? displayName;
  AddressModel? addressModel;
  Timestamp? userCreationTime;
  String? userImageUrl;
  String? gender;
  String? dob;
  String? phone;
  String email;

  UserModel({
    this.userId,
    this.displayName,
    this.addressModel,
    this.userCreationTime,
    this.userImageUrl,
    this.gender,
    this.dob,
    this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      userFieldUserId: userId,
      userFieldUserDisplayName: displayName,
      userFieldUserAddress: addressModel?.toMap(),
      userFieldUserCreationTime: userCreationTime,
      userFieldUserImageUrl: userImageUrl,
      userFieldUserGender: gender,
      userFieldUserDOB: dob,
      userFieldUserPhone: phone,
      userFieldUserEmail: email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map[userFieldUserId],
      displayName: map[userFieldUserDisplayName],
      addressModel: map[userFieldUserAddress] == null
          ? null
          : AddressModel.fromMap(map[userFieldUserAddress]),
      userCreationTime: map[userFieldUserCreationTime],
      userImageUrl: map[userFieldUserImageUrl],
      gender: map[userFieldUserGender],
      dob: map[userFieldUserDOB],
      phone: map[userFieldUserPhone],
      email: map[userFieldUserEmail],
    );
  }
}
