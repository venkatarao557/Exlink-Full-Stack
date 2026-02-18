namespace ExlinkAPI.DTOs
{
    public class CountryCommodityDto
    {
        public Guid CountryCommodityId { get; set; }
        public string CountryCode { get; set; } = null!;
        public string CountryName { get; set; } = null!;
        public string? Commodities { get; set; }
    }
}
