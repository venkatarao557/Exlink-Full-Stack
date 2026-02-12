using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

[Table("PreservationType")]
[Index("PreservationCode", Name = "UQ_Preservation_Code", IsUnique = true)]
public partial class PreservationType
{
    [Key]
    [Column("PreservationTypeID")]
    public Guid PreservationTypeId { get; set; }

    [StringLength(1)]
    [Unicode(false)]
    public string PreservationCode { get; set; } = null!;

    [StringLength(50)]
    public string Description { get; set; } = null!;

    [InverseProperty("PreservationCodeNavigation")]
    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
