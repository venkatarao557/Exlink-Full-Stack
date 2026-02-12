using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("Currency")]
[Index("CurrencyUnit", Name = "UQ_Currency_Unit", IsUnique = true)]
public partial class Currency
{
    [Key]
    [Column("CurrencyID")]
    public Guid CurrencyId { get; set; }

    [StringLength(10)]
    public string CurrencyUnit { get; set; } = null!;

    [StringLength(100)]
    public string Description { get; set; } = null!;
}
