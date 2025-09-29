namespace DevopsTrackingCodeApi.Dtos.TagDtos;

public record TagReadDto(
    string CodigoTag,
    string Status,
    DateTime? DataVinculo
    );