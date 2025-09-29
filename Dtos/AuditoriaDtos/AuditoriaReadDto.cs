using DevopsTrackingCodeApi.Entities;

namespace DevopsTrackingCodeApi.Dtos.AuditoriaDtos;

public record AuditoriaReadDto
(
    int IdFuncionario,
    Usuario Usuario,
    string TipoOperacao,
    DateTime DataOperacao,
    string ValoresNovos, 
    string ValoresAnteriores
);