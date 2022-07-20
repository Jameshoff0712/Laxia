import 'package:flutter/material.dart';

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

  List<int> diary_imageIds = [];
  get getDiaryImageIds => diary_imageIds;
  void setDiaryImageIds(List<int> postMedias) {
    diary_imageIds.clear();
    diary_imageIds.addAll(postMedias);
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
  }
}