namespace ExlinkAPI.DTOs
{
    public class ProductDto
    {
        public Guid ProductId { get; set; }
        public string CommodityCode { get; set; } = null!;
        public string? CommodityDescription { get; set; }
        public string PreservationCode { get; set; } = null!;
        public string? PreservationDescription { get; set; }
        public string ProductTypeCode { get; set; } = null!;
        public string PackTypeCode { get; set; } = null!;
        public string? PackTypeDescription { get; set; }
        public string SupplementaryCode { get; set; } = null!;
    }
}