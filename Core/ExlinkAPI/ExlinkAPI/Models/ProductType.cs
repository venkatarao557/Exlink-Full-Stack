using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("ProductType")]
[Index("CommodityCode", "ProductTypeCode", Name = "UQ_ProductType_Commodity_Product", IsUnique = true)]
public partial class ProductType
{
    [Key]
    [Column("ProductTypeID")]
    public Guid ProductTypeId { get; set; }

    [StringLength(5)]
    public string CommodityCode { get; set; } = null!;

    [StringLength(10)]
    public string ProductTypeCode { get; set; } = null!;

    [StringLength(255)]
    public string Description { get; set; } = null!;

    [StringLength(500)]
    public string? ScientificName { get; set; }

    [ForeignKey("CommodityCode")]
    [InverseProperty("ProductTypes")]
    public virtual Commodity CommodityCodeNavigation { get; set; } = null!;
}
