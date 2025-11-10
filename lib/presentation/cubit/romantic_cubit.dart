import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/romantic_step.dart';
import '../../domain/usecases/get_next_step.dart';
import '../../data/datasources/music_player_service.dart';
import 'dart:developer';

// State (Durum): Değişmez (immutable) olmalı.
class RomanticState {
  final RomanticStep currentStep;
  final bool isLoading;
  final bool isMusicPlaying; // Müzik yönetimini ekleyelim

  const RomanticState(
    this.currentStep, {
    this.isLoading = false,
    this.isMusicPlaying = false, // Varsayılan olarak müzik çalmasın
  });

  // State'i güncellemek için copyWith (Freezed kullanmadığımız için manuel)
  RomanticState copyWith({
    RomanticStep? currentStep,
    bool? isLoading,
    bool? isMusicPlaying,
  }) {
    return RomanticState(
      currentStep ?? this.currentStep,
      isLoading: isLoading ?? this.isLoading,
      isMusicPlaying: isMusicPlaying ?? this.isMusicPlaying,
    );
  }
}

class RomanticCubit extends Cubit<RomanticState> {
  final GetNextStep getNextStepUseCase;
  final MusicPlayerService musicPlayerService;
  int _currentStepIndex = 0;

  // Cubit başlangıç state'i (0. indexi alır)
  RomanticCubit(this.getNextStepUseCase, this.musicPlayerService)
    : super(
        RomanticState(
          const RomanticStep(
            stepIndex: 0,
            assetImagePath: '', // Başlangıçta boş, ilk fetch ile dolacak
            buttonText: '',
            headerText: 'Yükleniyor...',
          ),
          isLoading: false,
        ),
      ) {
    musicPlayerService.loadAsset('audio/somethingholy.mp3');
  }

  // Başlangıç verisini yükleme (index = 0)
  Future<void> loadInitialStep() async {
    emit(state.copyWith(isLoading: true));
    try {
      final initialStep = await getNextStepUseCase(0);
      emit(state.copyWith(currentStep: initialStep, isLoading: false));
    } catch (e) {
      log('Başlangıç verisi yüklenemedi: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> goToNextStep({bool isInitial = false}) async {
    // Eğer ilk yükleme değilse, indeksi artır.
    if (!isInitial) {
      _currentStepIndex++;
    }

    emit(state.copyWith(isLoading: true)); // Yükleniyor durumu

    final nextStep = await getNextStepUseCase(_currentStepIndex);

    emit(state.copyWith(currentStep: nextStep, isLoading: false));
  }

  // Müzik başlatma/durdurma mantığı
  void toggleMusic() async {
    final bool currentlyPlaying = await musicPlayerService.isPlaying();

    if (currentlyPlaying) {
      await musicPlayerService.pauseMusic();
      emit(state.copyWith(isMusicPlaying: false));
    } else {
      // Müzik zaten yüklenmiş olduğu için startMusic hızlı çalışır.
      await musicPlayerService.startMusic();
      emit(state.copyWith(isMusicPlaying: true));
    }
  }

  @override
  Future<void> close() {
    musicPlayerService.dispose(); // Player kaynağını serbest bırak
    return super.close();
  }
}
