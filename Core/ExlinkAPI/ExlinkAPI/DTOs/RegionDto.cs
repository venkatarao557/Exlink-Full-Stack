namespace ExlinkAPI.DTOs
{
    public class RegionDto
    {
        public Guid RegionId { get; set; }
        public string RegionCode { get; set; } = null!;
        public string RegionName { get; set; } = null!;
        public string? Commodities { get; set; }
    }
}