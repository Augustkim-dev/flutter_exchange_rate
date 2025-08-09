import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PermissionService {
  /// 위치 권한 상태를 확인합니다.
  static Future<LocationPermission> checkLocationPermission() async {
    return await Geolocator.checkPermission();
  }

  /// 위치 권한을 요청합니다.
  static Future<LocationPermission> requestLocationPermission() async {
    return await Geolocator.requestPermission();
  }

  /// 위치 서비스가 활성화되어 있는지 확인합니다.
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// 위치 서비스 설정으로 이동하는 다이얼로그를 표시합니다.
  static Future<bool> showLocationServiceDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('위치 서비스 필요'),
              content: Text('위치 기반 통화 감지를 위해 위치 서비스가 필요합니다. 설정에서 위치 서비스를 활성화해주세요.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                    await Geolocator.openLocationSettings();
                  },
                  child: Text('설정으로 이동'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// 위치 권한이 거부된 경우 다이얼로그를 표시합니다.
  static Future<bool> showPermissionDeniedDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('위치 권한 필요'),
              content: Text('위치 기반 통화 감지를 위해 위치 권한이 필요합니다. 앱 설정에서 위치 권한을 허용해주세요.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                    await Geolocator.openAppSettings();
                  },
                  child: Text('설정으로 이동'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// 위치 권한이 영구적으로 거부된 경우 다이얼로그를 표시합니다.
  static Future<bool> showPermissionPermanentlyDeniedDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('위치 권한 거부됨'),
              content: Text('위치 권한이 영구적으로 거부되었습니다. 앱 설정에서 위치 권한을 수동으로 허용해주세요.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                    await Geolocator.openAppSettings();
                  },
                  child: Text('설정으로 이동'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// 위치 권한 요청 다이얼로그를 표시합니다.
  static Future<bool> showPermissionRequestDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('위치 권한 요청'),
              content: Text('위치 기반 통화 감지를 위해 위치 권한이 필요합니다. 권한을 허용하시겠습니까?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('거부'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('허용'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
