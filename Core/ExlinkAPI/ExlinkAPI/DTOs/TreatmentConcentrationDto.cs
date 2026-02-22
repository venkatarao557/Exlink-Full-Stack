namespace ExlinkAPI.DTOs
{
    public class TreatmentConcentrationDto
    {
        public Guid ConcentrationUnitId { get; set; }
        public string UnitCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}