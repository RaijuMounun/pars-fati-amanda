import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import '../cubit/romantic_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cubit'e hızlı erişim için kısaltma
    final cubit = context.read<RomanticCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('güzelime'),
        backgroundColor: Colors.pink,
        actions: [
          // Müzik Butonu
          IconButton(
            icon: Icon(
              // isMusicPlaying durumuna göre ikon değiştir
              context.watch<RomanticCubit>().state.isMusicPlaying
                  ? Icons.music_note
                  : Icons.music_off,
            ),
            onPressed: () {
              cubit.toggleMusic(); // Cubit'teki metodu çağır
            },
          ),
        ],
      ),
      // BlocBuilder, sadece state değiştiğinde UI'ı yeniden çizer (build)
      body: BlocBuilder<RomanticCubit, RomanticState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            // Animasyonun süresi (geçiş hızı)
            duration: const Duration(milliseconds: 600),

            // Geçiş animasyonunun türü (Fade = Solma)
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },

            // Gösterilecek olan asıl içerik:
            // Bu 'child' değiştiğinde animasyon tetiklenir.
            child: _buildPageContent(context, state, cubit),
          );
        },
      ),
    );
  }

  /// O anki state'e göre hangi widget'ın gösterileceğini belirler.
  Widget _buildPageContent(
    BuildContext context,
    RomanticState state,
    RomanticCubit cubit,
  ) {
    // 1. Durum: Yükleniyor (isLoading: true)
    if (state.isLoading) {
      return const Center(
        // Key, AnimatedSwitcher'a bu widget'ın "farklı" bir widget olduğunu söyler.
        key: ValueKey('loading_spinner'),
        child: CircularProgressIndicator(color: Colors.pinkAccent),
      );
    }
    // 2. Durum: İçerik Gösterimi
    return SingleChildScrollView(
      // Key, hangi adımda olduğumuzu belirtir.
      // Index değiştiğinde, AnimatedSwitcher bunu yeni bir widget olarak algılar
      // ve eski widget'ı (eski index) fade out yapar, bunu fade in yapar.
      key: ValueKey<int>(state.currentStep.stepIndex),
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Romantik Başlık Metni
            Text(
              state.currentStep.headerText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink[700],
              ),
            ),
            const SizedBox(height: 30),

            // Resim Alanı
            // Resim yolunda sorun varsa hata ekranı gösterin.
            if (state.currentStep.assetImagePath.isNotEmpty)
              _buildImageSection(state.currentStep.assetImagePath),

            const SizedBox(height: 50),

            const SizedBox(height: 50),

            // Buton (Ana Etkileşim)
            ElevatedButton(
              onPressed: () {
                // KRİTİK DÜZELTME:
                // Eğer mevcut state'in index'i 999 (son adım) ise:
                if (state.currentStep.stepIndex == 999) {
                  _showFinalMessage(context);
                } else {
                  // Son adımda değilsek, normal şekilde sonraki adıma geç.
                  cubit.goToNextStep();
                }
              },
              child: Text(state.currentStep.buttonText),
            ),
          ],
        ),
      ),
    );
  }

  // Resim Gösterim Widget'ı
  Widget _buildImageSection(String imagePath) {
    // Resimlerinizi pubspec.yaml'de tanımladığınızdan emin olun.
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 350,
        fit: BoxFit.cover,
      ),
    );
  }

  void _showFinalMessage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Pop-up kapanmasın, duygusal an bölünsün istemeyiz.
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.pink[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: const BorderSide(color: Colors.pinkAccent, width: 3),
          ),
          title: const Text(
            '💖 Sonsuza Kadar Benimle Misin? 💖',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Farkına vardım, şükür, göçmeden Feyza /n Ellerinle sarıp beni, gölgemden şerden /n Yarın da kurtar beni, yoksa yok mu Feyza? /n ',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Icon(Icons.favorite, color: Colors.red, size: 40),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'Hep Seninleyim',
                style: TextStyle(color: Colors.pink, fontSize: 16),
              ),
              onPressed: () {
                // Uygulamayı kapatmak veya ana ekrana döndürmek. Kapatmak daha duygusal olabilir.
                Navigator.of(context).pop();
                // Alternatif: SystemNavigator.pop(); // Uygulamayı tamamen kapatır.
              },
            ),
          ],
        );
      },
    );
  }
}
