import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/1_domain/failures/advice_failure.dart';
import 'package:learning/1_domain/usecases/advice_usecases.dart';
import 'package:learning/2_application/pages/advice/cubit/advicer_state.dart';


const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdvicerInitial());
  final AdviceUseCases adviceUseCases = AdviceUseCases();
  // could also use other usecases

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    final failureOrAdvice = await adviceUseCases.getAdvice();
    failureOrAdvice.fold(
        (failure) => emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
        (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));
  }

  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}