import 'package:just_audio/just_audio.dart';
import 'dart:developer';

// Müzik çalma/durdurma işini soyutlayan servis.
class MusicPlayerService {
  final _player = AudioPlayer();
  bool _isSourceSet = false;

  // Singleton Pattern: Bu servisten sadece bir örnek olmalı.
  MusicPlayerService() {
    // Müzik bittiğinde otomatik tekrar başlasın
    _player.setLoopMode(LoopMode.one);
  }

  // Müzik dosyasını önceden yükler.
  // Bu metot, dosyayı okur ve player'a hazırlar.
  Future<void> loadAsset(String assetPath) async {
    if (_isSourceSet) return;
    try {
      // setAsset, dosyayı okur ve player'a hazırlar.
      // Bu işlem, just_audio'da genellikle daha güvenli ve asenkrondur.
      await _player.setAsset('assets/$assetPath');
      _isSourceSet = true;
      log('Müzik yüklendi: $assetPath');
    } catch (e) {
      // Hata durumunda loglama veya uyarı ekleyin
      log('Müzik yükleme hatası: ($assetPath) $e');
    }
  }

  Future<void> startMusic() async {
    // Assets'ten müzik çalma
    if (!_isSourceSet) {
      // *** BAŞLATMA HATA LOGU ***
      log(
        'HATA: Müzik kaynağı (source) ayarlanmadığı için startMusic() çağrılamadı.',
      );
      return;
    }

    try {
      await _player.play();
    } catch (e) {
      log('HATA: Oynatma sırasında hata oluştu.', error: e);
    }
  }

  Future<void> pauseMusic() async {
    await _player.pause();
  }

  // Müzik çalıp çalmadığını Cubit'e bildirir.
  Future<bool> isPlaying() async {
    return _player.playing;
  }

  // Uygulama kapanırken mutlaka çağrılmalı.
  void dispose() {
    _player.dispose();
  }
}
