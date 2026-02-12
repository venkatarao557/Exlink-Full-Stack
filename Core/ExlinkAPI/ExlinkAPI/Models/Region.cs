using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("Region")]
[Index("RegionCode", Name = "UQ_Region_Code", IsUnique = true)]
public partial class Region
{
    [Key]
    [Column("RegionID")]
    public Guid RegionId { get; set; }

    [StringLength(10)]
    public string RegionCode { get; set; } = null!;

    [StringLength(100)]
    public string RegionName { get; set; } = null!;

    [StringLength(255)]
    public string? Commodities { get; set; }
}
