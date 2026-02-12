using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("TreatmentType")]
[Index("TreatmentTypeCode", Name = "UQ_TreatmentType_Code", IsUnique = true)]
public partial class TreatmentType
{
    [Key]
    [Column("TreatmentTypeID")]
    public Guid TreatmentTypeId { get; set; }

    [StringLength(10)]
    public string TreatmentTypeCode { get; set; } = null!;

    [StringLength(100)]
    public string Description { get; set; } = null!;
}
