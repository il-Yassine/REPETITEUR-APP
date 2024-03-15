// role_provider.dart

import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/role/role_model.dart';

class RoleProvider extends ChangeNotifier {
  Role? _selectedRole;

  Role? get selectedRole => _selectedRole;

  void setSelectedRole(Role role) {
    _selectedRole = role;
    notifyListeners();
  }
}
