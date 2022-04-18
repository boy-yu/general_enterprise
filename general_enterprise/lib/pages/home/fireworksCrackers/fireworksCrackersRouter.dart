import 'package:enterprise/pages/home/fireworksCrackers/___productDeliveryRecord.dart';
import 'package:enterprise/pages/home/fireworksCrackers/___warehousingDeliveryRecord.dart';
import 'package:enterprise/pages/home/fireworksCrackers/__ewmOutPutInStorage.dart';
import 'package:enterprise/pages/home/fireworksCrackers/__orderFormDetails.dart';
import 'package:enterprise/pages/home/fireworksCrackers/__productDetails.dart';
import 'package:enterprise/pages/home/fireworksCrackers/__supplierDetails.dart';
import 'package:enterprise/pages/home/fireworksCrackers/__warehouseDetails.dart';
import 'package:enterprise/pages/home/fireworksCrackers/_fireworksCrackersLeftList.dart';
import 'package:enterprise/pages/home/fireworksCrackers/fireworksCrackers.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    fireworksCrackersRouter = [
  {'/fireworksCrackers/fireworksCrackers': (context, {arguments}) => FireworksCrackers()},

  {'/fireworksCrackers/fireworksCrackersLeftList': (context, {arguments}) => FireworksCrackersLeftList(
    index: arguments['index'],
  )},
  
  {'/fireworksCrackers/productDetails': (context, {arguments}) => ProductDetails(
    id: arguments['id'],
  )},

  {'/fireworksCrackers/productDeliveryRecord': (context, {arguments}) => ProductDeliveryRecord(
    id: arguments['id'],
  )},

  {'/fireworksCrackers/warehousingDeliveryRecord': (context, {arguments}) => WarehousingDeliveryRecord(
    id: arguments['id'],
  )},

  {'/fireworksCrackers/warehouseDetails': (context, {arguments}) => WarehouseDetails(
    data: arguments['data']
  )},

  {'/fireworksCrackers/supplierDetails': (context, {arguments}) => SupplierDetails(
    data: arguments['data']
  )},
  
  {'/fireworksCrackers/orderFormDetails': (context, {arguments}) => OrderFormDetails(
    id: arguments['id'],
  )},

  {'/fireworksCrackers/ewmOutPutInStorage': (context, {arguments}) => EwmOutPutInStorage(
    warehouse: arguments['warehouse'],
  )},
  
];
