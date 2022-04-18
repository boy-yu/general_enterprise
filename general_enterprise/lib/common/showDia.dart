import 'package:flutter/material.dart';

void showDia(context, List<Widget> children, {EdgeInsets padding}) {
  showDialog(
    context: context,
    useRootNavigator: false,
    builder: (_) => SimpleDialog(
        contentPadding: padding ?? EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          // side: BorderSide(),
          borderRadius: BorderRadius.circular(10),
        ),
        children: children),
  );
}
