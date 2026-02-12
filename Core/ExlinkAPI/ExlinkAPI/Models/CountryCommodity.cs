using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("CountryCommodity")]
[Index("CountryCode", Name = "UQ_CountryComm_Code", IsUnique = true)]
public partial class CountryCommodity
{
    [Key]
    [Column("CountryCommodityID")]
    public Guid CountryCommodityId { get; set; }

    [StringLength(5)]
    public string CountryCode { get; set; } = null!;

    [StringLength(100)]
    public string CountryName { get; set; } = null!;

    [StringLength(255)]
    public string? Commodities { get; set; }
}
