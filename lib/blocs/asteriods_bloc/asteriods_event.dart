part of 'asteriods_bloc.dart';

sealed class AsteriodsEvent extends Equatable {
  const AsteriodsEvent();

  @override
  List<Object> get props => [];
}

class AddAsteriodEvent extends AsteriodsEvent {}

class UpdateAsteriodEvent extends AsteriodsEvent {}

class DamagedAsteriodEvent extends AsteriodsEvent {}
