namespace ExlinkAPI.DTOs
{
    public class EUCountryDto
    {
        public Guid EUCountryId { get; set; }
        public string EUCountryCode { get; set; } = null!;
        public string EUCountryName { get; set; } = null!;
    }
}