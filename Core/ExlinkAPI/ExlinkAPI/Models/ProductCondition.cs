using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("ProductCondition")]
[Index("ConditionCode", Name = "UQ_ProdCondition_Code", IsUnique = true)]
public partial class ProductCondition
{
    [Key]
    [Column("ConditionID")]
    public Guid ConditionId { get; set; }

    [StringLength(4)]
    [Unicode(false)]
    public string ConditionCode { get; set; } = null!;

    [StringLength(100)]
    public string ConditionName { get; set; } = null!;
}
