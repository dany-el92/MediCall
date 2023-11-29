import 'package:medicall/main.dart';
import 'package:permission_handler/permission_handler.dart';

class GetPermissions {
  static Future<bool> getCameraPermission() async {
    PermissionStatus permissionStatus = await Permission.camera.status;

    if (permissionStatus.isGranted) {
      return true;
    } else if (permissionStatus.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      if (status.isGranted) {
        return true;
      } else {
        SnackBarService.showSnackBar(content: 'Permesso camera richiesto');
        return false;
      }
    }
    return false;
  }

  static Future<bool> getStoragePermission() async {
    PermissionStatus permissionStatus = await Permission.storage.status;

    if (permissionStatus.isGranted) {
      return true;
    } else if (permissionStatus.isDenied) {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else {
        SnackBarService.showSnackBar(content: 'Permesso memoria richiesto');
        return false;
      }
    }
    return false;
  }
}
