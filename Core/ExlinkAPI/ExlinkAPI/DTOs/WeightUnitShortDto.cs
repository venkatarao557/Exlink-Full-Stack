namespace ExlinkAPI.DTOs
{
    public class WeightUnitShortDto
    {
        public Guid WeightUnitShortId { get; set; }
        public string WeightUnit { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}