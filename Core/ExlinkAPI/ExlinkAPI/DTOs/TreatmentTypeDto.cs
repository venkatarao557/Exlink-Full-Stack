namespace ExlinkAPI.DTOs
{
    public class TreatmentTypeDto
    {
        public Guid TreatmentTypeId { get; set; }
        public string TreatmentTypeCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}