namespace ExlinkAPI.DTOs
{
    public class PackTypeDto
    {
        public Guid PackTypeId { get; set; }
        public string PackTypeCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}