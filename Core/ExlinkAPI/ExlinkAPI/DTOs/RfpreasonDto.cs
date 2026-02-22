namespace ExlinkAPI.DTOs
{
    public class RfpreasonDto
    {
        public Guid ReasonId { get; set; }
        public int ReasonCode { get; set; } 
        public string Description { get; set; } = null!;
    }
}