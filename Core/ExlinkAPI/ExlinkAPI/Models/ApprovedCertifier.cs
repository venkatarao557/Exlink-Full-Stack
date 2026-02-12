using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("ApprovedCertifier")]
[Index("CertifierCode", Name = "UQ_Certifier_Code", IsUnique = true)]
public partial class ApprovedCertifier
{
    [Key]
    [Column("CertifierID")]
    public Guid CertifierId { get; set; }

    [StringLength(10)]
    public string CertifierCode { get; set; } = null!;

    [StringLength(255)]
    public string CertifierName { get; set; } = null!;
}
