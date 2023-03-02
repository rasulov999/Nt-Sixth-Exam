part of 'single_state_bloc.dart';

@immutable
abstract class ContactsEvent {}

class AddCards extends ContactsEvent {
  AddCards({required this.cardModel});

  final CardModel cardModel;
}

class UpdateCard extends ContactsEvent {
  UpdateCard({required this.cardModel});

  final CardModel cardModel;
}

class DeleteCard extends ContactsEvent {
  DeleteCard({required this.cardId});

  final String cardId;
}
