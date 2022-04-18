import 'package:enterprise/pages/home/twoSingleCard/twoSingleCard.dart';
import 'package:enterprise/pages/home/twoSingleCard/twoSingleCardLeftList.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
  twoSingleCardRouter = [
    {'/twoSingleCard/twoSingleCard': (context, {arguments}) => TwoSingleCard()},

    {'/twoSingleCard/twoSingleCardLeftList': (context, {arguments}) => TwoSingleCardLeftList(index: arguments['index'],)},
  ];