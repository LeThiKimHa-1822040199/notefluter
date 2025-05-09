import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_project/project/model/task_provider.dart';
import 'package:app_project/project/view/login_screen.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => TaskProvider(),
    child: MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    ),
  ),
);