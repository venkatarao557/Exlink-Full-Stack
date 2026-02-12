using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("NatureOfCommodity")]
[Index("NatureOfCommodityCode", Name = "UQ_CommNature_Code", IsUnique = true)]
public partial class NatureOfCommodity
{
    [Key]
    [Column("NatureID")]
    public Guid NatureId { get; set; }

    [StringLength(10)]
    public string NatureOfCommodityCode { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;
}
