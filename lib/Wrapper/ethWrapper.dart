import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class EthWrapper {
  Future<bool> transferToken(String recipient, double amount) async {
    const apiUrl = "https://testnet2.matic.network";
    final client = Web3Client(apiUrl, http.Client());
    await rootBundle
        .loadString("assets/json/StandardToken.json")
        .then((abi) async {
      await SharedPreferences.getInstance().then((prefs) async {
        String privateKey = prefs.getString("privateKey");
        String recpAddress = await fetchAddress(recipient);
        print(recpAddress);
        Credentials credentials = EthPrivateKey.fromHex(privateKey);
        final address = await credentials.extractAddress();
        print(address);
        final contract = DeployedContract(
            ContractAbi.fromJson(abi, "StandardTOken"),
            EthereumAddress.fromHex(
                "0xb35456a9b634cf85569154321596ee2d62e215ba"));
        var transfer = contract.function('transfer');
        await client
            .sendTransaction(
          credentials,
          Transaction.callContract(
              contract: contract,
              function: transfer,
              parameters: [
                EthereumAddress.fromHex(recpAddress),
                BigInt.from(amount * 1000) * BigInt.from(1000000000000000)
              ]),
          chainId: 8995,
        )
            .then((hash) {
          print(BigInt.from(amount) * BigInt.from(1000000000000000000));
          print("tx hash: " + hash);
        });
      });
    });
    await client.dispose();
    return true;
  }

  Future<String> fetchAddress(String phone) async {
    EthereumAddress rAddress;
    var apiUrl = "https://testnet2.matic.network";
    final client =
        Web3Client(apiUrl, http.Client(), enableBackgroundIsolate: true);
    await rootBundle.loadString('assets/json/meWallet.json').then((abi) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String privateKey = prefs.getString("privateKey");
      var bytes = utf8.encode(phone);
      var digest = sha256.convert(bytes);
      print(digest.toString());
      Credentials credentials = EthPrivateKey.fromHex(privateKey);
      final address = await credentials.extractAddress();
      print(address);
      final contract = DeployedContract(
          ContractAbi.fromJson(abi, 'payDapp'),
          EthereumAddress.fromHex(
              '0x98B4b69fAA809f246631d192E9C1644dEBb370BA'));
      var mapp = contract.function('getNo');
      var addr = await client.call(
          contract: contract, function: mapp, params: [digest.toString()]);
      rAddress = addr[0];
      print(rAddress);
    });
    await client.dispose();
    return rAddress.toString();
  }
}
