namespace ExlinkAPI.DTOs
{
    public class SupplementaryCodeDto
    {
        public Guid SupplementaryCodeId { get; set; }
        public string SupplementaryCode1 { get; set; } = null!;
        public string Description { get; set; } = null!;
        public string? ApplicableCommodities { get; set; }
    }
}