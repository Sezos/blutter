import 'package:blutter/src/constants.dart';
import 'package:blutter/src/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class PopUpDialog extends StatelessWidget {
  PopUpDialog(
    this.titleText,
    this.bodyText,
    this.buttonText,
    this.popupStyle,
    this.onTap, {
    super.key,
    this.buttonText2 = '',
    VoidCallback? onTap2,
  }) : onTap2 = onTap2 ?? (() {});

  final String titleText;
  final String bodyText;
  final String buttonText;
  final String buttonText2;
  final PopupStyles popupStyle;
  final VoidCallback onTap;
  final VoidCallback onTap2;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      insetPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      backgroundColor: getBackroundColor(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: getIcon()),
            const SizedBox(height: 20),
            Text(
              titleText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(
              bodyText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(137, 137, 137, 1),
              ),
            ),
            const SizedBox(height: 20),
            getRoundButton(context),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget getRoundButton(BuildContext context) {
    if (buttonText2 == '') {
      return MoonFilledButton(
        label: BText(buttonText),
        onTap: onTap,
      ).withHaptic();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MoonOutlinedButton(
          label: BText(buttonText),
          onTap: onTap,
          width: MediaQuery.of(context).size.width * 0.35,
        ).withHaptic(),
        MoonFilledButton(
          label: BText(buttonText2),
          onTap: onTap2,
          width: MediaQuery.of(context).size.width * 0.35,
        ).withHaptic(),
      ],
    );
  }

  Color getBackroundColor() {
    return Colors.white;
  }

  Widget getIcon() {
    Icon icon;
    switch (popupStyle) {
      case PopupStyles.success:
        icon = const Icon(
          Icons.check,
          size: 30,
          color: Color.fromRGBO(34, 171, 148, 1),
        );
        break;
      case PopupStyles.alert:
        icon = const Icon(Icons.priority_high, size: 30, color: Colors.white);
        break;
      case PopupStyles.warning:
        icon = const Icon(Icons.swipe, size: 30, color: Colors.white);
        break;
      case PopupStyles.confirm:
        icon = const Icon(
          Icons.info_outline,
          size: 30,
          color: Color.fromRGBO(41, 98, 255, 1),
        );
        break;
    }
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: switch (popupStyle) {
          PopupStyles.success => const Color.fromRGBO(233, 247, 244, 1),
          PopupStyles.confirm => const Color.fromRGBO(234, 239, 255, 1),
          _ => const Color.fromRGBO(233, 247, 244, 1),
        },
        shape: BoxShape.circle,
      ),
      child: icon,
    );
  }
}

enum PopupStyles { success, alert, warning, confirm }
