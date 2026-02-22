namespace ExlinkAPI.DTOs
{
    public class WeightUnitAlternateDto
    {
        public Guid WeightUnitAltId { get; set; }
        public string WeightUnit { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}