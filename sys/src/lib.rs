#![allow(non_upper_case_globals)]
#![allow(non_camel_case_types)]
#![allow(non_snake_case)]

use raw_cpuid::CpuId;

include!(concat!(env!("OUT_DIR"), "/bindings.rs"));

pub fn has_avx_support() -> bool {
    let cpuid = CpuId::new();
    let has_avx = cpuid.get_feature_info()
        .map_or(false, |finfo| finfo.has_avx());
    let has_avx2 = cpuid.get_extended_feature_info()
        .map_or(false, |efinfo| efinfo.has_avx2());
    has_avx && has_avx2
}
