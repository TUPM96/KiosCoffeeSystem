import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'global_variables.g.dart';

class GlobalVariables = _GlobalVariables with _$GlobalVariables;

abstract class _GlobalVariables with Store {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}
