namespace ExlinkAPI.DTOs
{
    public class RegionalOfficeDto
    {
        public Guid OfficeId { get; set; }
        public string OfficeCode { get; set; } = null!;
        public string OfficeName { get; set; } = null!;
        public string OfficeType { get; set; } = null!; // e.g., Regional, State
    }
}