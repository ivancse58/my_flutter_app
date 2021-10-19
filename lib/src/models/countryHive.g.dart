// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageModelAdapter extends TypeAdapter<LanguageModel> {
  @override
  final int typeId = 2;

  @override
  LanguageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageModel(
      fields[0] as String?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class CurrencyModelAdapter extends TypeAdapter<CurrencyModel> {
  @override
  final int typeId = 1;

  @override
  CurrencyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyModel(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.symbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class CountryModelAdapter extends TypeAdapter<CountryModel> {
  @override
  final int typeId = 0;

  @override
  CountryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryModel(
      fields[0] as String,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as bool?,
      (fields[5] as List?)?.cast<CurrencyModel>(),
      (fields[6] as List?)?.cast<LanguageModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CountryModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.alpha2Code)
      ..writeByte(2)
      ..write(obj.alpha3Code)
      ..writeByte(3)
      ..write(obj.flag)
      ..writeByte(4)
      ..write(obj.isFav)
      ..writeByte(5)
      ..write(obj.currencies)
      ..writeByte(6)
      ..write(obj.languages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
