part of 'add_card_bloc.dart';

@immutable
abstract class AddCardEvent {}

class AddCard extends AddCardEvent {
  AddCard({required this.cardModel});
  final CardModel cardModel;
}

