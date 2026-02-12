using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("USTerritory")]
[Index("CountryCode", Name = "UQ_USTerritory_Code", IsUnique = true)]
public partial class Usterritory
{
    [Key]
    [Column("USTerritoryID")]
    public Guid UsterritoryId { get; set; }

    [StringLength(2)]
    [Unicode(false)]
    public string CountryCode { get; set; } = null!;

    [StringLength(100)]
    public string CountryName { get; set; } = null!;
}
