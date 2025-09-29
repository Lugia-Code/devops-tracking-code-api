using DevopsTrackingCodeApi.Dtos.SetorDtos;
using DevopsTrackingCodeApi.Dtos.TagDtos;

namespace DevopsTrackingCodeApi.Dtos.MotoDtos;

// DTO de leitura ajustado para Setor e Tag serem opcionais
public record MotoReadDto(
    string Chassi,
    string? Placa,
    string Modelo,
    DateTime DataCadastro,
    SetorReadDto Setor, // permite nulo
    TagReadDto Tag      // permite nulo
);
