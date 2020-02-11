// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  final _$isShowAdmobAtom = Atom(name: '_AppStore.isShowAdmob');

  @override
  bool get isShowAdmob {
    _$isShowAdmobAtom.context.enforceReadPolicy(_$isShowAdmobAtom);
    _$isShowAdmobAtom.reportObserved();
    return super.isShowAdmob;
  }

  @override
  set isShowAdmob(bool value) {
    _$isShowAdmobAtom.context.conditionallyRunInAction(() {
      super.isShowAdmob = value;
      _$isShowAdmobAtom.reportChanged();
    }, _$isShowAdmobAtom, name: '${_$isShowAdmobAtom.name}_set');
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  void setAdmob(bool isShowAdmob) {
    final _$actionInfo = _$_AppStoreActionController.startAction();
    try {
      return super.setAdmob(isShowAdmob);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool getAdmob() {
    final _$actionInfo = _$_AppStoreActionController.startAction();
    try {
      return super.getAdmob();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }
}
