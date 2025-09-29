
using System.ComponentModel.DataAnnotations;

using System.ComponentModel.DataAnnotations.Schema;

using System.Text.Json.Serialization;

namespace DevopsTrackingCodeApi.Entities;

[Table("TAG")]

public class Tag

{

    [Key]

    [Column("codigo_tag")]

    public string CodigoTag { get; set; }

    [Required] 

    [Column("status")]

    public string Status { get; set; } = "inativo";

    [Required]

    [Column("data_vinculo")]

    public DateTime DataVinculo { get; set; } = DateTime.Now;

    

    [Column("chassi")]

    public string? Chassi { get; set; }

    

    [JsonIgnore]

    public virtual Moto? Moto { get; set; }

    [JsonIgnore]

    public virtual ICollection<Localizacao> Localizacoes { get; set; } = new List<Localizacao>();

    

    public void VincularMoto(string chassi)

    {

        if (string.IsNullOrWhiteSpace(chassi))

            throw new ArgumentException("Chassi não pode ser nulo ou vazio", nameof(chassi));

            

        if (!string.IsNullOrEmpty(Chassi) && Chassi != chassi)

            throw new InvalidOperationException($"Tag já está vinculada à moto com chassi: {Chassi}");

        

        Chassi = chassi;

        Status = "ativo";

        DataVinculo = DateTime.Now;

    }

    

    public void DesvincularMoto()

    {

        Chassi = null;

        Status = "inativo";

    }

    

    [JsonIgnore]

    public bool EstaDisponivel => string.IsNullOrEmpty(Chassi) || Status == "inativo";

    [JsonIgnore]

    public bool EstaAtiva => Status == "ativo" && !string.IsNullOrEmpty(Chassi);

}

