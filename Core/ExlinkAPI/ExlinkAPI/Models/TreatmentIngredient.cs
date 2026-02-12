using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("TreatmentIngredient")]
[Index("IngredientCode", Name = "UQ_Ingredient_Code", IsUnique = true)]
public partial class TreatmentIngredient
{
    [Key]
    [Column("IngredientID")]
    public Guid IngredientId { get; set; }

    public int IngredientCode { get; set; }

    [StringLength(500)]
    public string Description { get; set; } = null!;
}
