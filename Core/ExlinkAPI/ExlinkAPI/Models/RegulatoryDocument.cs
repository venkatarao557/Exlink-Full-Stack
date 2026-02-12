using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("RegulatoryDocument")]
[Index("DocumentTypeCode", Name = "UQ_RegDoc_Code", IsUnique = true)]
public partial class RegulatoryDocument
{
    [Key]
    [Column("RegulatoryDocID")]
    public Guid RegulatoryDocId { get; set; }

    [StringLength(10)]
    public string DocumentTypeCode { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;
}
