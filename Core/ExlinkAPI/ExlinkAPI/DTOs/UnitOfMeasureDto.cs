namespace ExlinkAPI.DTOs
{
    public class UnitOfMeasureDto
    {
        public Guid UnitOfMeasureId { get; set; }
        public string UnitCode { get; set; } = null!;
        public string UnitType { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}