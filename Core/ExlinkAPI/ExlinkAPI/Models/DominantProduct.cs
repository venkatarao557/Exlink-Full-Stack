using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("DominantProduct")]
[Index("ProductName", Name = "UQ_DominantProduct_Name", IsUnique = true)]
public partial class DominantProduct
{
    [Key]
    [Column("DominantProductID")]
    public Guid DominantProductId { get; set; }

    [StringLength(100)]
    public string ProductName { get; set; } = null!;
}
