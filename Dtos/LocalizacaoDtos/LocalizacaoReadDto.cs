namespace DevopsTrackingCodeApi.Dtos.LocalizacaoDtos;

public record LocalizacaoReadDto(
    int IdLocalizacao, decimal X, decimal Y, string CodigoTag, int IdSetor);