namespace ExlinkAPI.DTOs
{
    public class CountryDto
    {
        public Guid CountryId { get; set; }
        public string CountryCode { get; set; } = null!;
        public string CountryName { get; set; } = null!;
    }
}
