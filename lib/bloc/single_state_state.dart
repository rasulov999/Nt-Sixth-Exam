part of 'single_state_bloc.dart';

class CardState extends Equatable {
  final CardsStete status;
  final String statusText;

  const CardState({required this.status, required this.statusText});

  CardState copyWith(
          {CardsStete? status, String? statusText, CardModel? cardModel}) =>
      CardState(
        status: status ?? this.status,
        statusText: statusText ?? this.statusText,
      );

  @override
  List<dynamic> get props => [
        status,
        statusText,
      ];
}

enum CardsStete {
  loading,
  pure,
  contactAdded,
  contactUpdate,
  contactDelete,
}
