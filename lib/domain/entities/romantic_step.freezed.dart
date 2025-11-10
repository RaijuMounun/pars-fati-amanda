// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'romantic_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RomanticStep {
  int get stepIndex => throw _privateConstructorUsedError;
  String get assetImagePath => throw _privateConstructorUsedError;
  String get buttonText => throw _privateConstructorUsedError;
  String get headerText => throw _privateConstructorUsedError;

  /// Create a copy of RomanticStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RomanticStepCopyWith<RomanticStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RomanticStepCopyWith<$Res> {
  factory $RomanticStepCopyWith(
    RomanticStep value,
    $Res Function(RomanticStep) then,
  ) = _$RomanticStepCopyWithImpl<$Res, RomanticStep>;
  @useResult
  $Res call({
    int stepIndex,
    String assetImagePath,
    String buttonText,
    String headerText,
  });
}

/// @nodoc
class _$RomanticStepCopyWithImpl<$Res, $Val extends RomanticStep>
    implements $RomanticStepCopyWith<$Res> {
  _$RomanticStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RomanticStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepIndex = null,
    Object? assetImagePath = null,
    Object? buttonText = null,
    Object? headerText = null,
  }) {
    return _then(
      _value.copyWith(
            stepIndex: null == stepIndex
                ? _value.stepIndex
                : stepIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            assetImagePath: null == assetImagePath
                ? _value.assetImagePath
                : assetImagePath // ignore: cast_nullable_to_non_nullable
                      as String,
            buttonText: null == buttonText
                ? _value.buttonText
                : buttonText // ignore: cast_nullable_to_non_nullable
                      as String,
            headerText: null == headerText
                ? _value.headerText
                : headerText // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RomanticStepImplCopyWith<$Res>
    implements $RomanticStepCopyWith<$Res> {
  factory _$$RomanticStepImplCopyWith(
    _$RomanticStepImpl value,
    $Res Function(_$RomanticStepImpl) then,
  ) = __$$RomanticStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int stepIndex,
    String assetImagePath,
    String buttonText,
    String headerText,
  });
}

/// @nodoc
class __$$RomanticStepImplCopyWithImpl<$Res>
    extends _$RomanticStepCopyWithImpl<$Res, _$RomanticStepImpl>
    implements _$$RomanticStepImplCopyWith<$Res> {
  __$$RomanticStepImplCopyWithImpl(
    _$RomanticStepImpl _value,
    $Res Function(_$RomanticStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RomanticStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepIndex = null,
    Object? assetImagePath = null,
    Object? buttonText = null,
    Object? headerText = null,
  }) {
    return _then(
      _$RomanticStepImpl(
        stepIndex: null == stepIndex
            ? _value.stepIndex
            : stepIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        assetImagePath: null == assetImagePath
            ? _value.assetImagePath
            : assetImagePath // ignore: cast_nullable_to_non_nullable
                  as String,
        buttonText: null == buttonText
            ? _value.buttonText
            : buttonText // ignore: cast_nullable_to_non_nullable
                  as String,
        headerText: null == headerText
            ? _value.headerText
            : headerText // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RomanticStepImpl implements _RomanticStep {
  const _$RomanticStepImpl({
    required this.stepIndex,
    required this.assetImagePath,
    required this.buttonText,
    required this.headerText,
  });

  @override
  final int stepIndex;
  @override
  final String assetImagePath;
  @override
  final String buttonText;
  @override
  final String headerText;

  @override
  String toString() {
    return 'RomanticStep(stepIndex: $stepIndex, assetImagePath: $assetImagePath, buttonText: $buttonText, headerText: $headerText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RomanticStepImpl &&
            (identical(other.stepIndex, stepIndex) ||
                other.stepIndex == stepIndex) &&
            (identical(other.assetImagePath, assetImagePath) ||
                other.assetImagePath == assetImagePath) &&
            (identical(other.buttonText, buttonText) ||
                other.buttonText == buttonText) &&
            (identical(other.headerText, headerText) ||
                other.headerText == headerText));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    stepIndex,
    assetImagePath,
    buttonText,
    headerText,
  );

  /// Create a copy of RomanticStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RomanticStepImplCopyWith<_$RomanticStepImpl> get copyWith =>
      __$$RomanticStepImplCopyWithImpl<_$RomanticStepImpl>(this, _$identity);
}

abstract class _RomanticStep implements RomanticStep {
  const factory _RomanticStep({
    required final int stepIndex,
    required final String assetImagePath,
    required final String buttonText,
    required final String headerText,
  }) = _$RomanticStepImpl;

  @override
  int get stepIndex;
  @override
  String get assetImagePath;
  @override
  String get buttonText;
  @override
  String get headerText;

  /// Create a copy of RomanticStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RomanticStepImplCopyWith<_$RomanticStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
