using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("TreatmentConcentration")]
[Index("UnitCode", Name = "UQ_TreatConcUnit_Code", IsUnique = true)]
public partial class TreatmentConcentration
{
    [Key]
    [Column("ConcentrationUnitID")]
    public Guid ConcentrationUnitId { get; set; }

    [StringLength(10)]
    public string UnitCode { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;
}
