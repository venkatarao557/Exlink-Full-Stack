namespace ExlinkAPI.DTOs
{
    public class PortDto
    {
        public Guid PortId { get; set; }
        public string PortCode { get; set; } = null!;
        public string PortName { get; set; } = null!;
    }
}