import 'package:toastification/toastification.dart';
import 'package:jolie/common.dart';

void successToast(BuildContext context, String message) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.simple,
    description: Text(
      message,
      style: Fonts.thin.copyWith(
        fontSize: 20,
      ),
    ),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    primaryColor: primaryColor,
    backgroundColor: primaryColor,
    foregroundColor: const Color(0xffffffff),
    borderRadius: BorderRadius.circular(100.0),
    boxShadow: highModeShadow,
    closeButtonShowType: CloseButtonShowType.none,
    applyBlurEffect: true,
    showIcon: false,
  );
}

void failureToast(BuildContext context, String message) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.simple,
    description: Text(
      message,
      style: Fonts.thin.copyWith(
        fontSize: 20,
      ),
    ),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    primaryColor: tertiaryColor,
    backgroundColor: tertiaryColor,
    foregroundColor: const Color(0xffffffff),
    borderRadius: BorderRadius.circular(100.0),
    boxShadow: highModeShadow,
    closeButtonShowType: CloseButtonShowType.none,
    applyBlurEffect: true,
    showIcon: false,
  );
}
