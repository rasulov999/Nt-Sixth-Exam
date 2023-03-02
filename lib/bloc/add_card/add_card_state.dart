part of 'add_card_bloc.dart';

class AddCardState extends Equatable {
  final Status status;

  const AddCardState({
    required this.status,
  });

  AddCardState copyWith({
    CardModel? cardModel,
    Status? status,
  }) =>
      AddCardState(
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [
        status,
      ];
}

enum Status { pure, loading, error, success }
