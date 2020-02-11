import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'AppStore.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isShowAdmob = false;

  @action
  void setAdmob(bool isShowAdmob) {
    this.isShowAdmob = isShowAdmob;
  }

  @action
  bool getAdmob() {
    return this.isShowAdmob;
  }

  // @action
  // Future<void> setRingtonesSharedP(List<Ringtone> ls) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> listStr = new List<String>();

  //   for (final f in ls) {
  //     Ringtone r = Ringtone.fromJson(f.toJsonSharedP());
  //     listStr.add(jsonEncode(r.toJsonSharedP()));
  //   }

  //   prefs.remove("savedRingtone");
  //   await prefs.setStringList('savedRingtone', listStr);
  // }

  // @action
  // Future<void> getRingtonesSharedP() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> list = prefs.getStringList('savedRingtone') ?? null;
  //   listSaved.clear();
  //   if (list != null) {
  //     list.forEach((f) => listSaved.add(Ringtone.fromJsonSharedP(jsonDecode(f))));
  //   }
  // }
}

final AppStore store = new AppStore();
