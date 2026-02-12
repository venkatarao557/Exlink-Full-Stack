using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("RegionalOffice")]
[Index("State", Name = "IX_RegionalOffice_State")]
[Index("OfficeCode", Name = "UQ_Office_Code", IsUnique = true)]
public partial class RegionalOffice
{
    [Key]
    [Column("OfficeID")]
    public Guid OfficeId { get; set; }

    [StringLength(10)]
    public string OfficeCode { get; set; } = null!;

    [StringLength(150)]
    public string OfficeName { get; set; } = null!;

    [StringLength(10)]
    public string State { get; set; } = null!;
}
