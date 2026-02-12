using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("ProductPart")]
[Index("PartCode", Name = "UQ_ProdPart_Code", IsUnique = true)]
public partial class ProductPart
{
    [Key]
    [Column("ProductPartID")]
    public Guid ProductPartId { get; set; }

    [StringLength(4)]
    [Unicode(false)]
    public string PartCode { get; set; } = null!;

    [StringLength(100)]
    public string PartName { get; set; } = null!;
}
