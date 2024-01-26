import 'package:flutter/material.dart';

class AlertDialogManager {
  Future showAlertDialog(BuildContext context, String title, String content) {
    AlertDialog buildAlertDialog(Color backgroundColor, IconData icon) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 35,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
            ),
            Text(content),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
            ),
          ),
        ],
      );
    }

    switch (title) {
      case "ok":
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
            heightFactor: 0.4,
            child: buildAlertDialog(Colors.green[700]!, Icons.check),
          ),
        );
      case "error":
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
            heightFactor: 0.4,
            child: buildAlertDialog(Colors.red[700]!, Icons.close),
          ),
        );
      default:
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
            heightFactor: 0.4,
            child: buildAlertDialog(Colors.blue[700]!, Icons.info_outline),
          ),
        );
    }
  }
}
