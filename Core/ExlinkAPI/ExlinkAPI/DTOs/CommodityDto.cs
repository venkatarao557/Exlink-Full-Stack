namespace ExlinkAPI.DTOs
{
    public class CommodityDto
    {
        public Guid CommodityId { get; set; }
        public string CommodityCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}