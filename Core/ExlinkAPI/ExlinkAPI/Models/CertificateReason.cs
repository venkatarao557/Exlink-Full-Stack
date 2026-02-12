using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("CertificateReason")]
[Index("ReasonCode", Name = "UQ_CertReason_Code", IsUnique = true)]
public partial class CertificateReason
{
    [Key]
    [Column("ReasonID")]
    public Guid ReasonId { get; set; }

    public int ReasonCode { get; set; }

    [StringLength(100)]
    public string Description { get; set; } = null!;
}
