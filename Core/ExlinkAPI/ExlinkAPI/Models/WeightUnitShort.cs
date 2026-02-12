using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("WeightUnitShort")]
[Index("WeightUnit", Name = "UQ_WeightShort_Code", IsUnique = true)]
public partial class WeightUnitShort
{
    [Key]
    [Column("WeightUnitShortID")]
    public Guid WeightUnitShortId { get; set; }

    [StringLength(10)]
    public string WeightUnit { get; set; } = null!;

    [StringLength(100)]
    public string Description { get; set; } = null!;
}
