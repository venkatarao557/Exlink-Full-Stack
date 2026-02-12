using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("IntendedUse")]
[Index("UseCode", Name = "UQ_IntendedUse_Code", IsUnique = true)]
public partial class IntendedUse
{
    [Key]
    [Column("IntendedUseID")]
    public Guid IntendedUseId { get; set; }

    [StringLength(4)]
    [Unicode(false)]
    public string UseCode { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;
}
