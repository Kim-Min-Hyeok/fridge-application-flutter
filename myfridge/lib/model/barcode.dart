class BarcodeModel {

  late final String name, barcode;

  BarcodeModel.fromJson(Map<String, dynamic> json) :
    name = json['PRDLST_NM'],
    barcode = json['BAR_CD'];
    
}