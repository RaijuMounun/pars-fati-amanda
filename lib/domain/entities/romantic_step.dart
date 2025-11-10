import 'package:freezed_annotation/freezed_annotation.dart';

part 'romantic_step.freezed.dart';

@freezed
class RomanticStep with _$RomanticStep {
  const factory RomanticStep({
    required int stepIndex,
    required String assetImagePath,
    required String buttonText,
    required String headerText,
  }) = _RomanticStep;
}
