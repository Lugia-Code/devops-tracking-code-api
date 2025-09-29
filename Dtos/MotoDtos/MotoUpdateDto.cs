using System.ComponentModel.DataAnnotations;

namespace DevopsTrackingCodeApi.Dtos.MotoDtos;

public record MotoUpdateDto
{
    public string? Placa { get; set; }
    public string? Modelo { get; set; }
    public int? IdSetor { get; set; }
    public string? CodigoTag { get; set; }
}