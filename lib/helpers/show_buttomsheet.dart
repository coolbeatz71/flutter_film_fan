import 'package:flutter/material.dart';
import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/views/widgets/shared/bottomsheet.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';

class Utils {
  Utils();

  Utils.showBottomSheet(BuildContext context, int movieId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BottomSheetContainer(movieId: movieId),
    );
  }

  static void showToast({
    @required String message,
    bool success = true,
    toastGravity = ToastGravity.BOTTOM,
  }) {
    FlutterFlexibleToast.showToast(
      message: message,
      toastLength: Toast.LENGTH_LONG,
      toastGravity: toastGravity,
      icon: ICON.SUCCESS,
      radius: 10,
      elevation: 0,
      imageSize: 16,
      textColor: Colors.white,
      backgroundColor: success ? AppColors.greenAccent : Colors.red,
      timeInSeconds: 2,
    );
  }
}
