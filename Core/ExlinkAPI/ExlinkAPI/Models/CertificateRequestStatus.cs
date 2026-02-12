using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("CertificateRequestStatus")]
[Index("StatusCode", Name = "UQ_CertReqStatus_Code", IsUnique = true)]
public partial class CertificateRequestStatus
{
    [Key]
    [Column("RequestStatusID")]
    public Guid RequestStatusId { get; set; }

    [StringLength(1)]
    [Unicode(false)]
    public string StatusCode { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;

    public DateTime? DateEffective { get; set; }
}
