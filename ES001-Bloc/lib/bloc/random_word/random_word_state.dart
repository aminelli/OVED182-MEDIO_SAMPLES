part of 'random_word_cubit.dart';

/// [RandomWordState] defines the various values of two variables: [pairOfWords] and [listOfFavorites], these values are the state.
/// [pairOfWords]'s type is [WordPair] and [listOfFavorites] is a list of [WordPair].
///
/// The constructor instantiates only the list of [WordPair] and it's set to an empty list by default while [pairOfWords] is null.
///
/// We also have the [copyWith] method which is used to update either one or more of the variables.
///
/// Also the @immutable annotation ensures that the class is immutable, that means the variables can't be modified.
///
@immutable
class RandomWordState {
  final WordPair? pairOfWords;
  final List<WordPair> listOfFavorites;

  const RandomWordState({this.pairOfWords, this.listOfFavorites = const []});

  /// The [copyWith] method is used to update either one or more variables.
  /// If no value is provided, the current value saved in the variable is used.
  /// So in the end it creates a new instance of the class.
  /// This ensures immutability by never modifying the existing state object.
  ///
  RandomWordState copyWith({
    WordPair? pairOfWords,
    List<WordPair>? listOfFavorites,
  }) => RandomWordState(
    pairOfWords: pairOfWords ?? this.pairOfWords,
    listOfFavorites: listOfFavorites ?? this.listOfFavorites,
  );

  Map<String, dynamic> toJson() => {
    'pairOfWords': {'first': pairOfWords!.first, 'second': pairOfWords!.second},
    'listOfFavorites': listOfFavorites
        .map((wordPair) => {'first': wordPair.first, 'second': wordPair.second})
        .toList(),
  };

  factory RandomWordState.fromJson(Map<String, dynamic> json) =>
      RandomWordState(
        pairOfWords: WordPair(
          json['pairOfWords']['first'],
          json['pairOfWords']['second'],
        ),
        listOfFavorites: (json['listOfFavorites'] as List)
            .map((wordPair) => WordPair(wordPair['first'], wordPair['second']))
            .toList(),
      );
}

/// Class used to initialize the variables. It's job is to reference the constructor of it's parent class.
///
final class RandomWordInitial extends RandomWordState {}
