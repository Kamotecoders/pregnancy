import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

import '../models/quiz.dart';

String getGreeting() {
  final currentTime = DateTime.now();
  final hour = currentTime.hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning,';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon,';
  } else {
    return 'Good Evening,';
  }
}

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

int alphabetToIndex(String? alphabet) {
  if (alphabet == null || alphabet.length != 1) {
    return -1;
  }

  final int charCode = alphabet.codeUnitAt(0);

  if (charCode >= 'A'.codeUnitAt(0) && charCode <= 'Z'.codeUnitAt(0)) {
    return charCode - 'A'.codeUnitAt(0);
  } else {
    return -1;
  }
}

String? indexToAlphabet(int index) {
  if (index >= 0 && index < 26) {
    return String.fromCharCode('A'.codeUnitAt(0) + index);
  } else {
    return null;
  }
}

int calculateScore(List<QuizQuestion> quizList, List<int> answerList) {
  int score = 0;

  for (int i = 0; i < quizList.length; i++) {
    if (isAnswerCorrect(quizList[i], answerList[i])) {
      score += 5;
    }
  }

  return score;
}

bool isAnswerCorrect(QuizQuestion question, int selectedAnswerIndex) {
  return selectedAnswerIndex != -1 &&
      question.answer == indexToAlphabet(selectedAnswerIndex);
}
