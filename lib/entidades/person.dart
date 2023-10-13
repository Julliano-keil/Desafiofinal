/// Represents a Person.
class Person {
  /// The unique identifier for this person.
  final int? id;

  /// The CNPJ (Cadastro Nacional da Pessoa Jurídica) for this person.
  final String? cnpj;

  /// The name of the store associated with this person.
  final String? storeName;

  /// The password for this person.
  final String? password;

  /// Constructor for creating a Person instance.
  Person({
    this.id,
    this.cnpj,
    this.storeName,
    this.password,
  });
}
