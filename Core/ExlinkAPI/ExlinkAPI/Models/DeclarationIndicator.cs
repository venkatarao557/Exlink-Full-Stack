using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("DeclarationIndicator")]
[Index("IndicatorCode", Name = "UQ_DeclInd_Code", IsUnique = true)]
public partial class DeclarationIndicator
{
    [Key]
    [Column("DeclarationID")]
    public Guid DeclarationId { get; set; }

    [StringLength(1)]
    [Unicode(false)]
    public string IndicatorCode { get; set; } = null!;

    [StringLength(100)]
    public string Description { get; set; } = null!;
}
