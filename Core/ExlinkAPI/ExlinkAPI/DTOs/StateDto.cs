namespace ExlinkAPI.DTOs
{
    public class StateDto
    {
        public Guid StateId { get; set; }
        public string StateCode { get; set; } = null!;
        public string StateName { get; set; } = null!;
    }
}