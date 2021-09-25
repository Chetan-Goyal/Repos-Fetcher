// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepoDetailsAdapter extends TypeAdapter<RepoDetails> {
  @override
  final int typeId = 0;

  @override
  RepoDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RepoDetails(
      id: fields[0] as int?,
      nodeId: fields[1] as String?,
      name: fields[2] as String?,
      description: fields[3] as String?,
      watchersCount: fields[4] as int?,
      language: fields[5] as String?,
      openIssuesCount: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RepoDetails obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nodeId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.watchersCount)
      ..writeByte(5)
      ..write(obj.language)
      ..writeByte(6)
      ..write(obj.openIssuesCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepoDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
