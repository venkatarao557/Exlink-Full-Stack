using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("RFPStatus")]
[Index("StatusCode", Name = "UQ_RFPStatus_Code", IsUnique = true)]
public partial class Rfpstatus
{
    [Key]
    [Column("StatusID")]
    public Guid StatusId { get; set; }

    [StringLength(10)]
    public string StatusCode { get; set; } = null!;

    [StringLength(100)]
    public string Description { get; set; } = null!;
}
