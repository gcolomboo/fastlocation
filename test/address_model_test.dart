import 'package:flutter_test/flutter_test.dart';
import 'package:fastlocation/src/modules/home/model/address_model.dart';
void main() {
  test('converte resposta ViaCEP em endereço', () {
    final address = AddressModel.fromJson({
      'cep': '01001-000', 'logradouro': 'Praça da Sé', 'complemento': '',
      'bairro': 'Sé', 'localidade': 'São Paulo', 'uf': 'SP'});
    expect(address.cep, '01001-000');
    expect(address.fullAddress, contains('São Paulo'));
    expect(address.toJson()['uf'], 'SP');
  });
}
