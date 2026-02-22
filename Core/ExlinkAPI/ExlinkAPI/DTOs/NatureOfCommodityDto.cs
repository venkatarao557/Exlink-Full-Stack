namespace ExlinkAPI.DTOs
{
    public class NatureOfCommodityDto
    {
        public Guid NatureId { get; set; }
        public string NatureOfCommodityCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}