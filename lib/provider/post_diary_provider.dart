import 'package:flutter/material.dart';
import 'package:laxia/models/counsel_question_model.dart';

class PostDiaryProvider extends ChangeNotifier {
  String date = "";
  get getDate => date;
  void setDate(String postDate) {
    date = postDate;
    notifyListeners();
  }

  List<int> operationTypes = [];
  get getOperationTypes => operationTypes;
  void setOperatinTypes(List<int> postOperationTypes) {
    operationTypes.clear();
    operationTypes.addAll(postOperationTypes);
    notifyListeners();
  }

  String clinic_id = '';
  get getClinicID => clinic_id;
  void setClinicID(int postClinicID) {
    clinic_id = postClinicID.toString();
    notifyListeners();
  }

  String doctor_id = '';
  get getDoctorID => doctor_id;
  void setDoctorID(int postDoctorID) {
    doctor_id = postDoctorID.toString();
    notifyListeners();
  }

  String operationDescription = "";
  get getOperationDescription => operationDescription;
  void setOperationDescription(String postOperationDescription) {
    operationDescription = postOperationDescription;
    notifyListeners();
  }

  List<List<int>> diary_imageIds = [[], []];
  get getDiaryImageIds => diary_imageIds;
  void setDiaryImageIds(List<List<int>> postMedias) {
    print(postMedias);
    for(int i=0; i<postMedias.length; i++){
      diary_imageIds.add([]);
      if(postMedias[i].length > 0) {
        for(int j=0;j<postMedias[i].length;j++)
          diary_imageIds[i].add(postMedias[i][j]);
      }
    }
    notifyListeners();
  }
  void init(){
    diary_imageIds.clear();
    notifyListeners();
  }
  
  int cost_op = 0;
  get getCostOp => cost_op;
  void setCostOp(int postCostOp) {
    cost_op = postCostOp;
    notifyListeners();
  }
  int cost_anesthetic = 0;
  get getCostAnesthetic => cost_anesthetic;
  void setCostAnesthetic(int postCostAnesthetic) {
    cost_anesthetic = postCostAnesthetic;
    notifyListeners();
  }
  int cost_drug = 0;
  get getCostDrug => cost_drug;
  void setCostDrug(int postCostDrug) {
    cost_drug = postCostDrug;
    notifyListeners();
  }
  int cost_other = 0;
  get getCostOther => cost_other;
  void setCostOther(int postCostOther) {
    cost_other = postCostOther;
    notifyListeners();
  }

  List<int> rates = [];
  get getRates => rates;
  void setRates(List<int> postRates) {
    rates.clear();
    rates.addAll(postRates);
    notifyListeners();
  }

  List<String> questions = [];
  get getQuestions => questions;
  void setQuestions(List<String> postQuestions) {
    questions.clear();
    questions.addAll(postQuestions);
    notifyListeners();
  }
  ////////////////////////Progress
  String numbers_date = '';
  get getNumbersDate => numbers_date;
  void setNumbersDate(String num) {
    numbers_date = num;
    notifyListeners();
  }
  int status1 = 1;
  get getStatus1 => status1;
  void setStatus1(int val) {
    status1 = val;
    notifyListeners();
  }
  int status2 = 1;
  get getStatus2 => status1;
  void setStatus2(int val) {
    status2 = val;
    notifyListeners();
  }
  int status3 = 1;
  get getStatus3 => status1;
  void setStatus3(int val) {
    status3 = val;
    notifyListeners();
  }
  List<int> progress_images = [];
  get getProgressImages => progress_images;
  void setProgressImages(List<int> images) {
    progress_images.clear();
    progress_images = images;
    notifyListeners();
  }







  String counsel_content = '';
  get getCounselContent => counsel_content;
  void setCounselContent(String value) {
    counsel_content = value;
    notifyListeners();
  }

  List<List<int>> counsel_imageIds = [[], [], []];
  get getCounselImageIds => counsel_imageIds;
  void setCounselImageIds(List<List<int>> imageIds) {
    for(int i = 0; i< imageIds.length; i++){
      print(counsel_imageIds);
      if(imageIds[i].length > 0){
        counsel_imageIds[i].addAll(imageIds[i]);
      }
    }
    notifyListeners();
  }
  List<List<String>> counsel_images = [[], [], []];
  get getCounselImages => counsel_images;
  void setCounselImages(List<List<String>> images) {
    for(int i = 0; i< images.length; i++){
      print(counsel_images);
      if(images[i].length > 0){
        counsel_images[i].addAll(images[i]);
      }
    }
    notifyListeners();
  }

  String counsel_reason = '';
  get getCounselReason => counsel_reason;
  void setCounselReason(String reason) {
    counsel_reason = reason;
    notifyListeners();
  }
  String counsel_before = '';
  get getCounselBefore => counsel_before;
  void setCounselBefore(String before) {
    counsel_before = before;
    notifyListeners();
  }
  String counsel_after = '';
  get getCounselAfter => counsel_after;
  void setCounselAfter(String after) {
    counsel_after = after;
    notifyListeners();
  }
  int counsel_rate = 0;
  get getCounselRate => counsel_rate;
  void setCounselRate(int rate) {
    counsel_rate = rate;
    notifyListeners();
  }
  List<CounselQuestion_Model> counsel_questions = [];
  get getCounselQuestions => counsel_questions;
  void setCounselQuestions(List<CounselQuestion_Model> questions) {
    counsel_questions = questions;
    notifyListeners();
  }
}