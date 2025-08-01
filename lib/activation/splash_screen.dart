import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/secure_storage.dart';
import '../utils/util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}




class _SplashScreenState extends State<SplashScreen> {

  List<Permission> permissionsToRequestList = [
    Permission.notification,
    Permission.storage
  ];

  Future<bool>? future;
  String _labels = 'Loading..';

  @override
  void initState() {
    super.initState();
    future = checkPermissionsAndNavigate();
  }
  Future<void> getPermissionList() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      if (sdkInt >= 33) {
        CustomLogger.logged("Android 13+");
        permissionsToRequestList = [
          // Permission.photos,
          // Permission.camera,
          // Permission.location,
          //Permission.manageExternalStorage,
          Permission.notification,
        ];
      } else {
        CustomLogger.logged("Android 13-");
        permissionsToRequestList = [
          // Permission.camera,
          // Permission.location,
          // Permission.storage,
          Permission.notification,
        ];
      }
    } else if (Platform.isIOS) {
      permissionsToRequestList = [
        // Permission.camera,
        Permission.notification,
        // Permission.photos,
        // Permission.microphone
      ];
    }
  }

  Future<bool> checkPermissionsAndNavigate() async {
    try {
      setState(() {
        _labels = "Checking permissions..";
      });
      await getPermissionList();
      bool allPermissionsGranted = await hasAllPermissions();

      if (!allPermissionsGranted) {
        allPermissionsGranted = await requestPermissions();
      }

      if (allPermissionsGranted) {
        //navigate to login or inside
        return true;
      } else {
        setState(() {
          _labels = "Permissions not granted";
        });
        if (mounted) {
          customErrorToast(
            "Required permissions not granted. Please enable them in settings.",
            context,
          );
        }
        return false;
      }
    } catch (e, stackTrace) {
      setState(() {
        _labels = "Please Check the internet Connection";
      });
      CustomLogger.logged(
          "Error checking permissions: $e\nStack trace: $stackTrace");
      String userLoggedin = await SecureStorage.instance.readSecureData(
          key: PreferenceHolders.otherDeviceLoggedIn.toString());

      return true;
    }
  }

  Future<bool> requestPermissions() async {
    try {
      List<Permission> permissionsToRequestNotGranted = [];
      for (var permission in permissionsToRequestList) {
        var status = await permission.status;
        if (status != PermissionStatus.granted) {
          // CustomLogger.logged(status.name);
          CustomLogger.logged('Permission not found $permission');
          // CustomLogger.logged(status.toString());
          permissionsToRequestNotGranted.add(permission);
        } else {
          CustomLogger.logged(permission.value.toString());
        }
      }
      CustomLogger.logged(
          "Permissions not granted: ${permissionsToRequestNotGranted.length}");
      await permissionsToRequestNotGranted.request();
      return await hasAllPermissions();
    } catch (e) {
      CustomLogger.logged("Error requesting permissions: $e");
      return false;
    }
  }

  Future<bool> hasAllPermissions() async {
    List<Permission> permissionsToCheck = List.from(permissionsToRequestList);
    if (Platform.isIOS) {
      permissionsToCheck.remove(Permission.notification);
    }
    for (var permission in permissionsToCheck) {
      if (await permission.status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/splash_wallet.json',
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
  }
}

