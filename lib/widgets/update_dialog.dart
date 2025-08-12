import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/app_update_service.dart';

class UpdateDialog extends StatelessWidget {
  final UpdateType updateType;
  final String currentVersion;
  final String latestVersion;
  final String message;
  final VoidCallback onUpdate;
  final VoidCallback? onLater;

  const UpdateDialog({
    Key? key,
    required this.updateType,
    required this.currentVersion,
    required this.latestVersion,
    required this.message,
    required this.onUpdate,
    this.onLater,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isForceUpdate = updateType == UpdateType.required;
    final bool isMaintenance = updateType == UpdateType.maintenance;
    
    return WillPopScope(
      onWillPop: () async => !isForceUpdate && !isMaintenance,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Column(
          children: [
            Icon(
              isMaintenance 
                  ? Icons.construction 
                  : Icons.system_update,
              size: 48,
              color: isMaintenance 
                  ? Colors.orange 
                  : Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 12),
            Text(
              isMaintenance 
                  ? '서버 점검 안내' 
                  : isForceUpdate 
                      ? '필수 업데이트' 
                      : '업데이트 안내',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isMaintenance) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '현재 버전',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'v$currentVersion',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.grey[400],
                    ),
                    Column(
                      children: [
                        Text(
                          '최신 버전',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'v$latestVersion',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            if (isForceUpdate) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber,
                      color: Colors.red[700],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '업데이트하지 않으면 앱을 사용할 수 없습니다.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: isMaintenance
            ? [
                TextButton(
                  onPressed: () {
                    // 앱 종료
                    SystemNavigator.pop();
                  },
                  child: const Text('앱 종료'),
                ),
              ]
            : [
                if (!isForceUpdate && onLater != null)
                  TextButton(
                    onPressed: onLater,
                    child: const Text('나중에'),
                  ),
                ElevatedButton(
                  onPressed: onUpdate,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(isForceUpdate ? '지금 업데이트' : '업데이트'),
                ),
              ],
      ),
    );
  }
}

// 업데이트 다이얼로그 표시 헬퍼 함수
Future<void> showUpdateDialog(
  BuildContext context,
  AppUpdateService updateService,
) async {
  final updateType = updateService.updateType;
  
  if (updateType == UpdateType.none) return;
  
  final String message = updateType == UpdateType.maintenance
      ? updateService.maintenanceMessage
      : updateService.updateMessage;
  
  await showDialog(
    context: context,
    barrierDismissible: updateType == UpdateType.optional,
    builder: (context) => UpdateDialog(
      updateType: updateType,
      currentVersion: updateService.currentVersion,
      latestVersion: updateService.latestVersion,
      message: message,
      onUpdate: () async {
        await updateService.navigateToStore();
        if (updateType == UpdateType.required) {
          // 강제 업데이트의 경우 앱 종료
          SystemNavigator.pop();
        } else {
          Navigator.of(context).pop();
        }
      },
      onLater: updateType == UpdateType.optional
          ? () => Navigator.of(context).pop()
          : null,
    ),
  );
}