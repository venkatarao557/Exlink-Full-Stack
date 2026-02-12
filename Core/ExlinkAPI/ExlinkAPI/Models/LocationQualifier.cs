using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("LocationQualifier")]
[Index("LocationQualifier1", Name = "UQ_LocQual_Name", IsUnique = true)]
public partial class LocationQualifier
{
    [Key]
    [Column("LocationQualID")]
    public Guid LocationQualId { get; set; }

    [Column("LocationQualifier")]
    [StringLength(100)]
    public string LocationQualifier1 { get; set; } = null!;
}
