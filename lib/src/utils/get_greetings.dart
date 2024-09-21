import 'dart:math';

String getGreeting(List<String> greetings) {
  return "${greetings[Random().nextInt(greetings.length)]},";
}