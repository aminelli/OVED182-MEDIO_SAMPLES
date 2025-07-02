import 'package:english_words/english_words.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'random_word_state.dart';

/// [RandomWordCubit] is the class responsible for handling the state of the application and the events.
/// It extends [Cubit] with type [RandomWordState] so that we can reference the parent class.
///
class RandomWordCubit extends HydratedCubit<RandomWordState> {
  /// Here we use the constructor of [RandomWordState]
  RandomWordCubit() : super(RandomWordInitial());

  /// The [generateRandomWord] method, as it's name suggests,
  /// generates a random word pair and emits it as the new state.
  ///
  void generateRandomWord() {
    final randomWorld = WordPair.random();
    emit(state.copyWith(pairOfWords: randomWorld));
  }

  /// The [manageFavorite] method is responsible for adding or removing a word pair from the list of favorites.
  /// The parameter is a [WordPair] object.
  ///
  /// The first thing it does is to create a copy of the list of favorites from the state,
  /// then it checks if the word pair is already in the list of favorites, and if it is, it removes it,
  /// otherwise it adds it.
  /// Finally it emits the new state with the updated list of favorites.
  ///
  void manageFavorite(WordPair wordPair) {
    print("WordPair $wordPair");
    final newListOfFavorites = List<WordPair>.from(state.listOfFavorites);
    print("List before add $newListOfFavorites");

    if (newListOfFavorites.contains(wordPair)) {
      newListOfFavorites.remove(wordPair);
    } else {
      newListOfFavorites.add(wordPair);
    }
    print("List after add $newListOfFavorites");
    emit(state.copyWith(listOfFavorites: newListOfFavorites));
  }

  @override
  RandomWordState? fromJson(Map<String, dynamic> json) {
    return RandomWordState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RandomWordState state) {
    return state.toJson();
  }
}
