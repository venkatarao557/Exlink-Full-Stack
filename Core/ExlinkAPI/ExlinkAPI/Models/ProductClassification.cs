using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("ProductClassification")]
[Index("Ahecc", Name = "IX_ProdClass_AHECC")]
public partial class ProductClassification
{
    [Key]
    [Column("ProductClassificationID")]
    public Guid ProductClassificationId { get; set; }

    [Column("CNCode")]
    [StringLength(20)]
    public string Cncode { get; set; } = null!;

    [Column("AHECC")]
    [StringLength(20)]
    public string Ahecc { get; set; } = null!;

    public string Description { get; set; } = null!;

    public DateTime StartDate { get; set; }

    public DateTime? EndDate { get; set; }
}
