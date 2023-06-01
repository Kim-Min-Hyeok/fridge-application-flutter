class RecipeModel {

  late final String menu, imageUrl, ingredients, 
  manual1, manual2, manual3, manual4, manual5,
  manual6, manual7, manual8, manual9, manual10,
  manual11, manual12, manual13, manual14, manual15,
  manual16, manual17, manual18, manual19, manual20;

  RecipeModel.fromJson(Map<String, dynamic> json) :
    menu = json['RCP_NM'],
    imageUrl = json['ATT_FILE_NO_MK'],
    ingredients = json['RCP_PARTS_DTLS'],
    manual1 = json['MANUAL01'], 
    manual2 = json['MANUAL02'],
    manual3 = json['MANUAL03'],
    manual4 = json['MANUAL04'],
    manual5 = json['MANUAL05'],
    manual6 = json['MANUAL06'],
    manual7 = json['MANUAL07'],
    manual8 = json['MANUAL08'],
    manual9 = json['MANUAL09'],
    manual10 = json['MANUAL10'],
    manual11 = json['MANUAL11'],
    manual12 = json['MANUAL12'],
    manual13 = json['MANUAL13'],
    manual14 = json['MANUAL14'],
    manual15 = json['MANUAL15'],
    manual16 = json['MANUAL16'],
    manual17 = json['MANUAL17'],
    manual18 = json['MANUAL18'],
    manual19 = json['MANUAL19'],
    manual20 = json['MANUAL20'];
}