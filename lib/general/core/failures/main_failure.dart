import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_failure.freezed.dart';

@freezed
abstract class MainFailure with _$MainFailure {
  const factory MainFailure.serverFailure({required String errorMsg}) =
      ServerFailure;
  const factory MainFailure.alreadyExists({required String errorMsg}) =
      _AlredyExist;
  const factory MainFailure.dataNotFound({required String errorMsg}) =
      DataNotFount;
  const factory MainFailure.locationFailure({required String errorMsg}) =
      _LocationFailure;
  const factory MainFailure.permissionDenied({required String errorMsg}) =
      _PermissionDenied;

  const factory MainFailure.pickFailed({required String errorMsg}) =
      _PickFailed;

  const factory MainFailure.authenticationFailure({required String errorMsg}) =
      AuthenticationFailure;
  // The errorMsg getter is implemented by the freezed package
  // Each specific failure type will provide its own implementation
}
