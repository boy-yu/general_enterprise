import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/riskHierarchicalControl/riskIdentifyTask/riskIdentifyTask.dart';
import 'package:enterprise/pages/riskHierarchicalControl/safetyRiskList/safetyRiskList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class RiskHierarchicalControl extends StatefulWidget {
  @override
  State<RiskHierarchicalControl> createState() => _RiskHierarchicalControlState();
}

class _RiskHierarchicalControlState extends State<RiskHierarchicalControl> {
  int chooseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Container(
        height: size.width * 72,
        width: size.width * 488,
        decoration: BoxDecoration(
          color: Color(0xff1E62EB),
          borderRadius: BorderRadius.all(Radius.circular(size.width * 46))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                chooseIndex = 0;
                setState(() {});
              },
              child: Container(
                height: size.width * 64,
                width: size.width * 240,
                alignment: Alignment.center,
                decoration: chooseIndex == 0 ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(size.width * 46))
                ) : null,
                child: Text(
                  '风险辨识任务',
                  style: TextStyle(
                    fontSize: size.width * 28,
                    color: chooseIndex == 0 ? Color(0xff3074FF) : Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                chooseIndex = 1;
                setState(() {});
              },
              child: Container(
                height: size.width * 64,
                width: size.width * 240,
                alignment: Alignment.center,
                decoration: chooseIndex == 1 ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(size.width * 46))
                ) : null,
                child: Text(
                  '安全风险清单',
                  style: TextStyle(
                    fontSize: size.width * 28,
                    color: chooseIndex == 1 ? Color(0xff3074FF) : Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      child: chooseIndex == 0 ? RiskIdentifyTask() : SafetyRiskList()
    );
  }
}