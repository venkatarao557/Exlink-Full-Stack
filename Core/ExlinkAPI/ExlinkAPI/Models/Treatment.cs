using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("Treatment")]
[Index("TreatmentCode", Name = "UQ_Treatment_Code", IsUnique = true)]
public partial class Treatment
{
    [Key]
    [Column("TreatmentID")]
    public Guid TreatmentId { get; set; }

    [StringLength(10)]
    public string TreatmentCode { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;
}
