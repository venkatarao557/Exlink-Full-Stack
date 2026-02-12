using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("PackageType")]
[Index("PackageTypeCode", Name = "UQ_PackageType_Code", IsUnique = true)]
public partial class PackageType
{
    [Key]
    [Column("PackageTypeID")]
    public Guid PackageTypeId { get; set; }

    [StringLength(10)]
    public string PackageTypeCode { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;
}
