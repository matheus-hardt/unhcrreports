# Generate Quarto HTML / PDF Country Factsheets in Batch

This function renders the 'Country_Factsheet' Quarto template for a list
of countries, generating a report file for each.

## Usage

``` r
generate_report(
  type = "country",
  year = 2024,
  name = NULL,
  gp_provider = "azure",
  gp_model = "gpt-4.1-mini"
)
```

## Arguments

- type:

  either donor recipient or destination.

- year:

  year

- name:

  name of donor recipient or destination if NULL batch process them

- gp_provider:

  for instance "azure"

- gp_model:

  for instance "gpt-4.1-mini"

## Value

links to genrated reports.

## Examples

``` r
 # unhcrreports::generate_report(type = "country", name = "BRA", gp_provider ="azure", gp_model = "gpt-4.1-mini" )
# linkcountryreport <- generate_report(type = "country" )
# dput(linkcountryreport )

linkcountryreport <- c("[Profile Report for country: AFG](../reports/Analysis-country-afg-2024-report.html)", 
"[Profile Report for country: AGO](../reports/Analysis-country-ago-2024-report.html)", 
"[Profile Report for country: ARG](../reports/Analysis-country-arg-2024-report.html)", 
"[Profile Report for country: ARM](../reports/Analysis-country-arm-2024-report.html)", 
"[Profile Report for country: AUS](../reports/Analysis-country-aus-2024-report.html)", 
"[Profile Report for country: AUT](../reports/Analysis-country-aut-2024-report.html)", 
"[Profile Report for country: AZE](../reports/Analysis-country-aze-2024-report.html)", 
"[Profile Report for country: BDI](../reports/Analysis-country-bdi-2024-report.html)", 
"[Profile Report for country: BEL](../reports/Analysis-country-bel-2024-report.html)", 
"[Profile Report for country: BFA](../reports/Analysis-country-bfa-2024-report.html)", 
"[Profile Report for country: BGD](../reports/Analysis-country-bgd-2024-report.html)", 
"[Profile Report for country: BIH](../reports/Analysis-country-bih-2024-report.html)", 
"[Profile Report for country: BLR](../reports/Analysis-country-blr-2024-report.html)", 
"[Profile Report for country: BRA](../reports/Analysis-country-bra-2024-report.html)", 
"[Profile Report for country: CAF](../reports/Analysis-country-caf-2024-report.html)", 
"[Profile Report for country: CAN](../reports/Analysis-country-can-2024-report.html)", 
"[Profile Report for country: CHE](../reports/Analysis-country-che-2024-report.html)", 
"[Profile Report for country: CHL](../reports/Analysis-country-chl-2024-report.html)", 
"[Profile Report for country: CHN](../reports/Analysis-country-chn-2024-report.html)", 
"[Profile Report for country: CIV](../reports/Analysis-country-civ-2024-report.html)", 
"[Profile Report for country: CMR](../reports/Analysis-country-cmr-2024-report.html)", 
"[Profile Report for country: COD](../reports/Analysis-country-cod-2024-report.html)", 
"[Profile Report for country: COG](../reports/Analysis-country-cog-2024-report.html)", 
"[Profile Report for country: COL](../reports/Analysis-country-col-2024-report.html)", 
"[Profile Report for country: CRI](../reports/Analysis-country-cri-2024-report.html)", 
"[Profile Report for country: CYP](../reports/Analysis-country-cyp-2024-report.html)", 
"[Profile Report for country: CZE](../reports/Analysis-country-cze-2024-report.html)", 
"[Profile Report for country: DEU](../reports/Analysis-country-deu-2024-report.html)", 
"[Profile Report for country: DJI](../reports/Analysis-country-dji-2024-report.html)", 
"[Profile Report for country: DNK](../reports/Analysis-country-dnk-2024-report.html)", 
"[Profile Report for country: DOM](../reports/Analysis-country-dom-2024-report.html)", 
"[Profile Report for country: DZA](../reports/Analysis-country-dza-2024-report.html)", 
"[Profile Report for country: ECU](../reports/Analysis-country-ecu-2024-report.html)", 
"[Profile Report for country: EGY](../reports/Analysis-country-egy-2024-report.html)", 
"[Profile Report for country: ERI](../reports/Analysis-country-eri-2024-report.html)", 
"[Profile Report for country: ESP](../reports/Analysis-country-esp-2024-report.html)", 
"[Profile Report for country: EST](../reports/Analysis-country-est-2024-report.html)", 
"[Profile Report for country: ETH](../reports/Analysis-country-eth-2024-report.html)", 
"[Profile Report for country: FRA](../reports/Analysis-country-fra-2024-report.html)", 
"[Profile Report for country: GBR](../reports/Analysis-country-gbr-2024-report.html)", 
"[Profile Report for country: GEO](../reports/Analysis-country-geo-2024-report.html)", 
"[Profile Report for country: GHA](../reports/Analysis-country-gha-2024-report.html)", 
"[Profile Report for country: GIN](../reports/Analysis-country-gin-2024-report.html)", 
"[Profile Report for country: GRC](../reports/Analysis-country-grc-2024-report.html)", 
"[Profile Report for country: GTM](../reports/Analysis-country-gtm-2024-report.html)", 
"[Profile Report for country: HKG](../reports/Analysis-country-hkg-2024-report.html)", 
"[Profile Report for country: HND](../reports/Analysis-country-hnd-2024-report.html)", 
"[Profile Report for country: HRV](../reports/Analysis-country-hrv-2024-report.html)", 
"[Profile Report for country: HTI](../reports/Analysis-country-hti-2024-report.html)", 
"[Profile Report for country: IND](../reports/Analysis-country-ind-2024-report.html)", 
"[Profile Report for country: IRN](../reports/Analysis-country-irn-2024-report.html)", 
"[Profile Report for country: IRQ](../reports/Analysis-country-irq-2024-report.html)", 
"[Profile Report for country: ITA](../reports/Analysis-country-ita-2024-report.html)", 
"[Profile Report for country: JOR](../reports/Analysis-country-jor-2024-report.html)", 
"[Profile Report for country: KAZ](../reports/Analysis-country-kaz-2024-report.html)", 
"[Profile Report for country: KEN](../reports/Analysis-country-ken-2024-report.html)", 
"[Profile Report for country: KWT](../reports/Analysis-country-kwt-2024-report.html)", 
"[Profile Report for country: LBN](../reports/Analysis-country-lbn-2024-report.html)", 
"[Profile Report for country: LBR](../reports/Analysis-country-lbr-2024-report.html)", 
"[Profile Report for country: LBY](../reports/Analysis-country-lby-2024-report.html)", 
"[Profile Report for country: LKA](../reports/Analysis-country-lka-2024-report.html)", 
"[Profile Report for country: LVA](../reports/Analysis-country-lva-2024-report.html)", 
"[Profile Report for country: MEX](../reports/Analysis-country-mex-2024-report.html)", 
"[Profile Report for country: MLI](../reports/Analysis-country-mli-2024-report.html)", 
"[Profile Report for country: MMR](../reports/Analysis-country-mmr-2024-report.html)", 
"[Profile Report for country: MOZ](../reports/Analysis-country-moz-2024-report.html)", 
"[Profile Report for country: MRT](../reports/Analysis-country-mrt-2024-report.html)", 
"[Profile Report for country: MWI](../reports/Analysis-country-mwi-2024-report.html)", 
"[Profile Report for country: MYS](../reports/Analysis-country-mys-2024-report.html)", 
"[Profile Report for country: NER](../reports/Analysis-country-ner-2024-report.html)", 
"[Profile Report for country: NGA](../reports/Analysis-country-nga-2024-report.html)", 
"[Profile Report for country: NLD](../reports/Analysis-country-nld-2024-report.html)", 
"[Profile Report for country: NOR](../reports/Analysis-country-nor-2024-report.html)", 
"[Profile Report for country: NPL](../reports/Analysis-country-npl-2024-report.html)", 
"[Profile Report for country: PAK](../reports/Analysis-country-pak-2024-report.html)", 
"[Profile Report for country: PAN](../reports/Analysis-country-pan-2024-report.html)", 
"[Profile Report for country: PER](../reports/Analysis-country-per-2024-report.html)", 
"[Profile Report for country: PHL](../reports/Analysis-country-phl-2024-report.html)", 
"[Profile Report for country: POL](../reports/Analysis-country-pol-2024-report.html)", 
"[Profile Report for country: RUS](../reports/Analysis-country-rus-2024-report.html)", 
"[Profile Report for country: RWA](../reports/Analysis-country-rwa-2024-report.html)", 
"[Profile Report for country: SAU](../reports/Analysis-country-sau-2024-report.html)", 
"[Profile Report for country: SDN](../reports/Analysis-country-sdn-2024-report.html)", 
"[Profile Report for country: SEN](../reports/Analysis-country-sen-2024-report.html)", 
"[Profile Report for country: SLE](../reports/Analysis-country-sle-2024-report.html)", 
"[Profile Report for country: SLV](../reports/Analysis-country-slv-2024-report.html)", 
"[Profile Report for country: SOM](../reports/Analysis-country-som-2024-report.html)", 
"[Profile Report for country: SRB](../reports/Analysis-country-srb-2024-report.html)", 
"[Profile Report for country: SSD](../reports/Analysis-country-ssd-2024-report.html)", 
"[Profile Report for country: SWE](../reports/Analysis-country-swe-2024-report.html)", 
"[Profile Report for country: SYR](../reports/Analysis-country-syr-2024-report.html)", 
"[Profile Report for country: TCD](../reports/Analysis-country-tcd-2024-report.html)", 
"[Profile Report for country: THA](../reports/Analysis-country-tha-2024-report.html)", 
"[Profile Report for country: TUR](../reports/Analysis-country-tur-2024-report.html)", 
"[Profile Report for country: TZA](../reports/Analysis-country-tza-2024-report.html)", 
"[Profile Report for country: UGA](../reports/Analysis-country-uga-2024-report.html)", 
"[Profile Report for country: UKR](../reports/Analysis-country-ukr-2024-report.html)", 
"[Profile Report for country: UNK](../reports/Analysis-country-unk-2024-report.html)", 
"[Profile Report for country: USA](../reports/Analysis-country-usa-2024-report.html)", 
"[Profile Report for country: UZB](../reports/Analysis-country-uzb-2024-report.html)", 
"[Profile Report for country: VEN](../reports/Analysis-country-ven-2024-report.html)", 
"[Profile Report for country: VNM](../reports/Analysis-country-vnm-2024-report.html)", 
"[Profile Report for country: YEM](../reports/Analysis-country-yem-2024-report.html)", 
"[Profile Report for country: ZAF](../reports/Analysis-country-zaf-2024-report.html)", 
"[Profile Report for country: ZMB](../reports/Analysis-country-zmb-2024-report.html)", 
"[Profile Report for country: ZWE](../reports/Analysis-country-zwe-2024-report.html)"
)
# linkregionalreport <- generate_report(type = "region")
# dput(linkregionalreport)
linkregionalreport <- c("[Profile Report for region: The Americas](../reports/Analysis-region-the-americas-2024-report.html)", 
"[Profile Report for region: Asia and the Pacific](../reports/Analysis-region-asia-and-the-pacific-2024-report.html)", 
"[Profile Report for region: Southern Africa](../reports/Analysis-region-southern-africa-2024-report.html)", 
"[Profile Report for region: Europe](../reports/Analysis-region-europe-2024-report.html)", 
"[Profile Report for region: Middle East and North Africa](../reports/Analysis-region-middle-east-and-north-africa-2024-report.html)", 
"[Profile Report for region: East and Horn of Africa](../reports/Analysis-region-east-and-horn-of-africa-2024-report.html)", 
"[Profile Report for region: West and Central Africa](../reports/Analysis-region-west-and-central-africa-2024-report.html)", 
"[Profile Report for region: NA](../reports/Analysis-region-NA-2024-report.html)"
)
```
