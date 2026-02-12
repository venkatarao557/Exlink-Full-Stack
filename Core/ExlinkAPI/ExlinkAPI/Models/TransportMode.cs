using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("TransportMode")]
[Index("ModeCode", Name = "UQ_TransMode_Code", IsUnique = true)]
public partial class TransportMode
{
    [Key]
    [Column("TransportModeID")]
    public Guid TransportModeId { get; set; }

    public int ModeCode { get; set; }

    [StringLength(50)]
    public string Description { get; set; } = null!;
}
