namespace ExlinkAPI.DTOs
{
    public class TreatmentDto
    {
        public Guid TreatmentId { get; set; }
        public string TreatmentCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}