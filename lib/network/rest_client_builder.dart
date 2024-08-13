import 'package:codonnier_network/network.dart';
import 'package:codonnier_network/network/rest_client.dart';
import 'package:flutter/material.dart';

class RestClientBuilder extends StatelessWidget {
  final ClientBuilder builder;
  final String baseUrl;
  final RestClient restClient;
  final VoidCallback? onSessionExpired;
  final int? connectionTO;
  final int? receiveTO;

  RestClientBuilder({
    super.key,
    required this.builder,
    required this.baseUrl,
    this.onSessionExpired,
    this.connectionTO,
    this.receiveTO,
  }) : restClient = RestClient(
            baseUrl: baseUrl,
            token: '',
            onSessionExpired: onSessionExpired,
            connectionTO: connectionTO ?? 30000,
            receiveTO: receiveTO ?? 30000);

  @override
  Widget build(BuildContext context) {
    return builder(context, restClient);
  }
}

typedef ClientBuilder = Widget Function(
    BuildContext context, RestClient restClient);
