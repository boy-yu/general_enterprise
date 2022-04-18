import 'package:enterprise/pages/home/education/My/StudyPlanList.dart';
import 'package:enterprise/pages/home/education/My/_____offLineYearPersonList.dart';
import 'package:enterprise/pages/home/education/My/____yearPlanDetails.dart';
import 'package:enterprise/pages/home/education/My/____offLineYearPlanDetails.dart';
import 'package:enterprise/pages/home/education/My/___eduMyAnnualThreeLevelList.dart';
import 'package:enterprise/pages/home/education/My/__eduMyAnnualYearPlan.dart';
import 'package:enterprise/pages/home/education/My/_assessmentDetail.dart';
import 'package:enterprise/pages/home/education/My/_chooseTextBook.dart';
import 'package:enterprise/pages/home/education/My/_eduMyAnnualPlan.dart';
import 'package:enterprise/pages/home/education/My/_examinePersonList.dart';
import 'package:enterprise/pages/home/education/My/assessment.dart';
import 'package:enterprise/pages/home/education/My/demand.dart';
import 'package:enterprise/pages/home/education/My/lineSendStudyPlan.dart';
import 'package:enterprise/pages/home/education/My/commonVideoList.dart';
import 'package:enterprise/pages/home/education/My/styduPlanDetail.dart';
import 'package:enterprise/pages/home/education/My/train.dart';
import 'package:enterprise/pages/home/education/______eduQuestionLibrary.dart';
import 'package:enterprise/pages/home/education/_____eduFormulateExamQuestions.dart';
import 'package:enterprise/pages/home/education/____eduInitiateStudyPlan.dart';
import 'package:enterprise/pages/home/education/____eduMyPlanHistoryList.dart';
import 'package:enterprise/pages/home/education/____myPlanFlowDetails.dart';
import 'package:enterprise/pages/home/education/____styduOfflinePlanDetail.dart';
import 'package:enterprise/pages/home/education/___eduAddDep.dart';
import 'package:enterprise/pages/home/education/___eduAddExam.dart';
import 'package:enterprise/pages/home/education/___eduAddPeople.dart';
import 'package:enterprise/pages/home/education/___eduAddTextBook.dart';
import 'package:enterprise/pages/home/education/___eduClassHours.dart';
import 'package:enterprise/pages/home/education/___eduCollectList.dart';
import 'package:enterprise/pages/home/education/___eduMyHistoryPlanList.dart';
import 'package:enterprise/pages/home/education/___eduMySponsorPlan.dart';
// import 'package:enterprise/pages/home/education/___eduSponsorPlan.dart';
import 'package:enterprise/pages/home/education/___educationDatabase.dart';
import 'package:enterprise/pages/home/education/___educationDatabaseMSDS.dart';
import 'package:enterprise/pages/home/education/__eduMyAddNeedQuestionnaire.dart';
import 'package:enterprise/pages/home/education/__eduMyHistoryTextbook.dart';
import 'package:enterprise/pages/home/education/__eduMyTrainFile.dart';
import 'package:enterprise/pages/home/education/__eduTextbookList.dart';
import 'package:enterprise/pages/home/education/__educationDatabaseList.dart';
import 'package:enterprise/pages/home/education/_eduHaveParticipatedAloneList.dart';
import 'package:enterprise/pages/home/education/_eduHaveParticipatedList.dart';
import 'package:enterprise/pages/home/education/_eduMy.dart';
import 'package:enterprise/pages/home/education/_eduPlanList.dart';
import 'package:enterprise/pages/home/education/_eduTextbookType.dart';
import 'package:enterprise/pages/home/education/_educationKnowledgeBase.dart';
import 'package:enterprise/pages/home/education/_notInvolvedPersonList.dart';
import 'package:enterprise/pages/home/education/_webActiveControl.dart';
import 'package:enterprise/pages/home/education/eduPlayback/eduPlaybackTextBook.dart';
// import 'package:enterprise/pages/home/education/eduTrainCalendar/eduTrainCalendar.dart';
// import 'package:enterprise/pages/home/education/eduTrainLive/eduTrainLive.dart';
import 'package:enterprise/pages/home/education/education.dart';
import 'package:enterprise/pages/home/education/exam/__examSpotPic.dart';
import 'package:enterprise/pages/home/education/exam/_eduCheckExamLedgerDetails.dart';
import 'package:enterprise/pages/home/education/exam/mokExam.dart';
import 'package:enterprise/pages/home/education/exam/study.dart';
import 'package:enterprise/pages/home/education/exam/sumbit.dart';
import 'package:enterprise/pages/home/education/planHistory/___eduPlanList.dart';
import 'package:flutter/material.dart';

