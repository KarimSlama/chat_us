import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
} //end navigateTo()

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Widget textForm({
  required TextInputType inputType,
  required TextEditingController controller,
  FormFieldValidator<String>? validate,
  Function? onSubmit,
  required String label,
  bool isPassword = false,
  int? maxLength,
  required IconData prefixIcon,
  double? height,
  double? width,
  Color color = Colors.white,
  double radius = 15.0,
  IconData? suffixIcon,
  Function? suffixPressed,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        keyboardType: inputType,
        controller: controller,
        validator: validate,
        obscureText: isPassword,
        maxLength: maxLength,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          fillColor: Colors.black,
          labelText: label,
          labelStyle: TextStyle(
            color: color,
            fontSize: 16.0,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: color,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(suffixIcon, color: Colors.black),
                )
              : null,
        ),
        onFieldSubmitted: (value) {
          onSubmit!(value);
        },
      ),
    );

Widget mainButton({
  required Function onPressed,
  required String text,
  double? width,
  double? minWidth,
  double? height,
  double radius = 20.0,
  bool isUpper = false,
  double fontSize = 18.0,
  Color? color,
  Color textColor = Colors.black,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        minWidth: minWidth,
        onPressed: () {
          onPressed();
        },
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );

void showToast({
  required String toastText,
  required ToastBackgroundColor state,
}) =>
    Fluttertoast.showToast(
      msg: toastText,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: toastBackground(state),
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
      fontSize: 16.0,
    );

Widget divider () => Container(height: 1, width: 300.0, color: Colors.grey[200]);

enum ToastBackgroundColor { SUCCESS, ERROR, WARNING }

Color toastBackground(ToastBackgroundColor state) {
  Color color;

  switch (state) {
    case ToastBackgroundColor.SUCCESS:
      color = Colors.green;
      break;
    case ToastBackgroundColor.ERROR:
      color = Colors.red;
      break;
    case ToastBackgroundColor.WARNING:
      color = Colors.cyan;
      break;
  }
  return color;
}
