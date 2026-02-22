namespace ExlinkAPI.DTOs
{
    public class ProcessTypeDto
    {
        public Guid ProcessTypeId { get; set; }
        public string ProcessTypeCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}