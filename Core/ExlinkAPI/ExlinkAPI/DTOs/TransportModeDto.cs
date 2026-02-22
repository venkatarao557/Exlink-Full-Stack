namespace ExlinkAPI.DTOs
{
    public class TransportModeDto
    {
        public Guid TransportModeId { get; set; }
        public int ModeCode { get; set; }
        public string Description { get; set; } = null!;
    }
}