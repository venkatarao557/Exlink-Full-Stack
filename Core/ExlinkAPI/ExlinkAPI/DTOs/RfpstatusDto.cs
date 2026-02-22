namespace ExlinkAPI.DTOs
{
    public class RfpstatusDto
    {
        public Guid StatusId { get; set; }
        public string StatusCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}