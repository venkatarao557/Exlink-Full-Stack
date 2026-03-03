using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("Country")]
[Microsoft.EntityFrameworkCore.Index("CountryName", Name = "IX_Country_Name")]
[Microsoft.EntityFrameworkCore.Index("CountryCode", Name = "UQ_Country_Code", IsUnique = true)]
public partial class Country
{
    [Key]
    [Column("CountryID")]
    public Guid CountryId { get; set; }

    [StringLength(5)]
    public string CountryCode { get; set; } = null!;

    [StringLength(100)]
    public string CountryName { get; set; } = null!;
}
