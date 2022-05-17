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

  late int clinic_id;
  get getClinicID => clinic_id;
  void setClinicID(int postClinicID) {
    clinic_id = postClinicID;
    notifyListeners();
  }

  late int doctor_id;
  get getDoctorID => doctor_id;
  void setDoctorID(int postDoctorID) {
    doctor_id = postDoctorID;
    notifyListeners();
  }

  String operationDescription = "";
  get getOperationDescription => operationDescription;
  void setOperationDescription(String postOperationDescription) {
    operationDescription = postOperationDescription;
    notifyListeners();
  }

  List<String> medias = [];
  get getMedias => medias;
  void setMedias(List<String> postMedias) {
    medias.clear();
    medias.addAll(postMedias);
    notifyListeners();
  }

  late int cost_anesthetic;
  get getCostAnesthetic => cost_anesthetic;
  void setCostAnesthetic(int postCostAnesthetic) {
    cost_anesthetic = postCostAnesthetic;
    notifyListeners();
  }
  late int cost_drug;
  get getCostDrug => cost_drug;
  void setCostDrug(int postCostDrug) {
    cost_drug = postCostDrug;
    notifyListeners();
  }
  late int cost_other;
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
}