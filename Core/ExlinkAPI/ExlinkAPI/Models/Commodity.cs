using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("Commodity")]
[Index("CommodityCode", Name = "UQ_Commodity_Code", IsUnique = true)]
[Index("CommodityId", Name = "UQ_Commodity_ID", IsUnique = true)]
public partial class Commodity
{
    [Key]
    [Column("CommodityID")]
    public Guid CommodityId { get; set; }

    [StringLength(5)]
    public string CommodityCode { get; set; } = null!;

    [StringLength(100)]
    public string Description { get; set; } = null!;

    [InverseProperty("CommodityCodeNavigation")]
    public virtual ICollection<ProductType> ProductTypes { get; set; } = new List<ProductType>();

    [InverseProperty("CommodityCodeNavigation")]
    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
