using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("Product")]
public partial class Product
{
    [Key]
    [Column("ProductID")]
    public Guid ProductId { get; set; }

    [StringLength(5)]
    public string CommodityCode { get; set; } = null!;

    [StringLength(1)]
    [Unicode(false)]
    public string PreservationCode { get; set; } = null!;

    [StringLength(10)]
    public string ProductTypeCode { get; set; } = null!;

    [StringLength(10)]
    public string PackTypeCode { get; set; } = null!;

    [StringLength(10)]
    public string SupplementaryCode { get; set; } = null!;

    [ForeignKey("CommodityCode")]
    [InverseProperty("Products")]
    public virtual Commodity CommodityCodeNavigation { get; set; } = null!;

    [ForeignKey("PackTypeCode")]
    [InverseProperty("Products")]
    public virtual PackType PackTypeCodeNavigation { get; set; } = null!;

    [ForeignKey("PreservationCode")]
    [InverseProperty("Products")]
    public virtual PreservationType PreservationCodeNavigation { get; set; } = null!;
}
