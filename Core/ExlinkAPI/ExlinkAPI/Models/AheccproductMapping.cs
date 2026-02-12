using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Keyless]
[Table("AHECCProductMapping")]
[Index("Ahecc", "ProductTypeCode", Name = "IX_AHECC_Lookup")]
public partial class AheccproductMapping
{
    [Column("MappingID")]
    public Guid MappingId { get; set; }

    [Column("AHECC")]
    [StringLength(20)]
    public string Ahecc { get; set; } = null!;

    [StringLength(20)]
    public string CutCode { get; set; } = null!;

    [StringLength(10)]
    public string ProductTypeCode { get; set; } = null!;

    [StringLength(255)]
    public string? Description { get; set; }

    [ForeignKey("CutCode")]
    public virtual CutType CutCodeNavigation { get; set; } = null!;
}
