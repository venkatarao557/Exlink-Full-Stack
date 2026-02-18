namespace ExlinkAPI.DTOs
{
    public class CutTypeDto
    {
        public Guid CutTypeId { get; set; }
        public Guid? CommodityId { get; set; }
        public string CutCode { get; set; } = null!;
        public string Description { get; set; } = null!;
        public string? BoneInIndicator { get; set; }
        public string? BeefVealIndicator { get; set; }
        public string? ChemicalLeanIndicator { get; set; }
    }
}