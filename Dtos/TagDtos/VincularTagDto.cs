using System.ComponentModel.DataAnnotations;

namespace DevopsTrackingCodeApi.Dtos.TagDtos;

public record VincularTagDto(
    [Required(ErrorMessage = "Código da tag é obrigatório")]
    string CodigoTag
);