import 'dart:async';

import 'package:flutter/services.dart';
import 'package:yandex_kassa/models/payment_parameters.dart';
import 'package:yandex_kassa/yandex_kassa.dart';

class YandexKassa {
  static const MethodChannel _channel = const MethodChannel('yandex_kassa');

  static Future<TokenizationResult> startCheckout(
      PaymentParameters paymentParameters) async =>
      TokenizationResult.fromJson(
          await _channel.invokeMapMethod<String, dynamic>(
              'startCheckout', paymentParameters.json));

  static Future<TokenizationResult> startCheckoutWithCvcRepeatRequest(
      PaymentParameters paymentParameters, String paymentId) async =>
      TokenizationResult.fromJson(
          await _channel.invokeMapMethod<String, dynamic>(
              'startCheckoutWithCvcRepeatRequest',
              (paymentParameters.json ?? {})
                ..addAll({"paymentId": paymentId})));

  static Future<dynamic> forceFinish(PaymentParameters paymentParameters) async =>
      TokenizationResult.fromJson(
          await _channel.invokeMapMethod<String, dynamic>(
              'forceFinish', paymentParameters.json));

  static Future<dynamic> confirm3dsCheckout(
      PaymentParameters paymentParameters, Uri confirmationUrl) async =>
      TokenizationResult.fromJson(
          await _channel.invokeMapMethod<String, dynamic>(
              'confirm3dsCheckout',
              Map<String, dynamic>.from(
                  Map<String, dynamic>.from((paymentParameters.json ?? {}))
                    ..addAll({"confirmationUrl": confirmationUrl.toString()}))));
}
