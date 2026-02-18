using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("EUCountry")]
[Index("EUCountryCode", Name = "UQ_EUCountry_Code", IsUnique = true)]
public partial class EUCountry
{
    [Key]
    [Column("EUCountryID")]
    public Guid EUCountryId { get; set; }

    [Column("EUCountryCode")]
    [StringLength(5)]
    public string EUCountryCode { get; set; } = null!;

    [Column("EUCountryName")]
    [StringLength(100)]
    public string EUCountryName { get; set; } = null!;
}
