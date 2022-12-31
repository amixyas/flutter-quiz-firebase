class Quiz {
  bool response;
  String question;
  //String imgUrl;

  Quiz({required this.response, required this.question});

  factory Quiz.fromJson(Map<dynamic, dynamic> json) {
    return Quiz(response: json['response'], question: json['question']);
  }

  Map<String, dynamic> toJson() {
    return {"response": this.response, "question": this.question};
  }
}
