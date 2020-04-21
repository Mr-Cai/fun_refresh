import 'package:flutter/material.dart';

class ItemD {
  ItemD({@required this.title, @required this.iconPath});
  final String title;
  final String iconPath;
}

class LangItem {
  LangItem({@required this.langName, this.index});
  final String langName;
  final int index;
}

class NavItemBTM {
  NavItemBTM({this.text, this.iconPath});
  final String text;
  final String iconPath;
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

// 用户资料
class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

// 提供详情
class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}