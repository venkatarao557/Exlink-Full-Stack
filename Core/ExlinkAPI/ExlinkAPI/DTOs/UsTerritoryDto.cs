namespace ExlinkAPI.DTOs
{
    public class UsTerritoryDto
    {
        public Guid UsTerritoryId { get; set; }
        public string CountryCode { get; set; } = null!;
        public string CountryName { get; set; } = null!;
    }
}