
class PhotoModel {
  String url;
  String photographer;
  SrcModel src;
  String photographerUrl;
  int photographerId;
  
  PhotoModel({this.url, this.photographer, this.photographerUrl, this.photographerId, this.src});

  factory PhotoModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotoModel(
      url: parsedJson["url"],
      photographer: parsedJson["photographer"],
      photographerId: parsedJson["photographerId"],
      photographerUrl: parsedJson["photographerId"],
      src: SrcModel.fromMap(parsedJson["src"])
    );
  }
}

class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel({this.portrait, this.large, this.landscape, this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
      portrait: srcJson["portrait"],
      large: srcJson["large"],
      landscape: srcJson["landscape"],
      medium: srcJson["medium"],
    );
  }

}