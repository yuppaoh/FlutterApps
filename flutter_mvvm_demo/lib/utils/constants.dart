class Constants {
  static const String API_KEY ='b6f198df25754973b3a535cfafaa106d';
  static const String TOP_HEADLINES_URL = 'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=';

  // https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=b6f198df25754973b3a535cfafaa106d
  static String headlinesFor(String country) {
    return 'https://newsapi.org/v2/top-headlines?country=$country&category=business&apiKey=$API_KEY';
    // return 'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=b6f198df25754973b3a535cfafaa106d';
  }

  static const Map<String, String> Countries = {
    "USA": "us",
    "India": "in",
    "Korea": "kr",
    "China": "ch",
  };

}