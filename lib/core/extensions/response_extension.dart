import 'package:dio/dio.dart';

extension ResponseX on Response {
  bool get isSuccess => statusCode == 200;
  bool get isCreated => statusCode == 201;
  bool get isAccepted => statusCode == 202;
  bool get isNoContent => statusCode == 204;
  bool get isConflict => statusCode == 409;
}
