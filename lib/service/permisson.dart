// import 'package:permission_handler/permission_handler.dart';

// class PermissionService {
//   Future<void> requestPermissions() async {
//     var status = await Permission.camera.status;
//     if (!status.isGranted) {
//       await Permission.camera.request();
//     }

//     status = await Permission.storage.status;
//     if (!status.isGranted) {
//       await Permission.storage.request();
//     }
//   }
// }