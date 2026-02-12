using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("PackType")]
[Index("PackTypeCode", Name = "UQ_PackType_Code", IsUnique = true)]
public partial class PackType
{
    [Key]
    [Column("PackTypeID")]
    public Guid PackTypeId { get; set; }

    [StringLength(10)]
    public string PackTypeCode { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;

    [InverseProperty("PackTypeCodeNavigation")]
    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
