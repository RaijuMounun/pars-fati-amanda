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
          isMusicPlaying: false,
        ),
      ) {
    _initializeAudio();
  }

  /// Müziği yükler ve bittiğinde otomatik olarak başlatır.
  Future<void> _initializeAudio() async {
    // 1. Dosyayı yükle (I/O)
    await musicPlayerService.loadAsset('audio/somethingholy.mp3');

    // 2. Yükleme bittiyse, oynatmayı başlat
    await musicPlayerService.startMusic();

    // 3. UI'ı (State'i) güncelle.
    // Artık müzik çaldığı için AppBar'daki ikonun güncellenmesi gerekir.
    if (state.isMusicPlaying == false) {
      // Sadece kapalıysa aç
      emit(state.copyWith(isMusicPlaying: true));
    }
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
    final bool currentlyPlaying = state.isMusicPlaying;

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
