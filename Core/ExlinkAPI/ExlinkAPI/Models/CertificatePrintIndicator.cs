using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("CertificatePrintIndicator")]
[Index("IndicatorCode", Name = "UQ_CertPrint_Code", IsUnique = true)]
public partial class CertificatePrintIndicator
{
    [Key]
    [Column("PrintIndicatorID")]
    public Guid PrintIndicatorId { get; set; }

    [StringLength(1)]
    [Unicode(false)]
    public string IndicatorCode { get; set; } = null!;

    [StringLength(100)]
    public string Description { get; set; } = null!;
}
