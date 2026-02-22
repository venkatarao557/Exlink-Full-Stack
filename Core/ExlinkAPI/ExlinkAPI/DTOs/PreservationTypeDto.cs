namespace ExlinkAPI.DTOs
{
    public class PreservationTypeDto
    {
        public Guid PreservationTypeId { get; set; }
        public string PreservationCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}