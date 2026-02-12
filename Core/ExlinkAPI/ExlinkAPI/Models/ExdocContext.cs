using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Models;

public partial class ExdocContext : DbContext
{
    public ExdocContext()
    {
    }

    public ExdocContext(DbContextOptions<ExdocContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AheccproductMapping> AheccproductMappings { get; set; }

    public virtual DbSet<ApprovedCertifier> ApprovedCertifiers { get; set; }

    public virtual DbSet<CertificatePrintIndicator> CertificatePrintIndicators { get; set; }

    public virtual DbSet<CertificateReason> CertificateReasons { get; set; }

    public virtual DbSet<CertificateRequestStatus> CertificateRequestStatuses { get; set; }

    public virtual DbSet<Commodity> Commodities { get; set; }

    public virtual DbSet<Country> Countries { get; set; }

    public virtual DbSet<CountryCommodity> CountryCommodities { get; set; }

    public virtual DbSet<Currency> Currencies { get; set; }

    public virtual DbSet<CustomsWeightUnit> CustomsWeightUnits { get; set; }

    public virtual DbSet<CutType> CutTypes { get; set; }

    public virtual DbSet<DeclarationIndicator> DeclarationIndicators { get; set; }

    public virtual DbSet<DominantProduct> DominantProducts { get; set; }

    public virtual DbSet<Eucountry> Eucountries { get; set; }

    public virtual DbSet<IntendedUse> IntendedUses { get; set; }

    public virtual DbSet<LocationQualifier> LocationQualifiers { get; set; }

    public virtual DbSet<NatureOfCommodity> NatureOfCommodities { get; set; }

    public virtual DbSet<PackType> PackTypes { get; set; }

    public virtual DbSet<PackageType> PackageTypes { get; set; }

    public virtual DbSet<Port> Ports { get; set; }

    public virtual DbSet<PreservationType> PreservationTypes { get; set; }

    public virtual DbSet<ProcessType> ProcessTypes { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductClassification> ProductClassifications { get; set; }

    public virtual DbSet<ProductCondition> ProductConditions { get; set; }

    public virtual DbSet<ProductPart> ProductParts { get; set; }

    public virtual DbSet<ProductType> ProductTypes { get; set; }

    public virtual DbSet<ProductUseIndicator> ProductUseIndicators { get; set; }

    public virtual DbSet<QualityQualifier> QualityQualifiers { get; set; }

    public virtual DbSet<Region> Regions { get; set; }

    public virtual DbSet<RegionalOffice> RegionalOffices { get; set; }

    public virtual DbSet<RegulatoryDocument> RegulatoryDocuments { get; set; }

    public virtual DbSet<Rfpreason> Rfpreasons { get; set; }

    public virtual DbSet<Rfpstatus> Rfpstatuses { get; set; }

    public virtual DbSet<State> States { get; set; }

    public virtual DbSet<SupplementaryCode> SupplementaryCodes { get; set; }

    public virtual DbSet<TransportMode> TransportModes { get; set; }

    public virtual DbSet<Treatment> Treatments { get; set; }

    public virtual DbSet<TreatmentConcentration> TreatmentConcentrations { get; set; }

    public virtual DbSet<TreatmentIngredient> TreatmentIngredients { get; set; }

    public virtual DbSet<TreatmentType> TreatmentTypes { get; set; }

    public virtual DbSet<UnitOfMeasure> UnitOfMeasures { get; set; }

    public virtual DbSet<Usterritory> Usterritories { get; set; }

    public virtual DbSet<WeightUnitAlternate> WeightUnitAlternates { get; set; }

    public virtual DbSet<WeightUnitShort> WeightUnitShorts { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=exlink;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=False;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AheccproductMapping>(entity =>
        {
            entity.Property(e => e.MappingId).HasDefaultValueSql("(newsequentialid())");

            entity.HasOne(d => d.CutCodeNavigation).WithMany()
                .HasPrincipalKey(p => p.CutCode)
                .HasForeignKey(d => d.CutCode)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_AHECC_CutType_Code");
        });

        modelBuilder.Entity<ApprovedCertifier>(entity =>
        {
            entity.HasKey(e => e.CertifierId).HasName("PK__Approved__441EF627AF59B9AE");

            entity.Property(e => e.CertifierId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<CertificatePrintIndicator>(entity =>
        {
            entity.HasKey(e => e.PrintIndicatorId).HasName("PK__Certific__7BF37815F6E652AB");

            entity.Property(e => e.PrintIndicatorId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.IndicatorCode).IsFixedLength();
        });

        modelBuilder.Entity<CertificateReason>(entity =>
        {
            entity.HasKey(e => e.ReasonId).HasName("PK__Certific__A4F8C0C76B50204D");

            entity.Property(e => e.ReasonId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<CertificateRequestStatus>(entity =>
        {
            entity.HasKey(e => e.RequestStatusId).HasName("PK__Certific__7094B7BB3F02F344");

            entity.Property(e => e.RequestStatusId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.DateEffective).HasDefaultValueSql("(getdate())");
            entity.Property(e => e.StatusCode).IsFixedLength();
        });

        modelBuilder.Entity<Commodity>(entity =>
        {
            entity.HasKey(e => e.CommodityId).HasName("PK__Commodit__5C5A915AFDE0204D");

            entity.Property(e => e.CommodityId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<Country>(entity =>
        {
            entity.HasKey(e => e.CountryId).HasName("PK__Country__10D160BF5A2E334B");

            entity.Property(e => e.CountryId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<CountryCommodity>(entity =>
        {
            entity.HasKey(e => e.CountryCommodityId).HasName("PK__CountryC__963F302A57997E5C");

            entity.Property(e => e.CountryCommodityId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<Currency>(entity =>
        {
            entity.HasKey(e => e.CurrencyId).HasName("PK__Currency__14470B10D803B9E4");

            entity.Property(e => e.CurrencyId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<CustomsWeightUnit>(entity =>
        {
            entity.HasKey(e => e.CustomsWeightId).HasName("PK__CustomsW__6FDB75E0EDC183A4");

            entity.Property(e => e.CustomsWeightId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<CutType>(entity =>
        {
            entity.HasKey(e => e.CutTypeId).HasName("PK__CutType__8A6E18ABC547693B");

            entity.Property(e => e.CutTypeId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.BeefVealIndicator).IsFixedLength();
            entity.Property(e => e.BoneInIndicator).IsFixedLength();
            entity.Property(e => e.ChemicalLeanIndicator).IsFixedLength();
        });

        modelBuilder.Entity<DeclarationIndicator>(entity =>
        {
            entity.HasKey(e => e.DeclarationId).HasName("PK__Declarat__B4AA37BFA6101728");

            entity.Property(e => e.DeclarationId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.IndicatorCode).IsFixedLength();
        });

        modelBuilder.Entity<DominantProduct>(entity =>
        {
            entity.HasKey(e => e.DominantProductId).HasName("PK__Dominant__CDED510CFFC6372B");

            entity.Property(e => e.DominantProductId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<Eucountry>(entity =>
        {
            entity.HasKey(e => e.EucountryId).HasName("PK__EUCountr__2ABEECCD107475D7");

            entity.Property(e => e.EucountryId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<IntendedUse>(entity =>
        {
            entity.HasKey(e => e.IntendedUseId).HasName("PK__Intended__D6121A9E733E5855");

            entity.Property(e => e.IntendedUseId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.UseCode).IsFixedLength();
        });

        modelBuilder.Entity<LocationQualifier>(entity =>
        {
            entity.HasKey(e => e.LocationQualId).HasName("PK__Location__AB358A345D387F1C");

            entity.Property(e => e.LocationQualId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<NatureOfCommodity>(entity =>
        {
            entity.HasKey(e => e.NatureId).HasName("PK__NatureOf__B61719D1656B141E");

            entity.Property(e => e.NatureId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<PackType>(entity =>
        {
            entity.HasKey(e => e.PackTypeId).HasName("PK__PackType__6FF8FC9CE25836AF");

            entity.Property(e => e.PackTypeId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<PackageType>(entity =>
        {
            entity.HasKey(e => e.PackageTypeId).HasName("PK__PackageT__0557DC702EE2BFFB");

            entity.Property(e => e.PackageTypeId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<Port>(entity =>
        {
            entity.HasKey(e => e.PortId).HasName("PK__Port__D859BFAF69C9F0C3");

            entity.Property(e => e.PortId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<PreservationType>(entity =>
        {
            entity.HasKey(e => e.PreservationTypeId).HasName("PK__Preserva__EE0D7FE3D2D4B063");

            entity.Property(e => e.PreservationTypeId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.PreservationCode).IsFixedLength();
        });

        modelBuilder.Entity<ProcessType>(entity =>
        {
            entity.HasKey(e => e.ProcessTypeId).HasName("PK__ProcessT__E0D195C4E8ECA459");

            entity.Property(e => e.ProcessTypeId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.ProductId).HasName("PK__Product__B40CC6ED200E708D");

            entity.Property(e => e.ProductId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.PreservationCode).IsFixedLength();

            entity.HasOne(d => d.CommodityCodeNavigation).WithMany(p => p.Products)
                .HasPrincipalKey(p => p.CommodityCode)
                .HasForeignKey(d => d.CommodityCode)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Product_Comm");

            entity.HasOne(d => d.PackTypeCodeNavigation).WithMany(p => p.Products)
                .HasPrincipalKey(p => p.PackTypeCode)
                .HasForeignKey(d => d.PackTypeCode)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Product_Pack");

            entity.HasOne(d => d.PreservationCodeNavigation).WithMany(p => p.Products)
                .HasPrincipalKey(p => p.PreservationCode)
                .HasForeignKey(d => d.PreservationCode)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Product_Pres");
        });

        modelBuilder.Entity<ProductClassification>(entity =>
        {
            entity.HasKey(e => e.ProductClassificationId).HasName("PK__ProductC__9E4F323CF094727C");

            entity.Property(e => e.ProductClassificationId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<ProductCondition>(entity =>
        {
            entity.HasKey(e => e.ConditionId).HasName("PK__ProductC__37F5C0EF65283D26");

            entity.Property(e => e.ConditionId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.ConditionCode).IsFixedLength();
        });

        modelBuilder.Entity<ProductPart>(entity =>
        {
            entity.HasKey(e => e.ProductPartId).HasName("PK__ProductP__6D371D64D59EB138");

            entity.Property(e => e.ProductPartId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.PartCode).IsFixedLength();
        });

        modelBuilder.Entity<ProductType>(entity =>
        {
            entity.HasKey(e => e.ProductTypeId).HasName("PK__ProductT__A1312F4EE22BD8AA");

            entity.Property(e => e.ProductTypeId).HasDefaultValueSql("(newsequentialid())");

            entity.HasOne(d => d.CommodityCodeNavigation).WithMany(p => p.ProductTypes)
                .HasPrincipalKey(p => p.CommodityCode)
                .HasForeignKey(d => d.CommodityCode)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ProductType_Commodity");
        });

        modelBuilder.Entity<ProductUseIndicator>(entity =>
        {
            entity.HasKey(e => e.ProductUseId).HasName("PK__ProductU__F0495CC34E0C38C8");

            entity.Property(e => e.ProductUseId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.UseCode).IsFixedLength();
        });

        modelBuilder.Entity<QualityQualifier>(entity =>
        {
            entity.HasKey(e => e.QualityQualifierId).HasName("PK__QualityQ__42642370B92AFE49");

            entity.Property(e => e.QualityQualifierId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<Region>(entity =>
        {
            entity.HasKey(e => e.RegionId).HasName("PK__Region__ACD844432BA3B3E9");

            entity.Property(e => e.RegionId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<RegionalOffice>(entity =>
        {
            entity.HasKey(e => e.OfficeId).HasName("PK__Regional__4B61930F95E6ACF4");

            entity.Property(e => e.OfficeId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<RegulatoryDocument>(entity =>
        {
            entity.HasKey(e => e.RegulatoryDocId).HasName("PK__Regulato__E420DFA1DE26A199");

            entity.Property(e => e.RegulatoryDocId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<Rfpreason>(entity =>
        {
            entity.HasKey(e => e.ReasonId).HasName("PK__RFPReaso__A4F8C0C7EA10BB78");

            entity.Property(e => e.ReasonId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<Rfpstatus>(entity =>
        {
            entity.HasKey(e => e.StatusId).HasName("PK__RFPStatu__C8EE204364D92D8E");

            entity.Property(e => e.StatusId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<State>(entity =>
        {
            entity.HasKey(e => e.StateId).HasName("PK__State__C3BA3B5A215A9CC3");

            entity.Property(e => e.StateId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.StateCode).IsFixedLength();
        });

        modelBuilder.Entity<SupplementaryCode>(entity =>
        {
            entity.HasKey(e => e.SupplementaryCodeId).HasName("PK__Suppleme__C7ECFCA9CDD1B897");

            entity.Property(e => e.SupplementaryCodeId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<TransportMode>(entity =>
        {
            entity.HasKey(e => e.TransportModeId).HasName("PK__Transpor__E9EEC47A60F18BB5");

            entity.Property(e => e.TransportModeId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<Treatment>(entity =>
        {
            entity.HasKey(e => e.TreatmentId).HasName("PK__Treatmen__1A57B71199FC2244");

            entity.Property(e => e.TreatmentId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<TreatmentConcentration>(entity =>
        {
            entity.HasKey(e => e.ConcentrationUnitId).HasName("PK__Treatmen__650AA81D2006B2EE");

            entity.Property(e => e.ConcentrationUnitId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<TreatmentIngredient>(entity =>
        {
            entity.HasKey(e => e.IngredientId).HasName("PK__Treatmen__BEAEB27AA28EFC19");

            entity.Property(e => e.IngredientId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<TreatmentType>(entity =>
        {
            entity.HasKey(e => e.TreatmentTypeId).HasName("PK__Treatmen__F3EDE179A476D428");

            entity.Property(e => e.TreatmentTypeId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<UnitOfMeasure>(entity =>
        {
            entity.HasKey(e => e.Uomid).HasName("PK__UnitOfMe__9825D9FBA4A395A8");

            entity.Property(e => e.Uomid).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<Usterritory>(entity =>
        {
            entity.HasKey(e => e.UsterritoryId).HasName("PK__USTerrit__EEA4F618CB957B21");

            entity.Property(e => e.UsterritoryId).HasDefaultValueSql("(newsequentialid())");
            entity.Property(e => e.CountryCode).IsFixedLength();
        });

        modelBuilder.Entity<WeightUnitAlternate>(entity =>
        {
            entity.HasKey(e => e.WeightUnitAltId).HasName("PK__WeightUn__2DF98689142B960F");

            entity.Property(e => e.WeightUnitAltId).HasDefaultValueSql("(newsequentialid())");
        });

        modelBuilder.Entity<WeightUnitShort>(entity =>
        {
            entity.HasKey(e => e.WeightUnitShortId).HasName("PK__WeightUn__92B5B8F0C465E3E9");

            entity.Property(e => e.WeightUnitShortId).HasDefaultValueSql("(newsequentialid())");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
