using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("CutType")]
[Index("CommodityId", Name = "IX_CutType_CommID")]
[Index("CutCode", Name = "UQ_CutType_Code", IsUnique = true)]
public partial class CutType
{
    [Key]
    [Column("CutTypeID")]
    public Guid CutTypeId { get; set; }

    [Column("CommodityID")]
    public Guid? CommodityId { get; set; }

    [StringLength(20)]
    public string CutCode { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;

    [StringLength(1)]
    [Unicode(false)]
    public string? BoneInIndicator { get; set; }

    [StringLength(1)]
    [Unicode(false)]
    public string? BeefVealIndicator { get; set; }

    [StringLength(1)]
    [Unicode(false)]
    public string? ChemicalLeanIndicator { get; set; }
}
