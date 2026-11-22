class AddressModel {
  final String cep, logradouro, complemento, bairro, localidade, uf;
  const AddressModel({required this.cep, required this.logradouro,
    required this.complemento, required this.bairro,
    required this.localidade, required this.uf});
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    cep: (json['cep'] ?? '').toString(),
    logradouro: (json['logradouro'] ?? '').toString(),
    complemento: (json['complemento'] ?? '').toString(),
    bairro: (json['bairro'] ?? '').toString(),
    localidade: (json['localidade'] ?? '').toString(),
    uf: (json['uf'] ?? '').toString());
  Map<String, dynamic> toJson() => {
    'cep': cep, 'logradouro': logradouro, 'complemento': complemento,
    'bairro': bairro, 'localidade': localidade, 'uf': uf};
  String get fullAddress => [logradouro, bairro, localidade, uf, cep]
    .where((s) => s.trim().isNotEmpty).join(', ');
}
