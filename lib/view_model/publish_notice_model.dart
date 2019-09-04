import 'package:flutter_drug/provider/view_state_model.dart';

class PublishNoticeModel extends ViewStateModel {
  bool _isPublishWeChat = true;
  String _validity = "永久";

  bool get isPublishWeChat => _isPublishWeChat;
  String get validity => _validity;

  set isPublishWeChat(bool isPublish) {
    _isPublishWeChat = isPublish;
    notifyListeners();
  }

  set validity(String va) {
    _validity = va;
    notifyListeners();
  }
}