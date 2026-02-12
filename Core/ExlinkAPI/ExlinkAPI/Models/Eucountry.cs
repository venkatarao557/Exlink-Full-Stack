using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("EUCountry")]
[Index("EucountryCode", Name = "UQ_EUCountry_Code", IsUnique = true)]
public partial class Eucountry
{
    [Key]
    [Column("EUCountryID")]
    public Guid EucountryId { get; set; }

    [Column("EUCountryCode")]
    [StringLength(5)]
    public string EucountryCode { get; set; } = null!;

    [Column("EUCountryName")]
    [StringLength(100)]
    public string EucountryName { get; set; } = null!;
}
