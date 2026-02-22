namespace ExlinkAPI.DTOs
{
    public class ProductClassificationDto
    {
        public Guid ProductClassificationId { get; set; }
        public string Cncode { get; set; } = null!;
        public string Ahecc { get; set; } = null!;
        public string Description { get; set; } = null!;
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
    }
}