using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("Port")]
[Index("PortName", Name = "IX_Port_Name")]
[Index("PortCode", Name = "UQ_Port_Code", IsUnique = true)]
public partial class Port
{
    [Key]
    [Column("PortID")]
    public Guid PortId { get; set; }

    [StringLength(10)]
    public string PortCode { get; set; } = null!;

    [StringLength(150)]
    public string PortName { get; set; } = null!;
}
