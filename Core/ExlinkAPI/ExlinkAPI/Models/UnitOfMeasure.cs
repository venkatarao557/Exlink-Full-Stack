using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("UnitOfMeasure")]
[Index("UnitType", Name = "IX_UOM_Type")]
[Index("UnitCode", Name = "UQ_UOM_Code", IsUnique = true)]
public partial class UnitOfMeasure
{
    [Key]
    [Column("UOMID")]
    public Guid Uomid { get; set; }

    [StringLength(10)]
    public string UnitCode { get; set; } = null!;

    [StringLength(50)]
    public string UnitType { get; set; } = null!;

    [StringLength(100)]
    public string Description { get; set; } = null!;
}
