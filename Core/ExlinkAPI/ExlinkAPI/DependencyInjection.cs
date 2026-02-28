using Microsoft.Extensions.DependencyInjection;
using ExlinkAPI.Repositories.Interfaces;
using ExlinkAPI.Repositories.Implementations;

namespace ExlinkAPI.Extensions
{
    public static class RepositoryServiceExtensions
    {
        public static IServiceCollection AddProjectRepositories(this IServiceCollection services)
        {
            // A - C
            services.AddScoped<IAheccMappingRepository, AheccMappingRepository>();
            services.AddScoped<IApprovedCertifierRepository, ApprovedCertifierRepository>();
            services.AddScoped<ICertificatePrintIndicatorRepository, CertificatePrintIndicatorRepository>();
            services.AddScoped<ICertificateReasonRepository, CertificateReasonRepository>();
            services.AddScoped<ICertificateRequestStatusRepository, CertificateRequestStatusRepository>();
            services.AddScoped<ICommodityRepository, CommodityRepository>();
            services.AddScoped<ICountryRepository, CountryRepository>();
            services.AddScoped<ICountryCommodityRepository, CountryCommodityRepository>();
            services.AddScoped<ICurrencyRepository, CurrencyRepository>();
            services.AddScoped<ICustomsWeightUnitRepository, CustomsWeightUnitRepository>();
            services.AddScoped<ICutTypeRepository, CutTypeRepository>();

            // D - L
            services.AddScoped<IDeclarationIndicatorRepository, DeclarationIndicatorRepository>();
            services.AddScoped<IDominantProductRepository, DominantProductRepository>();
            services.AddScoped<IEUCountryRepository, EUCountryRepository>();
            services.AddScoped<IIntendedUseRepository, IntendedUseRepository>();
            services.AddScoped<ILocationQualifierRepository, LocationQualifierRepository>();

            // N - P
            services.AddScoped<INatureOfCommodityRepository, NatureOfCommodityRepository>();
            services.AddScoped<IPackageTypeRepository, PackageTypeRepository>();
            services.AddScoped<IPackTypeRepository, PackTypeRepository>();
            services.AddScoped<IPortRepository, PortRepository>();
            services.AddScoped<IPreservationTypeRepository, PreservationTypeRepository>();
            services.AddScoped<IProcessTypeRepository, ProcessTypeRepository>();
            services.AddScoped<IProductClassificationRepository, ProductClassificationRepository>();
            services.AddScoped<IProductRepository, ProductRepository>();
            services.AddScoped<IProductUseIndicatorRepository, ProductUseIndicatorRepository>();

            // Q - S
            services.AddScoped<IQualityQualifierRepository, QualityQualifierRepository>();
            services.AddScoped<IRegionalOfficeRepository, RegionalOfficeRepository>();
            services.AddScoped<IRegionRepository, RegionRepository>();
            services.AddScoped<IRegulatoryDocumentRepository, RegulatoryDocumentRepository>();
            services.AddScoped<IRfpreasonRepository, RfpreasonRepository>();
            services.AddScoped<IRfpstatusRepository, RfpstatusRepository>();
            services.AddScoped<IStateRepository, StateRepository>();
            services.AddScoped<ISupplementaryCodeRepository, SupplementaryCodeRepository>();

            // T - W
            services.AddScoped<ITransportModeRepository, TransportModeRepository>();
            services.AddScoped<ITreatmentConcentrationRepository, TreatmentConcentrationRepository>();
            services.AddScoped<ITreatmentIngredientRepository, TreatmentIngredientRepository>();
            services.AddScoped<ITreatmentRepository, TreatmentRepository>();
            services.AddScoped<ITreatmentTypeRepository, TreatmentTypeRepository>();
            services.AddScoped<IUnitOfMeasureRepository, UnitOfMeasureRepository>();
            services.AddScoped<IUSTerritoryRepository, USTerritoryRepository>();
            services.AddScoped<IWeightUnitAlternateRepository, WeightUnitAlternateRepository>();
            services.AddScoped<IWeightUnitShortRepository, WeightUnitShortRepository>();

            return services;
        }
    }
}