class Resource {
  String question;
  String answer;

  Resource({required this.question, required this.answer});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }
}

final List<Resource> frequentQuestionsData = [
  Resource(question: 'question_1', answer: 'answer_1'),
  Resource(question: 'question_2', answer: 'answer_2'),
  Resource(question: 'question_3', answer: 'answer_3'),
  Resource(question: 'question_4', answer: 'answer_4'),
  Resource(question: 'question_5', answer: 'answer_5'),
  Resource(question: 'question_6', answer: 'answer_6'),
  Resource(question: 'question_7', answer: 'answer_7'),
  Resource(question: 'question_8', answer: 'answer_8'),
  Resource(question: 'question_9', answer: 'answer_9'),
  Resource(question: 'question_10', answer: 'answer_10'),
  Resource(question: 'question_11', answer: 'answer_11'),
  Resource(question: 'question_12', answer: 'answer_12'),
  Resource(question: 'question_13', answer: 'answer_13'),
  Resource(question: 'question_14', answer: 'answer_14'),
  Resource(question: 'question_15', answer: 'answer_15'),
  Resource(question: 'question_16', answer: 'answer_16'),
  Resource(question: 'question_17', answer: 'answer_17'),
  Resource(question: 'question_18', answer: 'answer_18'),
  Resource(question: 'question_19', answer: 'answer_10'),
  Resource(question: 'question_20', answer: 'answer_20'),
  Resource(question: 'question_21', answer: 'answer_21'),
];
