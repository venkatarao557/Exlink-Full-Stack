using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("SupplementaryCode")]
[Index("SupplementaryCode1", Name = "UQ_SuppCode", IsUnique = true)]
public partial class SupplementaryCode
{
    [Key]
    [Column("SupplementaryCodeID")]
    public Guid SupplementaryCodeId { get; set; }

    [Column("SupplementaryCode")]
    [StringLength(10)]
    public string SupplementaryCode1 { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;

    [StringLength(100)]
    public string? ApplicableCommodities { get; set; }
}
