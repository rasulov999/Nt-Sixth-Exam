import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:nt_sixth_exam/data/model/card_model.dart';
import 'package:nt_sixth_exam/data/repository/cards_repository.dart';

part 'single_state_event.dart';

part 'single_state_state.dart';

class AUDStateBloc extends Bloc<ContactsEvent, CardState> {
  AUDStateBloc({required this.cardRepository})
      : super(CardState(status: CardsStete.pure, statusText: "")) {
    on<AddCards>(_addCArd);
    on<UpdateCard>(_updateCard);
    on<DeleteCard>(_deleteCard);
  }

  CardRepository cardRepository;

  _addCArd(AddCards event, Emitter<CardState> emit) async {
    emit(state.copyWith(status: CardsStete.loading));
    var newContact = cardRepository.addCard(cardModel: event.cardModel);
    if (newContact != null) {
      emit(state.copyWith(status: CardsStete.contactAdded));
    }
  }

  _updateCard(UpdateCard event, Emitter<CardState> emit) async {
    emit(state.copyWith(status: CardsStete.loading));
    cardRepository.updateCard(cardModel: event.cardModel);
    emit(state.copyWith(status: CardsStete.contactUpdate));
  }

  _deleteCard(DeleteCard event, Emitter<CardState> emit) async {
    emit(state.copyWith(status: CardsStete.loading));
    var deleteId = cardRepository.deleteCard(doId: event.cardId);
    if (deleteId != "") {
      emit(state.copyWith(status: CardsStete.contactDelete));
    }
  }
}

enum MyStatus {
  error,
  success,
  loading,
  pure,
}
