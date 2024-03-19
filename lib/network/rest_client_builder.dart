import 'package:codonnier_network/network.dart';
import 'package:codonnier_network/network/rest_client.dart';
import 'package:flutter/material.dart';

class RestClientBuilder extends StatelessWidget {
  final ClientBuilder builder;
  final String baseUrl;
  final RestClient restClient;

  RestClientBuilder({
    super.key,
    required this.builder,
    required this.baseUrl,
  }) : restClient = RestClient(baseUrl: baseUrl, token: '');

  @override
  Widget build(BuildContext context) {
    return builder(context, restClient);
  }
}

typedef ClientBuilder = Widget Function(
    BuildContext context, RestClient restClient);
