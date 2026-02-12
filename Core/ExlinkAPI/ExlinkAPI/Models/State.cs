using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("State")]
[Index("StateCode", Name = "UQ_State_Code", IsUnique = true)]
public partial class State
{
    [Key]
    [Column("StateID")]
    public Guid StateId { get; set; }

    [StringLength(3)]
    [Unicode(false)]
    public string StateCode { get; set; } = null!;

    [StringLength(100)]
    public string StateName { get; set; } = null!;
}
