import 'package:flutter/material.dart';

class Sub {
  late String value;
  late String label;
   Sub(this.value,this.label);
}
class County {
  late String value;
  late String label;
  late List<Sub>  children;
  County(this.value,this.label,this.children);
}