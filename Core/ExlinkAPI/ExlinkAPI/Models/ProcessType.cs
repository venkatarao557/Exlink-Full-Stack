using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("ProcessType")]
[Index("ProcessTypeCode", Name = "UQ_ProcessType_Code", IsUnique = true)]
public partial class ProcessType
{
    [Key]
    [Column("ProcessTypeID")]
    public Guid ProcessTypeId { get; set; }

    [StringLength(10)]
    public string ProcessTypeCode { get; set; } = null!;

    [StringLength(100)]
    public string Description { get; set; } = null!;
}