import '___eduYearExaminatioEvaluation.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    educationRouter = [
  {'/home/education/education': (context, {arguments}) => Education()},

  // // 培训日历
  // {
  //   '/home/education/eduTrainCalendar': (context, {arguments}) =>
  //       EduTrainCalendar()
  // },

  // // 教育培训直播
  // {
  //   '/home/education/eduTrainLive': (context, {arguments}) =>
  //       EduTrainLive()
  // },

  {
    '/home/education/educationKnowledgeBase': (context, {arguments}) =>
        EducationKnowledgeBase()
  },
  {
    '/home/education/educationDatabaseList': (context, {arguments}) =>
        EducationDatabaseList(
          title: arguments['title'],
          kBIndex: arguments['kBIndex'],
        )
  },
  {
    '/home/education/educationDatabase': (context, {arguments}) =>
        EducationDatabase(
          name: arguments['name'],
          kBIndex: arguments['kBIndex'],
        )
  },
  {
    '/home/education/educationDatabaseMSDS': (context, {arguments}) =>
        EducationDatabaseMSDS(
          name: arguments['name'],
          kBIndex: arguments['kBIndex'],
          callback: arguments['callback'],
        )
  },
  {
    '/home/education/eduPlanList': (context, {arguments}) => EduPlanList(
        // name: arguments['name'],
        // kBIndex: arguments['kBIndex'],
        // callback: arguments['callback'],
        )
  },
  {
    '/home/education/eduTextbookType': (context, {arguments}) =>
        EduTextbookType(boxData: arguments["boxData"])
  },
  {
    '/home/education/eduTextbookList': (context, {arguments}) =>
        EduTextbookList(id: arguments["id"])
  },
  {
    '/home/education/eduMy': (context, {arguments}) => EduMy(
        // name: arguments['name'],
        // kBIndex: arguments['kBIndex'],
        // callback: arguments['callback'],
        )
  },
  {'/home/education/planHistoryList': (context, {arguments}) => EduPlanList()},
  {'/home/education/planList': (context, {arguments}) => EduMyPlanList(
    planId: arguments['id']
  )},
  {'/home/education/styduPlanList': (context, {arguments}) => StudyPlanList()},
  {
    '/home/education/lineSendStudyPlan': (context, {arguments}) =>
        LineSendStudyPlan()
  },
  {
    '/home/education/styduPlanDetail': (context, {arguments}) =>
        StyduPlanDetail(
          planId: arguments["planId"],
          source: arguments["source"],
        )
  },
  {'/home/education/myDemandList': (context, {arguments}) => EduDemandList(
    id: arguments["id"],
  )},
  // common video list
  {
    '/home/education/myDemandStyduPlan': (context, {arguments}) =>
        DemanVideoList(
          title: arguments["title"],
          widget: arguments['widget'],
          data: arguments['data'],
        )
  },
  {
    '/home/education/myDemandAssessment': (context, {arguments}) =>
        DemandAssessMent(
          planId: arguments['planId']
        )
  },
  {
    '/home/education/eduMyHistoryTextbook': (context, {arguments}) =>
        EduMyHistoryTextbook(
            // name: arguments['name'],
            // kBIndex: arguments['kBIndex'],
            // callback: arguments['callback'],
            )
  },
  {
    '/home/education/eduMyHistoryPlanList': (context, {arguments}) =>
        EduMyHistoryPlanList(
            planId: arguments['planId'],
            title: arguments['title'],
            // kBIndex: arguments['kBIndex'],
            // callback: arguments['callback'],
            )
  },
  {
    '/home/education/eduMyAddNeedQuestionnaire': (context, {arguments}) =>
        EduMyAddNeedQuestionnaire(
            // name: arguments['name'],
            // kBIndex: arguments['kBIndex'],
            // callback: arguments['callback'],
            )
  },
  {
    '/home/education/eduAddTextBook': (context, {arguments}) => EduAddTextBook(
        educationTrainingResources: arguments['educationTrainingResources'],
        // kBIndex: arguments['kBIndex'],
        // callback: arguments['callback'],
        )
  },
  // {
  //   '/home/education/eduAddNewDepartment': (context, {arguments}) =>
  //       EduAddNewDepartment(
  //           // name: arguments['name'],
  //           // kBIndex: arguments['kBIndex'],
  //           // callback: arguments['callback'],
  //           )
  // },
  {
    '/home/education/eduChooseTextBook': (context, {arguments}) =>
        EduChooseTextBook()
  },
  {
    '/home/education/eduChooseTextBookTopic': (context, {arguments}) =>
        ChooseTextBookTopic()
  },
  // new demo
  {
    '/home/education/study': (context, {arguments}) => EduStudy(
          id: arguments['id'],
          submitStudyRecords: arguments['submitStudyRecords'],
          stage: arguments['stage']
        )
  },
  {
    '/home/education/mokExam': (context, {arguments}) => MokExam(
          isExam: arguments['isExam'],
          data: arguments['data'],
          id: arguments['id'],
          formalExam: arguments['formalExam'],
          title: arguments['title'],
          duration: arguments['duration'],
          submitStudyRecords: arguments['submitStudyRecords'],
          stage: arguments['stage'],
          type: arguments['type'],
          passLine: arguments['passLine']
        )
  },
  {
    '/home/education/ExamResult': (context, {arguments}) => ExamSumbit(
          arguments["data"],
          formalExam: arguments['formalExam'],
          id: arguments['id'],
          submitStudyRecords: arguments['submitStudyRecords'],
          stage: arguments['stage'],
          type: arguments['type'],
          isPicList: arguments['isPicList']
        )
  },
  {
    '/home/education/examSpotPic': (context, {arguments}) => ExamSpotPic(
          arguments["data"],
          formalExam: arguments['formalExam'],
          id: arguments['id'],
          submitStudyRecords: arguments['submitStudyRecords'],
          stage: arguments['stage'],
          type: arguments['type'],
          picQuestionData: arguments['picQuestionData'],
        )
  },

  {
    '/home/education/eduMyAssessmentDetail': (context, {arguments}) =>
        AssessmentDetail(
          name: arguments['name'],
          data: arguments['data']
        )
  },
  {'/home/education/eduTrain': (context, {arguments}) => EduTrain()},
  // {
  //   '/home/education/eduTrainDetail': (context, {arguments}) => EduTrainDetail(
  //         state: arguments['state'],
  //         id: arguments['id'],
  //       )
  // },

  {'/home/education/eduAddPeople': (context, {arguments}) => EduAddPeople()},

  {'/home/education/eduAddDep': (context, {arguments}) => EduAddDep()},
  {
    '/home/education/WebActiveControl': (context, {arguments}) =>
        WebActiveControl(
          qrMessage: arguments['qrMessage'],
          title: arguments['title'],
        )
  },

  {'/home/education/eduCollectList': (context, {arguments}) => EduCollectList()},

  {'/home/education/eduMySponsorPlan': (context, {arguments}) => EduMySponsorPlan()},

  // {'/home/education/eduSponsorPlan': (context, {arguments}) => EduSponsorPlan(
  //   date: arguments['date'],
  //   type: arguments['type']
  // )},
  
  {'/home/education/myPlanFlowDetails': (context, {arguments}) => MyPlanFlowDetails(
      id: arguments['id'],
  )},

  {'/home/education/styduOfflinePlanDetail': (context, {arguments}) => StyduOfflinePlanDetail(
      planId: arguments['planId'],
      title: arguments['title']
  )},

  {'/home/education/eduMyStudyPlanHistoryList': (context, {arguments}) => EduMyStudyPlanHistoryList()},


  // 考试台账详情页面
  {'/home/education/eduCheckExamLedgerDetails': (context, {arguments}) => EduCheckExamLedgerDetails(
    // examinationId: arguments['examinationId'],
    planId: arguments['planId'],
    userId: arguments['userId'],
    stage: arguments['stage'],
    year: arguments['year']
  )},

  // 调研问卷 发起计划
  {'/home/education/eduInitiateStudyPlan': (context, {arguments}) => EduInitiateStudyPlan(
    researchId: arguments['researchId'],
    educationTrainingResources: arguments['educationTrainingResources']
  )},

  {'/home/education/eduAddExam': (context, {arguments}) => EduAddExam(
    educationTrainingResources: arguments['educationTrainingResources']
  )},

  {'/home/education/eduFormulateExamQuestions': (context, {arguments}) => EduFormulateExamQuestions(
    educationTrainingResources: arguments['educationTrainingResources']
  )},

  {'/home/education/eduQuestionLibrary': (context, {arguments}) => EduQuestionLibrary(
    compulsoryList: arguments['compulsoryList'],
    index: arguments['index']
  )},

  // 我的个人安全教育培训信息档案
  {'/home/education/eduMyTrainFile': (context, {arguments}) => EduMyTrainFile(
    // personalFileData: arguments['personalFileData']
  )},

  {'/home/education/eduClassHours': (context, {arguments}) => EduClassHours(
    title: arguments['title'],
    userId: arguments['userId'],
  )},

  {'/home/education/eduYearExaminatioEvaluation': (context, {arguments}) => EduYearExaminatioEvaluation(
    yearExaminatioEvaluation: arguments['yearExaminatioEvaluation']
  )},

  // 公司年度总体评估 未计划培训人数列表
  {'/home/education/notInvolvedPersonList': (context, {arguments}) => NotInvolvedPersonList(
    notInvolvedList: arguments['notInvolvedList']
  )},

  // 公司年度总体评估 已计划培训人数列表(全部培训)
  {'/home/education/eduHaveParticipatedList': (context, {arguments}) => EduHaveParticipatedList(
    haveParticipatedList: arguments['haveParticipatedList'],
    planType: arguments['planType'],
  )},

  // 公司年度总体评估 已计划培训人数列表(线上培训 | 现场培训)
  {'/home/education/eduHaveParticipatedAloneList': (context, {arguments}) => EduHaveParticipatedAloneList(
    haveParticipatedList: arguments['haveParticipatedList'],
    type: arguments['type'],
    planType: arguments['planType'],
  )},

  // 考核人员列表  年度线上计划详情人员列表
  {'/home/education/examinePersonList': (context, {arguments}) => ExaminePersonList(
    // haveParticipatedList: arguments['haveParticipatedList'],
    type: arguments['type'],
    data: arguments['data'],
    planId: arguments['planId'],
    stage: arguments['stage'],
    year: arguments['year'],
    endTime: arguments['endTime']
  )},

  //  我参与的年度学习计划
  {'/home/education/eduMyAnnualPlan': (context, {arguments}) => EduMyAnnualPlan(
  )},

  //  我参与的年度学习计划二级页面
  {'/home/education/eduMyAnnualYearPlan': (context, {arguments}) => EduMyAnnualYearPlan(
    year: arguments['year']
  )},

  //  我参与的年度学习计划三级页面
  {'/home/education/eduMyAnnualThreeLevelList': (context, {arguments}) => EduMyAnnualThreeLevelList(
    id: arguments['id']
  )},

  //  我参与的年度学习计划线下计划详情
  {'/home/education/offLineYearPlanDetails': (context, {arguments}) => OffLineYearPlanDetails(
    id: arguments['id']
  )},

  //  年度线下计划详情人员列表
  {'/home/education/offLineYearPersonList': (context, {arguments}) => OffLineYearPersonList(
    type: arguments['type'],
    data: arguments['data'],
  )},

  //  我参与的年度学习计划线下计划详情
  {'/home/education/yearPlanDetails': (context, {arguments}) => YearPlanDetails(
    id: arguments['id']
  )},

  //  年度线上计划详情人员列表
  // {'/home/education/yearPersonList': (context, {arguments}) => YearPersonList(
  //   type: arguments['type'],
  //   data: arguments['data'],
  // )},
  
  //  视频直播回放教材
  {'/home/education/eduPlayback': (context, {arguments}) => PlaybackTextBook(
  )},
];
