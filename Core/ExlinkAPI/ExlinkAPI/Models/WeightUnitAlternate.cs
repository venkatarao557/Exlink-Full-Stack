using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("WeightUnitAlternate")]
[Index("WeightUnit", Name = "UQ_WeightAlt_Code", IsUnique = true)]
public partial class WeightUnitAlternate
{
    [Key]
    [Column("WeightUnitAltID")]
    public Guid WeightUnitAltId { get; set; }

    [StringLength(10)]
    public string WeightUnit { get; set; } = null!;

    [StringLength(100)]
    public string Description { get; set; } = null!;
}
