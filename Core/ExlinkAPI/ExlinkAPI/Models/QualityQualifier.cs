using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("QualityQualifier")]
[Index("QualityQualifier1", Name = "UQ_QualityQual_Name", IsUnique = true)]
public partial class QualityQualifier
{
    [Key]
    [Column("QualityQualifierID")]
    public Guid QualityQualifierId { get; set; }

    [Column("QualityQualifier")]
    [StringLength(100)]
    public string QualityQualifier1 { get; set; } = null!;
}
