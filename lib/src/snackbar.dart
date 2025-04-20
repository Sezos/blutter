import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showSnackMsg(
  String message,
  BuildContext context, {
  String type = "info",
  Function? action,
  Duration? duration,
}) {
  switch (type) {
    case "success":
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(message: message, maxLines: 5),
        displayDuration: duration ?? const Duration(milliseconds: 500),
        animationDuration:
            duration != null
                ? duration * 2
                : const Duration(milliseconds: 1000),
      );
      break;
    case "error":
      showDialogPro(
        "Oops...",
        message,
        context,
        type: "error",
        onOkButton: action,
      );
      break;
    case "errorPro":
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: message, maxLines: 5),
        displayDuration: duration ?? const Duration(milliseconds: 500),
        animationDuration:
            duration != null
                ? duration * 2
                : const Duration(milliseconds: 1000),
      );
      break;

    case "warning":
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          message: message,
          maxLines: 5,
          backgroundColor: Colors.yellowAccent,
          textStyle: const TextStyle(color: Colors.black),
        ),
        displayDuration: duration ?? const Duration(milliseconds: 500),
        animationDuration:
            duration != null
                ? duration * 2
                : const Duration(milliseconds: 1000),
      );
      break;
    default:
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          icon: const Icon(
            Icons.sentiment_satisfied_alt,
            color: Color(0x15000000),
            size: 120,
          ),
          maxLines: 5,
          message: message,
        ),
        displayDuration: duration ?? const Duration(milliseconds: 500),
        animationDuration:
            duration != null
                ? duration * 2
                : const Duration(milliseconds: 1000),
      );
  }
}

void showDialogPro(
  String title,
  String body,
  BuildContext context, {
  String type = "info",
  String btnOkText = "OK",
  String btnCancelText = "Cancel",
  Color btnOkColor = Colors.blue,
  Color btnCancelColor = Colors.grey,
  onOkButton,
  onCancelButton,
}) {
  DialogType tt;

  switch (type) {
    case "info":
      tt = DialogType.info;
      break;
    case "success":
      tt = DialogType.success;
      break;
    case "error":
      tt = DialogType.error;
      break;
    case "warning":
      tt = DialogType.warning;
      break;
    default:
      tt = DialogType.info;
      break;
  }

  AwesomeDialog(
    context: context,
    dialogType: tt,
    animType: AnimType.rightSlide,
    title: title,
    desc: body,
    btnOkText: btnOkText,
    btnCancelText: btnCancelText,
    btnOkColor: btnOkColor,
    btnCancelColor: btnCancelColor,
    btnCancelOnPress: onCancelButton,
    btnOkOnPress: onOkButton ?? () {},
  ).show();
}
