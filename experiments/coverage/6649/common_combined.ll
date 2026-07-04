; ModuleID = '/home/mvh6224/CUDA-BOSolver/coverage-exp/6649/common_combined.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"struct.c10::UndefinedTensorImpl" = type { %"struct.c10::TensorImpl" }
%"struct.c10::TensorImpl" = type { %"class.c10::intrusive_ptr_target", %"struct.c10::Storage", %"class.std::unique_ptr.15", %"class.std::unique_ptr.23", %"struct.c10::VariableVersion", %"struct.c10::impl::PyObjectSlot", %"class.c10::impl::SizesAndStrides", i64, i64, %"class.caffe2::TypeMeta", %"class.std::optional.53", [3 x i8], %"class.c10::SymInt" }
%"class.c10::intrusive_ptr_target" = type { i32 (...)**, %"struct.std::atomic", %"struct.std::atomic" }
%"struct.std::atomic" = type { %"struct.std::__atomic_base" }
%"struct.std::__atomic_base" = type { i32 }
%"struct.c10::Storage" = type { %"class.c10::intrusive_ptr.0" }
%"class.c10::intrusive_ptr.0" = type { %"struct.c10::StorageImpl"* }
%"struct.c10::StorageImpl" = type { %"class.c10::intrusive_ptr_target", %"class.c10::DataPtr", %"class.c10::SymInt", i8, i8, i8, i8, i8, i8, i8, %"struct.c10::Allocator"*, %"struct.c10::impl::PyObjectSlot", %"class.std::unique_ptr.5" }
%"class.c10::DataPtr" = type <{ %"class.c10::detail::UniqueVoidPtr", %"struct.c10::Device", [6 x i8] }>
%"class.c10::detail::UniqueVoidPtr" = type { i8*, %"class.std::unique_ptr" }
%"class.std::unique_ptr" = type { %"struct.std::__uniq_ptr_data" }
%"struct.std::__uniq_ptr_data" = type { %"class.std::__uniq_ptr_impl" }
%"class.std::__uniq_ptr_impl" = type { %"class.std::tuple" }
%"class.std::tuple" = type { %"struct.std::_Tuple_impl" }
%"struct.std::_Tuple_impl" = type { %"struct.std::_Tuple_impl.1", %"struct.std::_Head_base.2" }
%"struct.std::_Tuple_impl.1" = type { %"struct.std::_Head_base" }
%"struct.std::_Head_base" = type { void (i8*)* }
%"struct.std::_Head_base.2" = type { i8* }
%"struct.c10::Device" = type { i8, i8 }
%"struct.c10::Allocator" = type { i32 (...)** }
%"class.std::unique_ptr.5" = type { %"struct.std::__uniq_ptr_data.6" }
%"struct.std::__uniq_ptr_data.6" = type { %"class.std::__uniq_ptr_impl.7" }
%"class.std::__uniq_ptr_impl.7" = type { %"class.std::tuple.8" }
%"class.std::tuple.8" = type { %"struct.std::_Tuple_impl.9" }
%"struct.std::_Tuple_impl.9" = type { %"struct.std::_Head_base.12" }
%"struct.std::_Head_base.12" = type { %"struct.c10::StorageExtraMeta"* }
%"struct.c10::StorageExtraMeta" = type { %"class.std::optional" }
%"class.std::optional" = type { %"struct.std::_Optional_base" }
%"struct.std::_Optional_base" = type { %"struct.std::_Optional_payload" }
%"struct.std::_Optional_payload" = type { %"struct.std::_Optional_payload.base", [7 x i8] }
%"struct.std::_Optional_payload.base" = type { %"struct.std::_Optional_payload_base.base" }
%"struct.std::_Optional_payload_base.base" = type <{ %"union.std::_Optional_payload_base<std::__cxx11::basic_string<char>>::_Storage", i8 }>
%"union.std::_Optional_payload_base<std::__cxx11::basic_string<char>>::_Storage" = type { %"class.std::__cxx11::basic_string" }
%"class.std::__cxx11::basic_string" = type { %"struct.std::_Head_base.2", i64, %union.anon }
%union.anon = type { i64, [8 x i8] }
%"class.std::unique_ptr.15" = type { %"struct.std::__uniq_ptr_data.16" }
%"struct.std::__uniq_ptr_data.16" = type { %"class.std::__uniq_ptr_impl.17" }
%"class.std::__uniq_ptr_impl.17" = type { %"class.std::tuple.18" }
%"class.std::tuple.18" = type { %"struct.std::_Tuple_impl.19" }
%"struct.std::_Tuple_impl.19" = type { %"struct.c10::impl::PyInterpreter" }
%"struct.c10::impl::PyInterpreter" = type { %"struct.c10::Allocator"* }
%"class.std::unique_ptr.23" = type { %"struct.std::__uniq_ptr_data.24" }
%"struct.std::__uniq_ptr_data.24" = type { %"class.std::__uniq_ptr_impl.25" }
%"class.std::__uniq_ptr_impl.25" = type { %"class.std::tuple.26" }
%"class.std::tuple.26" = type { %"struct.std::_Tuple_impl.27" }
%"struct.std::_Tuple_impl.27" = type { %"struct.std::_Head_base.30" }
%"struct.std::_Head_base.30" = type { %"struct.c10::ExtraMeta"* }
%"struct.c10::ExtraMeta" = type { %"class.std::unique_ptr.31", %"class.std::unique_ptr.15", %"class.c10::intrusive_ptr.41", %"class.std::optional", %"class.std::optional" }
%"class.std::unique_ptr.31" = type { %"struct.std::__uniq_ptr_data.32" }
%"struct.std::__uniq_ptr_data.32" = type { %"class.std::__uniq_ptr_impl.33" }
%"class.std::__uniq_ptr_impl.33" = type { %"class.std::tuple.34" }
%"class.std::tuple.34" = type { %"struct.std::_Tuple_impl.35" }
%"struct.std::_Tuple_impl.35" = type { %"struct.std::_Head_base.38" }
%"struct.std::_Head_base.38" = type { %"class.c10::SymbolicShapeMeta"* }
%"class.c10::SymbolicShapeMeta" = type { %"class.c10::SmallVector", %"class.c10::SmallVector", %"class.c10::SymInt", i8, %"struct.std::atomic", %"class.std::mutex", %"class.c10::SymInt", %"class.c10::SymBool", %"class.c10::SymBool", %"class.c10::SymBool", %"class.c10::SymBool", %"class.c10::SymBool", %"class.c10::SymBool" }
%"class.c10::SmallVector" = type { %"class.c10::SmallVectorImpl", %"struct.c10::SmallVectorStorage" }
%"class.c10::SmallVectorImpl" = type { %"class.c10::SmallVectorTemplateBase" }
%"class.c10::SmallVectorTemplateBase" = type { %"class.c10::SmallVectorTemplateCommon" }
%"class.c10::SmallVectorTemplateCommon" = type { %"class.c10::SmallVectorBase" }
%"class.c10::SmallVectorBase" = type { i8*, i32, i32 }
%"struct.c10::SmallVectorStorage" = type { [40 x i8] }
%"class.std::mutex" = type { %"class.std::__mutex_base" }
%"class.std::__mutex_base" = type { %union.pthread_mutex_t }
%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%"class.c10::SymBool" = type { i8, %"class.c10::intrusive_ptr.41" }
%"class.c10::intrusive_ptr.41" = type { %"class.c10::SymNodeImpl"* }
%"class.c10::SymNodeImpl" = type { %"class.c10::intrusive_ptr_target" }
%"struct.c10::VariableVersion" = type { %"class.c10::intrusive_ptr.51" }
%"class.c10::intrusive_ptr.51" = type { %"struct.c10::VariableVersion::VersionCounter"* }
%"struct.c10::VariableVersion::VersionCounter" = type <{ %"class.c10::intrusive_ptr_target", %"struct.std::atomic", [4 x i8] }>
%"struct.c10::impl::PyObjectSlot" = type { %"struct.std::atomic.3", %struct._object* }
%"struct.std::atomic.3" = type { %"struct.std::__atomic_base.4" }
%"struct.std::__atomic_base.4" = type { %"struct.c10::impl::PyInterpreter"* }
%struct._object = type opaque
%"class.c10::impl::SizesAndStrides" = type { i64, %union.anon.52 }
%union.anon.52 = type { [10 x i64] }
%"class.caffe2::TypeMeta" = type { i16 }
%"class.std::optional.53" = type { %"struct.std::_Optional_base.54" }
%"struct.std::_Optional_base.54" = type { %"struct.std::_Optional_payload.56" }
%"struct.std::_Optional_payload.56" = type { %"struct.std::_Optional_payload_base.57" }
%"struct.std::_Optional_payload_base.57" = type { %"union.std::_Optional_payload_base<c10::Device>::_Storage", i8 }
%"union.std::_Optional_payload_base<c10::Device>::_Storage" = type { %"struct.c10::Device" }
%"class.c10::SymInt" = type { i64 }
%"struct.std::array" = type { [21 x %"struct.std::_Tuple_impl.19"] }
%"struct.std::atomic.91" = type { %"struct.std::__atomic_base.92" }
%"struct.std::__atomic_base.92" = type { %"struct.c10::cuda::impl::CUDAGuardImpl"* }
%"struct.c10::cuda::impl::CUDAGuardImpl" = type { %"struct.c10::Allocator" }
%"class.at::Tensor" = type { %"class.at::TensorBase" }
%"class.at::TensorBase" = type { %"class.c10::intrusive_ptr" }
%"class.c10::intrusive_ptr" = type { %"struct.c10::TensorImpl"* }
%struct.dim3 = type { i32, i32, i32 }
%"struct.c10::cuda::OptionalCUDAGuard" = type { %"class.c10::impl::InlineOptionalDeviceGuard" }
%"class.c10::impl::InlineOptionalDeviceGuard" = type { %"class.std::optional.59" }
%"class.std::optional.59" = type { %"struct.std::_Optional_base.60" }
%"struct.std::_Optional_base.60" = type { %"struct.std::_Optional_payload.62" }
%"struct.std::_Optional_payload.62" = type { %"struct.std::_Optional_payload.base.66", [7 x i8] }
%"struct.std::_Optional_payload.base.66" = type { %"struct.std::_Optional_payload_base.base.65" }
%"struct.std::_Optional_payload_base.base.65" = type { %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage", i8 }
%"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage" = type { %"class.c10::impl::InlineDeviceGuard" }
%"class.c10::impl::InlineDeviceGuard" = type <{ %"struct.c10::cuda::impl::CUDAGuardImpl", %"struct.c10::Device", %"struct.c10::Device", [4 x i8] }>
%struct.CUstream_st = type opaque
%"class.c10::cuda::CUDAStream" = type { %"class.c10::Stream" }
%"class.c10::Stream" = type { %"struct.c10::Device", i64 }
%class.anon = type { %"class.at::Tensor"*, %struct.dim3*, %struct.dim3*, %struct.CUstream_st**, %"class.at::Tensor"*, %"class.at::Tensor"*, i64* }
%class.anon.93 = type { %struct.dim3*, %struct.dim3*, %struct.CUstream_st**, %"class.at::Tensor"*, %"class.at::Tensor"*, %"class.at::Tensor"*, i64* }
%"struct.std::_Optional_payload_base.64" = type { %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage", i8, [7 x i8] }
%"struct.std::_Optional_payload.63" = type { %"struct.std::_Optional_payload_base.base.65", [7 x i8] }
%"class.c10::Warning" = type <{ %"class.std::variant", [6 x i8], %"struct.c10::SourceLocation", %"class.std::__cxx11::basic_string", i8, [7 x i8] }>
%"class.std::variant" = type { %"struct.std::__detail::__variant::_Variant_base" }
%"struct.std::__detail::__variant::_Variant_base" = type { %"struct.std::__detail::__variant::_Move_assign_base" }
%"struct.std::__detail::__variant::_Move_assign_base" = type { %"struct.std::__detail::__variant::_Copy_assign_base" }
%"struct.std::__detail::__variant::_Copy_assign_base" = type { %"struct.std::__detail::__variant::_Move_ctor_base" }
%"struct.std::__detail::__variant::_Move_ctor_base" = type { %"struct.std::__detail::__variant::_Copy_ctor_base" }
%"struct.std::__detail::__variant::_Copy_ctor_base" = type { %"struct.std::__detail::__variant::_Variant_storage" }
%"struct.std::__detail::__variant::_Variant_storage" = type { %"union.std::__detail::__variant::_Variadic_union", i8 }
%"union.std::__detail::__variant::_Variadic_union" = type { %"struct.std::__detail::__variant::_Uninitialized" }
%"struct.std::__detail::__variant::_Uninitialized" = type { %"class.std::ios_base::Init" }
%"struct.c10::SourceLocation" = type { i8*, i8*, i32 }
%"class.std::__cxx11::basic_ostringstream" = type { %"struct.c10::Allocator", %"class.std::__cxx11::basic_stringbuf", %"class.std::basic_ios" }
%"class.std::__cxx11::basic_stringbuf" = type { %"class.std::basic_streambuf", i32, %"class.std::__cxx11::basic_string" }
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_put"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%struct.CUevent_st = type opaque
%"class.c10::DeviceGuard" = type { %"class.c10::impl::InlineDeviceGuard.87" }
%"class.c10::impl::InlineDeviceGuard.87" = type <{ %"class.c10::impl::VirtualGuardImpl", %"struct.c10::Device", %"struct.c10::Device", [4 x i8] }>
%"class.c10::impl::VirtualGuardImpl" = type { %"struct.c10::Allocator", %"struct.c10::Allocator"* }
%class.anon.69 = type { %"class.at::Tensor"*, %struct.dim3*, %struct.dim3*, %struct.CUstream_st**, %"class.at::Tensor"*, i64*, %"class.at::Tensor"* }
%class.anon.96 = type { %struct.dim3*, %struct.dim3*, %struct.CUstream_st**, %"class.at::Tensor"*, %"class.at::Tensor"*, i64*, %"class.at::Tensor"* }
%"class.std::optional.70" = type { %"struct.std::_Optional_base.71" }
%"struct.std::_Optional_base.71" = type { %"struct.std::_Optional_payload.73" }
%"struct.std::_Optional_payload.73" = type { %"struct.std::_Optional_payload.base.77", [7 x i8] }
%"struct.std::_Optional_payload.base.77" = type { %"struct.std::_Optional_payload_base.base.76" }
%"struct.std::_Optional_payload_base.base.76" = type <{ %"union.std::_Optional_payload_base<at::Tensor>::_Storage", i8 }>
%"union.std::_Optional_payload_base<at::Tensor>::_Storage" = type { %"class.at::Tensor" }
%class.anon.80 = type { %"class.at::Tensor"*, %struct.dim3*, %struct.dim3*, %struct.CUstream_st**, %"class.at::Tensor"*, %"class.at::Tensor"*, %"class.std::optional.70"*, i32* }
%class.anon.99 = type { %struct.dim3*, %struct.dim3*, %struct.CUstream_st**, %"class.at::Tensor"*, %"class.at::Tensor"*, %"class.at::Tensor"*, %"class.std::optional.70"*, i32* }
%"struct.std::_Optional_payload_base.75" = type <{ %"union.std::_Optional_payload_base<at::Tensor>::_Storage", i8, [7 x i8] }>
%"struct.vllm::vec4_t" = type { float, float, float, float }
%"struct.vllm::float8x4_t" = type { %"class.std::ios_base::Init", %"class.std::ios_base::Init", %"class.std::ios_base::Init", %"class.std::ios_base::Init" }
%"struct.vllm::vec4_t.0" = type { %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta" }

$_ZNK2at10TensorBase5numelEv = comdat any

$_ZNK2at10TensorBase4sizeEl = comdat any

$_ZN4dim3C2Ejjj = comdat any

$_ZN2at9device_ofERKNS_6TensorE = comdat any

$_ZN3c104cuda17OptionalCUDAGuardC2ESt8optionalINS_6DeviceEE = comdat any

$_ZNK3c104cuda10CUDAStreamcvP11CUstream_stEv = comdat any

$_ZN3c104cuda17OptionalCUDAGuardD2Ev = comdat any

$_ZN3c104impl25InlineOptionalDeviceGuardINS_4cuda4impl13CUDAGuardImplEED2Ev = comdat any

$_ZNSt8optionalIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEED2Ev = comdat any

$_ZNSt14_Optional_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0EED2Ev = comdat any

$_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0ELb0EED2Ev = comdat any

$_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE8_M_resetEv = comdat any

$_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb1ELb0ELb0EED2Ev = comdat any

$_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEED2Ev = comdat any

$_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE8_StorageIS6_Lb0EED2Ev = comdat any

$_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE10_M_destroyEv = comdat any

$_ZN3c104impl17InlineDeviceGuardINS_4cuda4impl13CUDAGuardImplEED2Ev = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl18uncheckedSetDeviceENS_6DeviceE = comdat any

$_ZN3c104cuda4impl13CUDAGuardImplD2Ev = comdat any

$_ZN3c104impl24DeviceGuardImplInterfaceD2Ev = comdat any

$_ZNK3c106Device5indexEv = comdat any

$_ZNSt7variantIJN3c107Warning11UserWarningENS1_18DeprecationWarningEEEC2IS2_vvS2_vEEOT_ = comdat any

$_ZN3c103strIJA15_cPKcEEEDcDpRKT_ = comdat any

$_ZN3c107WarningD2Ev = comdat any

$__clang_call_terminate = comdat any

$_ZN3c106detail12_str_wrapperIJPKcRKS3_EE4callB5cxx11ES5_S5_ = comdat any

$_ZN3c106detail4_strIPKcJS3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strIPKcEERSoS4_RKT_ = comdat any

$_ZSt7forwardIN3c107Warning11UserWarningEEOT_RNSt16remove_referenceIS3_E4typeE = comdat any

$_ZNSt7variantIJN3c107Warning11UserWarningENS1_18DeprecationWarningEEEC2ILm0EJS2_ES2_vEESt16in_place_index_tIXT_EEDpOT0_ = comdat any

$_ZNSt8__detail9__variant13_Variant_baseIJN3c107Warning11UserWarningENS3_18DeprecationWarningEEEC2ILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_ = comdat any

$_ZNSt27_Enable_default_constructorILb1ESt7variantIJN3c107Warning11UserWarningENS2_18DeprecationWarningEEEEC2ESt31_Enable_default_constructor_tag = comdat any

$_ZNSt8__detail9__variant17_Move_assign_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_ = comdat any

$_ZNSt8__detail9__variant17_Copy_assign_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_ = comdat any

$_ZNSt8__detail9__variant15_Move_ctor_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_ = comdat any

$_ZNSt8__detail9__variant15_Copy_ctor_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_ = comdat any

$_ZNSt8__detail9__variant16_Variant_storageILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEEC2ILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_ = comdat any

$_ZNSt8__detail9__variant15_Variadic_unionIJN3c107Warning11UserWarningENS3_18DeprecationWarningEEEC2IJS4_EEESt16in_place_index_tILm0EEDpOT_ = comdat any

$_ZNSt8__detail9__variant14_UninitializedIN3c107Warning11UserWarningELb1EEC2IJS4_EEESt16in_place_index_tILm0EEDpOT_ = comdat any

$_ZNK2at10TensorBase11scalar_typeEv = comdat any

$_ZN6detail11scalar_typeEN3c1010ScalarTypeE = comdat any

$_ZN3c108toStringENS_10ScalarTypeE = comdat any

$_ZN3c106detail17torchCheckMsgImplIJcPKcA24_cS3_A2_cEEEDcS3_DpRKT_ = comdat any

$_ZN3c103strIJcPKcA24_cS2_A2_cEEEDcDpRKT_ = comdat any

$_ZN3c106detail12_str_wrapperIJRKcRKPS2_S4_S6_S4_EE4callB5cxx11ES3_S6_S6_S6_S6_ = comdat any

$_ZN3c106detail4_strIcJPKcS3_S3_S3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strIcEERSoS2_RKT_ = comdat any

$_ZN3c106detail4_strIPKcJS3_S3_S3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strIPKcJS3_S3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv = comdat any

$_ZNK3c1010TensorImpl5dtypeEv = comdat any

$_ZN3c1020typeMetaToScalarTypeEN6caffe28TypeMetaE = comdat any

$_ZN6caffe28TypeMeta12toScalarTypeEv = comdat any

$_ZNK6caffe28TypeMeta12isScalarTypeEv = comdat any

$_ZN3c104impl25InlineOptionalDeviceGuardINS_4cuda4impl13CUDAGuardImplEEC2ESt8optionalINS_6DeviceEE = comdat any

$_ZNSt8optionalIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEEC2Ev = comdat any

$_ZNKSt8optionalIN3c106DeviceEE9has_valueEv = comdat any

$_ZNRSt8optionalIN3c106DeviceEE5valueEv = comdat any

$_ZNSt8optionalIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE7emplaceIJRNS0_6DeviceEEEENSt9enable_ifIX18is_constructible_vIS6_DpT_EERS6_E4typeEDpOSC_ = comdat any

$_ZNSt19_Optional_base_implIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEESt14_Optional_baseIS6_Lb0ELb0EEE8_M_resetEv = comdat any

$_ZSt7forwardIRN3c106DeviceEEOT_RNSt16remove_referenceIS3_E4typeE = comdat any

$_ZNSt19_Optional_base_implIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEESt14_Optional_baseIS6_Lb0ELb0EEE12_M_constructIJRNS0_6DeviceEEEEvDpOT_ = comdat any

$_ZNSt19_Optional_base_implIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEESt14_Optional_baseIS6_Lb0ELb0EEE6_M_getEv = comdat any

$_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE6_M_getEv = comdat any

$_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE12_M_constructIJRNS0_6DeviceEEEEvDpOT_ = comdat any

$_ZSt11__addressofIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEEPT_RS7_ = comdat any

$_ZSt10_ConstructIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEJRNS0_6DeviceEEEvPT_DpOT0_ = comdat any

$_ZN3c104impl17InlineDeviceGuardINS_4cuda4impl13CUDAGuardImplEEC2ENS_6DeviceE = comdat any

$_ZNK3c106Device4typeEv = comdat any

$_ZN3c104cuda4impl13CUDAGuardImplC2ENS_10DeviceTypeE = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl9getDeviceEv = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl14exchangeDeviceENS_6DeviceE = comdat any

$_ZNK3c106Device7is_cudaEv = comdat any

$_ZN3c103strIJEEEDcDpRKT_ = comdat any

$_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_NS0_22CompileTimeEmptyStringE = comdat any

$_ZN3c106DeviceC2ENS_10DeviceTypeEa = comdat any

$_ZN3c106Device8validateEv = comdat any

$_ZN3c103strIJA46_ciEEEDcDpRKT_ = comdat any

$_ZNK3c106Device6is_cpuEv = comdat any

$_ZN3c103strIJA42_ciEEEDcDpRKT_ = comdat any

$_ZN3c106detail12_str_wrapperIJPKcRKiEE4callB5cxx11ERKS3_S5_ = comdat any

$_ZN3c106detail4_strIPKcJiEEERSoS4_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strIiEERSoS2_RKT_ = comdat any

$_ZN3c106detail12_str_wrapperIJEE4callEv = comdat any

$_ZN3c104impl24DeviceGuardImplInterfaceC2Ev = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl4typeEv = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl9setDeviceENS_6DeviceE = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl9getStreamENS_6DeviceE = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl16getDefaultStreamENS_6DeviceE = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl23getStreamFromGlobalPoolENS_6DeviceEb = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl12getNewStreamENS_6DeviceEi = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl14exchangeStreamENS_6StreamE = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl12destroyEventEPva = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl6recordEPPvRKNS_6StreamEaNS_9EventFlagE = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl5blockEPvRKNS_6StreamE = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl10queryEventEPv = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl11deviceCountEv = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl11queryStreamERKNS_6StreamE = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl17synchronizeStreamERKNS_6StreamE = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl16synchronizeEventEPv = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl17synchronizeDeviceEa = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl21recordDataPtrOnStreamERKNS_7DataPtrERKNS_6StreamE = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl11elapsedTimeEPvS3_a = comdat any

$_ZN3c104cuda4impl13CUDAGuardImplD0Ev = comdat any

$_ZN3c106detail17torchCheckMsgImplEPKcS2_ = comdat any

$_ZN3c104cuda10CUDAStreamC2ENS_6StreamE = comdat any

$_ZN3c104cuda20CUDACachingAllocator12recordStreamERKNS_7DataPtrENS0_10CUDAStreamE = comdat any

$_ZN3c104cuda20CUDACachingAllocator3getEv = comdat any

$_ZNKSt6atomicIPN3c104cuda20CUDACachingAllocator13CUDAAllocatorEE4loadESt12memory_order = comdat any

$_ZStanSt12memory_orderSt23__memory_order_modifier = comdat any

$_ZNK3c106Stream11device_typeEv = comdat any

$_ZN3c106detail17torchCheckMsgImplEPKc = comdat any

$_ZN3c104impl8GPUTrace9get_traceEv = comdat any

$_ZNK3c104impl13PyInterpreterptEv = comdat any

$_ZNKSt6atomicIPKN3c104impl13PyInterpreterEE4loadESt12memory_order = comdat any

$_ZNK3c104cuda10CUDAStream11synchronizeEv = comdat any

$_ZNK3c106Stream6deviceEv = comdat any

$_ZN3c1011DeviceGuardC2ENS_6DeviceE = comdat any

$_ZN3c104cuda18stream_synchronizeEP11CUstream_st = comdat any

$_ZN3c1011DeviceGuardD2Ev = comdat any

$_ZN3c104impl17InlineDeviceGuardINS0_16VirtualGuardImplEED2Ev = comdat any

$_ZNK3c104impl16VirtualGuardImpl18uncheckedSetDeviceENS_6DeviceE = comdat any

$_ZN3c104impl16VirtualGuardImplD2Ev = comdat any

$_ZN3c104cuda13warning_stateEv = comdat any

$_ZN3c104cuda12WarningState19get_sync_debug_modeEv = comdat any

$_ZN3c104impl17InlineDeviceGuardINS0_16VirtualGuardImplEEC2ENS_6DeviceE = comdat any

$_ZN3c104impl16VirtualGuardImplC2ENS_10DeviceTypeE = comdat any

$_ZNK3c104impl16VirtualGuardImpl9getDeviceEv = comdat any

$_ZNK3c104impl16VirtualGuardImpl14exchangeDeviceENS_6DeviceE = comdat any

$_ZN3c104impl18getDeviceGuardImplENS_10DeviceTypeE = comdat any

$_ZNSt5arrayISt6atomicIPKN3c104impl24DeviceGuardImplInterfaceEELm21EEixEm = comdat any

$_ZNKSt6atomicIPKN3c104impl24DeviceGuardImplInterfaceEE4loadESt12memory_order = comdat any

$_ZN3c106detail17torchCheckMsgImplIJA40_cNS_10DeviceTypeEA9_cEEEDcPKcDpRKT_ = comdat any

$_ZN3c103strIJA40_cNS_10DeviceTypeEA9_cEEEDcDpRKT_ = comdat any

$_ZN3c106detail12_str_wrapperIJPKcRKNS_10DeviceTypeES3_EE4callB5cxx11ERKS3_S6_S9_ = comdat any

$_ZN3c106detail4_strIPKcJNS_10DeviceTypeES3_EEERSoS5_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strINS_10DeviceTypeEJPKcEEERSoS5_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strINS_10DeviceTypeEEERSoS3_RKT_ = comdat any

$_ZNSt14__array_traitsISt6atomicIPKN3c104impl24DeviceGuardImplInterfaceEELm21EE6_S_refERA21_KS6_m = comdat any

$_ZNK3c104impl16VirtualGuardImpl4typeEv = comdat any

$_ZNK3c104impl16VirtualGuardImpl9setDeviceENS_6DeviceE = comdat any

$_ZNK3c104impl16VirtualGuardImpl9getStreamENS_6DeviceE = comdat any

$_ZNK3c104impl16VirtualGuardImpl16getDefaultStreamENS_6DeviceE = comdat any

$_ZNK3c104impl16VirtualGuardImpl23getStreamFromGlobalPoolENS_6DeviceEb = comdat any

$_ZNK3c104impl16VirtualGuardImpl12getNewStreamENS_6DeviceEi = comdat any

$_ZNK3c104impl16VirtualGuardImpl14exchangeStreamENS_6StreamE = comdat any

$_ZNK3c104impl16VirtualGuardImpl12destroyEventEPva = comdat any

$_ZNK3c104impl16VirtualGuardImpl6recordEPPvRKNS_6StreamEaNS_9EventFlagE = comdat any

$_ZNK3c104impl16VirtualGuardImpl5blockEPvRKNS_6StreamE = comdat any

$_ZNK3c104impl16VirtualGuardImpl10queryEventEPv = comdat any

$_ZNK3c104impl16VirtualGuardImpl11deviceCountEv = comdat any

$_ZNK3c104impl16VirtualGuardImpl11queryStreamERKNS_6StreamE = comdat any

$_ZNK3c104impl16VirtualGuardImpl17synchronizeStreamERKNS_6StreamE = comdat any

$_ZNK3c104impl16VirtualGuardImpl16synchronizeEventEPv = comdat any

$_ZNK3c104impl16VirtualGuardImpl17synchronizeDeviceEa = comdat any

$_ZNK3c104impl16VirtualGuardImpl21recordDataPtrOnStreamERKNS_7DataPtrERKNS_6StreamE = comdat any

$_ZNK3c104impl16VirtualGuardImpl11elapsedTimeEPvS2_a = comdat any

$_ZN3c104impl16VirtualGuardImplD0Ev = comdat any

$_ZNK3c104cuda10CUDAStream5queryEv = comdat any

$_ZNK3c106Stream12device_indexEv = comdat any

$_ZN3c106detail17torchCheckMsgImplIJA20_caA49_caA2_cEEEDcPKcDpRKT_ = comdat any

$_ZNK3c104cuda4impl13CUDAGuardImpl11createEventEPP10CUevent_stNS_9EventFlagE = comdat any

$_ZN3c103strIJA20_caA49_caA2_cEEEDcDpRKT_ = comdat any

$_ZN3c106detail12_str_wrapperIJPKcRKaS3_S5_S3_EE4callB5cxx11ERKS3_S5_S8_S5_S8_ = comdat any

$_ZN3c106detail4_strIPKcJaS3_aS3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strIaJPKcaS3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strIaEERSoS2_RKT_ = comdat any

$_ZN3c106detail4_strIPKcJaS3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strIaJPKcEEERSoS4_RKT_DpRKT0_ = comdat any

$_ZNK3c104cuda10CUDAStream6unwrapEv = comdat any

$_ZNK3c104cuda10CUDAStreamcvNS_6StreamEEv = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface16getDefaultStreamENS_6DeviceE = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface23getStreamFromGlobalPoolENS_6DeviceEb = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface12getNewStreamENS_6DeviceEi = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface12destroyEventEPva = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface6recordEPPvRKNS_6StreamEaNS_9EventFlagE = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface5blockEPvRKNS_6StreamE = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface10queryEventEPv = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface11queryStreamERKNS_6StreamE = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface17synchronizeStreamERKNS_6StreamE = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface16synchronizeEventEPv = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface17synchronizeDeviceEa = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface21recordDataPtrOnStreamERKNS_7DataPtrERKNS_6StreamE = comdat any

$_ZNK3c104impl24DeviceGuardImplInterface11elapsedTimeEPvS2_a = comdat any

$_ZN3c104impl24DeviceGuardImplInterfaceD0Ev = comdat any

$_ZNKSt19_Optional_base_implIN3c106DeviceESt14_Optional_baseIS1_Lb1ELb1EEE13_M_is_engagedEv = comdat any

$_ZNSt19_Optional_base_implIN3c106DeviceESt14_Optional_baseIS1_Lb1ELb1EEE6_M_getEv = comdat any

$_ZSt27__throw_bad_optional_accessv = comdat any

$_ZNSt19bad_optional_accessC2Ev = comdat any

$_ZNSt19bad_optional_accessD2Ev = comdat any

$_ZNSt9exceptionC2Ev = comdat any

$_ZNSt19bad_optional_accessD0Ev = comdat any

$_ZNKSt19bad_optional_access4whatEv = comdat any

$_ZNSt22_Optional_payload_baseIN3c106DeviceEE6_M_getEv = comdat any

$_ZNSt14_Optional_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0EEC2Ev = comdat any

$_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0ELb0EEC2Ev = comdat any

$_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb1ELb0ELb0EEC2Ev = comdat any

$_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEEC2Ev = comdat any

$_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE8_StorageIS6_Lb0EEC2Ev = comdat any

$_ZNK2at10TensorBase7definedEv = comdat any

$_ZNK2at10TensorBase6deviceEv = comdat any

$_ZNSt8optionalIN3c106DeviceEEC2IS1_Lb1EEEOT_ = comdat any

$_ZNSt8optionalIN3c106DeviceEEC2ESt9nullopt_t = comdat any

$_ZNSt14_Optional_baseIN3c106DeviceELb1ELb1EEC2Ev = comdat any

$_ZNSt17_Optional_payloadIN3c106DeviceELb1ELb1ELb1EEC2Ev = comdat any

$_ZNSt22_Optional_payload_baseIN3c106DeviceEEC2Ev = comdat any

$_ZNSt22_Optional_payload_baseIN3c106DeviceEE8_StorageIS1_Lb1EEC2Ev = comdat any

$_ZSt7forwardIN3c106DeviceEEOT_RNSt16remove_referenceIS2_E4typeE = comdat any

$_ZNSt14_Optional_baseIN3c106DeviceELb1ELb1EEC2IJS1_ELb0EEESt10in_place_tDpOT_ = comdat any

$_ZNSt17_Optional_payloadIN3c106DeviceELb1ELb1ELb1EECI2St22_Optional_payload_baseIS1_EIJS1_EEESt10in_place_tDpOT_ = comdat any

$_ZNSt22_Optional_payload_baseIN3c106DeviceEEC2IJS1_EEESt10in_place_tDpOT_ = comdat any

$_ZNSt22_Optional_payload_baseIN3c106DeviceEE8_StorageIS1_Lb1EEC2IJS1_EEESt10in_place_tDpOT_ = comdat any

$_ZNK3c1010TensorImpl6deviceEv = comdat any

$_ZNK3c1010TensorImpl14device_defaultEv = comdat any

$_ZNKRSt8optionalIN3c106DeviceEEdeEv = comdat any

$_ZNKSt19_Optional_base_implIN3c106DeviceESt14_Optional_baseIS1_Lb1ELb1EEE6_M_getEv = comdat any

$_ZNKSt22_Optional_payload_baseIN3c106DeviceEE6_M_getEv = comdat any

$_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEcvbEv = comdat any

$_ZN3c1019UndefinedTensorImpl9singletonEv = comdat any

$_ZNK3c1010TensorImpl4sizeEl = comdat any

$_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE = comdat any

$_ZNK3c1010TensorImpl3dimEv = comdat any

$_ZN3c1014maybe_wrap_dimEllb = comdat any

$_ZNK3c104impl15SizesAndStrides17size_at_uncheckedEm = comdat any

$_ZNK3c104impl15SizesAndStrides10sizes_dataEv = comdat any

$_ZNK3c104impl15SizesAndStrides8isInlineEv = comdat any

$_ZN3c1015_maybe_wrap_dimIlEET_S1_S1_b = comdat any

$_ZSt4moveIRlEONSt16remove_referenceIT_E4typeEOS2_ = comdat any

$_ZNK3c104impl15SizesAndStrides4sizeEv = comdat any

$_ZNK3c1010TensorImpl5numelEv = comdat any

$_ZNK2at10TensorBase13is_contiguousEN3c1012MemoryFormatE = comdat any

$_ZSt3minIiEUa9enable_ifILb1EERKT_S2_S2_ = comdat any

$_ZNKSt8optionalIN2at6TensorEE9has_valueEv = comdat any

$_ZNKSt8optionalIN2at6TensorEEptEv = comdat any

$_ZNKSt19_Optional_base_implIN2at6TensorESt14_Optional_baseIS1_Lb0ELb0EEE6_M_getEv = comdat any

$_ZSt11__addressofIKN2at6TensorEEPT_RS3_ = comdat any

$_ZNKSt22_Optional_payload_baseIN2at6TensorEE6_M_getEv = comdat any

$_ZNKSt19_Optional_base_implIN2at6TensorESt14_Optional_baseIS1_Lb0ELb0EEE13_M_is_engagedEv = comdat any

$_ZNK3c1010TensorImpl13is_contiguousENS_12MemoryFormatE = comdat any

$_ZNK3c1010TensorImpl21is_contiguous_defaultENS_12MemoryFormatE = comdat any

$_ZNK3c1010TensorImpl19symbolic_shape_metaEv = comdat any

$_ZNK3c1017SymbolicShapeMeta27is_channels_last_contiguousEv = comdat any

$_ZNK3c1017SymbolicShapeMeta30is_channels_last_3d_contiguousEv = comdat any

$_ZNK3c1017SymbolicShapeMeta13is_contiguousEv = comdat any

$_ZNK3c1017SymbolicShapeMeta17has_is_contiguousEv = comdat any

$_ZNK3c1017SymbolicShapeMeta34has_is_channels_last_3d_contiguousEv = comdat any

$_ZNK3c1017SymbolicShapeMeta31has_is_channels_last_contiguousEv = comdat any

$_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEcvbEv = comdat any

$_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEptEv = comdat any

$_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEcvbEv = comdat any

$_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEdeEv = comdat any

$_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE3getEv = comdat any

$_ZNKSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE6_M_ptrEv = comdat any

$_ZSt3getILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_ = comdat any

$_ZSt12__get_helperILm0EPN3c1017SymbolicShapeMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE = comdat any

$_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_headERKS5_ = comdat any

$_ZNSt10_Head_baseILm0EPN3c1017SymbolicShapeMetaELb0EE7_M_headERKS3_ = comdat any

$_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE3getEv = comdat any

$_ZNKSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE6_M_ptrEv = comdat any

$_ZSt3getILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_ = comdat any

$_ZSt12__get_helperILm0EPN3c109ExtraMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE = comdat any

$_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_headERKS5_ = comdat any

$_ZNSt10_Head_baseILm0EPN3c109ExtraMetaELb0EE7_M_headERKS3_ = comdat any

$_ZN4vllm25scaled_fp8_conversion_vecIfLb1EEEvPN3c1013Float8_e4m3fnEPKT_flii = comdat any

$_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv = comdat any

$_ZN3c10ngERKNS_13Float8_e4m3fnE = comdat any

$_ZNK3c1013Float8_e4m3fncvfEv = comdat any

$_ZN3c1013Float8_e4m3fnC1Ef = comdat any

$_ZN3c1013Float8_e4m3fnC2Ef = comdat any

$_ZN3c106detail25fp8e4m3fn_from_fp32_valueEf = comdat any

$_ZN3c106detail12fp32_to_bitsEf = comdat any

$_ZN3c106detail14fp32_from_bitsEj = comdat any

$_ZN3c106detail23fp8e4m3fn_to_fp32_valueEh = comdat any

$_ZN3c1013Float8_e4m3fn9from_bitsEv = comdat any

$_ZN3c1013Float8_e4m3fnC1EhNS0_11from_bits_tE = comdat any

$_ZN3c1013Float8_e4m3fnC2EhNS0_11from_bits_tE = comdat any

$_ZN4vllm25scaled_fp8_conversion_vecIN3c104HalfELb1EEEvPNS1_13Float8_e4m3fnEPKT_flii = comdat any

$_ZNK3c104HalfcvfEv = comdat any

$_ZN4vllm25scaled_fp8_conversion_vecIN3c108BFloat16ELb1EEEvPNS1_13Float8_e4m3fnEPKT_flii = comdat any

$_ZNK3c108BFloat16cvfEv = comdat any

$_ZNK13__nv_bfloat16cv17__nv_bfloat16_rawEv = comdat any

$_ZN3c10dvEfNS_13Float8_e4m3fnE = comdat any

$_ZN3c104HalfC1Ef = comdat any

$_ZN3c104HalfC2Ef = comdat any

$_ZN3c108BFloat16C1Ef = comdat any

$_ZN3c108BFloat16C2Ef = comdat any

$_ZN3c10mlENS_13Float8_e4m3fnEf = comdat any

$_ZN4vllm14thread_max_vecIfEEfPKT_lii = comdat any

$_ZN4vllm14blockReduceMaxIfLi1024EEET_S1_ = comdat any

$_ZN4vllm25scaled_fp8_conversion_vecIfLb0EEEvPN3c1013Float8_e4m3fnEPKT_flii = comdat any

$_ZN4vllm6detail4_maxIfEET_S2_S2_ = comdat any

$_ZN4vllm11blockReduceIfLi1024EEET_S1_PFS1_S1_S1_E = comdat any

$_ZN4vllm10warpReduceIfLi32EEET_S1_PFS1_S1_S1_E = comdat any

$_Z15__shfl_xor_syncjfii = comdat any

$_ZN4vllm14thread_max_vecIN3c104HalfEEEfPKT_lii = comdat any

$_ZN4vllm25scaled_fp8_conversion_vecIN3c104HalfELb0EEEvPNS1_13Float8_e4m3fnEPKT_flii = comdat any

$_ZN4vllm14thread_max_vecIN3c108BFloat16EEEfPKT_lii = comdat any

$_ZN4vllm25scaled_fp8_conversion_vecIN3c108BFloat16ELb0EEEvPNS1_13Float8_e4m3fnEPKT_flii = comdat any

$_ZTVN3c104cuda4impl13CUDAGuardImplE = comdat any

$_ZTSN3c104cuda4impl13CUDAGuardImplE = comdat any

$_ZTSN3c104impl24DeviceGuardImplInterfaceE = comdat any

$_ZTIN3c104impl24DeviceGuardImplInterfaceE = comdat any

$_ZTIN3c104cuda4impl13CUDAGuardImplE = comdat any

$_ZTVN3c104impl24DeviceGuardImplInterfaceE = comdat any

$_ZTVN3c104impl16VirtualGuardImplE = comdat any

$_ZTSN3c104impl16VirtualGuardImplE = comdat any

$_ZTIN3c104impl16VirtualGuardImplE = comdat any

$_ZZN3c104cuda13warning_stateEvE14warning_state_ = comdat any

$_ZTSSt19bad_optional_access = comdat any

$_ZTISt19bad_optional_access = comdat any

$_ZTVSt19bad_optional_access = comdat any

$_ZZN4vllm23segmented_max_reductionIfEEvPfPKT_lE5cache = comdat any

$_ZZN4vllm23segmented_max_reductionIN3c104HalfEEEvPfPKT_lE5cache = comdat any

$_ZZN4vllm23segmented_max_reductionIN3c108BFloat16EEEvPfPKT_lE5cache = comdat any

$_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfiE11token_scale = comdat any

$_ZZN4vllm11blockReduceIfLi1024EEET_S1_PFS1_S1_S1_EE6shared = comdat any

$_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale = comdat any

$_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale = comdat any

@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_common.cu, i8* null }]
@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@__func__._Z34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_E = private unnamed_addr constant [35 x i8] c"dynamic_per_token_scaled_fp8_quant\00", align 1
@.str = private unnamed_addr constant [73 x i8] c"/home/mvh6224/CUDA-BOSolver/coverage-exp/6649/quantization/fp8/common.cu\00", align 1
@.str.1 = private unnamed_addr constant [156 x i8] c"Expected input.is_contiguous() to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@.str.2 = private unnamed_addr constant [154 x i8] c"Expected out.is_contiguous() to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@_ZN3c1019UndefinedTensorImpl10_singletonE = external dso_local global %"struct.c10::UndefinedTensorImpl", align 8
@__func__._ZNK3c1010TensorImpl14device_defaultEv = private unnamed_addr constant [15 x i8] c"device_default\00", align 1
@.str.3 = private unnamed_addr constant [104 x i8] c"/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/TensorImpl.h\00", align 1
@.str.4 = private unnamed_addr constant [158 x i8] c"Expected device_opt_.has_value() to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@.str.5 = private unnamed_addr constant [30 x i8] c"tensor does not have a device\00", align 1
@__func__._ZNK3c104cuda4impl13CUDAGuardImpl18uncheckedSetDeviceENS_6DeviceE = private unnamed_addr constant [19 x i8] c"uncheckedSetDevice\00", align 1
@.str.6 = private unnamed_addr constant [112 x i8] c"/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/cuda/impl/CUDAGuardImpl.h\00", align 1
@.str.7 = private unnamed_addr constant [15 x i8] c"CUDA warning: \00", align 1
@_ZTVN3c104cuda4impl13CUDAGuardImplE = linkonce_odr dso_local unnamed_addr constant { [25 x i8*] } { [25 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTIN3c104cuda4impl13CUDAGuardImplE to i8*), i8* bitcast (i8 (%"struct.c10::cuda::impl::CUDAGuardImpl"*)* @_ZNK3c104cuda4impl13CUDAGuardImpl4typeEv to i8*), i8* bitcast (i16 (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i16)* @_ZNK3c104cuda4impl13CUDAGuardImpl14exchangeDeviceENS_6DeviceE to i8*), i8* bitcast (i16 (%"struct.c10::cuda::impl::CUDAGuardImpl"*)* @_ZNK3c104cuda4impl13CUDAGuardImpl9getDeviceEv to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i16)* @_ZNK3c104cuda4impl13CUDAGuardImpl9setDeviceENS_6DeviceE to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i16)* @_ZNK3c104cuda4impl13CUDAGuardImpl18uncheckedSetDeviceENS_6DeviceE to i8*), i8* bitcast ({ i64, i64 } (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i16)* @_ZNK3c104cuda4impl13CUDAGuardImpl9getStreamENS_6DeviceE to i8*), i8* bitcast ({ i64, i64 } (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i16)* @_ZNK3c104cuda4impl13CUDAGuardImpl16getDefaultStreamENS_6DeviceE to i8*), i8* bitcast ({ i64, i64 } (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i16, i1)* @_ZNK3c104cuda4impl13CUDAGuardImpl23getStreamFromGlobalPoolENS_6DeviceEb to i8*), i8* bitcast ({ i64, i64 } (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i16, i32)* @_ZNK3c104cuda4impl13CUDAGuardImpl12getNewStreamENS_6DeviceEi to i8*), i8* bitcast ({ i64, i64 } (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i64, i64)* @_ZNK3c104cuda4impl13CUDAGuardImpl14exchangeStreamENS_6StreamE to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i8*, i8)* @_ZNK3c104cuda4impl13CUDAGuardImpl12destroyEventEPva to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i8**, %"class.c10::Stream"*, i8, i32)* @_ZNK3c104cuda4impl13CUDAGuardImpl6recordEPPvRKNS_6StreamEaNS_9EventFlagE to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i8*, %"class.c10::Stream"*)* @_ZNK3c104cuda4impl13CUDAGuardImpl5blockEPvRKNS_6StreamE to i8*), i8* bitcast (i1 (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i8*)* @_ZNK3c104cuda4impl13CUDAGuardImpl10queryEventEPv to i8*), i8* bitcast (i8 (%"struct.c10::cuda::impl::CUDAGuardImpl"*)* @_ZNK3c104cuda4impl13CUDAGuardImpl11deviceCountEv to i8*), i8* bitcast (i1 (%"struct.c10::cuda::impl::CUDAGuardImpl"*, %"class.c10::Stream"*)* @_ZNK3c104cuda4impl13CUDAGuardImpl11queryStreamERKNS_6StreamE to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, %"class.c10::Stream"*)* @_ZNK3c104cuda4impl13CUDAGuardImpl17synchronizeStreamERKNS_6StreamE to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i8*)* @_ZNK3c104cuda4impl13CUDAGuardImpl16synchronizeEventEPv to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i8)* @_ZNK3c104cuda4impl13CUDAGuardImpl17synchronizeDeviceEa to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, %"class.c10::DataPtr"*, %"class.c10::Stream"*)* @_ZNK3c104cuda4impl13CUDAGuardImpl21recordDataPtrOnStreamERKNS_7DataPtrERKNS_6StreamE to i8*), i8* bitcast (double (%"struct.c10::cuda::impl::CUDAGuardImpl"*, i8*, i8*, i8)* @_ZNK3c104cuda4impl13CUDAGuardImpl11elapsedTimeEPvS3_a to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*)* @_ZN3c104cuda4impl13CUDAGuardImplD2Ev to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*)* @_ZN3c104cuda4impl13CUDAGuardImplD0Ev to i8*)] }, comdat, align 8
@__func__._ZN3c104cuda4impl13CUDAGuardImplC2ENS_10DeviceTypeE = private unnamed_addr constant [14 x i8] c"CUDAGuardImpl\00", align 1
@.str.8 = private unnamed_addr constant [199 x i8] c"t == DeviceType::CUDA INTERNAL ASSERT FAILED at \22/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/cuda/impl/CUDAGuardImpl.h\22:28, please report a bug to PyTorch. \00", align 1
@_ZTVN10__cxxabiv120__si_class_type_infoE = external dso_local global i8*
@_ZTSN3c104cuda4impl13CUDAGuardImplE = linkonce_odr dso_local constant [32 x i8] c"N3c104cuda4impl13CUDAGuardImplE\00", comdat, align 1
@_ZTVN10__cxxabiv117__class_type_infoE = external dso_local global i8*
@_ZTSN3c104impl24DeviceGuardImplInterfaceE = linkonce_odr dso_local constant [38 x i8] c"N3c104impl24DeviceGuardImplInterfaceE\00", comdat, align 1
@_ZTIN3c104impl24DeviceGuardImplInterfaceE = linkonce_odr dso_local constant { i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv117__class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([38 x i8], [38 x i8]* @_ZTSN3c104impl24DeviceGuardImplInterfaceE, i32 0, i32 0) }, comdat, align 8
@_ZTIN3c104cuda4impl13CUDAGuardImplE = linkonce_odr dso_local constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @_ZTSN3c104cuda4impl13CUDAGuardImplE, i32 0, i32 0), i8* bitcast ({ i8*, i8* }* @_ZTIN3c104impl24DeviceGuardImplInterfaceE to i8*) }, comdat, align 8
@_ZTVN3c104impl24DeviceGuardImplInterfaceE = linkonce_odr dso_local unnamed_addr constant { [25 x i8*] } { [25 x i8*] [i8* null, i8* bitcast ({ i8*, i8* }* @_ZTIN3c104impl24DeviceGuardImplInterfaceE to i8*), i8* bitcast (void ()* @__cxa_pure_virtual to i8*), i8* bitcast (void ()* @__cxa_pure_virtual to i8*), i8* bitcast (void ()* @__cxa_pure_virtual to i8*), i8* bitcast (void ()* @__cxa_pure_virtual to i8*), i8* bitcast (void ()* @__cxa_pure_virtual to i8*), i8* bitcast (void ()* @__cxa_pure_virtual to i8*), i8* bitcast ({ i64, i64 } (%"struct.c10::Allocator"*, i16)* @_ZNK3c104impl24DeviceGuardImplInterface16getDefaultStreamENS_6DeviceE to i8*), i8* bitcast ({ i64, i64 } (%"struct.c10::Allocator"*, i16, i1)* @_ZNK3c104impl24DeviceGuardImplInterface23getStreamFromGlobalPoolENS_6DeviceEb to i8*), i8* bitcast ({ i64, i64 } (%"struct.c10::Allocator"*, i16, i32)* @_ZNK3c104impl24DeviceGuardImplInterface12getNewStreamENS_6DeviceEi to i8*), i8* bitcast (void ()* @__cxa_pure_virtual to i8*), i8* bitcast (void (%"struct.c10::Allocator"*, i8*, i8)* @_ZNK3c104impl24DeviceGuardImplInterface12destroyEventEPva to i8*), i8* bitcast (void (%"struct.c10::Allocator"*, i8**, %"class.c10::Stream"*, i8, i32)* @_ZNK3c104impl24DeviceGuardImplInterface6recordEPPvRKNS_6StreamEaNS_9EventFlagE to i8*), i8* bitcast (void (%"struct.c10::Allocator"*, i8*, %"class.c10::Stream"*)* @_ZNK3c104impl24DeviceGuardImplInterface5blockEPvRKNS_6StreamE to i8*), i8* bitcast (i1 (%"struct.c10::Allocator"*, i8*)* @_ZNK3c104impl24DeviceGuardImplInterface10queryEventEPv to i8*), i8* bitcast (void ()* @__cxa_pure_virtual to i8*), i8* bitcast (i1 (%"struct.c10::Allocator"*, %"class.c10::Stream"*)* @_ZNK3c104impl24DeviceGuardImplInterface11queryStreamERKNS_6StreamE to i8*), i8* bitcast (void (%"struct.c10::Allocator"*, %"class.c10::Stream"*)* @_ZNK3c104impl24DeviceGuardImplInterface17synchronizeStreamERKNS_6StreamE to i8*), i8* bitcast (void (%"struct.c10::Allocator"*, i8*)* @_ZNK3c104impl24DeviceGuardImplInterface16synchronizeEventEPv to i8*), i8* bitcast (void (%"struct.c10::Allocator"*, i8)* @_ZNK3c104impl24DeviceGuardImplInterface17synchronizeDeviceEa to i8*), i8* bitcast (void (%"struct.c10::Allocator"*, %"class.c10::DataPtr"*, %"class.c10::Stream"*)* @_ZNK3c104impl24DeviceGuardImplInterface21recordDataPtrOnStreamERKNS_7DataPtrERKNS_6StreamE to i8*), i8* bitcast (double (%"struct.c10::Allocator"*, i8*, i8*, i8)* @_ZNK3c104impl24DeviceGuardImplInterface11elapsedTimeEPvS2_a to i8*), i8* bitcast (void (%"struct.c10::Allocator"*)* @_ZN3c104impl24DeviceGuardImplInterfaceD2Ev to i8*), i8* bitcast (void (%"struct.c10::Allocator"*)* @_ZN3c104impl24DeviceGuardImplInterfaceD0Ev to i8*)] }, comdat, align 8
@__func__._ZNK3c104impl24DeviceGuardImplInterface16getDefaultStreamENS_6DeviceE = private unnamed_addr constant [17 x i8] c"getDefaultStream\00", align 1
@.str.9 = private unnamed_addr constant [123 x i8] c"/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/impl/DeviceGuardImplInterface.h\00", align 1
@.str.10 = private unnamed_addr constant [140 x i8] c"Expected false to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@.str.11 = private unnamed_addr constant [52 x i8] c"Backend doesn't support acquiring a default stream.\00", align 1
@__func__._ZNK3c104impl24DeviceGuardImplInterface23getStreamFromGlobalPoolENS_6DeviceEb = private unnamed_addr constant [24 x i8] c"getStreamFromGlobalPool\00", align 1
@.str.12 = private unnamed_addr constant [54 x i8] c"Backend doesn't support acquiring a stream from pool.\00", align 1
@__func__._ZNK3c104impl24DeviceGuardImplInterface12getNewStreamENS_6DeviceEi = private unnamed_addr constant [13 x i8] c"getNewStream\00", align 1
@.str.13 = private unnamed_addr constant [45 x i8] c"Backend doesn't support create a new Stream.\00", align 1
@__func__._ZNK3c104impl24DeviceGuardImplInterface6recordEPPvRKNS_6StreamEaNS_9EventFlagE = private unnamed_addr constant [7 x i8] c"record\00", align 1
@.str.14 = private unnamed_addr constant [32 x i8] c"Backend doesn't support events.\00", align 1
@__func__._ZNK3c104impl24DeviceGuardImplInterface5blockEPvRKNS_6StreamE = private unnamed_addr constant [6 x i8] c"block\00", align 1
@__func__._ZNK3c104impl24DeviceGuardImplInterface10queryEventEPv = private unnamed_addr constant [11 x i8] c"queryEvent\00", align 1
@__func__._ZNK3c104impl24DeviceGuardImplInterface11queryStreamERKNS_6StreamE = private unnamed_addr constant [12 x i8] c"queryStream\00", align 1
@.str.15 = private unnamed_addr constant [42 x i8] c"Backend doesn't support querying streams.\00", align 1
@__func__._ZNK3c104impl24DeviceGuardImplInterface17synchronizeStreamERKNS_6StreamE = private unnamed_addr constant [18 x i8] c"synchronizeStream\00", align 1
@.str.16 = private unnamed_addr constant [47 x i8] c"Backend doesn't support synchronizing streams.\00", align 1
@__func__._ZNK3c104impl24DeviceGuardImplInterface16synchronizeEventEPv = private unnamed_addr constant [17 x i8] c"synchronizeEvent\00", align 1
@.str.17 = private unnamed_addr constant [46 x i8] c"Backend doesn't support synchronizing events.\00", align 1
@__func__._ZNK3c104impl24DeviceGuardImplInterface17synchronizeDeviceEa = private unnamed_addr constant [18 x i8] c"synchronizeDevice\00", align 1
@.str.18 = private unnamed_addr constant [61 x i8] c"Backend doesn't support synchronizing all streams on device.\00", align 1
@__func__._ZNK3c104impl24DeviceGuardImplInterface11elapsedTimeEPvS2_a = private unnamed_addr constant [12 x i8] c"elapsedTime\00", align 1
@.str.19 = private unnamed_addr constant [37 x i8] c"Backend doesn't support elapsedTime.\00", align 1
@__func__._ZNK3c104cuda4impl13CUDAGuardImpl9setDeviceENS_6DeviceE = private unnamed_addr constant [10 x i8] c"setDevice\00", align 1
@.str.20 = private unnamed_addr constant [189 x i8] c"d.is_cuda() INTERNAL ASSERT FAILED at \22/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/cuda/impl/CUDAGuardImpl.h\22:53, please report a bug to PyTorch. \00", align 1
@__func__._ZN3c104cuda10CUDAStreamC2ENS_6StreamE = private unnamed_addr constant [11 x i8] c"CUDAStream\00", align 1
@.str.21 = private unnamed_addr constant [104 x i8] c"/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/cuda/CUDAStream.h\00", align 1
@.str.22 = private unnamed_addr constant [176 x i8] c"Expected stream_.device_type() == DeviceType::CUDA to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@__func__._ZNK3c104cuda4impl13CUDAGuardImpl12destroyEventEPva = private unnamed_addr constant [13 x i8] c"destroyEvent\00", align 1
@_ZN3c104impl8GPUTrace9haveStateE = external dso_local global i8, align 1
@_ZN3c104impl8GPUTrace13gpuTraceStateE = external dso_local global %"struct.std::atomic.3", align 8
@.str.23 = private unnamed_addr constant [194 x i8] c"Expected device_index == -1 || device_index == stream.device_index() to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@.str.24 = private unnamed_addr constant [20 x i8] c"Event device index \00", align 1
@.str.25 = private unnamed_addr constant [49 x i8] c" does not match recording stream's device index \00", align 1
@.str.26 = private unnamed_addr constant [2 x i8] c".\00", align 1
@__func__._ZNK3c104cuda4impl13CUDAGuardImpl11createEventEPP10CUevent_stNS_9EventFlagE = private unnamed_addr constant [12 x i8] c"createEvent\00", align 1
@.str.27 = private unnamed_addr constant [33 x i8] c"CUDA event received unknown flag\00", align 1
@__func__._ZNK3c104cuda10CUDAStream5queryEv = private unnamed_addr constant [6 x i8] c"query\00", align 1
@_ZTVN3c104impl16VirtualGuardImplE = linkonce_odr dso_local unnamed_addr constant { [25 x i8*] } { [25 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTIN3c104impl16VirtualGuardImplE to i8*), i8* bitcast (i8 (%"class.c10::impl::VirtualGuardImpl"*)* @_ZNK3c104impl16VirtualGuardImpl4typeEv to i8*), i8* bitcast (i16 (%"class.c10::impl::VirtualGuardImpl"*, i16)* @_ZNK3c104impl16VirtualGuardImpl14exchangeDeviceENS_6DeviceE to i8*), i8* bitcast (i16 (%"class.c10::impl::VirtualGuardImpl"*)* @_ZNK3c104impl16VirtualGuardImpl9getDeviceEv to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*, i16)* @_ZNK3c104impl16VirtualGuardImpl9setDeviceENS_6DeviceE to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*, i16)* @_ZNK3c104impl16VirtualGuardImpl18uncheckedSetDeviceENS_6DeviceE to i8*), i8* bitcast ({ i64, i64 } (%"class.c10::impl::VirtualGuardImpl"*, i16)* @_ZNK3c104impl16VirtualGuardImpl9getStreamENS_6DeviceE to i8*), i8* bitcast ({ i64, i64 } (%"class.c10::impl::VirtualGuardImpl"*, i16)* @_ZNK3c104impl16VirtualGuardImpl16getDefaultStreamENS_6DeviceE to i8*), i8* bitcast ({ i64, i64 } (%"class.c10::impl::VirtualGuardImpl"*, i16, i1)* @_ZNK3c104impl16VirtualGuardImpl23getStreamFromGlobalPoolENS_6DeviceEb to i8*), i8* bitcast ({ i64, i64 } (%"class.c10::impl::VirtualGuardImpl"*, i16, i32)* @_ZNK3c104impl16VirtualGuardImpl12getNewStreamENS_6DeviceEi to i8*), i8* bitcast ({ i64, i64 } (%"class.c10::impl::VirtualGuardImpl"*, i64, i64)* @_ZNK3c104impl16VirtualGuardImpl14exchangeStreamENS_6StreamE to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*, i8*, i8)* @_ZNK3c104impl16VirtualGuardImpl12destroyEventEPva to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*, i8**, %"class.c10::Stream"*, i8, i32)* @_ZNK3c104impl16VirtualGuardImpl6recordEPPvRKNS_6StreamEaNS_9EventFlagE to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*, i8*, %"class.c10::Stream"*)* @_ZNK3c104impl16VirtualGuardImpl5blockEPvRKNS_6StreamE to i8*), i8* bitcast (i1 (%"class.c10::impl::VirtualGuardImpl"*, i8*)* @_ZNK3c104impl16VirtualGuardImpl10queryEventEPv to i8*), i8* bitcast (i8 (%"class.c10::impl::VirtualGuardImpl"*)* @_ZNK3c104impl16VirtualGuardImpl11deviceCountEv to i8*), i8* bitcast (i1 (%"class.c10::impl::VirtualGuardImpl"*, %"class.c10::Stream"*)* @_ZNK3c104impl16VirtualGuardImpl11queryStreamERKNS_6StreamE to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*, %"class.c10::Stream"*)* @_ZNK3c104impl16VirtualGuardImpl17synchronizeStreamERKNS_6StreamE to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*, i8*)* @_ZNK3c104impl16VirtualGuardImpl16synchronizeEventEPv to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*, i8)* @_ZNK3c104impl16VirtualGuardImpl17synchronizeDeviceEa to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*, %"class.c10::DataPtr"*, %"class.c10::Stream"*)* @_ZNK3c104impl16VirtualGuardImpl21recordDataPtrOnStreamERKNS_7DataPtrERKNS_6StreamE to i8*), i8* bitcast (double (%"class.c10::impl::VirtualGuardImpl"*, i8*, i8*, i8)* @_ZNK3c104impl16VirtualGuardImpl11elapsedTimeEPvS2_a to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*)* @_ZN3c104impl16VirtualGuardImplD2Ev to i8*), i8* bitcast (void (%"class.c10::impl::VirtualGuardImpl"*)* @_ZN3c104impl16VirtualGuardImplD0Ev to i8*)] }, comdat, align 8
@_ZTSN3c104impl16VirtualGuardImplE = linkonce_odr dso_local constant [30 x i8] c"N3c104impl16VirtualGuardImplE\00", comdat, align 1
@_ZTIN3c104impl16VirtualGuardImplE = linkonce_odr dso_local constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @_ZTSN3c104impl16VirtualGuardImplE, i32 0, i32 0), i8* bitcast ({ i8*, i8* }* @_ZTIN3c104impl24DeviceGuardImplInterfaceE to i8*) }, comdat, align 8
@_ZN3c104impl26device_guard_impl_registryE = external dso_local global %"struct.std::array", align 8
@__func__._ZN3c104impl18getDeviceGuardImplENS_10DeviceTypeE = private unnamed_addr constant [19 x i8] c"getDeviceGuardImpl\00", align 1
@.str.28 = private unnamed_addr constant [136 x i8] c"Expected p to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@.str.29 = private unnamed_addr constant [40 x i8] c"PyTorch is not linked with support for \00", align 1
@.str.30 = private unnamed_addr constant [9 x i8] c" devices\00", align 1
@.str.31 = private unnamed_addr constant [107 x i8] c"/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/cuda/CUDAFunctions.h\00", align 1
@__func__._ZN3c104cuda18stream_synchronizeEP11CUstream_st = private unnamed_addr constant [19 x i8] c"stream_synchronize\00", align 1
@_ZZN3c104cuda13warning_stateEvE14warning_state_ = linkonce_odr dso_local global %"struct.std::__atomic_base" zeroinitializer, comdat, align 4
@_ZN3c104cuda20CUDACachingAllocator9allocatorE = external dso_local global %"struct.std::atomic.91", align 8
@.str.32 = private unnamed_addr constant [151 x i8] c"Expected event1 && event2 to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@.str.33 = private unnamed_addr constant [62 x i8] c"Both events must be recorded before calculating elapsed time.\00", align 1
@__func__._ZNK3c104cuda4impl13CUDAGuardImpl9getDeviceEv = private unnamed_addr constant [10 x i8] c"getDevice\00", align 1
@__func__._ZN3c106Device8validateEv = private unnamed_addr constant [9 x i8] c"validate\00", align 1
@.str.34 = private unnamed_addr constant [100 x i8] c"/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/Device.h\00", align 1
@.str.35 = private unnamed_addr constant [179 x i8] c"index_ >= -1 INTERNAL ASSERT FAILED at \22/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/Device.h\22:180, please report a bug to PyTorch. \00", align 1
@.str.36 = private unnamed_addr constant [46 x i8] c"Device index must be -1 or non-negative, got \00", align 1
@.str.37 = private unnamed_addr constant [191 x i8] c"!is_cpu() || index_ <= 0 INTERNAL ASSERT FAILED at \22/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/Device.h\22:184, please report a bug to PyTorch. \00", align 1
@.str.38 = private unnamed_addr constant [42 x i8] c"CPU device index must be -1 or zero, got \00", align 1
@__func__._ZNK3c104cuda4impl13CUDAGuardImpl14exchangeDeviceENS_6DeviceE = private unnamed_addr constant [15 x i8] c"exchangeDevice\00", align 1
@.str.39 = private unnamed_addr constant [189 x i8] c"d.is_cuda() INTERNAL ASSERT FAILED at \22/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/cuda/impl/CUDAGuardImpl.h\22:34, please report a bug to PyTorch. \00", align 1
@_ZTSSt19bad_optional_access = linkonce_odr dso_local constant [24 x i8] c"St19bad_optional_access\00", comdat, align 1
@_ZTISt9exception = external dso_local constant i8*
@_ZTISt19bad_optional_access = linkonce_odr dso_local constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @_ZTSSt19bad_optional_access, i32 0, i32 0), i8* bitcast (i8** @_ZTISt9exception to i8*) }, comdat, align 8
@_ZTVSt19bad_optional_access = linkonce_odr dso_local unnamed_addr constant { [5 x i8*] } { [5 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTISt19bad_optional_access to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*)* @_ZNSt19bad_optional_accessD2Ev to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*)* @_ZNSt19bad_optional_accessD0Ev to i8*), i8* bitcast (i8* (%"struct.c10::cuda::impl::CUDAGuardImpl"*)* @_ZNKSt19bad_optional_access4whatEv to i8*)] }, comdat, align 8
@_ZTVSt9exception = external dso_local unnamed_addr constant { [5 x i8*] }, align 8
@.str.40 = private unnamed_addr constant [20 x i8] c"bad optional access\00", align 1
@.str.41 = private unnamed_addr constant [24 x i8] c"scaled_fp8_quant_kernel\00", align 1
@__func__._ZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEv = private unnamed_addr constant [11 x i8] c"operator()\00", align 1
@.str.42 = private unnamed_addr constant [24 x i8] c"\22 not implemented for '\00", align 1
@.str.43 = private unnamed_addr constant [2 x i8] c"'\00", align 1
@.str.44 = private unnamed_addr constant [5 x i8] c"Byte\00", align 1
@.str.45 = private unnamed_addr constant [5 x i8] c"Char\00", align 1
@.str.46 = private unnamed_addr constant [6 x i8] c"Short\00", align 1
@.str.47 = private unnamed_addr constant [4 x i8] c"Int\00", align 1
@.str.48 = private unnamed_addr constant [5 x i8] c"Long\00", align 1
@.str.49 = private unnamed_addr constant [5 x i8] c"Half\00", align 1
@.str.50 = private unnamed_addr constant [6 x i8] c"Float\00", align 1
@.str.51 = private unnamed_addr constant [7 x i8] c"Double\00", align 1
@.str.52 = private unnamed_addr constant [12 x i8] c"ComplexHalf\00", align 1
@.str.53 = private unnamed_addr constant [13 x i8] c"ComplexFloat\00", align 1
@.str.54 = private unnamed_addr constant [14 x i8] c"ComplexDouble\00", align 1
@.str.55 = private unnamed_addr constant [5 x i8] c"Bool\00", align 1
@.str.56 = private unnamed_addr constant [6 x i8] c"QInt8\00", align 1
@.str.57 = private unnamed_addr constant [7 x i8] c"QUInt8\00", align 1
@.str.58 = private unnamed_addr constant [7 x i8] c"QInt32\00", align 1
@.str.59 = private unnamed_addr constant [9 x i8] c"BFloat16\00", align 1
@.str.60 = private unnamed_addr constant [9 x i8] c"QUInt4x2\00", align 1
@.str.61 = private unnamed_addr constant [9 x i8] c"QUInt2x4\00", align 1
@.str.62 = private unnamed_addr constant [8 x i8] c"Bits1x8\00", align 1
@.str.63 = private unnamed_addr constant [8 x i8] c"Bits2x4\00", align 1
@.str.64 = private unnamed_addr constant [8 x i8] c"Bits4x2\00", align 1
@.str.65 = private unnamed_addr constant [6 x i8] c"Bits8\00", align 1
@.str.66 = private unnamed_addr constant [7 x i8] c"Bits16\00", align 1
@.str.67 = private unnamed_addr constant [12 x i8] c"Float8_e5m2\00", align 1
@.str.68 = private unnamed_addr constant [14 x i8] c"Float8_e4m3fn\00", align 1
@.str.69 = private unnamed_addr constant [16 x i8] c"Float8_e5m2fnuz\00", align 1
@.str.70 = private unnamed_addr constant [16 x i8] c"Float8_e4m3fnuz\00", align 1
@.str.71 = private unnamed_addr constant [7 x i8] c"UInt16\00", align 1
@.str.72 = private unnamed_addr constant [7 x i8] c"UInt32\00", align 1
@.str.73 = private unnamed_addr constant [7 x i8] c"UInt64\00", align 1
@.str.74 = private unnamed_addr constant [6 x i8] c"UInt1\00", align 1
@.str.75 = private unnamed_addr constant [6 x i8] c"UInt2\00", align 1
@.str.76 = private unnamed_addr constant [6 x i8] c"UInt3\00", align 1
@.str.77 = private unnamed_addr constant [6 x i8] c"UInt4\00", align 1
@.str.78 = private unnamed_addr constant [6 x i8] c"UInt5\00", align 1
@.str.79 = private unnamed_addr constant [6 x i8] c"UInt6\00", align 1
@.str.80 = private unnamed_addr constant [6 x i8] c"UInt7\00", align 1
@.str.81 = private unnamed_addr constant [5 x i8] c"Int1\00", align 1
@.str.82 = private unnamed_addr constant [5 x i8] c"Int2\00", align 1
@.str.83 = private unnamed_addr constant [5 x i8] c"Int3\00", align 1
@.str.84 = private unnamed_addr constant [5 x i8] c"Int4\00", align 1
@.str.85 = private unnamed_addr constant [5 x i8] c"Int5\00", align 1
@.str.86 = private unnamed_addr constant [5 x i8] c"Int6\00", align 1
@.str.87 = private unnamed_addr constant [5 x i8] c"Int7\00", align 1
@.str.88 = private unnamed_addr constant [15 x i8] c"Float8_e8m0fnu\00", align 1
@.str.89 = private unnamed_addr constant [15 x i8] c"UNKNOWN_SCALAR\00", align 1
@__func__._ZNK3c1010TensorImpl19symbolic_shape_metaEv = private unnamed_addr constant [20 x i8] c"symbolic_shape_meta\00", align 1
@.str.90 = private unnamed_addr constant [220 x i8] c"extra_meta_ && extra_meta_->symbolic_shape_meta_ INTERNAL ASSERT FAILED at \22/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/TensorImpl.h\22:1733, please report a bug to PyTorch. \00", align 1
@.str.91 = private unnamed_addr constant [42 x i8] c"dynamic_per_token_scaled_fp8_quant_kernel\00", align 1
@_ZZN4vllm23segmented_max_reductionIfEEvPfPKT_lE5cache = linkonce_odr dso_local addrspace(3) global [1024 x float] undef, comdat, align 4
@_ZZN4vllm23segmented_max_reductionIN3c104HalfEEEvPfPKT_lE5cache = linkonce_odr dso_local addrspace(3) global [1024 x float] undef, comdat, align 4
@_ZZN4vllm23segmented_max_reductionIN3c108BFloat16EEEvPfPKT_lE5cache = linkonce_odr dso_local addrspace(3) global [1024 x float] undef, comdat, align 4
@_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfiE11token_scale = linkonce_odr dso_local addrspace(3) global float undef, comdat, align 4
@_ZZN4vllm11blockReduceIfLi1024EEET_S1_PFS1_S1_S1_EE6shared = linkonce_odr dso_local addrspace(3) global [32 x float] undef, comdat, align 4
@_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale = linkonce_odr dso_local addrspace(3) global float undef, comdat, align 4
@_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale = linkonce_odr dso_local addrspace(3) global float undef, comdat, align 4

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_common.cu() #0 section ".text.startup" {
  call void @__cxx_global_var_init()
  ret void
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" {
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %1 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #3
  ret void
}

declare dso_local void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nounwind
declare dso_local void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #2

; Function Attrs: nounwind
declare dso_local i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #3

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_Z23static_scaled_fp8_quantRN2at6TensorERKS0_S3_(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %0, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %1, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %2) #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %4 = alloca %"class.at::Tensor"*, align 8
  %5 = alloca %"class.at::Tensor"*, align 8
  %6 = alloca %"class.at::Tensor"*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca %struct.dim3, align 4
  %10 = alloca %struct.dim3, align 4
  %11 = alloca %"struct.c10::cuda::OptionalCUDAGuard", align 8
  %12 = alloca %"class.std::optional.53", align 1
  %13 = alloca i24, align 4
  %14 = alloca i24, align 4
  %15 = alloca %struct.CUstream_st*, align 8
  %16 = alloca %"class.c10::cuda::CUDAStream", align 8
  %17 = alloca i8*, align 8
  %18 = alloca i32, align 4
  %19 = alloca %class.anon, align 8
  store %"class.at::Tensor"* %0, %"class.at::Tensor"** %4, align 8
  store %"class.at::Tensor"* %1, %"class.at::Tensor"** %5, align 8
  store %"class.at::Tensor"* %2, %"class.at::Tensor"** %6, align 8
  %20 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  %21 = bitcast %"class.at::Tensor"* %20 to %"class.at::TensorBase"*
  %22 = call i64 @_ZNK2at10TensorBase5numelEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %21)
  %23 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  %24 = bitcast %"class.at::Tensor"* %23 to %"class.at::TensorBase"*
  %25 = call i64 @_ZNK2at10TensorBase4sizeEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %24, i64 -1)
  %26 = sdiv i64 %22, %25
  store i64 %26, i64* %7, align 8
  %27 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  %28 = bitcast %"class.at::Tensor"* %27 to %"class.at::TensorBase"*
  %29 = call i64 @_ZNK2at10TensorBase5numelEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %28)
  store i64 %29, i64* %8, align 8
  %30 = load i64, i64* %7, align 8
  %31 = trunc i64 %30 to i32
  call void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %9, i32 %31, i32 1, i32 1)
  call void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %10, i32 1024, i32 1, i32 1)
  %32 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  %33 = call i24 @_ZN2at9device_ofERKNS_6TensorE(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %32)
  %34 = getelementptr inbounds %"class.std::optional.53", %"class.std::optional.53"* %12, i32 0, i32 0
  %35 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %34, i32 0, i32 0
  %36 = getelementptr inbounds %"struct.std::_Optional_payload.56", %"struct.std::_Optional_payload.56"* %35, i32 0, i32 0
  store i24 %33, i24* %13, align 4
  %37 = bitcast %"struct.std::_Optional_payload_base.57"* %36 to i8*
  %38 = bitcast i24* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %37, i8* align 4 %38, i64 3, i1 false)
  %39 = getelementptr inbounds %"class.std::optional.53", %"class.std::optional.53"* %12, i32 0, i32 0
  %40 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %39, i32 0, i32 0
  %41 = getelementptr inbounds %"struct.std::_Optional_payload.56", %"struct.std::_Optional_payload.56"* %40, i32 0, i32 0
  %42 = bitcast i24* %14 to i8*
  %43 = bitcast %"struct.std::_Optional_payload_base.57"* %41 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %42, i8* align 1 %43, i64 3, i1 false)
  %44 = load i24, i24* %14, align 4
  call void @_ZN3c104cuda17OptionalCUDAGuardC2ESt8optionalINS_6DeviceEE(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %11, i24 %44)
  %45 = invoke { i64, i64 } @_ZN3c104cuda20getCurrentCUDAStreamEa(i8 signext -1)
          to label %46 unwind label %66

46:                                               ; preds = %3
  %47 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %16, i32 0, i32 0
  %48 = bitcast %"class.c10::Stream"* %47 to { i64, i64 }*
  %49 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %48, i32 0, i32 0
  %50 = extractvalue { i64, i64 } %45, 0
  store i64 %50, i64* %49, align 8
  %51 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %48, i32 0, i32 1
  %52 = extractvalue { i64, i64 } %45, 1
  store i64 %52, i64* %51, align 8
  %53 = invoke %struct.CUstream_st* @_ZNK3c104cuda10CUDAStreamcvP11CUstream_stEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %16)
          to label %54 unwind label %66

54:                                               ; preds = %46
  store %struct.CUstream_st* %53, %struct.CUstream_st** %15, align 8
  %55 = getelementptr inbounds %class.anon, %class.anon* %19, i32 0, i32 0
  %56 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  store %"class.at::Tensor"* %56, %"class.at::Tensor"** %55, align 8
  %57 = getelementptr inbounds %class.anon, %class.anon* %19, i32 0, i32 1
  store %struct.dim3* %9, %struct.dim3** %57, align 8
  %58 = getelementptr inbounds %class.anon, %class.anon* %19, i32 0, i32 2
  store %struct.dim3* %10, %struct.dim3** %58, align 8
  %59 = getelementptr inbounds %class.anon, %class.anon* %19, i32 0, i32 3
  store %struct.CUstream_st** %15, %struct.CUstream_st*** %59, align 8
  %60 = getelementptr inbounds %class.anon, %class.anon* %19, i32 0, i32 4
  %61 = load %"class.at::Tensor"*, %"class.at::Tensor"** %4, align 8
  store %"class.at::Tensor"* %61, %"class.at::Tensor"** %60, align 8
  %62 = getelementptr inbounds %class.anon, %class.anon* %19, i32 0, i32 5
  %63 = load %"class.at::Tensor"*, %"class.at::Tensor"** %6, align 8
  store %"class.at::Tensor"* %63, %"class.at::Tensor"** %62, align 8
  %64 = getelementptr inbounds %class.anon, %class.anon* %19, i32 0, i32 6
  store i64* %8, i64** %64, align 8
  invoke void @_ZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEv(%class.anon* nonnull align 8 dereferenceable(56) %19)
          to label %65 unwind label %66

65:                                               ; preds = %54
  call void @_ZN3c104cuda17OptionalCUDAGuardD2Ev(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %11) #3
  ret void

66:                                               ; preds = %54, %46, %3
  %67 = landingpad { i8*, i32 }
          cleanup
  %68 = extractvalue { i8*, i32 } %67, 0
  store i8* %68, i8** %17, align 8
  %69 = extractvalue { i8*, i32 } %67, 1
  store i32 %69, i32* %18, align 4
  call void @_ZN3c104cuda17OptionalCUDAGuardD2Ev(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %11) #3
  br label %70

70:                                               ; preds = %66
  %71 = load i8*, i8** %17, align 8
  %72 = load i32, i32* %18, align 4
  %73 = insertvalue { i8*, i32 } undef, i8* %71, 0
  %74 = insertvalue { i8*, i32 } %73, i32 %72, 1
  resume { i8*, i32 } %74
}

declare dso_local i32 @__gxx_personality_v0(...)

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK2at10TensorBase5numelEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0) #4 comdat align 2 {
  %2 = alloca %"class.at::TensorBase"*, align 8
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %2, align 8
  %3 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %2, align 8
  %4 = getelementptr inbounds %"class.at::TensorBase", %"class.at::TensorBase"* %3, i32 0, i32 0
  %5 = call %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %4) #3
  %6 = call i64 @_ZNK3c1010TensorImpl5numelEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %5)
  ret i64 %6
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK2at10TensorBase4sizeEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0, i64 %1) #4 comdat align 2 {
  %3 = alloca %"class.at::TensorBase"*, align 8
  %4 = alloca i64, align 8
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %3, align 8
  %6 = getelementptr inbounds %"class.at::TensorBase", %"class.at::TensorBase"* %5, i32 0, i32 0
  %7 = call %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %6) #3
  %8 = load i64, i64* %4, align 8
  %9 = call i64 @_ZNK3c1010TensorImpl4sizeEl(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %7, i64 %8)
  ret i64 %9
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %0, i32 %1, i32 %2, i32 %3) unnamed_addr #5 comdat align 2 {
  %5 = alloca %struct.dim3*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.dim3* %0, %struct.dim3** %5, align 8
  store i32 %1, i32* %6, align 4
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %9 = load %struct.dim3*, %struct.dim3** %5, align 8
  %10 = getelementptr inbounds %struct.dim3, %struct.dim3* %9, i32 0, i32 0
  %11 = load i32, i32* %6, align 4
  store i32 %11, i32* %10, align 4
  %12 = getelementptr inbounds %struct.dim3, %struct.dim3* %9, i32 0, i32 1
  %13 = load i32, i32* %7, align 4
  store i32 %13, i32* %12, align 4
  %14 = getelementptr inbounds %struct.dim3, %struct.dim3* %9, i32 0, i32 2
  %15 = load i32, i32* %8, align 4
  store i32 %15, i32* %14, align 4
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i24 @_ZN2at9device_ofERKNS_6TensorE(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %0) #4 comdat {
  %2 = alloca %"class.std::optional.53", align 1
  %3 = alloca %"class.at::Tensor"*, align 8
  %4 = alloca %"struct.c10::Device", align 1
  %5 = alloca %"class.std::ios_base::Init", align 1
  %6 = alloca i24, align 4
  store %"class.at::Tensor"* %0, %"class.at::Tensor"** %3, align 8
  %7 = load %"class.at::Tensor"*, %"class.at::Tensor"** %3, align 8
  %8 = bitcast %"class.at::Tensor"* %7 to %"class.at::TensorBase"*
  %9 = call zeroext i1 @_ZNK2at10TensorBase7definedEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %8)
  br i1 %9, label %10, label %15

10:                                               ; preds = %1
  %11 = load %"class.at::Tensor"*, %"class.at::Tensor"** %3, align 8
  %12 = bitcast %"class.at::Tensor"* %11 to %"class.at::TensorBase"*
  %13 = call i16 @_ZNK2at10TensorBase6deviceEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %12)
  %14 = bitcast %"struct.c10::Device"* %4 to i16*
  store i16 %13, i16* %14, align 1
  call void @_ZNSt8optionalIN3c106DeviceEEC2IS1_Lb1EEEOT_(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %2, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %4) #3
  br label %16

15:                                               ; preds = %1
  call void @_ZNSt8optionalIN3c106DeviceEEC2ESt9nullopt_t(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %2) #3
  br label %16

16:                                               ; preds = %15, %10
  %17 = getelementptr inbounds %"class.std::optional.53", %"class.std::optional.53"* %2, i32 0, i32 0
  %18 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %17, i32 0, i32 0
  %19 = getelementptr inbounds %"struct.std::_Optional_payload.56", %"struct.std::_Optional_payload.56"* %18, i32 0, i32 0
  %20 = bitcast i24* %6 to i8*
  %21 = bitcast %"struct.std::_Optional_payload_base.57"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %20, i8* align 1 %21, i64 3, i1 false)
  %22 = load i24, i24* %6, align 4
  ret i24 %22
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #6

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c104cuda17OptionalCUDAGuardC2ESt8optionalINS_6DeviceEE(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %0, i24 %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::optional.53", align 1
  %4 = alloca i24, align 4
  %5 = alloca %"struct.c10::cuda::OptionalCUDAGuard"*, align 8
  %6 = alloca %"class.std::optional.53", align 1
  %7 = alloca i24, align 4
  %8 = getelementptr inbounds %"class.std::optional.53", %"class.std::optional.53"* %3, i32 0, i32 0
  %9 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %8, i32 0, i32 0
  %10 = getelementptr inbounds %"struct.std::_Optional_payload.56", %"struct.std::_Optional_payload.56"* %9, i32 0, i32 0
  store i24 %1, i24* %4, align 4
  %11 = bitcast %"struct.std::_Optional_payload_base.57"* %10 to i8*
  %12 = bitcast i24* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 4 %12, i64 3, i1 false)
  store %"struct.c10::cuda::OptionalCUDAGuard"* %0, %"struct.c10::cuda::OptionalCUDAGuard"** %5, align 8
  %13 = load %"struct.c10::cuda::OptionalCUDAGuard"*, %"struct.c10::cuda::OptionalCUDAGuard"** %5, align 8
  %14 = getelementptr inbounds %"struct.c10::cuda::OptionalCUDAGuard", %"struct.c10::cuda::OptionalCUDAGuard"* %13, i32 0, i32 0
  %15 = bitcast %"class.std::optional.53"* %6 to i8*
  %16 = bitcast %"class.std::optional.53"* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %15, i8* align 1 %16, i64 3, i1 false)
  %17 = getelementptr inbounds %"class.std::optional.53", %"class.std::optional.53"* %6, i32 0, i32 0
  %18 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %17, i32 0, i32 0
  %19 = getelementptr inbounds %"struct.std::_Optional_payload.56", %"struct.std::_Optional_payload.56"* %18, i32 0, i32 0
  %20 = bitcast i24* %7 to i8*
  %21 = bitcast %"struct.std::_Optional_payload_base.57"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %20, i8* align 1 %21, i64 3, i1 false)
  %22 = load i24, i24* %7, align 4
  call void @_ZN3c104impl25InlineOptionalDeviceGuardINS_4cuda4impl13CUDAGuardImplEEC2ESt8optionalINS_6DeviceEE(%"class.c10::impl::InlineOptionalDeviceGuard"* nonnull align 8 dereferenceable(24) %14, i24 %22)
  ret void
}

declare dso_local { i64, i64 } @_ZN3c104cuda20getCurrentCUDAStreamEa(i8 signext) #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local %struct.CUstream_st* @_ZNK3c104cuda10CUDAStreamcvP11CUstream_stEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %0) #4 comdat align 2 {
  %2 = alloca %"class.c10::cuda::CUDAStream"*, align 8
  store %"class.c10::cuda::CUDAStream"* %0, %"class.c10::cuda::CUDAStream"** %2, align 8
  %3 = load %"class.c10::cuda::CUDAStream"*, %"class.c10::cuda::CUDAStream"** %2, align 8
  %4 = call %struct.CUstream_st* @_ZNK3c104cuda10CUDAStream6streamEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %3)
  ret %struct.CUstream_st* %4
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEv(%class.anon* nonnull align 8 dereferenceable(56) %0) #4 align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %class.anon*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i8, align 1
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  %7 = alloca %class.anon.93, align 8
  %8 = alloca %class.anon.93, align 8
  %9 = alloca %class.anon.93, align 8
  %10 = alloca %"class.std::__cxx11::basic_string", align 8
  %11 = alloca i8, align 1
  %12 = alloca i8*, align 8
  %13 = alloca i8*, align 8
  %14 = alloca i32, align 4
  store %class.anon* %0, %class.anon** %2, align 8
  %15 = load %class.anon*, %class.anon** %2, align 8
  %16 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 0
  %17 = load %"class.at::Tensor"*, %"class.at::Tensor"** %16, align 8
  %18 = bitcast %"class.at::Tensor"* %17 to %"class.at::TensorBase"*
  %19 = call signext i8 @_ZNK2at10TensorBase11scalar_typeEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %18)
  store i8 %19, i8* %4, align 1
  store i8* %4, i8** %3, align 8
  store i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.41, i32 0, i32 0), i8** %5, align 8
  %20 = load i8*, i8** %3, align 8
  %21 = load i8, i8* %20, align 1
  %22 = call signext i8 @_ZN6detail11scalar_typeEN3c1010ScalarTypeE(i8 signext %21)
  store i8 %22, i8* %6, align 1
  %23 = load i8, i8* %6, align 1
  switch i8 %23, label %96 [
    i8 6, label %24
    i8 5, label %48
    i8 15, label %72
  ]

24:                                               ; preds = %1
  br label %25

25:                                               ; preds = %24
  br label %26

26:                                               ; preds = %25
  %27 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 0
  %28 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 1
  %29 = load %struct.dim3*, %struct.dim3** %28, align 8
  store %struct.dim3* %29, %struct.dim3** %27, align 8
  %30 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 1
  %31 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 2
  %32 = load %struct.dim3*, %struct.dim3** %31, align 8
  store %struct.dim3* %32, %struct.dim3** %30, align 8
  %33 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 2
  %34 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 3
  %35 = load %struct.CUstream_st**, %struct.CUstream_st*** %34, align 8
  store %struct.CUstream_st** %35, %struct.CUstream_st*** %33, align 8
  %36 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 3
  %37 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 4
  %38 = load %"class.at::Tensor"*, %"class.at::Tensor"** %37, align 8
  store %"class.at::Tensor"* %38, %"class.at::Tensor"** %36, align 8
  %39 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 4
  %40 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 0
  %41 = load %"class.at::Tensor"*, %"class.at::Tensor"** %40, align 8
  store %"class.at::Tensor"* %41, %"class.at::Tensor"** %39, align 8
  %42 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 5
  %43 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 5
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  store %"class.at::Tensor"* %44, %"class.at::Tensor"** %42, align 8
  %45 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 6
  %46 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 6
  %47 = load i64*, i64** %46, align 8
  store i64* %47, i64** %45, align 8
  call void @_ZZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEvENKUlvE_clEv(%class.anon.93* nonnull align 8 dereferenceable(56) %7)
  br label %104

48:                                               ; preds = %1
  br label %49

49:                                               ; preds = %48
  br label %50

50:                                               ; preds = %49
  %51 = getelementptr inbounds %class.anon.93, %class.anon.93* %8, i32 0, i32 0
  %52 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 1
  %53 = load %struct.dim3*, %struct.dim3** %52, align 8
  store %struct.dim3* %53, %struct.dim3** %51, align 8
  %54 = getelementptr inbounds %class.anon.93, %class.anon.93* %8, i32 0, i32 1
  %55 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 2
  %56 = load %struct.dim3*, %struct.dim3** %55, align 8
  store %struct.dim3* %56, %struct.dim3** %54, align 8
  %57 = getelementptr inbounds %class.anon.93, %class.anon.93* %8, i32 0, i32 2
  %58 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 3
  %59 = load %struct.CUstream_st**, %struct.CUstream_st*** %58, align 8
  store %struct.CUstream_st** %59, %struct.CUstream_st*** %57, align 8
  %60 = getelementptr inbounds %class.anon.93, %class.anon.93* %8, i32 0, i32 3
  %61 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 4
  %62 = load %"class.at::Tensor"*, %"class.at::Tensor"** %61, align 8
  store %"class.at::Tensor"* %62, %"class.at::Tensor"** %60, align 8
  %63 = getelementptr inbounds %class.anon.93, %class.anon.93* %8, i32 0, i32 4
  %64 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 0
  %65 = load %"class.at::Tensor"*, %"class.at::Tensor"** %64, align 8
  store %"class.at::Tensor"* %65, %"class.at::Tensor"** %63, align 8
  %66 = getelementptr inbounds %class.anon.93, %class.anon.93* %8, i32 0, i32 5
  %67 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 5
  %68 = load %"class.at::Tensor"*, %"class.at::Tensor"** %67, align 8
  store %"class.at::Tensor"* %68, %"class.at::Tensor"** %66, align 8
  %69 = getelementptr inbounds %class.anon.93, %class.anon.93* %8, i32 0, i32 6
  %70 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 6
  %71 = load i64*, i64** %70, align 8
  store i64* %71, i64** %69, align 8
  call void @_ZZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEvENKUlvE0_clEv(%class.anon.93* nonnull align 8 dereferenceable(56) %8)
  br label %104

72:                                               ; preds = %1
  br label %73

73:                                               ; preds = %72
  br label %74

74:                                               ; preds = %73
  %75 = getelementptr inbounds %class.anon.93, %class.anon.93* %9, i32 0, i32 0
  %76 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 1
  %77 = load %struct.dim3*, %struct.dim3** %76, align 8
  store %struct.dim3* %77, %struct.dim3** %75, align 8
  %78 = getelementptr inbounds %class.anon.93, %class.anon.93* %9, i32 0, i32 1
  %79 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 2
  %80 = load %struct.dim3*, %struct.dim3** %79, align 8
  store %struct.dim3* %80, %struct.dim3** %78, align 8
  %81 = getelementptr inbounds %class.anon.93, %class.anon.93* %9, i32 0, i32 2
  %82 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 3
  %83 = load %struct.CUstream_st**, %struct.CUstream_st*** %82, align 8
  store %struct.CUstream_st** %83, %struct.CUstream_st*** %81, align 8
  %84 = getelementptr inbounds %class.anon.93, %class.anon.93* %9, i32 0, i32 3
  %85 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 4
  %86 = load %"class.at::Tensor"*, %"class.at::Tensor"** %85, align 8
  store %"class.at::Tensor"* %86, %"class.at::Tensor"** %84, align 8
  %87 = getelementptr inbounds %class.anon.93, %class.anon.93* %9, i32 0, i32 4
  %88 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 0
  %89 = load %"class.at::Tensor"*, %"class.at::Tensor"** %88, align 8
  store %"class.at::Tensor"* %89, %"class.at::Tensor"** %87, align 8
  %90 = getelementptr inbounds %class.anon.93, %class.anon.93* %9, i32 0, i32 5
  %91 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 5
  %92 = load %"class.at::Tensor"*, %"class.at::Tensor"** %91, align 8
  store %"class.at::Tensor"* %92, %"class.at::Tensor"** %90, align 8
  %93 = getelementptr inbounds %class.anon.93, %class.anon.93* %9, i32 0, i32 6
  %94 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 6
  %95 = load i64*, i64** %94, align 8
  store i64* %95, i64** %93, align 8
  call void @_ZZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEvENKUlvE1_clEv(%class.anon.93* nonnull align 8 dereferenceable(56) %9)
  br label %104

96:                                               ; preds = %1
  store i8 34, i8* %11, align 1
  %97 = load i8, i8* %6, align 1
  %98 = call i8* @_ZN3c108toStringENS_10ScalarTypeE(i8 signext %97)
  store i8* %98, i8** %12, align 8
  call void @_ZN3c106detail17torchCheckMsgImplIJcPKcA24_cS3_A2_cEEEDcS3_DpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %10, i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* nonnull align 1 dereferenceable(1) %11, i8** nonnull align 8 dereferenceable(8) %5, [24 x i8]* nonnull align 1 dereferenceable(24) @.str.42, i8** nonnull align 8 dereferenceable(8) %12, [2 x i8]* nonnull align 1 dereferenceable(2) @.str.43)
  invoke void @_ZN3c106detail14torchCheckFailEPKcS2_jRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__func__._ZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEv, i64 0, i64 0), i8* getelementptr inbounds ([73 x i8], [73 x i8]* @.str, i64 0, i64 0), i32 246, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %10) #25
          to label %99 unwind label %100

99:                                               ; preds = %96
  unreachable

100:                                              ; preds = %96
  %101 = landingpad { i8*, i32 }
          cleanup
  %102 = extractvalue { i8*, i32 } %101, 0
  store i8* %102, i8** %13, align 8
  %103 = extractvalue { i8*, i32 } %101, 1
  store i32 %103, i32* %14, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %10) #3
  br label %105

104:                                              ; preds = %74, %50, %26
  ret void

105:                                              ; preds = %100
  %106 = load i8*, i8** %13, align 8
  %107 = load i32, i32* %14, align 4
  %108 = insertvalue { i8*, i32 } undef, i8* %106, 0
  %109 = insertvalue { i8*, i32 } %108, i32 %107, 1
  resume { i8*, i32 } %109
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104cuda17OptionalCUDAGuardD2Ev(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.c10::cuda::OptionalCUDAGuard"*, align 8
  store %"struct.c10::cuda::OptionalCUDAGuard"* %0, %"struct.c10::cuda::OptionalCUDAGuard"** %2, align 8
  %3 = load %"struct.c10::cuda::OptionalCUDAGuard"*, %"struct.c10::cuda::OptionalCUDAGuard"** %2, align 8
  %4 = getelementptr inbounds %"struct.c10::cuda::OptionalCUDAGuard", %"struct.c10::cuda::OptionalCUDAGuard"* %3, i32 0, i32 0
  call void @_ZN3c104impl25InlineOptionalDeviceGuardINS_4cuda4impl13CUDAGuardImplEED2Ev(%"class.c10::impl::InlineOptionalDeviceGuard"* nonnull align 8 dereferenceable(24) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl25InlineOptionalDeviceGuardINS_4cuda4impl13CUDAGuardImplEED2Ev(%"class.c10::impl::InlineOptionalDeviceGuard"* nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.c10::impl::InlineOptionalDeviceGuard"*, align 8
  store %"class.c10::impl::InlineOptionalDeviceGuard"* %0, %"class.c10::impl::InlineOptionalDeviceGuard"** %2, align 8
  %3 = load %"class.c10::impl::InlineOptionalDeviceGuard"*, %"class.c10::impl::InlineOptionalDeviceGuard"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::impl::InlineOptionalDeviceGuard", %"class.c10::impl::InlineOptionalDeviceGuard"* %3, i32 0, i32 0
  call void @_ZNSt8optionalIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEED2Ev(%"class.std::optional.59"* nonnull align 8 dereferenceable(24) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt8optionalIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEED2Ev(%"class.std::optional.59"* nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.std::optional.59"*, align 8
  store %"class.std::optional.59"* %0, %"class.std::optional.59"** %2, align 8
  %3 = load %"class.std::optional.59"*, %"class.std::optional.59"** %2, align 8
  %4 = bitcast %"class.std::optional.59"* %3 to %"struct.std::_Optional_base.60"*
  call void @_ZNSt14_Optional_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0EED2Ev(%"struct.std::_Optional_base.60"* nonnull align 8 dereferenceable(24) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt14_Optional_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0EED2Ev(%"struct.std::_Optional_base.60"* nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_base.60"*, align 8
  store %"struct.std::_Optional_base.60"* %0, %"struct.std::_Optional_base.60"** %2, align 8
  %3 = load %"struct.std::_Optional_base.60"*, %"struct.std::_Optional_base.60"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_base.60", %"struct.std::_Optional_base.60"* %3, i32 0, i32 0
  call void @_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0ELb0EED2Ev(%"struct.std::_Optional_payload.62"* nonnull align 8 dereferenceable(17) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0ELb0EED2Ev(%"struct.std::_Optional_payload.62"* nonnull align 8 dereferenceable(17) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload.62"*, align 8
  store %"struct.std::_Optional_payload.62"* %0, %"struct.std::_Optional_payload.62"** %2, align 8
  %3 = load %"struct.std::_Optional_payload.62"*, %"struct.std::_Optional_payload.62"** %2, align 8
  %4 = bitcast %"struct.std::_Optional_payload.62"* %3 to %"struct.std::_Optional_payload_base.64"*
  call void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE8_M_resetEv(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %4) #3
  %5 = bitcast %"struct.std::_Optional_payload.62"* %3 to %"struct.std::_Optional_payload.63"*
  call void @_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb1ELb0ELb0EED2Ev(%"struct.std::_Optional_payload.63"* nonnull align 8 dereferenceable(17) %5) #3
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE8_M_resetEv(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload_base.64"*, align 8
  store %"struct.std::_Optional_payload_base.64"* %0, %"struct.std::_Optional_payload_base.64"** %2, align 8
  %3 = load %"struct.std::_Optional_payload_base.64"*, %"struct.std::_Optional_payload_base.64"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_payload_base.64", %"struct.std::_Optional_payload_base.64"* %3, i32 0, i32 1
  %5 = load i8, i8* %4, align 8
  %6 = trunc i8 %5 to i1
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  call void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE10_M_destroyEv(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %3) #3
  br label %8

8:                                                ; preds = %7, %1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb1ELb0ELb0EED2Ev(%"struct.std::_Optional_payload.63"* nonnull align 8 dereferenceable(17) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload.63"*, align 8
  store %"struct.std::_Optional_payload.63"* %0, %"struct.std::_Optional_payload.63"** %2, align 8
  %3 = load %"struct.std::_Optional_payload.63"*, %"struct.std::_Optional_payload.63"** %2, align 8
  %4 = bitcast %"struct.std::_Optional_payload.63"* %3 to %"struct.std::_Optional_payload_base.64"*
  call void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEED2Ev(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEED2Ev(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload_base.64"*, align 8
  store %"struct.std::_Optional_payload_base.64"* %0, %"struct.std::_Optional_payload_base.64"** %2, align 8
  %3 = load %"struct.std::_Optional_payload_base.64"*, %"struct.std::_Optional_payload_base.64"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_payload_base.64", %"struct.std::_Optional_payload_base.64"* %3, i32 0, i32 0
  call void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE8_StorageIS6_Lb0EED2Ev(%"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"* nonnull align 8 dereferenceable(16) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE8_StorageIS6_Lb0EED2Ev(%"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"* nonnull align 8 dereferenceable(16) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"*, align 8
  store %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"* %0, %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"** %2, align 8
  %3 = load %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"*, %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"** %2, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE10_M_destroyEv(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload_base.64"*, align 8
  store %"struct.std::_Optional_payload_base.64"* %0, %"struct.std::_Optional_payload_base.64"** %2, align 8
  %3 = load %"struct.std::_Optional_payload_base.64"*, %"struct.std::_Optional_payload_base.64"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_payload_base.64", %"struct.std::_Optional_payload_base.64"* %3, i32 0, i32 1
  store i8 0, i8* %4, align 8
  %5 = getelementptr inbounds %"struct.std::_Optional_payload_base.64", %"struct.std::_Optional_payload_base.64"* %3, i32 0, i32 0
  %6 = bitcast %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"* %5 to %"class.c10::impl::InlineDeviceGuard"*
  call void @_ZN3c104impl17InlineDeviceGuardINS_4cuda4impl13CUDAGuardImplEED2Ev(%"class.c10::impl::InlineDeviceGuard"* nonnull align 8 dereferenceable(12) %6) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl17InlineDeviceGuardINS_4cuda4impl13CUDAGuardImplEED2Ev(%"class.c10::impl::InlineDeviceGuard"* nonnull align 8 dereferenceable(12) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.c10::impl::InlineDeviceGuard"*, align 8
  %3 = alloca %"struct.c10::Device", align 1
  store %"class.c10::impl::InlineDeviceGuard"* %0, %"class.c10::impl::InlineDeviceGuard"** %2, align 8
  %4 = load %"class.c10::impl::InlineDeviceGuard"*, %"class.c10::impl::InlineDeviceGuard"** %2, align 8
  %5 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard", %"class.c10::impl::InlineDeviceGuard"* %4, i32 0, i32 0
  %6 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard", %"class.c10::impl::InlineDeviceGuard"* %4, i32 0, i32 1
  %7 = bitcast %"struct.c10::Device"* %3 to i8*
  %8 = bitcast %"struct.c10::Device"* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %7, i8* align 8 %8, i64 2, i1 false)
  %9 = bitcast %"struct.c10::Device"* %3 to i16*
  %10 = load i16, i16* %9, align 1
  call void @_ZNK3c104cuda4impl13CUDAGuardImpl18uncheckedSetDeviceENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %5, i16 %10) #3
  %11 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard", %"class.c10::impl::InlineDeviceGuard"* %4, i32 0, i32 0
  call void @_ZN3c104cuda4impl13CUDAGuardImplD2Ev(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %11) #3
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda4impl13CUDAGuardImpl18uncheckedSetDeviceENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i16 %1) unnamed_addr #8 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"struct.c10::Device", align 1
  %4 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca %"class.c10::Warning", align 8
  %8 = alloca %"class.std::variant", align 1
  %9 = alloca %"class.std::ios_base::Init", align 1
  %10 = alloca %"struct.c10::SourceLocation", align 8
  %11 = alloca %"class.std::__cxx11::basic_string", align 8
  %12 = alloca i8*, align 8
  %13 = alloca i8*, align 8
  %14 = alloca i32, align 4
  %15 = bitcast %"struct.c10::Device"* %3 to i16*
  store i16 %1, i16* %15, align 1
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  %16 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  br label %17

17:                                               ; preds = %2
  %18 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %3) #3
  %19 = invoke i32 @_ZN3c104cuda14MaybeSetDeviceEa(i8 signext %18)
          to label %20 unwind label %55

20:                                               ; preds = %17
  store i32 %19, i32* %5, align 4
  %21 = load i32, i32* %5, align 4
  %22 = icmp ne i32 %21, 0
  br i1 %22, label %23, label %52

23:                                               ; preds = %20
  %24 = invoke i32 @cudaGetLastError()
          to label %25 unwind label %55

25:                                               ; preds = %23
  store i32 %24, i32* %6, align 4
  call void @_ZNSt7variantIJN3c107Warning11UserWarningENS1_18DeprecationWarningEEEC2IS2_vvS2_vEEOT_(%"class.std::variant"* nonnull align 1 dereferenceable(2) %8, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %9) #3
  %26 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %10, i32 0, i32 0
  store i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl18uncheckedSetDeviceENS_6DeviceE, i64 0, i64 0), i8** %26, align 8
  %27 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %10, i32 0, i32 1
  store i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8** %27, align 8
  %28 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %10, i32 0, i32 2
  store i32 57, i32* %28, align 8
  %29 = load i32, i32* %5, align 4
  %30 = invoke i8* @cudaGetErrorString(i32 %29)
          to label %31 unwind label %55

31:                                               ; preds = %25
  store i8* %30, i8** %12, align 8
  invoke void @_ZN3c103strIJA15_cPKcEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %11, [15 x i8]* nonnull align 1 dereferenceable(15) @.str.7, i8** nonnull align 8 dereferenceable(8) %12)
          to label %32 unwind label %55

32:                                               ; preds = %31
  %33 = getelementptr inbounds %"class.std::variant", %"class.std::variant"* %8, i32 0, i32 0
  %34 = getelementptr inbounds %"struct.std::__detail::__variant::_Variant_base", %"struct.std::__detail::__variant::_Variant_base"* %33, i32 0, i32 0
  %35 = getelementptr inbounds %"struct.std::__detail::__variant::_Move_assign_base", %"struct.std::__detail::__variant::_Move_assign_base"* %34, i32 0, i32 0
  %36 = getelementptr inbounds %"struct.std::__detail::__variant::_Copy_assign_base", %"struct.std::__detail::__variant::_Copy_assign_base"* %35, i32 0, i32 0
  %37 = getelementptr inbounds %"struct.std::__detail::__variant::_Move_ctor_base", %"struct.std::__detail::__variant::_Move_ctor_base"* %36, i32 0, i32 0
  %38 = getelementptr inbounds %"struct.std::__detail::__variant::_Copy_ctor_base", %"struct.std::__detail::__variant::_Copy_ctor_base"* %37, i32 0, i32 0
  %39 = bitcast %"struct.std::__detail::__variant::_Variant_storage"* %38 to i16*
  %40 = load i16, i16* %39, align 1
  invoke void @_ZN3c107WarningC1ESt7variantIJNS0_11UserWarningENS0_18DeprecationWarningEEERKNS_14SourceLocationENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEb(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %7, i16 %40, %"struct.c10::SourceLocation"* nonnull align 8 dereferenceable(24) %10, %"class.std::__cxx11::basic_string"* %11, i1 zeroext false)
          to label %41 unwind label %43

41:                                               ; preds = %32
  invoke void @_ZN3c104warnERKNS_7WarningE(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %7)
          to label %42 unwind label %47

42:                                               ; preds = %41
  call void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %7) #3
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %11) #3
  br label %52

43:                                               ; preds = %32
  %44 = landingpad { i8*, i32 }
          catch i8* null
  %45 = extractvalue { i8*, i32 } %44, 0
  store i8* %45, i8** %13, align 8
  %46 = extractvalue { i8*, i32 } %44, 1
  store i32 %46, i32* %14, align 4
  br label %51

47:                                               ; preds = %41
  %48 = landingpad { i8*, i32 }
          catch i8* null
  %49 = extractvalue { i8*, i32 } %48, 0
  store i8* %49, i8** %13, align 8
  %50 = extractvalue { i8*, i32 } %48, 1
  store i32 %50, i32* %14, align 4
  call void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %7) #3
  br label %51

51:                                               ; preds = %47, %43
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %11) #3
  br label %58

52:                                               ; preds = %42, %20
  br label %53

53:                                               ; preds = %52
  br label %54

54:                                               ; preds = %53
  ret void

55:                                               ; preds = %31, %25, %23, %17
  %56 = landingpad { i8*, i32 }
          catch i8* null
  %57 = extractvalue { i8*, i32 } %56, 0
  call void @__clang_call_terminate(i8* %57) #26
  unreachable

58:                                               ; preds = %51
  %59 = load i8*, i8** %13, align 8
  call void @__clang_call_terminate(i8* %59) #26
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104cuda4impl13CUDAGuardImplD2Ev(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %3 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %4 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %3 to %"struct.c10::Allocator"*
  call void @_ZN3c104impl24DeviceGuardImplInterfaceD2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl24DeviceGuardImplInterfaceD2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.c10::Allocator"*, align 8
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %2, align 8
  %3 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %2, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %0) #8 comdat align 2 {
  %2 = alloca %"struct.c10::Device"*, align 8
  store %"struct.c10::Device"* %0, %"struct.c10::Device"** %2, align 8
  %3 = load %"struct.c10::Device"*, %"struct.c10::Device"** %2, align 8
  %4 = getelementptr inbounds %"struct.c10::Device", %"struct.c10::Device"* %3, i32 0, i32 1
  %5 = load i8, i8* %4, align 1
  ret i8 %5
}

declare dso_local i32 @_ZN3c104cuda14MaybeSetDeviceEa(i8 signext) #1

declare dso_local i32 @cudaGetLastError() #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt7variantIJN3c107Warning11UserWarningENS1_18DeprecationWarningEEEC2IS2_vvS2_vEEOT_(%"class.std::variant"* nonnull align 1 dereferenceable(2) %0, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) unnamed_addr #5 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.std::variant"*, align 8
  %4 = alloca %"class.std::ios_base::Init"*, align 8
  %5 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::variant"* %0, %"class.std::variant"** %3, align 8
  store %"class.std::ios_base::Init"* %1, %"class.std::ios_base::Init"** %4, align 8
  %6 = load %"class.std::variant"*, %"class.std::variant"** %3, align 8
  %7 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %4, align 8
  %8 = call nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZSt7forwardIN3c107Warning11UserWarningEEOT_RNSt16remove_referenceIS3_E4typeE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %7) #3
  invoke void @_ZNSt7variantIJN3c107Warning11UserWarningENS1_18DeprecationWarningEEEC2ILm0EJS2_ES2_vEESt16in_place_index_tIXT_EEDpOT0_(%"class.std::variant"* nonnull align 1 dereferenceable(2) %6, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %8)
          to label %9 unwind label %10

9:                                                ; preds = %2
  ret void

10:                                               ; preds = %2
  %11 = landingpad { i8*, i32 }
          catch i8* null
  %12 = extractvalue { i8*, i32 } %11, 0
  call void @__clang_call_terminate(i8* %12) #26
  unreachable
}

declare dso_local i8* @cudaGetErrorString(i32) #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c103strIJA15_cPKcEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, [15 x i8]* nonnull align 1 dereferenceable(15) %1, i8** nonnull align 8 dereferenceable(8) %2) #4 comdat {
  %4 = alloca i8*, align 8
  %5 = alloca [15 x i8]*, align 8
  %6 = alloca i8**, align 8
  %7 = alloca i8*, align 8
  %8 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %8, i8** %4, align 8
  store [15 x i8]* %1, [15 x i8]** %5, align 8
  store i8** %2, i8*** %6, align 8
  %9 = load [15 x i8]*, [15 x i8]** %5, align 8
  %10 = getelementptr inbounds [15 x i8], [15 x i8]* %9, i64 0, i64 0
  store i8* %10, i8** %7, align 8
  %11 = load i8**, i8*** %6, align 8
  call void @_ZN3c106detail12_str_wrapperIJPKcRKS3_EE4callB5cxx11ES5_S5_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, i8** nonnull align 8 dereferenceable(8) %7, i8** nonnull align 8 dereferenceable(8) %11)
  ret void
}

declare dso_local void @_ZN3c107WarningC1ESt7variantIJNS0_11UserWarningENS0_18DeprecationWarningEEERKNS_14SourceLocationENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEb(%"class.c10::Warning"* nonnull align 8 dereferenceable(65), i16, %"struct.c10::SourceLocation"* nonnull align 8 dereferenceable(24), %"class.std::__cxx11::basic_string"*, i1 zeroext) unnamed_addr #1

declare dso_local void @_ZN3c104warnERKNS_7WarningE(%"class.c10::Warning"* nonnull align 8 dereferenceable(65)) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.c10::Warning"*, align 8
  store %"class.c10::Warning"* %0, %"class.c10::Warning"** %2, align 8
  %3 = load %"class.c10::Warning"*, %"class.c10::Warning"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::Warning", %"class.c10::Warning"* %3, i32 0, i32 3
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %4) #3
  ret void
}

; Function Attrs: nounwind
declare dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32)) unnamed_addr #2

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8* %0) #9 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #3
  call void @_ZSt9terminatev() #26
  unreachable
}

declare dso_local i8* @__cxa_begin_catch(i8*)

declare dso_local void @_ZSt9terminatev()

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail12_str_wrapperIJPKcRKS3_EE4callB5cxx11ES5_S5_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, i8** nonnull align 8 dereferenceable(8) %1, i8** nonnull align 8 dereferenceable(8) %2) #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %4 = alloca i8*, align 8
  %5 = alloca i8**, align 8
  %6 = alloca i8**, align 8
  %7 = alloca %"class.std::__cxx11::basic_ostringstream", align 8
  %8 = alloca i8*, align 8
  %9 = alloca i32, align 4
  %10 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %10, i8** %4, align 8
  store i8** %1, i8*** %5, align 8
  store i8** %2, i8*** %6, align 8
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %7)
  %11 = bitcast %"class.std::__cxx11::basic_ostringstream"* %7 to %"class.std::basic_ostream"*
  %12 = load i8**, i8*** %5, align 8
  %13 = load i8**, i8*** %6, align 8
  %14 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJS3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %11, i8** nonnull align 8 dereferenceable(8) %12, i8** nonnull align 8 dereferenceable(8) %13)
          to label %15 unwind label %17

15:                                               ; preds = %3
  invoke void @_ZNKSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEE3strEv(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, %"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %7)
          to label %16 unwind label %17

16:                                               ; preds = %15
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %7) #3
  ret void

17:                                               ; preds = %15, %3
  %18 = landingpad { i8*, i32 }
          cleanup
  %19 = extractvalue { i8*, i32 } %18, 0
  store i8* %19, i8** %8, align 8
  %20 = extractvalue { i8*, i32 } %18, 1
  store i32 %20, i32* %9, align 4
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %7) #3
  br label %21

21:                                               ; preds = %17
  %22 = load i8*, i8** %8, align 8
  %23 = load i32, i32* %9, align 4
  %24 = insertvalue { i8*, i32 } undef, i8* %22, 0
  %25 = insertvalue { i8*, i32 } %24, i32 %23, 1
  resume { i8*, i32 } %25
}

declare dso_local void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112)) unnamed_addr #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJS3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8** nonnull align 8 dereferenceable(8) %1, i8** nonnull align 8 dereferenceable(8) %2) #4 comdat {
  %4 = alloca %"class.std::basic_ostream"*, align 8
  %5 = alloca i8**, align 8
  %6 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %4, align 8
  store i8** %1, i8*** %5, align 8
  store i8** %2, i8*** %6, align 8
  %7 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %4, align 8
  %8 = load i8**, i8*** %5, align 8
  %9 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %7, i8** nonnull align 8 dereferenceable(8) %8)
  %10 = load i8**, i8*** %6, align 8
  %11 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %9, i8** nonnull align 8 dereferenceable(8) %10)
  ret %"class.std::basic_ostream"* %11
}

declare dso_local void @_ZNKSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEE3strEv(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8, %"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112)) #1

; Function Attrs: nounwind
declare dso_local void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112)) unnamed_addr #2

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8** nonnull align 8 dereferenceable(8) %1) #4 comdat {
  %3 = alloca %"class.std::basic_ostream"*, align 8
  %4 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %3, align 8
  store i8** %1, i8*** %4, align 8
  %5 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %3, align 8
  %6 = load i8**, i8*** %4, align 8
  %7 = load i8*, i8** %6, align 8
  %8 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %5, i8* %7)
  %9 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %3, align 8
  ret %"class.std::basic_ostream"* %9
}

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8*) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZSt7forwardIN3c107Warning11UserWarningEEOT_RNSt16remove_referenceIS3_E4typeE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #8 comdat {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  ret %"class.std::ios_base::Init"* %3
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt7variantIJN3c107Warning11UserWarningENS1_18DeprecationWarningEEEC2ILm0EJS2_ES2_vEESt16in_place_index_tIXT_EEDpOT0_(%"class.std::variant"* nonnull align 1 dereferenceable(2) %0, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"class.std::variant"*, align 8
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  %6 = alloca %"class.std::ios_base::Init", align 1
  %7 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::variant"* %0, %"class.std::variant"** %4, align 8
  store %"class.std::ios_base::Init"* %1, %"class.std::ios_base::Init"** %5, align 8
  %8 = load %"class.std::variant"*, %"class.std::variant"** %4, align 8
  %9 = bitcast %"class.std::variant"* %8 to %"struct.std::__detail::__variant::_Variant_base"*
  %10 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  %11 = call nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZSt7forwardIN3c107Warning11UserWarningEEOT_RNSt16remove_referenceIS3_E4typeE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %10) #3
  call void @_ZNSt8__detail9__variant13_Variant_baseIJN3c107Warning11UserWarningENS3_18DeprecationWarningEEEC2ILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Variant_base"* nonnull align 1 dereferenceable(2) %9, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %11)
  %12 = bitcast %"class.std::variant"* %8 to %"class.std::ios_base::Init"*
  call void @_ZNSt27_Enable_default_constructorILb1ESt7variantIJN3c107Warning11UserWarningENS2_18DeprecationWarningEEEEC2ESt31_Enable_default_constructor_tag(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %12)
  %13 = bitcast %"class.std::variant"* %8 to %"class.std::ios_base::Init"*
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt8__detail9__variant13_Variant_baseIJN3c107Warning11UserWarningENS3_18DeprecationWarningEEEC2ILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Variant_base"* nonnull align 1 dereferenceable(2) %0, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"struct.std::__detail::__variant::_Variant_base"*, align 8
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  %6 = alloca %"class.std::ios_base::Init", align 1
  store %"struct.std::__detail::__variant::_Variant_base"* %0, %"struct.std::__detail::__variant::_Variant_base"** %4, align 8
  store %"class.std::ios_base::Init"* %1, %"class.std::ios_base::Init"** %5, align 8
  %7 = load %"struct.std::__detail::__variant::_Variant_base"*, %"struct.std::__detail::__variant::_Variant_base"** %4, align 8
  %8 = bitcast %"struct.std::__detail::__variant::_Variant_base"* %7 to %"struct.std::__detail::__variant::_Move_assign_base"*
  %9 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  %10 = call nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZSt7forwardIN3c107Warning11UserWarningEEOT_RNSt16remove_referenceIS3_E4typeE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %9) #3
  call void @_ZNSt8__detail9__variant17_Move_assign_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Move_assign_base"* nonnull align 1 dereferenceable(2) %8, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %10)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt27_Enable_default_constructorILb1ESt7variantIJN3c107Warning11UserWarningENS2_18DeprecationWarningEEEEC2ESt31_Enable_default_constructor_tag(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init", align 1
  %3 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %3, align 8
  %4 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %3, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt8__detail9__variant17_Move_assign_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Move_assign_base"* nonnull align 1 dereferenceable(2) %0, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"struct.std::__detail::__variant::_Move_assign_base"*, align 8
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  store %"struct.std::__detail::__variant::_Move_assign_base"* %0, %"struct.std::__detail::__variant::_Move_assign_base"** %4, align 8
  store %"class.std::ios_base::Init"* %1, %"class.std::ios_base::Init"** %5, align 8
  %6 = load %"struct.std::__detail::__variant::_Move_assign_base"*, %"struct.std::__detail::__variant::_Move_assign_base"** %4, align 8
  %7 = bitcast %"struct.std::__detail::__variant::_Move_assign_base"* %6 to %"struct.std::__detail::__variant::_Copy_assign_base"*
  %8 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  call void @_ZNSt8__detail9__variant17_Copy_assign_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Copy_assign_base"* nonnull align 1 dereferenceable(2) %7, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %8)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt8__detail9__variant17_Copy_assign_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Copy_assign_base"* nonnull align 1 dereferenceable(2) %0, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"struct.std::__detail::__variant::_Copy_assign_base"*, align 8
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  store %"struct.std::__detail::__variant::_Copy_assign_base"* %0, %"struct.std::__detail::__variant::_Copy_assign_base"** %4, align 8
  store %"class.std::ios_base::Init"* %1, %"class.std::ios_base::Init"** %5, align 8
  %6 = load %"struct.std::__detail::__variant::_Copy_assign_base"*, %"struct.std::__detail::__variant::_Copy_assign_base"** %4, align 8
  %7 = bitcast %"struct.std::__detail::__variant::_Copy_assign_base"* %6 to %"struct.std::__detail::__variant::_Move_ctor_base"*
  %8 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  call void @_ZNSt8__detail9__variant15_Move_ctor_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Move_ctor_base"* nonnull align 1 dereferenceable(2) %7, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %8)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt8__detail9__variant15_Move_ctor_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Move_ctor_base"* nonnull align 1 dereferenceable(2) %0, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"struct.std::__detail::__variant::_Move_ctor_base"*, align 8
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  store %"struct.std::__detail::__variant::_Move_ctor_base"* %0, %"struct.std::__detail::__variant::_Move_ctor_base"** %4, align 8
  store %"class.std::ios_base::Init"* %1, %"class.std::ios_base::Init"** %5, align 8
  %6 = load %"struct.std::__detail::__variant::_Move_ctor_base"*, %"struct.std::__detail::__variant::_Move_ctor_base"** %4, align 8
  %7 = bitcast %"struct.std::__detail::__variant::_Move_ctor_base"* %6 to %"struct.std::__detail::__variant::_Copy_ctor_base"*
  %8 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  call void @_ZNSt8__detail9__variant15_Copy_ctor_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Copy_ctor_base"* nonnull align 1 dereferenceable(2) %7, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %8)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt8__detail9__variant15_Copy_ctor_baseILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEECI2NS0_16_Variant_storageILb1EJS4_S5_EEEILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Copy_ctor_base"* nonnull align 1 dereferenceable(2) %0, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"struct.std::__detail::__variant::_Copy_ctor_base"*, align 8
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  store %"struct.std::__detail::__variant::_Copy_ctor_base"* %0, %"struct.std::__detail::__variant::_Copy_ctor_base"** %4, align 8
  store %"class.std::ios_base::Init"* %1, %"class.std::ios_base::Init"** %5, align 8
  %6 = load %"struct.std::__detail::__variant::_Copy_ctor_base"*, %"struct.std::__detail::__variant::_Copy_ctor_base"** %4, align 8
  %7 = bitcast %"struct.std::__detail::__variant::_Copy_ctor_base"* %6 to %"struct.std::__detail::__variant::_Variant_storage"*
  %8 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  call void @_ZNSt8__detail9__variant16_Variant_storageILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEEC2ILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Variant_storage"* nonnull align 1 dereferenceable(2) %7, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %8)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt8__detail9__variant16_Variant_storageILb1EJN3c107Warning11UserWarningENS3_18DeprecationWarningEEEC2ILm0EJS4_EEESt16in_place_index_tIXT_EEDpOT0_(%"struct.std::__detail::__variant::_Variant_storage"* nonnull align 1 dereferenceable(2) %0, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"struct.std::__detail::__variant::_Variant_storage"*, align 8
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  %6 = alloca %"class.std::ios_base::Init", align 1
  store %"struct.std::__detail::__variant::_Variant_storage"* %0, %"struct.std::__detail::__variant::_Variant_storage"** %4, align 8
  store %"class.std::ios_base::Init"* %1, %"class.std::ios_base::Init"** %5, align 8
  %7 = load %"struct.std::__detail::__variant::_Variant_storage"*, %"struct.std::__detail::__variant::_Variant_storage"** %4, align 8
  %8 = getelementptr inbounds %"struct.std::__detail::__variant::_Variant_storage", %"struct.std::__detail::__variant::_Variant_storage"* %7, i32 0, i32 0
  %9 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  %10 = call nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZSt7forwardIN3c107Warning11UserWarningEEOT_RNSt16remove_referenceIS3_E4typeE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %9) #3
  call void @_ZNSt8__detail9__variant15_Variadic_unionIJN3c107Warning11UserWarningENS3_18DeprecationWarningEEEC2IJS4_EEESt16in_place_index_tILm0EEDpOT_(%"union.std::__detail::__variant::_Variadic_union"* nonnull align 1 dereferenceable(1) %8, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %10)
  %11 = getelementptr inbounds %"struct.std::__detail::__variant::_Variant_storage", %"struct.std::__detail::__variant::_Variant_storage"* %7, i32 0, i32 1
  store i8 0, i8* %11, align 1
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt8__detail9__variant15_Variadic_unionIJN3c107Warning11UserWarningENS3_18DeprecationWarningEEEC2IJS4_EEESt16in_place_index_tILm0EEDpOT_(%"union.std::__detail::__variant::_Variadic_union"* nonnull align 1 dereferenceable(1) %0, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"union.std::__detail::__variant::_Variadic_union"*, align 8
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  %6 = alloca %"class.std::ios_base::Init", align 1
  store %"union.std::__detail::__variant::_Variadic_union"* %0, %"union.std::__detail::__variant::_Variadic_union"** %4, align 8
  store %"class.std::ios_base::Init"* %1, %"class.std::ios_base::Init"** %5, align 8
  %7 = load %"union.std::__detail::__variant::_Variadic_union"*, %"union.std::__detail::__variant::_Variadic_union"** %4, align 8
  %8 = bitcast %"union.std::__detail::__variant::_Variadic_union"* %7 to %"struct.std::__detail::__variant::_Uninitialized"*
  %9 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  %10 = call nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZSt7forwardIN3c107Warning11UserWarningEEOT_RNSt16remove_referenceIS3_E4typeE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %9) #3
  call void @_ZNSt8__detail9__variant14_UninitializedIN3c107Warning11UserWarningELb1EEC2IJS4_EEESt16in_place_index_tILm0EEDpOT_(%"struct.std::__detail::__variant::_Uninitialized"* nonnull align 1 dereferenceable(1) %8, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %10)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt8__detail9__variant14_UninitializedIN3c107Warning11UserWarningELb1EEC2IJS4_EEESt16in_place_index_tILm0EEDpOT_(%"struct.std::__detail::__variant::_Uninitialized"* nonnull align 1 dereferenceable(1) %0, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) unnamed_addr #5 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"struct.std::__detail::__variant::_Uninitialized"*, align 8
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  store %"struct.std::__detail::__variant::_Uninitialized"* %0, %"struct.std::__detail::__variant::_Uninitialized"** %4, align 8
  store %"class.std::ios_base::Init"* %1, %"class.std::ios_base::Init"** %5, align 8
  %6 = load %"struct.std::__detail::__variant::_Uninitialized"*, %"struct.std::__detail::__variant::_Uninitialized"** %4, align 8
  %7 = getelementptr inbounds %"struct.std::__detail::__variant::_Uninitialized", %"struct.std::__detail::__variant::_Uninitialized"* %6, i32 0, i32 0
  %8 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  %9 = call nonnull align 1 dereferenceable(1) %"class.std::ios_base::Init"* @_ZSt7forwardIN3c107Warning11UserWarningEEOT_RNSt16remove_referenceIS3_E4typeE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %8) #3
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local signext i8 @_ZNK2at10TensorBase11scalar_typeEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0) #4 comdat align 2 {
  %2 = alloca %"class.at::TensorBase"*, align 8
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %2, align 8
  %4 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %2, align 8
  %5 = getelementptr inbounds %"class.at::TensorBase", %"class.at::TensorBase"* %4, i32 0, i32 0
  %6 = call %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %5) #3
  %7 = call i16 @_ZNK3c1010TensorImpl5dtypeEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6)
  %8 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %3, i32 0, i32 0
  store i16 %7, i16* %8, align 2
  %9 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %3, i32 0, i32 0
  %10 = load i16, i16* %9, align 2
  %11 = call signext i8 @_ZN3c1020typeMetaToScalarTypeEN6caffe28TypeMetaE(i16 %10)
  ret i8 %11
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local signext i8 @_ZN6detail11scalar_typeEN3c1010ScalarTypeE(i8 signext %0) #8 comdat {
  %2 = alloca i8, align 1
  store i8 %0, i8* %2, align 1
  %3 = load i8, i8* %2, align 1
  ret i8 %3
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEvENKUlvE_clEv(%class.anon.93* nonnull align 8 dereferenceable(56) %0) #4 align 2 {
  %2 = alloca %class.anon.93*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  store %class.anon.93* %0, %class.anon.93** %2, align 8
  %7 = load %class.anon.93*, %class.anon.93** %2, align 8
  %8 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 0
  %9 = load %struct.dim3*, %struct.dim3** %8, align 8
  %10 = bitcast %struct.dim3* %3 to i8*
  %11 = bitcast %struct.dim3* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %10, i8* align 4 %11, i64 12, i1 false)
  %12 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 1
  %13 = load %struct.dim3*, %struct.dim3** %12, align 8
  %14 = bitcast %struct.dim3* %4 to i8*
  %15 = bitcast %struct.dim3* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %14, i8* align 4 %15, i64 12, i1 false)
  %16 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 2
  %17 = load %struct.CUstream_st**, %struct.CUstream_st*** %16, align 8
  %18 = load %struct.CUstream_st*, %struct.CUstream_st** %17, align 8
  %19 = bitcast %struct.CUstream_st* %18 to i8*
  %20 = bitcast { i64, i32 }* %5 to i8*
  %21 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %20, i8* align 4 %21, i64 12, i1 false)
  %22 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %23 = load i64, i64* %22, align 4
  %24 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = bitcast { i64, i32 }* %6 to i8*
  %27 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %26, i8* align 4 %27, i64 12, i1 false)
  %28 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %29 = load i64, i64* %28, align 4
  %30 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = call i32 @__cudaPushCallConfiguration(i64 %23, i32 %25, i64 %29, i32 %31, i64 0, i8* %19)
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %50, label %34

34:                                               ; preds = %1
  %35 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 3
  %36 = load %"class.at::Tensor"*, %"class.at::Tensor"** %35, align 8
  %37 = bitcast %"class.at::Tensor"* %36 to %"class.at::TensorBase"*
  %38 = call %"class.std::ios_base::Init"* @_ZNK2at10TensorBase8data_ptrIN3c1013Float8_e4m3fnEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %37)
  %39 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 4
  %40 = load %"class.at::Tensor"*, %"class.at::Tensor"** %39, align 8
  %41 = bitcast %"class.at::Tensor"* %40 to %"class.at::TensorBase"*
  %42 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %41)
  %43 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 5
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  %45 = bitcast %"class.at::Tensor"* %44 to %"class.at::TensorBase"*
  %46 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %45)
  %47 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 6
  %48 = load i64*, i64** %47, align 8
  %49 = load i64, i64* %48, align 8
  call void @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* %38, float* %42, float* %46, i64 %49)
  br label %50

50:                                               ; preds = %34, %1
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEvENKUlvE0_clEv(%class.anon.93* nonnull align 8 dereferenceable(56) %0) #4 align 2 {
  %2 = alloca %class.anon.93*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  store %class.anon.93* %0, %class.anon.93** %2, align 8
  %7 = load %class.anon.93*, %class.anon.93** %2, align 8
  %8 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 0
  %9 = load %struct.dim3*, %struct.dim3** %8, align 8
  %10 = bitcast %struct.dim3* %3 to i8*
  %11 = bitcast %struct.dim3* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %10, i8* align 4 %11, i64 12, i1 false)
  %12 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 1
  %13 = load %struct.dim3*, %struct.dim3** %12, align 8
  %14 = bitcast %struct.dim3* %4 to i8*
  %15 = bitcast %struct.dim3* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %14, i8* align 4 %15, i64 12, i1 false)
  %16 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 2
  %17 = load %struct.CUstream_st**, %struct.CUstream_st*** %16, align 8
  %18 = load %struct.CUstream_st*, %struct.CUstream_st** %17, align 8
  %19 = bitcast %struct.CUstream_st* %18 to i8*
  %20 = bitcast { i64, i32 }* %5 to i8*
  %21 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %20, i8* align 4 %21, i64 12, i1 false)
  %22 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %23 = load i64, i64* %22, align 4
  %24 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = bitcast { i64, i32 }* %6 to i8*
  %27 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %26, i8* align 4 %27, i64 12, i1 false)
  %28 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %29 = load i64, i64* %28, align 4
  %30 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = call i32 @__cudaPushCallConfiguration(i64 %23, i32 %25, i64 %29, i32 %31, i64 0, i8* %19)
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %50, label %34

34:                                               ; preds = %1
  %35 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 3
  %36 = load %"class.at::Tensor"*, %"class.at::Tensor"** %35, align 8
  %37 = bitcast %"class.at::Tensor"* %36 to %"class.at::TensorBase"*
  %38 = call %"class.std::ios_base::Init"* @_ZNK2at10TensorBase8data_ptrIN3c1013Float8_e4m3fnEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %37)
  %39 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 4
  %40 = load %"class.at::Tensor"*, %"class.at::Tensor"** %39, align 8
  %41 = bitcast %"class.at::Tensor"* %40 to %"class.at::TensorBase"*
  %42 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %41)
  %43 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 5
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  %45 = bitcast %"class.at::Tensor"* %44 to %"class.at::TensorBase"*
  %46 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %45)
  %47 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 6
  %48 = load i64*, i64** %47, align 8
  %49 = load i64, i64* %48, align 8
  call void @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* %38, %"class.caffe2::TypeMeta"* %42, float* %46, i64 %49)
  br label %50

50:                                               ; preds = %34, %1
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEvENKUlvE1_clEv(%class.anon.93* nonnull align 8 dereferenceable(56) %0) #4 align 2 {
  %2 = alloca %class.anon.93*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  store %class.anon.93* %0, %class.anon.93** %2, align 8
  %7 = load %class.anon.93*, %class.anon.93** %2, align 8
  %8 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 0
  %9 = load %struct.dim3*, %struct.dim3** %8, align 8
  %10 = bitcast %struct.dim3* %3 to i8*
  %11 = bitcast %struct.dim3* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %10, i8* align 4 %11, i64 12, i1 false)
  %12 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 1
  %13 = load %struct.dim3*, %struct.dim3** %12, align 8
  %14 = bitcast %struct.dim3* %4 to i8*
  %15 = bitcast %struct.dim3* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %14, i8* align 4 %15, i64 12, i1 false)
  %16 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 2
  %17 = load %struct.CUstream_st**, %struct.CUstream_st*** %16, align 8
  %18 = load %struct.CUstream_st*, %struct.CUstream_st** %17, align 8
  %19 = bitcast %struct.CUstream_st* %18 to i8*
  %20 = bitcast { i64, i32 }* %5 to i8*
  %21 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %20, i8* align 4 %21, i64 12, i1 false)
  %22 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %23 = load i64, i64* %22, align 4
  %24 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = bitcast { i64, i32 }* %6 to i8*
  %27 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %26, i8* align 4 %27, i64 12, i1 false)
  %28 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %29 = load i64, i64* %28, align 4
  %30 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = call i32 @__cudaPushCallConfiguration(i64 %23, i32 %25, i64 %29, i32 %31, i64 0, i8* %19)
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %50, label %34

34:                                               ; preds = %1
  %35 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 3
  %36 = load %"class.at::Tensor"*, %"class.at::Tensor"** %35, align 8
  %37 = bitcast %"class.at::Tensor"* %36 to %"class.at::TensorBase"*
  %38 = call %"class.std::ios_base::Init"* @_ZNK2at10TensorBase8data_ptrIN3c1013Float8_e4m3fnEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %37)
  %39 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 4
  %40 = load %"class.at::Tensor"*, %"class.at::Tensor"** %39, align 8
  %41 = bitcast %"class.at::Tensor"* %40 to %"class.at::TensorBase"*
  %42 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %41)
  %43 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 5
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  %45 = bitcast %"class.at::Tensor"* %44 to %"class.at::TensorBase"*
  %46 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %45)
  %47 = getelementptr inbounds %class.anon.93, %class.anon.93* %7, i32 0, i32 6
  %48 = load i64*, i64** %47, align 8
  %49 = load i64, i64* %48, align 8
  call void @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* %38, %"class.caffe2::TypeMeta"* %42, float* %46, i64 %49)
  br label %50

50:                                               ; preds = %34, %1
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i8* @_ZN3c108toStringENS_10ScalarTypeE(i8 signext %0) #8 comdat {
  %2 = alloca i8*, align 8
  %3 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  %4 = load i8, i8* %3, align 1
  switch i8 %4, label %50 [
    i8 0, label %5
    i8 1, label %6
    i8 2, label %7
    i8 3, label %8
    i8 4, label %9
    i8 5, label %10
    i8 6, label %11
    i8 7, label %12
    i8 8, label %13
    i8 9, label %14
    i8 10, label %15
    i8 11, label %16
    i8 12, label %17
    i8 13, label %18
    i8 14, label %19
    i8 15, label %20
    i8 16, label %21
    i8 17, label %22
    i8 18, label %23
    i8 19, label %24
    i8 20, label %25
    i8 21, label %26
    i8 22, label %27
    i8 23, label %28
    i8 24, label %29
    i8 25, label %30
    i8 26, label %31
    i8 27, label %32
    i8 28, label %33
    i8 29, label %34
    i8 30, label %35
    i8 31, label %36
    i8 32, label %37
    i8 33, label %38
    i8 34, label %39
    i8 35, label %40
    i8 36, label %41
    i8 37, label %42
    i8 38, label %43
    i8 39, label %44
    i8 40, label %45
    i8 41, label %46
    i8 42, label %47
    i8 43, label %48
    i8 44, label %49
  ]

5:                                                ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.44, i64 0, i64 0), i8** %2, align 8
  br label %51

6:                                                ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.45, i64 0, i64 0), i8** %2, align 8
  br label %51

7:                                                ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.46, i64 0, i64 0), i8** %2, align 8
  br label %51

8:                                                ; preds = %1
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.47, i64 0, i64 0), i8** %2, align 8
  br label %51

9:                                                ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.48, i64 0, i64 0), i8** %2, align 8
  br label %51

10:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.49, i64 0, i64 0), i8** %2, align 8
  br label %51

11:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.50, i64 0, i64 0), i8** %2, align 8
  br label %51

12:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.51, i64 0, i64 0), i8** %2, align 8
  br label %51

13:                                               ; preds = %1
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.52, i64 0, i64 0), i8** %2, align 8
  br label %51

14:                                               ; preds = %1
  store i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.53, i64 0, i64 0), i8** %2, align 8
  br label %51

15:                                               ; preds = %1
  store i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.54, i64 0, i64 0), i8** %2, align 8
  br label %51

16:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.55, i64 0, i64 0), i8** %2, align 8
  br label %51

17:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.56, i64 0, i64 0), i8** %2, align 8
  br label %51

18:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.57, i64 0, i64 0), i8** %2, align 8
  br label %51

19:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.58, i64 0, i64 0), i8** %2, align 8
  br label %51

20:                                               ; preds = %1
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.59, i64 0, i64 0), i8** %2, align 8
  br label %51

21:                                               ; preds = %1
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.60, i64 0, i64 0), i8** %2, align 8
  br label %51

22:                                               ; preds = %1
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.61, i64 0, i64 0), i8** %2, align 8
  br label %51

23:                                               ; preds = %1
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.62, i64 0, i64 0), i8** %2, align 8
  br label %51

24:                                               ; preds = %1
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.63, i64 0, i64 0), i8** %2, align 8
  br label %51

25:                                               ; preds = %1
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.64, i64 0, i64 0), i8** %2, align 8
  br label %51

26:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.65, i64 0, i64 0), i8** %2, align 8
  br label %51

27:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.66, i64 0, i64 0), i8** %2, align 8
  br label %51

28:                                               ; preds = %1
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.67, i64 0, i64 0), i8** %2, align 8
  br label %51

29:                                               ; preds = %1
  store i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.68, i64 0, i64 0), i8** %2, align 8
  br label %51

30:                                               ; preds = %1
  store i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.69, i64 0, i64 0), i8** %2, align 8
  br label %51

31:                                               ; preds = %1
  store i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.70, i64 0, i64 0), i8** %2, align 8
  br label %51

32:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.71, i64 0, i64 0), i8** %2, align 8
  br label %51

33:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.72, i64 0, i64 0), i8** %2, align 8
  br label %51

34:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.73, i64 0, i64 0), i8** %2, align 8
  br label %51

35:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.74, i64 0, i64 0), i8** %2, align 8
  br label %51

36:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.75, i64 0, i64 0), i8** %2, align 8
  br label %51

37:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.76, i64 0, i64 0), i8** %2, align 8
  br label %51

38:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.77, i64 0, i64 0), i8** %2, align 8
  br label %51

39:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.78, i64 0, i64 0), i8** %2, align 8
  br label %51

40:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.79, i64 0, i64 0), i8** %2, align 8
  br label %51

41:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.80, i64 0, i64 0), i8** %2, align 8
  br label %51

42:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.81, i64 0, i64 0), i8** %2, align 8
  br label %51

43:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.82, i64 0, i64 0), i8** %2, align 8
  br label %51

44:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.83, i64 0, i64 0), i8** %2, align 8
  br label %51

45:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.84, i64 0, i64 0), i8** %2, align 8
  br label %51

46:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.85, i64 0, i64 0), i8** %2, align 8
  br label %51

47:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.86, i64 0, i64 0), i8** %2, align 8
  br label %51

48:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.87, i64 0, i64 0), i8** %2, align 8
  br label %51

49:                                               ; preds = %1
  store i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.88, i64 0, i64 0), i8** %2, align 8
  br label %51

50:                                               ; preds = %1
  store i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.89, i64 0, i64 0), i8** %2, align 8
  br label %51

51:                                               ; preds = %50, %49, %48, %47, %46, %45, %44, %43, %42, %41, %40, %39, %38, %37, %36, %35, %34, %33, %32, %31, %30, %29, %28, %27, %26, %25, %24, %23, %22, %21, %20, %19, %18, %17, %16, %15, %14, %13, %12, %11, %10, %9, %8, %7, %6, %5
  %52 = load i8*, i8** %2, align 8
  ret i8* %52
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail17torchCheckMsgImplIJcPKcA24_cS3_A2_cEEEDcS3_DpRKT_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, i8* %1, i8* nonnull align 1 dereferenceable(1) %2, i8** nonnull align 8 dereferenceable(8) %3, [24 x i8]* nonnull align 1 dereferenceable(24) %4, i8** nonnull align 8 dereferenceable(8) %5, [2 x i8]* nonnull align 1 dereferenceable(2) %6) #4 comdat {
  %8 = alloca i8*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i8*, align 8
  %11 = alloca i8**, align 8
  %12 = alloca [24 x i8]*, align 8
  %13 = alloca i8**, align 8
  %14 = alloca [2 x i8]*, align 8
  %15 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %15, i8** %8, align 8
  store i8* %1, i8** %9, align 8
  store i8* %2, i8** %10, align 8
  store i8** %3, i8*** %11, align 8
  store [24 x i8]* %4, [24 x i8]** %12, align 8
  store i8** %5, i8*** %13, align 8
  store [2 x i8]* %6, [2 x i8]** %14, align 8
  %16 = load i8*, i8** %10, align 8
  %17 = load i8**, i8*** %11, align 8
  %18 = load [24 x i8]*, [24 x i8]** %12, align 8
  %19 = load i8**, i8*** %13, align 8
  %20 = load [2 x i8]*, [2 x i8]** %14, align 8
  call void @_ZN3c103strIJcPKcA24_cS2_A2_cEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, i8* nonnull align 1 dereferenceable(1) %16, i8** nonnull align 8 dereferenceable(8) %17, [24 x i8]* nonnull align 1 dereferenceable(24) %18, i8** nonnull align 8 dereferenceable(8) %19, [2 x i8]* nonnull align 1 dereferenceable(2) %20)
  ret void
}

; Function Attrs: noreturn
declare dso_local void @_ZN3c106detail14torchCheckFailEPKcS2_jRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8*, i8*, i32, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32)) #10

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c103strIJcPKcA24_cS2_A2_cEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, i8* nonnull align 1 dereferenceable(1) %1, i8** nonnull align 8 dereferenceable(8) %2, [24 x i8]* nonnull align 1 dereferenceable(24) %3, i8** nonnull align 8 dereferenceable(8) %4, [2 x i8]* nonnull align 1 dereferenceable(2) %5) #4 comdat {
  %7 = alloca i8*, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i8**, align 8
  %10 = alloca [24 x i8]*, align 8
  %11 = alloca i8**, align 8
  %12 = alloca [2 x i8]*, align 8
  %13 = alloca i8*, align 8
  %14 = alloca i8*, align 8
  %15 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %15, i8** %7, align 8
  store i8* %1, i8** %8, align 8
  store i8** %2, i8*** %9, align 8
  store [24 x i8]* %3, [24 x i8]** %10, align 8
  store i8** %4, i8*** %11, align 8
  store [2 x i8]* %5, [2 x i8]** %12, align 8
  %16 = load i8*, i8** %8, align 8
  %17 = load i8**, i8*** %9, align 8
  %18 = load [24 x i8]*, [24 x i8]** %10, align 8
  %19 = getelementptr inbounds [24 x i8], [24 x i8]* %18, i64 0, i64 0
  store i8* %19, i8** %13, align 8
  %20 = load i8**, i8*** %11, align 8
  %21 = load [2 x i8]*, [2 x i8]** %12, align 8
  %22 = getelementptr inbounds [2 x i8], [2 x i8]* %21, i64 0, i64 0
  store i8* %22, i8** %14, align 8
  call void @_ZN3c106detail12_str_wrapperIJRKcRKPS2_S4_S6_S4_EE4callB5cxx11ES3_S6_S6_S6_S6_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, i8* nonnull align 1 dereferenceable(1) %16, i8** nonnull align 8 dereferenceable(8) %17, i8** nonnull align 8 dereferenceable(8) %13, i8** nonnull align 8 dereferenceable(8) %20, i8** nonnull align 8 dereferenceable(8) %14)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail12_str_wrapperIJRKcRKPS2_S4_S6_S4_EE4callB5cxx11ES3_S6_S6_S6_S6_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, i8* nonnull align 1 dereferenceable(1) %1, i8** nonnull align 8 dereferenceable(8) %2, i8** nonnull align 8 dereferenceable(8) %3, i8** nonnull align 8 dereferenceable(8) %4, i8** nonnull align 8 dereferenceable(8) %5) #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %7 = alloca i8*, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i8**, align 8
  %10 = alloca i8**, align 8
  %11 = alloca i8**, align 8
  %12 = alloca i8**, align 8
  %13 = alloca %"class.std::__cxx11::basic_ostringstream", align 8
  %14 = alloca i8*, align 8
  %15 = alloca i32, align 4
  %16 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %16, i8** %7, align 8
  store i8* %1, i8** %8, align 8
  store i8** %2, i8*** %9, align 8
  store i8** %3, i8*** %10, align 8
  store i8** %4, i8*** %11, align 8
  store i8** %5, i8*** %12, align 8
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %13)
  %17 = bitcast %"class.std::__cxx11::basic_ostringstream"* %13 to %"class.std::basic_ostream"*
  %18 = load i8*, i8** %8, align 8
  %19 = load i8**, i8*** %9, align 8
  %20 = load i8**, i8*** %10, align 8
  %21 = load i8**, i8*** %11, align 8
  %22 = load i8**, i8*** %12, align 8
  %23 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIcJPKcS3_S3_S3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %17, i8* nonnull align 1 dereferenceable(1) %18, i8** nonnull align 8 dereferenceable(8) %19, i8** nonnull align 8 dereferenceable(8) %20, i8** nonnull align 8 dereferenceable(8) %21, i8** nonnull align 8 dereferenceable(8) %22)
          to label %24 unwind label %26

24:                                               ; preds = %6
  invoke void @_ZNKSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEE3strEv(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, %"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %13)
          to label %25 unwind label %26

25:                                               ; preds = %24
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %13) #3
  ret void

26:                                               ; preds = %24, %6
  %27 = landingpad { i8*, i32 }
          cleanup
  %28 = extractvalue { i8*, i32 } %27, 0
  store i8* %28, i8** %14, align 8
  %29 = extractvalue { i8*, i32 } %27, 1
  store i32 %29, i32* %15, align 4
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %13) #3
  br label %30

30:                                               ; preds = %26
  %31 = load i8*, i8** %14, align 8
  %32 = load i32, i32* %15, align 4
  %33 = insertvalue { i8*, i32 } undef, i8* %31, 0
  %34 = insertvalue { i8*, i32 } %33, i32 %32, 1
  resume { i8*, i32 } %34
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIcJPKcS3_S3_S3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8* nonnull align 1 dereferenceable(1) %1, i8** nonnull align 8 dereferenceable(8) %2, i8** nonnull align 8 dereferenceable(8) %3, i8** nonnull align 8 dereferenceable(8) %4, i8** nonnull align 8 dereferenceable(8) %5) #4 comdat {
  %7 = alloca %"class.std::basic_ostream"*, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i8**, align 8
  %10 = alloca i8**, align 8
  %11 = alloca i8**, align 8
  %12 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %7, align 8
  store i8* %1, i8** %8, align 8
  store i8** %2, i8*** %9, align 8
  store i8** %3, i8*** %10, align 8
  store i8** %4, i8*** %11, align 8
  store i8** %5, i8*** %12, align 8
  %13 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %7, align 8
  %14 = load i8*, i8** %8, align 8
  %15 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIcEERSoS2_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %13, i8* nonnull align 1 dereferenceable(1) %14)
  %16 = load i8**, i8*** %9, align 8
  %17 = load i8**, i8*** %10, align 8
  %18 = load i8**, i8*** %11, align 8
  %19 = load i8**, i8*** %12, align 8
  %20 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJS3_S3_S3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %15, i8** nonnull align 8 dereferenceable(8) %16, i8** nonnull align 8 dereferenceable(8) %17, i8** nonnull align 8 dereferenceable(8) %18, i8** nonnull align 8 dereferenceable(8) %19)
  ret %"class.std::basic_ostream"* %20
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIcEERSoS2_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8* nonnull align 1 dereferenceable(1) %1) #4 comdat {
  %3 = alloca %"class.std::basic_ostream"*, align 8
  %4 = alloca i8*, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %3, align 8
  %6 = load i8*, i8** %4, align 8
  %7 = load i8, i8* %6, align 1
  %8 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %5, i8 signext %7)
  %9 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %3, align 8
  ret %"class.std::basic_ostream"* %9
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJS3_S3_S3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8** nonnull align 8 dereferenceable(8) %1, i8** nonnull align 8 dereferenceable(8) %2, i8** nonnull align 8 dereferenceable(8) %3, i8** nonnull align 8 dereferenceable(8) %4) #4 comdat {
  %6 = alloca %"class.std::basic_ostream"*, align 8
  %7 = alloca i8**, align 8
  %8 = alloca i8**, align 8
  %9 = alloca i8**, align 8
  %10 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %6, align 8
  store i8** %1, i8*** %7, align 8
  store i8** %2, i8*** %8, align 8
  store i8** %3, i8*** %9, align 8
  store i8** %4, i8*** %10, align 8
  %11 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %6, align 8
  %12 = load i8**, i8*** %7, align 8
  %13 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %11, i8** nonnull align 8 dereferenceable(8) %12)
  %14 = load i8**, i8*** %8, align 8
  %15 = load i8**, i8*** %9, align 8
  %16 = load i8**, i8*** %10, align 8
  %17 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJS3_S3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %13, i8** nonnull align 8 dereferenceable(8) %14, i8** nonnull align 8 dereferenceable(8) %15, i8** nonnull align 8 dereferenceable(8) %16)
  ret %"class.std::basic_ostream"* %17
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJS3_S3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8** nonnull align 8 dereferenceable(8) %1, i8** nonnull align 8 dereferenceable(8) %2, i8** nonnull align 8 dereferenceable(8) %3) #4 comdat {
  %5 = alloca %"class.std::basic_ostream"*, align 8
  %6 = alloca i8**, align 8
  %7 = alloca i8**, align 8
  %8 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %5, align 8
  store i8** %1, i8*** %6, align 8
  store i8** %2, i8*** %7, align 8
  store i8** %3, i8*** %8, align 8
  %9 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %5, align 8
  %10 = load i8**, i8*** %6, align 8
  %11 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %9, i8** nonnull align 8 dereferenceable(8) %10)
  %12 = load i8**, i8*** %7, align 8
  %13 = load i8**, i8*** %8, align 8
  %14 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJS3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %11, i8** nonnull align 8 dereferenceable(8) %12, i8** nonnull align 8 dereferenceable(8) %13)
  ret %"class.std::basic_ostream"* %14
}

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8 signext) #1

declare dso_local i32 @__cudaPushCallConfiguration(i64, i32, i64, i32, i64, i8*) #1

declare dso_local %"class.std::ios_base::Init"* @_ZNK2at10TensorBase8data_ptrIN3c1013Float8_e4m3fnEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8)) #1

declare dso_local %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8)) #1

declare dso_local float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8)) #1

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, float* noalias %2, i64 %3) #11 {
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  %6 = alloca %"class.caffe2::TypeMeta"*, align 8
  %7 = alloca float*, align 8
  %8 = alloca i64, align 8
  %9 = alloca %struct.dim3, align 8
  %10 = alloca %struct.dim3, align 8
  %11 = alloca i64, align 8
  %12 = alloca i8*, align 8
  %13 = alloca { i64, i32 }, align 8
  %14 = alloca { i64, i32 }, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %5, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %6, align 8
  store float* %2, float** %7, align 8
  store i64 %3, i64* %8, align 8
  %15 = alloca i8*, i64 4, align 16
  %16 = bitcast %"class.std::ios_base::Init"** %5 to i8*
  %17 = getelementptr i8*, i8** %15, i32 0
  store i8* %16, i8** %17, align 8
  %18 = bitcast %"class.caffe2::TypeMeta"** %6 to i8*
  %19 = getelementptr i8*, i8** %15, i32 1
  store i8* %18, i8** %19, align 8
  %20 = bitcast float** %7 to i8*
  %21 = getelementptr i8*, i8** %15, i32 2
  store i8* %20, i8** %21, align 8
  %22 = bitcast i64* %8 to i8*
  %23 = getelementptr i8*, i8** %15, i32 3
  store i8* %22, i8** %23, align 8
  %24 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %9, %struct.dim3* %10, i64* %11, i8** %12)
  %25 = load i64, i64* %11, align 8
  %26 = load i8*, i8** %12, align 8
  %27 = bitcast { i64, i32 }* %13 to i8*
  %28 = bitcast %struct.dim3* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %27, i8* align 8 %28, i64 12, i1 false)
  %29 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %13, i32 0, i32 0
  %30 = load i64, i64* %29, align 8
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %13, i32 0, i32 1
  %32 = load i32, i32* %31, align 8
  %33 = bitcast { i64, i32 }* %14 to i8*
  %34 = bitcast %struct.dim3* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %33, i8* align 8 %34, i64 12, i1 false)
  %35 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %14, i32 0, i32 0
  %36 = load i64, i64* %35, align 8
  %37 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %14, i32 0, i32 1
  %38 = load i32, i32* %37, align 8
  %39 = bitcast i8* %26 to %struct.CUstream_st*
  %40 = call i32 @cudaLaunchKernel(i8* bitcast (void (%"class.std::ios_base::Init"*, %"class.caffe2::TypeMeta"*, float*, i64)* @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPKT_PKfl to i8*), i64 %30, i32 %32, i64 %36, i32 %38, i8** %15, i64 %25, %struct.CUstream_st* %39)
  br label %41

41:                                               ; preds = %4
  ret void
}

declare dso_local i32 @__cudaPopCallConfiguration(%struct.dim3*, %struct.dim3*, i64*, i8**)

declare dso_local i32 @cudaLaunchKernel(i8*, i64, i32, i64, i32, i8**, i64, %struct.CUstream_st*)

declare dso_local %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8)) #1

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, float* noalias %2, i64 %3) #11 {
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  %6 = alloca %"class.caffe2::TypeMeta"*, align 8
  %7 = alloca float*, align 8
  %8 = alloca i64, align 8
  %9 = alloca %struct.dim3, align 8
  %10 = alloca %struct.dim3, align 8
  %11 = alloca i64, align 8
  %12 = alloca i8*, align 8
  %13 = alloca { i64, i32 }, align 8
  %14 = alloca { i64, i32 }, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %5, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %6, align 8
  store float* %2, float** %7, align 8
  store i64 %3, i64* %8, align 8
  %15 = alloca i8*, i64 4, align 16
  %16 = bitcast %"class.std::ios_base::Init"** %5 to i8*
  %17 = getelementptr i8*, i8** %15, i32 0
  store i8* %16, i8** %17, align 8
  %18 = bitcast %"class.caffe2::TypeMeta"** %6 to i8*
  %19 = getelementptr i8*, i8** %15, i32 1
  store i8* %18, i8** %19, align 8
  %20 = bitcast float** %7 to i8*
  %21 = getelementptr i8*, i8** %15, i32 2
  store i8* %20, i8** %21, align 8
  %22 = bitcast i64* %8 to i8*
  %23 = getelementptr i8*, i8** %15, i32 3
  store i8* %22, i8** %23, align 8
  %24 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %9, %struct.dim3* %10, i64* %11, i8** %12)
  %25 = load i64, i64* %11, align 8
  %26 = load i8*, i8** %12, align 8
  %27 = bitcast { i64, i32 }* %13 to i8*
  %28 = bitcast %struct.dim3* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %27, i8* align 8 %28, i64 12, i1 false)
  %29 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %13, i32 0, i32 0
  %30 = load i64, i64* %29, align 8
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %13, i32 0, i32 1
  %32 = load i32, i32* %31, align 8
  %33 = bitcast { i64, i32 }* %14 to i8*
  %34 = bitcast %struct.dim3* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %33, i8* align 8 %34, i64 12, i1 false)
  %35 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %14, i32 0, i32 0
  %36 = load i64, i64* %35, align 8
  %37 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %14, i32 0, i32 1
  %38 = load i32, i32* %37, align 8
  %39 = bitcast i8* %26 to %struct.CUstream_st*
  %40 = call i32 @cudaLaunchKernel(i8* bitcast (void (%"class.std::ios_base::Init"*, %"class.caffe2::TypeMeta"*, float*, i64)* @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPKT_PKfl to i8*), i64 %30, i32 %32, i64 %36, i32 %38, i8** %15, i64 %25, %struct.CUstream_st* %39)
  br label %41

41:                                               ; preds = %4
  ret void
}

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* noalias %0, float* noalias %1, float* noalias %2, i64 %3) #11 {
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  %6 = alloca float*, align 8
  %7 = alloca float*, align 8
  %8 = alloca i64, align 8
  %9 = alloca %struct.dim3, align 8
  %10 = alloca %struct.dim3, align 8
  %11 = alloca i64, align 8
  %12 = alloca i8*, align 8
  %13 = alloca { i64, i32 }, align 8
  %14 = alloca { i64, i32 }, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %5, align 8
  store float* %1, float** %6, align 8
  store float* %2, float** %7, align 8
  store i64 %3, i64* %8, align 8
  %15 = alloca i8*, i64 4, align 16
  %16 = bitcast %"class.std::ios_base::Init"** %5 to i8*
  %17 = getelementptr i8*, i8** %15, i32 0
  store i8* %16, i8** %17, align 8
  %18 = bitcast float** %6 to i8*
  %19 = getelementptr i8*, i8** %15, i32 1
  store i8* %18, i8** %19, align 8
  %20 = bitcast float** %7 to i8*
  %21 = getelementptr i8*, i8** %15, i32 2
  store i8* %20, i8** %21, align 8
  %22 = bitcast i64* %8 to i8*
  %23 = getelementptr i8*, i8** %15, i32 3
  store i8* %22, i8** %23, align 8
  %24 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %9, %struct.dim3* %10, i64* %11, i8** %12)
  %25 = load i64, i64* %11, align 8
  %26 = load i8*, i8** %12, align 8
  %27 = bitcast { i64, i32 }* %13 to i8*
  %28 = bitcast %struct.dim3* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %27, i8* align 8 %28, i64 12, i1 false)
  %29 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %13, i32 0, i32 0
  %30 = load i64, i64* %29, align 8
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %13, i32 0, i32 1
  %32 = load i32, i32* %31, align 8
  %33 = bitcast { i64, i32 }* %14 to i8*
  %34 = bitcast %struct.dim3* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %33, i8* align 8 %34, i64 12, i1 false)
  %35 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %14, i32 0, i32 0
  %36 = load i64, i64* %35, align 8
  %37 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %14, i32 0, i32 1
  %38 = load i32, i32* %37, align 8
  %39 = bitcast i8* %26 to %struct.CUstream_st*
  %40 = call i32 @cudaLaunchKernel(i8* bitcast (void (%"class.std::ios_base::Init"*, float*, float*, i64)* @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPKT_PKfl to i8*), i64 %30, i32 %32, i64 %36, i32 %38, i8** %15, i64 %25, %struct.CUstream_st* %39)
  br label %41

41:                                               ; preds = %4
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"class.c10::intrusive_ptr"*, align 8
  store %"class.c10::intrusive_ptr"* %0, %"class.c10::intrusive_ptr"** %2, align 8
  %3 = load %"class.c10::intrusive_ptr"*, %"class.c10::intrusive_ptr"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::intrusive_ptr", %"class.c10::intrusive_ptr"* %3, i32 0, i32 0
  %5 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %4, align 8
  ret %"struct.c10::TensorImpl"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i16 @_ZNK3c1010TensorImpl5dtypeEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #8 comdat align 2 {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = alloca %"struct.c10::TensorImpl"*, align 8
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %3, align 8
  %4 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %3, align 8
  %5 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %4, i32 0, i32 9
  %6 = bitcast %"class.caffe2::TypeMeta"* %2 to i8*
  %7 = bitcast %"class.caffe2::TypeMeta"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %6, i8* align 8 %7, i64 2, i1 false)
  %8 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, i32 0, i32 0
  %9 = load i16, i16* %8, align 2
  ret i16 %9
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local signext i8 @_ZN3c1020typeMetaToScalarTypeEN6caffe28TypeMetaE(i16 %0) #4 comdat {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, i32 0, i32 0
  store i16 %0, i16* %3, align 2
  %4 = call signext i8 @_ZN6caffe28TypeMeta12toScalarTypeEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %2)
  ret i8 %4
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local signext i8 @_ZN6caffe28TypeMeta12toScalarTypeEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #4 comdat align 2 {
  %2 = alloca %"class.caffe2::TypeMeta"*, align 8
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %2, align 8
  %4 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %2, align 8
  %5 = call zeroext i1 @_ZNK6caffe28TypeMeta12isScalarTypeEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %4) #3
  br i1 %5, label %6, label %10

6:                                                ; preds = %1
  %7 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %4, i32 0, i32 0
  %8 = load i16, i16* %7, align 2
  %9 = trunc i16 %8 to i8
  ret i8 %9

10:                                               ; preds = %1
  %11 = bitcast %"class.caffe2::TypeMeta"* %3 to i8*
  %12 = bitcast %"class.caffe2::TypeMeta"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %11, i8* align 2 %12, i64 2, i1 false)
  %13 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %3, i32 0, i32 0
  %14 = load i16, i16* %13, align 2
  call void @_ZN6caffe28TypeMeta26error_unsupported_typemetaES0_(i16 %14) #25
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK6caffe28TypeMeta12isScalarTypeEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #8 comdat align 2 {
  %2 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %2, align 8
  %3 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %2, align 8
  %4 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %3, i32 0, i32 0
  %5 = load i16, i16* %4, align 2
  %6 = zext i16 %5 to i32
  %7 = icmp slt i32 %6, 46
  ret i1 %7
}

; Function Attrs: noreturn
declare dso_local void @_ZN6caffe28TypeMeta26error_unsupported_typemetaES0_(i16) #10

declare dso_local %struct.CUstream_st* @_ZNK3c104cuda10CUDAStream6streamEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16)) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl25InlineOptionalDeviceGuardINS_4cuda4impl13CUDAGuardImplEEC2ESt8optionalINS_6DeviceEE(%"class.c10::impl::InlineOptionalDeviceGuard"* nonnull align 8 dereferenceable(24) %0, i24 %1) unnamed_addr #7 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.std::optional.53", align 1
  %4 = alloca i24, align 4
  %5 = alloca %"class.c10::impl::InlineOptionalDeviceGuard"*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i32, align 4
  %8 = getelementptr inbounds %"class.std::optional.53", %"class.std::optional.53"* %3, i32 0, i32 0
  %9 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %8, i32 0, i32 0
  %10 = getelementptr inbounds %"struct.std::_Optional_payload.56", %"struct.std::_Optional_payload.56"* %9, i32 0, i32 0
  store i24 %1, i24* %4, align 4
  %11 = bitcast %"struct.std::_Optional_payload_base.57"* %10 to i8*
  %12 = bitcast i24* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 4 %12, i64 3, i1 false)
  store %"class.c10::impl::InlineOptionalDeviceGuard"* %0, %"class.c10::impl::InlineOptionalDeviceGuard"** %5, align 8
  %13 = load %"class.c10::impl::InlineOptionalDeviceGuard"*, %"class.c10::impl::InlineOptionalDeviceGuard"** %5, align 8
  %14 = getelementptr inbounds %"class.c10::impl::InlineOptionalDeviceGuard", %"class.c10::impl::InlineOptionalDeviceGuard"* %13, i32 0, i32 0
  call void @_ZNSt8optionalIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEEC2Ev(%"class.std::optional.59"* nonnull align 8 dereferenceable(24) %14) #3
  %15 = call zeroext i1 @_ZNKSt8optionalIN3c106DeviceEE9has_valueEv(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %3) #3
  br i1 %15, label %16, label %26

16:                                               ; preds = %2
  %17 = getelementptr inbounds %"class.c10::impl::InlineOptionalDeviceGuard", %"class.c10::impl::InlineOptionalDeviceGuard"* %13, i32 0, i32 0
  %18 = invoke nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNRSt8optionalIN3c106DeviceEE5valueEv(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %3)
          to label %19 unwind label %22

19:                                               ; preds = %16
  %20 = invoke nonnull align 8 dereferenceable(12) %"class.c10::impl::InlineDeviceGuard"* @_ZNSt8optionalIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE7emplaceIJRNS0_6DeviceEEEENSt9enable_ifIX18is_constructible_vIS6_DpT_EERS6_E4typeEDpOSC_(%"class.std::optional.59"* nonnull align 8 dereferenceable(24) %17, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %18)
          to label %21 unwind label %22

21:                                               ; preds = %19
  br label %26

22:                                               ; preds = %19, %16
  %23 = landingpad { i8*, i32 }
          cleanup
  %24 = extractvalue { i8*, i32 } %23, 0
  store i8* %24, i8** %6, align 8
  %25 = extractvalue { i8*, i32 } %23, 1
  store i32 %25, i32* %7, align 4
  call void @_ZNSt8optionalIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEED2Ev(%"class.std::optional.59"* nonnull align 8 dereferenceable(24) %14) #3
  br label %27

26:                                               ; preds = %21, %2
  ret void

27:                                               ; preds = %22
  %28 = load i8*, i8** %6, align 8
  %29 = load i32, i32* %7, align 4
  %30 = insertvalue { i8*, i32 } undef, i8* %28, 0
  %31 = insertvalue { i8*, i32 } %30, i32 %29, 1
  resume { i8*, i32 } %31
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt8optionalIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEEC2Ev(%"class.std::optional.59"* nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.std::optional.59"*, align 8
  store %"class.std::optional.59"* %0, %"class.std::optional.59"** %2, align 8
  %3 = load %"class.std::optional.59"*, %"class.std::optional.59"** %2, align 8
  %4 = bitcast %"class.std::optional.59"* %3 to %"struct.std::_Optional_base.60"*
  call void @_ZNSt14_Optional_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0EEC2Ev(%"struct.std::_Optional_base.60"* nonnull align 8 dereferenceable(24) %4) #3
  %5 = bitcast %"class.std::optional.59"* %3 to %"class.std::ios_base::Init"*
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNKSt8optionalIN3c106DeviceEE9has_valueEv(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::optional.53"*, align 8
  store %"class.std::optional.53"* %0, %"class.std::optional.53"** %2, align 8
  %3 = load %"class.std::optional.53"*, %"class.std::optional.53"** %2, align 8
  %4 = bitcast %"class.std::optional.53"* %3 to %"class.std::ios_base::Init"*
  %5 = call zeroext i1 @_ZNKSt19_Optional_base_implIN3c106DeviceESt14_Optional_baseIS1_Lb1ELb1EEE13_M_is_engagedEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %4) #3
  ret i1 %5
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNRSt8optionalIN3c106DeviceEE5valueEv(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %0) #4 comdat align 2 {
  %2 = alloca %"class.std::optional.53"*, align 8
  store %"class.std::optional.53"* %0, %"class.std::optional.53"** %2, align 8
  %3 = load %"class.std::optional.53"*, %"class.std::optional.53"** %2, align 8
  %4 = bitcast %"class.std::optional.53"* %3 to %"class.std::ios_base::Init"*
  %5 = call zeroext i1 @_ZNKSt19_Optional_base_implIN3c106DeviceESt14_Optional_baseIS1_Lb1ELb1EEE13_M_is_engagedEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %4) #3
  br i1 %5, label %6, label %9

6:                                                ; preds = %1
  %7 = bitcast %"class.std::optional.53"* %3 to %"class.std::ios_base::Init"*
  %8 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNSt19_Optional_base_implIN3c106DeviceESt14_Optional_baseIS1_Lb1ELb1EEE6_M_getEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %7) #3
  ret %"struct.c10::Device"* %8

9:                                                ; preds = %1
  call void @_ZSt27__throw_bad_optional_accessv() #25
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(12) %"class.c10::impl::InlineDeviceGuard"* @_ZNSt8optionalIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE7emplaceIJRNS0_6DeviceEEEENSt9enable_ifIX18is_constructible_vIS6_DpT_EERS6_E4typeEDpOSC_(%"class.std::optional.59"* nonnull align 8 dereferenceable(24) %0, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %1) #4 comdat align 2 {
  %3 = alloca %"class.std::optional.59"*, align 8
  %4 = alloca %"struct.c10::Device"*, align 8
  store %"class.std::optional.59"* %0, %"class.std::optional.59"** %3, align 8
  store %"struct.c10::Device"* %1, %"struct.c10::Device"** %4, align 8
  %5 = load %"class.std::optional.59"*, %"class.std::optional.59"** %3, align 8
  %6 = bitcast %"class.std::optional.59"* %5 to %"class.std::ios_base::Init"*
  call void @_ZNSt19_Optional_base_implIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEESt14_Optional_baseIS6_Lb0ELb0EEE8_M_resetEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %6) #3
  %7 = bitcast %"class.std::optional.59"* %5 to %"class.std::ios_base::Init"*
  %8 = load %"struct.c10::Device"*, %"struct.c10::Device"** %4, align 8
  %9 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZSt7forwardIRN3c106DeviceEEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %8) #3
  call void @_ZNSt19_Optional_base_implIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEESt14_Optional_baseIS6_Lb0ELb0EEE12_M_constructIJRNS0_6DeviceEEEEvDpOT_(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %7, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %9)
  %10 = bitcast %"class.std::optional.59"* %5 to %"class.std::ios_base::Init"*
  %11 = call nonnull align 8 dereferenceable(12) %"class.c10::impl::InlineDeviceGuard"* @_ZNSt19_Optional_base_implIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEESt14_Optional_baseIS6_Lb0ELb0EEE6_M_getEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %10) #3
  ret %"class.c10::impl::InlineDeviceGuard"* %11
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt19_Optional_base_implIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEESt14_Optional_baseIS6_Lb0ELb0EEE8_M_resetEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  %4 = bitcast %"class.std::ios_base::Init"* %3 to %"struct.std::_Optional_base.60"*
  %5 = getelementptr inbounds %"struct.std::_Optional_base.60", %"struct.std::_Optional_base.60"* %4, i32 0, i32 0
  %6 = bitcast %"struct.std::_Optional_payload.62"* %5 to %"struct.std::_Optional_payload_base.64"*
  call void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE8_M_resetEv(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %6) #3
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZSt7forwardIRN3c106DeviceEEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %0) #8 comdat {
  %2 = alloca %"struct.c10::Device"*, align 8
  store %"struct.c10::Device"* %0, %"struct.c10::Device"** %2, align 8
  %3 = load %"struct.c10::Device"*, %"struct.c10::Device"** %2, align 8
  ret %"struct.c10::Device"* %3
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt19_Optional_base_implIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEESt14_Optional_baseIS6_Lb0ELb0EEE12_M_constructIJRNS0_6DeviceEEEEvDpOT_(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %1) #4 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init"*, align 8
  %4 = alloca %"struct.c10::Device"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %3, align 8
  store %"struct.c10::Device"* %1, %"struct.c10::Device"** %4, align 8
  %5 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %3, align 8
  %6 = bitcast %"class.std::ios_base::Init"* %5 to %"struct.std::_Optional_base.60"*
  %7 = getelementptr inbounds %"struct.std::_Optional_base.60", %"struct.std::_Optional_base.60"* %6, i32 0, i32 0
  %8 = bitcast %"struct.std::_Optional_payload.62"* %7 to %"struct.std::_Optional_payload_base.64"*
  %9 = load %"struct.c10::Device"*, %"struct.c10::Device"** %4, align 8
  %10 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZSt7forwardIRN3c106DeviceEEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %9) #3
  call void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE12_M_constructIJRNS0_6DeviceEEEEvDpOT_(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %8, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %10)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(12) %"class.c10::impl::InlineDeviceGuard"* @_ZNSt19_Optional_base_implIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEESt14_Optional_baseIS6_Lb0ELb0EEE6_M_getEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  br label %4

4:                                                ; preds = %1
  br label %5

5:                                                ; preds = %4
  br label %6

6:                                                ; preds = %5
  %7 = bitcast %"class.std::ios_base::Init"* %3 to %"struct.std::_Optional_base.60"*
  %8 = getelementptr inbounds %"struct.std::_Optional_base.60", %"struct.std::_Optional_base.60"* %7, i32 0, i32 0
  %9 = bitcast %"struct.std::_Optional_payload.62"* %8 to %"struct.std::_Optional_payload_base.64"*
  %10 = call nonnull align 8 dereferenceable(12) %"class.c10::impl::InlineDeviceGuard"* @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE6_M_getEv(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %9) #3
  ret %"class.c10::impl::InlineDeviceGuard"* %10
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(12) %"class.c10::impl::InlineDeviceGuard"* @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE6_M_getEv(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload_base.64"*, align 8
  store %"struct.std::_Optional_payload_base.64"* %0, %"struct.std::_Optional_payload_base.64"** %2, align 8
  %3 = load %"struct.std::_Optional_payload_base.64"*, %"struct.std::_Optional_payload_base.64"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_payload_base.64", %"struct.std::_Optional_payload_base.64"* %3, i32 0, i32 0
  %5 = bitcast %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"* %4 to %"class.c10::impl::InlineDeviceGuard"*
  ret %"class.c10::impl::InlineDeviceGuard"* %5
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE12_M_constructIJRNS0_6DeviceEEEEvDpOT_(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %0, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %1) #4 comdat align 2 {
  %3 = alloca %"struct.std::_Optional_payload_base.64"*, align 8
  %4 = alloca %"struct.c10::Device"*, align 8
  store %"struct.std::_Optional_payload_base.64"* %0, %"struct.std::_Optional_payload_base.64"** %3, align 8
  store %"struct.c10::Device"* %1, %"struct.c10::Device"** %4, align 8
  %5 = load %"struct.std::_Optional_payload_base.64"*, %"struct.std::_Optional_payload_base.64"** %3, align 8
  %6 = getelementptr inbounds %"struct.std::_Optional_payload_base.64", %"struct.std::_Optional_payload_base.64"* %5, i32 0, i32 0
  %7 = bitcast %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"* %6 to %"class.c10::impl::InlineDeviceGuard"*
  %8 = call %"class.c10::impl::InlineDeviceGuard"* @_ZSt11__addressofIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEEPT_RS7_(%"class.c10::impl::InlineDeviceGuard"* nonnull align 8 dereferenceable(12) %7) #3
  %9 = load %"struct.c10::Device"*, %"struct.c10::Device"** %4, align 8
  %10 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZSt7forwardIRN3c106DeviceEEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %9) #3
  call void @_ZSt10_ConstructIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEJRNS0_6DeviceEEEvPT_DpOT0_(%"class.c10::impl::InlineDeviceGuard"* %8, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %10)
  %11 = getelementptr inbounds %"struct.std::_Optional_payload_base.64", %"struct.std::_Optional_payload_base.64"* %5, i32 0, i32 1
  store i8 1, i8* %11, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"class.c10::impl::InlineDeviceGuard"* @_ZSt11__addressofIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEEPT_RS7_(%"class.c10::impl::InlineDeviceGuard"* nonnull align 8 dereferenceable(12) %0) #8 comdat {
  %2 = alloca %"class.c10::impl::InlineDeviceGuard"*, align 8
  store %"class.c10::impl::InlineDeviceGuard"* %0, %"class.c10::impl::InlineDeviceGuard"** %2, align 8
  %3 = load %"class.c10::impl::InlineDeviceGuard"*, %"class.c10::impl::InlineDeviceGuard"** %2, align 8
  ret %"class.c10::impl::InlineDeviceGuard"* %3
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZSt10_ConstructIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEJRNS0_6DeviceEEEvPT_DpOT0_(%"class.c10::impl::InlineDeviceGuard"* %0, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %1) #4 comdat {
  %3 = alloca %"class.c10::impl::InlineDeviceGuard"*, align 8
  %4 = alloca %"struct.c10::Device"*, align 8
  %5 = alloca %"struct.c10::Device", align 1
  store %"class.c10::impl::InlineDeviceGuard"* %0, %"class.c10::impl::InlineDeviceGuard"** %3, align 8
  store %"struct.c10::Device"* %1, %"struct.c10::Device"** %4, align 8
  %6 = load %"class.c10::impl::InlineDeviceGuard"*, %"class.c10::impl::InlineDeviceGuard"** %3, align 8
  %7 = bitcast %"class.c10::impl::InlineDeviceGuard"* %6 to i8*
  %8 = bitcast i8* %7 to %"class.c10::impl::InlineDeviceGuard"*
  %9 = load %"struct.c10::Device"*, %"struct.c10::Device"** %4, align 8
  %10 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZSt7forwardIRN3c106DeviceEEOT_RNSt16remove_referenceIS3_E4typeE(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %9) #3
  %11 = bitcast %"struct.c10::Device"* %5 to i8*
  %12 = bitcast %"struct.c10::Device"* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %12, i64 2, i1 false)
  %13 = bitcast %"struct.c10::Device"* %5 to i16*
  %14 = load i16, i16* %13, align 1
  call void @_ZN3c104impl17InlineDeviceGuardINS_4cuda4impl13CUDAGuardImplEEC2ENS_6DeviceE(%"class.c10::impl::InlineDeviceGuard"* nonnull align 8 dereferenceable(12) %8, i16 %14)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl17InlineDeviceGuardINS_4cuda4impl13CUDAGuardImplEEC2ENS_6DeviceE(%"class.c10::impl::InlineDeviceGuard"* nonnull align 8 dereferenceable(12) %0, i16 %1) unnamed_addr #7 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"struct.c10::Device", align 1
  %4 = alloca %"class.c10::impl::InlineDeviceGuard"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %"struct.c10::Device", align 1
  %8 = bitcast %"struct.c10::Device"* %3 to i16*
  store i16 %1, i16* %8, align 1
  store %"class.c10::impl::InlineDeviceGuard"* %0, %"class.c10::impl::InlineDeviceGuard"** %4, align 8
  %9 = load %"class.c10::impl::InlineDeviceGuard"*, %"class.c10::impl::InlineDeviceGuard"** %4, align 8
  %10 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard", %"class.c10::impl::InlineDeviceGuard"* %9, i32 0, i32 0
  %11 = call signext i8 @_ZNK3c106Device4typeEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %3) #3
  call void @_ZN3c104cuda4impl13CUDAGuardImplC2ENS_10DeviceTypeE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %10, i8 signext %11)
  %12 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard", %"class.c10::impl::InlineDeviceGuard"* %9, i32 0, i32 1
  %13 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %3) #3
  %14 = sext i8 %13 to i32
  %15 = icmp eq i32 %14, -1
  br i1 %15, label %16, label %21

16:                                               ; preds = %2
  %17 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard", %"class.c10::impl::InlineDeviceGuard"* %9, i32 0, i32 0
  %18 = invoke i16 @_ZNK3c104cuda4impl13CUDAGuardImpl9getDeviceEv(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %17)
          to label %19 unwind label %42

19:                                               ; preds = %16
  %20 = bitcast %"struct.c10::Device"* %12 to i16*
  store i16 %18, i16* %20, align 8
  br label %30

21:                                               ; preds = %2
  %22 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard", %"class.c10::impl::InlineDeviceGuard"* %9, i32 0, i32 0
  %23 = bitcast %"struct.c10::Device"* %7 to i8*
  %24 = bitcast %"struct.c10::Device"* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %23, i8* align 1 %24, i64 2, i1 false)
  %25 = bitcast %"struct.c10::Device"* %7 to i16*
  %26 = load i16, i16* %25, align 1
  %27 = invoke i16 @_ZNK3c104cuda4impl13CUDAGuardImpl14exchangeDeviceENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %22, i16 %26)
          to label %28 unwind label %42

28:                                               ; preds = %21
  %29 = bitcast %"struct.c10::Device"* %12 to i16*
  store i16 %27, i16* %29, align 8
  br label %30

30:                                               ; preds = %28, %19
  %31 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard", %"class.c10::impl::InlineDeviceGuard"* %9, i32 0, i32 2
  %32 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %3) #3
  %33 = sext i8 %32 to i32
  %34 = icmp eq i32 %33, -1
  br i1 %34, label %35, label %37

35:                                               ; preds = %30
  %36 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard", %"class.c10::impl::InlineDeviceGuard"* %9, i32 0, i32 1
  br label %38

37:                                               ; preds = %30
  br label %38

38:                                               ; preds = %37, %35
  %39 = phi %"struct.c10::Device"* [ %36, %35 ], [ %3, %37 ]
  %40 = bitcast %"struct.c10::Device"* %31 to i8*
  %41 = bitcast %"struct.c10::Device"* %39 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %40, i8* align 1 %41, i64 2, i1 false)
  ret void

42:                                               ; preds = %21, %16
  %43 = landingpad { i8*, i32 }
          cleanup
  %44 = extractvalue { i8*, i32 } %43, 0
  store i8* %44, i8** %5, align 8
  %45 = extractvalue { i8*, i32 } %43, 1
  store i32 %45, i32* %6, align 4
  call void @_ZN3c104cuda4impl13CUDAGuardImplD2Ev(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %10) #3
  br label %46

46:                                               ; preds = %42
  %47 = load i8*, i8** %5, align 8
  %48 = load i32, i32* %6, align 4
  %49 = insertvalue { i8*, i32 } undef, i8* %47, 0
  %50 = insertvalue { i8*, i32 } %49, i32 %48, 1
  resume { i8*, i32 } %50
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local signext i8 @_ZNK3c106Device4typeEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %0) #8 comdat align 2 {
  %2 = alloca %"struct.c10::Device"*, align 8
  store %"struct.c10::Device"* %0, %"struct.c10::Device"** %2, align 8
  %3 = load %"struct.c10::Device"*, %"struct.c10::Device"** %2, align 8
  %4 = getelementptr inbounds %"struct.c10::Device", %"struct.c10::Device"* %3, i32 0, i32 0
  %5 = load i8, i8* %4, align 1
  ret i8 %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c104cuda4impl13CUDAGuardImplC2ENS_10DeviceTypeE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i8 signext %1) unnamed_addr #7 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %4 = alloca i8, align 1
  %5 = alloca %"class.std::ios_base::Init", align 1
  %6 = alloca i8*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %"class.std::ios_base::Init", align 1
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  store i8 %1, i8* %4, align 1
  %9 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  %10 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %9 to %"struct.c10::Allocator"*
  call void @_ZN3c104impl24DeviceGuardImplInterfaceC2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %10) #3
  %11 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %9 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [25 x i8*] }, { [25 x i8*] }* @_ZTVN3c104cuda4impl13CUDAGuardImplE, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %11, align 8
  %12 = load i8, i8* %4, align 1
  %13 = icmp eq i8 %12, 1
  br i1 %13, label %22, label %14

14:                                               ; preds = %2
  invoke void @_ZN3c103strIJEEEDcDpRKT_()
          to label %15 unwind label %17

15:                                               ; preds = %14
  invoke void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_NS0_22CompileTimeEmptyStringE(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__func__._ZN3c104cuda4impl13CUDAGuardImplC2ENS_10DeviceTypeE, i64 0, i64 0), i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i32 28, i8* getelementptr inbounds ([199 x i8], [199 x i8]* @.str.8, i64 0, i64 0)) #25
          to label %16 unwind label %17

16:                                               ; preds = %15
  unreachable

17:                                               ; preds = %15, %14
  %18 = landingpad { i8*, i32 }
          cleanup
  %19 = extractvalue { i8*, i32 } %18, 0
  store i8* %19, i8** %6, align 8
  %20 = extractvalue { i8*, i32 } %18, 1
  store i32 %20, i32* %7, align 4
  %21 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %9 to %"struct.c10::Allocator"*
  call void @_ZN3c104impl24DeviceGuardImplInterfaceD2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %21) #3
  br label %23

22:                                               ; preds = %2
  ret void

23:                                               ; preds = %17
  %24 = load i8*, i8** %6, align 8
  %25 = load i32, i32* %7, align 4
  %26 = insertvalue { i8*, i32 } undef, i8* %24, 0
  %27 = insertvalue { i8*, i32 } %26, i32 %25, 1
  resume { i8*, i32 } %27
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i16 @_ZNK3c104cuda4impl13CUDAGuardImpl9getDeviceEv(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #4 comdat align 2 {
  %2 = alloca %"struct.c10::Device", align 1
  %3 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  %6 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  store i8 0, i8* %4, align 1
  br label %7

7:                                                ; preds = %1
  %8 = call i32 @_ZN3c104cuda9GetDeviceEPa(i8* %4)
  store i32 %8, i32* %5, align 4
  %9 = load i32, i32* %5, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %9, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl9getDeviceEv, i64 0, i64 0), i32 40, i1 zeroext true)
  br label %10

10:                                               ; preds = %7
  %11 = load i8, i8* %4, align 1
  call void @_ZN3c106DeviceC2ENS_10DeviceTypeEa(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %2, i8 signext 1, i8 signext %11)
  %12 = bitcast %"struct.c10::Device"* %2 to i16*
  %13 = load i16, i16* %12, align 1
  ret i16 %13
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i16 @_ZNK3c104cuda4impl13CUDAGuardImpl14exchangeDeviceENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i16 %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::Device", align 1
  %4 = alloca %"struct.c10::Device", align 1
  %5 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %6 = alloca %"class.std::ios_base::Init", align 1
  %7 = alloca %"class.std::ios_base::Init", align 1
  %8 = alloca i8, align 1
  %9 = bitcast %"struct.c10::Device"* %4 to i16*
  store i16 %1, i16* %9, align 1
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %5, align 8
  %10 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %5, align 8
  %11 = call zeroext i1 @_ZNK3c106Device7is_cudaEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %4) #3
  br i1 %11, label %13, label %12

12:                                               ; preds = %2
  call void @_ZN3c103strIJEEEDcDpRKT_()
  call void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_NS0_22CompileTimeEmptyStringE(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl14exchangeDeviceENS_6DeviceE, i64 0, i64 0), i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i32 34, i8* getelementptr inbounds ([189 x i8], [189 x i8]* @.str.39, i64 0, i64 0)) #25
  unreachable

13:                                               ; preds = %2
  %14 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %4) #3
  %15 = call signext i8 @_ZN3c104cuda14ExchangeDeviceEa(i8 signext %14)
  store i8 %15, i8* %8, align 1
  %16 = load i8, i8* %8, align 1
  call void @_ZN3c106DeviceC2ENS_10DeviceTypeEa(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %3, i8 signext 1, i8 signext %16)
  %17 = bitcast %"struct.c10::Device"* %3 to i16*
  %18 = load i16, i16* %17, align 1
  ret i16 %18
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c106Device7is_cudaEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %0) #8 comdat align 2 {
  %2 = alloca %"struct.c10::Device"*, align 8
  store %"struct.c10::Device"* %0, %"struct.c10::Device"** %2, align 8
  %3 = load %"struct.c10::Device"*, %"struct.c10::Device"** %2, align 8
  %4 = getelementptr inbounds %"struct.c10::Device", %"struct.c10::Device"* %3, i32 0, i32 0
  %5 = load i8, i8* %4, align 1
  %6 = icmp eq i8 %5, 1
  ret i1 %6
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c103strIJEEEDcDpRKT_() #4 comdat {
  %1 = alloca %"class.std::ios_base::Init", align 1
  call void @_ZN3c106detail12_str_wrapperIJEE4callEv()
  ret void
}

; Function Attrs: mustprogress noinline noreturn optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_NS0_22CompileTimeEmptyStringE(i8* %0, i8* %1, i32 %2, i8* %3) #12 comdat {
  %5 = alloca %"class.std::ios_base::Init", align 1
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i8*, align 8
  store i8* %0, i8** %6, align 8
  store i8* %1, i8** %7, align 8
  store i32 %2, i32* %8, align 4
  store i8* %3, i8** %9, align 8
  %10 = load i8*, i8** %6, align 8
  %11 = load i8*, i8** %7, align 8
  %12 = load i32, i32* %8, align 4
  %13 = load i8*, i8** %9, align 8
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* %10, i8* %11, i32 %12, i8* %13) #25
  unreachable
}

declare dso_local signext i8 @_ZN3c104cuda14ExchangeDeviceEa(i8 signext) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c106DeviceC2ENS_10DeviceTypeEa(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %0, i8 signext %1, i8 signext %2) unnamed_addr #7 comdat align 2 {
  %4 = alloca %"struct.c10::Device"*, align 8
  %5 = alloca i8, align 1
  %6 = alloca i8, align 1
  store %"struct.c10::Device"* %0, %"struct.c10::Device"** %4, align 8
  store i8 %1, i8* %5, align 1
  store i8 %2, i8* %6, align 1
  %7 = load %"struct.c10::Device"*, %"struct.c10::Device"** %4, align 8
  %8 = getelementptr inbounds %"struct.c10::Device", %"struct.c10::Device"* %7, i32 0, i32 0
  %9 = load i8, i8* %5, align 1
  store i8 %9, i8* %8, align 1
  %10 = getelementptr inbounds %"struct.c10::Device", %"struct.c10::Device"* %7, i32 0, i32 1
  %11 = load i8, i8* %6, align 1
  store i8 %11, i8* %10, align 1
  call void @_ZN3c106Device8validateEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %7)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c106Device8validateEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %0) #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"struct.c10::Device"*, align 8
  %3 = alloca %"class.std::__cxx11::basic_string", align 8
  %4 = alloca i32, align 4
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %"class.std::__cxx11::basic_string", align 8
  %8 = alloca i32, align 4
  store %"struct.c10::Device"* %0, %"struct.c10::Device"** %2, align 8
  %9 = load %"struct.c10::Device"*, %"struct.c10::Device"** %2, align 8
  %10 = getelementptr inbounds %"struct.c10::Device", %"struct.c10::Device"* %9, i32 0, i32 1
  %11 = load i8, i8* %10, align 1
  %12 = sext i8 %11 to i32
  %13 = icmp sge i32 %12, -1
  br i1 %13, label %23, label %14

14:                                               ; preds = %1
  %15 = getelementptr inbounds %"struct.c10::Device", %"struct.c10::Device"* %9, i32 0, i32 1
  %16 = load i8, i8* %15, align 1
  %17 = sext i8 %16 to i32
  store i32 %17, i32* %4, align 4
  call void @_ZN3c103strIJA46_ciEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %3, [46 x i8]* nonnull align 1 dereferenceable(46) @.str.36, i32* nonnull align 4 dereferenceable(4) %4)
  invoke void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_RKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__func__._ZN3c106Device8validateEv, i64 0, i64 0), i8* getelementptr inbounds ([100 x i8], [100 x i8]* @.str.34, i64 0, i64 0), i32 180, i8* getelementptr inbounds ([179 x i8], [179 x i8]* @.str.35, i64 0, i64 0), %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %3) #25
          to label %18 unwind label %19

18:                                               ; preds = %14
  unreachable

19:                                               ; preds = %14
  %20 = landingpad { i8*, i32 }
          cleanup
  %21 = extractvalue { i8*, i32 } %20, 0
  store i8* %21, i8** %5, align 8
  %22 = extractvalue { i8*, i32 } %20, 1
  store i32 %22, i32* %6, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %3) #3
  br label %40

23:                                               ; preds = %1
  %24 = call zeroext i1 @_ZNK3c106Device6is_cpuEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %9) #3
  br i1 %24, label %25, label %39

25:                                               ; preds = %23
  %26 = getelementptr inbounds %"struct.c10::Device", %"struct.c10::Device"* %9, i32 0, i32 1
  %27 = load i8, i8* %26, align 1
  %28 = sext i8 %27 to i32
  %29 = icmp sle i32 %28, 0
  br i1 %29, label %39, label %30

30:                                               ; preds = %25
  %31 = getelementptr inbounds %"struct.c10::Device", %"struct.c10::Device"* %9, i32 0, i32 1
  %32 = load i8, i8* %31, align 1
  %33 = sext i8 %32 to i32
  store i32 %33, i32* %8, align 4
  call void @_ZN3c103strIJA42_ciEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %7, [42 x i8]* nonnull align 1 dereferenceable(42) @.str.38, i32* nonnull align 4 dereferenceable(4) %8)
  invoke void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_RKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__func__._ZN3c106Device8validateEv, i64 0, i64 0), i8* getelementptr inbounds ([100 x i8], [100 x i8]* @.str.34, i64 0, i64 0), i32 184, i8* getelementptr inbounds ([191 x i8], [191 x i8]* @.str.37, i64 0, i64 0), %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %7) #25
          to label %34 unwind label %35

34:                                               ; preds = %30
  unreachable

35:                                               ; preds = %30
  %36 = landingpad { i8*, i32 }
          cleanup
  %37 = extractvalue { i8*, i32 } %36, 0
  store i8* %37, i8** %5, align 8
  %38 = extractvalue { i8*, i32 } %36, 1
  store i32 %38, i32* %6, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %7) #3
  br label %40

39:                                               ; preds = %25, %23
  ret void

40:                                               ; preds = %35, %19
  %41 = load i8*, i8** %5, align 8
  %42 = load i32, i32* %6, align 4
  %43 = insertvalue { i8*, i32 } undef, i8* %41, 0
  %44 = insertvalue { i8*, i32 } %43, i32 %42, 1
  resume { i8*, i32 } %44
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c103strIJA46_ciEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, [46 x i8]* nonnull align 1 dereferenceable(46) %1, i32* nonnull align 4 dereferenceable(4) %2) #4 comdat {
  %4 = alloca i8*, align 8
  %5 = alloca [46 x i8]*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i8*, align 8
  %8 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %8, i8** %4, align 8
  store [46 x i8]* %1, [46 x i8]** %5, align 8
  store i32* %2, i32** %6, align 8
  %9 = load [46 x i8]*, [46 x i8]** %5, align 8
  %10 = getelementptr inbounds [46 x i8], [46 x i8]* %9, i64 0, i64 0
  store i8* %10, i8** %7, align 8
  %11 = load i32*, i32** %6, align 8
  call void @_ZN3c106detail12_str_wrapperIJPKcRKiEE4callB5cxx11ERKS3_S5_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, i8** nonnull align 8 dereferenceable(8) %7, i32* nonnull align 4 dereferenceable(4) %11)
  ret void
}

; Function Attrs: noreturn
declare dso_local void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_RKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8*, i8*, i32, i8*, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32)) #10

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c106Device6is_cpuEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %0) #8 comdat align 2 {
  %2 = alloca %"struct.c10::Device"*, align 8
  store %"struct.c10::Device"* %0, %"struct.c10::Device"** %2, align 8
  %3 = load %"struct.c10::Device"*, %"struct.c10::Device"** %2, align 8
  %4 = getelementptr inbounds %"struct.c10::Device", %"struct.c10::Device"* %3, i32 0, i32 0
  %5 = load i8, i8* %4, align 1
  %6 = icmp eq i8 %5, 0
  ret i1 %6
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c103strIJA42_ciEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, [42 x i8]* nonnull align 1 dereferenceable(42) %1, i32* nonnull align 4 dereferenceable(4) %2) #4 comdat {
  %4 = alloca i8*, align 8
  %5 = alloca [42 x i8]*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i8*, align 8
  %8 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %8, i8** %4, align 8
  store [42 x i8]* %1, [42 x i8]** %5, align 8
  store i32* %2, i32** %6, align 8
  %9 = load [42 x i8]*, [42 x i8]** %5, align 8
  %10 = getelementptr inbounds [42 x i8], [42 x i8]* %9, i64 0, i64 0
  store i8* %10, i8** %7, align 8
  %11 = load i32*, i32** %6, align 8
  call void @_ZN3c106detail12_str_wrapperIJPKcRKiEE4callB5cxx11ERKS3_S5_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, i8** nonnull align 8 dereferenceable(8) %7, i32* nonnull align 4 dereferenceable(4) %11)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail12_str_wrapperIJPKcRKiEE4callB5cxx11ERKS3_S5_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, i8** nonnull align 8 dereferenceable(8) %1, i32* nonnull align 4 dereferenceable(4) %2) #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %4 = alloca i8*, align 8
  %5 = alloca i8**, align 8
  %6 = alloca i32*, align 8
  %7 = alloca %"class.std::__cxx11::basic_ostringstream", align 8
  %8 = alloca i8*, align 8
  %9 = alloca i32, align 4
  %10 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %10, i8** %4, align 8
  store i8** %1, i8*** %5, align 8
  store i32* %2, i32** %6, align 8
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %7)
  %11 = bitcast %"class.std::__cxx11::basic_ostringstream"* %7 to %"class.std::basic_ostream"*
  %12 = load i8**, i8*** %5, align 8
  %13 = load i32*, i32** %6, align 8
  %14 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJiEEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %11, i8** nonnull align 8 dereferenceable(8) %12, i32* nonnull align 4 dereferenceable(4) %13)
          to label %15 unwind label %17

15:                                               ; preds = %3
  invoke void @_ZNKSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEE3strEv(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, %"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %7)
          to label %16 unwind label %17

16:                                               ; preds = %15
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %7) #3
  ret void

17:                                               ; preds = %15, %3
  %18 = landingpad { i8*, i32 }
          cleanup
  %19 = extractvalue { i8*, i32 } %18, 0
  store i8* %19, i8** %8, align 8
  %20 = extractvalue { i8*, i32 } %18, 1
  store i32 %20, i32* %9, align 4
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %7) #3
  br label %21

21:                                               ; preds = %17
  %22 = load i8*, i8** %8, align 8
  %23 = load i32, i32* %9, align 4
  %24 = insertvalue { i8*, i32 } undef, i8* %22, 0
  %25 = insertvalue { i8*, i32 } %24, i32 %23, 1
  resume { i8*, i32 } %25
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJiEEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8** nonnull align 8 dereferenceable(8) %1, i32* nonnull align 4 dereferenceable(4) %2) #4 comdat {
  %4 = alloca %"class.std::basic_ostream"*, align 8
  %5 = alloca i8**, align 8
  %6 = alloca i32*, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %4, align 8
  store i8** %1, i8*** %5, align 8
  store i32* %2, i32** %6, align 8
  %7 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %4, align 8
  %8 = load i8**, i8*** %5, align 8
  %9 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %7, i8** nonnull align 8 dereferenceable(8) %8)
  %10 = load i32*, i32** %6, align 8
  %11 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIiEERSoS2_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %9, i32* nonnull align 4 dereferenceable(4) %10)
  ret %"class.std::basic_ostream"* %11
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIiEERSoS2_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i32* nonnull align 4 dereferenceable(4) %1) #4 comdat {
  %3 = alloca %"class.std::basic_ostream"*, align 8
  %4 = alloca i32*, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %3, align 8
  store i32* %1, i32** %4, align 8
  %5 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %3, align 8
  %6 = load i32*, i32** %4, align 8
  %7 = load i32, i32* %6, align 4
  %8 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %5, i32 %7)
  %9 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %3, align 8
  ret %"class.std::basic_ostream"* %9
}

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i32) #1

; Function Attrs: noreturn
declare dso_local void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8*, i8*, i32, i8*) #10

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail12_str_wrapperIJEE4callEv() #8 comdat align 2 {
  ret void
}

declare dso_local i32 @_ZN3c104cuda9GetDeviceEPa(i8*) #1

declare dso_local void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32, i8*, i8*, i32, i1 zeroext) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl24DeviceGuardImplInterfaceC2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.c10::Allocator"*, align 8
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %2, align 8
  %3 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %2, align 8
  %4 = bitcast %"struct.c10::Allocator"* %3 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [25 x i8*] }, { [25 x i8*] }* @_ZTVN3c104impl24DeviceGuardImplInterfaceE, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %4, align 8
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local signext i8 @_ZNK3c104cuda4impl13CUDAGuardImpl4typeEv(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #8 comdat align 2 {
  %2 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %3 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  ret i8 1
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda4impl13CUDAGuardImpl9setDeviceENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i16 %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::Device", align 1
  %4 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %5 = alloca %"class.std::ios_base::Init", align 1
  %6 = alloca %"class.std::ios_base::Init", align 1
  %7 = alloca i32, align 4
  %8 = bitcast %"struct.c10::Device"* %3 to i16*
  store i16 %1, i16* %8, align 1
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  %9 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  %10 = call zeroext i1 @_ZNK3c106Device7is_cudaEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %3) #3
  br i1 %10, label %12, label %11

11:                                               ; preds = %2
  call void @_ZN3c103strIJEEEDcDpRKT_()
  call void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_NS0_22CompileTimeEmptyStringE(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl9setDeviceENS_6DeviceE, i64 0, i64 0), i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i32 53, i8* getelementptr inbounds ([189 x i8], [189 x i8]* @.str.20, i64 0, i64 0)) #25
  unreachable

12:                                               ; preds = %2
  br label %13

13:                                               ; preds = %12
  %14 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %3) #3
  %15 = call i32 @_ZN3c104cuda9SetDeviceEa(i8 signext %14)
  store i32 %15, i32* %7, align 4
  %16 = load i32, i32* %7, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %16, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl9setDeviceENS_6DeviceE, i64 0, i64 0), i32 54, i1 zeroext true)
  br label %17

17:                                               ; preds = %13
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104cuda4impl13CUDAGuardImpl9getStreamENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i16 %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"class.c10::Stream", align 8
  %4 = alloca %"struct.c10::Device", align 1
  %5 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %6 = alloca %"class.c10::cuda::CUDAStream", align 8
  %7 = bitcast %"struct.c10::Device"* %4 to i16*
  store i16 %1, i16* %7, align 1
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %5, align 8
  %8 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %5, align 8
  %9 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %4) #3
  %10 = call { i64, i64 } @_ZN3c104cuda20getCurrentCUDAStreamEa(i8 signext %9)
  %11 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %6, i32 0, i32 0
  %12 = bitcast %"class.c10::Stream"* %11 to { i64, i64 }*
  %13 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %12, i32 0, i32 0
  %14 = extractvalue { i64, i64 } %10, 0
  store i64 %14, i64* %13, align 8
  %15 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %12, i32 0, i32 1
  %16 = extractvalue { i64, i64 } %10, 1
  store i64 %16, i64* %15, align 8
  %17 = call { i64, i64 } @_ZNK3c104cuda10CUDAStream6unwrapEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %6)
  %18 = bitcast %"class.c10::Stream"* %3 to { i64, i64 }*
  %19 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %18, i32 0, i32 0
  %20 = extractvalue { i64, i64 } %17, 0
  store i64 %20, i64* %19, align 8
  %21 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %18, i32 0, i32 1
  %22 = extractvalue { i64, i64 } %17, 1
  store i64 %22, i64* %21, align 8
  %23 = bitcast %"class.c10::Stream"* %3 to { i64, i64 }*
  %24 = load { i64, i64 }, { i64, i64 }* %23, align 8
  ret { i64, i64 } %24
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104cuda4impl13CUDAGuardImpl16getDefaultStreamENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i16 %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"class.c10::Stream", align 8
  %4 = alloca %"struct.c10::Device", align 1
  %5 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %6 = alloca %"class.c10::cuda::CUDAStream", align 8
  %7 = bitcast %"struct.c10::Device"* %4 to i16*
  store i16 %1, i16* %7, align 1
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %5, align 8
  %8 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %5, align 8
  %9 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %4) #3
  %10 = call { i64, i64 } @_ZN3c104cuda20getDefaultCUDAStreamEa(i8 signext %9)
  %11 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %6, i32 0, i32 0
  %12 = bitcast %"class.c10::Stream"* %11 to { i64, i64 }*
  %13 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %12, i32 0, i32 0
  %14 = extractvalue { i64, i64 } %10, 0
  store i64 %14, i64* %13, align 8
  %15 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %12, i32 0, i32 1
  %16 = extractvalue { i64, i64 } %10, 1
  store i64 %16, i64* %15, align 8
  %17 = call { i64, i64 } @_ZNK3c104cuda10CUDAStreamcvNS_6StreamEEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %6)
  %18 = bitcast %"class.c10::Stream"* %3 to { i64, i64 }*
  %19 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %18, i32 0, i32 0
  %20 = extractvalue { i64, i64 } %17, 0
  store i64 %20, i64* %19, align 8
  %21 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %18, i32 0, i32 1
  %22 = extractvalue { i64, i64 } %17, 1
  store i64 %22, i64* %21, align 8
  %23 = bitcast %"class.c10::Stream"* %3 to { i64, i64 }*
  %24 = load { i64, i64 }, { i64, i64 }* %23, align 8
  ret { i64, i64 } %24
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104cuda4impl13CUDAGuardImpl23getStreamFromGlobalPoolENS_6DeviceEb(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i16 %1, i1 zeroext %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"class.c10::Stream", align 8
  %5 = alloca %"struct.c10::Device", align 1
  %6 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %7 = alloca i8, align 1
  %8 = alloca %"class.c10::cuda::CUDAStream", align 8
  %9 = bitcast %"struct.c10::Device"* %5 to i16*
  store i16 %1, i16* %9, align 1
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %6, align 8
  %10 = zext i1 %2 to i8
  store i8 %10, i8* %7, align 1
  %11 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %6, align 8
  %12 = load i8, i8* %7, align 1
  %13 = trunc i8 %12 to i1
  %14 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %5) #3
  %15 = call { i64, i64 } @_ZN3c104cuda17getStreamFromPoolEba(i1 zeroext %13, i8 signext %14)
  %16 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %8, i32 0, i32 0
  %17 = bitcast %"class.c10::Stream"* %16 to { i64, i64 }*
  %18 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %17, i32 0, i32 0
  %19 = extractvalue { i64, i64 } %15, 0
  store i64 %19, i64* %18, align 8
  %20 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %17, i32 0, i32 1
  %21 = extractvalue { i64, i64 } %15, 1
  store i64 %21, i64* %20, align 8
  %22 = call { i64, i64 } @_ZNK3c104cuda10CUDAStreamcvNS_6StreamEEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %8)
  %23 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %24 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %23, i32 0, i32 0
  %25 = extractvalue { i64, i64 } %22, 0
  store i64 %25, i64* %24, align 8
  %26 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %23, i32 0, i32 1
  %27 = extractvalue { i64, i64 } %22, 1
  store i64 %27, i64* %26, align 8
  %28 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %29 = load { i64, i64 }, { i64, i64 }* %28, align 8
  ret { i64, i64 } %29
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104cuda4impl13CUDAGuardImpl12getNewStreamENS_6DeviceEi(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i16 %1, i32 %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"class.c10::Stream", align 8
  %5 = alloca %"struct.c10::Device", align 1
  %6 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %"class.c10::cuda::CUDAStream", align 8
  %9 = bitcast %"struct.c10::Device"* %5 to i16*
  store i16 %1, i16* %9, align 1
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %6, align 8
  store i32 %2, i32* %7, align 4
  %10 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %6, align 8
  %11 = load i32, i32* %7, align 4
  %12 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %5) #3
  %13 = call { i64, i64 } @_ZN3c104cuda17getStreamFromPoolEia(i32 %11, i8 signext %12)
  %14 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %8, i32 0, i32 0
  %15 = bitcast %"class.c10::Stream"* %14 to { i64, i64 }*
  %16 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %15, i32 0, i32 0
  %17 = extractvalue { i64, i64 } %13, 0
  store i64 %17, i64* %16, align 8
  %18 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %15, i32 0, i32 1
  %19 = extractvalue { i64, i64 } %13, 1
  store i64 %19, i64* %18, align 8
  %20 = call { i64, i64 } @_ZNK3c104cuda10CUDAStreamcvNS_6StreamEEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %8)
  %21 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %22 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %21, i32 0, i32 0
  %23 = extractvalue { i64, i64 } %20, 0
  store i64 %23, i64* %22, align 8
  %24 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %21, i32 0, i32 1
  %25 = extractvalue { i64, i64 } %20, 1
  store i64 %25, i64* %24, align 8
  %26 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %27 = load { i64, i64 }, { i64, i64 }* %26, align 8
  ret { i64, i64 } %27
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104cuda4impl13CUDAGuardImpl14exchangeStreamENS_6StreamE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i64 %1, i64 %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"class.c10::Stream", align 8
  %5 = alloca %"class.c10::Stream", align 8
  %6 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %7 = alloca %"class.c10::cuda::CUDAStream", align 8
  %8 = alloca %"class.c10::Stream", align 8
  %9 = alloca %"class.c10::cuda::CUDAStream", align 8
  %10 = alloca %"struct.c10::Device", align 1
  %11 = alloca %"class.c10::cuda::CUDAStream", align 8
  %12 = bitcast %"class.c10::Stream"* %5 to { i64, i64 }*
  %13 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %12, i32 0, i32 0
  store i64 %1, i64* %13, align 8
  %14 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %12, i32 0, i32 1
  store i64 %2, i64* %14, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %6, align 8
  %15 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %6, align 8
  %16 = bitcast %"class.c10::Stream"* %8 to i8*
  %17 = bitcast %"class.c10::Stream"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %16, i8* align 8 %17, i64 16, i1 false)
  %18 = bitcast %"class.c10::Stream"* %8 to { i64, i64 }*
  %19 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %18, i32 0, i32 0
  %20 = load i64, i64* %19, align 8
  %21 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %18, i32 0, i32 1
  %22 = load i64, i64* %21, align 8
  call void @_ZN3c104cuda10CUDAStreamC2ENS_6StreamE(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %7, i64 %20, i64 %22)
  %23 = call i16 @_ZNK3c106Stream6deviceEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %5) #3
  %24 = bitcast %"struct.c10::Device"* %10 to i16*
  store i16 %23, i16* %24, align 1
  %25 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %10) #3
  %26 = call { i64, i64 } @_ZN3c104cuda20getCurrentCUDAStreamEa(i8 signext %25)
  %27 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %9, i32 0, i32 0
  %28 = bitcast %"class.c10::Stream"* %27 to { i64, i64 }*
  %29 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %28, i32 0, i32 0
  %30 = extractvalue { i64, i64 } %26, 0
  store i64 %30, i64* %29, align 8
  %31 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %28, i32 0, i32 1
  %32 = extractvalue { i64, i64 } %26, 1
  store i64 %32, i64* %31, align 8
  %33 = bitcast %"class.c10::cuda::CUDAStream"* %11 to i8*
  %34 = bitcast %"class.c10::cuda::CUDAStream"* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %33, i8* align 8 %34, i64 16, i1 false)
  %35 = bitcast %"class.c10::cuda::CUDAStream"* %11 to { i64, i64 }*
  %36 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %35, i32 0, i32 0
  %37 = load i64, i64* %36, align 8
  %38 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %35, i32 0, i32 1
  %39 = load i64, i64* %38, align 8
  call void @_ZN3c104cuda20setCurrentCUDAStreamENS0_10CUDAStreamE(i64 %37, i64 %39)
  %40 = call { i64, i64 } @_ZNK3c104cuda10CUDAStream6unwrapEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %9)
  %41 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %42 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %41, i32 0, i32 0
  %43 = extractvalue { i64, i64 } %40, 0
  store i64 %43, i64* %42, align 8
  %44 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %41, i32 0, i32 1
  %45 = extractvalue { i64, i64 } %40, 1
  store i64 %45, i64* %44, align 8
  %46 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %47 = load { i64, i64 }, { i64, i64 }* %46, align 8
  ret { i64, i64 } %47
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda4impl13CUDAGuardImpl12destroyEventEPva(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i8* %1, i8 signext %2) unnamed_addr #8 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %4 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  %7 = alloca %struct.CUevent_st*, align 8
  %8 = alloca i8, align 1
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %"class.c10::Warning", align 8
  %12 = alloca %"class.std::variant", align 1
  %13 = alloca %"class.std::ios_base::Init", align 1
  %14 = alloca %"struct.c10::SourceLocation", align 8
  %15 = alloca %"class.std::__cxx11::basic_string", align 8
  %16 = alloca i8*, align 8
  %17 = alloca i8*, align 8
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca %"class.c10::Warning", align 8
  %22 = alloca %"class.std::variant", align 1
  %23 = alloca %"class.std::ios_base::Init", align 1
  %24 = alloca %"struct.c10::SourceLocation", align 8
  %25 = alloca %"class.std::__cxx11::basic_string", align 8
  %26 = alloca i8*, align 8
  %27 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca %"class.c10::Warning", align 8
  %31 = alloca %"class.std::variant", align 1
  %32 = alloca %"class.std::ios_base::Init", align 1
  %33 = alloca %"struct.c10::SourceLocation", align 8
  %34 = alloca %"class.std::__cxx11::basic_string", align 8
  %35 = alloca i8*, align 8
  %36 = alloca i32, align 4
  %37 = alloca i32, align 4
  %38 = alloca %"class.c10::Warning", align 8
  %39 = alloca %"class.std::variant", align 1
  %40 = alloca %"class.std::ios_base::Init", align 1
  %41 = alloca %"struct.c10::SourceLocation", align 8
  %42 = alloca %"class.std::__cxx11::basic_string", align 8
  %43 = alloca i8*, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %44 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  %45 = load i8*, i8** %5, align 8
  %46 = icmp ne i8* %45, null
  br i1 %46, label %48, label %47

47:                                               ; preds = %3
  br label %216

48:                                               ; preds = %3
  %49 = load i8*, i8** %5, align 8
  %50 = bitcast i8* %49 to %struct.CUevent_st*
  store %struct.CUevent_st* %50, %struct.CUevent_st** %7, align 8
  store i8 -1, i8* %8, align 1
  br label %51

51:                                               ; preds = %48
  %52 = invoke i32 @_ZN3c104cuda9GetDeviceEPa(i8* %8)
          to label %53 unwind label %217

53:                                               ; preds = %51
  store i32 %52, i32* %9, align 4
  %54 = load i32, i32* %9, align 4
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %56, label %85

56:                                               ; preds = %53
  %57 = invoke i32 @cudaGetLastError()
          to label %58 unwind label %217

58:                                               ; preds = %56
  store i32 %57, i32* %10, align 4
  call void @_ZNSt7variantIJN3c107Warning11UserWarningENS1_18DeprecationWarningEEEC2IS2_vvS2_vEEOT_(%"class.std::variant"* nonnull align 1 dereferenceable(2) %12, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %13) #3
  %59 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %14, i32 0, i32 0
  store i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl12destroyEventEPva, i64 0, i64 0), i8** %59, align 8
  %60 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %14, i32 0, i32 1
  store i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8** %60, align 8
  %61 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %14, i32 0, i32 2
  store i32 112, i32* %61, align 8
  %62 = load i32, i32* %9, align 4
  %63 = invoke i8* @cudaGetErrorString(i32 %62)
          to label %64 unwind label %217

64:                                               ; preds = %58
  store i8* %63, i8** %16, align 8
  invoke void @_ZN3c103strIJA15_cPKcEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %15, [15 x i8]* nonnull align 1 dereferenceable(15) @.str.7, i8** nonnull align 8 dereferenceable(8) %16)
          to label %65 unwind label %217

65:                                               ; preds = %64
  %66 = getelementptr inbounds %"class.std::variant", %"class.std::variant"* %12, i32 0, i32 0
  %67 = getelementptr inbounds %"struct.std::__detail::__variant::_Variant_base", %"struct.std::__detail::__variant::_Variant_base"* %66, i32 0, i32 0
  %68 = getelementptr inbounds %"struct.std::__detail::__variant::_Move_assign_base", %"struct.std::__detail::__variant::_Move_assign_base"* %67, i32 0, i32 0
  %69 = getelementptr inbounds %"struct.std::__detail::__variant::_Copy_assign_base", %"struct.std::__detail::__variant::_Copy_assign_base"* %68, i32 0, i32 0
  %70 = getelementptr inbounds %"struct.std::__detail::__variant::_Move_ctor_base", %"struct.std::__detail::__variant::_Move_ctor_base"* %69, i32 0, i32 0
  %71 = getelementptr inbounds %"struct.std::__detail::__variant::_Copy_ctor_base", %"struct.std::__detail::__variant::_Copy_ctor_base"* %70, i32 0, i32 0
  %72 = bitcast %"struct.std::__detail::__variant::_Variant_storage"* %71 to i16*
  %73 = load i16, i16* %72, align 1
  invoke void @_ZN3c107WarningC1ESt7variantIJNS0_11UserWarningENS0_18DeprecationWarningEEERKNS_14SourceLocationENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEb(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %11, i16 %73, %"struct.c10::SourceLocation"* nonnull align 8 dereferenceable(24) %14, %"class.std::__cxx11::basic_string"* %15, i1 zeroext false)
          to label %74 unwind label %76

74:                                               ; preds = %65
  invoke void @_ZN3c104warnERKNS_7WarningE(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %11)
          to label %75 unwind label %80

75:                                               ; preds = %74
  call void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %11) #3
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %15) #3
  br label %85

76:                                               ; preds = %65
  %77 = landingpad { i8*, i32 }
          catch i8* null
  %78 = extractvalue { i8*, i32 } %77, 0
  store i8* %78, i8** %17, align 8
  %79 = extractvalue { i8*, i32 } %77, 1
  store i32 %79, i32* %18, align 4
  br label %84

80:                                               ; preds = %74
  %81 = landingpad { i8*, i32 }
          catch i8* null
  %82 = extractvalue { i8*, i32 } %81, 0
  store i8* %82, i8** %17, align 8
  %83 = extractvalue { i8*, i32 } %81, 1
  store i32 %83, i32* %18, align 4
  call void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %11) #3
  br label %84

84:                                               ; preds = %80, %76
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %15) #3
  br label %220

85:                                               ; preds = %75, %53
  br label %86

86:                                               ; preds = %85
  br label %87

87:                                               ; preds = %86
  br label %88

88:                                               ; preds = %87
  %89 = load i8, i8* %6, align 1
  %90 = invoke i32 @_ZN3c104cuda9SetDeviceEa(i8 signext %89)
          to label %91 unwind label %217

91:                                               ; preds = %88
  store i32 %90, i32* %19, align 4
  %92 = load i32, i32* %19, align 4
  %93 = icmp ne i32 %92, 0
  br i1 %93, label %94, label %123

94:                                               ; preds = %91
  %95 = invoke i32 @cudaGetLastError()
          to label %96 unwind label %217

96:                                               ; preds = %94
  store i32 %95, i32* %20, align 4
  call void @_ZNSt7variantIJN3c107Warning11UserWarningENS1_18DeprecationWarningEEEC2IS2_vvS2_vEEOT_(%"class.std::variant"* nonnull align 1 dereferenceable(2) %22, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %23) #3
  %97 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %24, i32 0, i32 0
  store i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl12destroyEventEPva, i64 0, i64 0), i8** %97, align 8
  %98 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %24, i32 0, i32 1
  store i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8** %98, align 8
  %99 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %24, i32 0, i32 2
  store i32 113, i32* %99, align 8
  %100 = load i32, i32* %19, align 4
  %101 = invoke i8* @cudaGetErrorString(i32 %100)
          to label %102 unwind label %217

102:                                              ; preds = %96
  store i8* %101, i8** %26, align 8
  invoke void @_ZN3c103strIJA15_cPKcEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %25, [15 x i8]* nonnull align 1 dereferenceable(15) @.str.7, i8** nonnull align 8 dereferenceable(8) %26)
          to label %103 unwind label %217

103:                                              ; preds = %102
  %104 = getelementptr inbounds %"class.std::variant", %"class.std::variant"* %22, i32 0, i32 0
  %105 = getelementptr inbounds %"struct.std::__detail::__variant::_Variant_base", %"struct.std::__detail::__variant::_Variant_base"* %104, i32 0, i32 0
  %106 = getelementptr inbounds %"struct.std::__detail::__variant::_Move_assign_base", %"struct.std::__detail::__variant::_Move_assign_base"* %105, i32 0, i32 0
  %107 = getelementptr inbounds %"struct.std::__detail::__variant::_Copy_assign_base", %"struct.std::__detail::__variant::_Copy_assign_base"* %106, i32 0, i32 0
  %108 = getelementptr inbounds %"struct.std::__detail::__variant::_Move_ctor_base", %"struct.std::__detail::__variant::_Move_ctor_base"* %107, i32 0, i32 0
  %109 = getelementptr inbounds %"struct.std::__detail::__variant::_Copy_ctor_base", %"struct.std::__detail::__variant::_Copy_ctor_base"* %108, i32 0, i32 0
  %110 = bitcast %"struct.std::__detail::__variant::_Variant_storage"* %109 to i16*
  %111 = load i16, i16* %110, align 1
  invoke void @_ZN3c107WarningC1ESt7variantIJNS0_11UserWarningENS0_18DeprecationWarningEEERKNS_14SourceLocationENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEb(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %21, i16 %111, %"struct.c10::SourceLocation"* nonnull align 8 dereferenceable(24) %24, %"class.std::__cxx11::basic_string"* %25, i1 zeroext false)
          to label %112 unwind label %114

112:                                              ; preds = %103
  invoke void @_ZN3c104warnERKNS_7WarningE(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %21)
          to label %113 unwind label %118

113:                                              ; preds = %112
  call void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %21) #3
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %25) #3
  br label %123

114:                                              ; preds = %103
  %115 = landingpad { i8*, i32 }
          catch i8* null
  %116 = extractvalue { i8*, i32 } %115, 0
  store i8* %116, i8** %17, align 8
  %117 = extractvalue { i8*, i32 } %115, 1
  store i32 %117, i32* %18, align 4
  br label %122

118:                                              ; preds = %112
  %119 = landingpad { i8*, i32 }
          catch i8* null
  %120 = extractvalue { i8*, i32 } %119, 0
  store i8* %120, i8** %17, align 8
  %121 = extractvalue { i8*, i32 } %119, 1
  store i32 %121, i32* %18, align 4
  call void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %21) #3
  br label %122

122:                                              ; preds = %118, %114
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %25) #3
  br label %220

123:                                              ; preds = %113, %91
  br label %124

124:                                              ; preds = %123
  br label %125

125:                                              ; preds = %124
  %126 = invoke %"struct.c10::impl::PyInterpreter"* @_ZN3c104impl8GPUTrace9get_traceEv()
          to label %127 unwind label %217

127:                                              ; preds = %125
  store %"struct.c10::impl::PyInterpreter"* %126, %"struct.c10::impl::PyInterpreter"** %27, align 8
  %128 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %27, align 8
  %129 = icmp ne %"struct.c10::impl::PyInterpreter"* %128, null
  br i1 %129, label %130, label %140

130:                                              ; preds = %127
  %131 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %27, align 8
  %132 = call %"struct.c10::Allocator"* @_ZNK3c104impl13PyInterpreterptEv(%"struct.c10::impl::PyInterpreter"* nonnull align 8 dereferenceable(8) %131) #3
  %133 = load %struct.CUevent_st*, %struct.CUevent_st** %7, align 8
  %134 = ptrtoint %struct.CUevent_st* %133 to i64
  %135 = bitcast %"struct.c10::Allocator"* %132 to void (%"struct.c10::Allocator"*, i8, i64)***
  %136 = load void (%"struct.c10::Allocator"*, i8, i64)**, void (%"struct.c10::Allocator"*, i8, i64)*** %135, align 8
  %137 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8, i64)*, void (%"struct.c10::Allocator"*, i8, i64)** %136, i64 25
  %138 = load void (%"struct.c10::Allocator"*, i8, i64)*, void (%"struct.c10::Allocator"*, i8, i64)** %137, align 8
  invoke void %138(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %132, i8 signext 1, i64 %134)
          to label %139 unwind label %217

139:                                              ; preds = %130
  br label %140

140:                                              ; preds = %139, %127
  br label %141

141:                                              ; preds = %140
  %142 = load %struct.CUevent_st*, %struct.CUevent_st** %7, align 8
  %143 = invoke i32 @cudaEventDestroy(%struct.CUevent_st* %142)
          to label %144 unwind label %217

144:                                              ; preds = %141
  store i32 %143, i32* %28, align 4
  %145 = load i32, i32* %28, align 4
  %146 = icmp ne i32 %145, 0
  br i1 %146, label %147, label %176

147:                                              ; preds = %144
  %148 = invoke i32 @cudaGetLastError()
          to label %149 unwind label %217

149:                                              ; preds = %147
  store i32 %148, i32* %29, align 4
  call void @_ZNSt7variantIJN3c107Warning11UserWarningENS1_18DeprecationWarningEEEC2IS2_vvS2_vEEOT_(%"class.std::variant"* nonnull align 1 dereferenceable(2) %31, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %32) #3
  %150 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %33, i32 0, i32 0
  store i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl12destroyEventEPva, i64 0, i64 0), i8** %150, align 8
  %151 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %33, i32 0, i32 1
  store i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8** %151, align 8
  %152 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %33, i32 0, i32 2
  store i32 119, i32* %152, align 8
  %153 = load i32, i32* %28, align 4
  %154 = invoke i8* @cudaGetErrorString(i32 %153)
          to label %155 unwind label %217

155:                                              ; preds = %149
  store i8* %154, i8** %35, align 8
  invoke void @_ZN3c103strIJA15_cPKcEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %34, [15 x i8]* nonnull align 1 dereferenceable(15) @.str.7, i8** nonnull align 8 dereferenceable(8) %35)
          to label %156 unwind label %217

156:                                              ; preds = %155
  %157 = getelementptr inbounds %"class.std::variant", %"class.std::variant"* %31, i32 0, i32 0
  %158 = getelementptr inbounds %"struct.std::__detail::__variant::_Variant_base", %"struct.std::__detail::__variant::_Variant_base"* %157, i32 0, i32 0
  %159 = getelementptr inbounds %"struct.std::__detail::__variant::_Move_assign_base", %"struct.std::__detail::__variant::_Move_assign_base"* %158, i32 0, i32 0
  %160 = getelementptr inbounds %"struct.std::__detail::__variant::_Copy_assign_base", %"struct.std::__detail::__variant::_Copy_assign_base"* %159, i32 0, i32 0
  %161 = getelementptr inbounds %"struct.std::__detail::__variant::_Move_ctor_base", %"struct.std::__detail::__variant::_Move_ctor_base"* %160, i32 0, i32 0
  %162 = getelementptr inbounds %"struct.std::__detail::__variant::_Copy_ctor_base", %"struct.std::__detail::__variant::_Copy_ctor_base"* %161, i32 0, i32 0
  %163 = bitcast %"struct.std::__detail::__variant::_Variant_storage"* %162 to i16*
  %164 = load i16, i16* %163, align 1
  invoke void @_ZN3c107WarningC1ESt7variantIJNS0_11UserWarningENS0_18DeprecationWarningEEERKNS_14SourceLocationENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEb(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %30, i16 %164, %"struct.c10::SourceLocation"* nonnull align 8 dereferenceable(24) %33, %"class.std::__cxx11::basic_string"* %34, i1 zeroext false)
          to label %165 unwind label %167

165:                                              ; preds = %156
  invoke void @_ZN3c104warnERKNS_7WarningE(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %30)
          to label %166 unwind label %171

166:                                              ; preds = %165
  call void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %30) #3
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %34) #3
  br label %176

167:                                              ; preds = %156
  %168 = landingpad { i8*, i32 }
          catch i8* null
  %169 = extractvalue { i8*, i32 } %168, 0
  store i8* %169, i8** %17, align 8
  %170 = extractvalue { i8*, i32 } %168, 1
  store i32 %170, i32* %18, align 4
  br label %175

171:                                              ; preds = %165
  %172 = landingpad { i8*, i32 }
          catch i8* null
  %173 = extractvalue { i8*, i32 } %172, 0
  store i8* %173, i8** %17, align 8
  %174 = extractvalue { i8*, i32 } %172, 1
  store i32 %174, i32* %18, align 4
  call void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %30) #3
  br label %175

175:                                              ; preds = %171, %167
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %34) #3
  br label %220

176:                                              ; preds = %166, %144
  br label %177

177:                                              ; preds = %176
  br label %178

178:                                              ; preds = %177
  br label %179

179:                                              ; preds = %178
  %180 = load i8, i8* %8, align 1
  %181 = invoke i32 @_ZN3c104cuda9SetDeviceEa(i8 signext %180)
          to label %182 unwind label %217

182:                                              ; preds = %179
  store i32 %181, i32* %36, align 4
  %183 = load i32, i32* %36, align 4
  %184 = icmp ne i32 %183, 0
  br i1 %184, label %185, label %214

185:                                              ; preds = %182
  %186 = invoke i32 @cudaGetLastError()
          to label %187 unwind label %217

187:                                              ; preds = %185
  store i32 %186, i32* %37, align 4
  call void @_ZNSt7variantIJN3c107Warning11UserWarningENS1_18DeprecationWarningEEEC2IS2_vvS2_vEEOT_(%"class.std::variant"* nonnull align 1 dereferenceable(2) %39, %"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %40) #3
  %188 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %41, i32 0, i32 0
  store i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl12destroyEventEPva, i64 0, i64 0), i8** %188, align 8
  %189 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %41, i32 0, i32 1
  store i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8** %189, align 8
  %190 = getelementptr inbounds %"struct.c10::SourceLocation", %"struct.c10::SourceLocation"* %41, i32 0, i32 2
  store i32 120, i32* %190, align 8
  %191 = load i32, i32* %36, align 4
  %192 = invoke i8* @cudaGetErrorString(i32 %191)
          to label %193 unwind label %217

193:                                              ; preds = %187
  store i8* %192, i8** %43, align 8
  invoke void @_ZN3c103strIJA15_cPKcEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %42, [15 x i8]* nonnull align 1 dereferenceable(15) @.str.7, i8** nonnull align 8 dereferenceable(8) %43)
          to label %194 unwind label %217

194:                                              ; preds = %193
  %195 = getelementptr inbounds %"class.std::variant", %"class.std::variant"* %39, i32 0, i32 0
  %196 = getelementptr inbounds %"struct.std::__detail::__variant::_Variant_base", %"struct.std::__detail::__variant::_Variant_base"* %195, i32 0, i32 0
  %197 = getelementptr inbounds %"struct.std::__detail::__variant::_Move_assign_base", %"struct.std::__detail::__variant::_Move_assign_base"* %196, i32 0, i32 0
  %198 = getelementptr inbounds %"struct.std::__detail::__variant::_Copy_assign_base", %"struct.std::__detail::__variant::_Copy_assign_base"* %197, i32 0, i32 0
  %199 = getelementptr inbounds %"struct.std::__detail::__variant::_Move_ctor_base", %"struct.std::__detail::__variant::_Move_ctor_base"* %198, i32 0, i32 0
  %200 = getelementptr inbounds %"struct.std::__detail::__variant::_Copy_ctor_base", %"struct.std::__detail::__variant::_Copy_ctor_base"* %199, i32 0, i32 0
  %201 = bitcast %"struct.std::__detail::__variant::_Variant_storage"* %200 to i16*
  %202 = load i16, i16* %201, align 1
  invoke void @_ZN3c107WarningC1ESt7variantIJNS0_11UserWarningENS0_18DeprecationWarningEEERKNS_14SourceLocationENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEb(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %38, i16 %202, %"struct.c10::SourceLocation"* nonnull align 8 dereferenceable(24) %41, %"class.std::__cxx11::basic_string"* %42, i1 zeroext false)
          to label %203 unwind label %205

203:                                              ; preds = %194
  invoke void @_ZN3c104warnERKNS_7WarningE(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %38)
          to label %204 unwind label %209

204:                                              ; preds = %203
  call void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %38) #3
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %42) #3
  br label %214

205:                                              ; preds = %194
  %206 = landingpad { i8*, i32 }
          catch i8* null
  %207 = extractvalue { i8*, i32 } %206, 0
  store i8* %207, i8** %17, align 8
  %208 = extractvalue { i8*, i32 } %206, 1
  store i32 %208, i32* %18, align 4
  br label %213

209:                                              ; preds = %203
  %210 = landingpad { i8*, i32 }
          catch i8* null
  %211 = extractvalue { i8*, i32 } %210, 0
  store i8* %211, i8** %17, align 8
  %212 = extractvalue { i8*, i32 } %210, 1
  store i32 %212, i32* %18, align 4
  call void @_ZN3c107WarningD2Ev(%"class.c10::Warning"* nonnull align 8 dereferenceable(65) %38) #3
  br label %213

213:                                              ; preds = %209, %205
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %42) #3
  br label %220

214:                                              ; preds = %204, %182
  br label %215

215:                                              ; preds = %214
  br label %216

216:                                              ; preds = %47, %215
  ret void

217:                                              ; preds = %193, %187, %185, %179, %155, %149, %147, %141, %130, %125, %102, %96, %94, %88, %64, %58, %56, %51
  %218 = landingpad { i8*, i32 }
          catch i8* null
  %219 = extractvalue { i8*, i32 } %218, 0
  call void @__clang_call_terminate(i8* %219) #26
  unreachable

220:                                              ; preds = %213, %175, %122, %84
  %221 = load i8*, i8** %17, align 8
  call void @__clang_call_terminate(i8* %221) #26
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda4impl13CUDAGuardImpl6recordEPPvRKNS_6StreamEaNS_9EventFlagE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i8** %1, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %2, i8 signext %3, i32 %4) unnamed_addr #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %6 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %7 = alloca i8**, align 8
  %8 = alloca %"class.c10::Stream"*, align 8
  %9 = alloca i8, align 1
  %10 = alloca i32, align 4
  %11 = alloca %"class.std::__cxx11::basic_string", align 8
  %12 = alloca i8, align 1
  %13 = alloca i8*, align 8
  %14 = alloca i32, align 4
  %15 = alloca %struct.CUevent_st*, align 8
  %16 = alloca %"class.c10::cuda::CUDAStream", align 8
  %17 = alloca %"class.c10::Stream", align 8
  %18 = alloca %"struct.c10::Device", align 1
  %19 = alloca %"struct.c10::Device", align 1
  %20 = alloca i32, align 4
  %21 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  %22 = alloca %"struct.c10::Device", align 1
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %6, align 8
  store i8** %1, i8*** %7, align 8
  store %"class.c10::Stream"* %2, %"class.c10::Stream"** %8, align 8
  store i8 %3, i8* %9, align 1
  store i32 %4, i32* %10, align 4
  %23 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %6, align 8
  %24 = load i8, i8* %9, align 1
  %25 = sext i8 %24 to i32
  %26 = icmp eq i32 %25, -1
  br i1 %26, label %42, label %27

27:                                               ; preds = %5
  %28 = load i8, i8* %9, align 1
  %29 = sext i8 %28 to i32
  %30 = load %"class.c10::Stream"*, %"class.c10::Stream"** %8, align 8
  %31 = call signext i8 @_ZNK3c106Stream12device_indexEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %30) #3
  %32 = sext i8 %31 to i32
  %33 = icmp eq i32 %29, %32
  br i1 %33, label %42, label %34

34:                                               ; preds = %27
  %35 = load %"class.c10::Stream"*, %"class.c10::Stream"** %8, align 8
  %36 = call signext i8 @_ZNK3c106Stream12device_indexEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %35) #3
  store i8 %36, i8* %12, align 1
  call void @_ZN3c106detail17torchCheckMsgImplIJA20_caA49_caA2_cEEEDcPKcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %11, i8* getelementptr inbounds ([194 x i8], [194 x i8]* @.str.23, i64 0, i64 0), [20 x i8]* nonnull align 1 dereferenceable(20) @.str.24, i8* nonnull align 1 dereferenceable(1) %9, [49 x i8]* nonnull align 1 dereferenceable(49) @.str.25, i8* nonnull align 1 dereferenceable(1) %12, [2 x i8]* nonnull align 1 dereferenceable(2) @.str.26)
  invoke void @_ZN3c106detail14torchCheckFailEPKcS2_jRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface6recordEPPvRKNS_6StreamEaNS_9EventFlagE, i64 0, i64 0), i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i32 134, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %11) #25
          to label %37 unwind label %38

37:                                               ; preds = %34
  unreachable

38:                                               ; preds = %34
  %39 = landingpad { i8*, i32 }
          cleanup
  %40 = extractvalue { i8*, i32 } %39, 0
  store i8* %40, i8** %13, align 8
  %41 = extractvalue { i8*, i32 } %39, 1
  store i32 %41, i32* %14, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %11) #3
  br label %94

42:                                               ; preds = %27, %5
  %43 = load i8**, i8*** %7, align 8
  %44 = load i8*, i8** %43, align 8
  %45 = bitcast i8* %44 to %struct.CUevent_st*
  store %struct.CUevent_st* %45, %struct.CUevent_st** %15, align 8
  %46 = load %"class.c10::Stream"*, %"class.c10::Stream"** %8, align 8
  %47 = bitcast %"class.c10::Stream"* %17 to i8*
  %48 = bitcast %"class.c10::Stream"* %46 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %47, i8* align 8 %48, i64 16, i1 false)
  %49 = bitcast %"class.c10::Stream"* %17 to { i64, i64 }*
  %50 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %49, i32 0, i32 0
  %51 = load i64, i64* %50, align 8
  %52 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %49, i32 0, i32 1
  %53 = load i64, i64* %52, align 8
  call void @_ZN3c104cuda10CUDAStreamC2ENS_6StreamE(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %16, i64 %51, i64 %53)
  %54 = call i16 @_ZNK3c104cuda4impl13CUDAGuardImpl9getDeviceEv(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %23)
  %55 = bitcast %"struct.c10::Device"* %18 to i16*
  store i16 %54, i16* %55, align 1
  %56 = load %"class.c10::Stream"*, %"class.c10::Stream"** %8, align 8
  %57 = call i16 @_ZNK3c106Stream6deviceEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %56) #3
  %58 = bitcast %"struct.c10::Device"* %19 to i16*
  store i16 %57, i16* %58, align 1
  %59 = bitcast %"struct.c10::Device"* %19 to i16*
  %60 = load i16, i16* %59, align 1
  call void @_ZNK3c104cuda4impl13CUDAGuardImpl9setDeviceENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %23, i16 %60)
  %61 = load %struct.CUevent_st*, %struct.CUevent_st** %15, align 8
  %62 = icmp ne %struct.CUevent_st* %61, null
  br i1 %62, label %65, label %63

63:                                               ; preds = %42
  %64 = load i32, i32* %10, align 4
  call void @_ZNK3c104cuda4impl13CUDAGuardImpl11createEventEPP10CUevent_stNS_9EventFlagE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %23, %struct.CUevent_st** %15, i32 %64)
  br label %65

65:                                               ; preds = %63, %42
  br label %66

66:                                               ; preds = %65
  %67 = load %struct.CUevent_st*, %struct.CUevent_st** %15, align 8
  %68 = call %struct.CUstream_st* @_ZNK3c104cuda10CUDAStreamcvP11CUstream_stEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %16)
  %69 = call i32 @cudaEventRecord(%struct.CUevent_st* %67, %struct.CUstream_st* %68)
  store i32 %69, i32* %20, align 4
  %70 = load i32, i32* %20, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %70, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface6recordEPPvRKNS_6StreamEaNS_9EventFlagE, i64 0, i64 0), i32 146, i1 zeroext true)
  br label %71

71:                                               ; preds = %66
  %72 = load %struct.CUevent_st*, %struct.CUevent_st** %15, align 8
  %73 = bitcast %struct.CUevent_st* %72 to i8*
  %74 = load i8**, i8*** %7, align 8
  store i8* %73, i8** %74, align 8
  %75 = call %"struct.c10::impl::PyInterpreter"* @_ZN3c104impl8GPUTrace9get_traceEv()
  store %"struct.c10::impl::PyInterpreter"* %75, %"struct.c10::impl::PyInterpreter"** %21, align 8
  %76 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %21, align 8
  %77 = icmp ne %"struct.c10::impl::PyInterpreter"* %76, null
  br i1 %77, label %78, label %89

78:                                               ; preds = %71
  %79 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %21, align 8
  %80 = call %"struct.c10::Allocator"* @_ZNK3c104impl13PyInterpreterptEv(%"struct.c10::impl::PyInterpreter"* nonnull align 8 dereferenceable(8) %79) #3
  %81 = load %struct.CUevent_st*, %struct.CUevent_st** %15, align 8
  %82 = ptrtoint %struct.CUevent_st* %81 to i64
  %83 = call %struct.CUstream_st* @_ZNK3c104cuda10CUDAStream6streamEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %16)
  %84 = ptrtoint %struct.CUstream_st* %83 to i64
  %85 = bitcast %"struct.c10::Allocator"* %80 to void (%"struct.c10::Allocator"*, i8, i64, i64)***
  %86 = load void (%"struct.c10::Allocator"*, i8, i64, i64)**, void (%"struct.c10::Allocator"*, i8, i64, i64)*** %85, align 8
  %87 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8, i64, i64)*, void (%"struct.c10::Allocator"*, i8, i64, i64)** %86, i64 26
  %88 = load void (%"struct.c10::Allocator"*, i8, i64, i64)*, void (%"struct.c10::Allocator"*, i8, i64, i64)** %87, align 8
  call void %88(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %80, i8 signext 1, i64 %82, i64 %84)
  br label %89

89:                                               ; preds = %78, %71
  %90 = bitcast %"struct.c10::Device"* %22 to i8*
  %91 = bitcast %"struct.c10::Device"* %18 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %90, i8* align 1 %91, i64 2, i1 false)
  %92 = bitcast %"struct.c10::Device"* %22 to i16*
  %93 = load i16, i16* %92, align 1
  call void @_ZNK3c104cuda4impl13CUDAGuardImpl9setDeviceENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %23, i16 %93)
  ret void

94:                                               ; preds = %38
  %95 = load i8*, i8** %13, align 8
  %96 = load i32, i32* %14, align 4
  %97 = insertvalue { i8*, i32 } undef, i8* %95, 0
  %98 = insertvalue { i8*, i32 } %97, i32 %96, 1
  resume { i8*, i32 } %98
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda4impl13CUDAGuardImpl5blockEPvRKNS_6StreamE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i8* %1, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %"class.c10::Stream"*, align 8
  %7 = alloca %struct.CUevent_st*, align 8
  %8 = alloca %"class.c10::cuda::CUDAStream", align 8
  %9 = alloca %"class.c10::Stream", align 8
  %10 = alloca %"struct.c10::Device", align 1
  %11 = alloca %"struct.c10::Device", align 1
  %12 = alloca i32, align 4
  %13 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  %14 = alloca %"struct.c10::Device", align 1
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  store i8* %1, i8** %5, align 8
  store %"class.c10::Stream"* %2, %"class.c10::Stream"** %6, align 8
  %15 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  %16 = load i8*, i8** %5, align 8
  %17 = icmp ne i8* %16, null
  br i1 %17, label %19, label %18

18:                                               ; preds = %3
  br label %62

19:                                               ; preds = %3
  %20 = load i8*, i8** %5, align 8
  %21 = bitcast i8* %20 to %struct.CUevent_st*
  store %struct.CUevent_st* %21, %struct.CUevent_st** %7, align 8
  %22 = load %"class.c10::Stream"*, %"class.c10::Stream"** %6, align 8
  %23 = bitcast %"class.c10::Stream"* %9 to i8*
  %24 = bitcast %"class.c10::Stream"* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %23, i8* align 8 %24, i64 16, i1 false)
  %25 = bitcast %"class.c10::Stream"* %9 to { i64, i64 }*
  %26 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %25, i32 0, i32 0
  %27 = load i64, i64* %26, align 8
  %28 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %25, i32 0, i32 1
  %29 = load i64, i64* %28, align 8
  call void @_ZN3c104cuda10CUDAStreamC2ENS_6StreamE(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %8, i64 %27, i64 %29)
  %30 = call i16 @_ZNK3c104cuda4impl13CUDAGuardImpl9getDeviceEv(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %15)
  %31 = bitcast %"struct.c10::Device"* %10 to i16*
  store i16 %30, i16* %31, align 1
  %32 = load %"class.c10::Stream"*, %"class.c10::Stream"** %6, align 8
  %33 = call i16 @_ZNK3c106Stream6deviceEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %32) #3
  %34 = bitcast %"struct.c10::Device"* %11 to i16*
  store i16 %33, i16* %34, align 1
  %35 = bitcast %"struct.c10::Device"* %11 to i16*
  %36 = load i16, i16* %35, align 1
  call void @_ZNK3c104cuda4impl13CUDAGuardImpl9setDeviceENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %15, i16 %36)
  br label %37

37:                                               ; preds = %19
  %38 = call %struct.CUstream_st* @_ZNK3c104cuda10CUDAStreamcvP11CUstream_stEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %8)
  %39 = load %struct.CUevent_st*, %struct.CUevent_st** %7, align 8
  %40 = call i32 @cudaStreamWaitEvent(%struct.CUstream_st* %38, %struct.CUevent_st* %39, i32 0)
  store i32 %40, i32* %12, align 4
  %41 = load i32, i32* %12, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %41, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface5blockEPvRKNS_6StreamE, i64 0, i64 0), i32 171, i1 zeroext true)
  br label %42

42:                                               ; preds = %37
  %43 = call %"struct.c10::impl::PyInterpreter"* @_ZN3c104impl8GPUTrace9get_traceEv()
  store %"struct.c10::impl::PyInterpreter"* %43, %"struct.c10::impl::PyInterpreter"** %13, align 8
  %44 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %13, align 8
  %45 = icmp ne %"struct.c10::impl::PyInterpreter"* %44, null
  br i1 %45, label %46, label %57

46:                                               ; preds = %42
  %47 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %13, align 8
  %48 = call %"struct.c10::Allocator"* @_ZNK3c104impl13PyInterpreterptEv(%"struct.c10::impl::PyInterpreter"* nonnull align 8 dereferenceable(8) %47) #3
  %49 = load %struct.CUevent_st*, %struct.CUevent_st** %7, align 8
  %50 = ptrtoint %struct.CUevent_st* %49 to i64
  %51 = call %struct.CUstream_st* @_ZNK3c104cuda10CUDAStream6streamEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %8)
  %52 = ptrtoint %struct.CUstream_st* %51 to i64
  %53 = bitcast %"struct.c10::Allocator"* %48 to void (%"struct.c10::Allocator"*, i8, i64, i64)***
  %54 = load void (%"struct.c10::Allocator"*, i8, i64, i64)**, void (%"struct.c10::Allocator"*, i8, i64, i64)*** %53, align 8
  %55 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8, i64, i64)*, void (%"struct.c10::Allocator"*, i8, i64, i64)** %54, i64 27
  %56 = load void (%"struct.c10::Allocator"*, i8, i64, i64)*, void (%"struct.c10::Allocator"*, i8, i64, i64)** %55, align 8
  call void %56(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %48, i8 signext 1, i64 %50, i64 %52)
  br label %57

57:                                               ; preds = %46, %42
  %58 = bitcast %"struct.c10::Device"* %14 to i8*
  %59 = bitcast %"struct.c10::Device"* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %58, i8* align 1 %59, i64 2, i1 false)
  %60 = bitcast %"struct.c10::Device"* %14 to i16*
  %61 = load i16, i16* %60, align 1
  call void @_ZNK3c104cuda4impl13CUDAGuardImpl9setDeviceENS_6DeviceE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %15, i16 %61)
  br label %62

62:                                               ; preds = %57, %18
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c104cuda4impl13CUDAGuardImpl10queryEventEPv(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i8* %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca i1, align 1
  %4 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %struct.CUevent_st*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  store i8* %1, i8** %5, align 8
  %9 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  %10 = load i8*, i8** %5, align 8
  %11 = icmp ne i8* %10, null
  br i1 %11, label %13, label %12

12:                                               ; preds = %2
  store i1 true, i1* %3, align 1
  br label %30

13:                                               ; preds = %2
  %14 = load i8*, i8** %5, align 8
  %15 = bitcast i8* %14 to %struct.CUevent_st*
  store %struct.CUevent_st* %15, %struct.CUevent_st** %6, align 8
  %16 = load %struct.CUevent_st*, %struct.CUevent_st** %6, align 8
  %17 = call i32 @cudaEventQuery(%struct.CUevent_st* %16)
  store i32 %17, i32* %7, align 4
  %18 = load i32, i32* %7, align 4
  %19 = icmp ne i32 %18, 600
  br i1 %19, label %20, label %25

20:                                               ; preds = %13
  br label %21

21:                                               ; preds = %20
  %22 = load i32, i32* %7, align 4
  store i32 %22, i32* %8, align 4
  %23 = load i32, i32* %8, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %23, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface10queryEventEPv, i64 0, i64 0), i32 190, i1 zeroext true)
  br label %24

24:                                               ; preds = %21
  br label %27

25:                                               ; preds = %13
  %26 = call i32 @cudaGetLastError()
  br label %27

27:                                               ; preds = %25, %24
  %28 = load i32, i32* %7, align 4
  %29 = icmp eq i32 %28, 0
  store i1 %29, i1* %3, align 1
  br label %30

30:                                               ; preds = %27, %12
  %31 = load i1, i1* %3, align 1
  ret i1 %31
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local signext i8 @_ZNK3c104cuda4impl13CUDAGuardImpl11deviceCountEv(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #8 comdat align 2 {
  %2 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %3 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %4 = call signext i8 @_ZN3c104cuda12device_countEv() #3
  ret i8 %4
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c104cuda4impl13CUDAGuardImpl11queryStreamERKNS_6StreamE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %4 = alloca %"class.c10::Stream"*, align 8
  %5 = alloca %"class.c10::cuda::CUDAStream", align 8
  %6 = alloca %"class.c10::Stream", align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  store %"class.c10::Stream"* %1, %"class.c10::Stream"** %4, align 8
  %7 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  %8 = load %"class.c10::Stream"*, %"class.c10::Stream"** %4, align 8
  %9 = bitcast %"class.c10::Stream"* %6 to i8*
  %10 = bitcast %"class.c10::Stream"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %9, i8* align 8 %10, i64 16, i1 false)
  %11 = bitcast %"class.c10::Stream"* %6 to { i64, i64 }*
  %12 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %11, i32 0, i32 0
  %13 = load i64, i64* %12, align 8
  %14 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %11, i32 0, i32 1
  %15 = load i64, i64* %14, align 8
  call void @_ZN3c104cuda10CUDAStreamC2ENS_6StreamE(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %5, i64 %13, i64 %15)
  %16 = call zeroext i1 @_ZNK3c104cuda10CUDAStream5queryEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %5)
  ret i1 %16
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda4impl13CUDAGuardImpl17synchronizeStreamERKNS_6StreamE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %4 = alloca %"class.c10::Stream"*, align 8
  %5 = alloca %"class.c10::cuda::CUDAStream", align 8
  %6 = alloca %"class.c10::Stream", align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  store %"class.c10::Stream"* %1, %"class.c10::Stream"** %4, align 8
  %7 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  %8 = load %"class.c10::Stream"*, %"class.c10::Stream"** %4, align 8
  %9 = bitcast %"class.c10::Stream"* %6 to i8*
  %10 = bitcast %"class.c10::Stream"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %9, i8* align 8 %10, i64 16, i1 false)
  %11 = bitcast %"class.c10::Stream"* %6 to { i64, i64 }*
  %12 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %11, i32 0, i32 0
  %13 = load i64, i64* %12, align 8
  %14 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %11, i32 0, i32 1
  %15 = load i64, i64* %14, align 8
  call void @_ZN3c104cuda10CUDAStreamC2ENS_6StreamE(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %5, i64 %13, i64 %15)
  call void @_ZNK3c104cuda10CUDAStream11synchronizeEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %5)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda4impl13CUDAGuardImpl16synchronizeEventEPv(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i8* %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca %struct.CUevent_st*, align 8
  %6 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  %7 = alloca i32, align 4
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  store i8* %1, i8** %4, align 8
  %8 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  %9 = load i8*, i8** %4, align 8
  %10 = icmp ne i8* %9, null
  br i1 %10, label %12, label %11

11:                                               ; preds = %2
  br label %32

12:                                               ; preds = %2
  %13 = load i8*, i8** %4, align 8
  %14 = bitcast i8* %13 to %struct.CUevent_st*
  store %struct.CUevent_st* %14, %struct.CUevent_st** %5, align 8
  %15 = call %"struct.c10::impl::PyInterpreter"* @_ZN3c104impl8GPUTrace9get_traceEv()
  store %"struct.c10::impl::PyInterpreter"* %15, %"struct.c10::impl::PyInterpreter"** %6, align 8
  %16 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %6, align 8
  %17 = icmp ne %"struct.c10::impl::PyInterpreter"* %16, null
  br i1 %17, label %18, label %27

18:                                               ; preds = %12
  %19 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %6, align 8
  %20 = call %"struct.c10::Allocator"* @_ZNK3c104impl13PyInterpreterptEv(%"struct.c10::impl::PyInterpreter"* nonnull align 8 dereferenceable(8) %19) #3
  %21 = load %struct.CUevent_st*, %struct.CUevent_st** %5, align 8
  %22 = ptrtoint %struct.CUevent_st* %21 to i64
  %23 = bitcast %"struct.c10::Allocator"* %20 to void (%"struct.c10::Allocator"*, i8, i64)***
  %24 = load void (%"struct.c10::Allocator"*, i8, i64)**, void (%"struct.c10::Allocator"*, i8, i64)*** %23, align 8
  %25 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8, i64)*, void (%"struct.c10::Allocator"*, i8, i64)** %24, i64 33
  %26 = load void (%"struct.c10::Allocator"*, i8, i64)*, void (%"struct.c10::Allocator"*, i8, i64)** %25, align 8
  call void %26(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %20, i8 signext 1, i64 %22)
  br label %27

27:                                               ; preds = %18, %12
  br label %28

28:                                               ; preds = %27
  %29 = load %struct.CUevent_st*, %struct.CUevent_st** %5, align 8
  %30 = call i32 @cudaEventSynchronize(%struct.CUevent_st* %29)
  store i32 %30, i32* %7, align 4
  %31 = load i32, i32* %7, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %31, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface16synchronizeEventEPv, i64 0, i64 0), i32 219, i1 zeroext true)
  br label %32

32:                                               ; preds = %11, %28
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda4impl13CUDAGuardImpl17synchronizeDeviceEa(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i8 signext %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %4 = alloca i8, align 1
  %5 = alloca i8, align 1
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  store i8 %1, i8* %4, align 1
  %11 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %3, align 8
  store i8 -1, i8* %5, align 1
  br label %12

12:                                               ; preds = %2
  %13 = call i32 @_ZN3c104cuda9GetDeviceEPa(i8* %5)
  store i32 %13, i32* %6, align 4
  %14 = load i32, i32* %6, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %14, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface17synchronizeDeviceEa, i64 0, i64 0), i32 225, i1 zeroext true)
  br label %15

15:                                               ; preds = %12
  br label %16

16:                                               ; preds = %15
  %17 = load i8, i8* %4, align 1
  %18 = call i32 @_ZN3c104cuda9SetDeviceEa(i8 signext %17)
  store i32 %18, i32* %7, align 4
  %19 = load i32, i32* %7, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %19, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface17synchronizeDeviceEa, i64 0, i64 0), i32 226, i1 zeroext true)
  br label %20

20:                                               ; preds = %16
  %21 = call %"struct.c10::impl::PyInterpreter"* @_ZN3c104impl8GPUTrace9get_traceEv()
  store %"struct.c10::impl::PyInterpreter"* %21, %"struct.c10::impl::PyInterpreter"** %8, align 8
  %22 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %8, align 8
  %23 = icmp ne %"struct.c10::impl::PyInterpreter"* %22, null
  br i1 %23, label %24, label %31

24:                                               ; preds = %20
  %25 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %8, align 8
  %26 = call %"struct.c10::Allocator"* @_ZNK3c104impl13PyInterpreterptEv(%"struct.c10::impl::PyInterpreter"* nonnull align 8 dereferenceable(8) %25) #3
  %27 = bitcast %"struct.c10::Allocator"* %26 to void (%"struct.c10::Allocator"*, i8)***
  %28 = load void (%"struct.c10::Allocator"*, i8)**, void (%"struct.c10::Allocator"*, i8)*** %27, align 8
  %29 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8)*, void (%"struct.c10::Allocator"*, i8)** %28, i64 31
  %30 = load void (%"struct.c10::Allocator"*, i8)*, void (%"struct.c10::Allocator"*, i8)** %29, align 8
  call void %30(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %26, i8 signext 1)
  br label %31

31:                                               ; preds = %24, %20
  br label %32

32:                                               ; preds = %31
  %33 = call i32 @cudaDeviceSynchronize()
  store i32 %33, i32* %9, align 4
  %34 = load i32, i32* %9, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %34, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface17synchronizeDeviceEa, i64 0, i64 0), i32 231, i1 zeroext true)
  br label %35

35:                                               ; preds = %32
  br label %36

36:                                               ; preds = %35
  %37 = load i8, i8* %5, align 1
  %38 = call i32 @_ZN3c104cuda9SetDeviceEa(i8 signext %37)
  store i32 %38, i32* %10, align 4
  %39 = load i32, i32* %10, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %39, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface17synchronizeDeviceEa, i64 0, i64 0), i32 232, i1 zeroext true)
  br label %40

40:                                               ; preds = %36
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda4impl13CUDAGuardImpl21recordDataPtrOnStreamERKNS_7DataPtrERKNS_6StreamE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, %"class.c10::DataPtr"* nonnull align 8 dereferenceable(26) %1, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %5 = alloca %"class.c10::DataPtr"*, align 8
  %6 = alloca %"class.c10::Stream"*, align 8
  %7 = alloca %"class.c10::cuda::CUDAStream", align 8
  %8 = alloca %"class.c10::Stream", align 8
  %9 = alloca %"class.c10::cuda::CUDAStream", align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  store %"class.c10::DataPtr"* %1, %"class.c10::DataPtr"** %5, align 8
  store %"class.c10::Stream"* %2, %"class.c10::Stream"** %6, align 8
  %10 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  %11 = load %"class.c10::Stream"*, %"class.c10::Stream"** %6, align 8
  %12 = bitcast %"class.c10::Stream"* %8 to i8*
  %13 = bitcast %"class.c10::Stream"* %11 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %12, i8* align 8 %13, i64 16, i1 false)
  %14 = bitcast %"class.c10::Stream"* %8 to { i64, i64 }*
  %15 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %14, i32 0, i32 0
  %16 = load i64, i64* %15, align 8
  %17 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %14, i32 0, i32 1
  %18 = load i64, i64* %17, align 8
  call void @_ZN3c104cuda10CUDAStreamC2ENS_6StreamE(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %7, i64 %16, i64 %18)
  %19 = load %"class.c10::DataPtr"*, %"class.c10::DataPtr"** %5, align 8
  %20 = bitcast %"class.c10::cuda::CUDAStream"* %9 to i8*
  %21 = bitcast %"class.c10::cuda::CUDAStream"* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %20, i8* align 8 %21, i64 16, i1 false)
  %22 = bitcast %"class.c10::cuda::CUDAStream"* %9 to { i64, i64 }*
  %23 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %22, i32 0, i32 0
  %24 = load i64, i64* %23, align 8
  %25 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %22, i32 0, i32 1
  %26 = load i64, i64* %25, align 8
  call void @_ZN3c104cuda20CUDACachingAllocator12recordStreamERKNS_7DataPtrENS0_10CUDAStreamE(%"class.c10::DataPtr"* nonnull align 8 dereferenceable(26) %19, i64 %24, i64 %26)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local double @_ZNK3c104cuda4impl13CUDAGuardImpl11elapsedTimeEPvS3_a(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, i8* %1, i8* %2, i8 signext %3) unnamed_addr #4 comdat align 2 {
  %5 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8, align 1
  %9 = alloca i8, align 1
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca %struct.CUevent_st*, align 8
  %13 = alloca %struct.CUevent_st*, align 8
  %14 = alloca float, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i8 %3, i8* %8, align 1
  %17 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %5, align 8
  %18 = load i8*, i8** %6, align 8
  %19 = icmp ne i8* %18, null
  br i1 %19, label %20, label %23

20:                                               ; preds = %4
  %21 = load i8*, i8** %7, align 8
  %22 = icmp ne i8* %21, null
  br i1 %22, label %25, label %23

23:                                               ; preds = %20, %4
  %24 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([151 x i8], [151 x i8]* @.str.32, i64 0, i64 0), i8* getelementptr inbounds ([62 x i8], [62 x i8]* @.str.33, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface11elapsedTimeEPvS2_a, i64 0, i64 0), i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i32 245, i8* %24) #25
  unreachable

25:                                               ; preds = %20
  store i8 -1, i8* %9, align 1
  br label %26

26:                                               ; preds = %25
  %27 = call i32 @_ZN3c104cuda9GetDeviceEPa(i8* %9)
  store i32 %27, i32* %10, align 4
  %28 = load i32, i32* %10, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %28, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface11elapsedTimeEPvS2_a, i64 0, i64 0), i32 250, i1 zeroext true)
  br label %29

29:                                               ; preds = %26
  br label %30

30:                                               ; preds = %29
  %31 = load i8, i8* %8, align 1
  %32 = call i32 @_ZN3c104cuda9SetDeviceEa(i8 signext %31)
  store i32 %32, i32* %11, align 4
  %33 = load i32, i32* %11, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %33, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface11elapsedTimeEPvS2_a, i64 0, i64 0), i32 251, i1 zeroext true)
  br label %34

34:                                               ; preds = %30
  %35 = load i8*, i8** %6, align 8
  %36 = bitcast i8* %35 to %struct.CUevent_st*
  store %struct.CUevent_st* %36, %struct.CUevent_st** %12, align 8
  %37 = load i8*, i8** %7, align 8
  %38 = bitcast i8* %37 to %struct.CUevent_st*
  store %struct.CUevent_st* %38, %struct.CUevent_st** %13, align 8
  store float 0.000000e+00, float* %14, align 4
  br label %39

39:                                               ; preds = %34
  %40 = load %struct.CUevent_st*, %struct.CUevent_st** %12, align 8
  %41 = load %struct.CUevent_st*, %struct.CUevent_st** %13, align 8
  %42 = call i32 @cudaEventElapsedTime(float* %14, %struct.CUevent_st* %40, %struct.CUevent_st* %41)
  store i32 %42, i32* %15, align 4
  %43 = load i32, i32* %15, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %43, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface11elapsedTimeEPvS2_a, i64 0, i64 0), i32 256, i1 zeroext true)
  br label %44

44:                                               ; preds = %39
  br label %45

45:                                               ; preds = %44
  %46 = load i8, i8* %9, align 1
  %47 = call i32 @_ZN3c104cuda9SetDeviceEa(i8 signext %46)
  store i32 %47, i32* %16, align 4
  %48 = load i32, i32* %16, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %48, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface11elapsedTimeEPvS2_a, i64 0, i64 0), i32 257, i1 zeroext true)
  br label %49

49:                                               ; preds = %45
  %50 = load float, float* %14, align 4
  %51 = fpext float %50 to double
  ret double %51
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104cuda4impl13CUDAGuardImplD0Ev(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %3 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  call void @_ZN3c104cuda4impl13CUDAGuardImplD2Ev(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %3) #3
  %4 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %3 to i8*
  call void @_ZdlPv(i8* %4) #27
  ret void
}

; Function Attrs: nobuiltin nounwind
declare dso_local void @_ZdlPv(i8*) #13

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* %0, i8* %1) #8 comdat {
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load i8*, i8** %4, align 8
  ret i8* %5
}

declare dso_local i32 @_ZN3c104cuda9SetDeviceEa(i8 signext) #1

declare dso_local i32 @cudaEventElapsedTime(float*, %struct.CUevent_st*, %struct.CUevent_st*) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c104cuda10CUDAStreamC2ENS_6StreamE(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %0, i64 %1, i64 %2) unnamed_addr #7 comdat align 2 {
  %4 = alloca %"class.c10::Stream", align 8
  %5 = alloca %"class.c10::cuda::CUDAStream"*, align 8
  %6 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %7 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %6, i32 0, i32 0
  store i64 %1, i64* %7, align 8
  %8 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %6, i32 0, i32 1
  store i64 %2, i64* %8, align 8
  store %"class.c10::cuda::CUDAStream"* %0, %"class.c10::cuda::CUDAStream"** %5, align 8
  %9 = load %"class.c10::cuda::CUDAStream"*, %"class.c10::cuda::CUDAStream"** %5, align 8
  %10 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %9, i32 0, i32 0
  %11 = bitcast %"class.c10::Stream"* %10 to i8*
  %12 = bitcast %"class.c10::Stream"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %11, i8* align 8 %12, i64 16, i1 false)
  %13 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %9, i32 0, i32 0
  %14 = call signext i8 @_ZNK3c106Stream11device_typeEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %13) #3
  %15 = icmp eq i8 %14, 1
  br i1 %15, label %18, label %16

16:                                               ; preds = %3
  %17 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKc(i8* getelementptr inbounds ([176 x i8], [176 x i8]* @.str.22, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__func__._ZN3c104cuda10CUDAStreamC2ENS_6StreamE, i64 0, i64 0), i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.21, i64 0, i64 0), i32 67, i8* %17) #25
  unreachable

18:                                               ; preds = %3
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c104cuda20CUDACachingAllocator12recordStreamERKNS_7DataPtrENS0_10CUDAStreamE(%"class.c10::DataPtr"* nonnull align 8 dereferenceable(26) %0, i64 %1, i64 %2) #4 comdat {
  %4 = alloca %"class.c10::cuda::CUDAStream", align 8
  %5 = alloca %"class.c10::DataPtr"*, align 8
  %6 = alloca %"class.c10::cuda::CUDAStream", align 8
  %7 = bitcast %"class.c10::cuda::CUDAStream"* %4 to { i64, i64 }*
  %8 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %7, i32 0, i32 0
  store i64 %1, i64* %8, align 8
  %9 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %7, i32 0, i32 1
  store i64 %2, i64* %9, align 8
  store %"class.c10::DataPtr"* %0, %"class.c10::DataPtr"** %5, align 8
  %10 = call %"struct.c10::cuda::impl::CUDAGuardImpl"* @_ZN3c104cuda20CUDACachingAllocator3getEv()
  %11 = load %"class.c10::DataPtr"*, %"class.c10::DataPtr"** %5, align 8
  %12 = bitcast %"class.c10::cuda::CUDAStream"* %6 to i8*
  %13 = bitcast %"class.c10::cuda::CUDAStream"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %12, i8* align 8 %13, i64 16, i1 false)
  %14 = bitcast %"class.c10::cuda::CUDAStream"* %6 to { i64, i64 }*
  %15 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %14, i32 0, i32 0
  %16 = load i64, i64* %15, align 8
  %17 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %14, i32 0, i32 1
  %18 = load i64, i64* %17, align 8
  %19 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %10 to void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, %"class.c10::DataPtr"*, i64, i64)***
  %20 = load void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, %"class.c10::DataPtr"*, i64, i64)**, void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, %"class.c10::DataPtr"*, i64, i64)*** %19, align 8
  %21 = getelementptr inbounds void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, %"class.c10::DataPtr"*, i64, i64)*, void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, %"class.c10::DataPtr"*, i64, i64)** %20, i64 18
  %22 = load void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, %"class.c10::DataPtr"*, i64, i64)*, void (%"struct.c10::cuda::impl::CUDAGuardImpl"*, %"class.c10::DataPtr"*, i64, i64)** %21, align 8
  call void %22(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %10, %"class.c10::DataPtr"* nonnull align 8 dereferenceable(26) %11, i64 %16, i64 %18)
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::cuda::impl::CUDAGuardImpl"* @_ZN3c104cuda20CUDACachingAllocator3getEv() #8 comdat {
  %1 = call %"struct.c10::cuda::impl::CUDAGuardImpl"* @_ZNKSt6atomicIPN3c104cuda20CUDACachingAllocator13CUDAAllocatorEE4loadESt12memory_order(%"struct.std::atomic.91"* nonnull align 8 dereferenceable(8) @_ZN3c104cuda20CUDACachingAllocator9allocatorE, i32 5) #3
  ret %"struct.c10::cuda::impl::CUDAGuardImpl"* %1
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::cuda::impl::CUDAGuardImpl"* @_ZNKSt6atomicIPN3c104cuda20CUDACachingAllocator13CUDAAllocatorEE4loadESt12memory_order(%"struct.std::atomic.91"* nonnull align 8 dereferenceable(8) %0, i32 %1) #8 comdat align 2 {
  %3 = alloca %"struct.std::__atomic_base.92"*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %7 = alloca %"struct.std::atomic.91"*, align 8
  %8 = alloca i32, align 4
  store %"struct.std::atomic.91"* %0, %"struct.std::atomic.91"** %7, align 8
  store i32 %1, i32* %8, align 4
  %9 = load %"struct.std::atomic.91"*, %"struct.std::atomic.91"** %7, align 8
  %10 = getelementptr inbounds %"struct.std::atomic.91", %"struct.std::atomic.91"* %9, i32 0, i32 0
  %11 = load i32, i32* %8, align 4
  store %"struct.std::__atomic_base.92"* %10, %"struct.std::__atomic_base.92"** %3, align 8
  store i32 %11, i32* %4, align 4
  %12 = load %"struct.std::__atomic_base.92"*, %"struct.std::__atomic_base.92"** %3, align 8
  %13 = load i32, i32* %4, align 4
  %14 = call i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %13, i32 65535) #3
  store i32 %14, i32* %5, align 4
  %15 = getelementptr inbounds %"struct.std::__atomic_base.92", %"struct.std::__atomic_base.92"* %12, i32 0, i32 0
  %16 = load i32, i32* %4, align 4
  %17 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"** %15 to i64*
  %18 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"** %6 to i64*
  switch i32 %16, label %19 [
    i32 1, label %21
    i32 2, label %21
    i32 5, label %23
  ]

19:                                               ; preds = %2
  %20 = load atomic i64, i64* %17 monotonic, align 8
  store i64 %20, i64* %18, align 8
  br label %25

21:                                               ; preds = %2, %2
  %22 = load atomic i64, i64* %17 acquire, align 8
  store i64 %22, i64* %18, align 8
  br label %25

23:                                               ; preds = %2
  %24 = load atomic i64, i64* %17 seq_cst, align 8
  store i64 %24, i64* %18, align 8
  br label %25

25:                                               ; preds = %19, %21, %23
  %26 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %6, align 8
  ret %"struct.c10::cuda::impl::CUDAGuardImpl"* %26
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %0, i32 %1) #8 comdat {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = and i32 %5, %6
  ret i32 %7
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local signext i8 @_ZNK3c106Stream11device_typeEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %0) #8 comdat align 2 {
  %2 = alloca %"class.c10::Stream"*, align 8
  store %"class.c10::Stream"* %0, %"class.c10::Stream"** %2, align 8
  %3 = load %"class.c10::Stream"*, %"class.c10::Stream"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::Stream", %"class.c10::Stream"* %3, i32 0, i32 0
  %5 = call signext i8 @_ZNK3c106Device4typeEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %4) #3
  ret i8 %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i8* @_ZN3c106detail17torchCheckMsgImplEPKc(i8* %0) #8 comdat {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  ret i8* %3
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::impl::PyInterpreter"* @_ZN3c104impl8GPUTrace9get_traceEv() #8 comdat align 2 {
  %1 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  %2 = load i8, i8* @_ZN3c104impl8GPUTrace9haveStateE, align 1
  %3 = trunc i8 %2 to i1
  br i1 %3, label %5, label %4

4:                                                ; preds = %0
  store %"struct.c10::impl::PyInterpreter"* null, %"struct.c10::impl::PyInterpreter"** %1, align 8
  br label %7

5:                                                ; preds = %0
  %6 = call %"struct.c10::impl::PyInterpreter"* @_ZNKSt6atomicIPKN3c104impl13PyInterpreterEE4loadESt12memory_order(%"struct.std::atomic.3"* nonnull align 8 dereferenceable(8) @_ZN3c104impl8GPUTrace13gpuTraceStateE, i32 2) #3
  store %"struct.c10::impl::PyInterpreter"* %6, %"struct.c10::impl::PyInterpreter"** %1, align 8
  br label %7

7:                                                ; preds = %5, %4
  %8 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %1, align 8
  ret %"struct.c10::impl::PyInterpreter"* %8
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::Allocator"* @_ZNK3c104impl13PyInterpreterptEv(%"struct.c10::impl::PyInterpreter"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  store %"struct.c10::impl::PyInterpreter"* %0, %"struct.c10::impl::PyInterpreter"** %2, align 8
  %3 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %2, align 8
  %4 = getelementptr inbounds %"struct.c10::impl::PyInterpreter", %"struct.c10::impl::PyInterpreter"* %3, i32 0, i32 0
  %5 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %4, align 8
  ret %"struct.c10::Allocator"* %5
}

declare dso_local i32 @cudaDeviceSynchronize() #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::impl::PyInterpreter"* @_ZNKSt6atomicIPKN3c104impl13PyInterpreterEE4loadESt12memory_order(%"struct.std::atomic.3"* nonnull align 8 dereferenceable(8) %0, i32 %1) #8 comdat align 2 personality i32 (...)* @__gxx_personality_v0 {
  %3 = alloca %"struct.std::__atomic_base.4"*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  %7 = alloca %"struct.std::atomic.3"*, align 8
  %8 = alloca i32, align 4
  store %"struct.std::atomic.3"* %0, %"struct.std::atomic.3"** %7, align 8
  store i32 %1, i32* %8, align 4
  %9 = load %"struct.std::atomic.3"*, %"struct.std::atomic.3"** %7, align 8
  %10 = getelementptr inbounds %"struct.std::atomic.3", %"struct.std::atomic.3"* %9, i32 0, i32 0
  %11 = load i32, i32* %8, align 4
  store %"struct.std::__atomic_base.4"* %10, %"struct.std::__atomic_base.4"** %3, align 8
  store i32 %11, i32* %4, align 4
  %12 = load %"struct.std::__atomic_base.4"*, %"struct.std::__atomic_base.4"** %3, align 8
  %13 = load i32, i32* %4, align 4
  %14 = invoke i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %13, i32 65535)
          to label %15 unwind label %26

15:                                               ; preds = %2
  store i32 %14, i32* %5, align 4
  %16 = getelementptr inbounds %"struct.std::__atomic_base.4", %"struct.std::__atomic_base.4"* %12, i32 0, i32 0
  %17 = load i32, i32* %4, align 4
  %18 = bitcast %"struct.c10::impl::PyInterpreter"** %16 to i64*
  %19 = bitcast %"struct.c10::impl::PyInterpreter"** %6 to i64*
  switch i32 %17, label %20 [
    i32 1, label %22
    i32 2, label %22
    i32 5, label %24
  ]

20:                                               ; preds = %15
  %21 = load atomic i64, i64* %18 monotonic, align 8
  store i64 %21, i64* %19, align 8
  br label %29

22:                                               ; preds = %15, %15
  %23 = load atomic i64, i64* %18 acquire, align 8
  store i64 %23, i64* %19, align 8
  br label %29

24:                                               ; preds = %15
  %25 = load atomic i64, i64* %18 seq_cst, align 8
  store i64 %25, i64* %19, align 8
  br label %29

26:                                               ; preds = %2
  %27 = landingpad { i8*, i32 }
          catch i8* null
  %28 = extractvalue { i8*, i32 } %27, 0
  call void @__clang_call_terminate(i8* %28) #26
  unreachable

29:                                               ; preds = %20, %22, %24
  %30 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %6, align 8
  ret %"struct.c10::impl::PyInterpreter"* %30
}

declare dso_local i32 @cudaEventSynchronize(%struct.CUevent_st*) #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda10CUDAStream11synchronizeEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %0) #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.c10::cuda::CUDAStream"*, align 8
  %3 = alloca %"class.c10::DeviceGuard", align 8
  %4 = alloca %"struct.c10::Device", align 1
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  store %"class.c10::cuda::CUDAStream"* %0, %"class.c10::cuda::CUDAStream"** %2, align 8
  %7 = load %"class.c10::cuda::CUDAStream"*, %"class.c10::cuda::CUDAStream"** %2, align 8
  %8 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %7, i32 0, i32 0
  %9 = call i16 @_ZNK3c106Stream6deviceEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %8) #3
  %10 = bitcast %"struct.c10::Device"* %4 to i16*
  store i16 %9, i16* %10, align 1
  %11 = bitcast %"struct.c10::Device"* %4 to i16*
  %12 = load i16, i16* %11, align 1
  call void @_ZN3c1011DeviceGuardC2ENS_6DeviceE(%"class.c10::DeviceGuard"* nonnull align 8 dereferenceable(24) %3, i16 %12)
  %13 = invoke %struct.CUstream_st* @_ZNK3c104cuda10CUDAStream6streamEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %7)
          to label %14 unwind label %16

14:                                               ; preds = %1
  invoke void @_ZN3c104cuda18stream_synchronizeEP11CUstream_st(%struct.CUstream_st* %13)
          to label %15 unwind label %16

15:                                               ; preds = %14
  call void @_ZN3c1011DeviceGuardD2Ev(%"class.c10::DeviceGuard"* nonnull align 8 dereferenceable(24) %3) #3
  ret void

16:                                               ; preds = %14, %1
  %17 = landingpad { i8*, i32 }
          cleanup
  %18 = extractvalue { i8*, i32 } %17, 0
  store i8* %18, i8** %5, align 8
  %19 = extractvalue { i8*, i32 } %17, 1
  store i32 %19, i32* %6, align 4
  call void @_ZN3c1011DeviceGuardD2Ev(%"class.c10::DeviceGuard"* nonnull align 8 dereferenceable(24) %3) #3
  br label %20

20:                                               ; preds = %16
  %21 = load i8*, i8** %5, align 8
  %22 = load i32, i32* %6, align 4
  %23 = insertvalue { i8*, i32 } undef, i8* %21, 0
  %24 = insertvalue { i8*, i32 } %23, i32 %22, 1
  resume { i8*, i32 } %24
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i16 @_ZNK3c106Stream6deviceEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %0) #8 comdat align 2 {
  %2 = alloca %"struct.c10::Device", align 1
  %3 = alloca %"class.c10::Stream"*, align 8
  store %"class.c10::Stream"* %0, %"class.c10::Stream"** %3, align 8
  %4 = load %"class.c10::Stream"*, %"class.c10::Stream"** %3, align 8
  %5 = getelementptr inbounds %"class.c10::Stream", %"class.c10::Stream"* %4, i32 0, i32 0
  %6 = bitcast %"struct.c10::Device"* %2 to i8*
  %7 = bitcast %"struct.c10::Device"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %6, i8* align 8 %7, i64 2, i1 false)
  %8 = bitcast %"struct.c10::Device"* %2 to i16*
  %9 = load i16, i16* %8, align 1
  ret i16 %9
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c1011DeviceGuardC2ENS_6DeviceE(%"class.c10::DeviceGuard"* nonnull align 8 dereferenceable(24) %0, i16 %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"struct.c10::Device", align 1
  %4 = alloca %"class.c10::DeviceGuard"*, align 8
  %5 = alloca %"struct.c10::Device", align 1
  %6 = bitcast %"struct.c10::Device"* %3 to i16*
  store i16 %1, i16* %6, align 1
  store %"class.c10::DeviceGuard"* %0, %"class.c10::DeviceGuard"** %4, align 8
  %7 = load %"class.c10::DeviceGuard"*, %"class.c10::DeviceGuard"** %4, align 8
  %8 = getelementptr inbounds %"class.c10::DeviceGuard", %"class.c10::DeviceGuard"* %7, i32 0, i32 0
  %9 = bitcast %"struct.c10::Device"* %5 to i8*
  %10 = bitcast %"struct.c10::Device"* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %9, i8* align 1 %10, i64 2, i1 false)
  %11 = bitcast %"struct.c10::Device"* %5 to i16*
  %12 = load i16, i16* %11, align 1
  call void @_ZN3c104impl17InlineDeviceGuardINS0_16VirtualGuardImplEEC2ENS_6DeviceE(%"class.c10::impl::InlineDeviceGuard.87"* nonnull align 8 dereferenceable(20) %8, i16 %12)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c104cuda18stream_synchronizeEP11CUstream_st(%struct.CUstream_st* %0) #4 comdat {
  %2 = alloca %struct.CUstream_st*, align 8
  %3 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  %4 = alloca i32, align 4
  store %struct.CUstream_st* %0, %struct.CUstream_st** %2, align 8
  %5 = call nonnull align 4 dereferenceable(4) %"struct.std::__atomic_base"* @_ZN3c104cuda13warning_stateEv()
  %6 = call i32 @_ZN3c104cuda12WarningState19get_sync_debug_modeEv(%"struct.std::__atomic_base"* nonnull align 4 dereferenceable(4) %5)
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %1
  call void @_ZN3c104cuda21warn_or_error_on_syncEv()
  br label %9

9:                                                ; preds = %8, %1
  %10 = call %"struct.c10::impl::PyInterpreter"* @_ZN3c104impl8GPUTrace9get_traceEv()
  store %"struct.c10::impl::PyInterpreter"* %10, %"struct.c10::impl::PyInterpreter"** %3, align 8
  %11 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %3, align 8
  %12 = icmp ne %"struct.c10::impl::PyInterpreter"* %11, null
  br i1 %12, label %13, label %22

13:                                               ; preds = %9
  %14 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %3, align 8
  %15 = call %"struct.c10::Allocator"* @_ZNK3c104impl13PyInterpreterptEv(%"struct.c10::impl::PyInterpreter"* nonnull align 8 dereferenceable(8) %14) #3
  %16 = load %struct.CUstream_st*, %struct.CUstream_st** %2, align 8
  %17 = ptrtoint %struct.CUstream_st* %16 to i64
  %18 = bitcast %"struct.c10::Allocator"* %15 to void (%"struct.c10::Allocator"*, i8, i64)***
  %19 = load void (%"struct.c10::Allocator"*, i8, i64)**, void (%"struct.c10::Allocator"*, i8, i64)*** %18, align 8
  %20 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8, i64)*, void (%"struct.c10::Allocator"*, i8, i64)** %19, i64 32
  %21 = load void (%"struct.c10::Allocator"*, i8, i64)*, void (%"struct.c10::Allocator"*, i8, i64)** %20, align 8
  call void %21(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %15, i8 signext 1, i64 %17)
  br label %22

22:                                               ; preds = %13, %9
  br label %23

23:                                               ; preds = %22
  %24 = load %struct.CUstream_st*, %struct.CUstream_st** %2, align 8
  %25 = call i32 @cudaStreamSynchronize(%struct.CUstream_st* %24)
  store i32 %25, i32* %4, align 4
  %26 = load i32, i32* %4, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %26, i8* getelementptr inbounds ([107 x i8], [107 x i8]* @.str.31, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__func__._ZN3c104cuda18stream_synchronizeEP11CUstream_st, i64 0, i64 0), i32 110, i1 zeroext true)
  br label %27

27:                                               ; preds = %23
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c1011DeviceGuardD2Ev(%"class.c10::DeviceGuard"* nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.c10::DeviceGuard"*, align 8
  store %"class.c10::DeviceGuard"* %0, %"class.c10::DeviceGuard"** %2, align 8
  %3 = load %"class.c10::DeviceGuard"*, %"class.c10::DeviceGuard"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::DeviceGuard", %"class.c10::DeviceGuard"* %3, i32 0, i32 0
  call void @_ZN3c104impl17InlineDeviceGuardINS0_16VirtualGuardImplEED2Ev(%"class.c10::impl::InlineDeviceGuard.87"* nonnull align 8 dereferenceable(20) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl17InlineDeviceGuardINS0_16VirtualGuardImplEED2Ev(%"class.c10::impl::InlineDeviceGuard.87"* nonnull align 8 dereferenceable(20) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.c10::impl::InlineDeviceGuard.87"*, align 8
  %3 = alloca %"struct.c10::Device", align 1
  store %"class.c10::impl::InlineDeviceGuard.87"* %0, %"class.c10::impl::InlineDeviceGuard.87"** %2, align 8
  %4 = load %"class.c10::impl::InlineDeviceGuard.87"*, %"class.c10::impl::InlineDeviceGuard.87"** %2, align 8
  %5 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard.87", %"class.c10::impl::InlineDeviceGuard.87"* %4, i32 0, i32 0
  %6 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard.87", %"class.c10::impl::InlineDeviceGuard.87"* %4, i32 0, i32 1
  %7 = bitcast %"struct.c10::Device"* %3 to i8*
  %8 = bitcast %"struct.c10::Device"* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %7, i8* align 8 %8, i64 2, i1 false)
  %9 = bitcast %"struct.c10::Device"* %3 to i16*
  %10 = load i16, i16* %9, align 1
  call void @_ZNK3c104impl16VirtualGuardImpl18uncheckedSetDeviceENS_6DeviceE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %5, i16 %10) #3
  %11 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard.87", %"class.c10::impl::InlineDeviceGuard.87"* %4, i32 0, i32 0
  call void @_ZN3c104impl16VirtualGuardImplD2Ev(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %11) #3
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl16VirtualGuardImpl18uncheckedSetDeviceENS_6DeviceE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i16 %1) unnamed_addr #8 comdat align 2 {
  %3 = alloca %"struct.c10::Device", align 1
  %4 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %5 = alloca %"struct.c10::Device", align 1
  %6 = bitcast %"struct.c10::Device"* %3 to i16*
  store i16 %1, i16* %6, align 1
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %4, align 8
  %7 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %4, align 8
  %8 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %7, i32 0, i32 1
  %9 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %8, align 8
  %10 = bitcast %"struct.c10::Device"* %5 to i8*
  %11 = bitcast %"struct.c10::Device"* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %10, i8* align 1 %11, i64 2, i1 false)
  %12 = bitcast %"struct.c10::Device"* %5 to i16*
  %13 = load i16, i16* %12, align 1
  %14 = bitcast %"struct.c10::Allocator"* %9 to void (%"struct.c10::Allocator"*, i16)***
  %15 = load void (%"struct.c10::Allocator"*, i16)**, void (%"struct.c10::Allocator"*, i16)*** %14, align 8
  %16 = getelementptr inbounds void (%"struct.c10::Allocator"*, i16)*, void (%"struct.c10::Allocator"*, i16)** %15, i64 4
  %17 = load void (%"struct.c10::Allocator"*, i16)*, void (%"struct.c10::Allocator"*, i16)** %16, align 8
  call void %17(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %9, i16 %13) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl16VirtualGuardImplD2Ev(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %2, align 8
  %3 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %2, align 8
  %4 = bitcast %"class.c10::impl::VirtualGuardImpl"* %3 to %"struct.c10::Allocator"*
  call void @_ZN3c104impl24DeviceGuardImplInterfaceD2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %4) #3
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 4 dereferenceable(4) %"struct.std::__atomic_base"* @_ZN3c104cuda13warning_stateEv() #8 comdat {
  ret %"struct.std::__atomic_base"* @_ZZN3c104cuda13warning_stateEvE14warning_state_
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_ZN3c104cuda12WarningState19get_sync_debug_modeEv(%"struct.std::__atomic_base"* nonnull align 4 dereferenceable(4) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::__atomic_base"*, align 8
  store %"struct.std::__atomic_base"* %0, %"struct.std::__atomic_base"** %2, align 8
  %3 = load %"struct.std::__atomic_base"*, %"struct.std::__atomic_base"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::__atomic_base", %"struct.std::__atomic_base"* %3, i32 0, i32 0
  %5 = load i32, i32* %4, align 4
  ret i32 %5
}

declare dso_local void @_ZN3c104cuda21warn_or_error_on_syncEv() #1

declare dso_local i32 @cudaStreamSynchronize(%struct.CUstream_st*) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl17InlineDeviceGuardINS0_16VirtualGuardImplEEC2ENS_6DeviceE(%"class.c10::impl::InlineDeviceGuard.87"* nonnull align 8 dereferenceable(20) %0, i16 %1) unnamed_addr #7 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"struct.c10::Device", align 1
  %4 = alloca %"class.c10::impl::InlineDeviceGuard.87"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %"struct.c10::Device", align 1
  %8 = bitcast %"struct.c10::Device"* %3 to i16*
  store i16 %1, i16* %8, align 1
  store %"class.c10::impl::InlineDeviceGuard.87"* %0, %"class.c10::impl::InlineDeviceGuard.87"** %4, align 8
  %9 = load %"class.c10::impl::InlineDeviceGuard.87"*, %"class.c10::impl::InlineDeviceGuard.87"** %4, align 8
  %10 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard.87", %"class.c10::impl::InlineDeviceGuard.87"* %9, i32 0, i32 0
  %11 = call signext i8 @_ZNK3c106Device4typeEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %3) #3
  call void @_ZN3c104impl16VirtualGuardImplC2ENS_10DeviceTypeE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %10, i8 signext %11)
  %12 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard.87", %"class.c10::impl::InlineDeviceGuard.87"* %9, i32 0, i32 1
  %13 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %3) #3
  %14 = sext i8 %13 to i32
  %15 = icmp eq i32 %14, -1
  br i1 %15, label %16, label %21

16:                                               ; preds = %2
  %17 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard.87", %"class.c10::impl::InlineDeviceGuard.87"* %9, i32 0, i32 0
  %18 = invoke i16 @_ZNK3c104impl16VirtualGuardImpl9getDeviceEv(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %17)
          to label %19 unwind label %42

19:                                               ; preds = %16
  %20 = bitcast %"struct.c10::Device"* %12 to i16*
  store i16 %18, i16* %20, align 8
  br label %30

21:                                               ; preds = %2
  %22 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard.87", %"class.c10::impl::InlineDeviceGuard.87"* %9, i32 0, i32 0
  %23 = bitcast %"struct.c10::Device"* %7 to i8*
  %24 = bitcast %"struct.c10::Device"* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %23, i8* align 1 %24, i64 2, i1 false)
  %25 = bitcast %"struct.c10::Device"* %7 to i16*
  %26 = load i16, i16* %25, align 1
  %27 = invoke i16 @_ZNK3c104impl16VirtualGuardImpl14exchangeDeviceENS_6DeviceE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %22, i16 %26)
          to label %28 unwind label %42

28:                                               ; preds = %21
  %29 = bitcast %"struct.c10::Device"* %12 to i16*
  store i16 %27, i16* %29, align 8
  br label %30

30:                                               ; preds = %28, %19
  %31 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard.87", %"class.c10::impl::InlineDeviceGuard.87"* %9, i32 0, i32 2
  %32 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %3) #3
  %33 = sext i8 %32 to i32
  %34 = icmp eq i32 %33, -1
  br i1 %34, label %35, label %37

35:                                               ; preds = %30
  %36 = getelementptr inbounds %"class.c10::impl::InlineDeviceGuard.87", %"class.c10::impl::InlineDeviceGuard.87"* %9, i32 0, i32 1
  br label %38

37:                                               ; preds = %30
  br label %38

38:                                               ; preds = %37, %35
  %39 = phi %"struct.c10::Device"* [ %36, %35 ], [ %3, %37 ]
  %40 = bitcast %"struct.c10::Device"* %31 to i8*
  %41 = bitcast %"struct.c10::Device"* %39 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %40, i8* align 1 %41, i64 2, i1 false)
  ret void

42:                                               ; preds = %21, %16
  %43 = landingpad { i8*, i32 }
          cleanup
  %44 = extractvalue { i8*, i32 } %43, 0
  store i8* %44, i8** %5, align 8
  %45 = extractvalue { i8*, i32 } %43, 1
  store i32 %45, i32* %6, align 4
  call void @_ZN3c104impl16VirtualGuardImplD2Ev(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %10) #3
  br label %46

46:                                               ; preds = %42
  %47 = load i8*, i8** %5, align 8
  %48 = load i32, i32* %6, align 4
  %49 = insertvalue { i8*, i32 } undef, i8* %47, 0
  %50 = insertvalue { i8*, i32 } %49, i32 %48, 1
  resume { i8*, i32 } %50
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl16VirtualGuardImplC2ENS_10DeviceTypeE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i8 signext %1) unnamed_addr #7 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %4 = alloca i8, align 1
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  store i8 %1, i8* %4, align 1
  %7 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  %8 = bitcast %"class.c10::impl::VirtualGuardImpl"* %7 to %"struct.c10::Allocator"*
  call void @_ZN3c104impl24DeviceGuardImplInterfaceC2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %8) #3
  %9 = bitcast %"class.c10::impl::VirtualGuardImpl"* %7 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [25 x i8*] }, { [25 x i8*] }* @_ZTVN3c104impl16VirtualGuardImplE, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %9, align 8
  %10 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %7, i32 0, i32 1
  %11 = load i8, i8* %4, align 1
  %12 = invoke %"struct.c10::Allocator"* @_ZN3c104impl18getDeviceGuardImplENS_10DeviceTypeE(i8 signext %11)
          to label %13 unwind label %14

13:                                               ; preds = %2
  store %"struct.c10::Allocator"* %12, %"struct.c10::Allocator"** %10, align 8
  ret void

14:                                               ; preds = %2
  %15 = landingpad { i8*, i32 }
          cleanup
  %16 = extractvalue { i8*, i32 } %15, 0
  store i8* %16, i8** %5, align 8
  %17 = extractvalue { i8*, i32 } %15, 1
  store i32 %17, i32* %6, align 4
  %18 = bitcast %"class.c10::impl::VirtualGuardImpl"* %7 to %"struct.c10::Allocator"*
  call void @_ZN3c104impl24DeviceGuardImplInterfaceD2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %18) #3
  br label %19

19:                                               ; preds = %14
  %20 = load i8*, i8** %5, align 8
  %21 = load i32, i32* %6, align 4
  %22 = insertvalue { i8*, i32 } undef, i8* %20, 0
  %23 = insertvalue { i8*, i32 } %22, i32 %21, 1
  resume { i8*, i32 } %23
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i16 @_ZNK3c104impl16VirtualGuardImpl9getDeviceEv(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0) unnamed_addr #4 comdat align 2 {
  %2 = alloca %"struct.c10::Device", align 1
  %3 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  %4 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  %5 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %4, i32 0, i32 1
  %6 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %5, align 8
  %7 = bitcast %"struct.c10::Allocator"* %6 to i16 (%"struct.c10::Allocator"*)***
  %8 = load i16 (%"struct.c10::Allocator"*)**, i16 (%"struct.c10::Allocator"*)*** %7, align 8
  %9 = getelementptr inbounds i16 (%"struct.c10::Allocator"*)*, i16 (%"struct.c10::Allocator"*)** %8, i64 2
  %10 = load i16 (%"struct.c10::Allocator"*)*, i16 (%"struct.c10::Allocator"*)** %9, align 8
  %11 = call i16 %10(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %6)
  %12 = bitcast %"struct.c10::Device"* %2 to i16*
  store i16 %11, i16* %12, align 1
  %13 = bitcast %"struct.c10::Device"* %2 to i16*
  %14 = load i16, i16* %13, align 1
  ret i16 %14
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i16 @_ZNK3c104impl16VirtualGuardImpl14exchangeDeviceENS_6DeviceE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i16 %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::Device", align 1
  %4 = alloca %"struct.c10::Device", align 1
  %5 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %6 = alloca %"struct.c10::Device", align 1
  %7 = bitcast %"struct.c10::Device"* %4 to i16*
  store i16 %1, i16* %7, align 1
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %5, align 8
  %8 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %5, align 8
  %9 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %8, i32 0, i32 1
  %10 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %9, align 8
  %11 = bitcast %"struct.c10::Device"* %6 to i8*
  %12 = bitcast %"struct.c10::Device"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %12, i64 2, i1 false)
  %13 = bitcast %"struct.c10::Device"* %6 to i16*
  %14 = load i16, i16* %13, align 1
  %15 = bitcast %"struct.c10::Allocator"* %10 to i16 (%"struct.c10::Allocator"*, i16)***
  %16 = load i16 (%"struct.c10::Allocator"*, i16)**, i16 (%"struct.c10::Allocator"*, i16)*** %15, align 8
  %17 = getelementptr inbounds i16 (%"struct.c10::Allocator"*, i16)*, i16 (%"struct.c10::Allocator"*, i16)** %16, i64 1
  %18 = load i16 (%"struct.c10::Allocator"*, i16)*, i16 (%"struct.c10::Allocator"*, i16)** %17, align 8
  %19 = call i16 %18(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %10, i16 %14)
  %20 = bitcast %"struct.c10::Device"* %3 to i16*
  store i16 %19, i16* %20, align 1
  %21 = bitcast %"struct.c10::Device"* %3 to i16*
  %22 = load i16, i16* %21, align 1
  ret i16 %22
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local %"struct.c10::Allocator"* @_ZN3c104impl18getDeviceGuardImplENS_10DeviceTypeE(i8 signext %0) #4 comdat personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca i8, align 1
  %3 = alloca %"struct.c10::Allocator"*, align 8
  %4 = alloca %"class.std::__cxx11::basic_string", align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  store i8 %0, i8* %2, align 1
  %7 = load i8, i8* %2, align 1
  %8 = sext i8 %7 to i64
  %9 = and i64 %8, 255
  %10 = call nonnull align 8 dereferenceable(8) %"struct.std::_Tuple_impl.19"* @_ZNSt5arrayISt6atomicIPKN3c104impl24DeviceGuardImplInterfaceEELm21EEixEm(%"struct.std::array"* nonnull align 8 dereferenceable(168) @_ZN3c104impl26device_guard_impl_registryE, i64 %9) #3
  %11 = call %"struct.c10::Allocator"* @_ZNKSt6atomicIPKN3c104impl24DeviceGuardImplInterfaceEE4loadESt12memory_order(%"struct.std::_Tuple_impl.19"* nonnull align 8 dereferenceable(8) %10, i32 5) #3
  store %"struct.c10::Allocator"* %11, %"struct.c10::Allocator"** %3, align 8
  %12 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %3, align 8
  %13 = icmp ne %"struct.c10::Allocator"* %12, null
  br i1 %13, label %20, label %14

14:                                               ; preds = %1
  call void @_ZN3c106detail17torchCheckMsgImplIJA40_cNS_10DeviceTypeEA9_cEEEDcPKcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %4, i8* getelementptr inbounds ([136 x i8], [136 x i8]* @.str.28, i64 0, i64 0), [40 x i8]* nonnull align 1 dereferenceable(40) @.str.29, i8* nonnull align 1 dereferenceable(1) %2, [9 x i8]* nonnull align 1 dereferenceable(9) @.str.30)
  invoke void @_ZN3c106detail14torchCheckFailEPKcS2_jRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__func__._ZN3c104impl18getDeviceGuardImplENS_10DeviceTypeE, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 366, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %4) #25
          to label %15 unwind label %16

15:                                               ; preds = %14
  unreachable

16:                                               ; preds = %14
  %17 = landingpad { i8*, i32 }
          cleanup
  %18 = extractvalue { i8*, i32 } %17, 0
  store i8* %18, i8** %5, align 8
  %19 = extractvalue { i8*, i32 } %17, 1
  store i32 %19, i32* %6, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %4) #3
  br label %22

20:                                               ; preds = %1
  %21 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %3, align 8
  ret %"struct.c10::Allocator"* %21

22:                                               ; preds = %16
  %23 = load i8*, i8** %5, align 8
  %24 = load i32, i32* %6, align 4
  %25 = insertvalue { i8*, i32 } undef, i8* %23, 0
  %26 = insertvalue { i8*, i32 } %25, i32 %24, 1
  resume { i8*, i32 } %26
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"struct.std::_Tuple_impl.19"* @_ZNSt5arrayISt6atomicIPKN3c104impl24DeviceGuardImplInterfaceEELm21EEixEm(%"struct.std::array"* nonnull align 8 dereferenceable(168) %0, i64 %1) #8 comdat align 2 {
  %3 = alloca %"struct.std::array"*, align 8
  %4 = alloca i64, align 8
  store %"struct.std::array"* %0, %"struct.std::array"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"struct.std::array"*, %"struct.std::array"** %3, align 8
  %6 = getelementptr inbounds %"struct.std::array", %"struct.std::array"* %5, i32 0, i32 0
  %7 = load i64, i64* %4, align 8
  %8 = call nonnull align 8 dereferenceable(8) %"struct.std::_Tuple_impl.19"* @_ZNSt14__array_traitsISt6atomicIPKN3c104impl24DeviceGuardImplInterfaceEELm21EE6_S_refERA21_KS6_m([21 x %"struct.std::_Tuple_impl.19"]* nonnull align 8 dereferenceable(168) %6, i64 %7) #3
  ret %"struct.std::_Tuple_impl.19"* %8
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::Allocator"* @_ZNKSt6atomicIPKN3c104impl24DeviceGuardImplInterfaceEE4loadESt12memory_order(%"struct.std::_Tuple_impl.19"* nonnull align 8 dereferenceable(8) %0, i32 %1) #8 comdat align 2 {
  %3 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %"struct.c10::Allocator"*, align 8
  %7 = alloca %"struct.std::_Tuple_impl.19"*, align 8
  %8 = alloca i32, align 4
  store %"struct.std::_Tuple_impl.19"* %0, %"struct.std::_Tuple_impl.19"** %7, align 8
  store i32 %1, i32* %8, align 4
  %9 = load %"struct.std::_Tuple_impl.19"*, %"struct.std::_Tuple_impl.19"** %7, align 8
  %10 = getelementptr inbounds %"struct.std::_Tuple_impl.19", %"struct.std::_Tuple_impl.19"* %9, i32 0, i32 0
  %11 = load i32, i32* %8, align 4
  store %"struct.c10::impl::PyInterpreter"* %10, %"struct.c10::impl::PyInterpreter"** %3, align 8
  store i32 %11, i32* %4, align 4
  %12 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %3, align 8
  %13 = load i32, i32* %4, align 4
  %14 = call i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %13, i32 65535) #3
  store i32 %14, i32* %5, align 4
  %15 = getelementptr inbounds %"struct.c10::impl::PyInterpreter", %"struct.c10::impl::PyInterpreter"* %12, i32 0, i32 0
  %16 = load i32, i32* %4, align 4
  %17 = bitcast %"struct.c10::Allocator"** %15 to i64*
  %18 = bitcast %"struct.c10::Allocator"** %6 to i64*
  switch i32 %16, label %19 [
    i32 1, label %21
    i32 2, label %21
    i32 5, label %23
  ]

19:                                               ; preds = %2
  %20 = load atomic i64, i64* %17 monotonic, align 8
  store i64 %20, i64* %18, align 8
  br label %25

21:                                               ; preds = %2, %2
  %22 = load atomic i64, i64* %17 acquire, align 8
  store i64 %22, i64* %18, align 8
  br label %25

23:                                               ; preds = %2
  %24 = load atomic i64, i64* %17 seq_cst, align 8
  store i64 %24, i64* %18, align 8
  br label %25

25:                                               ; preds = %19, %21, %23
  %26 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %6, align 8
  ret %"struct.c10::Allocator"* %26
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail17torchCheckMsgImplIJA40_cNS_10DeviceTypeEA9_cEEEDcPKcDpRKT_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, i8* %1, [40 x i8]* nonnull align 1 dereferenceable(40) %2, i8* nonnull align 1 dereferenceable(1) %3, [9 x i8]* nonnull align 1 dereferenceable(9) %4) #4 comdat {
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca [40 x i8]*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca [9 x i8]*, align 8
  %11 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %11, i8** %6, align 8
  store i8* %1, i8** %7, align 8
  store [40 x i8]* %2, [40 x i8]** %8, align 8
  store i8* %3, i8** %9, align 8
  store [9 x i8]* %4, [9 x i8]** %10, align 8
  %12 = load [40 x i8]*, [40 x i8]** %8, align 8
  %13 = load i8*, i8** %9, align 8
  %14 = load [9 x i8]*, [9 x i8]** %10, align 8
  call void @_ZN3c103strIJA40_cNS_10DeviceTypeEA9_cEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, [40 x i8]* nonnull align 1 dereferenceable(40) %12, i8* nonnull align 1 dereferenceable(1) %13, [9 x i8]* nonnull align 1 dereferenceable(9) %14)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c103strIJA40_cNS_10DeviceTypeEA9_cEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, [40 x i8]* nonnull align 1 dereferenceable(40) %1, i8* nonnull align 1 dereferenceable(1) %2, [9 x i8]* nonnull align 1 dereferenceable(9) %3) #4 comdat {
  %5 = alloca i8*, align 8
  %6 = alloca [40 x i8]*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca [9 x i8]*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i8*, align 8
  %11 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %11, i8** %5, align 8
  store [40 x i8]* %1, [40 x i8]** %6, align 8
  store i8* %2, i8** %7, align 8
  store [9 x i8]* %3, [9 x i8]** %8, align 8
  %12 = load [40 x i8]*, [40 x i8]** %6, align 8
  %13 = getelementptr inbounds [40 x i8], [40 x i8]* %12, i64 0, i64 0
  store i8* %13, i8** %9, align 8
  %14 = load i8*, i8** %7, align 8
  %15 = load [9 x i8]*, [9 x i8]** %8, align 8
  %16 = getelementptr inbounds [9 x i8], [9 x i8]* %15, i64 0, i64 0
  store i8* %16, i8** %10, align 8
  call void @_ZN3c106detail12_str_wrapperIJPKcRKNS_10DeviceTypeES3_EE4callB5cxx11ERKS3_S6_S9_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, i8** nonnull align 8 dereferenceable(8) %9, i8* nonnull align 1 dereferenceable(1) %14, i8** nonnull align 8 dereferenceable(8) %10)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail12_str_wrapperIJPKcRKNS_10DeviceTypeES3_EE4callB5cxx11ERKS3_S6_S9_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, i8** nonnull align 8 dereferenceable(8) %1, i8* nonnull align 1 dereferenceable(1) %2, i8** nonnull align 8 dereferenceable(8) %3) #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %5 = alloca i8*, align 8
  %6 = alloca i8**, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8**, align 8
  %9 = alloca %"class.std::__cxx11::basic_ostringstream", align 8
  %10 = alloca i8*, align 8
  %11 = alloca i32, align 4
  %12 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %12, i8** %5, align 8
  store i8** %1, i8*** %6, align 8
  store i8* %2, i8** %7, align 8
  store i8** %3, i8*** %8, align 8
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %9)
  %13 = bitcast %"class.std::__cxx11::basic_ostringstream"* %9 to %"class.std::basic_ostream"*
  %14 = load i8**, i8*** %6, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = load i8**, i8*** %8, align 8
  %17 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJNS_10DeviceTypeES3_EEERSoS5_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %13, i8** nonnull align 8 dereferenceable(8) %14, i8* nonnull align 1 dereferenceable(1) %15, i8** nonnull align 8 dereferenceable(8) %16)
          to label %18 unwind label %20

18:                                               ; preds = %4
  invoke void @_ZNKSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEE3strEv(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, %"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %9)
          to label %19 unwind label %20

19:                                               ; preds = %18
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %9) #3
  ret void

20:                                               ; preds = %18, %4
  %21 = landingpad { i8*, i32 }
          cleanup
  %22 = extractvalue { i8*, i32 } %21, 0
  store i8* %22, i8** %10, align 8
  %23 = extractvalue { i8*, i32 } %21, 1
  store i32 %23, i32* %11, align 4
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %9) #3
  br label %24

24:                                               ; preds = %20
  %25 = load i8*, i8** %10, align 8
  %26 = load i32, i32* %11, align 4
  %27 = insertvalue { i8*, i32 } undef, i8* %25, 0
  %28 = insertvalue { i8*, i32 } %27, i32 %26, 1
  resume { i8*, i32 } %28
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJNS_10DeviceTypeES3_EEERSoS5_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8** nonnull align 8 dereferenceable(8) %1, i8* nonnull align 1 dereferenceable(1) %2, i8** nonnull align 8 dereferenceable(8) %3) #4 comdat {
  %5 = alloca %"class.std::basic_ostream"*, align 8
  %6 = alloca i8**, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %5, align 8
  store i8** %1, i8*** %6, align 8
  store i8* %2, i8** %7, align 8
  store i8** %3, i8*** %8, align 8
  %9 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %5, align 8
  %10 = load i8**, i8*** %6, align 8
  %11 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %9, i8** nonnull align 8 dereferenceable(8) %10)
  %12 = load i8*, i8** %7, align 8
  %13 = load i8**, i8*** %8, align 8
  %14 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strINS_10DeviceTypeEJPKcEEERSoS5_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %11, i8* nonnull align 1 dereferenceable(1) %12, i8** nonnull align 8 dereferenceable(8) %13)
  ret %"class.std::basic_ostream"* %14
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strINS_10DeviceTypeEJPKcEEERSoS5_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8* nonnull align 1 dereferenceable(1) %1, i8** nonnull align 8 dereferenceable(8) %2) #4 comdat {
  %4 = alloca %"class.std::basic_ostream"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8** %2, i8*** %6, align 8
  %7 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %4, align 8
  %8 = load i8*, i8** %5, align 8
  %9 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strINS_10DeviceTypeEEERSoS3_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %7, i8* nonnull align 1 dereferenceable(1) %8)
  %10 = load i8**, i8*** %6, align 8
  %11 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %9, i8** nonnull align 8 dereferenceable(8) %10)
  ret %"class.std::basic_ostream"* %11
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strINS_10DeviceTypeEEERSoS3_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8* nonnull align 1 dereferenceable(1) %1) #4 comdat {
  %3 = alloca %"class.std::basic_ostream"*, align 8
  %4 = alloca i8*, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %3, align 8
  %6 = load i8*, i8** %4, align 8
  %7 = load i8, i8* %6, align 1
  %8 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c10lsERSoNS_10DeviceTypeE(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %5, i8 signext %7)
  %9 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %3, align 8
  ret %"class.std::basic_ostream"* %9
}

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c10lsERSoNS_10DeviceTypeE(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8 signext) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"struct.std::_Tuple_impl.19"* @_ZNSt14__array_traitsISt6atomicIPKN3c104impl24DeviceGuardImplInterfaceEELm21EE6_S_refERA21_KS6_m([21 x %"struct.std::_Tuple_impl.19"]* nonnull align 8 dereferenceable(168) %0, i64 %1) #8 comdat align 2 {
  %3 = alloca [21 x %"struct.std::_Tuple_impl.19"]*, align 8
  %4 = alloca i64, align 8
  store [21 x %"struct.std::_Tuple_impl.19"]* %0, [21 x %"struct.std::_Tuple_impl.19"]** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load [21 x %"struct.std::_Tuple_impl.19"]*, [21 x %"struct.std::_Tuple_impl.19"]** %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = getelementptr inbounds [21 x %"struct.std::_Tuple_impl.19"], [21 x %"struct.std::_Tuple_impl.19"]* %5, i64 0, i64 %6
  ret %"struct.std::_Tuple_impl.19"* %7
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local signext i8 @_ZNK3c104impl16VirtualGuardImpl4typeEv(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0) unnamed_addr #4 comdat align 2 {
  %2 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %2, align 8
  %3 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %3, i32 0, i32 1
  %5 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %4, align 8
  %6 = bitcast %"struct.c10::Allocator"* %5 to i8 (%"struct.c10::Allocator"*)***
  %7 = load i8 (%"struct.c10::Allocator"*)**, i8 (%"struct.c10::Allocator"*)*** %6, align 8
  %8 = getelementptr inbounds i8 (%"struct.c10::Allocator"*)*, i8 (%"struct.c10::Allocator"*)** %7, i64 0
  %9 = load i8 (%"struct.c10::Allocator"*)*, i8 (%"struct.c10::Allocator"*)** %8, align 8
  %10 = call signext i8 %9(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %5)
  ret i8 %10
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl16VirtualGuardImpl9setDeviceENS_6DeviceE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i16 %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::Device", align 1
  %4 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %5 = alloca %"struct.c10::Device", align 1
  %6 = bitcast %"struct.c10::Device"* %3 to i16*
  store i16 %1, i16* %6, align 1
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %4, align 8
  %7 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %4, align 8
  %8 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %7, i32 0, i32 1
  %9 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %8, align 8
  %10 = bitcast %"struct.c10::Device"* %5 to i8*
  %11 = bitcast %"struct.c10::Device"* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %10, i8* align 1 %11, i64 2, i1 false)
  %12 = bitcast %"struct.c10::Device"* %5 to i16*
  %13 = load i16, i16* %12, align 1
  %14 = bitcast %"struct.c10::Allocator"* %9 to void (%"struct.c10::Allocator"*, i16)***
  %15 = load void (%"struct.c10::Allocator"*, i16)**, void (%"struct.c10::Allocator"*, i16)*** %14, align 8
  %16 = getelementptr inbounds void (%"struct.c10::Allocator"*, i16)*, void (%"struct.c10::Allocator"*, i16)** %15, i64 3
  %17 = load void (%"struct.c10::Allocator"*, i16)*, void (%"struct.c10::Allocator"*, i16)** %16, align 8
  call void %17(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %9, i16 %13)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104impl16VirtualGuardImpl9getStreamENS_6DeviceE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i16 %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"class.c10::Stream", align 8
  %4 = alloca %"struct.c10::Device", align 1
  %5 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %6 = alloca %"struct.c10::Device", align 1
  %7 = bitcast %"struct.c10::Device"* %4 to i16*
  store i16 %1, i16* %7, align 1
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %5, align 8
  %8 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %5, align 8
  %9 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %8, i32 0, i32 1
  %10 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %9, align 8
  %11 = bitcast %"struct.c10::Device"* %6 to i8*
  %12 = bitcast %"struct.c10::Device"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %12, i64 2, i1 false)
  %13 = bitcast %"struct.c10::Device"* %6 to i16*
  %14 = load i16, i16* %13, align 1
  %15 = bitcast %"struct.c10::Allocator"* %10 to { i64, i64 } (%"struct.c10::Allocator"*, i16)***
  %16 = load { i64, i64 } (%"struct.c10::Allocator"*, i16)**, { i64, i64 } (%"struct.c10::Allocator"*, i16)*** %15, align 8
  %17 = getelementptr inbounds { i64, i64 } (%"struct.c10::Allocator"*, i16)*, { i64, i64 } (%"struct.c10::Allocator"*, i16)** %16, i64 5
  %18 = load { i64, i64 } (%"struct.c10::Allocator"*, i16)*, { i64, i64 } (%"struct.c10::Allocator"*, i16)** %17, align 8
  %19 = call { i64, i64 } %18(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %10, i16 %14)
  %20 = bitcast %"class.c10::Stream"* %3 to { i64, i64 }*
  %21 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %20, i32 0, i32 0
  %22 = extractvalue { i64, i64 } %19, 0
  store i64 %22, i64* %21, align 8
  %23 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %20, i32 0, i32 1
  %24 = extractvalue { i64, i64 } %19, 1
  store i64 %24, i64* %23, align 8
  %25 = bitcast %"class.c10::Stream"* %3 to { i64, i64 }*
  %26 = load { i64, i64 }, { i64, i64 }* %25, align 8
  ret { i64, i64 } %26
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104impl16VirtualGuardImpl16getDefaultStreamENS_6DeviceE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i16 %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"class.c10::Stream", align 8
  %4 = alloca %"struct.c10::Device", align 1
  %5 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %6 = alloca %"struct.c10::Device", align 1
  %7 = bitcast %"struct.c10::Device"* %4 to i16*
  store i16 %1, i16* %7, align 1
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %5, align 8
  %8 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %5, align 8
  %9 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %8, i32 0, i32 1
  %10 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %9, align 8
  %11 = bitcast %"struct.c10::Device"* %6 to i8*
  %12 = bitcast %"struct.c10::Device"* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %12, i64 2, i1 false)
  %13 = bitcast %"struct.c10::Device"* %6 to i16*
  %14 = load i16, i16* %13, align 1
  %15 = bitcast %"struct.c10::Allocator"* %10 to { i64, i64 } (%"struct.c10::Allocator"*, i16)***
  %16 = load { i64, i64 } (%"struct.c10::Allocator"*, i16)**, { i64, i64 } (%"struct.c10::Allocator"*, i16)*** %15, align 8
  %17 = getelementptr inbounds { i64, i64 } (%"struct.c10::Allocator"*, i16)*, { i64, i64 } (%"struct.c10::Allocator"*, i16)** %16, i64 6
  %18 = load { i64, i64 } (%"struct.c10::Allocator"*, i16)*, { i64, i64 } (%"struct.c10::Allocator"*, i16)** %17, align 8
  %19 = call { i64, i64 } %18(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %10, i16 %14)
  %20 = bitcast %"class.c10::Stream"* %3 to { i64, i64 }*
  %21 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %20, i32 0, i32 0
  %22 = extractvalue { i64, i64 } %19, 0
  store i64 %22, i64* %21, align 8
  %23 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %20, i32 0, i32 1
  %24 = extractvalue { i64, i64 } %19, 1
  store i64 %24, i64* %23, align 8
  %25 = bitcast %"class.c10::Stream"* %3 to { i64, i64 }*
  %26 = load { i64, i64 }, { i64, i64 }* %25, align 8
  ret { i64, i64 } %26
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104impl16VirtualGuardImpl23getStreamFromGlobalPoolENS_6DeviceEb(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i16 %1, i1 zeroext %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"class.c10::Stream", align 8
  %5 = alloca %"struct.c10::Device", align 1
  %6 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %7 = alloca i8, align 1
  %8 = alloca %"struct.c10::Device", align 1
  %9 = bitcast %"struct.c10::Device"* %5 to i16*
  store i16 %1, i16* %9, align 1
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %6, align 8
  %10 = zext i1 %2 to i8
  store i8 %10, i8* %7, align 1
  %11 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %6, align 8
  %12 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %11, i32 0, i32 1
  %13 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %12, align 8
  %14 = bitcast %"struct.c10::Device"* %8 to i8*
  %15 = bitcast %"struct.c10::Device"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %14, i8* align 1 %15, i64 2, i1 false)
  %16 = load i8, i8* %7, align 1
  %17 = trunc i8 %16 to i1
  %18 = bitcast %"struct.c10::Device"* %8 to i16*
  %19 = load i16, i16* %18, align 1
  %20 = bitcast %"struct.c10::Allocator"* %13 to { i64, i64 } (%"struct.c10::Allocator"*, i16, i1)***
  %21 = load { i64, i64 } (%"struct.c10::Allocator"*, i16, i1)**, { i64, i64 } (%"struct.c10::Allocator"*, i16, i1)*** %20, align 8
  %22 = getelementptr inbounds { i64, i64 } (%"struct.c10::Allocator"*, i16, i1)*, { i64, i64 } (%"struct.c10::Allocator"*, i16, i1)** %21, i64 7
  %23 = load { i64, i64 } (%"struct.c10::Allocator"*, i16, i1)*, { i64, i64 } (%"struct.c10::Allocator"*, i16, i1)** %22, align 8
  %24 = call { i64, i64 } %23(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %13, i16 %19, i1 zeroext %17)
  %25 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %26 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %25, i32 0, i32 0
  %27 = extractvalue { i64, i64 } %24, 0
  store i64 %27, i64* %26, align 8
  %28 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %25, i32 0, i32 1
  %29 = extractvalue { i64, i64 } %24, 1
  store i64 %29, i64* %28, align 8
  %30 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %31 = load { i64, i64 }, { i64, i64 }* %30, align 8
  ret { i64, i64 } %31
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104impl16VirtualGuardImpl12getNewStreamENS_6DeviceEi(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i16 %1, i32 %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"class.c10::Stream", align 8
  %5 = alloca %"struct.c10::Device", align 1
  %6 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %"struct.c10::Device", align 1
  %9 = bitcast %"struct.c10::Device"* %5 to i16*
  store i16 %1, i16* %9, align 1
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %6, align 8
  store i32 %2, i32* %7, align 4
  %10 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %6, align 8
  %11 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %10, i32 0, i32 1
  %12 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %11, align 8
  %13 = bitcast %"struct.c10::Device"* %8 to i8*
  %14 = bitcast %"struct.c10::Device"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %13, i8* align 1 %14, i64 2, i1 false)
  %15 = load i32, i32* %7, align 4
  %16 = bitcast %"struct.c10::Device"* %8 to i16*
  %17 = load i16, i16* %16, align 1
  %18 = bitcast %"struct.c10::Allocator"* %12 to { i64, i64 } (%"struct.c10::Allocator"*, i16, i32)***
  %19 = load { i64, i64 } (%"struct.c10::Allocator"*, i16, i32)**, { i64, i64 } (%"struct.c10::Allocator"*, i16, i32)*** %18, align 8
  %20 = getelementptr inbounds { i64, i64 } (%"struct.c10::Allocator"*, i16, i32)*, { i64, i64 } (%"struct.c10::Allocator"*, i16, i32)** %19, i64 8
  %21 = load { i64, i64 } (%"struct.c10::Allocator"*, i16, i32)*, { i64, i64 } (%"struct.c10::Allocator"*, i16, i32)** %20, align 8
  %22 = call { i64, i64 } %21(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %12, i16 %17, i32 %15)
  %23 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %24 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %23, i32 0, i32 0
  %25 = extractvalue { i64, i64 } %22, 0
  store i64 %25, i64* %24, align 8
  %26 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %23, i32 0, i32 1
  %27 = extractvalue { i64, i64 } %22, 1
  store i64 %27, i64* %26, align 8
  %28 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %29 = load { i64, i64 }, { i64, i64 }* %28, align 8
  ret { i64, i64 } %29
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104impl16VirtualGuardImpl14exchangeStreamENS_6StreamE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i64 %1, i64 %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"class.c10::Stream", align 8
  %5 = alloca %"class.c10::Stream", align 8
  %6 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %7 = alloca %"class.c10::Stream", align 8
  %8 = bitcast %"class.c10::Stream"* %5 to { i64, i64 }*
  %9 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %8, i32 0, i32 0
  store i64 %1, i64* %9, align 8
  %10 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %8, i32 0, i32 1
  store i64 %2, i64* %10, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %6, align 8
  %11 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %6, align 8
  %12 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %11, i32 0, i32 1
  %13 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %12, align 8
  %14 = bitcast %"class.c10::Stream"* %7 to i8*
  %15 = bitcast %"class.c10::Stream"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %14, i8* align 8 %15, i64 16, i1 false)
  %16 = bitcast %"class.c10::Stream"* %7 to { i64, i64 }*
  %17 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %16, i32 0, i32 0
  %18 = load i64, i64* %17, align 8
  %19 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %16, i32 0, i32 1
  %20 = load i64, i64* %19, align 8
  %21 = bitcast %"struct.c10::Allocator"* %13 to { i64, i64 } (%"struct.c10::Allocator"*, i64, i64)***
  %22 = load { i64, i64 } (%"struct.c10::Allocator"*, i64, i64)**, { i64, i64 } (%"struct.c10::Allocator"*, i64, i64)*** %21, align 8
  %23 = getelementptr inbounds { i64, i64 } (%"struct.c10::Allocator"*, i64, i64)*, { i64, i64 } (%"struct.c10::Allocator"*, i64, i64)** %22, i64 9
  %24 = load { i64, i64 } (%"struct.c10::Allocator"*, i64, i64)*, { i64, i64 } (%"struct.c10::Allocator"*, i64, i64)** %23, align 8
  %25 = call { i64, i64 } %24(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %13, i64 %18, i64 %20)
  %26 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %27 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %26, i32 0, i32 0
  %28 = extractvalue { i64, i64 } %25, 0
  store i64 %28, i64* %27, align 8
  %29 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %26, i32 0, i32 1
  %30 = extractvalue { i64, i64 } %25, 1
  store i64 %30, i64* %29, align 8
  %31 = bitcast %"class.c10::Stream"* %4 to { i64, i64 }*
  %32 = load { i64, i64 }, { i64, i64 }* %31, align 8
  ret { i64, i64 } %32
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl16VirtualGuardImpl12destroyEventEPva(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i8* %1, i8 signext %2) unnamed_addr #8 comdat align 2 {
  %4 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %4, align 8
  %8 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %7, i32 0, i32 1
  %9 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %8, align 8
  %10 = load i8*, i8** %5, align 8
  %11 = load i8, i8* %6, align 1
  %12 = bitcast %"struct.c10::Allocator"* %9 to void (%"struct.c10::Allocator"*, i8*, i8)***
  %13 = load void (%"struct.c10::Allocator"*, i8*, i8)**, void (%"struct.c10::Allocator"*, i8*, i8)*** %12, align 8
  %14 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8*, i8)*, void (%"struct.c10::Allocator"*, i8*, i8)** %13, i64 10
  %15 = load void (%"struct.c10::Allocator"*, i8*, i8)*, void (%"struct.c10::Allocator"*, i8*, i8)** %14, align 8
  call void %15(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %9, i8* %10, i8 signext %11) #3
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl16VirtualGuardImpl6recordEPPvRKNS_6StreamEaNS_9EventFlagE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i8** %1, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %2, i8 signext %3, i32 %4) unnamed_addr #4 comdat align 2 {
  %6 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %7 = alloca i8**, align 8
  %8 = alloca %"class.c10::Stream"*, align 8
  %9 = alloca i8, align 1
  %10 = alloca i32, align 4
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %6, align 8
  store i8** %1, i8*** %7, align 8
  store %"class.c10::Stream"* %2, %"class.c10::Stream"** %8, align 8
  store i8 %3, i8* %9, align 1
  store i32 %4, i32* %10, align 4
  %11 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %6, align 8
  %12 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %11, i32 0, i32 1
  %13 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %12, align 8
  %14 = load i8**, i8*** %7, align 8
  %15 = load %"class.c10::Stream"*, %"class.c10::Stream"** %8, align 8
  %16 = load i8, i8* %9, align 1
  %17 = load i32, i32* %10, align 4
  %18 = bitcast %"struct.c10::Allocator"* %13 to void (%"struct.c10::Allocator"*, i8**, %"class.c10::Stream"*, i8, i32)***
  %19 = load void (%"struct.c10::Allocator"*, i8**, %"class.c10::Stream"*, i8, i32)**, void (%"struct.c10::Allocator"*, i8**, %"class.c10::Stream"*, i8, i32)*** %18, align 8
  %20 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8**, %"class.c10::Stream"*, i8, i32)*, void (%"struct.c10::Allocator"*, i8**, %"class.c10::Stream"*, i8, i32)** %19, i64 11
  %21 = load void (%"struct.c10::Allocator"*, i8**, %"class.c10::Stream"*, i8, i32)*, void (%"struct.c10::Allocator"*, i8**, %"class.c10::Stream"*, i8, i32)** %20, align 8
  call void %21(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %13, i8** %14, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %15, i8 signext %16, i32 %17)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl16VirtualGuardImpl5blockEPvRKNS_6StreamE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i8* %1, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %"class.c10::Stream"*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %4, align 8
  store i8* %1, i8** %5, align 8
  store %"class.c10::Stream"* %2, %"class.c10::Stream"** %6, align 8
  %7 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %4, align 8
  %8 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %7, i32 0, i32 1
  %9 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %8, align 8
  %10 = load i8*, i8** %5, align 8
  %11 = load %"class.c10::Stream"*, %"class.c10::Stream"** %6, align 8
  %12 = bitcast %"struct.c10::Allocator"* %9 to void (%"struct.c10::Allocator"*, i8*, %"class.c10::Stream"*)***
  %13 = load void (%"struct.c10::Allocator"*, i8*, %"class.c10::Stream"*)**, void (%"struct.c10::Allocator"*, i8*, %"class.c10::Stream"*)*** %12, align 8
  %14 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8*, %"class.c10::Stream"*)*, void (%"struct.c10::Allocator"*, i8*, %"class.c10::Stream"*)** %13, i64 12
  %15 = load void (%"struct.c10::Allocator"*, i8*, %"class.c10::Stream"*)*, void (%"struct.c10::Allocator"*, i8*, %"class.c10::Stream"*)** %14, align 8
  call void %15(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %9, i8* %10, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %11)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c104impl16VirtualGuardImpl10queryEventEPv(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i8* %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %4 = alloca i8*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  %6 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %5, i32 0, i32 1
  %7 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %6, align 8
  %8 = load i8*, i8** %4, align 8
  %9 = bitcast %"struct.c10::Allocator"* %7 to i1 (%"struct.c10::Allocator"*, i8*)***
  %10 = load i1 (%"struct.c10::Allocator"*, i8*)**, i1 (%"struct.c10::Allocator"*, i8*)*** %9, align 8
  %11 = getelementptr inbounds i1 (%"struct.c10::Allocator"*, i8*)*, i1 (%"struct.c10::Allocator"*, i8*)** %10, i64 13
  %12 = load i1 (%"struct.c10::Allocator"*, i8*)*, i1 (%"struct.c10::Allocator"*, i8*)** %11, align 8
  %13 = call zeroext i1 %12(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %7, i8* %8)
  ret i1 %13
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local signext i8 @_ZNK3c104impl16VirtualGuardImpl11deviceCountEv(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0) unnamed_addr #8 comdat align 2 {
  %2 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %2, align 8
  %3 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %3, i32 0, i32 1
  %5 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %4, align 8
  %6 = bitcast %"struct.c10::Allocator"* %5 to i8 (%"struct.c10::Allocator"*)***
  %7 = load i8 (%"struct.c10::Allocator"*)**, i8 (%"struct.c10::Allocator"*)*** %6, align 8
  %8 = getelementptr inbounds i8 (%"struct.c10::Allocator"*)*, i8 (%"struct.c10::Allocator"*)** %7, i64 14
  %9 = load i8 (%"struct.c10::Allocator"*)*, i8 (%"struct.c10::Allocator"*)** %8, align 8
  %10 = call signext i8 %9(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %5) #3
  ret i8 %10
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c104impl16VirtualGuardImpl11queryStreamERKNS_6StreamE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %4 = alloca %"class.c10::Stream"*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  store %"class.c10::Stream"* %1, %"class.c10::Stream"** %4, align 8
  %5 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  %6 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %5, i32 0, i32 1
  %7 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %6, align 8
  %8 = load %"class.c10::Stream"*, %"class.c10::Stream"** %4, align 8
  %9 = bitcast %"struct.c10::Allocator"* %7 to i1 (%"struct.c10::Allocator"*, %"class.c10::Stream"*)***
  %10 = load i1 (%"struct.c10::Allocator"*, %"class.c10::Stream"*)**, i1 (%"struct.c10::Allocator"*, %"class.c10::Stream"*)*** %9, align 8
  %11 = getelementptr inbounds i1 (%"struct.c10::Allocator"*, %"class.c10::Stream"*)*, i1 (%"struct.c10::Allocator"*, %"class.c10::Stream"*)** %10, i64 15
  %12 = load i1 (%"struct.c10::Allocator"*, %"class.c10::Stream"*)*, i1 (%"struct.c10::Allocator"*, %"class.c10::Stream"*)** %11, align 8
  %13 = call zeroext i1 %12(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %7, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %8)
  ret i1 %13
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl16VirtualGuardImpl17synchronizeStreamERKNS_6StreamE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %4 = alloca %"class.c10::Stream"*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  store %"class.c10::Stream"* %1, %"class.c10::Stream"** %4, align 8
  %5 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  %6 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %5, i32 0, i32 1
  %7 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %6, align 8
  %8 = load %"class.c10::Stream"*, %"class.c10::Stream"** %4, align 8
  %9 = bitcast %"struct.c10::Allocator"* %7 to void (%"struct.c10::Allocator"*, %"class.c10::Stream"*)***
  %10 = load void (%"struct.c10::Allocator"*, %"class.c10::Stream"*)**, void (%"struct.c10::Allocator"*, %"class.c10::Stream"*)*** %9, align 8
  %11 = getelementptr inbounds void (%"struct.c10::Allocator"*, %"class.c10::Stream"*)*, void (%"struct.c10::Allocator"*, %"class.c10::Stream"*)** %10, i64 16
  %12 = load void (%"struct.c10::Allocator"*, %"class.c10::Stream"*)*, void (%"struct.c10::Allocator"*, %"class.c10::Stream"*)** %11, align 8
  call void %12(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %7, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %8)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl16VirtualGuardImpl16synchronizeEventEPv(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i8* %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %4 = alloca i8*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  %6 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %5, i32 0, i32 1
  %7 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %6, align 8
  %8 = load i8*, i8** %4, align 8
  %9 = bitcast %"struct.c10::Allocator"* %7 to void (%"struct.c10::Allocator"*, i8*)***
  %10 = load void (%"struct.c10::Allocator"*, i8*)**, void (%"struct.c10::Allocator"*, i8*)*** %9, align 8
  %11 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8*)*, void (%"struct.c10::Allocator"*, i8*)** %10, i64 17
  %12 = load void (%"struct.c10::Allocator"*, i8*)*, void (%"struct.c10::Allocator"*, i8*)** %11, align 8
  call void %12(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %7, i8* %8)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl16VirtualGuardImpl17synchronizeDeviceEa(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i8 signext %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %4 = alloca i8, align 1
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  store i8 %1, i8* %4, align 1
  %5 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %3, align 8
  %6 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %5, i32 0, i32 1
  %7 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %6, align 8
  %8 = load i8, i8* %4, align 1
  %9 = bitcast %"struct.c10::Allocator"* %7 to void (%"struct.c10::Allocator"*, i8)***
  %10 = load void (%"struct.c10::Allocator"*, i8)**, void (%"struct.c10::Allocator"*, i8)*** %9, align 8
  %11 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8)*, void (%"struct.c10::Allocator"*, i8)** %10, i64 18
  %12 = load void (%"struct.c10::Allocator"*, i8)*, void (%"struct.c10::Allocator"*, i8)** %11, align 8
  call void %12(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %7, i8 signext %8)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl16VirtualGuardImpl21recordDataPtrOnStreamERKNS_7DataPtrERKNS_6StreamE(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, %"class.c10::DataPtr"* nonnull align 8 dereferenceable(26) %1, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %5 = alloca %"class.c10::DataPtr"*, align 8
  %6 = alloca %"class.c10::Stream"*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %4, align 8
  store %"class.c10::DataPtr"* %1, %"class.c10::DataPtr"** %5, align 8
  store %"class.c10::Stream"* %2, %"class.c10::Stream"** %6, align 8
  %7 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %4, align 8
  %8 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %7, i32 0, i32 1
  %9 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %8, align 8
  %10 = load %"class.c10::DataPtr"*, %"class.c10::DataPtr"** %5, align 8
  %11 = load %"class.c10::Stream"*, %"class.c10::Stream"** %6, align 8
  %12 = bitcast %"struct.c10::Allocator"* %9 to void (%"struct.c10::Allocator"*, %"class.c10::DataPtr"*, %"class.c10::Stream"*)***
  %13 = load void (%"struct.c10::Allocator"*, %"class.c10::DataPtr"*, %"class.c10::Stream"*)**, void (%"struct.c10::Allocator"*, %"class.c10::DataPtr"*, %"class.c10::Stream"*)*** %12, align 8
  %14 = getelementptr inbounds void (%"struct.c10::Allocator"*, %"class.c10::DataPtr"*, %"class.c10::Stream"*)*, void (%"struct.c10::Allocator"*, %"class.c10::DataPtr"*, %"class.c10::Stream"*)** %13, i64 19
  %15 = load void (%"struct.c10::Allocator"*, %"class.c10::DataPtr"*, %"class.c10::Stream"*)*, void (%"struct.c10::Allocator"*, %"class.c10::DataPtr"*, %"class.c10::Stream"*)** %14, align 8
  call void %15(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %9, %"class.c10::DataPtr"* nonnull align 8 dereferenceable(26) %10, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %11)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local double @_ZNK3c104impl16VirtualGuardImpl11elapsedTimeEPvS2_a(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0, i8* %1, i8* %2, i8 signext %3) unnamed_addr #4 comdat align 2 {
  %5 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8, align 1
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i8 %3, i8* %8, align 1
  %9 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %5, align 8
  %10 = getelementptr inbounds %"class.c10::impl::VirtualGuardImpl", %"class.c10::impl::VirtualGuardImpl"* %9, i32 0, i32 1
  %11 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %10, align 8
  %12 = load i8*, i8** %6, align 8
  %13 = load i8*, i8** %7, align 8
  %14 = load i8, i8* %8, align 1
  %15 = bitcast %"struct.c10::Allocator"* %11 to double (%"struct.c10::Allocator"*, i8*, i8*, i8)***
  %16 = load double (%"struct.c10::Allocator"*, i8*, i8*, i8)**, double (%"struct.c10::Allocator"*, i8*, i8*, i8)*** %15, align 8
  %17 = getelementptr inbounds double (%"struct.c10::Allocator"*, i8*, i8*, i8)*, double (%"struct.c10::Allocator"*, i8*, i8*, i8)** %16, i64 20
  %18 = load double (%"struct.c10::Allocator"*, i8*, i8*, i8)*, double (%"struct.c10::Allocator"*, i8*, i8*, i8)** %17, align 8
  %19 = call contract double %18(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %11, i8* %12, i8* %13, i8 signext %14)
  ret double %19
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl16VirtualGuardImplD0Ev(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.c10::impl::VirtualGuardImpl"*, align 8
  store %"class.c10::impl::VirtualGuardImpl"* %0, %"class.c10::impl::VirtualGuardImpl"** %2, align 8
  %3 = load %"class.c10::impl::VirtualGuardImpl"*, %"class.c10::impl::VirtualGuardImpl"** %2, align 8
  call void @_ZN3c104impl16VirtualGuardImplD2Ev(%"class.c10::impl::VirtualGuardImpl"* nonnull align 8 dereferenceable(16) %3) #3
  %4 = bitcast %"class.c10::impl::VirtualGuardImpl"* %3 to i8*
  call void @_ZdlPv(i8* %4) #27
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c104cuda10CUDAStream5queryEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %0) #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca i1, align 1
  %3 = alloca %"class.c10::cuda::CUDAStream"*, align 8
  %4 = alloca %"class.c10::DeviceGuard", align 8
  %5 = alloca %"struct.c10::Device", align 1
  %6 = alloca i32, align 4
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %"class.c10::cuda::CUDAStream"* %0, %"class.c10::cuda::CUDAStream"** %3, align 8
  %11 = load %"class.c10::cuda::CUDAStream"*, %"class.c10::cuda::CUDAStream"** %3, align 8
  %12 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %11, i32 0, i32 0
  %13 = call i16 @_ZNK3c106Stream6deviceEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %12) #3
  %14 = bitcast %"struct.c10::Device"* %5 to i16*
  store i16 %13, i16* %14, align 1
  %15 = bitcast %"struct.c10::Device"* %5 to i16*
  %16 = load i16, i16* %15, align 1
  call void @_ZN3c1011DeviceGuardC2ENS_6DeviceE(%"class.c10::DeviceGuard"* nonnull align 8 dereferenceable(24) %4, i16 %16)
  %17 = invoke %struct.CUstream_st* @_ZNK3c104cuda10CUDAStream6streamEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %11)
          to label %18 unwind label %24

18:                                               ; preds = %1
  %19 = invoke i32 @cudaStreamQuery(%struct.CUstream_st* %17)
          to label %20 unwind label %24

20:                                               ; preds = %18
  store i32 %19, i32* %6, align 4
  %21 = load i32, i32* %6, align 4
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %28

23:                                               ; preds = %20
  store i1 true, i1* %2, align 1
  store i32 1, i32* %9, align 4
  br label %43

24:                                               ; preds = %38, %32, %18, %1
  %25 = landingpad { i8*, i32 }
          cleanup
  %26 = extractvalue { i8*, i32 } %25, 0
  store i8* %26, i8** %7, align 8
  %27 = extractvalue { i8*, i32 } %25, 1
  store i32 %27, i32* %8, align 4
  call void @_ZN3c1011DeviceGuardD2Ev(%"class.c10::DeviceGuard"* nonnull align 8 dereferenceable(24) %4) #3
  br label %45

28:                                               ; preds = %20
  %29 = load i32, i32* %6, align 4
  %30 = icmp ne i32 %29, 600
  br i1 %30, label %31, label %38

31:                                               ; preds = %28
  br label %32

32:                                               ; preds = %31
  %33 = load i32, i32* %6, align 4
  store i32 %33, i32* %10, align 4
  %34 = load i32, i32* %10, align 4
  invoke void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %34, i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.21, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @__func__._ZNK3c104cuda10CUDAStream5queryEv, i64 0, i64 0), i32 122, i1 zeroext true)
          to label %35 unwind label %24

35:                                               ; preds = %32
  br label %36

36:                                               ; preds = %35
  br label %37

37:                                               ; preds = %36
  br label %41

38:                                               ; preds = %28
  %39 = invoke i32 @cudaGetLastError()
          to label %40 unwind label %24

40:                                               ; preds = %38
  br label %41

41:                                               ; preds = %40, %37
  br label %42

42:                                               ; preds = %41
  store i1 false, i1* %2, align 1
  store i32 1, i32* %9, align 4
  br label %43

43:                                               ; preds = %42, %23
  call void @_ZN3c1011DeviceGuardD2Ev(%"class.c10::DeviceGuard"* nonnull align 8 dereferenceable(24) %4) #3
  %44 = load i1, i1* %2, align 1
  ret i1 %44

45:                                               ; preds = %24
  %46 = load i8*, i8** %7, align 8
  %47 = load i32, i32* %8, align 4
  %48 = insertvalue { i8*, i32 } undef, i8* %46, 0
  %49 = insertvalue { i8*, i32 } %48, i32 %47, 1
  resume { i8*, i32 } %49
}

declare dso_local i32 @cudaStreamQuery(%struct.CUstream_st*) #1

; Function Attrs: nounwind
declare dso_local signext i8 @_ZN3c104cuda12device_countEv() #2

declare dso_local i32 @cudaEventQuery(%struct.CUevent_st*) #1

declare dso_local i32 @cudaStreamWaitEvent(%struct.CUstream_st*, %struct.CUevent_st*, i32) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local signext i8 @_ZNK3c106Stream12device_indexEv(%"class.c10::Stream"* nonnull align 8 dereferenceable(16) %0) #8 comdat align 2 {
  %2 = alloca %"class.c10::Stream"*, align 8
  store %"class.c10::Stream"* %0, %"class.c10::Stream"** %2, align 8
  %3 = load %"class.c10::Stream"*, %"class.c10::Stream"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::Stream", %"class.c10::Stream"* %3, i32 0, i32 0
  %5 = call signext i8 @_ZNK3c106Device5indexEv(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %4) #3
  ret i8 %5
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail17torchCheckMsgImplIJA20_caA49_caA2_cEEEDcPKcDpRKT_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, i8* %1, [20 x i8]* nonnull align 1 dereferenceable(20) %2, i8* nonnull align 1 dereferenceable(1) %3, [49 x i8]* nonnull align 1 dereferenceable(49) %4, i8* nonnull align 1 dereferenceable(1) %5, [2 x i8]* nonnull align 1 dereferenceable(2) %6) #4 comdat {
  %8 = alloca i8*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca [20 x i8]*, align 8
  %11 = alloca i8*, align 8
  %12 = alloca [49 x i8]*, align 8
  %13 = alloca i8*, align 8
  %14 = alloca [2 x i8]*, align 8
  %15 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %15, i8** %8, align 8
  store i8* %1, i8** %9, align 8
  store [20 x i8]* %2, [20 x i8]** %10, align 8
  store i8* %3, i8** %11, align 8
  store [49 x i8]* %4, [49 x i8]** %12, align 8
  store i8* %5, i8** %13, align 8
  store [2 x i8]* %6, [2 x i8]** %14, align 8
  %16 = load [20 x i8]*, [20 x i8]** %10, align 8
  %17 = load i8*, i8** %11, align 8
  %18 = load [49 x i8]*, [49 x i8]** %12, align 8
  %19 = load i8*, i8** %13, align 8
  %20 = load [2 x i8]*, [2 x i8]** %14, align 8
  call void @_ZN3c103strIJA20_caA49_caA2_cEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, [20 x i8]* nonnull align 1 dereferenceable(20) %16, i8* nonnull align 1 dereferenceable(1) %17, [49 x i8]* nonnull align 1 dereferenceable(49) %18, i8* nonnull align 1 dereferenceable(1) %19, [2 x i8]* nonnull align 1 dereferenceable(2) %20)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104cuda4impl13CUDAGuardImpl11createEventEPP10CUevent_stNS_9EventFlagE(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0, %struct.CUevent_st** %1, i32 %2) #4 comdat align 2 {
  %4 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  %5 = alloca %struct.CUevent_st**, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %"struct.c10::impl::PyInterpreter"*, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  store %struct.CUevent_st** %1, %struct.CUevent_st*** %5, align 8
  store i32 %2, i32* %6, align 4
  %10 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %4, align 8
  store i32 0, i32* %7, align 4
  %11 = load i32, i32* %6, align 4
  switch i32 %11, label %14 [
    i32 0, label %12
    i32 1, label %13
  ]

12:                                               ; preds = %3
  store i32 2, i32* %7, align 4
  br label %16

13:                                               ; preds = %3
  store i32 0, i32* %7, align 4
  br label %16

14:                                               ; preds = %3
  %15 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.27, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl11createEventEPP10CUevent_stNS_9EventFlagE, i64 0, i64 0), i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i32 95, i8* %15) #25
  unreachable

16:                                               ; preds = %13, %12
  br label %17

17:                                               ; preds = %16
  %18 = load %struct.CUevent_st**, %struct.CUevent_st*** %5, align 8
  %19 = load i32, i32* %7, align 4
  %20 = call i32 @cudaEventCreateWithFlags(%struct.CUevent_st** %18, i32 %19)
  store i32 %20, i32* %8, align 4
  %21 = load i32, i32* %8, align 4
  call void @_ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib(i32 %21, i8* getelementptr inbounds ([112 x i8], [112 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__func__._ZNK3c104cuda4impl13CUDAGuardImpl11createEventEPP10CUevent_stNS_9EventFlagE, i64 0, i64 0), i32 98, i1 zeroext true)
  br label %22

22:                                               ; preds = %17
  %23 = call %"struct.c10::impl::PyInterpreter"* @_ZN3c104impl8GPUTrace9get_traceEv()
  store %"struct.c10::impl::PyInterpreter"* %23, %"struct.c10::impl::PyInterpreter"** %9, align 8
  %24 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %9, align 8
  %25 = icmp ne %"struct.c10::impl::PyInterpreter"* %24, null
  br i1 %25, label %26, label %35

26:                                               ; preds = %22
  %27 = load %"struct.c10::impl::PyInterpreter"*, %"struct.c10::impl::PyInterpreter"** %9, align 8
  %28 = call %"struct.c10::Allocator"* @_ZNK3c104impl13PyInterpreterptEv(%"struct.c10::impl::PyInterpreter"* nonnull align 8 dereferenceable(8) %27) #3
  %29 = load %struct.CUevent_st**, %struct.CUevent_st*** %5, align 8
  %30 = ptrtoint %struct.CUevent_st** %29 to i64
  %31 = bitcast %"struct.c10::Allocator"* %28 to void (%"struct.c10::Allocator"*, i8, i64)***
  %32 = load void (%"struct.c10::Allocator"*, i8, i64)**, void (%"struct.c10::Allocator"*, i8, i64)*** %31, align 8
  %33 = getelementptr inbounds void (%"struct.c10::Allocator"*, i8, i64)*, void (%"struct.c10::Allocator"*, i8, i64)** %32, i64 24
  %34 = load void (%"struct.c10::Allocator"*, i8, i64)*, void (%"struct.c10::Allocator"*, i8, i64)** %33, align 8
  call void %34(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %28, i8 signext 1, i64 %30)
  br label %35

35:                                               ; preds = %26, %22
  ret void
}

declare dso_local i32 @cudaEventRecord(%struct.CUevent_st*, %struct.CUstream_st*) #1

declare dso_local i32 @cudaEventCreateWithFlags(%struct.CUevent_st**, i32) #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c103strIJA20_caA49_caA2_cEEEDcDpRKT_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, [20 x i8]* nonnull align 1 dereferenceable(20) %1, i8* nonnull align 1 dereferenceable(1) %2, [49 x i8]* nonnull align 1 dereferenceable(49) %3, i8* nonnull align 1 dereferenceable(1) %4, [2 x i8]* nonnull align 1 dereferenceable(2) %5) #4 comdat {
  %7 = alloca i8*, align 8
  %8 = alloca [20 x i8]*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca [49 x i8]*, align 8
  %11 = alloca i8*, align 8
  %12 = alloca [2 x i8]*, align 8
  %13 = alloca i8*, align 8
  %14 = alloca i8*, align 8
  %15 = alloca i8*, align 8
  %16 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %16, i8** %7, align 8
  store [20 x i8]* %1, [20 x i8]** %8, align 8
  store i8* %2, i8** %9, align 8
  store [49 x i8]* %3, [49 x i8]** %10, align 8
  store i8* %4, i8** %11, align 8
  store [2 x i8]* %5, [2 x i8]** %12, align 8
  %17 = load [20 x i8]*, [20 x i8]** %8, align 8
  %18 = getelementptr inbounds [20 x i8], [20 x i8]* %17, i64 0, i64 0
  store i8* %18, i8** %13, align 8
  %19 = load i8*, i8** %9, align 8
  %20 = load [49 x i8]*, [49 x i8]** %10, align 8
  %21 = getelementptr inbounds [49 x i8], [49 x i8]* %20, i64 0, i64 0
  store i8* %21, i8** %14, align 8
  %22 = load i8*, i8** %11, align 8
  %23 = load [2 x i8]*, [2 x i8]** %12, align 8
  %24 = getelementptr inbounds [2 x i8], [2 x i8]* %23, i64 0, i64 0
  store i8* %24, i8** %15, align 8
  call void @_ZN3c106detail12_str_wrapperIJPKcRKaS3_S5_S3_EE4callB5cxx11ERKS3_S5_S8_S5_S8_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, i8** nonnull align 8 dereferenceable(8) %13, i8* nonnull align 1 dereferenceable(1) %19, i8** nonnull align 8 dereferenceable(8) %14, i8* nonnull align 1 dereferenceable(1) %22, i8** nonnull align 8 dereferenceable(8) %15)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail12_str_wrapperIJPKcRKaS3_S5_S3_EE4callB5cxx11ERKS3_S5_S8_S5_S8_(%"class.std::__cxx11::basic_string"* noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, i8** nonnull align 8 dereferenceable(8) %1, i8* nonnull align 1 dereferenceable(1) %2, i8** nonnull align 8 dereferenceable(8) %3, i8* nonnull align 1 dereferenceable(1) %4, i8** nonnull align 8 dereferenceable(8) %5) #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %7 = alloca i8*, align 8
  %8 = alloca i8**, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i8**, align 8
  %11 = alloca i8*, align 8
  %12 = alloca i8**, align 8
  %13 = alloca %"class.std::__cxx11::basic_ostringstream", align 8
  %14 = alloca i8*, align 8
  %15 = alloca i32, align 4
  %16 = bitcast %"class.std::__cxx11::basic_string"* %0 to i8*
  store i8* %16, i8** %7, align 8
  store i8** %1, i8*** %8, align 8
  store i8* %2, i8** %9, align 8
  store i8** %3, i8*** %10, align 8
  store i8* %4, i8** %11, align 8
  store i8** %5, i8*** %12, align 8
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %13)
  %17 = bitcast %"class.std::__cxx11::basic_ostringstream"* %13 to %"class.std::basic_ostream"*
  %18 = load i8**, i8*** %8, align 8
  %19 = load i8*, i8** %9, align 8
  %20 = load i8**, i8*** %10, align 8
  %21 = load i8*, i8** %11, align 8
  %22 = load i8**, i8*** %12, align 8
  %23 = invoke nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJaS3_aS3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %17, i8** nonnull align 8 dereferenceable(8) %18, i8* nonnull align 1 dereferenceable(1) %19, i8** nonnull align 8 dereferenceable(8) %20, i8* nonnull align 1 dereferenceable(1) %21, i8** nonnull align 8 dereferenceable(8) %22)
          to label %24 unwind label %26

24:                                               ; preds = %6
  invoke void @_ZNKSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEE3strEv(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %0, %"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %13)
          to label %25 unwind label %26

25:                                               ; preds = %24
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %13) #3
  ret void

26:                                               ; preds = %24, %6
  %27 = landingpad { i8*, i32 }
          cleanup
  %28 = extractvalue { i8*, i32 } %27, 0
  store i8* %28, i8** %14, align 8
  %29 = extractvalue { i8*, i32 } %27, 1
  store i32 %29, i32* %15, align 4
  call void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112) %13) #3
  br label %30

30:                                               ; preds = %26
  %31 = load i8*, i8** %14, align 8
  %32 = load i32, i32* %15, align 4
  %33 = insertvalue { i8*, i32 } undef, i8* %31, 0
  %34 = insertvalue { i8*, i32 } %33, i32 %32, 1
  resume { i8*, i32 } %34
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJaS3_aS3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8** nonnull align 8 dereferenceable(8) %1, i8* nonnull align 1 dereferenceable(1) %2, i8** nonnull align 8 dereferenceable(8) %3, i8* nonnull align 1 dereferenceable(1) %4, i8** nonnull align 8 dereferenceable(8) %5) #4 comdat {
  %7 = alloca %"class.std::basic_ostream"*, align 8
  %8 = alloca i8**, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i8**, align 8
  %11 = alloca i8*, align 8
  %12 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %7, align 8
  store i8** %1, i8*** %8, align 8
  store i8* %2, i8** %9, align 8
  store i8** %3, i8*** %10, align 8
  store i8* %4, i8** %11, align 8
  store i8** %5, i8*** %12, align 8
  %13 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %7, align 8
  %14 = load i8**, i8*** %8, align 8
  %15 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %13, i8** nonnull align 8 dereferenceable(8) %14)
  %16 = load i8*, i8** %9, align 8
  %17 = load i8**, i8*** %10, align 8
  %18 = load i8*, i8** %11, align 8
  %19 = load i8**, i8*** %12, align 8
  %20 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIaJPKcaS3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %15, i8* nonnull align 1 dereferenceable(1) %16, i8** nonnull align 8 dereferenceable(8) %17, i8* nonnull align 1 dereferenceable(1) %18, i8** nonnull align 8 dereferenceable(8) %19)
  ret %"class.std::basic_ostream"* %20
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIaJPKcaS3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8* nonnull align 1 dereferenceable(1) %1, i8** nonnull align 8 dereferenceable(8) %2, i8* nonnull align 1 dereferenceable(1) %3, i8** nonnull align 8 dereferenceable(8) %4) #4 comdat {
  %6 = alloca %"class.std::basic_ostream"*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8**, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %6, align 8
  store i8* %1, i8** %7, align 8
  store i8** %2, i8*** %8, align 8
  store i8* %3, i8** %9, align 8
  store i8** %4, i8*** %10, align 8
  %11 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %6, align 8
  %12 = load i8*, i8** %7, align 8
  %13 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIaEERSoS2_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %11, i8* nonnull align 1 dereferenceable(1) %12)
  %14 = load i8**, i8*** %8, align 8
  %15 = load i8*, i8** %9, align 8
  %16 = load i8**, i8*** %10, align 8
  %17 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJaS3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %13, i8** nonnull align 8 dereferenceable(8) %14, i8* nonnull align 1 dereferenceable(1) %15, i8** nonnull align 8 dereferenceable(8) %16)
  ret %"class.std::basic_ostream"* %17
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIaEERSoS2_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8* nonnull align 1 dereferenceable(1) %1) #4 comdat {
  %3 = alloca %"class.std::basic_ostream"*, align 8
  %4 = alloca i8*, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %3, align 8
  %6 = load i8*, i8** %4, align 8
  %7 = load i8, i8* %6, align 1
  %8 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_a(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %5, i8 signext %7)
  %9 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %3, align 8
  ret %"class.std::basic_ostream"* %9
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcJaS3_EEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8** nonnull align 8 dereferenceable(8) %1, i8* nonnull align 1 dereferenceable(1) %2, i8** nonnull align 8 dereferenceable(8) %3) #4 comdat {
  %5 = alloca %"class.std::basic_ostream"*, align 8
  %6 = alloca i8**, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %5, align 8
  store i8** %1, i8*** %6, align 8
  store i8* %2, i8** %7, align 8
  store i8** %3, i8*** %8, align 8
  %9 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %5, align 8
  %10 = load i8**, i8*** %6, align 8
  %11 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %9, i8** nonnull align 8 dereferenceable(8) %10)
  %12 = load i8*, i8** %7, align 8
  %13 = load i8**, i8*** %8, align 8
  %14 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIaJPKcEEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %11, i8* nonnull align 1 dereferenceable(1) %12, i8** nonnull align 8 dereferenceable(8) %13)
  ret %"class.std::basic_ostream"* %14
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIaJPKcEEERSoS4_RKT_DpRKT0_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %0, i8* nonnull align 1 dereferenceable(1) %1, i8** nonnull align 8 dereferenceable(8) %2) #4 comdat {
  %4 = alloca %"class.std::basic_ostream"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8**, align 8
  store %"class.std::basic_ostream"* %0, %"class.std::basic_ostream"** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8** %2, i8*** %6, align 8
  %7 = load %"class.std::basic_ostream"*, %"class.std::basic_ostream"** %4, align 8
  %8 = load i8*, i8** %5, align 8
  %9 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIaEERSoS2_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %7, i8* nonnull align 1 dereferenceable(1) %8)
  %10 = load i8**, i8*** %6, align 8
  %11 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZN3c106detail4_strIPKcEERSoS4_RKT_(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %9, i8** nonnull align 8 dereferenceable(8) %10)
  ret %"class.std::basic_ostream"* %11
}

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_a(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8 signext) #1

declare dso_local i32 @cudaEventDestroy(%struct.CUevent_st*) #1

declare dso_local void @_ZN3c104cuda20setCurrentCUDAStreamENS0_10CUDAStreamE(i64, i64) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104cuda10CUDAStream6unwrapEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %0) #8 comdat align 2 {
  %2 = alloca %"class.c10::Stream", align 8
  %3 = alloca %"class.c10::cuda::CUDAStream"*, align 8
  store %"class.c10::cuda::CUDAStream"* %0, %"class.c10::cuda::CUDAStream"** %3, align 8
  %4 = load %"class.c10::cuda::CUDAStream"*, %"class.c10::cuda::CUDAStream"** %3, align 8
  %5 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %4, i32 0, i32 0
  %6 = bitcast %"class.c10::Stream"* %2 to i8*
  %7 = bitcast %"class.c10::Stream"* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %6, i8* align 8 %7, i64 16, i1 false)
  %8 = bitcast %"class.c10::Stream"* %2 to { i64, i64 }*
  %9 = load { i64, i64 }, { i64, i64 }* %8, align 8
  ret { i64, i64 } %9
}

declare dso_local { i64, i64 } @_ZN3c104cuda17getStreamFromPoolEia(i32, i8 signext) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104cuda10CUDAStreamcvNS_6StreamEEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %0) #8 comdat align 2 {
  %2 = alloca %"class.c10::Stream", align 8
  %3 = alloca %"class.c10::cuda::CUDAStream"*, align 8
  store %"class.c10::cuda::CUDAStream"* %0, %"class.c10::cuda::CUDAStream"** %3, align 8
  %4 = load %"class.c10::cuda::CUDAStream"*, %"class.c10::cuda::CUDAStream"** %3, align 8
  %5 = call { i64, i64 } @_ZNK3c104cuda10CUDAStream6unwrapEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %4)
  %6 = bitcast %"class.c10::Stream"* %2 to { i64, i64 }*
  %7 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %6, i32 0, i32 0
  %8 = extractvalue { i64, i64 } %5, 0
  store i64 %8, i64* %7, align 8
  %9 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %6, i32 0, i32 1
  %10 = extractvalue { i64, i64 } %5, 1
  store i64 %10, i64* %9, align 8
  %11 = bitcast %"class.c10::Stream"* %2 to { i64, i64 }*
  %12 = load { i64, i64 }, { i64, i64 }* %11, align 8
  ret { i64, i64 } %12
}

declare dso_local { i64, i64 } @_ZN3c104cuda17getStreamFromPoolEba(i1 zeroext, i8 signext) #1

declare dso_local { i64, i64 } @_ZN3c104cuda20getDefaultCUDAStreamEa(i8 signext) #1

declare dso_local void @__cxa_pure_virtual() unnamed_addr

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104impl24DeviceGuardImplInterface16getDefaultStreamENS_6DeviceE(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, i16 %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::Device", align 1
  %4 = alloca %"struct.c10::Allocator"*, align 8
  %5 = bitcast %"struct.c10::Device"* %3 to i16*
  store i16 %1, i16* %5, align 1
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %4, align 8
  %6 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %4, align 8
  %7 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.11, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface16getDefaultStreamENS_6DeviceE, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 114, i8* %7) #25
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104impl24DeviceGuardImplInterface23getStreamFromGlobalPoolENS_6DeviceEb(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, i16 %1, i1 zeroext %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"struct.c10::Device", align 1
  %5 = alloca %"struct.c10::Allocator"*, align 8
  %6 = alloca i8, align 1
  %7 = bitcast %"struct.c10::Device"* %4 to i16*
  store i16 %1, i16* %7, align 1
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %5, align 8
  %8 = zext i1 %2 to i8
  store i8 %8, i8* %6, align 1
  %9 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %5, align 8
  %10 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.12, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface23getStreamFromGlobalPoolENS_6DeviceEb, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 123, i8* %10) #25
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64, i64 } @_ZNK3c104impl24DeviceGuardImplInterface12getNewStreamENS_6DeviceEi(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, i16 %1, i32 %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"struct.c10::Device", align 1
  %5 = alloca %"struct.c10::Allocator"*, align 8
  %6 = alloca i32, align 4
  %7 = bitcast %"struct.c10::Device"* %4 to i16*
  store i16 %1, i16* %7, align 1
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %5, align 8
  %9 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.13, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface12getNewStreamENS_6DeviceEi, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 133, i8* %9) #25
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl24DeviceGuardImplInterface12destroyEventEPva(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, i8* %1, i8 signext %2) unnamed_addr #8 comdat align 2 {
  %4 = alloca %"struct.c10::Allocator"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %4, align 8
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl24DeviceGuardImplInterface6recordEPPvRKNS_6StreamEaNS_9EventFlagE(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, i8** %1, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %2, i8 signext %3, i32 %4) unnamed_addr #4 comdat align 2 {
  %6 = alloca %"struct.c10::Allocator"*, align 8
  %7 = alloca i8**, align 8
  %8 = alloca %"class.c10::Stream"*, align 8
  %9 = alloca i8, align 1
  %10 = alloca i32, align 4
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %6, align 8
  store i8** %1, i8*** %7, align 8
  store %"class.c10::Stream"* %2, %"class.c10::Stream"** %8, align 8
  store i8 %3, i8* %9, align 1
  store i32 %4, i32* %10, align 4
  %11 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %6, align 8
  %12 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.14, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface6recordEPPvRKNS_6StreamEaNS_9EventFlagE, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 160, i8* %12) #25
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl24DeviceGuardImplInterface5blockEPvRKNS_6StreamE(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, i8* %1, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %2) unnamed_addr #4 comdat align 2 {
  %4 = alloca %"struct.c10::Allocator"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %"class.c10::Stream"*, align 8
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %4, align 8
  store i8* %1, i8** %5, align 8
  store %"class.c10::Stream"* %2, %"class.c10::Stream"** %6, align 8
  %7 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %4, align 8
  %8 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.14, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface5blockEPvRKNS_6StreamE, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 172, i8* %8) #25
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c104impl24DeviceGuardImplInterface10queryEventEPv(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, i8* %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::Allocator"*, align 8
  %4 = alloca i8*, align 8
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %3, align 8
  %6 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.14, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface10queryEventEPv, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 182, i8* %6) #25
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c104impl24DeviceGuardImplInterface11queryStreamERKNS_6StreamE(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::Allocator"*, align 8
  %4 = alloca %"class.c10::Stream"*, align 8
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %3, align 8
  store %"class.c10::Stream"* %1, %"class.c10::Stream"** %4, align 8
  %5 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %3, align 8
  %6 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.15, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface11queryStreamERKNS_6StreamE, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 197, i8* %6) #25
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl24DeviceGuardImplInterface17synchronizeStreamERKNS_6StreamE(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::Allocator"*, align 8
  %4 = alloca %"class.c10::Stream"*, align 8
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %3, align 8
  store %"class.c10::Stream"* %1, %"class.c10::Stream"** %4, align 8
  %5 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %3, align 8
  %6 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([47 x i8], [47 x i8]* @.str.16, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface17synchronizeStreamERKNS_6StreamE, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 205, i8* %6) #25
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl24DeviceGuardImplInterface16synchronizeEventEPv(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, i8* %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::Allocator"*, align 8
  %4 = alloca i8*, align 8
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %3, align 8
  %6 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.17, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface16synchronizeEventEPv, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 213, i8* %6) #25
  unreachable
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl24DeviceGuardImplInterface17synchronizeDeviceEa(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, i8 signext %1) unnamed_addr #4 comdat align 2 {
  %3 = alloca %"struct.c10::Allocator"*, align 8
  %4 = alloca i8, align 1
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %3, align 8
  store i8 %1, i8* %4, align 1
  %5 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %3, align 8
  %6 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.18, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface17synchronizeDeviceEa, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 222, i8* %6) #25
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNK3c104impl24DeviceGuardImplInterface21recordDataPtrOnStreamERKNS_7DataPtrERKNS_6StreamE(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, %"class.c10::DataPtr"* nonnull align 8 dereferenceable(26) %1, %"class.c10::Stream"* nonnull align 8 dereferenceable(16) %2) unnamed_addr #8 comdat align 2 {
  %4 = alloca %"struct.c10::Allocator"*, align 8
  %5 = alloca %"class.c10::DataPtr"*, align 8
  %6 = alloca %"class.c10::Stream"*, align 8
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %4, align 8
  store %"class.c10::DataPtr"* %1, %"class.c10::DataPtr"** %5, align 8
  store %"class.c10::Stream"* %2, %"class.c10::Stream"** %6, align 8
  %7 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %4, align 8
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local double @_ZNK3c104impl24DeviceGuardImplInterface11elapsedTimeEPvS2_a(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0, i8* %1, i8* %2, i8 signext %3) unnamed_addr #4 comdat align 2 {
  %5 = alloca %"struct.c10::Allocator"*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8, align 1
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i8 %3, i8* %8, align 1
  %9 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %5, align 8
  %10 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.19, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__func__._ZNK3c104impl24DeviceGuardImplInterface11elapsedTimeEPvS2_a, i64 0, i64 0), i8* getelementptr inbounds ([123 x i8], [123 x i8]* @.str.9, i64 0, i64 0), i32 240, i8* %10) #25
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c104impl24DeviceGuardImplInterfaceD0Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.c10::Allocator"*, align 8
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %2, align 8
  %3 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %2, align 8
  call void @llvm.trap() #26
  unreachable
}

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #14

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNKSt19_Optional_base_implIN3c106DeviceESt14_Optional_baseIS1_Lb1ELb1EEE13_M_is_engagedEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  %4 = bitcast %"class.std::ios_base::Init"* %3 to %"struct.std::_Optional_base.54"*
  %5 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %4, i32 0, i32 0
  %6 = bitcast %"struct.std::_Optional_payload.56"* %5 to %"struct.std::_Optional_payload_base.57"*
  %7 = getelementptr inbounds %"struct.std::_Optional_payload_base.57", %"struct.std::_Optional_payload_base.57"* %6, i32 0, i32 1
  %8 = load i8, i8* %7, align 1
  %9 = trunc i8 %8 to i1
  ret i1 %9
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNSt19_Optional_base_implIN3c106DeviceESt14_Optional_baseIS1_Lb1ELb1EEE6_M_getEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  br label %4

4:                                                ; preds = %1
  br label %5

5:                                                ; preds = %4
  br label %6

6:                                                ; preds = %5
  %7 = bitcast %"class.std::ios_base::Init"* %3 to %"struct.std::_Optional_base.54"*
  %8 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %7, i32 0, i32 0
  %9 = bitcast %"struct.std::_Optional_payload.56"* %8 to %"struct.std::_Optional_payload_base.57"*
  %10 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNSt22_Optional_payload_baseIN3c106DeviceEE6_M_getEv(%"struct.std::_Optional_payload_base.57"* nonnull align 1 dereferenceable(3) %9) #3
  ret %"struct.c10::Device"* %10
}

; Function Attrs: mustprogress noinline noreturn optnone uwtable
define linkonce_odr dso_local void @_ZSt27__throw_bad_optional_accessv() #12 comdat {
  %1 = call i8* @__cxa_allocate_exception(i64 8) #3
  %2 = bitcast i8* %1 to %"struct.c10::cuda::impl::CUDAGuardImpl"*
  %3 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %2 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 16 %3, i8 0, i64 8, i1 false)
  call void @_ZNSt19bad_optional_accessC2Ev(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %2) #3
  call void @__cxa_throw(i8* %1, i8* bitcast ({ i8*, i8*, i8* }* @_ZTISt19bad_optional_access to i8*), i8* bitcast (void (%"struct.c10::cuda::impl::CUDAGuardImpl"*)* @_ZNSt19bad_optional_accessD2Ev to i8*)) #25
  unreachable
}

declare dso_local i8* @__cxa_allocate_exception(i64)

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #15

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt19bad_optional_accessC2Ev(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %3 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %4 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %3 to %"struct.c10::Allocator"*
  call void @_ZNSt9exceptionC2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %4) #3
  %5 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %3 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [5 x i8*] }, { [5 x i8*] }* @_ZTVSt19bad_optional_access, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %5, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt19bad_optional_accessD2Ev(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %3 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %4 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %3 to %"struct.c10::Allocator"*
  call void @_ZNSt9exceptionD2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %4) #3
  ret void
}

declare dso_local void @__cxa_throw(i8*, i8*, i8*)

; Function Attrs: nounwind
declare dso_local void @_ZNSt9exceptionD2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8)) unnamed_addr #2

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt9exceptionC2Ev(%"struct.c10::Allocator"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.c10::Allocator"*, align 8
  store %"struct.c10::Allocator"* %0, %"struct.c10::Allocator"** %2, align 8
  %3 = load %"struct.c10::Allocator"*, %"struct.c10::Allocator"** %2, align 8
  %4 = bitcast %"struct.c10::Allocator"* %3 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ({ [5 x i8*] }, { [5 x i8*] }* @_ZTVSt9exception, i32 0, inrange i32 0, i32 2) to i32 (...)**), i32 (...)*** %4, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt19bad_optional_accessD0Ev(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %3 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  call void @_ZNSt19bad_optional_accessD2Ev(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %3) #3
  %4 = bitcast %"struct.c10::cuda::impl::CUDAGuardImpl"* %3 to i8*
  call void @_ZdlPv(i8* %4) #27
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i8* @_ZNKSt19bad_optional_access4whatEv(%"struct.c10::cuda::impl::CUDAGuardImpl"* nonnull align 8 dereferenceable(8) %0) unnamed_addr #8 comdat align 2 {
  %2 = alloca %"struct.c10::cuda::impl::CUDAGuardImpl"*, align 8
  store %"struct.c10::cuda::impl::CUDAGuardImpl"* %0, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  %3 = load %"struct.c10::cuda::impl::CUDAGuardImpl"*, %"struct.c10::cuda::impl::CUDAGuardImpl"** %2, align 8
  ret i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.40, i64 0, i64 0)
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNSt22_Optional_payload_baseIN3c106DeviceEE6_M_getEv(%"struct.std::_Optional_payload_base.57"* nonnull align 1 dereferenceable(3) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload_base.57"*, align 8
  store %"struct.std::_Optional_payload_base.57"* %0, %"struct.std::_Optional_payload_base.57"** %2, align 8
  %3 = load %"struct.std::_Optional_payload_base.57"*, %"struct.std::_Optional_payload_base.57"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_payload_base.57", %"struct.std::_Optional_payload_base.57"* %3, i32 0, i32 0
  %5 = bitcast %"union.std::_Optional_payload_base<c10::Device>::_Storage"* %4 to %"struct.c10::Device"*
  ret %"struct.c10::Device"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt14_Optional_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0EEC2Ev(%"struct.std::_Optional_base.60"* nonnull align 8 dereferenceable(24) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_base.60"*, align 8
  store %"struct.std::_Optional_base.60"* %0, %"struct.std::_Optional_base.60"** %2, align 8
  %3 = load %"struct.std::_Optional_base.60"*, %"struct.std::_Optional_base.60"** %2, align 8
  %4 = bitcast %"struct.std::_Optional_base.60"* %3 to %"class.std::ios_base::Init"*
  %5 = getelementptr inbounds %"struct.std::_Optional_base.60", %"struct.std::_Optional_base.60"* %3, i32 0, i32 0
  call void @_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0ELb0EEC2Ev(%"struct.std::_Optional_payload.62"* nonnull align 8 dereferenceable(17) %5) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb0ELb0ELb0EEC2Ev(%"struct.std::_Optional_payload.62"* nonnull align 8 dereferenceable(17) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload.62"*, align 8
  store %"struct.std::_Optional_payload.62"* %0, %"struct.std::_Optional_payload.62"** %2, align 8
  %3 = load %"struct.std::_Optional_payload.62"*, %"struct.std::_Optional_payload.62"** %2, align 8
  %4 = bitcast %"struct.std::_Optional_payload.62"* %3 to %"struct.std::_Optional_payload.63"*
  call void @_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb1ELb0ELb0EEC2Ev(%"struct.std::_Optional_payload.63"* nonnull align 8 dereferenceable(17) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt17_Optional_payloadIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEELb1ELb0ELb0EEC2Ev(%"struct.std::_Optional_payload.63"* nonnull align 8 dereferenceable(17) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload.63"*, align 8
  store %"struct.std::_Optional_payload.63"* %0, %"struct.std::_Optional_payload.63"** %2, align 8
  %3 = load %"struct.std::_Optional_payload.63"*, %"struct.std::_Optional_payload.63"** %2, align 8
  %4 = bitcast %"struct.std::_Optional_payload.63"* %3 to %"struct.std::_Optional_payload_base.64"*
  call void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEEC2Ev(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEEC2Ev(%"struct.std::_Optional_payload_base.64"* nonnull align 8 dereferenceable(17) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload_base.64"*, align 8
  store %"struct.std::_Optional_payload_base.64"* %0, %"struct.std::_Optional_payload_base.64"** %2, align 8
  %3 = load %"struct.std::_Optional_payload_base.64"*, %"struct.std::_Optional_payload_base.64"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_payload_base.64", %"struct.std::_Optional_payload_base.64"* %3, i32 0, i32 0
  call void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE8_StorageIS6_Lb0EEC2Ev(%"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"* nonnull align 8 dereferenceable(16) %4) #3
  %5 = getelementptr inbounds %"struct.std::_Optional_payload_base.64", %"struct.std::_Optional_payload_base.64"* %3, i32 0, i32 1
  store i8 0, i8* %5, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c104impl17InlineDeviceGuardINS0_4cuda4impl13CUDAGuardImplEEEE8_StorageIS6_Lb0EEC2Ev(%"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"* nonnull align 8 dereferenceable(16) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"*, align 8
  store %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"* %0, %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"** %2, align 8
  %3 = load %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"*, %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"** %2, align 8
  %4 = bitcast %"union.std::_Optional_payload_base<c10::impl::InlineDeviceGuard<c10::cuda::impl::CUDAGuardImpl>>::_Storage"* %3 to %"class.std::ios_base::Init"*
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK2at10TensorBase7definedEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"class.at::TensorBase"*, align 8
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %2, align 8
  %3 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %2, align 8
  %4 = getelementptr inbounds %"class.at::TensorBase", %"class.at::TensorBase"* %3, i32 0, i32 0
  %5 = call zeroext i1 @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEcvbEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %4) #3
  ret i1 %5
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i16 @_ZNK2at10TensorBase6deviceEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0) #4 comdat align 2 {
  %2 = alloca %"struct.c10::Device", align 1
  %3 = alloca %"class.at::TensorBase"*, align 8
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %3, align 8
  %4 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %3, align 8
  %5 = getelementptr inbounds %"class.at::TensorBase", %"class.at::TensorBase"* %4, i32 0, i32 0
  %6 = call %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %5) #3
  %7 = call i16 @_ZNK3c1010TensorImpl6deviceEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6)
  %8 = bitcast %"struct.c10::Device"* %2 to i16*
  store i16 %7, i16* %8, align 1
  %9 = bitcast %"struct.c10::Device"* %2 to i16*
  %10 = load i16, i16* %9, align 1
  ret i16 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt8optionalIN3c106DeviceEEC2IS1_Lb1EEEOT_(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %0, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %1) unnamed_addr #5 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.std::optional.53"*, align 8
  %4 = alloca %"struct.c10::Device"*, align 8
  %5 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::optional.53"* %0, %"class.std::optional.53"** %3, align 8
  store %"struct.c10::Device"* %1, %"struct.c10::Device"** %4, align 8
  %6 = load %"class.std::optional.53"*, %"class.std::optional.53"** %3, align 8
  %7 = bitcast %"class.std::optional.53"* %6 to %"struct.std::_Optional_base.54"*
  %8 = load %"struct.c10::Device"*, %"struct.c10::Device"** %4, align 8
  %9 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZSt7forwardIN3c106DeviceEEOT_RNSt16remove_referenceIS2_E4typeE(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %8) #3
  invoke void @_ZNSt14_Optional_baseIN3c106DeviceELb1ELb1EEC2IJS1_ELb0EEESt10in_place_tDpOT_(%"struct.std::_Optional_base.54"* nonnull align 1 dereferenceable(3) %7, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %9)
          to label %10 unwind label %12

10:                                               ; preds = %2
  %11 = bitcast %"class.std::optional.53"* %6 to %"class.std::ios_base::Init"*
  ret void

12:                                               ; preds = %2
  %13 = landingpad { i8*, i32 }
          catch i8* null
  %14 = extractvalue { i8*, i32 } %13, 0
  call void @__clang_call_terminate(i8* %14) #26
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt8optionalIN3c106DeviceEEC2ESt9nullopt_t(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init", align 1
  %3 = alloca %"class.std::optional.53"*, align 8
  store %"class.std::optional.53"* %0, %"class.std::optional.53"** %3, align 8
  %4 = load %"class.std::optional.53"*, %"class.std::optional.53"** %3, align 8
  %5 = bitcast %"class.std::optional.53"* %4 to %"struct.std::_Optional_base.54"*
  call void @_ZNSt14_Optional_baseIN3c106DeviceELb1ELb1EEC2Ev(%"struct.std::_Optional_base.54"* nonnull align 1 dereferenceable(3) %5) #3
  %6 = bitcast %"class.std::optional.53"* %4 to %"class.std::ios_base::Init"*
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt14_Optional_baseIN3c106DeviceELb1ELb1EEC2Ev(%"struct.std::_Optional_base.54"* nonnull align 1 dereferenceable(3) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_base.54"*, align 8
  store %"struct.std::_Optional_base.54"* %0, %"struct.std::_Optional_base.54"** %2, align 8
  %3 = load %"struct.std::_Optional_base.54"*, %"struct.std::_Optional_base.54"** %2, align 8
  %4 = bitcast %"struct.std::_Optional_base.54"* %3 to %"class.std::ios_base::Init"*
  %5 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %3, i32 0, i32 0
  call void @_ZNSt17_Optional_payloadIN3c106DeviceELb1ELb1ELb1EEC2Ev(%"struct.std::_Optional_payload.56"* nonnull align 1 dereferenceable(3) %5) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt17_Optional_payloadIN3c106DeviceELb1ELb1ELb1EEC2Ev(%"struct.std::_Optional_payload.56"* nonnull align 1 dereferenceable(3) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload.56"*, align 8
  store %"struct.std::_Optional_payload.56"* %0, %"struct.std::_Optional_payload.56"** %2, align 8
  %3 = load %"struct.std::_Optional_payload.56"*, %"struct.std::_Optional_payload.56"** %2, align 8
  %4 = bitcast %"struct.std::_Optional_payload.56"* %3 to %"struct.std::_Optional_payload_base.57"*
  call void @_ZNSt22_Optional_payload_baseIN3c106DeviceEEC2Ev(%"struct.std::_Optional_payload_base.57"* nonnull align 1 dereferenceable(3) %4) #3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c106DeviceEEC2Ev(%"struct.std::_Optional_payload_base.57"* nonnull align 1 dereferenceable(3) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload_base.57"*, align 8
  store %"struct.std::_Optional_payload_base.57"* %0, %"struct.std::_Optional_payload_base.57"** %2, align 8
  %3 = load %"struct.std::_Optional_payload_base.57"*, %"struct.std::_Optional_payload_base.57"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_payload_base.57", %"struct.std::_Optional_payload_base.57"* %3, i32 0, i32 0
  call void @_ZNSt22_Optional_payload_baseIN3c106DeviceEE8_StorageIS1_Lb1EEC2Ev(%"union.std::_Optional_payload_base<c10::Device>::_Storage"* nonnull align 1 dereferenceable(2) %4) #3
  %5 = getelementptr inbounds %"struct.std::_Optional_payload_base.57", %"struct.std::_Optional_payload_base.57"* %3, i32 0, i32 1
  store i8 0, i8* %5, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c106DeviceEE8_StorageIS1_Lb1EEC2Ev(%"union.std::_Optional_payload_base<c10::Device>::_Storage"* nonnull align 1 dereferenceable(2) %0) unnamed_addr #5 comdat align 2 {
  %2 = alloca %"union.std::_Optional_payload_base<c10::Device>::_Storage"*, align 8
  store %"union.std::_Optional_payload_base<c10::Device>::_Storage"* %0, %"union.std::_Optional_payload_base<c10::Device>::_Storage"** %2, align 8
  %3 = load %"union.std::_Optional_payload_base<c10::Device>::_Storage"*, %"union.std::_Optional_payload_base<c10::Device>::_Storage"** %2, align 8
  %4 = bitcast %"union.std::_Optional_payload_base<c10::Device>::_Storage"* %3 to %"class.std::ios_base::Init"*
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZSt7forwardIN3c106DeviceEEOT_RNSt16remove_referenceIS2_E4typeE(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %0) #8 comdat {
  %2 = alloca %"struct.c10::Device"*, align 8
  store %"struct.c10::Device"* %0, %"struct.c10::Device"** %2, align 8
  %3 = load %"struct.c10::Device"*, %"struct.c10::Device"** %2, align 8
  ret %"struct.c10::Device"* %3
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt14_Optional_baseIN3c106DeviceELb1ELb1EEC2IJS1_ELb0EEESt10in_place_tDpOT_(%"struct.std::_Optional_base.54"* nonnull align 1 dereferenceable(3) %0, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"struct.std::_Optional_base.54"*, align 8
  %5 = alloca %"struct.c10::Device"*, align 8
  %6 = alloca %"class.std::ios_base::Init", align 1
  store %"struct.std::_Optional_base.54"* %0, %"struct.std::_Optional_base.54"** %4, align 8
  store %"struct.c10::Device"* %1, %"struct.c10::Device"** %5, align 8
  %7 = load %"struct.std::_Optional_base.54"*, %"struct.std::_Optional_base.54"** %4, align 8
  %8 = bitcast %"struct.std::_Optional_base.54"* %7 to %"class.std::ios_base::Init"*
  %9 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %7, i32 0, i32 0
  %10 = load %"struct.c10::Device"*, %"struct.c10::Device"** %5, align 8
  %11 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZSt7forwardIN3c106DeviceEEOT_RNSt16remove_referenceIS2_E4typeE(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %10) #3
  call void @_ZNSt17_Optional_payloadIN3c106DeviceELb1ELb1ELb1EECI2St22_Optional_payload_baseIS1_EIJS1_EEESt10in_place_tDpOT_(%"struct.std::_Optional_payload.56"* nonnull align 1 dereferenceable(3) %9, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %11)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt17_Optional_payloadIN3c106DeviceELb1ELb1ELb1EECI2St22_Optional_payload_baseIS1_EIJS1_EEESt10in_place_tDpOT_(%"struct.std::_Optional_payload.56"* nonnull align 1 dereferenceable(3) %0, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"struct.std::_Optional_payload.56"*, align 8
  %5 = alloca %"struct.c10::Device"*, align 8
  store %"struct.std::_Optional_payload.56"* %0, %"struct.std::_Optional_payload.56"** %4, align 8
  store %"struct.c10::Device"* %1, %"struct.c10::Device"** %5, align 8
  %6 = load %"struct.std::_Optional_payload.56"*, %"struct.std::_Optional_payload.56"** %4, align 8
  %7 = bitcast %"struct.std::_Optional_payload.56"* %6 to %"struct.std::_Optional_payload_base.57"*
  %8 = load %"struct.c10::Device"*, %"struct.c10::Device"** %5, align 8
  call void @_ZNSt22_Optional_payload_baseIN3c106DeviceEEC2IJS1_EEESt10in_place_tDpOT_(%"struct.std::_Optional_payload_base.57"* nonnull align 1 dereferenceable(3) %7, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %8)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c106DeviceEEC2IJS1_EEESt10in_place_tDpOT_(%"struct.std::_Optional_payload_base.57"* nonnull align 1 dereferenceable(3) %0, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %1) unnamed_addr #7 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"struct.std::_Optional_payload_base.57"*, align 8
  %5 = alloca %"struct.c10::Device"*, align 8
  %6 = alloca %"class.std::ios_base::Init", align 1
  store %"struct.std::_Optional_payload_base.57"* %0, %"struct.std::_Optional_payload_base.57"** %4, align 8
  store %"struct.c10::Device"* %1, %"struct.c10::Device"** %5, align 8
  %7 = load %"struct.std::_Optional_payload_base.57"*, %"struct.std::_Optional_payload_base.57"** %4, align 8
  %8 = getelementptr inbounds %"struct.std::_Optional_payload_base.57", %"struct.std::_Optional_payload_base.57"* %7, i32 0, i32 0
  %9 = load %"struct.c10::Device"*, %"struct.c10::Device"** %5, align 8
  %10 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZSt7forwardIN3c106DeviceEEOT_RNSt16remove_referenceIS2_E4typeE(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %9) #3
  call void @_ZNSt22_Optional_payload_baseIN3c106DeviceEE8_StorageIS1_Lb1EEC2IJS1_EEESt10in_place_tDpOT_(%"union.std::_Optional_payload_base<c10::Device>::_Storage"* nonnull align 1 dereferenceable(2) %8, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %10)
  %11 = getelementptr inbounds %"struct.std::_Optional_payload_base.57", %"struct.std::_Optional_payload_base.57"* %7, i32 0, i32 1
  store i8 1, i8* %11, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt22_Optional_payload_baseIN3c106DeviceEE8_StorageIS1_Lb1EEC2IJS1_EEESt10in_place_tDpOT_(%"union.std::_Optional_payload_base<c10::Device>::_Storage"* nonnull align 1 dereferenceable(2) %0, %"struct.c10::Device"* nonnull align 1 dereferenceable(2) %1) unnamed_addr #5 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"union.std::_Optional_payload_base<c10::Device>::_Storage"*, align 8
  %5 = alloca %"struct.c10::Device"*, align 8
  store %"union.std::_Optional_payload_base<c10::Device>::_Storage"* %0, %"union.std::_Optional_payload_base<c10::Device>::_Storage"** %4, align 8
  store %"struct.c10::Device"* %1, %"struct.c10::Device"** %5, align 8
  %6 = load %"union.std::_Optional_payload_base<c10::Device>::_Storage"*, %"union.std::_Optional_payload_base<c10::Device>::_Storage"** %4, align 8
  %7 = bitcast %"union.std::_Optional_payload_base<c10::Device>::_Storage"* %6 to %"struct.c10::Device"*
  %8 = load %"struct.c10::Device"*, %"struct.c10::Device"** %5, align 8
  %9 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZSt7forwardIN3c106DeviceEEOT_RNSt16remove_referenceIS2_E4typeE(%"struct.c10::Device"* nonnull align 1 dereferenceable(2) %8) #3
  %10 = bitcast %"struct.c10::Device"* %7 to i8*
  %11 = bitcast %"struct.c10::Device"* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %10, i8* align 1 %11, i64 2, i1 false)
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i16 @_ZNK3c1010TensorImpl6deviceEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #4 comdat align 2 {
  %2 = alloca %"struct.c10::Device", align 1
  %3 = alloca %"struct.c10::TensorImpl"*, align 8
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %3, align 8
  %4 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %3, align 8
  %5 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %4, i32 0, i32 11
  %6 = bitcast [3 x i8]* %5 to i24*
  %7 = load i24, i24* %6, align 1
  %8 = lshr i24 %7, 15
  %9 = and i24 %8, 1
  %10 = trunc i24 %9 to i1
  br i1 %10, label %11, label %18

11:                                               ; preds = %1
  %12 = bitcast %"struct.c10::TensorImpl"* %4 to i16 (%"struct.c10::TensorImpl"*)***
  %13 = load i16 (%"struct.c10::TensorImpl"*)**, i16 (%"struct.c10::TensorImpl"*)*** %12, align 8
  %14 = getelementptr inbounds i16 (%"struct.c10::TensorImpl"*)*, i16 (%"struct.c10::TensorImpl"*)** %13, i64 13
  %15 = load i16 (%"struct.c10::TensorImpl"*)*, i16 (%"struct.c10::TensorImpl"*)** %14, align 8
  %16 = call i16 %15(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4)
  %17 = bitcast %"struct.c10::Device"* %2 to i16*
  store i16 %16, i16* %17, align 1
  br label %21

18:                                               ; preds = %1
  %19 = call i16 @_ZNK3c1010TensorImpl14device_defaultEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4)
  %20 = bitcast %"struct.c10::Device"* %2 to i16*
  store i16 %19, i16* %20, align 1
  br label %21

21:                                               ; preds = %18, %11
  %22 = bitcast %"struct.c10::Device"* %2 to i16*
  %23 = load i16, i16* %22, align 1
  ret i16 %23
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i16 @_ZNK3c1010TensorImpl14device_defaultEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #4 comdat align 2 {
  %2 = alloca %"struct.c10::Device", align 1
  %3 = alloca %"struct.c10::TensorImpl"*, align 8
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %3, align 8
  %4 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %3, align 8
  %5 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %4, i32 0, i32 10
  %6 = call zeroext i1 @_ZNKSt8optionalIN3c106DeviceEE9has_valueEv(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %5) #3
  br i1 %6, label %9, label %7

7:                                                ; preds = %1
  %8 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKcS2_(i8* getelementptr inbounds ([158 x i8], [158 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.5, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__func__._ZNK3c1010TensorImpl14device_defaultEv, i64 0, i64 0), i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.3, i64 0, i64 0), i32 1265, i8* %8) #25
  unreachable

9:                                                ; preds = %1
  %10 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %4, i32 0, i32 10
  %11 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNKRSt8optionalIN3c106DeviceEEdeEv(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %10) #3
  %12 = bitcast %"struct.c10::Device"* %2 to i8*
  %13 = bitcast %"struct.c10::Device"* %11 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %12, i8* align 1 %13, i64 2, i1 false)
  %14 = bitcast %"struct.c10::Device"* %2 to i16*
  %15 = load i16, i16* %14, align 1
  ret i16 %15
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNKRSt8optionalIN3c106DeviceEEdeEv(%"class.std::optional.53"* nonnull align 1 dereferenceable(3) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::optional.53"*, align 8
  store %"class.std::optional.53"* %0, %"class.std::optional.53"** %2, align 8
  %3 = load %"class.std::optional.53"*, %"class.std::optional.53"** %2, align 8
  %4 = bitcast %"class.std::optional.53"* %3 to %"class.std::ios_base::Init"*
  %5 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNKSt19_Optional_base_implIN3c106DeviceESt14_Optional_baseIS1_Lb1ELb1EEE6_M_getEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %4) #3
  ret %"struct.c10::Device"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNKSt19_Optional_base_implIN3c106DeviceESt14_Optional_baseIS1_Lb1ELb1EEE6_M_getEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  br label %4

4:                                                ; preds = %1
  br label %5

5:                                                ; preds = %4
  br label %6

6:                                                ; preds = %5
  %7 = bitcast %"class.std::ios_base::Init"* %3 to %"struct.std::_Optional_base.54"*
  %8 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %7, i32 0, i32 0
  %9 = bitcast %"struct.std::_Optional_payload.56"* %8 to %"struct.std::_Optional_payload_base.57"*
  %10 = call nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNKSt22_Optional_payload_baseIN3c106DeviceEE6_M_getEv(%"struct.std::_Optional_payload_base.57"* nonnull align 1 dereferenceable(3) %9) #3
  ret %"struct.c10::Device"* %10
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 1 dereferenceable(2) %"struct.c10::Device"* @_ZNKSt22_Optional_payload_baseIN3c106DeviceEE6_M_getEv(%"struct.std::_Optional_payload_base.57"* nonnull align 1 dereferenceable(3) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload_base.57"*, align 8
  store %"struct.std::_Optional_payload_base.57"* %0, %"struct.std::_Optional_payload_base.57"** %2, align 8
  %3 = load %"struct.std::_Optional_payload_base.57"*, %"struct.std::_Optional_payload_base.57"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_payload_base.57", %"struct.std::_Optional_payload_base.57"* %3, i32 0, i32 0
  %5 = bitcast %"union.std::_Optional_payload_base<c10::Device>::_Storage"* %4 to %"struct.c10::Device"*
  ret %"struct.c10::Device"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEcvbEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.c10::intrusive_ptr"*, align 8
  store %"class.c10::intrusive_ptr"* %0, %"class.c10::intrusive_ptr"** %2, align 8
  %3 = load %"class.c10::intrusive_ptr"*, %"class.c10::intrusive_ptr"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::intrusive_ptr", %"class.c10::intrusive_ptr"* %3, i32 0, i32 0
  %5 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %4, align 8
  %6 = invoke %"struct.c10::TensorImpl"* @_ZN3c1019UndefinedTensorImpl9singletonEv()
          to label %7 unwind label %9

7:                                                ; preds = %1
  %8 = icmp ne %"struct.c10::TensorImpl"* %5, %6
  ret i1 %8

9:                                                ; preds = %1
  %10 = landingpad { i8*, i32 }
          catch i8* null
  %11 = extractvalue { i8*, i32 } %10, 0
  call void @__clang_call_terminate(i8* %11) #26
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::TensorImpl"* @_ZN3c1019UndefinedTensorImpl9singletonEv() #8 comdat align 2 {
  ret %"struct.c10::TensorImpl"* getelementptr inbounds (%"struct.c10::UndefinedTensorImpl", %"struct.c10::UndefinedTensorImpl"* @_ZN3c1019UndefinedTensorImpl10_singletonE, i32 0, i32 0)
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c1010TensorImpl4sizeEl(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0, i64 %1) #4 comdat align 2 {
  %3 = alloca i64, align 8
  %4 = alloca %"struct.c10::TensorImpl"*, align 8
  %5 = alloca i64, align 8
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %4, align 8
  store i64 %1, i64* %5, align 8
  %6 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %4, align 8
  %7 = call zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6, i8 zeroext 2)
  br i1 %7, label %8, label %15

8:                                                ; preds = %2
  %9 = load i64, i64* %5, align 8
  %10 = bitcast %"struct.c10::TensorImpl"* %6 to i64 (%"struct.c10::TensorImpl"*, i64)***
  %11 = load i64 (%"struct.c10::TensorImpl"*, i64)**, i64 (%"struct.c10::TensorImpl"*, i64)*** %10, align 8
  %12 = getelementptr inbounds i64 (%"struct.c10::TensorImpl"*, i64)*, i64 (%"struct.c10::TensorImpl"*, i64)** %11, i64 6
  %13 = load i64 (%"struct.c10::TensorImpl"*, i64)*, i64 (%"struct.c10::TensorImpl"*, i64)** %12, align 8
  %14 = call i64 %13(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6, i64 %9)
  store i64 %14, i64* %3, align 8
  br label %22

15:                                               ; preds = %2
  %16 = load i64, i64* %5, align 8
  %17 = call i64 @_ZNK3c1010TensorImpl3dimEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6)
  %18 = call i64 @_ZN3c1014maybe_wrap_dimEllb(i64 %16, i64 %17, i1 zeroext false)
  store i64 %18, i64* %5, align 8
  %19 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %6, i32 0, i32 6
  %20 = load i64, i64* %5, align 8
  %21 = call i64 @_ZNK3c104impl15SizesAndStrides17size_at_uncheckedEm(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %19, i64 %20) #3
  store i64 %21, i64* %3, align 8
  br label %22

22:                                               ; preds = %15, %8
  %23 = load i64, i64* %3, align 8
  ret i64 %23
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0, i8 zeroext %1) #8 comdat align 2 {
  %3 = alloca %"struct.c10::TensorImpl"*, align 8
  %4 = alloca i8, align 1
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %3, align 8
  store i8 %1, i8* %4, align 1
  %5 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %3, align 8
  %6 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %5, i32 0, i32 11
  %7 = bitcast [3 x i8]* %6 to i24*
  %8 = load i24, i24* %7, align 1
  %9 = lshr i24 %8, 10
  %10 = and i24 %9, 3
  %11 = trunc i24 %10 to i8
  %12 = zext i8 %11 to i32
  %13 = load i8, i8* %4, align 1
  %14 = zext i8 %13 to i32
  %15 = icmp sge i32 %12, %14
  ret i1 %15
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c1010TensorImpl3dimEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #4 comdat align 2 {
  %2 = alloca i64, align 8
  %3 = alloca %"struct.c10::TensorImpl"*, align 8
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %3, align 8
  %4 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %3, align 8
  %5 = call zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4, i8 zeroext 2)
  br i1 %5, label %6, label %12

6:                                                ; preds = %1
  %7 = bitcast %"struct.c10::TensorImpl"* %4 to i64 (%"struct.c10::TensorImpl"*)***
  %8 = load i64 (%"struct.c10::TensorImpl"*)**, i64 (%"struct.c10::TensorImpl"*)*** %7, align 8
  %9 = getelementptr inbounds i64 (%"struct.c10::TensorImpl"*)*, i64 (%"struct.c10::TensorImpl"*)** %8, i64 12
  %10 = load i64 (%"struct.c10::TensorImpl"*)*, i64 (%"struct.c10::TensorImpl"*)** %9, align 8
  %11 = call i64 %10(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4)
  store i64 %11, i64* %2, align 8
  br label %15

12:                                               ; preds = %1
  %13 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %4, i32 0, i32 6
  %14 = call i64 @_ZNK3c104impl15SizesAndStrides4sizeEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %13) #3
  store i64 %14, i64* %2, align 8
  br label %15

15:                                               ; preds = %12, %6
  %16 = load i64, i64* %2, align 8
  ret i64 %16
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZN3c1014maybe_wrap_dimEllb(i64 %0, i64 %1, i1 zeroext %2) #4 comdat {
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8, align 1
  store i64 %0, i64* %4, align 8
  store i64 %1, i64* %5, align 8
  %7 = zext i1 %2 to i8
  store i8 %7, i8* %6, align 1
  %8 = load i64, i64* %4, align 8
  %9 = load i64, i64* %5, align 8
  %10 = load i8, i8* %6, align 1
  %11 = trunc i8 %10 to i1
  %12 = call i64 @_ZN3c1015_maybe_wrap_dimIlEET_S1_S1_b(i64 %8, i64 %9, i1 zeroext %11)
  ret i64 %12
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c104impl15SizesAndStrides17size_at_uncheckedEm(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0, i64 %1) #8 comdat align 2 {
  %3 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  %4 = alloca i64, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %3, align 8
  %6 = call i64* @_ZNK3c104impl15SizesAndStrides10sizes_dataEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %5) #3
  %7 = load i64, i64* %4, align 8
  %8 = getelementptr inbounds i64, i64* %6, i64 %7
  %9 = load i64, i64* %8, align 8
  ret i64 %9
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i64* @_ZNK3c104impl15SizesAndStrides10sizes_dataEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #8 comdat align 2 {
  %2 = alloca i64*, align 8
  %3 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %3, align 8
  %4 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %3, align 8
  %5 = call zeroext i1 @_ZNK3c104impl15SizesAndStrides8isInlineEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %4) #3
  br i1 %5, label %6, label %10

6:                                                ; preds = %1
  %7 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %4, i32 0, i32 1
  %8 = bitcast %union.anon.52* %7 to [10 x i64]*
  %9 = getelementptr inbounds [10 x i64], [10 x i64]* %8, i64 0, i64 0
  store i64* %9, i64** %2, align 8
  br label %15

10:                                               ; preds = %1
  %11 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %4, i32 0, i32 1
  %12 = bitcast %union.anon.52* %11 to i64**
  %13 = load i64*, i64** %12, align 8
  %14 = getelementptr inbounds i64, i64* %13, i64 0
  store i64* %14, i64** %2, align 8
  br label %15

15:                                               ; preds = %10, %6
  %16 = load i64*, i64** %2, align 8
  ret i64* %16
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c104impl15SizesAndStrides8isInlineEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #8 comdat align 2 {
  %2 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %2, align 8
  %3 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %3, i32 0, i32 0
  %5 = load i64, i64* %4, align 8
  %6 = icmp ule i64 %5, 5
  ret i1 %6
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZN3c1015_maybe_wrap_dimIlEET_S1_S1_b(i64 %0, i64 %1, i1 zeroext %2) #4 comdat {
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8, align 1
  store i64 %0, i64* %5, align 8
  store i64 %1, i64* %6, align 8
  %8 = zext i1 %2 to i8
  store i8 %8, i8* %7, align 1
  %9 = load i64, i64* %6, align 8
  %10 = mul nsw i64 %9, -1
  %11 = load i64, i64* %5, align 8
  %12 = icmp sle i64 %10, %11
  br i1 %12, label %13, label %17

13:                                               ; preds = %3
  %14 = load i64, i64* %5, align 8
  %15 = load i64, i64* %6, align 8
  %16 = icmp slt i64 %14, %15
  br label %17

17:                                               ; preds = %13, %3
  %18 = phi i1 [ false, %3 ], [ %16, %13 ]
  br i1 %18, label %19, label %28

19:                                               ; preds = %17
  %20 = load i64, i64* %5, align 8
  %21 = icmp slt i64 %20, 0
  br i1 %21, label %22, label %26

22:                                               ; preds = %19
  %23 = load i64, i64* %5, align 8
  %24 = load i64, i64* %6, align 8
  %25 = add nsw i64 %23, %24
  store i64 %25, i64* %4, align 8
  br label %36

26:                                               ; preds = %19
  %27 = load i64, i64* %5, align 8
  store i64 %27, i64* %4, align 8
  br label %36

28:                                               ; preds = %17
  %29 = call nonnull align 8 dereferenceable(8) i64* @_ZSt4moveIRlEONSt16remove_referenceIT_E4typeEOS2_(i64* nonnull align 8 dereferenceable(8) %5) #3
  %30 = load i64, i64* %29, align 8
  %31 = call nonnull align 8 dereferenceable(8) i64* @_ZSt4moveIRlEONSt16remove_referenceIT_E4typeEOS2_(i64* nonnull align 8 dereferenceable(8) %6) #3
  %32 = load i64, i64* %31, align 8
  %33 = load i8, i8* %7, align 1
  %34 = trunc i8 %33 to i1
  %35 = call i64 @_ZN3c106detail19maybe_wrap_dim_slowIlEET_S2_S2_b(i64 %30, i64 %32, i1 zeroext %34)
  store i64 %35, i64* %4, align 8
  br label %36

36:                                               ; preds = %28, %26, %22
  %37 = load i64, i64* %4, align 8
  ret i64 %37
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) i64* @_ZSt4moveIRlEONSt16remove_referenceIT_E4typeEOS2_(i64* nonnull align 8 dereferenceable(8) %0) #8 comdat {
  %2 = alloca i64*, align 8
  store i64* %0, i64** %2, align 8
  %3 = load i64*, i64** %2, align 8
  ret i64* %3
}

declare dso_local i64 @_ZN3c106detail19maybe_wrap_dim_slowIlEET_S2_S2_b(i64, i64, i1 zeroext) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c104impl15SizesAndStrides4sizeEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #8 comdat align 2 {
  %2 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %2, align 8
  %3 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %3, i32 0, i32 0
  %5 = load i64, i64* %4, align 8
  ret i64 %5
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c1010TensorImpl5numelEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #4 comdat align 2 {
  %2 = alloca i64, align 8
  %3 = alloca %"struct.c10::TensorImpl"*, align 8
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %3, align 8
  %4 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %3, align 8
  %5 = call zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4, i8 zeroext 2)
  br i1 %5, label %6, label %12

6:                                                ; preds = %1
  %7 = bitcast %"struct.c10::TensorImpl"* %4 to i64 (%"struct.c10::TensorImpl"*)***
  %8 = load i64 (%"struct.c10::TensorImpl"*)**, i64 (%"struct.c10::TensorImpl"*)*** %7, align 8
  %9 = getelementptr inbounds i64 (%"struct.c10::TensorImpl"*)*, i64 (%"struct.c10::TensorImpl"*)** %8, i64 10
  %10 = load i64 (%"struct.c10::TensorImpl"*)*, i64 (%"struct.c10::TensorImpl"*)** %9, align 8
  %11 = call i64 %10(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4)
  store i64 %11, i64* %2, align 8
  br label %15

12:                                               ; preds = %1
  %13 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %4, i32 0, i32 8
  %14 = load i64, i64* %13, align 8
  store i64 %14, i64* %2, align 8
  br label %15

15:                                               ; preds = %12, %6
  %16 = load i64, i64* %2, align 8
  ret i64 %16
}

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_Z24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %0, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %1, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %2) #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %4 = alloca %"class.at::Tensor"*, align 8
  %5 = alloca %"class.at::Tensor"*, align 8
  %6 = alloca %"class.at::Tensor"*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca %struct.dim3, align 4
  %10 = alloca %struct.dim3, align 4
  %11 = alloca %"struct.c10::cuda::OptionalCUDAGuard", align 8
  %12 = alloca %"class.std::optional.53", align 1
  %13 = alloca i24, align 4
  %14 = alloca i24, align 4
  %15 = alloca %struct.CUstream_st*, align 8
  %16 = alloca %"class.c10::cuda::CUDAStream", align 8
  %17 = alloca i8*, align 8
  %18 = alloca i32, align 4
  %19 = alloca %class.anon.69, align 8
  store %"class.at::Tensor"* %0, %"class.at::Tensor"** %4, align 8
  store %"class.at::Tensor"* %1, %"class.at::Tensor"** %5, align 8
  store %"class.at::Tensor"* %2, %"class.at::Tensor"** %6, align 8
  %20 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  %21 = bitcast %"class.at::Tensor"* %20 to %"class.at::TensorBase"*
  %22 = call i64 @_ZNK2at10TensorBase5numelEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %21)
  %23 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  %24 = bitcast %"class.at::Tensor"* %23 to %"class.at::TensorBase"*
  %25 = call i64 @_ZNK2at10TensorBase4sizeEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %24, i64 -1)
  %26 = sdiv i64 %22, %25
  store i64 %26, i64* %7, align 8
  %27 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  %28 = bitcast %"class.at::Tensor"* %27 to %"class.at::TensorBase"*
  %29 = call i64 @_ZNK2at10TensorBase5numelEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %28)
  store i64 %29, i64* %8, align 8
  %30 = load i64, i64* %7, align 8
  %31 = trunc i64 %30 to i32
  call void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %9, i32 %31, i32 1, i32 1)
  call void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %10, i32 1024, i32 1, i32 1)
  %32 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  %33 = call i24 @_ZN2at9device_ofERKNS_6TensorE(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %32)
  %34 = getelementptr inbounds %"class.std::optional.53", %"class.std::optional.53"* %12, i32 0, i32 0
  %35 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %34, i32 0, i32 0
  %36 = getelementptr inbounds %"struct.std::_Optional_payload.56", %"struct.std::_Optional_payload.56"* %35, i32 0, i32 0
  store i24 %33, i24* %13, align 4
  %37 = bitcast %"struct.std::_Optional_payload_base.57"* %36 to i8*
  %38 = bitcast i24* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %37, i8* align 4 %38, i64 3, i1 false)
  %39 = getelementptr inbounds %"class.std::optional.53", %"class.std::optional.53"* %12, i32 0, i32 0
  %40 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %39, i32 0, i32 0
  %41 = getelementptr inbounds %"struct.std::_Optional_payload.56", %"struct.std::_Optional_payload.56"* %40, i32 0, i32 0
  %42 = bitcast i24* %14 to i8*
  %43 = bitcast %"struct.std::_Optional_payload_base.57"* %41 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %42, i8* align 1 %43, i64 3, i1 false)
  %44 = load i24, i24* %14, align 4
  call void @_ZN3c104cuda17OptionalCUDAGuardC2ESt8optionalINS_6DeviceEE(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %11, i24 %44)
  %45 = invoke { i64, i64 } @_ZN3c104cuda20getCurrentCUDAStreamEa(i8 signext -1)
          to label %46 unwind label %66

46:                                               ; preds = %3
  %47 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %16, i32 0, i32 0
  %48 = bitcast %"class.c10::Stream"* %47 to { i64, i64 }*
  %49 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %48, i32 0, i32 0
  %50 = extractvalue { i64, i64 } %45, 0
  store i64 %50, i64* %49, align 8
  %51 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %48, i32 0, i32 1
  %52 = extractvalue { i64, i64 } %45, 1
  store i64 %52, i64* %51, align 8
  %53 = invoke %struct.CUstream_st* @_ZNK3c104cuda10CUDAStreamcvP11CUstream_stEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %16)
          to label %54 unwind label %66

54:                                               ; preds = %46
  store %struct.CUstream_st* %53, %struct.CUstream_st** %15, align 8
  %55 = getelementptr inbounds %class.anon.69, %class.anon.69* %19, i32 0, i32 0
  %56 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  store %"class.at::Tensor"* %56, %"class.at::Tensor"** %55, align 8
  %57 = getelementptr inbounds %class.anon.69, %class.anon.69* %19, i32 0, i32 1
  store %struct.dim3* %9, %struct.dim3** %57, align 8
  %58 = getelementptr inbounds %class.anon.69, %class.anon.69* %19, i32 0, i32 2
  store %struct.dim3* %10, %struct.dim3** %58, align 8
  %59 = getelementptr inbounds %class.anon.69, %class.anon.69* %19, i32 0, i32 3
  store %struct.CUstream_st** %15, %struct.CUstream_st*** %59, align 8
  %60 = getelementptr inbounds %class.anon.69, %class.anon.69* %19, i32 0, i32 4
  %61 = load %"class.at::Tensor"*, %"class.at::Tensor"** %6, align 8
  store %"class.at::Tensor"* %61, %"class.at::Tensor"** %60, align 8
  %62 = getelementptr inbounds %class.anon.69, %class.anon.69* %19, i32 0, i32 5
  store i64* %8, i64** %62, align 8
  %63 = getelementptr inbounds %class.anon.69, %class.anon.69* %19, i32 0, i32 6
  %64 = load %"class.at::Tensor"*, %"class.at::Tensor"** %4, align 8
  store %"class.at::Tensor"* %64, %"class.at::Tensor"** %63, align 8
  invoke void @_ZZ24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_ENKUlvE_clEv(%class.anon.69* nonnull align 8 dereferenceable(56) %19)
          to label %65 unwind label %66

65:                                               ; preds = %54
  call void @_ZN3c104cuda17OptionalCUDAGuardD2Ev(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %11) #3
  ret void

66:                                               ; preds = %54, %46, %3
  %67 = landingpad { i8*, i32 }
          cleanup
  %68 = extractvalue { i8*, i32 } %67, 0
  store i8* %68, i8** %17, align 8
  %69 = extractvalue { i8*, i32 } %67, 1
  store i32 %69, i32* %18, align 4
  call void @_ZN3c104cuda17OptionalCUDAGuardD2Ev(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %11) #3
  br label %70

70:                                               ; preds = %66
  %71 = load i8*, i8** %17, align 8
  %72 = load i32, i32* %18, align 4
  %73 = insertvalue { i8*, i32 } undef, i8* %71, 0
  %74 = insertvalue { i8*, i32 } %73, i32 %72, 1
  resume { i8*, i32 } %74
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZ24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_ENKUlvE_clEv(%class.anon.69* nonnull align 8 dereferenceable(56) %0) #4 align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %class.anon.69*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i8, align 1
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  %7 = alloca %class.anon.96, align 8
  %8 = alloca %class.anon.96, align 8
  %9 = alloca %class.anon.96, align 8
  %10 = alloca %"class.std::__cxx11::basic_string", align 8
  %11 = alloca i8, align 1
  %12 = alloca i8*, align 8
  %13 = alloca i8*, align 8
  %14 = alloca i32, align 4
  store %class.anon.69* %0, %class.anon.69** %2, align 8
  %15 = load %class.anon.69*, %class.anon.69** %2, align 8
  %16 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 0
  %17 = load %"class.at::Tensor"*, %"class.at::Tensor"** %16, align 8
  %18 = bitcast %"class.at::Tensor"* %17 to %"class.at::TensorBase"*
  %19 = call signext i8 @_ZNK2at10TensorBase11scalar_typeEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %18)
  store i8 %19, i8* %4, align 1
  store i8* %4, i8** %3, align 8
  store i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.41, i32 0, i32 0), i8** %5, align 8
  %20 = load i8*, i8** %3, align 8
  %21 = load i8, i8* %20, align 1
  %22 = call signext i8 @_ZN6detail11scalar_typeEN3c1010ScalarTypeE(i8 signext %21)
  store i8 %22, i8* %6, align 1
  %23 = load i8, i8* %6, align 1
  switch i8 %23, label %96 [
    i8 6, label %24
    i8 5, label %48
    i8 15, label %72
  ]

24:                                               ; preds = %1
  br label %25

25:                                               ; preds = %24
  br label %26

26:                                               ; preds = %25
  %27 = getelementptr inbounds %class.anon.96, %class.anon.96* %7, i32 0, i32 0
  %28 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 1
  %29 = load %struct.dim3*, %struct.dim3** %28, align 8
  store %struct.dim3* %29, %struct.dim3** %27, align 8
  %30 = getelementptr inbounds %class.anon.96, %class.anon.96* %7, i32 0, i32 1
  %31 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 2
  %32 = load %struct.dim3*, %struct.dim3** %31, align 8
  store %struct.dim3* %32, %struct.dim3** %30, align 8
  %33 = getelementptr inbounds %class.anon.96, %class.anon.96* %7, i32 0, i32 2
  %34 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 3
  %35 = load %struct.CUstream_st**, %struct.CUstream_st*** %34, align 8
  store %struct.CUstream_st** %35, %struct.CUstream_st*** %33, align 8
  %36 = getelementptr inbounds %class.anon.96, %class.anon.96* %7, i32 0, i32 3
  %37 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 4
  %38 = load %"class.at::Tensor"*, %"class.at::Tensor"** %37, align 8
  store %"class.at::Tensor"* %38, %"class.at::Tensor"** %36, align 8
  %39 = getelementptr inbounds %class.anon.96, %class.anon.96* %7, i32 0, i32 4
  %40 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 0
  %41 = load %"class.at::Tensor"*, %"class.at::Tensor"** %40, align 8
  store %"class.at::Tensor"* %41, %"class.at::Tensor"** %39, align 8
  %42 = getelementptr inbounds %class.anon.96, %class.anon.96* %7, i32 0, i32 5
  %43 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 5
  %44 = load i64*, i64** %43, align 8
  store i64* %44, i64** %42, align 8
  %45 = getelementptr inbounds %class.anon.96, %class.anon.96* %7, i32 0, i32 6
  %46 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 6
  %47 = load %"class.at::Tensor"*, %"class.at::Tensor"** %46, align 8
  store %"class.at::Tensor"* %47, %"class.at::Tensor"** %45, align 8
  call void @_ZZZ24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_ENKUlvE_clEvENKUlvE_clEv(%class.anon.96* nonnull align 8 dereferenceable(56) %7)
  br label %104

48:                                               ; preds = %1
  br label %49

49:                                               ; preds = %48
  br label %50

50:                                               ; preds = %49
  %51 = getelementptr inbounds %class.anon.96, %class.anon.96* %8, i32 0, i32 0
  %52 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 1
  %53 = load %struct.dim3*, %struct.dim3** %52, align 8
  store %struct.dim3* %53, %struct.dim3** %51, align 8
  %54 = getelementptr inbounds %class.anon.96, %class.anon.96* %8, i32 0, i32 1
  %55 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 2
  %56 = load %struct.dim3*, %struct.dim3** %55, align 8
  store %struct.dim3* %56, %struct.dim3** %54, align 8
  %57 = getelementptr inbounds %class.anon.96, %class.anon.96* %8, i32 0, i32 2
  %58 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 3
  %59 = load %struct.CUstream_st**, %struct.CUstream_st*** %58, align 8
  store %struct.CUstream_st** %59, %struct.CUstream_st*** %57, align 8
  %60 = getelementptr inbounds %class.anon.96, %class.anon.96* %8, i32 0, i32 3
  %61 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 4
  %62 = load %"class.at::Tensor"*, %"class.at::Tensor"** %61, align 8
  store %"class.at::Tensor"* %62, %"class.at::Tensor"** %60, align 8
  %63 = getelementptr inbounds %class.anon.96, %class.anon.96* %8, i32 0, i32 4
  %64 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 0
  %65 = load %"class.at::Tensor"*, %"class.at::Tensor"** %64, align 8
  store %"class.at::Tensor"* %65, %"class.at::Tensor"** %63, align 8
  %66 = getelementptr inbounds %class.anon.96, %class.anon.96* %8, i32 0, i32 5
  %67 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 5
  %68 = load i64*, i64** %67, align 8
  store i64* %68, i64** %66, align 8
  %69 = getelementptr inbounds %class.anon.96, %class.anon.96* %8, i32 0, i32 6
  %70 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 6
  %71 = load %"class.at::Tensor"*, %"class.at::Tensor"** %70, align 8
  store %"class.at::Tensor"* %71, %"class.at::Tensor"** %69, align 8
  call void @_ZZZ24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_ENKUlvE_clEvENKUlvE0_clEv(%class.anon.96* nonnull align 8 dereferenceable(56) %8)
  br label %104

72:                                               ; preds = %1
  br label %73

73:                                               ; preds = %72
  br label %74

74:                                               ; preds = %73
  %75 = getelementptr inbounds %class.anon.96, %class.anon.96* %9, i32 0, i32 0
  %76 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 1
  %77 = load %struct.dim3*, %struct.dim3** %76, align 8
  store %struct.dim3* %77, %struct.dim3** %75, align 8
  %78 = getelementptr inbounds %class.anon.96, %class.anon.96* %9, i32 0, i32 1
  %79 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 2
  %80 = load %struct.dim3*, %struct.dim3** %79, align 8
  store %struct.dim3* %80, %struct.dim3** %78, align 8
  %81 = getelementptr inbounds %class.anon.96, %class.anon.96* %9, i32 0, i32 2
  %82 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 3
  %83 = load %struct.CUstream_st**, %struct.CUstream_st*** %82, align 8
  store %struct.CUstream_st** %83, %struct.CUstream_st*** %81, align 8
  %84 = getelementptr inbounds %class.anon.96, %class.anon.96* %9, i32 0, i32 3
  %85 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 4
  %86 = load %"class.at::Tensor"*, %"class.at::Tensor"** %85, align 8
  store %"class.at::Tensor"* %86, %"class.at::Tensor"** %84, align 8
  %87 = getelementptr inbounds %class.anon.96, %class.anon.96* %9, i32 0, i32 4
  %88 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 0
  %89 = load %"class.at::Tensor"*, %"class.at::Tensor"** %88, align 8
  store %"class.at::Tensor"* %89, %"class.at::Tensor"** %87, align 8
  %90 = getelementptr inbounds %class.anon.96, %class.anon.96* %9, i32 0, i32 5
  %91 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 5
  %92 = load i64*, i64** %91, align 8
  store i64* %92, i64** %90, align 8
  %93 = getelementptr inbounds %class.anon.96, %class.anon.96* %9, i32 0, i32 6
  %94 = getelementptr inbounds %class.anon.69, %class.anon.69* %15, i32 0, i32 6
  %95 = load %"class.at::Tensor"*, %"class.at::Tensor"** %94, align 8
  store %"class.at::Tensor"* %95, %"class.at::Tensor"** %93, align 8
  call void @_ZZZ24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_ENKUlvE_clEvENKUlvE1_clEv(%class.anon.96* nonnull align 8 dereferenceable(56) %9)
  br label %104

96:                                               ; preds = %1
  store i8 34, i8* %11, align 1
  %97 = load i8, i8* %6, align 1
  %98 = call i8* @_ZN3c108toStringENS_10ScalarTypeE(i8 signext %97)
  store i8* %98, i8** %12, align 8
  call void @_ZN3c106detail17torchCheckMsgImplIJcPKcA24_cS3_A2_cEEEDcS3_DpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %10, i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* nonnull align 1 dereferenceable(1) %11, i8** nonnull align 8 dereferenceable(8) %5, [24 x i8]* nonnull align 1 dereferenceable(24) @.str.42, i8** nonnull align 8 dereferenceable(8) %12, [2 x i8]* nonnull align 1 dereferenceable(2) @.str.43)
  invoke void @_ZN3c106detail14torchCheckFailEPKcS2_jRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__func__._ZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEv, i64 0, i64 0), i8* getelementptr inbounds ([73 x i8], [73 x i8]* @.str, i64 0, i64 0), i32 266, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %10) #25
          to label %99 unwind label %100

99:                                               ; preds = %96
  unreachable

100:                                              ; preds = %96
  %101 = landingpad { i8*, i32 }
          cleanup
  %102 = extractvalue { i8*, i32 } %101, 0
  store i8* %102, i8** %13, align 8
  %103 = extractvalue { i8*, i32 } %101, 1
  store i32 %103, i32* %14, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %10) #3
  br label %105

104:                                              ; preds = %74, %50, %26
  ret void

105:                                              ; preds = %100
  %106 = load i8*, i8** %13, align 8
  %107 = load i32, i32* %14, align 4
  %108 = insertvalue { i8*, i32 } undef, i8* %106, 0
  %109 = insertvalue { i8*, i32 } %108, i32 %107, 1
  resume { i8*, i32 } %109
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_ENKUlvE_clEvENKUlvE_clEv(%class.anon.96* nonnull align 8 dereferenceable(56) %0) #4 align 2 {
  %2 = alloca %class.anon.96*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  %7 = alloca %struct.dim3, align 4
  %8 = alloca %struct.dim3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca { i64, i32 }, align 4
  store %class.anon.96* %0, %class.anon.96** %2, align 8
  %11 = load %class.anon.96*, %class.anon.96** %2, align 8
  %12 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 0
  %13 = load %struct.dim3*, %struct.dim3** %12, align 8
  %14 = bitcast %struct.dim3* %3 to i8*
  %15 = bitcast %struct.dim3* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %14, i8* align 4 %15, i64 12, i1 false)
  %16 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 1
  %17 = load %struct.dim3*, %struct.dim3** %16, align 8
  %18 = bitcast %struct.dim3* %4 to i8*
  %19 = bitcast %struct.dim3* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %18, i8* align 4 %19, i64 12, i1 false)
  %20 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 2
  %21 = load %struct.CUstream_st**, %struct.CUstream_st*** %20, align 8
  %22 = load %struct.CUstream_st*, %struct.CUstream_st** %21, align 8
  %23 = bitcast %struct.CUstream_st* %22 to i8*
  %24 = bitcast { i64, i32 }* %5 to i8*
  %25 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %24, i8* align 4 %25, i64 12, i1 false)
  %26 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %27 = load i64, i64* %26, align 4
  %28 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %29 = load i32, i32* %28, align 4
  %30 = bitcast { i64, i32 }* %6 to i8*
  %31 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %30, i8* align 4 %31, i64 12, i1 false)
  %32 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %33 = load i64, i64* %32, align 4
  %34 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = call i32 @__cudaPushCallConfiguration(i64 %27, i32 %29, i64 %33, i32 %35, i64 0, i8* %23)
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %50, label %38

38:                                               ; preds = %1
  %39 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 3
  %40 = load %"class.at::Tensor"*, %"class.at::Tensor"** %39, align 8
  %41 = bitcast %"class.at::Tensor"* %40 to %"class.at::TensorBase"*
  %42 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %41)
  %43 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 4
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  %45 = bitcast %"class.at::Tensor"* %44 to %"class.at::TensorBase"*
  %46 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %45)
  %47 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 5
  %48 = load i64*, i64** %47, align 8
  %49 = load i64, i64* %48, align 8
  call void @_ZN4vllm38__device_stub__segmented_max_reductionIfEEvPfPKT_l(float* %42, float* %46, i64 %49)
  br label %50

50:                                               ; preds = %38, %1
  %51 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 0
  %52 = load %struct.dim3*, %struct.dim3** %51, align 8
  %53 = bitcast %struct.dim3* %7 to i8*
  %54 = bitcast %struct.dim3* %52 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %53, i8* align 4 %54, i64 12, i1 false)
  %55 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 1
  %56 = load %struct.dim3*, %struct.dim3** %55, align 8
  %57 = bitcast %struct.dim3* %8 to i8*
  %58 = bitcast %struct.dim3* %56 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %57, i8* align 4 %58, i64 12, i1 false)
  %59 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 2
  %60 = load %struct.CUstream_st**, %struct.CUstream_st*** %59, align 8
  %61 = load %struct.CUstream_st*, %struct.CUstream_st** %60, align 8
  %62 = bitcast %struct.CUstream_st* %61 to i8*
  %63 = bitcast { i64, i32 }* %9 to i8*
  %64 = bitcast %struct.dim3* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %63, i8* align 4 %64, i64 12, i1 false)
  %65 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 0
  %66 = load i64, i64* %65, align 4
  %67 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 1
  %68 = load i32, i32* %67, align 4
  %69 = bitcast { i64, i32 }* %10 to i8*
  %70 = bitcast %struct.dim3* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %69, i8* align 4 %70, i64 12, i1 false)
  %71 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 0
  %72 = load i64, i64* %71, align 4
  %73 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 1
  %74 = load i32, i32* %73, align 4
  %75 = call i32 @__cudaPushCallConfiguration(i64 %66, i32 %68, i64 %72, i32 %74, i64 0, i8* %62)
  %76 = icmp ne i32 %75, 0
  br i1 %76, label %93, label %77

77:                                               ; preds = %50
  %78 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 6
  %79 = load %"class.at::Tensor"*, %"class.at::Tensor"** %78, align 8
  %80 = bitcast %"class.at::Tensor"* %79 to %"class.at::TensorBase"*
  %81 = call %"class.std::ios_base::Init"* @_ZNK2at10TensorBase8data_ptrIN3c1013Float8_e4m3fnEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %80)
  %82 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 4
  %83 = load %"class.at::Tensor"*, %"class.at::Tensor"** %82, align 8
  %84 = bitcast %"class.at::Tensor"* %83 to %"class.at::TensorBase"*
  %85 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %84)
  %86 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 3
  %87 = load %"class.at::Tensor"*, %"class.at::Tensor"** %86, align 8
  %88 = bitcast %"class.at::Tensor"* %87 to %"class.at::TensorBase"*
  %89 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %88)
  %90 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 5
  %91 = load i64*, i64** %90, align 8
  %92 = load i64, i64* %91, align 8
  call void @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* %81, float* %85, float* %89, i64 %92)
  br label %93

93:                                               ; preds = %77, %50
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_ENKUlvE_clEvENKUlvE0_clEv(%class.anon.96* nonnull align 8 dereferenceable(56) %0) #4 align 2 {
  %2 = alloca %class.anon.96*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  %7 = alloca %struct.dim3, align 4
  %8 = alloca %struct.dim3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca { i64, i32 }, align 4
  store %class.anon.96* %0, %class.anon.96** %2, align 8
  %11 = load %class.anon.96*, %class.anon.96** %2, align 8
  %12 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 0
  %13 = load %struct.dim3*, %struct.dim3** %12, align 8
  %14 = bitcast %struct.dim3* %3 to i8*
  %15 = bitcast %struct.dim3* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %14, i8* align 4 %15, i64 12, i1 false)
  %16 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 1
  %17 = load %struct.dim3*, %struct.dim3** %16, align 8
  %18 = bitcast %struct.dim3* %4 to i8*
  %19 = bitcast %struct.dim3* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %18, i8* align 4 %19, i64 12, i1 false)
  %20 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 2
  %21 = load %struct.CUstream_st**, %struct.CUstream_st*** %20, align 8
  %22 = load %struct.CUstream_st*, %struct.CUstream_st** %21, align 8
  %23 = bitcast %struct.CUstream_st* %22 to i8*
  %24 = bitcast { i64, i32 }* %5 to i8*
  %25 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %24, i8* align 4 %25, i64 12, i1 false)
  %26 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %27 = load i64, i64* %26, align 4
  %28 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %29 = load i32, i32* %28, align 4
  %30 = bitcast { i64, i32 }* %6 to i8*
  %31 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %30, i8* align 4 %31, i64 12, i1 false)
  %32 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %33 = load i64, i64* %32, align 4
  %34 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = call i32 @__cudaPushCallConfiguration(i64 %27, i32 %29, i64 %33, i32 %35, i64 0, i8* %23)
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %50, label %38

38:                                               ; preds = %1
  %39 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 3
  %40 = load %"class.at::Tensor"*, %"class.at::Tensor"** %39, align 8
  %41 = bitcast %"class.at::Tensor"* %40 to %"class.at::TensorBase"*
  %42 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %41)
  %43 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 4
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  %45 = bitcast %"class.at::Tensor"* %44 to %"class.at::TensorBase"*
  %46 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %45)
  %47 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 5
  %48 = load i64*, i64** %47, align 8
  %49 = load i64, i64* %48, align 8
  call void @_ZN4vllm38__device_stub__segmented_max_reductionIN3c104HalfEEEvPfPKT_l(float* %42, %"class.caffe2::TypeMeta"* %46, i64 %49)
  br label %50

50:                                               ; preds = %38, %1
  %51 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 0
  %52 = load %struct.dim3*, %struct.dim3** %51, align 8
  %53 = bitcast %struct.dim3* %7 to i8*
  %54 = bitcast %struct.dim3* %52 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %53, i8* align 4 %54, i64 12, i1 false)
  %55 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 1
  %56 = load %struct.dim3*, %struct.dim3** %55, align 8
  %57 = bitcast %struct.dim3* %8 to i8*
  %58 = bitcast %struct.dim3* %56 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %57, i8* align 4 %58, i64 12, i1 false)
  %59 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 2
  %60 = load %struct.CUstream_st**, %struct.CUstream_st*** %59, align 8
  %61 = load %struct.CUstream_st*, %struct.CUstream_st** %60, align 8
  %62 = bitcast %struct.CUstream_st* %61 to i8*
  %63 = bitcast { i64, i32 }* %9 to i8*
  %64 = bitcast %struct.dim3* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %63, i8* align 4 %64, i64 12, i1 false)
  %65 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 0
  %66 = load i64, i64* %65, align 4
  %67 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 1
  %68 = load i32, i32* %67, align 4
  %69 = bitcast { i64, i32 }* %10 to i8*
  %70 = bitcast %struct.dim3* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %69, i8* align 4 %70, i64 12, i1 false)
  %71 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 0
  %72 = load i64, i64* %71, align 4
  %73 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 1
  %74 = load i32, i32* %73, align 4
  %75 = call i32 @__cudaPushCallConfiguration(i64 %66, i32 %68, i64 %72, i32 %74, i64 0, i8* %62)
  %76 = icmp ne i32 %75, 0
  br i1 %76, label %93, label %77

77:                                               ; preds = %50
  %78 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 6
  %79 = load %"class.at::Tensor"*, %"class.at::Tensor"** %78, align 8
  %80 = bitcast %"class.at::Tensor"* %79 to %"class.at::TensorBase"*
  %81 = call %"class.std::ios_base::Init"* @_ZNK2at10TensorBase8data_ptrIN3c1013Float8_e4m3fnEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %80)
  %82 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 4
  %83 = load %"class.at::Tensor"*, %"class.at::Tensor"** %82, align 8
  %84 = bitcast %"class.at::Tensor"* %83 to %"class.at::TensorBase"*
  %85 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %84)
  %86 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 3
  %87 = load %"class.at::Tensor"*, %"class.at::Tensor"** %86, align 8
  %88 = bitcast %"class.at::Tensor"* %87 to %"class.at::TensorBase"*
  %89 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %88)
  %90 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 5
  %91 = load i64*, i64** %90, align 8
  %92 = load i64, i64* %91, align 8
  call void @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* %81, %"class.caffe2::TypeMeta"* %85, float* %89, i64 %92)
  br label %93

93:                                               ; preds = %77, %50
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_ENKUlvE_clEvENKUlvE1_clEv(%class.anon.96* nonnull align 8 dereferenceable(56) %0) #4 align 2 {
  %2 = alloca %class.anon.96*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  %7 = alloca %struct.dim3, align 4
  %8 = alloca %struct.dim3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca { i64, i32 }, align 4
  store %class.anon.96* %0, %class.anon.96** %2, align 8
  %11 = load %class.anon.96*, %class.anon.96** %2, align 8
  %12 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 0
  %13 = load %struct.dim3*, %struct.dim3** %12, align 8
  %14 = bitcast %struct.dim3* %3 to i8*
  %15 = bitcast %struct.dim3* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %14, i8* align 4 %15, i64 12, i1 false)
  %16 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 1
  %17 = load %struct.dim3*, %struct.dim3** %16, align 8
  %18 = bitcast %struct.dim3* %4 to i8*
  %19 = bitcast %struct.dim3* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %18, i8* align 4 %19, i64 12, i1 false)
  %20 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 2
  %21 = load %struct.CUstream_st**, %struct.CUstream_st*** %20, align 8
  %22 = load %struct.CUstream_st*, %struct.CUstream_st** %21, align 8
  %23 = bitcast %struct.CUstream_st* %22 to i8*
  %24 = bitcast { i64, i32 }* %5 to i8*
  %25 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %24, i8* align 4 %25, i64 12, i1 false)
  %26 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %27 = load i64, i64* %26, align 4
  %28 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %29 = load i32, i32* %28, align 4
  %30 = bitcast { i64, i32 }* %6 to i8*
  %31 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %30, i8* align 4 %31, i64 12, i1 false)
  %32 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %33 = load i64, i64* %32, align 4
  %34 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = call i32 @__cudaPushCallConfiguration(i64 %27, i32 %29, i64 %33, i32 %35, i64 0, i8* %23)
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %50, label %38

38:                                               ; preds = %1
  %39 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 3
  %40 = load %"class.at::Tensor"*, %"class.at::Tensor"** %39, align 8
  %41 = bitcast %"class.at::Tensor"* %40 to %"class.at::TensorBase"*
  %42 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %41)
  %43 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 4
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  %45 = bitcast %"class.at::Tensor"* %44 to %"class.at::TensorBase"*
  %46 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %45)
  %47 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 5
  %48 = load i64*, i64** %47, align 8
  %49 = load i64, i64* %48, align 8
  call void @_ZN4vllm38__device_stub__segmented_max_reductionIN3c108BFloat16EEEvPfPKT_l(float* %42, %"class.caffe2::TypeMeta"* %46, i64 %49)
  br label %50

50:                                               ; preds = %38, %1
  %51 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 0
  %52 = load %struct.dim3*, %struct.dim3** %51, align 8
  %53 = bitcast %struct.dim3* %7 to i8*
  %54 = bitcast %struct.dim3* %52 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %53, i8* align 4 %54, i64 12, i1 false)
  %55 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 1
  %56 = load %struct.dim3*, %struct.dim3** %55, align 8
  %57 = bitcast %struct.dim3* %8 to i8*
  %58 = bitcast %struct.dim3* %56 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %57, i8* align 4 %58, i64 12, i1 false)
  %59 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 2
  %60 = load %struct.CUstream_st**, %struct.CUstream_st*** %59, align 8
  %61 = load %struct.CUstream_st*, %struct.CUstream_st** %60, align 8
  %62 = bitcast %struct.CUstream_st* %61 to i8*
  %63 = bitcast { i64, i32 }* %9 to i8*
  %64 = bitcast %struct.dim3* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %63, i8* align 4 %64, i64 12, i1 false)
  %65 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 0
  %66 = load i64, i64* %65, align 4
  %67 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 1
  %68 = load i32, i32* %67, align 4
  %69 = bitcast { i64, i32 }* %10 to i8*
  %70 = bitcast %struct.dim3* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %69, i8* align 4 %70, i64 12, i1 false)
  %71 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 0
  %72 = load i64, i64* %71, align 4
  %73 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 1
  %74 = load i32, i32* %73, align 4
  %75 = call i32 @__cudaPushCallConfiguration(i64 %66, i32 %68, i64 %72, i32 %74, i64 0, i8* %62)
  %76 = icmp ne i32 %75, 0
  br i1 %76, label %93, label %77

77:                                               ; preds = %50
  %78 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 6
  %79 = load %"class.at::Tensor"*, %"class.at::Tensor"** %78, align 8
  %80 = bitcast %"class.at::Tensor"* %79 to %"class.at::TensorBase"*
  %81 = call %"class.std::ios_base::Init"* @_ZNK2at10TensorBase8data_ptrIN3c1013Float8_e4m3fnEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %80)
  %82 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 4
  %83 = load %"class.at::Tensor"*, %"class.at::Tensor"** %82, align 8
  %84 = bitcast %"class.at::Tensor"* %83 to %"class.at::TensorBase"*
  %85 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %84)
  %86 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 3
  %87 = load %"class.at::Tensor"*, %"class.at::Tensor"** %86, align 8
  %88 = bitcast %"class.at::Tensor"* %87 to %"class.at::TensorBase"*
  %89 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %88)
  %90 = getelementptr inbounds %class.anon.96, %class.anon.96* %11, i32 0, i32 5
  %91 = load i64*, i64** %90, align 8
  %92 = load i64, i64* %91, align 8
  call void @_ZN4vllm38__device_stub__scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* %81, %"class.caffe2::TypeMeta"* %85, float* %89, i64 %92)
  br label %93

93:                                               ; preds = %77, %50
  ret void
}

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__segmented_max_reductionIN3c108BFloat16EEEvPfPKT_l(float* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, i64 %2) #11 {
  %4 = alloca float*, align 8
  %5 = alloca %"class.caffe2::TypeMeta"*, align 8
  %6 = alloca i64, align 8
  %7 = alloca %struct.dim3, align 8
  %8 = alloca %struct.dim3, align 8
  %9 = alloca i64, align 8
  %10 = alloca i8*, align 8
  %11 = alloca { i64, i32 }, align 8
  %12 = alloca { i64, i32 }, align 8
  store float* %0, float** %4, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %5, align 8
  store i64 %2, i64* %6, align 8
  %13 = alloca i8*, i64 3, align 16
  %14 = bitcast float** %4 to i8*
  %15 = getelementptr i8*, i8** %13, i32 0
  store i8* %14, i8** %15, align 8
  %16 = bitcast %"class.caffe2::TypeMeta"** %5 to i8*
  %17 = getelementptr i8*, i8** %13, i32 1
  store i8* %16, i8** %17, align 8
  %18 = bitcast i64* %6 to i8*
  %19 = getelementptr i8*, i8** %13, i32 2
  store i8* %18, i8** %19, align 8
  %20 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %7, %struct.dim3* %8, i64* %9, i8** %10)
  %21 = load i64, i64* %9, align 8
  %22 = load i8*, i8** %10, align 8
  %23 = bitcast { i64, i32 }* %11 to i8*
  %24 = bitcast %struct.dim3* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %23, i8* align 8 %24, i64 12, i1 false)
  %25 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %11, i32 0, i32 0
  %26 = load i64, i64* %25, align 8
  %27 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %11, i32 0, i32 1
  %28 = load i32, i32* %27, align 8
  %29 = bitcast { i64, i32 }* %12 to i8*
  %30 = bitcast %struct.dim3* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %29, i8* align 8 %30, i64 12, i1 false)
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %12, i32 0, i32 0
  %32 = load i64, i64* %31, align 8
  %33 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %12, i32 0, i32 1
  %34 = load i32, i32* %33, align 8
  %35 = bitcast i8* %22 to %struct.CUstream_st*
  %36 = call i32 @cudaLaunchKernel(i8* bitcast (void (float*, %"class.caffe2::TypeMeta"*, i64)* @_ZN4vllm38__device_stub__segmented_max_reductionIN3c108BFloat16EEEvPfPKT_l to i8*), i64 %26, i32 %28, i64 %32, i32 %34, i8** %13, i64 %21, %struct.CUstream_st* %35)
  br label %37

37:                                               ; preds = %3
  ret void
}

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__segmented_max_reductionIN3c104HalfEEEvPfPKT_l(float* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, i64 %2) #11 {
  %4 = alloca float*, align 8
  %5 = alloca %"class.caffe2::TypeMeta"*, align 8
  %6 = alloca i64, align 8
  %7 = alloca %struct.dim3, align 8
  %8 = alloca %struct.dim3, align 8
  %9 = alloca i64, align 8
  %10 = alloca i8*, align 8
  %11 = alloca { i64, i32 }, align 8
  %12 = alloca { i64, i32 }, align 8
  store float* %0, float** %4, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %5, align 8
  store i64 %2, i64* %6, align 8
  %13 = alloca i8*, i64 3, align 16
  %14 = bitcast float** %4 to i8*
  %15 = getelementptr i8*, i8** %13, i32 0
  store i8* %14, i8** %15, align 8
  %16 = bitcast %"class.caffe2::TypeMeta"** %5 to i8*
  %17 = getelementptr i8*, i8** %13, i32 1
  store i8* %16, i8** %17, align 8
  %18 = bitcast i64* %6 to i8*
  %19 = getelementptr i8*, i8** %13, i32 2
  store i8* %18, i8** %19, align 8
  %20 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %7, %struct.dim3* %8, i64* %9, i8** %10)
  %21 = load i64, i64* %9, align 8
  %22 = load i8*, i8** %10, align 8
  %23 = bitcast { i64, i32 }* %11 to i8*
  %24 = bitcast %struct.dim3* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %23, i8* align 8 %24, i64 12, i1 false)
  %25 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %11, i32 0, i32 0
  %26 = load i64, i64* %25, align 8
  %27 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %11, i32 0, i32 1
  %28 = load i32, i32* %27, align 8
  %29 = bitcast { i64, i32 }* %12 to i8*
  %30 = bitcast %struct.dim3* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %29, i8* align 8 %30, i64 12, i1 false)
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %12, i32 0, i32 0
  %32 = load i64, i64* %31, align 8
  %33 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %12, i32 0, i32 1
  %34 = load i32, i32* %33, align 8
  %35 = bitcast i8* %22 to %struct.CUstream_st*
  %36 = call i32 @cudaLaunchKernel(i8* bitcast (void (float*, %"class.caffe2::TypeMeta"*, i64)* @_ZN4vllm38__device_stub__segmented_max_reductionIN3c104HalfEEEvPfPKT_l to i8*), i64 %26, i32 %28, i64 %32, i32 %34, i8** %13, i64 %21, %struct.CUstream_st* %35)
  br label %37

37:                                               ; preds = %3
  ret void
}

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__segmented_max_reductionIfEEvPfPKT_l(float* noalias %0, float* noalias %1, i64 %2) #11 {
  %4 = alloca float*, align 8
  %5 = alloca float*, align 8
  %6 = alloca i64, align 8
  %7 = alloca %struct.dim3, align 8
  %8 = alloca %struct.dim3, align 8
  %9 = alloca i64, align 8
  %10 = alloca i8*, align 8
  %11 = alloca { i64, i32 }, align 8
  %12 = alloca { i64, i32 }, align 8
  store float* %0, float** %4, align 8
  store float* %1, float** %5, align 8
  store i64 %2, i64* %6, align 8
  %13 = alloca i8*, i64 3, align 16
  %14 = bitcast float** %4 to i8*
  %15 = getelementptr i8*, i8** %13, i32 0
  store i8* %14, i8** %15, align 8
  %16 = bitcast float** %5 to i8*
  %17 = getelementptr i8*, i8** %13, i32 1
  store i8* %16, i8** %17, align 8
  %18 = bitcast i64* %6 to i8*
  %19 = getelementptr i8*, i8** %13, i32 2
  store i8* %18, i8** %19, align 8
  %20 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %7, %struct.dim3* %8, i64* %9, i8** %10)
  %21 = load i64, i64* %9, align 8
  %22 = load i8*, i8** %10, align 8
  %23 = bitcast { i64, i32 }* %11 to i8*
  %24 = bitcast %struct.dim3* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %23, i8* align 8 %24, i64 12, i1 false)
  %25 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %11, i32 0, i32 0
  %26 = load i64, i64* %25, align 8
  %27 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %11, i32 0, i32 1
  %28 = load i32, i32* %27, align 8
  %29 = bitcast { i64, i32 }* %12 to i8*
  %30 = bitcast %struct.dim3* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %29, i8* align 8 %30, i64 12, i1 false)
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %12, i32 0, i32 0
  %32 = load i64, i64* %31, align 8
  %33 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %12, i32 0, i32 1
  %34 = load i32, i32* %33, align 8
  %35 = bitcast i8* %22 to %struct.CUstream_st*
  %36 = call i32 @cudaLaunchKernel(i8* bitcast (void (float*, float*, i64)* @_ZN4vllm38__device_stub__segmented_max_reductionIfEEvPfPKT_l to i8*), i64 %26, i32 %28, i64 %32, i32 %34, i8** %13, i64 %21, %struct.CUstream_st* %35)
  br label %37

37:                                               ; preds = %3
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_Z34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_E(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %0, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %1, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %2, %"class.std::optional.70"* nonnull align 8 dereferenceable(16) %3) #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %5 = alloca %"class.at::Tensor"*, align 8
  %6 = alloca %"class.at::Tensor"*, align 8
  %7 = alloca %"class.at::Tensor"*, align 8
  %8 = alloca %"class.std::optional.70"*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.dim3, align 4
  %12 = alloca %struct.dim3, align 4
  %13 = alloca i32, align 4
  %14 = alloca %"struct.c10::cuda::OptionalCUDAGuard", align 8
  %15 = alloca %"class.std::optional.53", align 1
  %16 = alloca i24, align 4
  %17 = alloca i24, align 4
  %18 = alloca %struct.CUstream_st*, align 8
  %19 = alloca %"class.c10::cuda::CUDAStream", align 8
  %20 = alloca i8*, align 8
  %21 = alloca i32, align 4
  %22 = alloca %class.anon.80, align 8
  store %"class.at::Tensor"* %0, %"class.at::Tensor"** %5, align 8
  store %"class.at::Tensor"* %1, %"class.at::Tensor"** %6, align 8
  store %"class.at::Tensor"* %2, %"class.at::Tensor"** %7, align 8
  store %"class.std::optional.70"* %3, %"class.std::optional.70"** %8, align 8
  %23 = load %"class.at::Tensor"*, %"class.at::Tensor"** %6, align 8
  %24 = bitcast %"class.at::Tensor"* %23 to %"class.at::TensorBase"*
  %25 = call zeroext i1 @_ZNK2at10TensorBase13is_contiguousEN3c1012MemoryFormatE(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %24, i8 signext 0)
  br i1 %25, label %28, label %26

26:                                               ; preds = %4
  %27 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKc(i8* getelementptr inbounds ([156 x i8], [156 x i8]* @.str.1, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__func__._Z34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_E, i64 0, i64 0), i8* getelementptr inbounds ([73 x i8], [73 x i8]* @.str, i64 0, i64 0), i32 273, i8* %27) #25
  unreachable

28:                                               ; preds = %4
  %29 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  %30 = bitcast %"class.at::Tensor"* %29 to %"class.at::TensorBase"*
  %31 = call zeroext i1 @_ZNK2at10TensorBase13is_contiguousEN3c1012MemoryFormatE(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %30, i8 signext 0)
  br i1 %31, label %34, label %32

32:                                               ; preds = %28
  %33 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKc(i8* getelementptr inbounds ([154 x i8], [154 x i8]* @.str.2, i64 0, i64 0))
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @__func__._Z34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_E, i64 0, i64 0), i8* getelementptr inbounds ([73 x i8], [73 x i8]* @.str, i64 0, i64 0), i32 274, i8* %33) #25
  unreachable

34:                                               ; preds = %28
  %35 = load %"class.at::Tensor"*, %"class.at::Tensor"** %6, align 8
  %36 = bitcast %"class.at::Tensor"* %35 to %"class.at::TensorBase"*
  %37 = call i64 @_ZNK2at10TensorBase4sizeEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %36, i64 -1)
  %38 = trunc i64 %37 to i32
  store i32 %38, i32* %9, align 4
  %39 = load %"class.at::Tensor"*, %"class.at::Tensor"** %6, align 8
  %40 = bitcast %"class.at::Tensor"* %39 to %"class.at::TensorBase"*
  %41 = call i64 @_ZNK2at10TensorBase5numelEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %40)
  %42 = load i32, i32* %9, align 4
  %43 = sext i32 %42 to i64
  %44 = sdiv i64 %41, %43
  %45 = trunc i64 %44 to i32
  store i32 %45, i32* %10, align 4
  %46 = load i32, i32* %10, align 4
  call void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %11, i32 %46, i32 1, i32 1)
  store i32 1024, i32* %13, align 4
  %47 = call nonnull align 4 dereferenceable(4) i32* @_ZSt3minIiEUa9enable_ifILb1EERKT_S2_S2_(i32* nonnull align 4 dereferenceable(4) %9, i32* nonnull align 4 dereferenceable(4) %13)
  %48 = load i32, i32* %47, align 4
  call void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %12, i32 %48, i32 1, i32 1)
  %49 = load %"class.at::Tensor"*, %"class.at::Tensor"** %6, align 8
  %50 = call i24 @_ZN2at9device_ofERKNS_6TensorE(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %49)
  %51 = getelementptr inbounds %"class.std::optional.53", %"class.std::optional.53"* %15, i32 0, i32 0
  %52 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %51, i32 0, i32 0
  %53 = getelementptr inbounds %"struct.std::_Optional_payload.56", %"struct.std::_Optional_payload.56"* %52, i32 0, i32 0
  store i24 %50, i24* %16, align 4
  %54 = bitcast %"struct.std::_Optional_payload_base.57"* %53 to i8*
  %55 = bitcast i24* %16 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %54, i8* align 4 %55, i64 3, i1 false)
  %56 = getelementptr inbounds %"class.std::optional.53", %"class.std::optional.53"* %15, i32 0, i32 0
  %57 = getelementptr inbounds %"struct.std::_Optional_base.54", %"struct.std::_Optional_base.54"* %56, i32 0, i32 0
  %58 = getelementptr inbounds %"struct.std::_Optional_payload.56", %"struct.std::_Optional_payload.56"* %57, i32 0, i32 0
  %59 = bitcast i24* %17 to i8*
  %60 = bitcast %"struct.std::_Optional_payload_base.57"* %58 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %59, i8* align 1 %60, i64 3, i1 false)
  %61 = load i24, i24* %17, align 4
  call void @_ZN3c104cuda17OptionalCUDAGuardC2ESt8optionalINS_6DeviceEE(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %14, i24 %61)
  %62 = invoke { i64, i64 } @_ZN3c104cuda20getCurrentCUDAStreamEa(i8 signext -1)
          to label %63 unwind label %85

63:                                               ; preds = %34
  %64 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %19, i32 0, i32 0
  %65 = bitcast %"class.c10::Stream"* %64 to { i64, i64 }*
  %66 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %65, i32 0, i32 0
  %67 = extractvalue { i64, i64 } %62, 0
  store i64 %67, i64* %66, align 8
  %68 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %65, i32 0, i32 1
  %69 = extractvalue { i64, i64 } %62, 1
  store i64 %69, i64* %68, align 8
  %70 = invoke %struct.CUstream_st* @_ZNK3c104cuda10CUDAStreamcvP11CUstream_stEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %19)
          to label %71 unwind label %85

71:                                               ; preds = %63
  store %struct.CUstream_st* %70, %struct.CUstream_st** %18, align 8
  %72 = getelementptr inbounds %class.anon.80, %class.anon.80* %22, i32 0, i32 0
  %73 = load %"class.at::Tensor"*, %"class.at::Tensor"** %6, align 8
  store %"class.at::Tensor"* %73, %"class.at::Tensor"** %72, align 8
  %74 = getelementptr inbounds %class.anon.80, %class.anon.80* %22, i32 0, i32 1
  store %struct.dim3* %11, %struct.dim3** %74, align 8
  %75 = getelementptr inbounds %class.anon.80, %class.anon.80* %22, i32 0, i32 2
  store %struct.dim3* %12, %struct.dim3** %75, align 8
  %76 = getelementptr inbounds %class.anon.80, %class.anon.80* %22, i32 0, i32 3
  store %struct.CUstream_st** %18, %struct.CUstream_st*** %76, align 8
  %77 = getelementptr inbounds %class.anon.80, %class.anon.80* %22, i32 0, i32 4
  %78 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8
  store %"class.at::Tensor"* %78, %"class.at::Tensor"** %77, align 8
  %79 = getelementptr inbounds %class.anon.80, %class.anon.80* %22, i32 0, i32 5
  %80 = load %"class.at::Tensor"*, %"class.at::Tensor"** %7, align 8
  store %"class.at::Tensor"* %80, %"class.at::Tensor"** %79, align 8
  %81 = getelementptr inbounds %class.anon.80, %class.anon.80* %22, i32 0, i32 6
  %82 = load %"class.std::optional.70"*, %"class.std::optional.70"** %8, align 8
  store %"class.std::optional.70"* %82, %"class.std::optional.70"** %81, align 8
  %83 = getelementptr inbounds %class.anon.80, %class.anon.80* %22, i32 0, i32 7
  store i32* %9, i32** %83, align 8
  invoke void @_ZZ34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_EENKUlvE_clEv(%class.anon.80* nonnull align 8 dereferenceable(64) %22)
          to label %84 unwind label %85

84:                                               ; preds = %71
  call void @_ZN3c104cuda17OptionalCUDAGuardD2Ev(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %14) #3
  ret void

85:                                               ; preds = %71, %63, %34
  %86 = landingpad { i8*, i32 }
          cleanup
  %87 = extractvalue { i8*, i32 } %86, 0
  store i8* %87, i8** %20, align 8
  %88 = extractvalue { i8*, i32 } %86, 1
  store i32 %88, i32* %21, align 4
  call void @_ZN3c104cuda17OptionalCUDAGuardD2Ev(%"struct.c10::cuda::OptionalCUDAGuard"* nonnull align 8 dereferenceable(24) %14) #3
  br label %89

89:                                               ; preds = %85
  %90 = load i8*, i8** %20, align 8
  %91 = load i32, i32* %21, align 4
  %92 = insertvalue { i8*, i32 } undef, i8* %90, 0
  %93 = insertvalue { i8*, i32 } %92, i32 %91, 1
  resume { i8*, i32 } %93
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK2at10TensorBase13is_contiguousEN3c1012MemoryFormatE(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0, i8 signext %1) #4 comdat align 2 {
  %3 = alloca %"class.at::TensorBase"*, align 8
  %4 = alloca i8, align 1
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %3, align 8
  store i8 %1, i8* %4, align 1
  %5 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %3, align 8
  %6 = getelementptr inbounds %"class.at::TensorBase", %"class.at::TensorBase"* %5, i32 0, i32 0
  %7 = call %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %6) #3
  %8 = load i8, i8* %4, align 1
  %9 = call zeroext i1 @_ZNK3c1010TensorImpl13is_contiguousENS_12MemoryFormatE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %7, i8 signext %8)
  ret i1 %9
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 4 dereferenceable(4) i32* @_ZSt3minIiEUa9enable_ifILb1EERKT_S2_S2_(i32* nonnull align 4 dereferenceable(4) %0, i32* nonnull align 4 dereferenceable(4) %1) #8 comdat {
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  store i32* %0, i32** %3, align 8
  store i32* %1, i32** %4, align 8
  %5 = load i32*, i32** %3, align 8
  %6 = load i32, i32* %5, align 4
  %7 = load i32*, i32** %4, align 8
  %8 = load i32, i32* %7, align 4
  %9 = icmp slt i32 %6, %8
  br i1 %9, label %10, label %12

10:                                               ; preds = %2
  %11 = load i32*, i32** %3, align 8
  br label %14

12:                                               ; preds = %2
  %13 = load i32*, i32** %4, align 8
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i32* [ %11, %10 ], [ %13, %12 ]
  ret i32* %15
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZ34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_EENKUlvE_clEv(%class.anon.80* nonnull align 8 dereferenceable(64) %0) #4 align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %class.anon.80*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i8, align 1
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  %7 = alloca %class.anon.99, align 8
  %8 = alloca %class.anon.99, align 8
  %9 = alloca %class.anon.99, align 8
  %10 = alloca %"class.std::__cxx11::basic_string", align 8
  %11 = alloca i8, align 1
  %12 = alloca i8*, align 8
  %13 = alloca i8*, align 8
  %14 = alloca i32, align 4
  store %class.anon.80* %0, %class.anon.80** %2, align 8
  %15 = load %class.anon.80*, %class.anon.80** %2, align 8
  %16 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 0
  %17 = load %"class.at::Tensor"*, %"class.at::Tensor"** %16, align 8
  %18 = bitcast %"class.at::Tensor"* %17 to %"class.at::TensorBase"*
  %19 = call signext i8 @_ZNK2at10TensorBase11scalar_typeEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %18)
  store i8 %19, i8* %4, align 1
  store i8* %4, i8** %3, align 8
  store i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.91, i32 0, i32 0), i8** %5, align 8
  %20 = load i8*, i8** %3, align 8
  %21 = load i8, i8* %20, align 1
  %22 = call signext i8 @_ZN6detail11scalar_typeEN3c1010ScalarTypeE(i8 signext %21)
  store i8 %22, i8* %6, align 1
  %23 = load i8, i8* %6, align 1
  switch i8 %23, label %105 [
    i8 6, label %24
    i8 5, label %51
    i8 15, label %78
  ]

24:                                               ; preds = %1
  br label %25

25:                                               ; preds = %24
  br label %26

26:                                               ; preds = %25
  %27 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 0
  %28 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 1
  %29 = load %struct.dim3*, %struct.dim3** %28, align 8
  store %struct.dim3* %29, %struct.dim3** %27, align 8
  %30 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 1
  %31 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 2
  %32 = load %struct.dim3*, %struct.dim3** %31, align 8
  store %struct.dim3* %32, %struct.dim3** %30, align 8
  %33 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 2
  %34 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 3
  %35 = load %struct.CUstream_st**, %struct.CUstream_st*** %34, align 8
  store %struct.CUstream_st** %35, %struct.CUstream_st*** %33, align 8
  %36 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 3
  %37 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 4
  %38 = load %"class.at::Tensor"*, %"class.at::Tensor"** %37, align 8
  store %"class.at::Tensor"* %38, %"class.at::Tensor"** %36, align 8
  %39 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 4
  %40 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 5
  %41 = load %"class.at::Tensor"*, %"class.at::Tensor"** %40, align 8
  store %"class.at::Tensor"* %41, %"class.at::Tensor"** %39, align 8
  %42 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 5
  %43 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 0
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  store %"class.at::Tensor"* %44, %"class.at::Tensor"** %42, align 8
  %45 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 6
  %46 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 6
  %47 = load %"class.std::optional.70"*, %"class.std::optional.70"** %46, align 8
  store %"class.std::optional.70"* %47, %"class.std::optional.70"** %45, align 8
  %48 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 7
  %49 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 7
  %50 = load i32*, i32** %49, align 8
  store i32* %50, i32** %48, align 8
  call void @_ZZZ34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_EENKUlvE_clEvENKUlvE_clEv(%class.anon.99* nonnull align 8 dereferenceable(64) %7)
  br label %113

51:                                               ; preds = %1
  br label %52

52:                                               ; preds = %51
  br label %53

53:                                               ; preds = %52
  %54 = getelementptr inbounds %class.anon.99, %class.anon.99* %8, i32 0, i32 0
  %55 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 1
  %56 = load %struct.dim3*, %struct.dim3** %55, align 8
  store %struct.dim3* %56, %struct.dim3** %54, align 8
  %57 = getelementptr inbounds %class.anon.99, %class.anon.99* %8, i32 0, i32 1
  %58 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 2
  %59 = load %struct.dim3*, %struct.dim3** %58, align 8
  store %struct.dim3* %59, %struct.dim3** %57, align 8
  %60 = getelementptr inbounds %class.anon.99, %class.anon.99* %8, i32 0, i32 2
  %61 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 3
  %62 = load %struct.CUstream_st**, %struct.CUstream_st*** %61, align 8
  store %struct.CUstream_st** %62, %struct.CUstream_st*** %60, align 8
  %63 = getelementptr inbounds %class.anon.99, %class.anon.99* %8, i32 0, i32 3
  %64 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 4
  %65 = load %"class.at::Tensor"*, %"class.at::Tensor"** %64, align 8
  store %"class.at::Tensor"* %65, %"class.at::Tensor"** %63, align 8
  %66 = getelementptr inbounds %class.anon.99, %class.anon.99* %8, i32 0, i32 4
  %67 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 5
  %68 = load %"class.at::Tensor"*, %"class.at::Tensor"** %67, align 8
  store %"class.at::Tensor"* %68, %"class.at::Tensor"** %66, align 8
  %69 = getelementptr inbounds %class.anon.99, %class.anon.99* %8, i32 0, i32 5
  %70 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 0
  %71 = load %"class.at::Tensor"*, %"class.at::Tensor"** %70, align 8
  store %"class.at::Tensor"* %71, %"class.at::Tensor"** %69, align 8
  %72 = getelementptr inbounds %class.anon.99, %class.anon.99* %8, i32 0, i32 6
  %73 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 6
  %74 = load %"class.std::optional.70"*, %"class.std::optional.70"** %73, align 8
  store %"class.std::optional.70"* %74, %"class.std::optional.70"** %72, align 8
  %75 = getelementptr inbounds %class.anon.99, %class.anon.99* %8, i32 0, i32 7
  %76 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 7
  %77 = load i32*, i32** %76, align 8
  store i32* %77, i32** %75, align 8
  call void @_ZZZ34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_EENKUlvE_clEvENKUlvE0_clEv(%class.anon.99* nonnull align 8 dereferenceable(64) %8)
  br label %113

78:                                               ; preds = %1
  br label %79

79:                                               ; preds = %78
  br label %80

80:                                               ; preds = %79
  %81 = getelementptr inbounds %class.anon.99, %class.anon.99* %9, i32 0, i32 0
  %82 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 1
  %83 = load %struct.dim3*, %struct.dim3** %82, align 8
  store %struct.dim3* %83, %struct.dim3** %81, align 8
  %84 = getelementptr inbounds %class.anon.99, %class.anon.99* %9, i32 0, i32 1
  %85 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 2
  %86 = load %struct.dim3*, %struct.dim3** %85, align 8
  store %struct.dim3* %86, %struct.dim3** %84, align 8
  %87 = getelementptr inbounds %class.anon.99, %class.anon.99* %9, i32 0, i32 2
  %88 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 3
  %89 = load %struct.CUstream_st**, %struct.CUstream_st*** %88, align 8
  store %struct.CUstream_st** %89, %struct.CUstream_st*** %87, align 8
  %90 = getelementptr inbounds %class.anon.99, %class.anon.99* %9, i32 0, i32 3
  %91 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 4
  %92 = load %"class.at::Tensor"*, %"class.at::Tensor"** %91, align 8
  store %"class.at::Tensor"* %92, %"class.at::Tensor"** %90, align 8
  %93 = getelementptr inbounds %class.anon.99, %class.anon.99* %9, i32 0, i32 4
  %94 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 5
  %95 = load %"class.at::Tensor"*, %"class.at::Tensor"** %94, align 8
  store %"class.at::Tensor"* %95, %"class.at::Tensor"** %93, align 8
  %96 = getelementptr inbounds %class.anon.99, %class.anon.99* %9, i32 0, i32 5
  %97 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 0
  %98 = load %"class.at::Tensor"*, %"class.at::Tensor"** %97, align 8
  store %"class.at::Tensor"* %98, %"class.at::Tensor"** %96, align 8
  %99 = getelementptr inbounds %class.anon.99, %class.anon.99* %9, i32 0, i32 6
  %100 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 6
  %101 = load %"class.std::optional.70"*, %"class.std::optional.70"** %100, align 8
  store %"class.std::optional.70"* %101, %"class.std::optional.70"** %99, align 8
  %102 = getelementptr inbounds %class.anon.99, %class.anon.99* %9, i32 0, i32 7
  %103 = getelementptr inbounds %class.anon.80, %class.anon.80* %15, i32 0, i32 7
  %104 = load i32*, i32** %103, align 8
  store i32* %104, i32** %102, align 8
  call void @_ZZZ34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_EENKUlvE_clEvENKUlvE1_clEv(%class.anon.99* nonnull align 8 dereferenceable(64) %9)
  br label %113

105:                                              ; preds = %1
  store i8 34, i8* %11, align 1
  %106 = load i8, i8* %6, align 1
  %107 = call i8* @_ZN3c108toStringENS_10ScalarTypeE(i8 signext %106)
  store i8* %107, i8** %12, align 8
  call void @_ZN3c106detail17torchCheckMsgImplIJcPKcA24_cS3_A2_cEEEDcS3_DpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %10, i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.10, i64 0, i64 0), i8* nonnull align 1 dereferenceable(1) %11, i8** nonnull align 8 dereferenceable(8) %5, [24 x i8]* nonnull align 1 dereferenceable(24) @.str.42, i8** nonnull align 8 dereferenceable(8) %12, [2 x i8]* nonnull align 1 dereferenceable(2) @.str.43)
  invoke void @_ZN3c106detail14torchCheckFailEPKcS2_jRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__func__._ZZ23static_scaled_fp8_quantRN2at6TensorERKS0_S3_ENKUlvE_clEv, i64 0, i64 0), i8* getelementptr inbounds ([73 x i8], [73 x i8]* @.str, i64 0, i64 0), i32 291, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %10) #25
          to label %108 unwind label %109

108:                                              ; preds = %105
  unreachable

109:                                              ; preds = %105
  %110 = landingpad { i8*, i32 }
          cleanup
  %111 = extractvalue { i8*, i32 } %110, 0
  store i8* %111, i8** %13, align 8
  %112 = extractvalue { i8*, i32 } %110, 1
  store i32 %112, i32* %14, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %10) #3
  br label %114

113:                                              ; preds = %80, %53, %26
  ret void

114:                                              ; preds = %109
  %115 = load i8*, i8** %13, align 8
  %116 = load i32, i32* %14, align 4
  %117 = insertvalue { i8*, i32 } undef, i8* %115, 0
  %118 = insertvalue { i8*, i32 } %117, i32 %116, 1
  resume { i8*, i32 } %118
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_EENKUlvE_clEvENKUlvE_clEv(%class.anon.99* nonnull align 8 dereferenceable(64) %0) #4 align 2 {
  %2 = alloca %class.anon.99*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  store %class.anon.99* %0, %class.anon.99** %2, align 8
  %7 = load %class.anon.99*, %class.anon.99** %2, align 8
  %8 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 0
  %9 = load %struct.dim3*, %struct.dim3** %8, align 8
  %10 = bitcast %struct.dim3* %3 to i8*
  %11 = bitcast %struct.dim3* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %10, i8* align 4 %11, i64 12, i1 false)
  %12 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 1
  %13 = load %struct.dim3*, %struct.dim3** %12, align 8
  %14 = bitcast %struct.dim3* %4 to i8*
  %15 = bitcast %struct.dim3* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %14, i8* align 4 %15, i64 12, i1 false)
  %16 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 2
  %17 = load %struct.CUstream_st**, %struct.CUstream_st*** %16, align 8
  %18 = load %struct.CUstream_st*, %struct.CUstream_st** %17, align 8
  %19 = bitcast %struct.CUstream_st* %18 to i8*
  %20 = bitcast { i64, i32 }* %5 to i8*
  %21 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %20, i8* align 4 %21, i64 12, i1 false)
  %22 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %23 = load i64, i64* %22, align 4
  %24 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = bitcast { i64, i32 }* %6 to i8*
  %27 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %26, i8* align 4 %27, i64 12, i1 false)
  %28 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %29 = load i64, i64* %28, align 4
  %30 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = call i32 @__cudaPushCallConfiguration(i64 %23, i32 %25, i64 %29, i32 %31, i64 0, i8* %19)
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %62, label %34

34:                                               ; preds = %1
  %35 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 3
  %36 = load %"class.at::Tensor"*, %"class.at::Tensor"** %35, align 8
  %37 = bitcast %"class.at::Tensor"* %36 to %"class.at::TensorBase"*
  %38 = call %"class.std::ios_base::Init"* @_ZNK2at10TensorBase8data_ptrIN3c1013Float8_e4m3fnEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %37)
  %39 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 4
  %40 = load %"class.at::Tensor"*, %"class.at::Tensor"** %39, align 8
  %41 = bitcast %"class.at::Tensor"* %40 to %"class.at::TensorBase"*
  %42 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %41)
  %43 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 5
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  %45 = bitcast %"class.at::Tensor"* %44 to %"class.at::TensorBase"*
  %46 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %45)
  %47 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 6
  %48 = load %"class.std::optional.70"*, %"class.std::optional.70"** %47, align 8
  %49 = call zeroext i1 @_ZNKSt8optionalIN2at6TensorEE9has_valueEv(%"class.std::optional.70"* nonnull align 8 dereferenceable(16) %48) #3
  br i1 %49, label %50, label %56

50:                                               ; preds = %34
  %51 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 6
  %52 = load %"class.std::optional.70"*, %"class.std::optional.70"** %51, align 8
  %53 = call %"class.at::Tensor"* @_ZNKSt8optionalIN2at6TensorEEptEv(%"class.std::optional.70"* nonnull align 8 dereferenceable(16) %52) #3
  %54 = bitcast %"class.at::Tensor"* %53 to %"class.at::TensorBase"*
  %55 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %54)
  br label %57

56:                                               ; preds = %34
  br label %57

57:                                               ; preds = %56, %50
  %58 = phi float* [ %55, %50 ], [ null, %56 ]
  %59 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 7
  %60 = load i32*, i32** %59, align 8
  %61 = load i32, i32* %60, align 4
  call void @_ZN4vllm56__device_stub__dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfi(%"class.std::ios_base::Init"* %38, float* %42, float* %46, float* %58, i32 %61)
  br label %62

62:                                               ; preds = %57, %1
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_EENKUlvE_clEvENKUlvE0_clEv(%class.anon.99* nonnull align 8 dereferenceable(64) %0) #4 align 2 {
  %2 = alloca %class.anon.99*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  store %class.anon.99* %0, %class.anon.99** %2, align 8
  %7 = load %class.anon.99*, %class.anon.99** %2, align 8
  %8 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 0
  %9 = load %struct.dim3*, %struct.dim3** %8, align 8
  %10 = bitcast %struct.dim3* %3 to i8*
  %11 = bitcast %struct.dim3* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %10, i8* align 4 %11, i64 12, i1 false)
  %12 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 1
  %13 = load %struct.dim3*, %struct.dim3** %12, align 8
  %14 = bitcast %struct.dim3* %4 to i8*
  %15 = bitcast %struct.dim3* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %14, i8* align 4 %15, i64 12, i1 false)
  %16 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 2
  %17 = load %struct.CUstream_st**, %struct.CUstream_st*** %16, align 8
  %18 = load %struct.CUstream_st*, %struct.CUstream_st** %17, align 8
  %19 = bitcast %struct.CUstream_st* %18 to i8*
  %20 = bitcast { i64, i32 }* %5 to i8*
  %21 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %20, i8* align 4 %21, i64 12, i1 false)
  %22 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %23 = load i64, i64* %22, align 4
  %24 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = bitcast { i64, i32 }* %6 to i8*
  %27 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %26, i8* align 4 %27, i64 12, i1 false)
  %28 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %29 = load i64, i64* %28, align 4
  %30 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = call i32 @__cudaPushCallConfiguration(i64 %23, i32 %25, i64 %29, i32 %31, i64 0, i8* %19)
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %62, label %34

34:                                               ; preds = %1
  %35 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 3
  %36 = load %"class.at::Tensor"*, %"class.at::Tensor"** %35, align 8
  %37 = bitcast %"class.at::Tensor"* %36 to %"class.at::TensorBase"*
  %38 = call %"class.std::ios_base::Init"* @_ZNK2at10TensorBase8data_ptrIN3c1013Float8_e4m3fnEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %37)
  %39 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 4
  %40 = load %"class.at::Tensor"*, %"class.at::Tensor"** %39, align 8
  %41 = bitcast %"class.at::Tensor"* %40 to %"class.at::TensorBase"*
  %42 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %41)
  %43 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 5
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  %45 = bitcast %"class.at::Tensor"* %44 to %"class.at::TensorBase"*
  %46 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %45)
  %47 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 6
  %48 = load %"class.std::optional.70"*, %"class.std::optional.70"** %47, align 8
  %49 = call zeroext i1 @_ZNKSt8optionalIN2at6TensorEE9has_valueEv(%"class.std::optional.70"* nonnull align 8 dereferenceable(16) %48) #3
  br i1 %49, label %50, label %56

50:                                               ; preds = %34
  %51 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 6
  %52 = load %"class.std::optional.70"*, %"class.std::optional.70"** %51, align 8
  %53 = call %"class.at::Tensor"* @_ZNKSt8optionalIN2at6TensorEEptEv(%"class.std::optional.70"* nonnull align 8 dereferenceable(16) %52) #3
  %54 = bitcast %"class.at::Tensor"* %53 to %"class.at::TensorBase"*
  %55 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %54)
  br label %57

56:                                               ; preds = %34
  br label %57

57:                                               ; preds = %56, %50
  %58 = phi float* [ %55, %50 ], [ null, %56 ]
  %59 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 7
  %60 = load i32*, i32** %59, align 8
  %61 = load i32, i32* %60, align 4
  call void @_ZN4vllm56__device_stub__dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfi(%"class.std::ios_base::Init"* %38, float* %42, %"class.caffe2::TypeMeta"* %46, float* %58, i32 %61)
  br label %62

62:                                               ; preds = %57, %1
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ34dynamic_per_token_scaled_fp8_quantRN2at6TensorERKS0_S1_RKSt8optionalIS0_EENKUlvE_clEvENKUlvE1_clEv(%class.anon.99* nonnull align 8 dereferenceable(64) %0) #4 align 2 {
  %2 = alloca %class.anon.99*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  store %class.anon.99* %0, %class.anon.99** %2, align 8
  %7 = load %class.anon.99*, %class.anon.99** %2, align 8
  %8 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 0
  %9 = load %struct.dim3*, %struct.dim3** %8, align 8
  %10 = bitcast %struct.dim3* %3 to i8*
  %11 = bitcast %struct.dim3* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %10, i8* align 4 %11, i64 12, i1 false)
  %12 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 1
  %13 = load %struct.dim3*, %struct.dim3** %12, align 8
  %14 = bitcast %struct.dim3* %4 to i8*
  %15 = bitcast %struct.dim3* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %14, i8* align 4 %15, i64 12, i1 false)
  %16 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 2
  %17 = load %struct.CUstream_st**, %struct.CUstream_st*** %16, align 8
  %18 = load %struct.CUstream_st*, %struct.CUstream_st** %17, align 8
  %19 = bitcast %struct.CUstream_st* %18 to i8*
  %20 = bitcast { i64, i32 }* %5 to i8*
  %21 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %20, i8* align 4 %21, i64 12, i1 false)
  %22 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %23 = load i64, i64* %22, align 4
  %24 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = bitcast { i64, i32 }* %6 to i8*
  %27 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %26, i8* align 4 %27, i64 12, i1 false)
  %28 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %29 = load i64, i64* %28, align 4
  %30 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = call i32 @__cudaPushCallConfiguration(i64 %23, i32 %25, i64 %29, i32 %31, i64 0, i8* %19)
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %62, label %34

34:                                               ; preds = %1
  %35 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 3
  %36 = load %"class.at::Tensor"*, %"class.at::Tensor"** %35, align 8
  %37 = bitcast %"class.at::Tensor"* %36 to %"class.at::TensorBase"*
  %38 = call %"class.std::ios_base::Init"* @_ZNK2at10TensorBase8data_ptrIN3c1013Float8_e4m3fnEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %37)
  %39 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 4
  %40 = load %"class.at::Tensor"*, %"class.at::Tensor"** %39, align 8
  %41 = bitcast %"class.at::Tensor"* %40 to %"class.at::TensorBase"*
  %42 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %41)
  %43 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 5
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  %45 = bitcast %"class.at::Tensor"* %44 to %"class.at::TensorBase"*
  %46 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %45)
  %47 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 6
  %48 = load %"class.std::optional.70"*, %"class.std::optional.70"** %47, align 8
  %49 = call zeroext i1 @_ZNKSt8optionalIN2at6TensorEE9has_valueEv(%"class.std::optional.70"* nonnull align 8 dereferenceable(16) %48) #3
  br i1 %49, label %50, label %56

50:                                               ; preds = %34
  %51 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 6
  %52 = load %"class.std::optional.70"*, %"class.std::optional.70"** %51, align 8
  %53 = call %"class.at::Tensor"* @_ZNKSt8optionalIN2at6TensorEEptEv(%"class.std::optional.70"* nonnull align 8 dereferenceable(16) %52) #3
  %54 = bitcast %"class.at::Tensor"* %53 to %"class.at::TensorBase"*
  %55 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %54)
  br label %57

56:                                               ; preds = %34
  br label %57

57:                                               ; preds = %56, %50
  %58 = phi float* [ %55, %50 ], [ null, %56 ]
  %59 = getelementptr inbounds %class.anon.99, %class.anon.99* %7, i32 0, i32 7
  %60 = load i32*, i32** %59, align 8
  %61 = load i32, i32* %60, align 4
  call void @_ZN4vllm56__device_stub__dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfi(%"class.std::ios_base::Init"* %38, float* %42, %"class.caffe2::TypeMeta"* %46, float* %58, i32 %61)
  br label %62

62:                                               ; preds = %57, %1
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNKSt8optionalIN2at6TensorEE9has_valueEv(%"class.std::optional.70"* nonnull align 8 dereferenceable(16) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::optional.70"*, align 8
  store %"class.std::optional.70"* %0, %"class.std::optional.70"** %2, align 8
  %3 = load %"class.std::optional.70"*, %"class.std::optional.70"** %2, align 8
  %4 = bitcast %"class.std::optional.70"* %3 to %"class.std::ios_base::Init"*
  %5 = call zeroext i1 @_ZNKSt19_Optional_base_implIN2at6TensorESt14_Optional_baseIS1_Lb0ELb0EEE13_M_is_engagedEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %4) #3
  ret i1 %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"class.at::Tensor"* @_ZNKSt8optionalIN2at6TensorEEptEv(%"class.std::optional.70"* nonnull align 8 dereferenceable(16) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::optional.70"*, align 8
  store %"class.std::optional.70"* %0, %"class.std::optional.70"** %2, align 8
  %3 = load %"class.std::optional.70"*, %"class.std::optional.70"** %2, align 8
  %4 = bitcast %"class.std::optional.70"* %3 to %"class.std::ios_base::Init"*
  %5 = call nonnull align 8 dereferenceable(8) %"class.at::Tensor"* @_ZNKSt19_Optional_base_implIN2at6TensorESt14_Optional_baseIS1_Lb0ELb0EEE6_M_getEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %4) #3
  %6 = call %"class.at::Tensor"* @_ZSt11__addressofIKN2at6TensorEEPT_RS3_(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %5) #3
  ret %"class.at::Tensor"* %6
}

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm56__device_stub__dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfi(%"class.std::ios_base::Init"* noalias %0, float* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, float* noalias %3, i32 %4) #11 {
  %6 = alloca %"class.std::ios_base::Init"*, align 8
  %7 = alloca float*, align 8
  %8 = alloca %"class.caffe2::TypeMeta"*, align 8
  %9 = alloca float*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.dim3, align 8
  %12 = alloca %struct.dim3, align 8
  %13 = alloca i64, align 8
  %14 = alloca i8*, align 8
  %15 = alloca { i64, i32 }, align 8
  %16 = alloca { i64, i32 }, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %6, align 8
  store float* %1, float** %7, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %8, align 8
  store float* %3, float** %9, align 8
  store i32 %4, i32* %10, align 4
  %17 = alloca i8*, i64 5, align 16
  %18 = bitcast %"class.std::ios_base::Init"** %6 to i8*
  %19 = getelementptr i8*, i8** %17, i32 0
  store i8* %18, i8** %19, align 8
  %20 = bitcast float** %7 to i8*
  %21 = getelementptr i8*, i8** %17, i32 1
  store i8* %20, i8** %21, align 8
  %22 = bitcast %"class.caffe2::TypeMeta"** %8 to i8*
  %23 = getelementptr i8*, i8** %17, i32 2
  store i8* %22, i8** %23, align 8
  %24 = bitcast float** %9 to i8*
  %25 = getelementptr i8*, i8** %17, i32 3
  store i8* %24, i8** %25, align 8
  %26 = bitcast i32* %10 to i8*
  %27 = getelementptr i8*, i8** %17, i32 4
  store i8* %26, i8** %27, align 8
  %28 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %11, %struct.dim3* %12, i64* %13, i8** %14)
  %29 = load i64, i64* %13, align 8
  %30 = load i8*, i8** %14, align 8
  %31 = bitcast { i64, i32 }* %15 to i8*
  %32 = bitcast %struct.dim3* %11 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %31, i8* align 8 %32, i64 12, i1 false)
  %33 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %15, i32 0, i32 0
  %34 = load i64, i64* %33, align 8
  %35 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %15, i32 0, i32 1
  %36 = load i32, i32* %35, align 8
  %37 = bitcast { i64, i32 }* %16 to i8*
  %38 = bitcast %struct.dim3* %12 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %37, i8* align 8 %38, i64 12, i1 false)
  %39 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %16, i32 0, i32 0
  %40 = load i64, i64* %39, align 8
  %41 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %16, i32 0, i32 1
  %42 = load i32, i32* %41, align 8
  %43 = bitcast i8* %30 to %struct.CUstream_st*
  %44 = call i32 @cudaLaunchKernel(i8* bitcast (void (%"class.std::ios_base::Init"*, float*, %"class.caffe2::TypeMeta"*, float*, i32)* @_ZN4vllm56__device_stub__dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfi to i8*), i64 %34, i32 %36, i64 %40, i32 %42, i8** %17, i64 %29, %struct.CUstream_st* %43)
  br label %45

45:                                               ; preds = %5
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.at::Tensor"* @_ZNKSt19_Optional_base_implIN2at6TensorESt14_Optional_baseIS1_Lb0ELb0EEE6_M_getEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  br label %4

4:                                                ; preds = %1
  br label %5

5:                                                ; preds = %4
  br label %6

6:                                                ; preds = %5
  %7 = bitcast %"class.std::ios_base::Init"* %3 to %"struct.std::_Optional_base.71"*
  %8 = getelementptr inbounds %"struct.std::_Optional_base.71", %"struct.std::_Optional_base.71"* %7, i32 0, i32 0
  %9 = bitcast %"struct.std::_Optional_payload.73"* %8 to %"struct.std::_Optional_payload_base.75"*
  %10 = call nonnull align 8 dereferenceable(8) %"class.at::Tensor"* @_ZNKSt22_Optional_payload_baseIN2at6TensorEE6_M_getEv(%"struct.std::_Optional_payload_base.75"* nonnull align 8 dereferenceable(9) %9) #3
  ret %"class.at::Tensor"* %10
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"class.at::Tensor"* @_ZSt11__addressofIKN2at6TensorEEPT_RS3_(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %0) #8 comdat {
  %2 = alloca %"class.at::Tensor"*, align 8
  store %"class.at::Tensor"* %0, %"class.at::Tensor"** %2, align 8
  %3 = load %"class.at::Tensor"*, %"class.at::Tensor"** %2, align 8
  ret %"class.at::Tensor"* %3
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.at::Tensor"* @_ZNKSt22_Optional_payload_baseIN2at6TensorEE6_M_getEv(%"struct.std::_Optional_payload_base.75"* nonnull align 8 dereferenceable(9) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::_Optional_payload_base.75"*, align 8
  store %"struct.std::_Optional_payload_base.75"* %0, %"struct.std::_Optional_payload_base.75"** %2, align 8
  %3 = load %"struct.std::_Optional_payload_base.75"*, %"struct.std::_Optional_payload_base.75"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Optional_payload_base.75", %"struct.std::_Optional_payload_base.75"* %3, i32 0, i32 0
  %5 = bitcast %"union.std::_Optional_payload_base<at::Tensor>::_Storage"* %4 to %"class.at::Tensor"*
  ret %"class.at::Tensor"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNKSt19_Optional_base_implIN2at6TensorESt14_Optional_baseIS1_Lb0ELb0EEE13_M_is_engagedEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  %4 = bitcast %"class.std::ios_base::Init"* %3 to %"struct.std::_Optional_base.71"*
  %5 = getelementptr inbounds %"struct.std::_Optional_base.71", %"struct.std::_Optional_base.71"* %4, i32 0, i32 0
  %6 = bitcast %"struct.std::_Optional_payload.73"* %5 to %"struct.std::_Optional_payload_base.75"*
  %7 = getelementptr inbounds %"struct.std::_Optional_payload_base.75", %"struct.std::_Optional_payload_base.75"* %6, i32 0, i32 1
  %8 = load i8, i8* %7, align 8
  %9 = trunc i8 %8 to i1
  ret i1 %9
}

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm56__device_stub__dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfi(%"class.std::ios_base::Init"* noalias %0, float* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, float* noalias %3, i32 %4) #11 {
  %6 = alloca %"class.std::ios_base::Init"*, align 8
  %7 = alloca float*, align 8
  %8 = alloca %"class.caffe2::TypeMeta"*, align 8
  %9 = alloca float*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.dim3, align 8
  %12 = alloca %struct.dim3, align 8
  %13 = alloca i64, align 8
  %14 = alloca i8*, align 8
  %15 = alloca { i64, i32 }, align 8
  %16 = alloca { i64, i32 }, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %6, align 8
  store float* %1, float** %7, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %8, align 8
  store float* %3, float** %9, align 8
  store i32 %4, i32* %10, align 4
  %17 = alloca i8*, i64 5, align 16
  %18 = bitcast %"class.std::ios_base::Init"** %6 to i8*
  %19 = getelementptr i8*, i8** %17, i32 0
  store i8* %18, i8** %19, align 8
  %20 = bitcast float** %7 to i8*
  %21 = getelementptr i8*, i8** %17, i32 1
  store i8* %20, i8** %21, align 8
  %22 = bitcast %"class.caffe2::TypeMeta"** %8 to i8*
  %23 = getelementptr i8*, i8** %17, i32 2
  store i8* %22, i8** %23, align 8
  %24 = bitcast float** %9 to i8*
  %25 = getelementptr i8*, i8** %17, i32 3
  store i8* %24, i8** %25, align 8
  %26 = bitcast i32* %10 to i8*
  %27 = getelementptr i8*, i8** %17, i32 4
  store i8* %26, i8** %27, align 8
  %28 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %11, %struct.dim3* %12, i64* %13, i8** %14)
  %29 = load i64, i64* %13, align 8
  %30 = load i8*, i8** %14, align 8
  %31 = bitcast { i64, i32 }* %15 to i8*
  %32 = bitcast %struct.dim3* %11 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %31, i8* align 8 %32, i64 12, i1 false)
  %33 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %15, i32 0, i32 0
  %34 = load i64, i64* %33, align 8
  %35 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %15, i32 0, i32 1
  %36 = load i32, i32* %35, align 8
  %37 = bitcast { i64, i32 }* %16 to i8*
  %38 = bitcast %struct.dim3* %12 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %37, i8* align 8 %38, i64 12, i1 false)
  %39 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %16, i32 0, i32 0
  %40 = load i64, i64* %39, align 8
  %41 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %16, i32 0, i32 1
  %42 = load i32, i32* %41, align 8
  %43 = bitcast i8* %30 to %struct.CUstream_st*
  %44 = call i32 @cudaLaunchKernel(i8* bitcast (void (%"class.std::ios_base::Init"*, float*, %"class.caffe2::TypeMeta"*, float*, i32)* @_ZN4vllm56__device_stub__dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfi to i8*), i64 %34, i32 %36, i64 %40, i32 %42, i8** %17, i64 %29, %struct.CUstream_st* %43)
  br label %45

45:                                               ; preds = %5
  ret void
}

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm56__device_stub__dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfi(%"class.std::ios_base::Init"* noalias %0, float* noalias %1, float* noalias %2, float* noalias %3, i32 %4) #11 {
  %6 = alloca %"class.std::ios_base::Init"*, align 8
  %7 = alloca float*, align 8
  %8 = alloca float*, align 8
  %9 = alloca float*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.dim3, align 8
  %12 = alloca %struct.dim3, align 8
  %13 = alloca i64, align 8
  %14 = alloca i8*, align 8
  %15 = alloca { i64, i32 }, align 8
  %16 = alloca { i64, i32 }, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %6, align 8
  store float* %1, float** %7, align 8
  store float* %2, float** %8, align 8
  store float* %3, float** %9, align 8
  store i32 %4, i32* %10, align 4
  %17 = alloca i8*, i64 5, align 16
  %18 = bitcast %"class.std::ios_base::Init"** %6 to i8*
  %19 = getelementptr i8*, i8** %17, i32 0
  store i8* %18, i8** %19, align 8
  %20 = bitcast float** %7 to i8*
  %21 = getelementptr i8*, i8** %17, i32 1
  store i8* %20, i8** %21, align 8
  %22 = bitcast float** %8 to i8*
  %23 = getelementptr i8*, i8** %17, i32 2
  store i8* %22, i8** %23, align 8
  %24 = bitcast float** %9 to i8*
  %25 = getelementptr i8*, i8** %17, i32 3
  store i8* %24, i8** %25, align 8
  %26 = bitcast i32* %10 to i8*
  %27 = getelementptr i8*, i8** %17, i32 4
  store i8* %26, i8** %27, align 8
  %28 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %11, %struct.dim3* %12, i64* %13, i8** %14)
  %29 = load i64, i64* %13, align 8
  %30 = load i8*, i8** %14, align 8
  %31 = bitcast { i64, i32 }* %15 to i8*
  %32 = bitcast %struct.dim3* %11 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %31, i8* align 8 %32, i64 12, i1 false)
  %33 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %15, i32 0, i32 0
  %34 = load i64, i64* %33, align 8
  %35 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %15, i32 0, i32 1
  %36 = load i32, i32* %35, align 8
  %37 = bitcast { i64, i32 }* %16 to i8*
  %38 = bitcast %struct.dim3* %12 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %37, i8* align 8 %38, i64 12, i1 false)
  %39 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %16, i32 0, i32 0
  %40 = load i64, i64* %39, align 8
  %41 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %16, i32 0, i32 1
  %42 = load i32, i32* %41, align 8
  %43 = bitcast i8* %30 to %struct.CUstream_st*
  %44 = call i32 @cudaLaunchKernel(i8* bitcast (void (%"class.std::ios_base::Init"*, float*, float*, float*, i32)* @_ZN4vllm56__device_stub__dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfi to i8*), i64 %34, i32 %36, i64 %40, i32 %42, i8** %17, i64 %29, %struct.CUstream_st* %43)
  br label %45

45:                                               ; preds = %5
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1010TensorImpl13is_contiguousENS_12MemoryFormatE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0, i8 signext %1) #4 comdat align 2 {
  %3 = alloca i1, align 1
  %4 = alloca %"struct.c10::TensorImpl"*, align 8
  %5 = alloca i8, align 1
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %4, align 8
  store i8 %1, i8* %5, align 1
  %6 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %4, align 8
  %7 = call zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6, i8 zeroext 1)
  br i1 %7, label %8, label %15

8:                                                ; preds = %2
  %9 = load i8, i8* %5, align 1
  %10 = bitcast %"struct.c10::TensorImpl"* %6 to i1 (%"struct.c10::TensorImpl"*, i8)***
  %11 = load i1 (%"struct.c10::TensorImpl"*, i8)**, i1 (%"struct.c10::TensorImpl"*, i8)*** %10, align 8
  %12 = getelementptr inbounds i1 (%"struct.c10::TensorImpl"*, i8)*, i1 (%"struct.c10::TensorImpl"*, i8)** %11, i64 3
  %13 = load i1 (%"struct.c10::TensorImpl"*, i8)*, i1 (%"struct.c10::TensorImpl"*, i8)** %12, align 8
  %14 = call zeroext i1 %13(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6, i8 signext %9)
  store i1 %14, i1* %3, align 1
  br label %18

15:                                               ; preds = %2
  %16 = load i8, i8* %5, align 1
  %17 = call zeroext i1 @_ZNK3c1010TensorImpl21is_contiguous_defaultENS_12MemoryFormatE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6, i8 signext %16)
  store i1 %17, i1* %3, align 1
  br label %18

18:                                               ; preds = %15, %8
  %19 = load i1, i1* %3, align 1
  ret i1 %19
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1010TensorImpl21is_contiguous_defaultENS_12MemoryFormatE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0, i8 signext %1) #4 comdat align 2 {
  %3 = alloca i1, align 1
  %4 = alloca %"struct.c10::TensorImpl"*, align 8
  %5 = alloca i8, align 1
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %4, align 8
  store i8 %1, i8* %5, align 1
  %6 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %4, align 8
  %7 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %6, i32 0, i32 11
  %8 = bitcast [3 x i8]* %7 to i24*
  %9 = load i24, i24* %8, align 1
  %10 = lshr i24 %9, 12
  %11 = and i24 %10, 1
  %12 = trunc i24 %11 to i1
  br i1 %12, label %13, label %32

13:                                               ; preds = %2
  %14 = load i8, i8* %5, align 1
  %15 = icmp eq i8 %14, 2
  br i1 %15, label %16, label %20

16:                                               ; preds = %13
  %17 = call nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNK3c1010TensorImpl19symbolic_shape_metaEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6)
  %18 = call nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta27is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %17)
  %19 = call zeroext i1 @_ZNK3c107SymBool10guard_boolEPKcl(%"class.c10::SymBool"* nonnull align 8 dereferenceable(16) %18, i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.3, i64 0, i64 0), i64 836)
  store i1 %19, i1* %3, align 1
  br label %59

20:                                               ; preds = %13
  %21 = load i8, i8* %5, align 1
  %22 = icmp eq i8 %21, 3
  br i1 %22, label %23, label %27

23:                                               ; preds = %20
  %24 = call nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNK3c1010TensorImpl19symbolic_shape_metaEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6)
  %25 = call nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta30is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %24)
  %26 = call zeroext i1 @_ZNK3c107SymBool10guard_boolEPKcl(%"class.c10::SymBool"* nonnull align 8 dereferenceable(16) %25, i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.3, i64 0, i64 0), i64 840)
  store i1 %26, i1* %3, align 1
  br label %59

27:                                               ; preds = %20
  br label %28

28:                                               ; preds = %27
  %29 = call nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNK3c1010TensorImpl19symbolic_shape_metaEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6)
  %30 = call nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta13is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %29)
  %31 = call zeroext i1 @_ZNK3c107SymBool10guard_boolEPKcl(%"class.c10::SymBool"* nonnull align 8 dereferenceable(16) %30, i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.3, i64 0, i64 0), i64 843)
  store i1 %31, i1* %3, align 1
  br label %59

32:                                               ; preds = %2
  %33 = load i8, i8* %5, align 1
  %34 = icmp eq i8 %33, 2
  br i1 %34, label %35, label %42

35:                                               ; preds = %32
  %36 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %6, i32 0, i32 11
  %37 = bitcast [3 x i8]* %36 to i24*
  %38 = load i24, i24* %37, align 1
  %39 = lshr i24 %38, 3
  %40 = and i24 %39, 1
  %41 = trunc i24 %40 to i1
  store i1 %41, i1* %3, align 1
  br label %59

42:                                               ; preds = %32
  %43 = load i8, i8* %5, align 1
  %44 = icmp eq i8 %43, 3
  br i1 %44, label %45, label %52

45:                                               ; preds = %42
  %46 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %6, i32 0, i32 11
  %47 = bitcast [3 x i8]* %46 to i24*
  %48 = load i24, i24* %47, align 1
  %49 = lshr i24 %48, 5
  %50 = and i24 %49, 1
  %51 = trunc i24 %50 to i1
  store i1 %51, i1* %3, align 1
  br label %59

52:                                               ; preds = %42
  br label %53

53:                                               ; preds = %52
  %54 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %6, i32 0, i32 11
  %55 = bitcast [3 x i8]* %54 to i24*
  %56 = load i24, i24* %55, align 1
  %57 = and i24 %56, 1
  %58 = trunc i24 %57 to i1
  store i1 %58, i1* %3, align 1
  br label %59

59:                                               ; preds = %53, %45, %35, %28, %23, %16
  %60 = load i1, i1* %3, align 1
  ret i1 %60
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNK3c1010TensorImpl19symbolic_shape_metaEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #4 comdat align 2 {
  %2 = alloca %"struct.c10::TensorImpl"*, align 8
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"class.std::ios_base::Init", align 1
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %2, align 8
  %5 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %2, align 8
  %6 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %5, i32 0, i32 3
  %7 = call zeroext i1 @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEcvbEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %6) #3
  br i1 %7, label %8, label %13

8:                                                ; preds = %1
  %9 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %5, i32 0, i32 3
  %10 = call %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEptEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %9) #3
  %11 = getelementptr inbounds %"struct.c10::ExtraMeta", %"struct.c10::ExtraMeta"* %10, i32 0, i32 0
  %12 = call zeroext i1 @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEcvbEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %11) #3
  br i1 %12, label %14, label %13

13:                                               ; preds = %8, %1
  call void @_ZN3c103strIJEEEDcDpRKT_()
  call void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_NS0_22CompileTimeEmptyStringE(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__func__._ZNK3c1010TensorImpl19symbolic_shape_metaEv, i64 0, i64 0), i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.3, i64 0, i64 0), i32 1733, i8* getelementptr inbounds ([220 x i8], [220 x i8]* @.str.90, i64 0, i64 0)) #25
  unreachable

14:                                               ; preds = %8
  %15 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %5, i32 0, i32 3
  %16 = call %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEptEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %15) #3
  %17 = getelementptr inbounds %"struct.c10::ExtraMeta", %"struct.c10::ExtraMeta"* %16, i32 0, i32 0
  %18 = call nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEdeEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %17)
  ret %"class.c10::SymbolicShapeMeta"* %18
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta27is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #4 comdat align 2 {
  %2 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %2, align 8
  %3 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %2, align 8
  %4 = call zeroext i1 @_ZNK3c1017SymbolicShapeMeta31has_is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3)
  %5 = xor i1 %4, true
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  call void @_ZNK3c1017SymbolicShapeMeta32init_is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3)
  br label %7

7:                                                ; preds = %6, %1
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %3, i32 0, i32 8
  ret %"class.c10::SymBool"* %8
}

declare dso_local zeroext i1 @_ZNK3c107SymBool10guard_boolEPKcl(%"class.c10::SymBool"* nonnull align 8 dereferenceable(16), i8*, i64) #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta30is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #4 comdat align 2 {
  %2 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %2, align 8
  %3 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %2, align 8
  %4 = call zeroext i1 @_ZNK3c1017SymbolicShapeMeta34has_is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3)
  %5 = xor i1 %4, true
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  call void @_ZNK3c1017SymbolicShapeMeta35init_is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3)
  br label %7

7:                                                ; preds = %6, %1
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %3, i32 0, i32 9
  ret %"class.c10::SymBool"* %8
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta13is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #4 comdat align 2 {
  %2 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %2, align 8
  %3 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %2, align 8
  %4 = call zeroext i1 @_ZNK3c1017SymbolicShapeMeta17has_is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3)
  %5 = xor i1 %4, true
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  call void @_ZNK3c1017SymbolicShapeMeta18init_is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3)
  br label %7

7:                                                ; preds = %6, %1
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %3, i32 0, i32 7
  ret %"class.c10::SymBool"* %8
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1017SymbolicShapeMeta17has_is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::__atomic_base"*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %6, align 8
  %7 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %6, align 8
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %7, i32 0, i32 4
  %9 = bitcast %"struct.std::atomic"* %8 to %"struct.std::__atomic_base"*
  store %"struct.std::__atomic_base"* %9, %"struct.std::__atomic_base"** %2, align 8
  store i32 5, i32* %3, align 4
  %10 = load %"struct.std::__atomic_base"*, %"struct.std::__atomic_base"** %2, align 8
  %11 = load i32, i32* %3, align 4
  %12 = call i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %11, i32 65535) #3
  store i32 %12, i32* %4, align 4
  %13 = getelementptr inbounds %"struct.std::__atomic_base", %"struct.std::__atomic_base"* %10, i32 0, i32 0
  %14 = load i32, i32* %3, align 4
  switch i32 %14, label %15 [
    i32 1, label %17
    i32 2, label %17
    i32 5, label %19
  ]

15:                                               ; preds = %1
  %16 = load atomic i32, i32* %13 monotonic, align 4
  store i32 %16, i32* %5, align 4
  br label %21

17:                                               ; preds = %1, %1
  %18 = load atomic i32, i32* %13 acquire, align 4
  store i32 %18, i32* %5, align 4
  br label %21

19:                                               ; preds = %1
  %20 = load atomic i32, i32* %13 seq_cst, align 4
  store i32 %20, i32* %5, align 4
  br label %21

21:                                               ; preds = %15, %17, %19
  %22 = load i32, i32* %5, align 4
  %23 = and i32 %22, 2
  %24 = icmp ne i32 %23, 0
  ret i1 %24
}

declare dso_local void @_ZNK3c1017SymbolicShapeMeta18init_is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272)) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1017SymbolicShapeMeta34has_is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::__atomic_base"*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %6, align 8
  %7 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %6, align 8
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %7, i32 0, i32 4
  %9 = bitcast %"struct.std::atomic"* %8 to %"struct.std::__atomic_base"*
  store %"struct.std::__atomic_base"* %9, %"struct.std::__atomic_base"** %2, align 8
  store i32 5, i32* %3, align 4
  %10 = load %"struct.std::__atomic_base"*, %"struct.std::__atomic_base"** %2, align 8
  %11 = load i32, i32* %3, align 4
  %12 = call i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %11, i32 65535) #3
  store i32 %12, i32* %4, align 4
  %13 = getelementptr inbounds %"struct.std::__atomic_base", %"struct.std::__atomic_base"* %10, i32 0, i32 0
  %14 = load i32, i32* %3, align 4
  switch i32 %14, label %15 [
    i32 1, label %17
    i32 2, label %17
    i32 5, label %19
  ]

15:                                               ; preds = %1
  %16 = load atomic i32, i32* %13 monotonic, align 4
  store i32 %16, i32* %5, align 4
  br label %21

17:                                               ; preds = %1, %1
  %18 = load atomic i32, i32* %13 acquire, align 4
  store i32 %18, i32* %5, align 4
  br label %21

19:                                               ; preds = %1
  %20 = load atomic i32, i32* %13 seq_cst, align 4
  store i32 %20, i32* %5, align 4
  br label %21

21:                                               ; preds = %15, %17, %19
  %22 = load i32, i32* %5, align 4
  %23 = and i32 %22, 8
  %24 = icmp ne i32 %23, 0
  ret i1 %24
}

declare dso_local void @_ZNK3c1017SymbolicShapeMeta35init_is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272)) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1017SymbolicShapeMeta31has_is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::__atomic_base"*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %6, align 8
  %7 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %6, align 8
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %7, i32 0, i32 4
  %9 = bitcast %"struct.std::atomic"* %8 to %"struct.std::__atomic_base"*
  store %"struct.std::__atomic_base"* %9, %"struct.std::__atomic_base"** %2, align 8
  store i32 5, i32* %3, align 4
  %10 = load %"struct.std::__atomic_base"*, %"struct.std::__atomic_base"** %2, align 8
  %11 = load i32, i32* %3, align 4
  %12 = call i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %11, i32 65535) #3
  store i32 %12, i32* %4, align 4
  %13 = getelementptr inbounds %"struct.std::__atomic_base", %"struct.std::__atomic_base"* %10, i32 0, i32 0
  %14 = load i32, i32* %3, align 4
  switch i32 %14, label %15 [
    i32 1, label %17
    i32 2, label %17
    i32 5, label %19
  ]

15:                                               ; preds = %1
  %16 = load atomic i32, i32* %13 monotonic, align 4
  store i32 %16, i32* %5, align 4
  br label %21

17:                                               ; preds = %1, %1
  %18 = load atomic i32, i32* %13 acquire, align 4
  store i32 %18, i32* %5, align 4
  br label %21

19:                                               ; preds = %1
  %20 = load atomic i32, i32* %13 seq_cst, align 4
  store i32 %20, i32* %5, align 4
  br label %21

21:                                               ; preds = %15, %17, %19
  %22 = load i32, i32* %5, align 4
  %23 = and i32 %22, 4
  %24 = icmp ne i32 %23, 0
  ret i1 %24
}

declare dso_local void @_ZNK3c1017SymbolicShapeMeta32init_is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272)) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEcvbEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::unique_ptr.23"*, align 8
  store %"class.std::unique_ptr.23"* %0, %"class.std::unique_ptr.23"** %2, align 8
  %3 = load %"class.std::unique_ptr.23"*, %"class.std::unique_ptr.23"** %2, align 8
  %4 = call %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %3) #3
  %5 = icmp eq %"struct.c10::ExtraMeta"* %4, null
  %6 = zext i1 %5 to i64
  %7 = select i1 %5, i1 false, i1 true
  ret i1 %7
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEptEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::unique_ptr.23"*, align 8
  store %"class.std::unique_ptr.23"* %0, %"class.std::unique_ptr.23"** %2, align 8
  %3 = load %"class.std::unique_ptr.23"*, %"class.std::unique_ptr.23"** %2, align 8
  %4 = call %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %3) #3
  ret %"struct.c10::ExtraMeta"* %4
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEcvbEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::unique_ptr.31"*, align 8
  store %"class.std::unique_ptr.31"* %0, %"class.std::unique_ptr.31"** %2, align 8
  %3 = load %"class.std::unique_ptr.31"*, %"class.std::unique_ptr.31"** %2, align 8
  %4 = call %"class.c10::SymbolicShapeMeta"* @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %3) #3
  %5 = icmp eq %"class.c10::SymbolicShapeMeta"* %4, null
  %6 = zext i1 %5 to i64
  %7 = select i1 %5, i1 false, i1 true
  ret i1 %7
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEdeEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::unique_ptr.31"*, align 8
  store %"class.std::unique_ptr.31"* %0, %"class.std::unique_ptr.31"** %2, align 8
  %3 = load %"class.std::unique_ptr.31"*, %"class.std::unique_ptr.31"** %2, align 8
  br label %4

4:                                                ; preds = %1
  br label %5

5:                                                ; preds = %4
  %6 = call %"class.c10::SymbolicShapeMeta"* @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %3) #3
  ret %"class.c10::SymbolicShapeMeta"* %6
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"class.c10::SymbolicShapeMeta"* @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::unique_ptr.31"*, align 8
  store %"class.std::unique_ptr.31"* %0, %"class.std::unique_ptr.31"** %2, align 8
  %3 = load %"class.std::unique_ptr.31"*, %"class.std::unique_ptr.31"** %2, align 8
  %4 = getelementptr inbounds %"class.std::unique_ptr.31", %"class.std::unique_ptr.31"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::__uniq_ptr_data.32"* %4 to %"class.std::__uniq_ptr_impl.33"*
  %6 = invoke %"class.c10::SymbolicShapeMeta"* @_ZNKSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.33"* nonnull align 8 dereferenceable(8) %5)
          to label %7 unwind label %8

7:                                                ; preds = %1
  ret %"class.c10::SymbolicShapeMeta"* %6

8:                                                ; preds = %1
  %9 = landingpad { i8*, i32 }
          catch i8* null
  %10 = extractvalue { i8*, i32 } %9, 0
  call void @__clang_call_terminate(i8* %10) #26
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"class.c10::SymbolicShapeMeta"* @_ZNKSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.33"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::__uniq_ptr_impl.33"*, align 8
  store %"class.std::__uniq_ptr_impl.33"* %0, %"class.std::__uniq_ptr_impl.33"** %2, align 8
  %3 = load %"class.std::__uniq_ptr_impl.33"*, %"class.std::__uniq_ptr_impl.33"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__uniq_ptr_impl.33", %"class.std::__uniq_ptr_impl.33"* %3, i32 0, i32 0
  %5 = call nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZSt3getILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_(%"class.std::tuple.34"* nonnull align 8 dereferenceable(8) %4) #3
  %6 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %5, align 8
  ret %"class.c10::SymbolicShapeMeta"* %6
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZSt3getILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_(%"class.std::tuple.34"* nonnull align 8 dereferenceable(8) %0) #8 comdat {
  %2 = alloca %"class.std::tuple.34"*, align 8
  store %"class.std::tuple.34"* %0, %"class.std::tuple.34"** %2, align 8
  %3 = load %"class.std::tuple.34"*, %"class.std::tuple.34"** %2, align 8
  %4 = bitcast %"class.std::tuple.34"* %3 to %"struct.std::_Tuple_impl.35"*
  %5 = call nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZSt12__get_helperILm0EPN3c1017SymbolicShapeMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.35"* nonnull align 8 dereferenceable(8) %4) #3
  ret %"class.c10::SymbolicShapeMeta"** %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZSt12__get_helperILm0EPN3c1017SymbolicShapeMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.35"* nonnull align 8 dereferenceable(8) %0) #8 comdat {
  %2 = alloca %"struct.std::_Tuple_impl.35"*, align 8
  store %"struct.std::_Tuple_impl.35"* %0, %"struct.std::_Tuple_impl.35"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.35"*, %"struct.std::_Tuple_impl.35"** %2, align 8
  %4 = call nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_headERKS5_(%"struct.std::_Tuple_impl.35"* nonnull align 8 dereferenceable(8) %3) #3
  ret %"class.c10::SymbolicShapeMeta"** %4
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_headERKS5_(%"struct.std::_Tuple_impl.35"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::_Tuple_impl.35"*, align 8
  store %"struct.std::_Tuple_impl.35"* %0, %"struct.std::_Tuple_impl.35"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.35"*, %"struct.std::_Tuple_impl.35"** %2, align 8
  %4 = bitcast %"struct.std::_Tuple_impl.35"* %3 to %"struct.std::_Head_base.38"*
  %5 = call nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZNSt10_Head_baseILm0EPN3c1017SymbolicShapeMetaELb0EE7_M_headERKS3_(%"struct.std::_Head_base.38"* nonnull align 8 dereferenceable(8) %4) #3
  ret %"class.c10::SymbolicShapeMeta"** %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZNSt10_Head_baseILm0EPN3c1017SymbolicShapeMetaELb0EE7_M_headERKS3_(%"struct.std::_Head_base.38"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::_Head_base.38"*, align 8
  store %"struct.std::_Head_base.38"* %0, %"struct.std::_Head_base.38"** %2, align 8
  %3 = load %"struct.std::_Head_base.38"*, %"struct.std::_Head_base.38"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Head_base.38", %"struct.std::_Head_base.38"* %3, i32 0, i32 0
  ret %"class.c10::SymbolicShapeMeta"** %4
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::unique_ptr.23"*, align 8
  store %"class.std::unique_ptr.23"* %0, %"class.std::unique_ptr.23"** %2, align 8
  %3 = load %"class.std::unique_ptr.23"*, %"class.std::unique_ptr.23"** %2, align 8
  %4 = getelementptr inbounds %"class.std::unique_ptr.23", %"class.std::unique_ptr.23"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::__uniq_ptr_data.24"* %4 to %"class.std::__uniq_ptr_impl.25"*
  %6 = invoke %"struct.c10::ExtraMeta"* @_ZNKSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.25"* nonnull align 8 dereferenceable(8) %5)
          to label %7 unwind label %8

7:                                                ; preds = %1
  ret %"struct.c10::ExtraMeta"* %6

8:                                                ; preds = %1
  %9 = landingpad { i8*, i32 }
          catch i8* null
  %10 = extractvalue { i8*, i32 } %9, 0
  call void @__clang_call_terminate(i8* %10) #26
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::ExtraMeta"* @_ZNKSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.25"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"class.std::__uniq_ptr_impl.25"*, align 8
  store %"class.std::__uniq_ptr_impl.25"* %0, %"class.std::__uniq_ptr_impl.25"** %2, align 8
  %3 = load %"class.std::__uniq_ptr_impl.25"*, %"class.std::__uniq_ptr_impl.25"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__uniq_ptr_impl.25", %"class.std::__uniq_ptr_impl.25"* %3, i32 0, i32 0
  %5 = call nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZSt3getILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_(%"class.std::tuple.26"* nonnull align 8 dereferenceable(8) %4) #3
  %6 = load %"struct.c10::ExtraMeta"*, %"struct.c10::ExtraMeta"** %5, align 8
  ret %"struct.c10::ExtraMeta"* %6
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZSt3getILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_(%"class.std::tuple.26"* nonnull align 8 dereferenceable(8) %0) #8 comdat {
  %2 = alloca %"class.std::tuple.26"*, align 8
  store %"class.std::tuple.26"* %0, %"class.std::tuple.26"** %2, align 8
  %3 = load %"class.std::tuple.26"*, %"class.std::tuple.26"** %2, align 8
  %4 = bitcast %"class.std::tuple.26"* %3 to %"struct.std::_Tuple_impl.27"*
  %5 = call nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZSt12__get_helperILm0EPN3c109ExtraMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.27"* nonnull align 8 dereferenceable(8) %4) #3
  ret %"struct.c10::ExtraMeta"** %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZSt12__get_helperILm0EPN3c109ExtraMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.27"* nonnull align 8 dereferenceable(8) %0) #8 comdat {
  %2 = alloca %"struct.std::_Tuple_impl.27"*, align 8
  store %"struct.std::_Tuple_impl.27"* %0, %"struct.std::_Tuple_impl.27"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.27"*, %"struct.std::_Tuple_impl.27"** %2, align 8
  %4 = call nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_headERKS5_(%"struct.std::_Tuple_impl.27"* nonnull align 8 dereferenceable(8) %3) #3
  ret %"struct.c10::ExtraMeta"** %4
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_headERKS5_(%"struct.std::_Tuple_impl.27"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::_Tuple_impl.27"*, align 8
  store %"struct.std::_Tuple_impl.27"* %0, %"struct.std::_Tuple_impl.27"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.27"*, %"struct.std::_Tuple_impl.27"** %2, align 8
  %4 = bitcast %"struct.std::_Tuple_impl.27"* %3 to %"struct.std::_Head_base.30"*
  %5 = call nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZNSt10_Head_baseILm0EPN3c109ExtraMetaELb0EE7_M_headERKS3_(%"struct.std::_Head_base.30"* nonnull align 8 dereferenceable(8) %4) #3
  ret %"struct.c10::ExtraMeta"** %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZNSt10_Head_baseILm0EPN3c109ExtraMetaELb0EE7_M_headERKS3_(%"struct.std::_Head_base.30"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 {
  %2 = alloca %"struct.std::_Head_base.30"*, align 8
  store %"struct.std::_Head_base.30"* %0, %"struct.std::_Head_base.30"** %2, align 8
  %3 = load %"struct.std::_Head_base.30"*, %"struct.std::_Head_base.30"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Head_base.30", %"struct.std::_Head_base.30"* %3, i32 0, i32 0
  ret %"struct.c10::ExtraMeta"** %4
}

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* noalias %0, float* noalias %1, float* noalias %2, i64 %3) #16 {
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  %6 = alloca float*, align 8
  %7 = alloca float*, align 8
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca float, align 4
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %5, align 8
  store float* %1, float** %6, align 8
  store float* %2, float** %7, align 8
  store i64 %3, i64* %8, align 8
  %11 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %12 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  %13 = mul i32 %11, %12
  %14 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %15 = add i32 %13, %14
  store i32 %15, i32* %9, align 4
  %16 = load float*, float** %7, align 8
  %17 = load float, float* %16, align 4
  %18 = fdiv contract float 1.000000e+00, %17
  store float %18, float* %10, align 4
  %19 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  %20 = load float*, float** %6, align 8
  %21 = load float, float* %10, align 4
  %22 = load i64, i64* %8, align 8
  %23 = load i32, i32* %9, align 4
  %24 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %25 = call i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #3
  %26 = mul i32 %24, %25
  call void @_ZN4vllm25scaled_fp8_conversion_vecIfLb1EEEvPN3c1013Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* %19, float* %20, float %21, i64 %22, i32 %23, i32 %26) #23
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #17

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #17

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #17

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #17

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm25scaled_fp8_conversion_vecIfLb1EEEvPN3c1013Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* noalias %0, float* noalias %1, float %2, i64 %3, i32 %4, i32 %5) #18 comdat {
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca double, align 8
  %12 = alloca double, align 8
  %13 = alloca double, align 8
  %14 = alloca double, align 8
  %15 = alloca double, align 8
  %16 = alloca double, align 8
  %17 = alloca double, align 8
  %18 = alloca double, align 8
  %19 = alloca double, align 8
  %20 = alloca double, align 8
  %21 = alloca double, align 8
  %22 = alloca double, align 8
  %23 = alloca double, align 8
  %24 = alloca double, align 8
  %25 = alloca double, align 8
  %26 = alloca double, align 8
  %27 = alloca float, align 4
  %28 = alloca %"class.std::ios_base::Init", align 8
  %29 = alloca float, align 4
  %30 = alloca %"class.std::ios_base::Init", align 8
  %31 = alloca float, align 4
  %32 = alloca %"class.std::ios_base::Init", align 8
  %33 = alloca float, align 4
  %34 = alloca %"class.std::ios_base::Init", align 8
  %35 = alloca float, align 4
  %36 = alloca %"class.std::ios_base::Init", align 8
  %37 = alloca double, align 8
  %38 = alloca %"class.std::ios_base::Init", align 8
  %39 = alloca double, align 8
  %40 = alloca %"class.std::ios_base::Init", align 8
  %41 = alloca double, align 8
  %42 = alloca %"class.std::ios_base::Init", align 8
  %43 = alloca double, align 8
  %44 = alloca %"class.std::ios_base::Init", align 8
  %45 = alloca double, align 8
  %46 = alloca %"class.std::ios_base::Init", align 8
  %47 = alloca %"class.std::ios_base::Init", align 1
  %48 = alloca float, align 4
  %49 = alloca float, align 4
  %50 = alloca float, align 4
  %51 = alloca float, align 4
  %52 = alloca %"class.std::ios_base::Init", align 1
  %53 = alloca %"class.std::ios_base::Init", align 1
  %54 = alloca %"class.std::ios_base::Init", align 1
  %55 = alloca %"class.std::ios_base::Init", align 1
  %56 = alloca float, align 4
  %57 = alloca float, align 4
  %58 = alloca float, align 4
  %59 = alloca float, align 4
  %60 = alloca %"class.std::ios_base::Init", align 1
  %61 = alloca %"class.std::ios_base::Init", align 1
  %62 = alloca %"class.std::ios_base::Init", align 1
  %63 = alloca %"class.std::ios_base::Init", align 1
  %64 = alloca float, align 4
  %65 = alloca float, align 4
  %66 = alloca float, align 4
  %67 = alloca float, align 4
  %68 = alloca %"class.std::ios_base::Init", align 1
  %69 = alloca %"class.std::ios_base::Init", align 1
  %70 = alloca %"class.std::ios_base::Init", align 1
  %71 = alloca %"class.std::ios_base::Init", align 1
  %72 = alloca float, align 4
  %73 = alloca float, align 4
  %74 = alloca float, align 4
  %75 = alloca float, align 4
  %76 = alloca %"class.std::ios_base::Init", align 1
  %77 = alloca %"class.std::ios_base::Init", align 1
  %78 = alloca %"class.std::ios_base::Init", align 1
  %79 = alloca %"class.std::ios_base::Init", align 1
  %80 = alloca float, align 4
  %81 = alloca float, align 4
  %82 = alloca float, align 4
  %83 = alloca float, align 4
  %84 = alloca %"class.std::ios_base::Init", align 1
  %85 = alloca %"class.std::ios_base::Init", align 1
  %86 = alloca %"class.std::ios_base::Init", align 1
  %87 = alloca %"class.std::ios_base::Init"*, align 8
  %88 = alloca float*, align 8
  %89 = alloca float, align 4
  %90 = alloca i64, align 8
  %91 = alloca i32, align 4
  %92 = alloca i32, align 4
  %93 = alloca %"struct.vllm::vec4_t"*, align 8
  %94 = alloca %"struct.vllm::float8x4_t"*, align 8
  %95 = alloca i32, align 4
  %96 = alloca i32, align 4
  %97 = alloca %"struct.vllm::vec4_t", align 8
  %98 = alloca %"struct.vllm::float8x4_t", align 4
  %99 = alloca %"class.std::ios_base::Init", align 1
  %100 = alloca %"class.std::ios_base::Init", align 1
  %101 = alloca %"class.std::ios_base::Init", align 1
  %102 = alloca %"class.std::ios_base::Init", align 1
  %103 = alloca i32, align 4
  %104 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %87, align 8
  store float* %1, float** %88, align 8
  store float %2, float* %89, align 4
  store i64 %3, i64* %90, align 8
  store i32 %4, i32* %91, align 4
  store i32 %5, i32* %92, align 4
  %105 = load float*, float** %88, align 8
  %106 = bitcast float* %105 to %"struct.vllm::vec4_t"*
  store %"struct.vllm::vec4_t"* %106, %"struct.vllm::vec4_t"** %93, align 8
  %107 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %108 = bitcast %"class.std::ios_base::Init"* %107 to %"struct.vllm::float8x4_t"*
  store %"struct.vllm::float8x4_t"* %108, %"struct.vllm::float8x4_t"** %94, align 8
  %109 = load i64, i64* %90, align 8
  %110 = ashr i64 %109, 2
  %111 = trunc i64 %110 to i32
  store i32 %111, i32* %95, align 4
  %112 = load i32, i32* %91, align 4
  store i32 %112, i32* %96, align 4
  br label %113

113:                                              ; preds = %294, %6
  %114 = load i32, i32* %96, align 4
  %115 = load i32, i32* %95, align 4
  %116 = icmp slt i32 %114, %115
  br i1 %116, label %117, label %298

117:                                              ; preds = %113
  %118 = load %"struct.vllm::vec4_t"*, %"struct.vllm::vec4_t"** %93, align 8
  %119 = load i32, i32* %96, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %118, i64 %120
  %122 = bitcast %"struct.vllm::vec4_t"* %97 to i8*
  %123 = bitcast %"struct.vllm::vec4_t"* %121 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %122, i8* align 8 %123, i64 16, i1 false)
  %124 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %97, i32 0, i32 0
  %125 = load float, float* %124, align 8
  %126 = load float, float* %89, align 4
  store float %125, float* %48, align 4
  store float %126, float* %49, align 4
  store float 0.000000e+00, float* %50, align 4
  %127 = load float, float* %48, align 4
  %128 = load float, float* %49, align 4
  %129 = fmul contract float %127, %128
  store float %129, float* %50, align 4
  %130 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %131 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %53, i32 0, i32 0
  %132 = extractvalue %"class.std::ios_base::Init" %130, 0
  store i8 %132, i8* %131, align 1
  %133 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %53) #23
  %134 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %52, i32 0, i32 0
  %135 = extractvalue %"class.std::ios_base::Init" %133, 0
  store i8 %135, i8* %134, align 1
  %136 = load float, float* %50, align 4
  %137 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %138 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %54, i32 0, i32 0
  %139 = extractvalue %"class.std::ios_base::Init" %137, 0
  store i8 %139, i8* %138, align 1
  %140 = bitcast %"class.std::ios_base::Init"* %36 to i8*
  %141 = bitcast %"class.std::ios_base::Init"* %54 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %140, i8* align 1 %141, i64 1, i1 false) #3
  store float %136, float* %35, align 4
  %142 = load float, float* %35, align 4
  %143 = fpext float %142 to double
  %144 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %36) #23
  %145 = fpext float %144 to double
  store double %143, double* %7, align 8
  store double %145, double* %8, align 8
  %146 = load double, double* %7, align 8
  %147 = load double, double* %8, align 8
  %148 = call double @llvm.nvvm.fmin.d(double %146, double %147) #3
  %149 = bitcast %"class.std::ios_base::Init"* %46 to i8*
  %150 = bitcast %"class.std::ios_base::Init"* %52 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %149, i8* align 1 %150, i64 1, i1 false) #3
  store double %148, double* %45, align 8
  %151 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %46) #23
  %152 = fpext float %151 to double
  %153 = load double, double* %45, align 8
  store double %152, double* %17, align 8
  store double %153, double* %18, align 8
  %154 = load double, double* %17, align 8
  %155 = load double, double* %18, align 8
  %156 = call double @llvm.nvvm.fmax.d(double %154, double %155) #3
  %157 = fptrunc double %156 to float
  store float %157, float* %51, align 4
  %158 = load float, float* %51, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %47, float %158) #23
  %159 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %47, align 1
  %160 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %99, i32 0, i32 0
  %161 = extractvalue %"class.std::ios_base::Init" %159, 0
  store i8 %161, i8* %160, align 1
  %162 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 0
  %163 = bitcast %"class.std::ios_base::Init"* %162 to i8*
  %164 = bitcast %"class.std::ios_base::Init"* %99 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %163, i8* align 1 %164, i64 1, i1 false)
  %165 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %97, i32 0, i32 1
  %166 = load float, float* %165, align 4
  %167 = load float, float* %89, align 4
  store float %166, float* %56, align 4
  store float %167, float* %57, align 4
  store float 0.000000e+00, float* %58, align 4
  %168 = load float, float* %56, align 4
  %169 = load float, float* %57, align 4
  %170 = fmul contract float %168, %169
  store float %170, float* %58, align 4
  %171 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %172 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %61, i32 0, i32 0
  %173 = extractvalue %"class.std::ios_base::Init" %171, 0
  store i8 %173, i8* %172, align 1
  %174 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %61) #23
  %175 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %60, i32 0, i32 0
  %176 = extractvalue %"class.std::ios_base::Init" %174, 0
  store i8 %176, i8* %175, align 1
  %177 = load float, float* %58, align 4
  %178 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %179 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %62, i32 0, i32 0
  %180 = extractvalue %"class.std::ios_base::Init" %178, 0
  store i8 %180, i8* %179, align 1
  %181 = bitcast %"class.std::ios_base::Init"* %34 to i8*
  %182 = bitcast %"class.std::ios_base::Init"* %62 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %181, i8* align 1 %182, i64 1, i1 false) #3
  store float %177, float* %33, align 4
  %183 = load float, float* %33, align 4
  %184 = fpext float %183 to double
  %185 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %34) #23
  %186 = fpext float %185 to double
  store double %184, double* %9, align 8
  store double %186, double* %10, align 8
  %187 = load double, double* %9, align 8
  %188 = load double, double* %10, align 8
  %189 = call double @llvm.nvvm.fmin.d(double %187, double %188) #3
  %190 = bitcast %"class.std::ios_base::Init"* %44 to i8*
  %191 = bitcast %"class.std::ios_base::Init"* %60 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %190, i8* align 1 %191, i64 1, i1 false) #3
  store double %189, double* %43, align 8
  %192 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %44) #23
  %193 = fpext float %192 to double
  %194 = load double, double* %43, align 8
  store double %193, double* %19, align 8
  store double %194, double* %20, align 8
  %195 = load double, double* %19, align 8
  %196 = load double, double* %20, align 8
  %197 = call double @llvm.nvvm.fmax.d(double %195, double %196) #3
  %198 = fptrunc double %197 to float
  store float %198, float* %59, align 4
  %199 = load float, float* %59, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %55, float %199) #23
  %200 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %55, align 1
  %201 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %100, i32 0, i32 0
  %202 = extractvalue %"class.std::ios_base::Init" %200, 0
  store i8 %202, i8* %201, align 1
  %203 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 1
  %204 = bitcast %"class.std::ios_base::Init"* %203 to i8*
  %205 = bitcast %"class.std::ios_base::Init"* %100 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %204, i8* align 1 %205, i64 1, i1 false)
  %206 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %97, i32 0, i32 2
  %207 = load float, float* %206, align 8
  %208 = load float, float* %89, align 4
  store float %207, float* %64, align 4
  store float %208, float* %65, align 4
  store float 0.000000e+00, float* %66, align 4
  %209 = load float, float* %64, align 4
  %210 = load float, float* %65, align 4
  %211 = fmul contract float %209, %210
  store float %211, float* %66, align 4
  %212 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %213 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %69, i32 0, i32 0
  %214 = extractvalue %"class.std::ios_base::Init" %212, 0
  store i8 %214, i8* %213, align 1
  %215 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %69) #23
  %216 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %68, i32 0, i32 0
  %217 = extractvalue %"class.std::ios_base::Init" %215, 0
  store i8 %217, i8* %216, align 1
  %218 = load float, float* %66, align 4
  %219 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %220 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %70, i32 0, i32 0
  %221 = extractvalue %"class.std::ios_base::Init" %219, 0
  store i8 %221, i8* %220, align 1
  %222 = bitcast %"class.std::ios_base::Init"* %32 to i8*
  %223 = bitcast %"class.std::ios_base::Init"* %70 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %222, i8* align 1 %223, i64 1, i1 false) #3
  store float %218, float* %31, align 4
  %224 = load float, float* %31, align 4
  %225 = fpext float %224 to double
  %226 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %32) #23
  %227 = fpext float %226 to double
  store double %225, double* %11, align 8
  store double %227, double* %12, align 8
  %228 = load double, double* %11, align 8
  %229 = load double, double* %12, align 8
  %230 = call double @llvm.nvvm.fmin.d(double %228, double %229) #3
  %231 = bitcast %"class.std::ios_base::Init"* %42 to i8*
  %232 = bitcast %"class.std::ios_base::Init"* %68 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %231, i8* align 1 %232, i64 1, i1 false) #3
  store double %230, double* %41, align 8
  %233 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %42) #23
  %234 = fpext float %233 to double
  %235 = load double, double* %41, align 8
  store double %234, double* %21, align 8
  store double %235, double* %22, align 8
  %236 = load double, double* %21, align 8
  %237 = load double, double* %22, align 8
  %238 = call double @llvm.nvvm.fmax.d(double %236, double %237) #3
  %239 = fptrunc double %238 to float
  store float %239, float* %67, align 4
  %240 = load float, float* %67, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %63, float %240) #23
  %241 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %63, align 1
  %242 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %101, i32 0, i32 0
  %243 = extractvalue %"class.std::ios_base::Init" %241, 0
  store i8 %243, i8* %242, align 1
  %244 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 2
  %245 = bitcast %"class.std::ios_base::Init"* %244 to i8*
  %246 = bitcast %"class.std::ios_base::Init"* %101 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %245, i8* align 1 %246, i64 1, i1 false)
  %247 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %97, i32 0, i32 3
  %248 = load float, float* %247, align 4
  %249 = load float, float* %89, align 4
  store float %248, float* %72, align 4
  store float %249, float* %73, align 4
  store float 0.000000e+00, float* %74, align 4
  %250 = load float, float* %72, align 4
  %251 = load float, float* %73, align 4
  %252 = fmul contract float %250, %251
  store float %252, float* %74, align 4
  %253 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %254 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %77, i32 0, i32 0
  %255 = extractvalue %"class.std::ios_base::Init" %253, 0
  store i8 %255, i8* %254, align 1
  %256 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %77) #23
  %257 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %76, i32 0, i32 0
  %258 = extractvalue %"class.std::ios_base::Init" %256, 0
  store i8 %258, i8* %257, align 1
  %259 = load float, float* %74, align 4
  %260 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %261 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %78, i32 0, i32 0
  %262 = extractvalue %"class.std::ios_base::Init" %260, 0
  store i8 %262, i8* %261, align 1
  %263 = bitcast %"class.std::ios_base::Init"* %30 to i8*
  %264 = bitcast %"class.std::ios_base::Init"* %78 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %263, i8* align 1 %264, i64 1, i1 false) #3
  store float %259, float* %29, align 4
  %265 = load float, float* %29, align 4
  %266 = fpext float %265 to double
  %267 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %30) #23
  %268 = fpext float %267 to double
  store double %266, double* %13, align 8
  store double %268, double* %14, align 8
  %269 = load double, double* %13, align 8
  %270 = load double, double* %14, align 8
  %271 = call double @llvm.nvvm.fmin.d(double %269, double %270) #3
  %272 = bitcast %"class.std::ios_base::Init"* %40 to i8*
  %273 = bitcast %"class.std::ios_base::Init"* %76 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %272, i8* align 1 %273, i64 1, i1 false) #3
  store double %271, double* %39, align 8
  %274 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %40) #23
  %275 = fpext float %274 to double
  %276 = load double, double* %39, align 8
  store double %275, double* %23, align 8
  store double %276, double* %24, align 8
  %277 = load double, double* %23, align 8
  %278 = load double, double* %24, align 8
  %279 = call double @llvm.nvvm.fmax.d(double %277, double %278) #3
  %280 = fptrunc double %279 to float
  store float %280, float* %75, align 4
  %281 = load float, float* %75, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %71, float %281) #23
  %282 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %71, align 1
  %283 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %102, i32 0, i32 0
  %284 = extractvalue %"class.std::ios_base::Init" %282, 0
  store i8 %284, i8* %283, align 1
  %285 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 3
  %286 = bitcast %"class.std::ios_base::Init"* %285 to i8*
  %287 = bitcast %"class.std::ios_base::Init"* %102 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %286, i8* align 1 %287, i64 1, i1 false)
  %288 = load %"struct.vllm::float8x4_t"*, %"struct.vllm::float8x4_t"** %94, align 8
  %289 = load i32, i32* %96, align 4
  %290 = sext i32 %289 to i64
  %291 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %288, i64 %290
  %292 = bitcast %"struct.vllm::float8x4_t"* %291 to i8*
  %293 = bitcast %"struct.vllm::float8x4_t"* %98 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %292, i8* align 4 %293, i64 4, i1 false)
  br label %294

294:                                              ; preds = %117
  %295 = load i32, i32* %92, align 4
  %296 = load i32, i32* %96, align 4
  %297 = add nsw i32 %296, %295
  store i32 %297, i32* %96, align 4
  br label %113, !llvm.loop !17

298:                                              ; preds = %113
  %299 = load i32, i32* %95, align 4
  %300 = mul nsw i32 %299, 4
  %301 = load i32, i32* %91, align 4
  %302 = add nsw i32 %300, %301
  store i32 %302, i32* %103, align 4
  br label %303

303:                                              ; preds = %356, %298
  %304 = load i32, i32* %103, align 4
  %305 = sext i32 %304 to i64
  %306 = load i64, i64* %90, align 8
  %307 = icmp slt i64 %305, %306
  br i1 %307, label %308, label %360

308:                                              ; preds = %303
  %309 = load float*, float** %88, align 8
  %310 = load i32, i32* %103, align 4
  %311 = sext i32 %310 to i64
  %312 = getelementptr inbounds float, float* %309, i64 %311
  %313 = load float, float* %312, align 4
  %314 = load float, float* %89, align 4
  store float %313, float* %80, align 4
  store float %314, float* %81, align 4
  store float 0.000000e+00, float* %82, align 4
  %315 = load float, float* %80, align 4
  %316 = load float, float* %81, align 4
  %317 = fmul contract float %315, %316
  store float %317, float* %82, align 4
  %318 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %319 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %85, i32 0, i32 0
  %320 = extractvalue %"class.std::ios_base::Init" %318, 0
  store i8 %320, i8* %319, align 1
  %321 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %85) #23
  %322 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %84, i32 0, i32 0
  %323 = extractvalue %"class.std::ios_base::Init" %321, 0
  store i8 %323, i8* %322, align 1
  %324 = load float, float* %82, align 4
  %325 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %326 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %86, i32 0, i32 0
  %327 = extractvalue %"class.std::ios_base::Init" %325, 0
  store i8 %327, i8* %326, align 1
  %328 = bitcast %"class.std::ios_base::Init"* %28 to i8*
  %329 = bitcast %"class.std::ios_base::Init"* %86 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %328, i8* align 1 %329, i64 1, i1 false) #3
  store float %324, float* %27, align 4
  %330 = load float, float* %27, align 4
  %331 = fpext float %330 to double
  %332 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %28) #23
  %333 = fpext float %332 to double
  store double %331, double* %15, align 8
  store double %333, double* %16, align 8
  %334 = load double, double* %15, align 8
  %335 = load double, double* %16, align 8
  %336 = call double @llvm.nvvm.fmin.d(double %334, double %335) #3
  %337 = bitcast %"class.std::ios_base::Init"* %38 to i8*
  %338 = bitcast %"class.std::ios_base::Init"* %84 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %337, i8* align 1 %338, i64 1, i1 false) #3
  store double %336, double* %37, align 8
  %339 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %38) #23
  %340 = fpext float %339 to double
  %341 = load double, double* %37, align 8
  store double %340, double* %25, align 8
  store double %341, double* %26, align 8
  %342 = load double, double* %25, align 8
  %343 = load double, double* %26, align 8
  %344 = call double @llvm.nvvm.fmax.d(double %342, double %343) #3
  %345 = fptrunc double %344 to float
  store float %345, float* %83, align 4
  %346 = load float, float* %83, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %79, float %346) #23
  %347 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %79, align 1
  %348 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %104, i32 0, i32 0
  %349 = extractvalue %"class.std::ios_base::Init" %347, 0
  store i8 %349, i8* %348, align 1
  %350 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %351 = load i32, i32* %103, align 4
  %352 = sext i32 %351 to i64
  %353 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %350, i64 %352
  %354 = bitcast %"class.std::ios_base::Init"* %353 to i8*
  %355 = bitcast %"class.std::ios_base::Init"* %104 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %354, i8* align 1 %355, i64 1, i1 false)
  br label %356

356:                                              ; preds = %308
  %357 = load i32, i32* %92, align 4
  %358 = load i32, i32* %103, align 4
  %359 = add nsw i32 %358, %357
  store i32 %359, i32* %103, align 4
  br label %303, !llvm.loop !20

360:                                              ; preds = %303
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #19 comdat align 2 {
  %1 = alloca %"class.std::ios_base::Init", align 1
  %2 = alloca %"class.std::ios_base::Init", align 1
  %3 = call %"class.std::ios_base::Init" @_ZN3c1013Float8_e4m3fn9from_bitsEv() #23
  %4 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %2, i32 0, i32 0
  %5 = extractvalue %"class.std::ios_base::Init" %3, 0
  store i8 %5, i8* %4, align 1
  call void @_ZN3c1013Float8_e4m3fnC1EhNS0_11from_bits_tE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1, i8 zeroext 126, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %2) #23
  %6 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %1, align 1
  ret %"class.std::ios_base::Init" %6
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #19 comdat {
  %2 = alloca %"class.std::ios_base::Init", align 1
  %3 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %3, align 8
  %4 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %3, align 8
  %5 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %4) #23
  %6 = fneg contract float %5
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %2, float %6) #23
  %7 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %2, align 1
  ret %"class.std::ios_base::Init" %7
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #19 comdat align 2 {
  %2 = alloca %"class.std::ios_base::Init"*, align 8
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %2, align 8
  %3 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %2, align 8
  %4 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %3, i32 0, i32 0
  %5 = load i8, i8* %4, align 1
  %6 = call contract float @_ZN3c106detail23fp8e4m3fn_to_fp32_valueEh(i8 zeroext %5) #23
  ret float %6
}

; Function Attrs: nounwind readnone
declare double @llvm.nvvm.fmin.d(double, double) #17

; Function Attrs: nounwind readnone
declare double @llvm.nvvm.fmax.d(double, double) #17

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0, float %1) unnamed_addr #20 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init"*, align 8
  %4 = alloca float, align 4
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %3, align 8
  store float %1, float* %4, align 4
  %5 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %3, align 8
  %6 = load float, float* %4, align 4
  call void @_ZN3c1013Float8_e4m3fnC2Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %5, float %6) #23
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c1013Float8_e4m3fnC2Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0, float %1) unnamed_addr #20 comdat align 2 {
  %3 = alloca %"class.std::ios_base::Init"*, align 8
  %4 = alloca float, align 4
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %3, align 8
  store float %1, float* %4, align 4
  %5 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %3, align 8
  %6 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %5, i32 0, i32 0
  %7 = load float, float* %4, align 4
  %8 = call zeroext i8 @_ZN3c106detail25fp8e4m3fn_from_fp32_valueEf(float %7) #23
  store i8 %8, i8* %6, align 1
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local zeroext i8 @_ZN3c106detail25fp8e4m3fn_from_fp32_valueEf(float %0) #19 comdat {
  %2 = alloca float, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i8, align 1
  %7 = alloca i32, align 4
  %8 = alloca i8, align 1
  store float %0, float* %2, align 4
  store i32 1139802112, i32* %3, align 4
  store i32 1182793728, i32* %4, align 4
  %9 = load float, float* %2, align 4
  %10 = call i32 @_ZN3c106detail12fp32_to_bitsEf(float %9) #23
  store i32 %10, i32* %5, align 4
  store i8 0, i8* %6, align 1
  %11 = load i32, i32* %5, align 4
  %12 = and i32 %11, -2147483648
  store i32 %12, i32* %7, align 4
  %13 = load i32, i32* %7, align 4
  %14 = load i32, i32* %5, align 4
  %15 = xor i32 %14, %13
  store i32 %15, i32* %5, align 4
  %16 = load i32, i32* %5, align 4
  %17 = icmp uge i32 %16, 1139802112
  br i1 %17, label %18, label %19

18:                                               ; preds = %1
  store i8 127, i8* %6, align 1
  br label %46

19:                                               ; preds = %1
  %20 = load i32, i32* %5, align 4
  %21 = icmp ult i32 %20, 1015021568
  br i1 %21, label %22, label %31

22:                                               ; preds = %19
  %23 = load i32, i32* %5, align 4
  %24 = call contract float @_ZN3c106detail14fp32_from_bitsEj(i32 %23) #23
  %25 = call contract float @_ZN3c106detail14fp32_from_bitsEj(i32 1182793728) #23
  %26 = fadd contract float %24, %25
  %27 = call i32 @_ZN3c106detail12fp32_to_bitsEf(float %26) #23
  store i32 %27, i32* %5, align 4
  %28 = load i32, i32* %5, align 4
  %29 = sub i32 %28, 1182793728
  %30 = trunc i32 %29 to i8
  store i8 %30, i8* %6, align 1
  br label %45

31:                                               ; preds = %19
  %32 = load i32, i32* %5, align 4
  %33 = lshr i32 %32, 20
  %34 = and i32 %33, 1
  %35 = trunc i32 %34 to i8
  store i8 %35, i8* %8, align 1
  %36 = load i32, i32* %5, align 4
  %37 = add i32 %36, -1006108673
  store i32 %37, i32* %5, align 4
  %38 = load i8, i8* %8, align 1
  %39 = zext i8 %38 to i32
  %40 = load i32, i32* %5, align 4
  %41 = add i32 %40, %39
  store i32 %41, i32* %5, align 4
  %42 = load i32, i32* %5, align 4
  %43 = lshr i32 %42, 20
  %44 = trunc i32 %43 to i8
  store i8 %44, i8* %6, align 1
  br label %45

45:                                               ; preds = %31, %22
  br label %46

46:                                               ; preds = %45, %18
  %47 = load i32, i32* %7, align 4
  %48 = lshr i32 %47, 24
  %49 = trunc i32 %48 to i8
  %50 = zext i8 %49 to i32
  %51 = load i8, i8* %6, align 1
  %52 = zext i8 %51 to i32
  %53 = or i32 %52, %50
  %54 = trunc i32 %53 to i8
  store i8 %54, i8* %6, align 1
  %55 = load i8, i8* %6, align 1
  ret i8 %55
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local i32 @_ZN3c106detail12fp32_to_bitsEf(float %0) #18 comdat {
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  store float %0, float* %3, align 4
  %4 = load float, float* %3, align 4
  store float %4, float* %2, align 4
  %5 = load float, float* %2, align 4
  %6 = bitcast float %5 to i32
  ret i32 %6
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local float @_ZN3c106detail14fp32_from_bitsEj(i32 %0) #18 comdat {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  %4 = load i32, i32* %3, align 4
  store i32 %4, i32* %2, align 4
  %5 = load i32, i32* %2, align 4
  %6 = bitcast i32 %5 to float
  ret float %6
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local float @_ZN3c106detail23fp8e4m3fn_to_fp32_valueEh(i8 zeroext %0) #18 comdat {
  %2 = alloca i32, align 4
  %3 = alloca i8, align 1
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i8 %0, i8* %3, align 1
  %11 = load i8, i8* %3, align 1
  %12 = zext i8 %11 to i32
  %13 = shl i32 %12, 24
  store i32 %13, i32* %4, align 4
  %14 = load i32, i32* %4, align 4
  %15 = and i32 %14, -2147483648
  store i32 %15, i32* %5, align 4
  %16 = load i32, i32* %4, align 4
  %17 = and i32 %16, 2147483647
  store i32 %17, i32* %6, align 4
  %18 = load i32, i32* %6, align 4
  store i32 %18, i32* %2, align 4
  %19 = load i32, i32* %2, align 4
  %20 = call i32 @llvm.ctlz.i32(i32 %19, i1 false) #3
  store i32 %20, i32* %7, align 4
  %21 = load i32, i32* %7, align 4
  %22 = icmp ugt i32 %21, 4
  br i1 %22, label %23, label %26

23:                                               ; preds = %1
  %24 = load i32, i32* %7, align 4
  %25 = sub i32 %24, 4
  br label %27

26:                                               ; preds = %1
  br label %27

27:                                               ; preds = %26, %23
  %28 = phi i32 [ %25, %23 ], [ 0, %26 ]
  store i32 %28, i32* %7, align 4
  %29 = load i32, i32* %6, align 4
  %30 = add i32 %29, 16777216
  %31 = ashr i32 %30, 8
  %32 = and i32 %31, 2139095040
  store i32 %32, i32* %8, align 4
  %33 = load i32, i32* %6, align 4
  %34 = sub i32 %33, 1
  %35 = ashr i32 %34, 31
  store i32 %35, i32* %9, align 4
  %36 = load i32, i32* %5, align 4
  %37 = load i32, i32* %6, align 4
  %38 = load i32, i32* %7, align 4
  %39 = shl i32 %37, %38
  %40 = lshr i32 %39, 4
  %41 = load i32, i32* %7, align 4
  %42 = sub i32 120, %41
  %43 = shl i32 %42, 23
  %44 = add i32 %40, %43
  %45 = load i32, i32* %8, align 4
  %46 = or i32 %44, %45
  %47 = load i32, i32* %9, align 4
  %48 = xor i32 %47, -1
  %49 = and i32 %46, %48
  %50 = or i32 %36, %49
  store i32 %50, i32* %10, align 4
  %51 = load i32, i32* %10, align 4
  %52 = call contract float @_ZN3c106detail14fp32_from_bitsEj(i32 %51) #23
  ret float %52
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctlz.i32(i32, i1 immarg) #21

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.std::ios_base::Init" @_ZN3c1013Float8_e4m3fn9from_bitsEv() #19 comdat align 2 {
  %1 = alloca %"class.std::ios_base::Init", align 1
  %2 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %1, align 1
  ret %"class.std::ios_base::Init" %2
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c1013Float8_e4m3fnC1EhNS0_11from_bits_tE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0, i8 zeroext %1, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %2) unnamed_addr #20 comdat align 2 {
  %4 = alloca %"class.std::ios_base::Init"*, align 8
  %5 = alloca i8, align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %4, align 8
  store i8 %1, i8* %5, align 1
  %6 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %4, align 8
  %7 = load i8, i8* %5, align 1
  call void @_ZN3c1013Float8_e4m3fnC2EhNS0_11from_bits_tE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %6, i8 zeroext %7, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %2) #23
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c1013Float8_e4m3fnC2EhNS0_11from_bits_tE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0, i8 zeroext %1, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %2) unnamed_addr #20 comdat align 2 {
  %4 = alloca %"class.std::ios_base::Init"*, align 8
  %5 = alloca i8, align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %4, align 8
  store i8 %1, i8* %5, align 1
  %6 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %4, align 8
  %7 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %6, i32 0, i32 0
  %8 = load i8, i8* %5, align 1
  store i8 %8, i8* %7, align 1
  ret void
}

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, float* noalias %2, i64 %3) #16 {
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  %6 = alloca %"class.caffe2::TypeMeta"*, align 8
  %7 = alloca float*, align 8
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca float, align 4
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %5, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %6, align 8
  store float* %2, float** %7, align 8
  store i64 %3, i64* %8, align 8
  %11 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %12 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  %13 = mul i32 %11, %12
  %14 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %15 = add i32 %13, %14
  store i32 %15, i32* %9, align 4
  %16 = load float*, float** %7, align 8
  %17 = load float, float* %16, align 4
  %18 = fdiv contract float 1.000000e+00, %17
  store float %18, float* %10, align 4
  %19 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  %20 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %21 = load float, float* %10, align 4
  %22 = load i64, i64* %8, align 8
  %23 = load i32, i32* %9, align 4
  %24 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %25 = call i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #3
  %26 = mul i32 %24, %25
  call void @_ZN4vllm25scaled_fp8_conversion_vecIN3c104HalfELb1EEEvPNS1_13Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* %19, %"class.caffe2::TypeMeta"* %20, float %21, i64 %22, i32 %23, i32 %26) #23
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm25scaled_fp8_conversion_vecIN3c104HalfELb1EEEvPNS1_13Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, float %2, i64 %3, i32 %4, i32 %5) #18 comdat {
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca double, align 8
  %12 = alloca double, align 8
  %13 = alloca double, align 8
  %14 = alloca double, align 8
  %15 = alloca double, align 8
  %16 = alloca double, align 8
  %17 = alloca double, align 8
  %18 = alloca double, align 8
  %19 = alloca double, align 8
  %20 = alloca double, align 8
  %21 = alloca double, align 8
  %22 = alloca double, align 8
  %23 = alloca double, align 8
  %24 = alloca double, align 8
  %25 = alloca double, align 8
  %26 = alloca double, align 8
  %27 = alloca float, align 4
  %28 = alloca %"class.std::ios_base::Init", align 8
  %29 = alloca float, align 4
  %30 = alloca %"class.std::ios_base::Init", align 8
  %31 = alloca float, align 4
  %32 = alloca %"class.std::ios_base::Init", align 8
  %33 = alloca float, align 4
  %34 = alloca %"class.std::ios_base::Init", align 8
  %35 = alloca float, align 4
  %36 = alloca %"class.std::ios_base::Init", align 8
  %37 = alloca double, align 8
  %38 = alloca %"class.std::ios_base::Init", align 8
  %39 = alloca double, align 8
  %40 = alloca %"class.std::ios_base::Init", align 8
  %41 = alloca double, align 8
  %42 = alloca %"class.std::ios_base::Init", align 8
  %43 = alloca double, align 8
  %44 = alloca %"class.std::ios_base::Init", align 8
  %45 = alloca double, align 8
  %46 = alloca %"class.std::ios_base::Init", align 8
  %47 = alloca %"class.std::ios_base::Init", align 1
  %48 = alloca float, align 4
  %49 = alloca float, align 4
  %50 = alloca float, align 4
  %51 = alloca float, align 4
  %52 = alloca %"class.std::ios_base::Init", align 1
  %53 = alloca %"class.std::ios_base::Init", align 1
  %54 = alloca %"class.std::ios_base::Init", align 1
  %55 = alloca %"class.std::ios_base::Init", align 1
  %56 = alloca float, align 4
  %57 = alloca float, align 4
  %58 = alloca float, align 4
  %59 = alloca float, align 4
  %60 = alloca %"class.std::ios_base::Init", align 1
  %61 = alloca %"class.std::ios_base::Init", align 1
  %62 = alloca %"class.std::ios_base::Init", align 1
  %63 = alloca %"class.std::ios_base::Init", align 1
  %64 = alloca float, align 4
  %65 = alloca float, align 4
  %66 = alloca float, align 4
  %67 = alloca float, align 4
  %68 = alloca %"class.std::ios_base::Init", align 1
  %69 = alloca %"class.std::ios_base::Init", align 1
  %70 = alloca %"class.std::ios_base::Init", align 1
  %71 = alloca %"class.std::ios_base::Init", align 1
  %72 = alloca float, align 4
  %73 = alloca float, align 4
  %74 = alloca float, align 4
  %75 = alloca float, align 4
  %76 = alloca %"class.std::ios_base::Init", align 1
  %77 = alloca %"class.std::ios_base::Init", align 1
  %78 = alloca %"class.std::ios_base::Init", align 1
  %79 = alloca %"class.std::ios_base::Init", align 1
  %80 = alloca float, align 4
  %81 = alloca float, align 4
  %82 = alloca float, align 4
  %83 = alloca float, align 4
  %84 = alloca %"class.std::ios_base::Init", align 1
  %85 = alloca %"class.std::ios_base::Init", align 1
  %86 = alloca %"class.std::ios_base::Init", align 1
  %87 = alloca %"class.std::ios_base::Init"*, align 8
  %88 = alloca %"class.caffe2::TypeMeta"*, align 8
  %89 = alloca float, align 4
  %90 = alloca i64, align 8
  %91 = alloca i32, align 4
  %92 = alloca i32, align 4
  %93 = alloca %"struct.vllm::vec4_t.0"*, align 8
  %94 = alloca %"struct.vllm::float8x4_t"*, align 8
  %95 = alloca i32, align 4
  %96 = alloca i32, align 4
  %97 = alloca %"struct.vllm::vec4_t.0", align 8
  %98 = alloca %"struct.vllm::float8x4_t", align 4
  %99 = alloca %"class.std::ios_base::Init", align 1
  %100 = alloca %"class.std::ios_base::Init", align 1
  %101 = alloca %"class.std::ios_base::Init", align 1
  %102 = alloca %"class.std::ios_base::Init", align 1
  %103 = alloca i32, align 4
  %104 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %87, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %88, align 8
  store float %2, float* %89, align 4
  store i64 %3, i64* %90, align 8
  store i32 %4, i32* %91, align 4
  store i32 %5, i32* %92, align 4
  %105 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %88, align 8
  %106 = bitcast %"class.caffe2::TypeMeta"* %105 to %"struct.vllm::vec4_t.0"*
  store %"struct.vllm::vec4_t.0"* %106, %"struct.vllm::vec4_t.0"** %93, align 8
  %107 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %108 = bitcast %"class.std::ios_base::Init"* %107 to %"struct.vllm::float8x4_t"*
  store %"struct.vllm::float8x4_t"* %108, %"struct.vllm::float8x4_t"** %94, align 8
  %109 = load i64, i64* %90, align 8
  %110 = ashr i64 %109, 2
  %111 = trunc i64 %110 to i32
  store i32 %111, i32* %95, align 4
  %112 = load i32, i32* %91, align 4
  store i32 %112, i32* %96, align 4
  br label %113

113:                                              ; preds = %294, %6
  %114 = load i32, i32* %96, align 4
  %115 = load i32, i32* %95, align 4
  %116 = icmp slt i32 %114, %115
  br i1 %116, label %117, label %298

117:                                              ; preds = %113
  %118 = load %"struct.vllm::vec4_t.0"*, %"struct.vllm::vec4_t.0"** %93, align 8
  %119 = load i32, i32* %96, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %118, i64 %120
  %122 = bitcast %"struct.vllm::vec4_t.0"* %97 to i8*
  %123 = bitcast %"struct.vllm::vec4_t.0"* %121 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %122, i8* align 8 %123, i64 8, i1 false)
  %124 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 0
  %125 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %124) #23
  %126 = load float, float* %89, align 4
  store float %125, float* %48, align 4
  store float %126, float* %49, align 4
  store float 0.000000e+00, float* %50, align 4
  %127 = load float, float* %48, align 4
  %128 = load float, float* %49, align 4
  %129 = fmul contract float %127, %128
  store float %129, float* %50, align 4
  %130 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %131 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %53, i32 0, i32 0
  %132 = extractvalue %"class.std::ios_base::Init" %130, 0
  store i8 %132, i8* %131, align 1
  %133 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %53) #23
  %134 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %52, i32 0, i32 0
  %135 = extractvalue %"class.std::ios_base::Init" %133, 0
  store i8 %135, i8* %134, align 1
  %136 = load float, float* %50, align 4
  %137 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %138 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %54, i32 0, i32 0
  %139 = extractvalue %"class.std::ios_base::Init" %137, 0
  store i8 %139, i8* %138, align 1
  %140 = bitcast %"class.std::ios_base::Init"* %36 to i8*
  %141 = bitcast %"class.std::ios_base::Init"* %54 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %140, i8* align 1 %141, i64 1, i1 false) #3
  store float %136, float* %35, align 4
  %142 = load float, float* %35, align 4
  %143 = fpext float %142 to double
  %144 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %36) #23
  %145 = fpext float %144 to double
  store double %143, double* %7, align 8
  store double %145, double* %8, align 8
  %146 = load double, double* %7, align 8
  %147 = load double, double* %8, align 8
  %148 = call double @llvm.nvvm.fmin.d(double %146, double %147) #3
  %149 = bitcast %"class.std::ios_base::Init"* %46 to i8*
  %150 = bitcast %"class.std::ios_base::Init"* %52 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %149, i8* align 1 %150, i64 1, i1 false) #3
  store double %148, double* %45, align 8
  %151 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %46) #23
  %152 = fpext float %151 to double
  %153 = load double, double* %45, align 8
  store double %152, double* %17, align 8
  store double %153, double* %18, align 8
  %154 = load double, double* %17, align 8
  %155 = load double, double* %18, align 8
  %156 = call double @llvm.nvvm.fmax.d(double %154, double %155) #3
  %157 = fptrunc double %156 to float
  store float %157, float* %51, align 4
  %158 = load float, float* %51, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %47, float %158) #23
  %159 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %47, align 1
  %160 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %99, i32 0, i32 0
  %161 = extractvalue %"class.std::ios_base::Init" %159, 0
  store i8 %161, i8* %160, align 1
  %162 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 0
  %163 = bitcast %"class.std::ios_base::Init"* %162 to i8*
  %164 = bitcast %"class.std::ios_base::Init"* %99 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %163, i8* align 1 %164, i64 1, i1 false)
  %165 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 1
  %166 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %165) #23
  %167 = load float, float* %89, align 4
  store float %166, float* %56, align 4
  store float %167, float* %57, align 4
  store float 0.000000e+00, float* %58, align 4
  %168 = load float, float* %56, align 4
  %169 = load float, float* %57, align 4
  %170 = fmul contract float %168, %169
  store float %170, float* %58, align 4
  %171 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %172 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %61, i32 0, i32 0
  %173 = extractvalue %"class.std::ios_base::Init" %171, 0
  store i8 %173, i8* %172, align 1
  %174 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %61) #23
  %175 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %60, i32 0, i32 0
  %176 = extractvalue %"class.std::ios_base::Init" %174, 0
  store i8 %176, i8* %175, align 1
  %177 = load float, float* %58, align 4
  %178 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %179 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %62, i32 0, i32 0
  %180 = extractvalue %"class.std::ios_base::Init" %178, 0
  store i8 %180, i8* %179, align 1
  %181 = bitcast %"class.std::ios_base::Init"* %34 to i8*
  %182 = bitcast %"class.std::ios_base::Init"* %62 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %181, i8* align 1 %182, i64 1, i1 false) #3
  store float %177, float* %33, align 4
  %183 = load float, float* %33, align 4
  %184 = fpext float %183 to double
  %185 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %34) #23
  %186 = fpext float %185 to double
  store double %184, double* %9, align 8
  store double %186, double* %10, align 8
  %187 = load double, double* %9, align 8
  %188 = load double, double* %10, align 8
  %189 = call double @llvm.nvvm.fmin.d(double %187, double %188) #3
  %190 = bitcast %"class.std::ios_base::Init"* %44 to i8*
  %191 = bitcast %"class.std::ios_base::Init"* %60 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %190, i8* align 1 %191, i64 1, i1 false) #3
  store double %189, double* %43, align 8
  %192 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %44) #23
  %193 = fpext float %192 to double
  %194 = load double, double* %43, align 8
  store double %193, double* %19, align 8
  store double %194, double* %20, align 8
  %195 = load double, double* %19, align 8
  %196 = load double, double* %20, align 8
  %197 = call double @llvm.nvvm.fmax.d(double %195, double %196) #3
  %198 = fptrunc double %197 to float
  store float %198, float* %59, align 4
  %199 = load float, float* %59, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %55, float %199) #23
  %200 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %55, align 1
  %201 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %100, i32 0, i32 0
  %202 = extractvalue %"class.std::ios_base::Init" %200, 0
  store i8 %202, i8* %201, align 1
  %203 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 1
  %204 = bitcast %"class.std::ios_base::Init"* %203 to i8*
  %205 = bitcast %"class.std::ios_base::Init"* %100 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %204, i8* align 1 %205, i64 1, i1 false)
  %206 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 2
  %207 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %206) #23
  %208 = load float, float* %89, align 4
  store float %207, float* %64, align 4
  store float %208, float* %65, align 4
  store float 0.000000e+00, float* %66, align 4
  %209 = load float, float* %64, align 4
  %210 = load float, float* %65, align 4
  %211 = fmul contract float %209, %210
  store float %211, float* %66, align 4
  %212 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %213 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %69, i32 0, i32 0
  %214 = extractvalue %"class.std::ios_base::Init" %212, 0
  store i8 %214, i8* %213, align 1
  %215 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %69) #23
  %216 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %68, i32 0, i32 0
  %217 = extractvalue %"class.std::ios_base::Init" %215, 0
  store i8 %217, i8* %216, align 1
  %218 = load float, float* %66, align 4
  %219 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %220 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %70, i32 0, i32 0
  %221 = extractvalue %"class.std::ios_base::Init" %219, 0
  store i8 %221, i8* %220, align 1
  %222 = bitcast %"class.std::ios_base::Init"* %32 to i8*
  %223 = bitcast %"class.std::ios_base::Init"* %70 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %222, i8* align 1 %223, i64 1, i1 false) #3
  store float %218, float* %31, align 4
  %224 = load float, float* %31, align 4
  %225 = fpext float %224 to double
  %226 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %32) #23
  %227 = fpext float %226 to double
  store double %225, double* %11, align 8
  store double %227, double* %12, align 8
  %228 = load double, double* %11, align 8
  %229 = load double, double* %12, align 8
  %230 = call double @llvm.nvvm.fmin.d(double %228, double %229) #3
  %231 = bitcast %"class.std::ios_base::Init"* %42 to i8*
  %232 = bitcast %"class.std::ios_base::Init"* %68 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %231, i8* align 1 %232, i64 1, i1 false) #3
  store double %230, double* %41, align 8
  %233 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %42) #23
  %234 = fpext float %233 to double
  %235 = load double, double* %41, align 8
  store double %234, double* %21, align 8
  store double %235, double* %22, align 8
  %236 = load double, double* %21, align 8
  %237 = load double, double* %22, align 8
  %238 = call double @llvm.nvvm.fmax.d(double %236, double %237) #3
  %239 = fptrunc double %238 to float
  store float %239, float* %67, align 4
  %240 = load float, float* %67, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %63, float %240) #23
  %241 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %63, align 1
  %242 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %101, i32 0, i32 0
  %243 = extractvalue %"class.std::ios_base::Init" %241, 0
  store i8 %243, i8* %242, align 1
  %244 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 2
  %245 = bitcast %"class.std::ios_base::Init"* %244 to i8*
  %246 = bitcast %"class.std::ios_base::Init"* %101 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %245, i8* align 1 %246, i64 1, i1 false)
  %247 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 3
  %248 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %247) #23
  %249 = load float, float* %89, align 4
  store float %248, float* %72, align 4
  store float %249, float* %73, align 4
  store float 0.000000e+00, float* %74, align 4
  %250 = load float, float* %72, align 4
  %251 = load float, float* %73, align 4
  %252 = fmul contract float %250, %251
  store float %252, float* %74, align 4
  %253 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %254 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %77, i32 0, i32 0
  %255 = extractvalue %"class.std::ios_base::Init" %253, 0
  store i8 %255, i8* %254, align 1
  %256 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %77) #23
  %257 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %76, i32 0, i32 0
  %258 = extractvalue %"class.std::ios_base::Init" %256, 0
  store i8 %258, i8* %257, align 1
  %259 = load float, float* %74, align 4
  %260 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %261 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %78, i32 0, i32 0
  %262 = extractvalue %"class.std::ios_base::Init" %260, 0
  store i8 %262, i8* %261, align 1
  %263 = bitcast %"class.std::ios_base::Init"* %30 to i8*
  %264 = bitcast %"class.std::ios_base::Init"* %78 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %263, i8* align 1 %264, i64 1, i1 false) #3
  store float %259, float* %29, align 4
  %265 = load float, float* %29, align 4
  %266 = fpext float %265 to double
  %267 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %30) #23
  %268 = fpext float %267 to double
  store double %266, double* %13, align 8
  store double %268, double* %14, align 8
  %269 = load double, double* %13, align 8
  %270 = load double, double* %14, align 8
  %271 = call double @llvm.nvvm.fmin.d(double %269, double %270) #3
  %272 = bitcast %"class.std::ios_base::Init"* %40 to i8*
  %273 = bitcast %"class.std::ios_base::Init"* %76 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %272, i8* align 1 %273, i64 1, i1 false) #3
  store double %271, double* %39, align 8
  %274 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %40) #23
  %275 = fpext float %274 to double
  %276 = load double, double* %39, align 8
  store double %275, double* %23, align 8
  store double %276, double* %24, align 8
  %277 = load double, double* %23, align 8
  %278 = load double, double* %24, align 8
  %279 = call double @llvm.nvvm.fmax.d(double %277, double %278) #3
  %280 = fptrunc double %279 to float
  store float %280, float* %75, align 4
  %281 = load float, float* %75, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %71, float %281) #23
  %282 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %71, align 1
  %283 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %102, i32 0, i32 0
  %284 = extractvalue %"class.std::ios_base::Init" %282, 0
  store i8 %284, i8* %283, align 1
  %285 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 3
  %286 = bitcast %"class.std::ios_base::Init"* %285 to i8*
  %287 = bitcast %"class.std::ios_base::Init"* %102 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %286, i8* align 1 %287, i64 1, i1 false)
  %288 = load %"struct.vllm::float8x4_t"*, %"struct.vllm::float8x4_t"** %94, align 8
  %289 = load i32, i32* %96, align 4
  %290 = sext i32 %289 to i64
  %291 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %288, i64 %290
  %292 = bitcast %"struct.vllm::float8x4_t"* %291 to i8*
  %293 = bitcast %"struct.vllm::float8x4_t"* %98 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %292, i8* align 4 %293, i64 4, i1 false)
  br label %294

294:                                              ; preds = %117
  %295 = load i32, i32* %92, align 4
  %296 = load i32, i32* %96, align 4
  %297 = add nsw i32 %296, %295
  store i32 %297, i32* %96, align 4
  br label %113, !llvm.loop !21

298:                                              ; preds = %113
  %299 = load i32, i32* %95, align 4
  %300 = mul nsw i32 %299, 4
  %301 = load i32, i32* %91, align 4
  %302 = add nsw i32 %300, %301
  store i32 %302, i32* %103, align 4
  br label %303

303:                                              ; preds = %356, %298
  %304 = load i32, i32* %103, align 4
  %305 = sext i32 %304 to i64
  %306 = load i64, i64* %90, align 8
  %307 = icmp slt i64 %305, %306
  br i1 %307, label %308, label %360

308:                                              ; preds = %303
  %309 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %88, align 8
  %310 = load i32, i32* %103, align 4
  %311 = sext i32 %310 to i64
  %312 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %309, i64 %311
  %313 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %312) #23
  %314 = load float, float* %89, align 4
  store float %313, float* %80, align 4
  store float %314, float* %81, align 4
  store float 0.000000e+00, float* %82, align 4
  %315 = load float, float* %80, align 4
  %316 = load float, float* %81, align 4
  %317 = fmul contract float %315, %316
  store float %317, float* %82, align 4
  %318 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %319 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %85, i32 0, i32 0
  %320 = extractvalue %"class.std::ios_base::Init" %318, 0
  store i8 %320, i8* %319, align 1
  %321 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %85) #23
  %322 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %84, i32 0, i32 0
  %323 = extractvalue %"class.std::ios_base::Init" %321, 0
  store i8 %323, i8* %322, align 1
  %324 = load float, float* %82, align 4
  %325 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %326 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %86, i32 0, i32 0
  %327 = extractvalue %"class.std::ios_base::Init" %325, 0
  store i8 %327, i8* %326, align 1
  %328 = bitcast %"class.std::ios_base::Init"* %28 to i8*
  %329 = bitcast %"class.std::ios_base::Init"* %86 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %328, i8* align 1 %329, i64 1, i1 false) #3
  store float %324, float* %27, align 4
  %330 = load float, float* %27, align 4
  %331 = fpext float %330 to double
  %332 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %28) #23
  %333 = fpext float %332 to double
  store double %331, double* %15, align 8
  store double %333, double* %16, align 8
  %334 = load double, double* %15, align 8
  %335 = load double, double* %16, align 8
  %336 = call double @llvm.nvvm.fmin.d(double %334, double %335) #3
  %337 = bitcast %"class.std::ios_base::Init"* %38 to i8*
  %338 = bitcast %"class.std::ios_base::Init"* %84 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %337, i8* align 1 %338, i64 1, i1 false) #3
  store double %336, double* %37, align 8
  %339 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %38) #23
  %340 = fpext float %339 to double
  %341 = load double, double* %37, align 8
  store double %340, double* %25, align 8
  store double %341, double* %26, align 8
  %342 = load double, double* %25, align 8
  %343 = load double, double* %26, align 8
  %344 = call double @llvm.nvvm.fmax.d(double %342, double %343) #3
  %345 = fptrunc double %344 to float
  store float %345, float* %83, align 4
  %346 = load float, float* %83, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %79, float %346) #23
  %347 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %79, align 1
  %348 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %104, i32 0, i32 0
  %349 = extractvalue %"class.std::ios_base::Init" %347, 0
  store i8 %349, i8* %348, align 1
  %350 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %351 = load i32, i32* %103, align 4
  %352 = sext i32 %351 to i64
  %353 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %350, i64 %352
  %354 = bitcast %"class.std::ios_base::Init"* %353 to i8*
  %355 = bitcast %"class.std::ios_base::Init"* %104 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %354, i8* align 1 %355, i64 1, i1 false)
  br label %356

356:                                              ; preds = %308
  %357 = load i32, i32* %92, align 4
  %358 = load i32, i32* %103, align 4
  %359 = add nsw i32 %358, %357
  store i32 %359, i32* %103, align 4
  br label %303, !llvm.loop !22

360:                                              ; preds = %303
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #19 comdat align 2 {
  %2 = alloca %"class.caffe2::TypeMeta"*, align 8
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %2, align 8
  %4 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %2, align 8
  %5 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %4, i32 0, i32 0
  %6 = bitcast i16* %5 to %"class.caffe2::TypeMeta"*
  %7 = bitcast %"class.caffe2::TypeMeta"* %3 to i8*
  %8 = bitcast %"class.caffe2::TypeMeta"* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %7, i8* align 2 %8, i64 2, i1 false)
  %9 = call contract float @_ZL12__half2float6__half(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %3) #23
  ret float %9
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal float @_ZL12__half2float6__half(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %0) #19 {
  %2 = alloca float, align 4
  %3 = bitcast %"class.caffe2::TypeMeta"* %0 to i16*
  %4 = load i16, i16* %3, align 2
  %5 = call contract float asm "{  cvt.f32.f16 $0, $1;}\0A", "=f,h"(i16 %4) #28, !srcloc !23
  store float %5, float* %2, align 4
  %6 = load float, float* %2, align 4
  ret float %6
}

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPKT_PKfl(%"class.std::ios_base::Init"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, float* noalias %2, i64 %3) #16 {
  %5 = alloca %"class.std::ios_base::Init"*, align 8
  %6 = alloca %"class.caffe2::TypeMeta"*, align 8
  %7 = alloca float*, align 8
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca float, align 4
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %5, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %6, align 8
  store float* %2, float** %7, align 8
  store i64 %3, i64* %8, align 8
  %11 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %12 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  %13 = mul i32 %11, %12
  %14 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %15 = add i32 %13, %14
  store i32 %15, i32* %9, align 4
  %16 = load float*, float** %7, align 8
  %17 = load float, float* %16, align 4
  %18 = fdiv contract float 1.000000e+00, %17
  store float %18, float* %10, align 4
  %19 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %5, align 8
  %20 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %21 = load float, float* %10, align 4
  %22 = load i64, i64* %8, align 8
  %23 = load i32, i32* %9, align 4
  %24 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %25 = call i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #3
  %26 = mul i32 %24, %25
  call void @_ZN4vllm25scaled_fp8_conversion_vecIN3c108BFloat16ELb1EEEvPNS1_13Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* %19, %"class.caffe2::TypeMeta"* %20, float %21, i64 %22, i32 %23, i32 %26) #23
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm25scaled_fp8_conversion_vecIN3c108BFloat16ELb1EEEvPNS1_13Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, float %2, i64 %3, i32 %4, i32 %5) #18 comdat {
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca double, align 8
  %12 = alloca double, align 8
  %13 = alloca double, align 8
  %14 = alloca double, align 8
  %15 = alloca double, align 8
  %16 = alloca double, align 8
  %17 = alloca double, align 8
  %18 = alloca double, align 8
  %19 = alloca double, align 8
  %20 = alloca double, align 8
  %21 = alloca double, align 8
  %22 = alloca double, align 8
  %23 = alloca double, align 8
  %24 = alloca double, align 8
  %25 = alloca double, align 8
  %26 = alloca double, align 8
  %27 = alloca float, align 4
  %28 = alloca %"class.std::ios_base::Init", align 8
  %29 = alloca float, align 4
  %30 = alloca %"class.std::ios_base::Init", align 8
  %31 = alloca float, align 4
  %32 = alloca %"class.std::ios_base::Init", align 8
  %33 = alloca float, align 4
  %34 = alloca %"class.std::ios_base::Init", align 8
  %35 = alloca float, align 4
  %36 = alloca %"class.std::ios_base::Init", align 8
  %37 = alloca double, align 8
  %38 = alloca %"class.std::ios_base::Init", align 8
  %39 = alloca double, align 8
  %40 = alloca %"class.std::ios_base::Init", align 8
  %41 = alloca double, align 8
  %42 = alloca %"class.std::ios_base::Init", align 8
  %43 = alloca double, align 8
  %44 = alloca %"class.std::ios_base::Init", align 8
  %45 = alloca double, align 8
  %46 = alloca %"class.std::ios_base::Init", align 8
  %47 = alloca %"class.std::ios_base::Init", align 1
  %48 = alloca float, align 4
  %49 = alloca float, align 4
  %50 = alloca float, align 4
  %51 = alloca float, align 4
  %52 = alloca %"class.std::ios_base::Init", align 1
  %53 = alloca %"class.std::ios_base::Init", align 1
  %54 = alloca %"class.std::ios_base::Init", align 1
  %55 = alloca %"class.std::ios_base::Init", align 1
  %56 = alloca float, align 4
  %57 = alloca float, align 4
  %58 = alloca float, align 4
  %59 = alloca float, align 4
  %60 = alloca %"class.std::ios_base::Init", align 1
  %61 = alloca %"class.std::ios_base::Init", align 1
  %62 = alloca %"class.std::ios_base::Init", align 1
  %63 = alloca %"class.std::ios_base::Init", align 1
  %64 = alloca float, align 4
  %65 = alloca float, align 4
  %66 = alloca float, align 4
  %67 = alloca float, align 4
  %68 = alloca %"class.std::ios_base::Init", align 1
  %69 = alloca %"class.std::ios_base::Init", align 1
  %70 = alloca %"class.std::ios_base::Init", align 1
  %71 = alloca %"class.std::ios_base::Init", align 1
  %72 = alloca float, align 4
  %73 = alloca float, align 4
  %74 = alloca float, align 4
  %75 = alloca float, align 4
  %76 = alloca %"class.std::ios_base::Init", align 1
  %77 = alloca %"class.std::ios_base::Init", align 1
  %78 = alloca %"class.std::ios_base::Init", align 1
  %79 = alloca %"class.std::ios_base::Init", align 1
  %80 = alloca float, align 4
  %81 = alloca float, align 4
  %82 = alloca float, align 4
  %83 = alloca float, align 4
  %84 = alloca %"class.std::ios_base::Init", align 1
  %85 = alloca %"class.std::ios_base::Init", align 1
  %86 = alloca %"class.std::ios_base::Init", align 1
  %87 = alloca %"class.std::ios_base::Init"*, align 8
  %88 = alloca %"class.caffe2::TypeMeta"*, align 8
  %89 = alloca float, align 4
  %90 = alloca i64, align 8
  %91 = alloca i32, align 4
  %92 = alloca i32, align 4
  %93 = alloca %"struct.vllm::vec4_t.0"*, align 8
  %94 = alloca %"struct.vllm::float8x4_t"*, align 8
  %95 = alloca i32, align 4
  %96 = alloca i32, align 4
  %97 = alloca %"struct.vllm::vec4_t.0", align 8
  %98 = alloca %"struct.vllm::float8x4_t", align 4
  %99 = alloca %"class.std::ios_base::Init", align 1
  %100 = alloca %"class.std::ios_base::Init", align 1
  %101 = alloca %"class.std::ios_base::Init", align 1
  %102 = alloca %"class.std::ios_base::Init", align 1
  %103 = alloca i32, align 4
  %104 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %87, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %88, align 8
  store float %2, float* %89, align 4
  store i64 %3, i64* %90, align 8
  store i32 %4, i32* %91, align 4
  store i32 %5, i32* %92, align 4
  %105 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %88, align 8
  %106 = bitcast %"class.caffe2::TypeMeta"* %105 to %"struct.vllm::vec4_t.0"*
  store %"struct.vllm::vec4_t.0"* %106, %"struct.vllm::vec4_t.0"** %93, align 8
  %107 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %108 = bitcast %"class.std::ios_base::Init"* %107 to %"struct.vllm::float8x4_t"*
  store %"struct.vllm::float8x4_t"* %108, %"struct.vllm::float8x4_t"** %94, align 8
  %109 = load i64, i64* %90, align 8
  %110 = ashr i64 %109, 2
  %111 = trunc i64 %110 to i32
  store i32 %111, i32* %95, align 4
  %112 = load i32, i32* %91, align 4
  store i32 %112, i32* %96, align 4
  br label %113

113:                                              ; preds = %294, %6
  %114 = load i32, i32* %96, align 4
  %115 = load i32, i32* %95, align 4
  %116 = icmp slt i32 %114, %115
  br i1 %116, label %117, label %298

117:                                              ; preds = %113
  %118 = load %"struct.vllm::vec4_t.0"*, %"struct.vllm::vec4_t.0"** %93, align 8
  %119 = load i32, i32* %96, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %118, i64 %120
  %122 = bitcast %"struct.vllm::vec4_t.0"* %97 to i8*
  %123 = bitcast %"struct.vllm::vec4_t.0"* %121 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %122, i8* align 8 %123, i64 8, i1 false)
  %124 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 0
  %125 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %124) #23
  %126 = load float, float* %89, align 4
  store float %125, float* %48, align 4
  store float %126, float* %49, align 4
  store float 0.000000e+00, float* %50, align 4
  %127 = load float, float* %48, align 4
  %128 = load float, float* %49, align 4
  %129 = fmul contract float %127, %128
  store float %129, float* %50, align 4
  %130 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %131 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %53, i32 0, i32 0
  %132 = extractvalue %"class.std::ios_base::Init" %130, 0
  store i8 %132, i8* %131, align 1
  %133 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %53) #23
  %134 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %52, i32 0, i32 0
  %135 = extractvalue %"class.std::ios_base::Init" %133, 0
  store i8 %135, i8* %134, align 1
  %136 = load float, float* %50, align 4
  %137 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %138 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %54, i32 0, i32 0
  %139 = extractvalue %"class.std::ios_base::Init" %137, 0
  store i8 %139, i8* %138, align 1
  %140 = bitcast %"class.std::ios_base::Init"* %36 to i8*
  %141 = bitcast %"class.std::ios_base::Init"* %54 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %140, i8* align 1 %141, i64 1, i1 false) #3
  store float %136, float* %35, align 4
  %142 = load float, float* %35, align 4
  %143 = fpext float %142 to double
  %144 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %36) #23
  %145 = fpext float %144 to double
  store double %143, double* %7, align 8
  store double %145, double* %8, align 8
  %146 = load double, double* %7, align 8
  %147 = load double, double* %8, align 8
  %148 = call double @llvm.nvvm.fmin.d(double %146, double %147) #3
  %149 = bitcast %"class.std::ios_base::Init"* %46 to i8*
  %150 = bitcast %"class.std::ios_base::Init"* %52 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %149, i8* align 1 %150, i64 1, i1 false) #3
  store double %148, double* %45, align 8
  %151 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %46) #23
  %152 = fpext float %151 to double
  %153 = load double, double* %45, align 8
  store double %152, double* %17, align 8
  store double %153, double* %18, align 8
  %154 = load double, double* %17, align 8
  %155 = load double, double* %18, align 8
  %156 = call double @llvm.nvvm.fmax.d(double %154, double %155) #3
  %157 = fptrunc double %156 to float
  store float %157, float* %51, align 4
  %158 = load float, float* %51, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %47, float %158) #23
  %159 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %47, align 1
  %160 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %99, i32 0, i32 0
  %161 = extractvalue %"class.std::ios_base::Init" %159, 0
  store i8 %161, i8* %160, align 1
  %162 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 0
  %163 = bitcast %"class.std::ios_base::Init"* %162 to i8*
  %164 = bitcast %"class.std::ios_base::Init"* %99 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %163, i8* align 1 %164, i64 1, i1 false)
  %165 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 1
  %166 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %165) #23
  %167 = load float, float* %89, align 4
  store float %166, float* %56, align 4
  store float %167, float* %57, align 4
  store float 0.000000e+00, float* %58, align 4
  %168 = load float, float* %56, align 4
  %169 = load float, float* %57, align 4
  %170 = fmul contract float %168, %169
  store float %170, float* %58, align 4
  %171 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %172 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %61, i32 0, i32 0
  %173 = extractvalue %"class.std::ios_base::Init" %171, 0
  store i8 %173, i8* %172, align 1
  %174 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %61) #23
  %175 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %60, i32 0, i32 0
  %176 = extractvalue %"class.std::ios_base::Init" %174, 0
  store i8 %176, i8* %175, align 1
  %177 = load float, float* %58, align 4
  %178 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %179 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %62, i32 0, i32 0
  %180 = extractvalue %"class.std::ios_base::Init" %178, 0
  store i8 %180, i8* %179, align 1
  %181 = bitcast %"class.std::ios_base::Init"* %34 to i8*
  %182 = bitcast %"class.std::ios_base::Init"* %62 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %181, i8* align 1 %182, i64 1, i1 false) #3
  store float %177, float* %33, align 4
  %183 = load float, float* %33, align 4
  %184 = fpext float %183 to double
  %185 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %34) #23
  %186 = fpext float %185 to double
  store double %184, double* %9, align 8
  store double %186, double* %10, align 8
  %187 = load double, double* %9, align 8
  %188 = load double, double* %10, align 8
  %189 = call double @llvm.nvvm.fmin.d(double %187, double %188) #3
  %190 = bitcast %"class.std::ios_base::Init"* %44 to i8*
  %191 = bitcast %"class.std::ios_base::Init"* %60 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %190, i8* align 1 %191, i64 1, i1 false) #3
  store double %189, double* %43, align 8
  %192 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %44) #23
  %193 = fpext float %192 to double
  %194 = load double, double* %43, align 8
  store double %193, double* %19, align 8
  store double %194, double* %20, align 8
  %195 = load double, double* %19, align 8
  %196 = load double, double* %20, align 8
  %197 = call double @llvm.nvvm.fmax.d(double %195, double %196) #3
  %198 = fptrunc double %197 to float
  store float %198, float* %59, align 4
  %199 = load float, float* %59, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %55, float %199) #23
  %200 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %55, align 1
  %201 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %100, i32 0, i32 0
  %202 = extractvalue %"class.std::ios_base::Init" %200, 0
  store i8 %202, i8* %201, align 1
  %203 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 1
  %204 = bitcast %"class.std::ios_base::Init"* %203 to i8*
  %205 = bitcast %"class.std::ios_base::Init"* %100 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %204, i8* align 1 %205, i64 1, i1 false)
  %206 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 2
  %207 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %206) #23
  %208 = load float, float* %89, align 4
  store float %207, float* %64, align 4
  store float %208, float* %65, align 4
  store float 0.000000e+00, float* %66, align 4
  %209 = load float, float* %64, align 4
  %210 = load float, float* %65, align 4
  %211 = fmul contract float %209, %210
  store float %211, float* %66, align 4
  %212 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %213 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %69, i32 0, i32 0
  %214 = extractvalue %"class.std::ios_base::Init" %212, 0
  store i8 %214, i8* %213, align 1
  %215 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %69) #23
  %216 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %68, i32 0, i32 0
  %217 = extractvalue %"class.std::ios_base::Init" %215, 0
  store i8 %217, i8* %216, align 1
  %218 = load float, float* %66, align 4
  %219 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %220 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %70, i32 0, i32 0
  %221 = extractvalue %"class.std::ios_base::Init" %219, 0
  store i8 %221, i8* %220, align 1
  %222 = bitcast %"class.std::ios_base::Init"* %32 to i8*
  %223 = bitcast %"class.std::ios_base::Init"* %70 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %222, i8* align 1 %223, i64 1, i1 false) #3
  store float %218, float* %31, align 4
  %224 = load float, float* %31, align 4
  %225 = fpext float %224 to double
  %226 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %32) #23
  %227 = fpext float %226 to double
  store double %225, double* %11, align 8
  store double %227, double* %12, align 8
  %228 = load double, double* %11, align 8
  %229 = load double, double* %12, align 8
  %230 = call double @llvm.nvvm.fmin.d(double %228, double %229) #3
  %231 = bitcast %"class.std::ios_base::Init"* %42 to i8*
  %232 = bitcast %"class.std::ios_base::Init"* %68 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %231, i8* align 1 %232, i64 1, i1 false) #3
  store double %230, double* %41, align 8
  %233 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %42) #23
  %234 = fpext float %233 to double
  %235 = load double, double* %41, align 8
  store double %234, double* %21, align 8
  store double %235, double* %22, align 8
  %236 = load double, double* %21, align 8
  %237 = load double, double* %22, align 8
  %238 = call double @llvm.nvvm.fmax.d(double %236, double %237) #3
  %239 = fptrunc double %238 to float
  store float %239, float* %67, align 4
  %240 = load float, float* %67, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %63, float %240) #23
  %241 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %63, align 1
  %242 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %101, i32 0, i32 0
  %243 = extractvalue %"class.std::ios_base::Init" %241, 0
  store i8 %243, i8* %242, align 1
  %244 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 2
  %245 = bitcast %"class.std::ios_base::Init"* %244 to i8*
  %246 = bitcast %"class.std::ios_base::Init"* %101 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %245, i8* align 1 %246, i64 1, i1 false)
  %247 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 3
  %248 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %247) #23
  %249 = load float, float* %89, align 4
  store float %248, float* %72, align 4
  store float %249, float* %73, align 4
  store float 0.000000e+00, float* %74, align 4
  %250 = load float, float* %72, align 4
  %251 = load float, float* %73, align 4
  %252 = fmul contract float %250, %251
  store float %252, float* %74, align 4
  %253 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %254 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %77, i32 0, i32 0
  %255 = extractvalue %"class.std::ios_base::Init" %253, 0
  store i8 %255, i8* %254, align 1
  %256 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %77) #23
  %257 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %76, i32 0, i32 0
  %258 = extractvalue %"class.std::ios_base::Init" %256, 0
  store i8 %258, i8* %257, align 1
  %259 = load float, float* %74, align 4
  %260 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %261 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %78, i32 0, i32 0
  %262 = extractvalue %"class.std::ios_base::Init" %260, 0
  store i8 %262, i8* %261, align 1
  %263 = bitcast %"class.std::ios_base::Init"* %30 to i8*
  %264 = bitcast %"class.std::ios_base::Init"* %78 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %263, i8* align 1 %264, i64 1, i1 false) #3
  store float %259, float* %29, align 4
  %265 = load float, float* %29, align 4
  %266 = fpext float %265 to double
  %267 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %30) #23
  %268 = fpext float %267 to double
  store double %266, double* %13, align 8
  store double %268, double* %14, align 8
  %269 = load double, double* %13, align 8
  %270 = load double, double* %14, align 8
  %271 = call double @llvm.nvvm.fmin.d(double %269, double %270) #3
  %272 = bitcast %"class.std::ios_base::Init"* %40 to i8*
  %273 = bitcast %"class.std::ios_base::Init"* %76 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %272, i8* align 1 %273, i64 1, i1 false) #3
  store double %271, double* %39, align 8
  %274 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %40) #23
  %275 = fpext float %274 to double
  %276 = load double, double* %39, align 8
  store double %275, double* %23, align 8
  store double %276, double* %24, align 8
  %277 = load double, double* %23, align 8
  %278 = load double, double* %24, align 8
  %279 = call double @llvm.nvvm.fmax.d(double %277, double %278) #3
  %280 = fptrunc double %279 to float
  store float %280, float* %75, align 4
  %281 = load float, float* %75, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %71, float %281) #23
  %282 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %71, align 1
  %283 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %102, i32 0, i32 0
  %284 = extractvalue %"class.std::ios_base::Init" %282, 0
  store i8 %284, i8* %283, align 1
  %285 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 3
  %286 = bitcast %"class.std::ios_base::Init"* %285 to i8*
  %287 = bitcast %"class.std::ios_base::Init"* %102 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %286, i8* align 1 %287, i64 1, i1 false)
  %288 = load %"struct.vllm::float8x4_t"*, %"struct.vllm::float8x4_t"** %94, align 8
  %289 = load i32, i32* %96, align 4
  %290 = sext i32 %289 to i64
  %291 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %288, i64 %290
  %292 = bitcast %"struct.vllm::float8x4_t"* %291 to i8*
  %293 = bitcast %"struct.vllm::float8x4_t"* %98 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %292, i8* align 4 %293, i64 4, i1 false)
  br label %294

294:                                              ; preds = %117
  %295 = load i32, i32* %92, align 4
  %296 = load i32, i32* %96, align 4
  %297 = add nsw i32 %296, %295
  store i32 %297, i32* %96, align 4
  br label %113, !llvm.loop !24

298:                                              ; preds = %113
  %299 = load i32, i32* %95, align 4
  %300 = mul nsw i32 %299, 4
  %301 = load i32, i32* %91, align 4
  %302 = add nsw i32 %300, %301
  store i32 %302, i32* %103, align 4
  br label %303

303:                                              ; preds = %356, %298
  %304 = load i32, i32* %103, align 4
  %305 = sext i32 %304 to i64
  %306 = load i64, i64* %90, align 8
  %307 = icmp slt i64 %305, %306
  br i1 %307, label %308, label %360

308:                                              ; preds = %303
  %309 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %88, align 8
  %310 = load i32, i32* %103, align 4
  %311 = sext i32 %310 to i64
  %312 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %309, i64 %311
  %313 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %312) #23
  %314 = load float, float* %89, align 4
  store float %313, float* %80, align 4
  store float %314, float* %81, align 4
  store float 0.000000e+00, float* %82, align 4
  %315 = load float, float* %80, align 4
  %316 = load float, float* %81, align 4
  %317 = fmul contract float %315, %316
  store float %317, float* %82, align 4
  %318 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %319 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %85, i32 0, i32 0
  %320 = extractvalue %"class.std::ios_base::Init" %318, 0
  store i8 %320, i8* %319, align 1
  %321 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %85) #23
  %322 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %84, i32 0, i32 0
  %323 = extractvalue %"class.std::ios_base::Init" %321, 0
  store i8 %323, i8* %322, align 1
  %324 = load float, float* %82, align 4
  %325 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %326 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %86, i32 0, i32 0
  %327 = extractvalue %"class.std::ios_base::Init" %325, 0
  store i8 %327, i8* %326, align 1
  %328 = bitcast %"class.std::ios_base::Init"* %28 to i8*
  %329 = bitcast %"class.std::ios_base::Init"* %86 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %328, i8* align 1 %329, i64 1, i1 false) #3
  store float %324, float* %27, align 4
  %330 = load float, float* %27, align 4
  %331 = fpext float %330 to double
  %332 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %28) #23
  %333 = fpext float %332 to double
  store double %331, double* %15, align 8
  store double %333, double* %16, align 8
  %334 = load double, double* %15, align 8
  %335 = load double, double* %16, align 8
  %336 = call double @llvm.nvvm.fmin.d(double %334, double %335) #3
  %337 = bitcast %"class.std::ios_base::Init"* %38 to i8*
  %338 = bitcast %"class.std::ios_base::Init"* %84 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %337, i8* align 1 %338, i64 1, i1 false) #3
  store double %336, double* %37, align 8
  %339 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %38) #23
  %340 = fpext float %339 to double
  %341 = load double, double* %37, align 8
  store double %340, double* %25, align 8
  store double %341, double* %26, align 8
  %342 = load double, double* %25, align 8
  %343 = load double, double* %26, align 8
  %344 = call double @llvm.nvvm.fmax.d(double %342, double %343) #3
  %345 = fptrunc double %344 to float
  store float %345, float* %83, align 4
  %346 = load float, float* %83, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %79, float %346) #23
  %347 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %79, align 1
  %348 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %104, i32 0, i32 0
  %349 = extractvalue %"class.std::ios_base::Init" %347, 0
  store i8 %349, i8* %348, align 1
  %350 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %351 = load i32, i32* %103, align 4
  %352 = sext i32 %351 to i64
  %353 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %350, i64 %352
  %354 = bitcast %"class.std::ios_base::Init"* %353 to i8*
  %355 = bitcast %"class.std::ios_base::Init"* %104 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %354, i8* align 1 %355, i64 1, i1 false)
  br label %356

356:                                              ; preds = %308
  %357 = load i32, i32* %92, align 4
  %358 = load i32, i32* %103, align 4
  %359 = add nsw i32 %358, %357
  store i32 %359, i32* %103, align 4
  br label %303, !llvm.loop !25

360:                                              ; preds = %303
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #19 comdat align 2 {
  %2 = alloca %"class.caffe2::TypeMeta"*, align 8
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %2, align 8
  %4 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %2, align 8
  %5 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %4, i32 0, i32 0
  %6 = bitcast i16* %5 to %"class.caffe2::TypeMeta"*
  %7 = bitcast %"class.caffe2::TypeMeta"* %3 to i8*
  %8 = bitcast %"class.caffe2::TypeMeta"* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %7, i8* align 2 %8, i64 2, i1 false)
  %9 = call contract float @_ZL16__bfloat162float13__nv_bfloat16(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %3) #23
  ret float %9
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal float @_ZL16__bfloat162float13__nv_bfloat16(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %0) #19 {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = call %"class.caffe2::TypeMeta" @_ZNK13__nv_bfloat16cv17__nv_bfloat16_rawEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #23
  %4 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, i32 0, i32 0
  %5 = extractvalue %"class.caffe2::TypeMeta" %3, 0
  store i16 %5, i16* %4, align 2
  %6 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, i32 0, i32 0
  %7 = load i16, i16* %6, align 2
  %8 = call contract float @_ZL25__internal_bfloat162floatt(i16 zeroext %7) #23
  ret float %8
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.caffe2::TypeMeta" @_ZNK13__nv_bfloat16cv17__nv_bfloat16_rawEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #19 comdat align 2 {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  %4 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %5 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %4, i32 0, i32 0
  %6 = load i16, i16* %5, align 2
  %7 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, i32 0, i32 0
  store i16 %6, i16* %7, align 2
  %8 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, align 2
  ret %"class.caffe2::TypeMeta" %8
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal float @_ZL25__internal_bfloat162floatt(i16 zeroext %0) #19 {
  %2 = alloca i16, align 2
  %3 = alloca float, align 4
  store i16 %0, i16* %2, align 2
  %4 = load i16, i16* %2, align 2
  %5 = call contract float @_ZL32__internal_device_bfloat162floatt(i16 zeroext %4) #23
  store float %5, float* %3, align 4
  %6 = load float, float* %3, align 4
  ret float %6
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal float @_ZL32__internal_device_bfloat162floatt(i16 zeroext %0) #19 {
  %2 = alloca i16, align 2
  %3 = alloca float, align 4
  store i16 %0, i16* %2, align 2
  %4 = load i16, i16* %2, align 2
  %5 = call contract float asm "{ mov.b32 $0, {0,$1};}\0A", "=f,h"(i16 %4) #28, !srcloc !26
  store float %5, float* %3, align 4
  %6 = load float, float* %3, align 4
  ret float %6
}

; Function Attrs: convergent noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23segmented_max_reductionIfEEvPfPKT_l(float* noalias %0, float* noalias %1, i64 %2) #22 {
  %4 = alloca float, align 4
  %5 = alloca i32, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca i32, align 4
  %9 = alloca float*, align 8
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float, align 4
  %13 = alloca float*, align 8
  %14 = alloca float*, align 8
  %15 = alloca i64, align 8
  %16 = alloca i32, align 4
  %17 = alloca float, align 4
  %18 = alloca float, align 4
  %19 = alloca i32, align 4
  %20 = alloca %"class.std::ios_base::Init", align 1
  store float* %0, float** %13, align 8
  store float* %1, float** %14, align 8
  store i64 %2, i64* %15, align 8
  %21 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %22 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  %23 = mul i32 %21, %22
  %24 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %25 = add i32 %23, %24
  store i32 %25, i32* %16, align 4
  store float 0.000000e+00, float* %17, align 4
  br label %26

26:                                               ; preds = %31, %3
  %27 = load i32, i32* %16, align 4
  %28 = sext i32 %27 to i64
  %29 = load i64, i64* %15, align 8
  %30 = icmp slt i64 %28, %29
  br i1 %30, label %31, label %48

31:                                               ; preds = %26
  %32 = load float*, float** %14, align 8
  %33 = load i32, i32* %16, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds float, float* %32, i64 %34
  %36 = load float, float* %35, align 4
  store float %36, float* %18, align 4
  %37 = load float, float* %17, align 4
  %38 = load float, float* %18, align 4
  store float %38, float* %12, align 4
  %39 = load float, float* %12, align 4
  store float %39, float* %6, align 4
  %40 = load float, float* %6, align 4
  %41 = call float @llvm.nvvm.fabs.f(float %40) #3
  %42 = call contract float @_ZL3maxff(float %37, float %41) #23
  store float %42, float* %17, align 4
  %43 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %44 = call i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #3
  %45 = mul i32 %43, %44
  %46 = load i32, i32* %16, align 4
  %47 = add i32 %46, %45
  store i32 %47, i32* %16, align 4
  br label %26, !llvm.loop !27

48:                                               ; preds = %26
  %49 = load float, float* %17, align 4
  %50 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %51 = zext i32 %50 to i64
  %52 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIfEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %51
  store float %49, float* %52, align 4
  call void @llvm.nvvm.barrier0()
  %53 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %54 = udiv i32 %53, 2
  store i32 %54, i32* %19, align 4
  br label %55

55:                                               ; preds = %84, %48
  %56 = load i32, i32* %19, align 4
  %57 = icmp ne i32 %56, 0
  br i1 %57, label %58, label %87

58:                                               ; preds = %55
  %59 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %60 = load i32, i32* %19, align 4
  %61 = icmp ult i32 %59, %60
  br i1 %61, label %62, label %84

62:                                               ; preds = %58
  %63 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %64 = load i32, i32* %19, align 4
  %65 = add i32 %63, %64
  %66 = zext i32 %65 to i64
  %67 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIfEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %66
  %68 = load float, float* %67, align 4
  %69 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %70 = zext i32 %69 to i64
  %71 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIfEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %70
  %72 = load float, float* %71, align 4
  %73 = fcmp contract ogt float %68, %72
  br i1 %73, label %74, label %84

74:                                               ; preds = %62
  %75 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %76 = load i32, i32* %19, align 4
  %77 = add i32 %75, %76
  %78 = zext i32 %77 to i64
  %79 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIfEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %78
  %80 = load float, float* %79, align 4
  %81 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %82 = zext i32 %81 to i64
  %83 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIfEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %82
  store float %80, float* %83, align 4
  br label %84

84:                                               ; preds = %74, %62, %58
  call void @llvm.nvvm.barrier0()
  %85 = load i32, i32* %19, align 4
  %86 = sdiv i32 %85, 2
  store i32 %86, i32* %19, align 4
  br label %55, !llvm.loop !28

87:                                               ; preds = %55
  %88 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %89 = icmp eq i32 %88, 0
  br i1 %89, label %90, label %120

90:                                               ; preds = %87
  %91 = load float*, float** %13, align 8
  %92 = load float, float* getelementptr inbounds ([1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIfEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 0), align 4
  %93 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %94 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %20, i32 0, i32 0
  %95 = extractvalue %"class.std::ios_base::Init" %93, 0
  store i8 %95, i8* %94, align 1
  %96 = call contract float @_ZN3c10dvEfNS_13Float8_e4m3fnE(float %92, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %20) #23
  store float* %91, float** %9, align 8
  store float %96, float* %10, align 4
  %97 = load float, float* %10, align 4
  %98 = fcmp contract oge float %97, 0.000000e+00
  br i1 %98, label %99, label %108

99:                                               ; preds = %90
  %100 = load float*, float** %9, align 8
  %101 = bitcast float* %100 to i32*
  %102 = load float, float* %10, align 4
  store float %102, float* %4, align 4
  %103 = load float, float* %4, align 4
  %104 = bitcast float %103 to i32
  %105 = call i32 @_ZL9atomicMaxPii(i32* %101, i32 %104) #23
  store i32 %105, i32* %5, align 4
  %106 = load i32, i32* %5, align 4
  %107 = bitcast i32 %106 to float
  br label %117

108:                                              ; preds = %90
  %109 = load float*, float** %9, align 8
  %110 = bitcast float* %109 to i32*
  %111 = load float, float* %10, align 4
  store float %111, float* %7, align 4
  %112 = load float, float* %7, align 4
  %113 = bitcast float %112 to i32
  %114 = call i32 @_ZL9atomicMinPjj(i32* %110, i32 %113) #23
  store i32 %114, i32* %8, align 4
  %115 = load i32, i32* %8, align 4
  %116 = bitcast i32 %115 to float
  br label %117

117:                                              ; preds = %99, %108
  %118 = phi contract float [ %107, %99 ], [ %116, %108 ]
  store float %118, float* %11, align 4
  %119 = load float, float* %11, align 4
  br label %120

120:                                              ; preds = %117, %87
  ret void
}

; Function Attrs: nounwind readnone
declare float @llvm.nvvm.fabs.f(float) #17

; Function Attrs: convergent noinline nounwind optnone
define internal float @_ZL3maxff(float %0, float %1) #18 {
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  store float %0, float* %5, align 4
  store float %1, float* %6, align 4
  %7 = load float, float* %5, align 4
  %8 = load float, float* %6, align 4
  store float %7, float* %3, align 4
  store float %8, float* %4, align 4
  %9 = load float, float* %3, align 4
  %10 = load float, float* %4, align 4
  %11 = call float @llvm.nvvm.fmax.f(float %9, float %10) #3
  ret float %11
}

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() #23

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZN3c10dvEfNS_13Float8_e4m3fnE(float %0, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %1) #19 comdat {
  %3 = alloca float, align 4
  store float %0, float* %3, align 4
  %4 = load float, float* %3, align 4
  %5 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %1) #23
  %6 = fdiv contract float %4, %5
  ret float %6
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal i32 @_ZL9atomicMaxPii(i32* %0, i32 %1) #19 {
  %3 = alloca i32*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  store i32* %0, i32** %5, align 8
  store i32 %1, i32* %6, align 4
  %7 = load i32*, i32** %5, align 8
  %8 = load i32, i32* %6, align 4
  store i32* %7, i32** %3, align 8
  store i32 %8, i32* %4, align 4
  %9 = load i32*, i32** %3, align 8
  %10 = load i32, i32* %4, align 4
  %11 = atomicrmw max i32* %9, i32 %10 seq_cst, align 4
  ret i32 %11
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal i32 @_ZL9atomicMinPjj(i32* %0, i32 %1) #19 {
  %3 = alloca i32*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  store i32* %0, i32** %5, align 8
  store i32 %1, i32* %6, align 4
  %7 = load i32*, i32** %5, align 8
  %8 = load i32, i32* %6, align 4
  store i32* %7, i32** %3, align 8
  store i32 %8, i32* %4, align 4
  %9 = load i32*, i32** %3, align 8
  %10 = load i32, i32* %4, align 4
  %11 = atomicrmw umin i32* %9, i32 %10 seq_cst, align 4
  ret i32 %11
}

; Function Attrs: nounwind readnone
declare float @llvm.nvvm.fmax.f(float, float) #17

; Function Attrs: convergent noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23segmented_max_reductionIN3c104HalfEEEvPfPKT_l(float* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, i64 %2) #22 {
  %4 = alloca float, align 4
  %5 = alloca i32, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca i32, align 4
  %9 = alloca float*, align 8
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float, align 4
  %13 = alloca float*, align 8
  %14 = alloca %"class.caffe2::TypeMeta"*, align 8
  %15 = alloca i64, align 8
  %16 = alloca i32, align 4
  %17 = alloca %"class.caffe2::TypeMeta", align 2
  %18 = alloca float, align 4
  %19 = alloca %"class.caffe2::TypeMeta", align 2
  %20 = alloca i32, align 4
  %21 = alloca %"class.std::ios_base::Init", align 1
  store float* %0, float** %13, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %14, align 8
  store i64 %2, i64* %15, align 8
  %22 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %23 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  %24 = mul i32 %22, %23
  %25 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %26 = add i32 %24, %25
  store i32 %26, i32* %16, align 4
  call void @_ZN3c104HalfC1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17, float 0.000000e+00) #23
  br label %27

27:                                               ; preds = %32, %3
  %28 = load i32, i32* %16, align 4
  %29 = sext i32 %28 to i64
  %30 = load i64, i64* %15, align 8
  %31 = icmp slt i64 %29, %30
  br i1 %31, label %32, label %51

32:                                               ; preds = %27
  %33 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %14, align 8
  %34 = load i32, i32* %16, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %33, i64 %35
  %37 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %36) #23
  store float %37, float* %18, align 4
  %38 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17) #23
  %39 = load float, float* %18, align 4
  store float %39, float* %12, align 4
  %40 = load float, float* %12, align 4
  store float %40, float* %6, align 4
  %41 = load float, float* %6, align 4
  %42 = call float @llvm.nvvm.fabs.f(float %41) #3
  %43 = call contract float @_ZL3maxff(float %38, float %42) #23
  call void @_ZN3c104HalfC1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %19, float %43) #23
  %44 = bitcast %"class.caffe2::TypeMeta"* %17 to i8*
  %45 = bitcast %"class.caffe2::TypeMeta"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %44, i8* align 2 %45, i64 2, i1 false)
  %46 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %47 = call i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #3
  %48 = mul i32 %46, %47
  %49 = load i32, i32* %16, align 4
  %50 = add i32 %49, %48
  store i32 %50, i32* %16, align 4
  br label %27, !llvm.loop !29

51:                                               ; preds = %27
  %52 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17) #23
  %53 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %54 = zext i32 %53 to i64
  %55 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c104HalfEEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %54
  store float %52, float* %55, align 4
  call void @llvm.nvvm.barrier0()
  %56 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %57 = udiv i32 %56, 2
  store i32 %57, i32* %20, align 4
  br label %58

58:                                               ; preds = %87, %51
  %59 = load i32, i32* %20, align 4
  %60 = icmp ne i32 %59, 0
  br i1 %60, label %61, label %90

61:                                               ; preds = %58
  %62 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %63 = load i32, i32* %20, align 4
  %64 = icmp ult i32 %62, %63
  br i1 %64, label %65, label %87

65:                                               ; preds = %61
  %66 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %67 = load i32, i32* %20, align 4
  %68 = add i32 %66, %67
  %69 = zext i32 %68 to i64
  %70 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c104HalfEEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %69
  %71 = load float, float* %70, align 4
  %72 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %73 = zext i32 %72 to i64
  %74 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c104HalfEEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %73
  %75 = load float, float* %74, align 4
  %76 = fcmp contract ogt float %71, %75
  br i1 %76, label %77, label %87

77:                                               ; preds = %65
  %78 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %79 = load i32, i32* %20, align 4
  %80 = add i32 %78, %79
  %81 = zext i32 %80 to i64
  %82 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c104HalfEEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %81
  %83 = load float, float* %82, align 4
  %84 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %85 = zext i32 %84 to i64
  %86 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c104HalfEEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %85
  store float %83, float* %86, align 4
  br label %87

87:                                               ; preds = %77, %65, %61
  call void @llvm.nvvm.barrier0()
  %88 = load i32, i32* %20, align 4
  %89 = sdiv i32 %88, 2
  store i32 %89, i32* %20, align 4
  br label %58, !llvm.loop !30

90:                                               ; preds = %58
  %91 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %92 = icmp eq i32 %91, 0
  br i1 %92, label %93, label %123

93:                                               ; preds = %90
  %94 = load float*, float** %13, align 8
  %95 = load float, float* getelementptr inbounds ([1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c104HalfEEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 0), align 4
  %96 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %97 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %21, i32 0, i32 0
  %98 = extractvalue %"class.std::ios_base::Init" %96, 0
  store i8 %98, i8* %97, align 1
  %99 = call contract float @_ZN3c10dvEfNS_13Float8_e4m3fnE(float %95, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %21) #23
  store float* %94, float** %9, align 8
  store float %99, float* %10, align 4
  %100 = load float, float* %10, align 4
  %101 = fcmp contract oge float %100, 0.000000e+00
  br i1 %101, label %102, label %111

102:                                              ; preds = %93
  %103 = load float*, float** %9, align 8
  %104 = bitcast float* %103 to i32*
  %105 = load float, float* %10, align 4
  store float %105, float* %4, align 4
  %106 = load float, float* %4, align 4
  %107 = bitcast float %106 to i32
  %108 = call i32 @_ZL9atomicMaxPii(i32* %104, i32 %107) #23
  store i32 %108, i32* %5, align 4
  %109 = load i32, i32* %5, align 4
  %110 = bitcast i32 %109 to float
  br label %120

111:                                              ; preds = %93
  %112 = load float*, float** %9, align 8
  %113 = bitcast float* %112 to i32*
  %114 = load float, float* %10, align 4
  store float %114, float* %7, align 4
  %115 = load float, float* %7, align 4
  %116 = bitcast float %115 to i32
  %117 = call i32 @_ZL9atomicMinPjj(i32* %113, i32 %116) #23
  store i32 %117, i32* %8, align 4
  %118 = load i32, i32* %8, align 4
  %119 = bitcast i32 %118 to float
  br label %120

120:                                              ; preds = %102, %111
  %121 = phi contract float [ %110, %102 ], [ %119, %111 ]
  store float %121, float* %11, align 4
  %122 = load float, float* %11, align 4
  br label %123

123:                                              ; preds = %120, %90
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c104HalfC1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, float %1) unnamed_addr #20 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca float, align 4
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store float %1, float* %4, align 4
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = load float, float* %4, align 4
  call void @_ZN3c104HalfC2Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %5, float %6) #23
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c104HalfC2Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, float %1) unnamed_addr #20 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca float, align 4
  %5 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store float %1, float* %4, align 4
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %7 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %6, i32 0, i32 0
  %8 = load float, float* %4, align 4
  %9 = call %"class.caffe2::TypeMeta" @_ZL12__float2halff(float %8) #23
  %10 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %5, i32 0, i32 0
  %11 = extractvalue %"class.caffe2::TypeMeta" %9, 0
  store i16 %11, i16* %10, align 2
  %12 = call signext i16 @_ZL15__half_as_short6__half(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %5) #23
  store i16 %12, i16* %7, align 2
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal %"class.caffe2::TypeMeta" @_ZL12__float2halff(float %0) #19 {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = alloca float, align 4
  store float %0, float* %3, align 4
  %4 = bitcast %"class.caffe2::TypeMeta"* %2 to i16*
  %5 = load float, float* %3, align 4
  %6 = call i16 asm "{  cvt.rn.f16.f32 $0, $1;}\0A", "=h,f"(float %5) #28, !srcloc !31
  store i16 %6, i16* %4, align 2
  %7 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, align 2
  ret %"class.caffe2::TypeMeta" %7
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal signext i16 @_ZL15__half_as_short6__half(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %0) #19 {
  %2 = bitcast %"class.caffe2::TypeMeta"* %0 to i16*
  %3 = load i16, i16* %2, align 2
  ret i16 %3
}

; Function Attrs: convergent noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23segmented_max_reductionIN3c108BFloat16EEEvPfPKT_l(float* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, i64 %2) #22 {
  %4 = alloca float, align 4
  %5 = alloca i32, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca i32, align 4
  %9 = alloca float*, align 8
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float, align 4
  %13 = alloca float*, align 8
  %14 = alloca %"class.caffe2::TypeMeta"*, align 8
  %15 = alloca i64, align 8
  %16 = alloca i32, align 4
  %17 = alloca %"class.caffe2::TypeMeta", align 2
  %18 = alloca float, align 4
  %19 = alloca %"class.caffe2::TypeMeta", align 2
  %20 = alloca i32, align 4
  %21 = alloca %"class.std::ios_base::Init", align 1
  store float* %0, float** %13, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %14, align 8
  store i64 %2, i64* %15, align 8
  %22 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %23 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  %24 = mul i32 %22, %23
  %25 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %26 = add i32 %24, %25
  store i32 %26, i32* %16, align 4
  call void @_ZN3c108BFloat16C1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17, float 0.000000e+00) #23
  br label %27

27:                                               ; preds = %32, %3
  %28 = load i32, i32* %16, align 4
  %29 = sext i32 %28 to i64
  %30 = load i64, i64* %15, align 8
  %31 = icmp slt i64 %29, %30
  br i1 %31, label %32, label %51

32:                                               ; preds = %27
  %33 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %14, align 8
  %34 = load i32, i32* %16, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %33, i64 %35
  %37 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %36) #23
  store float %37, float* %18, align 4
  %38 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17) #23
  %39 = load float, float* %18, align 4
  store float %39, float* %12, align 4
  %40 = load float, float* %12, align 4
  store float %40, float* %6, align 4
  %41 = load float, float* %6, align 4
  %42 = call float @llvm.nvvm.fabs.f(float %41) #3
  %43 = call contract float @_ZL3maxff(float %38, float %42) #23
  call void @_ZN3c108BFloat16C1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %19, float %43) #23
  %44 = bitcast %"class.caffe2::TypeMeta"* %17 to i8*
  %45 = bitcast %"class.caffe2::TypeMeta"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %44, i8* align 2 %45, i64 2, i1 false)
  %46 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %47 = call i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #3
  %48 = mul i32 %46, %47
  %49 = load i32, i32* %16, align 4
  %50 = add i32 %49, %48
  store i32 %50, i32* %16, align 4
  br label %27, !llvm.loop !32

51:                                               ; preds = %27
  %52 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17) #23
  %53 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %54 = zext i32 %53 to i64
  %55 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c108BFloat16EEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %54
  store float %52, float* %55, align 4
  call void @llvm.nvvm.barrier0()
  %56 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %57 = udiv i32 %56, 2
  store i32 %57, i32* %20, align 4
  br label %58

58:                                               ; preds = %87, %51
  %59 = load i32, i32* %20, align 4
  %60 = icmp ne i32 %59, 0
  br i1 %60, label %61, label %90

61:                                               ; preds = %58
  %62 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %63 = load i32, i32* %20, align 4
  %64 = icmp ult i32 %62, %63
  br i1 %64, label %65, label %87

65:                                               ; preds = %61
  %66 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %67 = load i32, i32* %20, align 4
  %68 = add i32 %66, %67
  %69 = zext i32 %68 to i64
  %70 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c108BFloat16EEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %69
  %71 = load float, float* %70, align 4
  %72 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %73 = zext i32 %72 to i64
  %74 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c108BFloat16EEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %73
  %75 = load float, float* %74, align 4
  %76 = fcmp contract ogt float %71, %75
  br i1 %76, label %77, label %87

77:                                               ; preds = %65
  %78 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %79 = load i32, i32* %20, align 4
  %80 = add i32 %78, %79
  %81 = zext i32 %80 to i64
  %82 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c108BFloat16EEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %81
  %83 = load float, float* %82, align 4
  %84 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %85 = zext i32 %84 to i64
  %86 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c108BFloat16EEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 %85
  store float %83, float* %86, align 4
  br label %87

87:                                               ; preds = %77, %65, %61
  call void @llvm.nvvm.barrier0()
  %88 = load i32, i32* %20, align 4
  %89 = sdiv i32 %88, 2
  store i32 %89, i32* %20, align 4
  br label %58, !llvm.loop !33

90:                                               ; preds = %58
  %91 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %92 = icmp eq i32 %91, 0
  br i1 %92, label %93, label %123

93:                                               ; preds = %90
  %94 = load float*, float** %13, align 8
  %95 = load float, float* getelementptr inbounds ([1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZN4vllm23segmented_max_reductionIN3c108BFloat16EEEvPfPKT_lE5cache to [1024 x float]*), i64 0, i64 0), align 4
  %96 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %97 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %21, i32 0, i32 0
  %98 = extractvalue %"class.std::ios_base::Init" %96, 0
  store i8 %98, i8* %97, align 1
  %99 = call contract float @_ZN3c10dvEfNS_13Float8_e4m3fnE(float %95, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %21) #23
  store float* %94, float** %9, align 8
  store float %99, float* %10, align 4
  %100 = load float, float* %10, align 4
  %101 = fcmp contract oge float %100, 0.000000e+00
  br i1 %101, label %102, label %111

102:                                              ; preds = %93
  %103 = load float*, float** %9, align 8
  %104 = bitcast float* %103 to i32*
  %105 = load float, float* %10, align 4
  store float %105, float* %4, align 4
  %106 = load float, float* %4, align 4
  %107 = bitcast float %106 to i32
  %108 = call i32 @_ZL9atomicMaxPii(i32* %104, i32 %107) #23
  store i32 %108, i32* %5, align 4
  %109 = load i32, i32* %5, align 4
  %110 = bitcast i32 %109 to float
  br label %120

111:                                              ; preds = %93
  %112 = load float*, float** %9, align 8
  %113 = bitcast float* %112 to i32*
  %114 = load float, float* %10, align 4
  store float %114, float* %7, align 4
  %115 = load float, float* %7, align 4
  %116 = bitcast float %115 to i32
  %117 = call i32 @_ZL9atomicMinPjj(i32* %113, i32 %116) #23
  store i32 %117, i32* %8, align 4
  %118 = load i32, i32* %8, align 4
  %119 = bitcast i32 %118 to float
  br label %120

120:                                              ; preds = %102, %111
  %121 = phi contract float [ %110, %102 ], [ %119, %111 ]
  store float %121, float* %11, align 4
  %122 = load float, float* %11, align 4
  br label %123

123:                                              ; preds = %120, %90
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c108BFloat16C1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, float %1) unnamed_addr #20 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca float, align 4
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store float %1, float* %4, align 4
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = load float, float* %4, align 4
  call void @_ZN3c108BFloat16C2Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %5, float %6) #23
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c108BFloat16C2Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, float %1) unnamed_addr #20 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca float, align 4
  %5 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store float %1, float* %4, align 4
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %7 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %6, i32 0, i32 0
  %8 = load float, float* %4, align 4
  %9 = call %"class.caffe2::TypeMeta" @_ZL16__float2bfloat16f(float %8) #23
  %10 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %5, i32 0, i32 0
  %11 = extractvalue %"class.caffe2::TypeMeta" %9, 0
  store i16 %11, i16* %10, align 2
  %12 = call zeroext i16 @_ZL20__bfloat16_as_ushort13__nv_bfloat16(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %5) #23
  store i16 %12, i16* %7, align 2
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal %"class.caffe2::TypeMeta" @_ZL16__float2bfloat16f(float %0) #19 {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = alloca float, align 4
  store float %0, float* %3, align 4
  %4 = bitcast %"class.caffe2::TypeMeta"* %2 to i16*
  %5 = load float, float* %3, align 4
  %6 = call i16 asm "{  cvt.rn.bf16.f32 $0, $1;}\0A", "=h,f"(float %5) #28, !srcloc !34
  store i16 %6, i16* %4, align 2
  %7 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, align 2
  ret %"class.caffe2::TypeMeta" %7
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal zeroext i16 @_ZL20__bfloat16_as_ushort13__nv_bfloat16(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %0) #19 {
  %2 = bitcast %"class.caffe2::TypeMeta"* %0 to i16*
  %3 = load i16, i16* %2, align 2
  ret i16 %3
}

; Function Attrs: convergent noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfi(%"class.std::ios_base::Init"* noalias %0, float* noalias %1, float* noalias %2, float* noalias %3, i32 %4) #22 {
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca float, align 4
  %11 = alloca %"class.std::ios_base::Init", align 8
  %12 = alloca double, align 8
  %13 = alloca %"class.std::ios_base::Init", align 8
  %14 = alloca %"class.std::ios_base::Init", align 1
  %15 = alloca float, align 4
  %16 = alloca float, align 4
  %17 = alloca float, align 4
  %18 = alloca float, align 4
  %19 = alloca %"class.std::ios_base::Init", align 1
  %20 = alloca %"class.std::ios_base::Init", align 1
  %21 = alloca %"class.std::ios_base::Init", align 1
  %22 = alloca float, align 4
  %23 = alloca float, align 4
  %24 = alloca %"class.std::ios_base::Init"*, align 8
  %25 = alloca float*, align 8
  %26 = alloca float*, align 8
  %27 = alloca float*, align 8
  %28 = alloca i32, align 4
  %29 = alloca float, align 4
  %30 = alloca %"class.std::ios_base::Init", align 1
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca float*, align 8
  %34 = alloca %"class.std::ios_base::Init"*, align 8
  %35 = alloca i8, align 1
  %36 = alloca float, align 4
  %37 = alloca i32, align 4
  %38 = alloca float, align 4
  %39 = alloca float, align 4
  %40 = alloca %"class.std::ios_base::Init", align 1
  %41 = alloca i32, align 4
  %42 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %24, align 8
  store float* %1, float** %25, align 8
  store float* %2, float** %26, align 8
  store float* %3, float** %27, align 8
  store i32 %4, i32* %28, align 4
  %43 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %44 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %30, i32 0, i32 0
  %45 = extractvalue %"class.std::ios_base::Init" %43, 0
  store i8 %45, i8* %44, align 1
  %46 = call contract float @_ZN3c10mlENS_13Float8_e4m3fnEf(%"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %30, float 5.120000e+02) #23
  %47 = fdiv contract float 1.000000e+00, %46
  store float %47, float* %29, align 4
  %48 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %48, i32* %31, align 4
  %49 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  store i32 %49, i32* %32, align 4
  %50 = load float*, float** %26, align 8
  %51 = load i32, i32* %32, align 4
  %52 = load i32, i32* %28, align 4
  %53 = mul nsw i32 %51, %52
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds float, float* %50, i64 %54
  store float* %55, float** %33, align 8
  %56 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %24, align 8
  %57 = load i32, i32* %32, align 4
  %58 = load i32, i32* %28, align 4
  %59 = mul nsw i32 %57, %58
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %56, i64 %60
  store %"class.std::ios_base::Init"* %61, %"class.std::ios_base::Init"** %34, align 8
  %62 = load i32, i32* %28, align 4
  %63 = srem i32 %62, 4
  %64 = icmp eq i32 %63, 0
  %65 = zext i1 %64 to i8
  store i8 %65, i8* %35, align 1
  store float 0.000000e+00, float* %36, align 4
  %66 = load i8, i8* %35, align 1
  %67 = trunc i8 %66 to i1
  br i1 %67, label %68, label %75

68:                                               ; preds = %5
  %69 = load float*, float** %33, align 8
  %70 = load i32, i32* %28, align 4
  %71 = sext i32 %70 to i64
  %72 = load i32, i32* %31, align 4
  %73 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %74 = call contract float @_ZN4vllm14thread_max_vecIfEEfPKT_lii(float* %69, i64 %71, i32 %72, i32 %73) #23
  store float %74, float* %36, align 4
  br label %98

75:                                               ; preds = %5
  %76 = load i32, i32* %31, align 4
  store i32 %76, i32* %37, align 4
  br label %77

77:                                               ; preds = %93, %75
  %78 = load i32, i32* %37, align 4
  %79 = load i32, i32* %28, align 4
  %80 = icmp slt i32 %78, %79
  br i1 %80, label %81, label %97

81:                                               ; preds = %77
  %82 = load float*, float** %33, align 8
  %83 = load i32, i32* %37, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds float, float* %82, i64 %84
  %86 = load float, float* %85, align 4
  store float %86, float* %38, align 4
  %87 = load float, float* %36, align 4
  %88 = load float, float* %38, align 4
  store float %88, float* %23, align 4
  %89 = load float, float* %23, align 4
  store float %89, float* %22, align 4
  %90 = load float, float* %22, align 4
  %91 = call float @llvm.nvvm.fabs.f(float %90) #3
  %92 = call contract float @_ZL3maxff(float %87, float %91) #23
  store float %92, float* %36, align 4
  br label %93

93:                                               ; preds = %81
  %94 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %95 = load i32, i32* %37, align 4
  %96 = add i32 %95, %94
  store i32 %96, i32* %37, align 4
  br label %77, !llvm.loop !35

97:                                               ; preds = %77
  br label %98

98:                                               ; preds = %97, %68
  %99 = load float, float* %36, align 4
  %100 = call contract float @_ZN4vllm14blockReduceMaxIfLi1024EEET_S1_(float %99) #23
  store float %100, float* %39, align 4
  %101 = load i32, i32* %31, align 4
  %102 = icmp eq i32 %101, 0
  br i1 %102, label %103, label %126

103:                                              ; preds = %98
  %104 = load float*, float** %27, align 8
  %105 = icmp ne float* %104, null
  br i1 %105, label %106, label %111

106:                                              ; preds = %103
  %107 = load float, float* %39, align 4
  %108 = load float*, float** %27, align 8
  %109 = load float, float* %108, align 4
  %110 = call contract float @_ZL3minff(float %107, float %109) #23
  store float %110, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  br label %113

111:                                              ; preds = %103
  %112 = load float, float* %39, align 4
  store float %112, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  br label %113

113:                                              ; preds = %111, %106
  %114 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %115 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %116 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %40, i32 0, i32 0
  %117 = extractvalue %"class.std::ios_base::Init" %115, 0
  store i8 %117, i8* %116, align 1
  %118 = call contract float @_ZN3c10dvEfNS_13Float8_e4m3fnE(float %114, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %40) #23
  %119 = load float, float* %29, align 4
  %120 = call contract float @_ZL3maxff(float %118, float %119) #23
  store float %120, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %121 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %122 = load float*, float** %25, align 8
  %123 = load i32, i32* %32, align 4
  %124 = sext i32 %123 to i64
  %125 = getelementptr inbounds float, float* %122, i64 %124
  store float %121, float* %125, align 4
  br label %126

126:                                              ; preds = %113, %98
  call void @llvm.nvvm.barrier0()
  %127 = load i8, i8* %35, align 1
  %128 = trunc i8 %127 to i1
  br i1 %128, label %129, label %137

129:                                              ; preds = %126
  %130 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %34, align 8
  %131 = load float*, float** %33, align 8
  %132 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %133 = load i32, i32* %28, align 4
  %134 = sext i32 %133 to i64
  %135 = load i32, i32* %31, align 4
  %136 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  call void @_ZN4vllm25scaled_fp8_conversion_vecIfLb0EEEvPN3c1013Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* %130, float* %131, float %132, i64 %134, i32 %135, i32 %136) #23
  br label %196

137:                                              ; preds = %126
  %138 = load i32, i32* %31, align 4
  store i32 %138, i32* %41, align 4
  br label %139

139:                                              ; preds = %191, %137
  %140 = load i32, i32* %41, align 4
  %141 = load i32, i32* %28, align 4
  %142 = icmp slt i32 %140, %141
  br i1 %142, label %143, label %195

143:                                              ; preds = %139
  %144 = load float*, float** %33, align 8
  %145 = load i32, i32* %41, align 4
  %146 = sext i32 %145 to i64
  %147 = getelementptr inbounds float, float* %144, i64 %146
  %148 = load float, float* %147, align 4
  %149 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  store float %148, float* %15, align 4
  store float %149, float* %16, align 4
  store float 0.000000e+00, float* %17, align 4
  %150 = load float, float* %15, align 4
  %151 = load float, float* %16, align 4
  %152 = fdiv contract float %150, %151
  store float %152, float* %17, align 4
  %153 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %154 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %20, i32 0, i32 0
  %155 = extractvalue %"class.std::ios_base::Init" %153, 0
  store i8 %155, i8* %154, align 1
  %156 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %20) #23
  %157 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %19, i32 0, i32 0
  %158 = extractvalue %"class.std::ios_base::Init" %156, 0
  store i8 %158, i8* %157, align 1
  %159 = load float, float* %17, align 4
  %160 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %161 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %21, i32 0, i32 0
  %162 = extractvalue %"class.std::ios_base::Init" %160, 0
  store i8 %162, i8* %161, align 1
  %163 = bitcast %"class.std::ios_base::Init"* %11 to i8*
  %164 = bitcast %"class.std::ios_base::Init"* %21 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %163, i8* align 1 %164, i64 1, i1 false) #3
  store float %159, float* %10, align 4
  %165 = load float, float* %10, align 4
  %166 = fpext float %165 to double
  %167 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %11) #23
  %168 = fpext float %167 to double
  store double %166, double* %6, align 8
  store double %168, double* %7, align 8
  %169 = load double, double* %6, align 8
  %170 = load double, double* %7, align 8
  %171 = call double @llvm.nvvm.fmin.d(double %169, double %170) #3
  %172 = bitcast %"class.std::ios_base::Init"* %13 to i8*
  %173 = bitcast %"class.std::ios_base::Init"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %172, i8* align 1 %173, i64 1, i1 false) #3
  store double %171, double* %12, align 8
  %174 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %13) #23
  %175 = fpext float %174 to double
  %176 = load double, double* %12, align 8
  store double %175, double* %8, align 8
  store double %176, double* %9, align 8
  %177 = load double, double* %8, align 8
  %178 = load double, double* %9, align 8
  %179 = call double @llvm.nvvm.fmax.d(double %177, double %178) #3
  %180 = fptrunc double %179 to float
  store float %180, float* %18, align 4
  %181 = load float, float* %18, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %14, float %181) #23
  %182 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %14, align 1
  %183 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %42, i32 0, i32 0
  %184 = extractvalue %"class.std::ios_base::Init" %182, 0
  store i8 %184, i8* %183, align 1
  %185 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %34, align 8
  %186 = load i32, i32* %41, align 4
  %187 = sext i32 %186 to i64
  %188 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %185, i64 %187
  %189 = bitcast %"class.std::ios_base::Init"* %188 to i8*
  %190 = bitcast %"class.std::ios_base::Init"* %42 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %189, i8* align 1 %190, i64 1, i1 false)
  br label %191

191:                                              ; preds = %143
  %192 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %193 = load i32, i32* %41, align 4
  %194 = add i32 %193, %192
  store i32 %194, i32* %41, align 4
  br label %139, !llvm.loop !36

195:                                              ; preds = %139
  br label %196

196:                                              ; preds = %195, %129
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZN3c10mlENS_13Float8_e4m3fnEf(%"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %0, float %1) #19 comdat {
  %3 = alloca float, align 4
  store float %1, float* %3, align 4
  %4 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %0) #23
  %5 = load float, float* %3, align 4
  %6 = fmul contract float %4, %5
  ret float %6
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local float @_ZN4vllm14thread_max_vecIfEEfPKT_lii(float* noalias %0, i64 %1, i32 %2, i32 %3) #18 comdat {
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float, align 4
  %13 = alloca float, align 4
  %14 = alloca float, align 4
  %15 = alloca float*, align 8
  %16 = alloca i64, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca %"struct.vllm::vec4_t"*, align 8
  %20 = alloca i32, align 4
  %21 = alloca float, align 4
  %22 = alloca i32, align 4
  %23 = alloca %"struct.vllm::vec4_t", align 8
  %24 = alloca i32, align 4
  store float* %0, float** %15, align 8
  store i64 %1, i64* %16, align 8
  store i32 %2, i32* %17, align 4
  store i32 %3, i32* %18, align 4
  %25 = load float*, float** %15, align 8
  %26 = bitcast float* %25 to %"struct.vllm::vec4_t"*
  store %"struct.vllm::vec4_t"* %26, %"struct.vllm::vec4_t"** %19, align 8
  %27 = load i64, i64* %16, align 8
  %28 = ashr i64 %27, 2
  %29 = trunc i64 %28 to i32
  store i32 %29, i32* %20, align 4
  store float 0.000000e+00, float* %21, align 4
  %30 = load i32, i32* %17, align 4
  store i32 %30, i32* %22, align 4
  br label %31

31:                                               ; preds = %70, %4
  %32 = load i32, i32* %22, align 4
  %33 = load i32, i32* %20, align 4
  %34 = icmp slt i32 %32, %33
  br i1 %34, label %35, label %74

35:                                               ; preds = %31
  %36 = load %"struct.vllm::vec4_t"*, %"struct.vllm::vec4_t"** %19, align 8
  %37 = load i32, i32* %22, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %36, i64 %38
  %40 = bitcast %"struct.vllm::vec4_t"* %23 to i8*
  %41 = bitcast %"struct.vllm::vec4_t"* %39 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %40, i8* align 8 %41, i64 16, i1 false)
  %42 = load float, float* %21, align 4
  %43 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %23, i32 0, i32 0
  %44 = load float, float* %43, align 8
  store float %44, float* %10, align 4
  %45 = load float, float* %10, align 4
  store float %45, float* %9, align 4
  %46 = load float, float* %9, align 4
  %47 = call float @llvm.nvvm.fabs.f(float %46) #3
  %48 = call contract float @_ZL3maxff(float %42, float %47) #23
  store float %48, float* %21, align 4
  %49 = load float, float* %21, align 4
  %50 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %23, i32 0, i32 1
  %51 = load float, float* %50, align 4
  store float %51, float* %11, align 4
  %52 = load float, float* %11, align 4
  store float %52, float* %8, align 4
  %53 = load float, float* %8, align 4
  %54 = call float @llvm.nvvm.fabs.f(float %53) #3
  %55 = call contract float @_ZL3maxff(float %49, float %54) #23
  store float %55, float* %21, align 4
  %56 = load float, float* %21, align 4
  %57 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %23, i32 0, i32 2
  %58 = load float, float* %57, align 8
  store float %58, float* %12, align 4
  %59 = load float, float* %12, align 4
  store float %59, float* %7, align 4
  %60 = load float, float* %7, align 4
  %61 = call float @llvm.nvvm.fabs.f(float %60) #3
  %62 = call contract float @_ZL3maxff(float %56, float %61) #23
  store float %62, float* %21, align 4
  %63 = load float, float* %21, align 4
  %64 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %23, i32 0, i32 3
  %65 = load float, float* %64, align 4
  store float %65, float* %13, align 4
  %66 = load float, float* %13, align 4
  store float %66, float* %6, align 4
  %67 = load float, float* %6, align 4
  %68 = call float @llvm.nvvm.fabs.f(float %67) #3
  %69 = call contract float @_ZL3maxff(float %63, float %68) #23
  store float %69, float* %21, align 4
  br label %70

70:                                               ; preds = %35
  %71 = load i32, i32* %18, align 4
  %72 = load i32, i32* %22, align 4
  %73 = add nsw i32 %72, %71
  store i32 %73, i32* %22, align 4
  br label %31, !llvm.loop !37

74:                                               ; preds = %31
  %75 = load i32, i32* %20, align 4
  %76 = mul nsw i32 %75, 4
  %77 = load i32, i32* %17, align 4
  %78 = add nsw i32 %76, %77
  store i32 %78, i32* %24, align 4
  br label %79

79:                                               ; preds = %95, %74
  %80 = load i32, i32* %24, align 4
  %81 = sext i32 %80 to i64
  %82 = load i64, i64* %16, align 8
  %83 = icmp slt i64 %81, %82
  br i1 %83, label %84, label %99

84:                                               ; preds = %79
  %85 = load float, float* %21, align 4
  %86 = load float*, float** %15, align 8
  %87 = load i32, i32* %24, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds float, float* %86, i64 %88
  %90 = load float, float* %89, align 4
  store float %90, float* %14, align 4
  %91 = load float, float* %14, align 4
  store float %91, float* %5, align 4
  %92 = load float, float* %5, align 4
  %93 = call float @llvm.nvvm.fabs.f(float %92) #3
  %94 = call contract float @_ZL3maxff(float %85, float %93) #23
  store float %94, float* %21, align 4
  br label %95

95:                                               ; preds = %84
  %96 = load i32, i32* %18, align 4
  %97 = load i32, i32* %24, align 4
  %98 = add nsw i32 %97, %96
  store i32 %98, i32* %24, align 4
  br label %79, !llvm.loop !38

99:                                               ; preds = %79
  %100 = load float, float* %21, align 4
  ret float %100
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZN4vllm14blockReduceMaxIfLi1024EEET_S1_(float %0) #19 comdat {
  %2 = alloca float, align 4
  store float %0, float* %2, align 4
  %3 = load float, float* %2, align 4
  %4 = call contract float @_ZN4vllm11blockReduceIfLi1024EEET_S1_PFS1_S1_S1_E(float %3, float (float, float)* @_ZN4vllm6detail4_maxIfEET_S2_S2_) #23
  ret float %4
}

; Function Attrs: convergent noinline nounwind optnone
define internal float @_ZL3minff(float %0, float %1) #18 {
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  store float %0, float* %5, align 4
  store float %1, float* %6, align 4
  %7 = load float, float* %5, align 4
  %8 = load float, float* %6, align 4
  store float %7, float* %3, align 4
  store float %8, float* %4, align 4
  %9 = load float, float* %3, align 4
  %10 = load float, float* %4, align 4
  %11 = call float @llvm.nvvm.fmin.f(float %9, float %10) #3
  ret float %11
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm25scaled_fp8_conversion_vecIfLb0EEEvPN3c1013Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* noalias %0, float* noalias %1, float %2, i64 %3, i32 %4, i32 %5) #18 comdat {
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca float, align 4
  %12 = alloca %"class.std::ios_base::Init", align 8
  %13 = alloca double, align 8
  %14 = alloca %"class.std::ios_base::Init", align 8
  %15 = alloca %"class.std::ios_base::Init", align 1
  %16 = alloca float, align 4
  %17 = alloca float, align 4
  %18 = alloca float, align 4
  %19 = alloca float, align 4
  %20 = alloca %"class.std::ios_base::Init", align 1
  %21 = alloca %"class.std::ios_base::Init", align 1
  %22 = alloca %"class.std::ios_base::Init", align 1
  %23 = alloca double, align 8
  %24 = alloca double, align 8
  %25 = alloca double, align 8
  %26 = alloca double, align 8
  %27 = alloca float, align 4
  %28 = alloca %"class.std::ios_base::Init", align 8
  %29 = alloca double, align 8
  %30 = alloca %"class.std::ios_base::Init", align 8
  %31 = alloca %"class.std::ios_base::Init", align 1
  %32 = alloca float, align 4
  %33 = alloca float, align 4
  %34 = alloca float, align 4
  %35 = alloca float, align 4
  %36 = alloca %"class.std::ios_base::Init", align 1
  %37 = alloca %"class.std::ios_base::Init", align 1
  %38 = alloca %"class.std::ios_base::Init", align 1
  %39 = alloca double, align 8
  %40 = alloca double, align 8
  %41 = alloca double, align 8
  %42 = alloca double, align 8
  %43 = alloca float, align 4
  %44 = alloca %"class.std::ios_base::Init", align 8
  %45 = alloca double, align 8
  %46 = alloca %"class.std::ios_base::Init", align 8
  %47 = alloca %"class.std::ios_base::Init", align 1
  %48 = alloca float, align 4
  %49 = alloca float, align 4
  %50 = alloca float, align 4
  %51 = alloca float, align 4
  %52 = alloca %"class.std::ios_base::Init", align 1
  %53 = alloca %"class.std::ios_base::Init", align 1
  %54 = alloca %"class.std::ios_base::Init", align 1
  %55 = alloca double, align 8
  %56 = alloca double, align 8
  %57 = alloca double, align 8
  %58 = alloca double, align 8
  %59 = alloca float, align 4
  %60 = alloca %"class.std::ios_base::Init", align 8
  %61 = alloca double, align 8
  %62 = alloca %"class.std::ios_base::Init", align 8
  %63 = alloca %"class.std::ios_base::Init", align 1
  %64 = alloca float, align 4
  %65 = alloca float, align 4
  %66 = alloca float, align 4
  %67 = alloca float, align 4
  %68 = alloca %"class.std::ios_base::Init", align 1
  %69 = alloca %"class.std::ios_base::Init", align 1
  %70 = alloca %"class.std::ios_base::Init", align 1
  %71 = alloca double, align 8
  %72 = alloca double, align 8
  %73 = alloca double, align 8
  %74 = alloca double, align 8
  %75 = alloca float, align 4
  %76 = alloca %"class.std::ios_base::Init", align 8
  %77 = alloca double, align 8
  %78 = alloca %"class.std::ios_base::Init", align 8
  %79 = alloca %"class.std::ios_base::Init", align 1
  %80 = alloca float, align 4
  %81 = alloca float, align 4
  %82 = alloca float, align 4
  %83 = alloca float, align 4
  %84 = alloca %"class.std::ios_base::Init", align 1
  %85 = alloca %"class.std::ios_base::Init", align 1
  %86 = alloca %"class.std::ios_base::Init", align 1
  %87 = alloca %"class.std::ios_base::Init"*, align 8
  %88 = alloca float*, align 8
  %89 = alloca float, align 4
  %90 = alloca i64, align 8
  %91 = alloca i32, align 4
  %92 = alloca i32, align 4
  %93 = alloca %"struct.vllm::vec4_t"*, align 8
  %94 = alloca %"struct.vllm::float8x4_t"*, align 8
  %95 = alloca i32, align 4
  %96 = alloca i32, align 4
  %97 = alloca %"struct.vllm::vec4_t", align 8
  %98 = alloca %"struct.vllm::float8x4_t", align 4
  %99 = alloca %"class.std::ios_base::Init", align 1
  %100 = alloca %"class.std::ios_base::Init", align 1
  %101 = alloca %"class.std::ios_base::Init", align 1
  %102 = alloca %"class.std::ios_base::Init", align 1
  %103 = alloca i32, align 4
  %104 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %87, align 8
  store float* %1, float** %88, align 8
  store float %2, float* %89, align 4
  store i64 %3, i64* %90, align 8
  store i32 %4, i32* %91, align 4
  store i32 %5, i32* %92, align 4
  %105 = load float*, float** %88, align 8
  %106 = bitcast float* %105 to %"struct.vllm::vec4_t"*
  store %"struct.vllm::vec4_t"* %106, %"struct.vllm::vec4_t"** %93, align 8
  %107 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %108 = bitcast %"class.std::ios_base::Init"* %107 to %"struct.vllm::float8x4_t"*
  store %"struct.vllm::float8x4_t"* %108, %"struct.vllm::float8x4_t"** %94, align 8
  %109 = load i64, i64* %90, align 8
  %110 = ashr i64 %109, 2
  %111 = trunc i64 %110 to i32
  store i32 %111, i32* %95, align 4
  %112 = load i32, i32* %91, align 4
  store i32 %112, i32* %96, align 4
  br label %113

113:                                              ; preds = %294, %6
  %114 = load i32, i32* %96, align 4
  %115 = load i32, i32* %95, align 4
  %116 = icmp slt i32 %114, %115
  br i1 %116, label %117, label %298

117:                                              ; preds = %113
  %118 = load %"struct.vllm::vec4_t"*, %"struct.vllm::vec4_t"** %93, align 8
  %119 = load i32, i32* %96, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %118, i64 %120
  %122 = bitcast %"struct.vllm::vec4_t"* %97 to i8*
  %123 = bitcast %"struct.vllm::vec4_t"* %121 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %122, i8* align 8 %123, i64 16, i1 false)
  %124 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %97, i32 0, i32 0
  %125 = load float, float* %124, align 8
  %126 = load float, float* %89, align 4
  store float %125, float* %16, align 4
  store float %126, float* %17, align 4
  store float 0.000000e+00, float* %18, align 4
  %127 = load float, float* %16, align 4
  %128 = load float, float* %17, align 4
  %129 = fdiv contract float %127, %128
  store float %129, float* %18, align 4
  %130 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %131 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %21, i32 0, i32 0
  %132 = extractvalue %"class.std::ios_base::Init" %130, 0
  store i8 %132, i8* %131, align 1
  %133 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %21) #23
  %134 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %20, i32 0, i32 0
  %135 = extractvalue %"class.std::ios_base::Init" %133, 0
  store i8 %135, i8* %134, align 1
  %136 = load float, float* %18, align 4
  %137 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %138 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %22, i32 0, i32 0
  %139 = extractvalue %"class.std::ios_base::Init" %137, 0
  store i8 %139, i8* %138, align 1
  %140 = bitcast %"class.std::ios_base::Init"* %12 to i8*
  %141 = bitcast %"class.std::ios_base::Init"* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %140, i8* align 1 %141, i64 1, i1 false) #3
  store float %136, float* %11, align 4
  %142 = load float, float* %11, align 4
  %143 = fpext float %142 to double
  %144 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %12) #23
  %145 = fpext float %144 to double
  store double %143, double* %7, align 8
  store double %145, double* %8, align 8
  %146 = load double, double* %7, align 8
  %147 = load double, double* %8, align 8
  %148 = call double @llvm.nvvm.fmin.d(double %146, double %147) #3
  %149 = bitcast %"class.std::ios_base::Init"* %14 to i8*
  %150 = bitcast %"class.std::ios_base::Init"* %20 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %149, i8* align 1 %150, i64 1, i1 false) #3
  store double %148, double* %13, align 8
  %151 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %14) #23
  %152 = fpext float %151 to double
  %153 = load double, double* %13, align 8
  store double %152, double* %9, align 8
  store double %153, double* %10, align 8
  %154 = load double, double* %9, align 8
  %155 = load double, double* %10, align 8
  %156 = call double @llvm.nvvm.fmax.d(double %154, double %155) #3
  %157 = fptrunc double %156 to float
  store float %157, float* %19, align 4
  %158 = load float, float* %19, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %15, float %158) #23
  %159 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %15, align 1
  %160 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %99, i32 0, i32 0
  %161 = extractvalue %"class.std::ios_base::Init" %159, 0
  store i8 %161, i8* %160, align 1
  %162 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 0
  %163 = bitcast %"class.std::ios_base::Init"* %162 to i8*
  %164 = bitcast %"class.std::ios_base::Init"* %99 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %163, i8* align 1 %164, i64 1, i1 false)
  %165 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %97, i32 0, i32 1
  %166 = load float, float* %165, align 4
  %167 = load float, float* %89, align 4
  store float %166, float* %32, align 4
  store float %167, float* %33, align 4
  store float 0.000000e+00, float* %34, align 4
  %168 = load float, float* %32, align 4
  %169 = load float, float* %33, align 4
  %170 = fdiv contract float %168, %169
  store float %170, float* %34, align 4
  %171 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %172 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %37, i32 0, i32 0
  %173 = extractvalue %"class.std::ios_base::Init" %171, 0
  store i8 %173, i8* %172, align 1
  %174 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %37) #23
  %175 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %36, i32 0, i32 0
  %176 = extractvalue %"class.std::ios_base::Init" %174, 0
  store i8 %176, i8* %175, align 1
  %177 = load float, float* %34, align 4
  %178 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %179 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %38, i32 0, i32 0
  %180 = extractvalue %"class.std::ios_base::Init" %178, 0
  store i8 %180, i8* %179, align 1
  %181 = bitcast %"class.std::ios_base::Init"* %28 to i8*
  %182 = bitcast %"class.std::ios_base::Init"* %38 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %181, i8* align 1 %182, i64 1, i1 false) #3
  store float %177, float* %27, align 4
  %183 = load float, float* %27, align 4
  %184 = fpext float %183 to double
  %185 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %28) #23
  %186 = fpext float %185 to double
  store double %184, double* %23, align 8
  store double %186, double* %24, align 8
  %187 = load double, double* %23, align 8
  %188 = load double, double* %24, align 8
  %189 = call double @llvm.nvvm.fmin.d(double %187, double %188) #3
  %190 = bitcast %"class.std::ios_base::Init"* %30 to i8*
  %191 = bitcast %"class.std::ios_base::Init"* %36 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %190, i8* align 1 %191, i64 1, i1 false) #3
  store double %189, double* %29, align 8
  %192 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %30) #23
  %193 = fpext float %192 to double
  %194 = load double, double* %29, align 8
  store double %193, double* %25, align 8
  store double %194, double* %26, align 8
  %195 = load double, double* %25, align 8
  %196 = load double, double* %26, align 8
  %197 = call double @llvm.nvvm.fmax.d(double %195, double %196) #3
  %198 = fptrunc double %197 to float
  store float %198, float* %35, align 4
  %199 = load float, float* %35, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %31, float %199) #23
  %200 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %31, align 1
  %201 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %100, i32 0, i32 0
  %202 = extractvalue %"class.std::ios_base::Init" %200, 0
  store i8 %202, i8* %201, align 1
  %203 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 1
  %204 = bitcast %"class.std::ios_base::Init"* %203 to i8*
  %205 = bitcast %"class.std::ios_base::Init"* %100 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %204, i8* align 1 %205, i64 1, i1 false)
  %206 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %97, i32 0, i32 2
  %207 = load float, float* %206, align 8
  %208 = load float, float* %89, align 4
  store float %207, float* %48, align 4
  store float %208, float* %49, align 4
  store float 0.000000e+00, float* %50, align 4
  %209 = load float, float* %48, align 4
  %210 = load float, float* %49, align 4
  %211 = fdiv contract float %209, %210
  store float %211, float* %50, align 4
  %212 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %213 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %53, i32 0, i32 0
  %214 = extractvalue %"class.std::ios_base::Init" %212, 0
  store i8 %214, i8* %213, align 1
  %215 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %53) #23
  %216 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %52, i32 0, i32 0
  %217 = extractvalue %"class.std::ios_base::Init" %215, 0
  store i8 %217, i8* %216, align 1
  %218 = load float, float* %50, align 4
  %219 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %220 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %54, i32 0, i32 0
  %221 = extractvalue %"class.std::ios_base::Init" %219, 0
  store i8 %221, i8* %220, align 1
  %222 = bitcast %"class.std::ios_base::Init"* %44 to i8*
  %223 = bitcast %"class.std::ios_base::Init"* %54 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %222, i8* align 1 %223, i64 1, i1 false) #3
  store float %218, float* %43, align 4
  %224 = load float, float* %43, align 4
  %225 = fpext float %224 to double
  %226 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %44) #23
  %227 = fpext float %226 to double
  store double %225, double* %39, align 8
  store double %227, double* %40, align 8
  %228 = load double, double* %39, align 8
  %229 = load double, double* %40, align 8
  %230 = call double @llvm.nvvm.fmin.d(double %228, double %229) #3
  %231 = bitcast %"class.std::ios_base::Init"* %46 to i8*
  %232 = bitcast %"class.std::ios_base::Init"* %52 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %231, i8* align 1 %232, i64 1, i1 false) #3
  store double %230, double* %45, align 8
  %233 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %46) #23
  %234 = fpext float %233 to double
  %235 = load double, double* %45, align 8
  store double %234, double* %41, align 8
  store double %235, double* %42, align 8
  %236 = load double, double* %41, align 8
  %237 = load double, double* %42, align 8
  %238 = call double @llvm.nvvm.fmax.d(double %236, double %237) #3
  %239 = fptrunc double %238 to float
  store float %239, float* %51, align 4
  %240 = load float, float* %51, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %47, float %240) #23
  %241 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %47, align 1
  %242 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %101, i32 0, i32 0
  %243 = extractvalue %"class.std::ios_base::Init" %241, 0
  store i8 %243, i8* %242, align 1
  %244 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 2
  %245 = bitcast %"class.std::ios_base::Init"* %244 to i8*
  %246 = bitcast %"class.std::ios_base::Init"* %101 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %245, i8* align 1 %246, i64 1, i1 false)
  %247 = getelementptr inbounds %"struct.vllm::vec4_t", %"struct.vllm::vec4_t"* %97, i32 0, i32 3
  %248 = load float, float* %247, align 4
  %249 = load float, float* %89, align 4
  store float %248, float* %64, align 4
  store float %249, float* %65, align 4
  store float 0.000000e+00, float* %66, align 4
  %250 = load float, float* %64, align 4
  %251 = load float, float* %65, align 4
  %252 = fdiv contract float %250, %251
  store float %252, float* %66, align 4
  %253 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %254 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %69, i32 0, i32 0
  %255 = extractvalue %"class.std::ios_base::Init" %253, 0
  store i8 %255, i8* %254, align 1
  %256 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %69) #23
  %257 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %68, i32 0, i32 0
  %258 = extractvalue %"class.std::ios_base::Init" %256, 0
  store i8 %258, i8* %257, align 1
  %259 = load float, float* %66, align 4
  %260 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %261 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %70, i32 0, i32 0
  %262 = extractvalue %"class.std::ios_base::Init" %260, 0
  store i8 %262, i8* %261, align 1
  %263 = bitcast %"class.std::ios_base::Init"* %60 to i8*
  %264 = bitcast %"class.std::ios_base::Init"* %70 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %263, i8* align 1 %264, i64 1, i1 false) #3
  store float %259, float* %59, align 4
  %265 = load float, float* %59, align 4
  %266 = fpext float %265 to double
  %267 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %60) #23
  %268 = fpext float %267 to double
  store double %266, double* %55, align 8
  store double %268, double* %56, align 8
  %269 = load double, double* %55, align 8
  %270 = load double, double* %56, align 8
  %271 = call double @llvm.nvvm.fmin.d(double %269, double %270) #3
  %272 = bitcast %"class.std::ios_base::Init"* %62 to i8*
  %273 = bitcast %"class.std::ios_base::Init"* %68 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %272, i8* align 1 %273, i64 1, i1 false) #3
  store double %271, double* %61, align 8
  %274 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %62) #23
  %275 = fpext float %274 to double
  %276 = load double, double* %61, align 8
  store double %275, double* %57, align 8
  store double %276, double* %58, align 8
  %277 = load double, double* %57, align 8
  %278 = load double, double* %58, align 8
  %279 = call double @llvm.nvvm.fmax.d(double %277, double %278) #3
  %280 = fptrunc double %279 to float
  store float %280, float* %67, align 4
  %281 = load float, float* %67, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %63, float %281) #23
  %282 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %63, align 1
  %283 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %102, i32 0, i32 0
  %284 = extractvalue %"class.std::ios_base::Init" %282, 0
  store i8 %284, i8* %283, align 1
  %285 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 3
  %286 = bitcast %"class.std::ios_base::Init"* %285 to i8*
  %287 = bitcast %"class.std::ios_base::Init"* %102 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %286, i8* align 1 %287, i64 1, i1 false)
  %288 = load %"struct.vllm::float8x4_t"*, %"struct.vllm::float8x4_t"** %94, align 8
  %289 = load i32, i32* %96, align 4
  %290 = sext i32 %289 to i64
  %291 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %288, i64 %290
  %292 = bitcast %"struct.vllm::float8x4_t"* %291 to i8*
  %293 = bitcast %"struct.vllm::float8x4_t"* %98 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %292, i8* align 4 %293, i64 4, i1 false)
  br label %294

294:                                              ; preds = %117
  %295 = load i32, i32* %92, align 4
  %296 = load i32, i32* %96, align 4
  %297 = add nsw i32 %296, %295
  store i32 %297, i32* %96, align 4
  br label %113, !llvm.loop !39

298:                                              ; preds = %113
  %299 = load i32, i32* %95, align 4
  %300 = mul nsw i32 %299, 4
  %301 = load i32, i32* %91, align 4
  %302 = add nsw i32 %300, %301
  store i32 %302, i32* %103, align 4
  br label %303

303:                                              ; preds = %356, %298
  %304 = load i32, i32* %103, align 4
  %305 = sext i32 %304 to i64
  %306 = load i64, i64* %90, align 8
  %307 = icmp slt i64 %305, %306
  br i1 %307, label %308, label %360

308:                                              ; preds = %303
  %309 = load float*, float** %88, align 8
  %310 = load i32, i32* %103, align 4
  %311 = sext i32 %310 to i64
  %312 = getelementptr inbounds float, float* %309, i64 %311
  %313 = load float, float* %312, align 4
  %314 = load float, float* %89, align 4
  store float %313, float* %80, align 4
  store float %314, float* %81, align 4
  store float 0.000000e+00, float* %82, align 4
  %315 = load float, float* %80, align 4
  %316 = load float, float* %81, align 4
  %317 = fdiv contract float %315, %316
  store float %317, float* %82, align 4
  %318 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %319 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %85, i32 0, i32 0
  %320 = extractvalue %"class.std::ios_base::Init" %318, 0
  store i8 %320, i8* %319, align 1
  %321 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %85) #23
  %322 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %84, i32 0, i32 0
  %323 = extractvalue %"class.std::ios_base::Init" %321, 0
  store i8 %323, i8* %322, align 1
  %324 = load float, float* %82, align 4
  %325 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %326 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %86, i32 0, i32 0
  %327 = extractvalue %"class.std::ios_base::Init" %325, 0
  store i8 %327, i8* %326, align 1
  %328 = bitcast %"class.std::ios_base::Init"* %76 to i8*
  %329 = bitcast %"class.std::ios_base::Init"* %86 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %328, i8* align 1 %329, i64 1, i1 false) #3
  store float %324, float* %75, align 4
  %330 = load float, float* %75, align 4
  %331 = fpext float %330 to double
  %332 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %76) #23
  %333 = fpext float %332 to double
  store double %331, double* %71, align 8
  store double %333, double* %72, align 8
  %334 = load double, double* %71, align 8
  %335 = load double, double* %72, align 8
  %336 = call double @llvm.nvvm.fmin.d(double %334, double %335) #3
  %337 = bitcast %"class.std::ios_base::Init"* %78 to i8*
  %338 = bitcast %"class.std::ios_base::Init"* %84 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %337, i8* align 1 %338, i64 1, i1 false) #3
  store double %336, double* %77, align 8
  %339 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %78) #23
  %340 = fpext float %339 to double
  %341 = load double, double* %77, align 8
  store double %340, double* %73, align 8
  store double %341, double* %74, align 8
  %342 = load double, double* %73, align 8
  %343 = load double, double* %74, align 8
  %344 = call double @llvm.nvvm.fmax.d(double %342, double %343) #3
  %345 = fptrunc double %344 to float
  store float %345, float* %83, align 4
  %346 = load float, float* %83, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %79, float %346) #23
  %347 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %79, align 1
  %348 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %104, i32 0, i32 0
  %349 = extractvalue %"class.std::ios_base::Init" %347, 0
  store i8 %349, i8* %348, align 1
  %350 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %351 = load i32, i32* %103, align 4
  %352 = sext i32 %351 to i64
  %353 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %350, i64 %352
  %354 = bitcast %"class.std::ios_base::Init"* %353 to i8*
  %355 = bitcast %"class.std::ios_base::Init"* %104 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %354, i8* align 1 %355, i64 1, i1 false)
  br label %356

356:                                              ; preds = %308
  %357 = load i32, i32* %92, align 4
  %358 = load i32, i32* %103, align 4
  %359 = add nsw i32 %358, %357
  store i32 %359, i32* %103, align 4
  br label %303, !llvm.loop !40

360:                                              ; preds = %303
  ret void
}

; Function Attrs: nounwind readnone
declare float @llvm.nvvm.fmin.f(float, float) #17

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZN4vllm6detail4_maxIfEET_S2_S2_(float %0, float %1) #19 comdat {
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  store float %0, float* %3, align 4
  store float %1, float* %4, align 4
  %5 = load float, float* %3, align 4
  %6 = load float, float* %4, align 4
  %7 = call contract float @_ZL3maxff(float %5, float %6) #23
  ret float %7
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZN4vllm11blockReduceIfLi1024EEET_S1_PFS1_S1_S1_E(float %0, float (float, float)* %1) #19 comdat {
  %3 = alloca float, align 4
  %4 = alloca float (float, float)*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store float %0, float* %3, align 4
  store float (float, float)* %1, float (float, float)** %4, align 8
  %8 = load float, float* %3, align 4
  %9 = load float (float, float)*, float (float, float)** %4, align 8
  %10 = call contract float @_ZN4vllm10warpReduceIfLi32EEET_S1_PFS1_S1_S1_E(float %8, float (float, float)* %9) #23
  store float %10, float* %3, align 4
  store i32 32, i32* %5, align 4
  %11 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %12 = urem i32 %11, 32
  store i32 %12, i32* %6, align 4
  %13 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %14 = udiv i32 %13, 32
  store i32 %14, i32* %7, align 4
  %15 = load i32, i32* %6, align 4
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %22

17:                                               ; preds = %2
  %18 = load float, float* %3, align 4
  %19 = load i32, i32* %7, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [32 x float], [32 x float]* addrspacecast ([32 x float] addrspace(3)* @_ZZN4vllm11blockReduceIfLi1024EEET_S1_PFS1_S1_S1_EE6shared to [32 x float]*), i64 0, i64 %20
  store float %18, float* %21, align 4
  br label %22

22:                                               ; preds = %17, %2
  call void @llvm.nvvm.barrier0()
  %23 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  %24 = uitofp i32 %23 to float
  %25 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %26 = uitofp i32 %25 to float
  %27 = fdiv contract float %26, 3.200000e+01
  %28 = fcmp contract olt float %24, %27
  br i1 %28, label %29, label %34

29:                                               ; preds = %22
  %30 = load i32, i32* %6, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [32 x float], [32 x float]* addrspacecast ([32 x float] addrspace(3)* @_ZZN4vllm11blockReduceIfLi1024EEET_S1_PFS1_S1_S1_EE6shared to [32 x float]*), i64 0, i64 %31
  %33 = load float, float* %32, align 4
  br label %35

34:                                               ; preds = %22
  br label %35

35:                                               ; preds = %34, %29
  %36 = phi contract float [ %33, %29 ], [ 0.000000e+00, %34 ]
  store float %36, float* %3, align 4
  %37 = load float, float* %3, align 4
  %38 = load float (float, float)*, float (float, float)** %4, align 8
  %39 = call contract float @_ZN4vllm10warpReduceIfLi32EEET_S1_PFS1_S1_S1_E(float %37, float (float, float)* %38) #23
  store float %39, float* %3, align 4
  %40 = load float, float* %3, align 4
  ret float %40
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZN4vllm10warpReduceIfLi32EEET_S1_PFS1_S1_S1_E(float %0, float (float, float)* %1) #19 comdat {
  %3 = alloca float, align 4
  %4 = alloca float (float, float)*, align 8
  %5 = alloca i32, align 4
  store float %0, float* %3, align 4
  store float (float, float)* %1, float (float, float)** %4, align 8
  store i32 16, i32* %5, align 4
  br label %6

6:                                                ; preds = %16, %2
  %7 = load i32, i32* %5, align 4
  %8 = icmp sgt i32 %7, 0
  br i1 %8, label %9, label %19

9:                                                ; preds = %6
  %10 = load float (float, float)*, float (float, float)** %4, align 8
  %11 = load float, float* %3, align 4
  %12 = load float, float* %3, align 4
  %13 = load i32, i32* %5, align 4
  %14 = call contract float @_Z15__shfl_xor_syncjfii(i32 -1, float %12, i32 %13, i32 32) #23
  %15 = call contract float %10(float %11, float %14) #23
  store float %15, float* %3, align 4
  br label %16

16:                                               ; preds = %9
  %17 = load i32, i32* %5, align 4
  %18 = ashr i32 %17, 1
  store i32 %18, i32* %5, align 4
  br label %6, !llvm.loop !41

19:                                               ; preds = %6
  %20 = load float, float* %3, align 4
  ret float %20
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_Z15__shfl_xor_syncjfii(i32 %0, float %1, i32 %2, i32 %3) #19 comdat {
  %5 = alloca i32, align 4
  %6 = alloca float, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, i32* %5, align 4
  store float %1, float* %6, align 4
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %5, align 4
  %10 = load float, float* %6, align 4
  %11 = load i32, i32* %7, align 4
  %12 = load i32, i32* %8, align 4
  %13 = sub nsw i32 32, %12
  %14 = shl i32 %13, 8
  %15 = or i32 %14, 31
  %16 = call contract float @llvm.nvvm.shfl.sync.bfly.f32(i32 %9, float %10, i32 %11, i32 %15)
  ret float %16
}

; Function Attrs: convergent inaccessiblememonly nounwind
declare float @llvm.nvvm.shfl.sync.bfly.f32(i32, float, i32, i32) #24

; Function Attrs: convergent noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfi(%"class.std::ios_base::Init"* noalias %0, float* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, float* noalias %3, i32 %4) #22 {
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca float, align 4
  %11 = alloca %"class.std::ios_base::Init", align 8
  %12 = alloca double, align 8
  %13 = alloca %"class.std::ios_base::Init", align 8
  %14 = alloca %"class.std::ios_base::Init", align 1
  %15 = alloca float, align 4
  %16 = alloca float, align 4
  %17 = alloca float, align 4
  %18 = alloca float, align 4
  %19 = alloca %"class.std::ios_base::Init", align 1
  %20 = alloca %"class.std::ios_base::Init", align 1
  %21 = alloca %"class.std::ios_base::Init", align 1
  %22 = alloca float, align 4
  %23 = alloca float, align 4
  %24 = alloca %"class.std::ios_base::Init"*, align 8
  %25 = alloca float*, align 8
  %26 = alloca %"class.caffe2::TypeMeta"*, align 8
  %27 = alloca float*, align 8
  %28 = alloca i32, align 4
  %29 = alloca float, align 4
  %30 = alloca %"class.std::ios_base::Init", align 1
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca %"class.caffe2::TypeMeta"*, align 8
  %34 = alloca %"class.std::ios_base::Init"*, align 8
  %35 = alloca i8, align 1
  %36 = alloca float, align 4
  %37 = alloca i32, align 4
  %38 = alloca float, align 4
  %39 = alloca float, align 4
  %40 = alloca %"class.std::ios_base::Init", align 1
  %41 = alloca i32, align 4
  %42 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %24, align 8
  store float* %1, float** %25, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %26, align 8
  store float* %3, float** %27, align 8
  store i32 %4, i32* %28, align 4
  %43 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %44 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %30, i32 0, i32 0
  %45 = extractvalue %"class.std::ios_base::Init" %43, 0
  store i8 %45, i8* %44, align 1
  %46 = call contract float @_ZN3c10mlENS_13Float8_e4m3fnEf(%"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %30, float 5.120000e+02) #23
  %47 = fdiv contract float 1.000000e+00, %46
  store float %47, float* %29, align 4
  %48 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %48, i32* %31, align 4
  %49 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  store i32 %49, i32* %32, align 4
  %50 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %26, align 8
  %51 = load i32, i32* %32, align 4
  %52 = load i32, i32* %28, align 4
  %53 = mul nsw i32 %51, %52
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %50, i64 %54
  store %"class.caffe2::TypeMeta"* %55, %"class.caffe2::TypeMeta"** %33, align 8
  %56 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %24, align 8
  %57 = load i32, i32* %32, align 4
  %58 = load i32, i32* %28, align 4
  %59 = mul nsw i32 %57, %58
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %56, i64 %60
  store %"class.std::ios_base::Init"* %61, %"class.std::ios_base::Init"** %34, align 8
  %62 = load i32, i32* %28, align 4
  %63 = srem i32 %62, 4
  %64 = icmp eq i32 %63, 0
  %65 = zext i1 %64 to i8
  store i8 %65, i8* %35, align 1
  store float 0.000000e+00, float* %36, align 4
  %66 = load i8, i8* %35, align 1
  %67 = trunc i8 %66 to i1
  br i1 %67, label %68, label %75

68:                                               ; preds = %5
  %69 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %33, align 8
  %70 = load i32, i32* %28, align 4
  %71 = sext i32 %70 to i64
  %72 = load i32, i32* %31, align 4
  %73 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %74 = call contract float @_ZN4vllm14thread_max_vecIN3c104HalfEEEfPKT_lii(%"class.caffe2::TypeMeta"* %69, i64 %71, i32 %72, i32 %73) #23
  store float %74, float* %36, align 4
  br label %98

75:                                               ; preds = %5
  %76 = load i32, i32* %31, align 4
  store i32 %76, i32* %37, align 4
  br label %77

77:                                               ; preds = %93, %75
  %78 = load i32, i32* %37, align 4
  %79 = load i32, i32* %28, align 4
  %80 = icmp slt i32 %78, %79
  br i1 %80, label %81, label %97

81:                                               ; preds = %77
  %82 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %33, align 8
  %83 = load i32, i32* %37, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %82, i64 %84
  %86 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %85) #23
  store float %86, float* %38, align 4
  %87 = load float, float* %36, align 4
  %88 = load float, float* %38, align 4
  store float %88, float* %23, align 4
  %89 = load float, float* %23, align 4
  store float %89, float* %22, align 4
  %90 = load float, float* %22, align 4
  %91 = call float @llvm.nvvm.fabs.f(float %90) #3
  %92 = call contract float @_ZL3maxff(float %87, float %91) #23
  store float %92, float* %36, align 4
  br label %93

93:                                               ; preds = %81
  %94 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %95 = load i32, i32* %37, align 4
  %96 = add i32 %95, %94
  store i32 %96, i32* %37, align 4
  br label %77, !llvm.loop !43

97:                                               ; preds = %77
  br label %98

98:                                               ; preds = %97, %68
  %99 = load float, float* %36, align 4
  %100 = call contract float @_ZN4vllm14blockReduceMaxIfLi1024EEET_S1_(float %99) #23
  store float %100, float* %39, align 4
  %101 = load i32, i32* %31, align 4
  %102 = icmp eq i32 %101, 0
  br i1 %102, label %103, label %126

103:                                              ; preds = %98
  %104 = load float*, float** %27, align 8
  %105 = icmp ne float* %104, null
  br i1 %105, label %106, label %111

106:                                              ; preds = %103
  %107 = load float, float* %39, align 4
  %108 = load float*, float** %27, align 8
  %109 = load float, float* %108, align 4
  %110 = call contract float @_ZL3minff(float %107, float %109) #23
  store float %110, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  br label %113

111:                                              ; preds = %103
  %112 = load float, float* %39, align 4
  store float %112, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  br label %113

113:                                              ; preds = %111, %106
  %114 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %115 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %116 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %40, i32 0, i32 0
  %117 = extractvalue %"class.std::ios_base::Init" %115, 0
  store i8 %117, i8* %116, align 1
  %118 = call contract float @_ZN3c10dvEfNS_13Float8_e4m3fnE(float %114, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %40) #23
  %119 = load float, float* %29, align 4
  %120 = call contract float @_ZL3maxff(float %118, float %119) #23
  store float %120, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %121 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %122 = load float*, float** %25, align 8
  %123 = load i32, i32* %32, align 4
  %124 = sext i32 %123 to i64
  %125 = getelementptr inbounds float, float* %122, i64 %124
  store float %121, float* %125, align 4
  br label %126

126:                                              ; preds = %113, %98
  call void @llvm.nvvm.barrier0()
  %127 = load i8, i8* %35, align 1
  %128 = trunc i8 %127 to i1
  br i1 %128, label %129, label %137

129:                                              ; preds = %126
  %130 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %34, align 8
  %131 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %33, align 8
  %132 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %133 = load i32, i32* %28, align 4
  %134 = sext i32 %133 to i64
  %135 = load i32, i32* %31, align 4
  %136 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  call void @_ZN4vllm25scaled_fp8_conversion_vecIN3c104HalfELb0EEEvPNS1_13Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* %130, %"class.caffe2::TypeMeta"* %131, float %132, i64 %134, i32 %135, i32 %136) #23
  br label %196

137:                                              ; preds = %126
  %138 = load i32, i32* %31, align 4
  store i32 %138, i32* %41, align 4
  br label %139

139:                                              ; preds = %191, %137
  %140 = load i32, i32* %41, align 4
  %141 = load i32, i32* %28, align 4
  %142 = icmp slt i32 %140, %141
  br i1 %142, label %143, label %195

143:                                              ; preds = %139
  %144 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %33, align 8
  %145 = load i32, i32* %41, align 4
  %146 = sext i32 %145 to i64
  %147 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %144, i64 %146
  %148 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %147) #23
  %149 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  store float %148, float* %15, align 4
  store float %149, float* %16, align 4
  store float 0.000000e+00, float* %17, align 4
  %150 = load float, float* %15, align 4
  %151 = load float, float* %16, align 4
  %152 = fdiv contract float %150, %151
  store float %152, float* %17, align 4
  %153 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %154 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %20, i32 0, i32 0
  %155 = extractvalue %"class.std::ios_base::Init" %153, 0
  store i8 %155, i8* %154, align 1
  %156 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %20) #23
  %157 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %19, i32 0, i32 0
  %158 = extractvalue %"class.std::ios_base::Init" %156, 0
  store i8 %158, i8* %157, align 1
  %159 = load float, float* %17, align 4
  %160 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %161 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %21, i32 0, i32 0
  %162 = extractvalue %"class.std::ios_base::Init" %160, 0
  store i8 %162, i8* %161, align 1
  %163 = bitcast %"class.std::ios_base::Init"* %11 to i8*
  %164 = bitcast %"class.std::ios_base::Init"* %21 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %163, i8* align 1 %164, i64 1, i1 false) #3
  store float %159, float* %10, align 4
  %165 = load float, float* %10, align 4
  %166 = fpext float %165 to double
  %167 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %11) #23
  %168 = fpext float %167 to double
  store double %166, double* %6, align 8
  store double %168, double* %7, align 8
  %169 = load double, double* %6, align 8
  %170 = load double, double* %7, align 8
  %171 = call double @llvm.nvvm.fmin.d(double %169, double %170) #3
  %172 = bitcast %"class.std::ios_base::Init"* %13 to i8*
  %173 = bitcast %"class.std::ios_base::Init"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %172, i8* align 1 %173, i64 1, i1 false) #3
  store double %171, double* %12, align 8
  %174 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %13) #23
  %175 = fpext float %174 to double
  %176 = load double, double* %12, align 8
  store double %175, double* %8, align 8
  store double %176, double* %9, align 8
  %177 = load double, double* %8, align 8
  %178 = load double, double* %9, align 8
  %179 = call double @llvm.nvvm.fmax.d(double %177, double %178) #3
  %180 = fptrunc double %179 to float
  store float %180, float* %18, align 4
  %181 = load float, float* %18, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %14, float %181) #23
  %182 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %14, align 1
  %183 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %42, i32 0, i32 0
  %184 = extractvalue %"class.std::ios_base::Init" %182, 0
  store i8 %184, i8* %183, align 1
  %185 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %34, align 8
  %186 = load i32, i32* %41, align 4
  %187 = sext i32 %186 to i64
  %188 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %185, i64 %187
  %189 = bitcast %"class.std::ios_base::Init"* %188 to i8*
  %190 = bitcast %"class.std::ios_base::Init"* %42 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %189, i8* align 1 %190, i64 1, i1 false)
  br label %191

191:                                              ; preds = %143
  %192 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %193 = load i32, i32* %41, align 4
  %194 = add i32 %193, %192
  store i32 %194, i32* %41, align 4
  br label %139, !llvm.loop !44

195:                                              ; preds = %139
  br label %196

196:                                              ; preds = %195, %129
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local float @_ZN4vllm14thread_max_vecIN3c104HalfEEEfPKT_lii(%"class.caffe2::TypeMeta"* noalias %0, i64 %1, i32 %2, i32 %3) #18 comdat {
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float, align 4
  %13 = alloca float, align 4
  %14 = alloca float, align 4
  %15 = alloca %"class.caffe2::TypeMeta"*, align 8
  %16 = alloca i64, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca %"struct.vllm::vec4_t.0"*, align 8
  %20 = alloca i32, align 4
  %21 = alloca float, align 4
  %22 = alloca i32, align 4
  %23 = alloca %"struct.vllm::vec4_t.0", align 8
  %24 = alloca i32, align 4
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %15, align 8
  store i64 %1, i64* %16, align 8
  store i32 %2, i32* %17, align 4
  store i32 %3, i32* %18, align 4
  %25 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %15, align 8
  %26 = bitcast %"class.caffe2::TypeMeta"* %25 to %"struct.vllm::vec4_t.0"*
  store %"struct.vllm::vec4_t.0"* %26, %"struct.vllm::vec4_t.0"** %19, align 8
  %27 = load i64, i64* %16, align 8
  %28 = ashr i64 %27, 2
  %29 = trunc i64 %28 to i32
  store i32 %29, i32* %20, align 4
  store float 0.000000e+00, float* %21, align 4
  %30 = load i32, i32* %17, align 4
  store i32 %30, i32* %22, align 4
  br label %31

31:                                               ; preds = %70, %4
  %32 = load i32, i32* %22, align 4
  %33 = load i32, i32* %20, align 4
  %34 = icmp slt i32 %32, %33
  br i1 %34, label %35, label %74

35:                                               ; preds = %31
  %36 = load %"struct.vllm::vec4_t.0"*, %"struct.vllm::vec4_t.0"** %19, align 8
  %37 = load i32, i32* %22, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %36, i64 %38
  %40 = bitcast %"struct.vllm::vec4_t.0"* %23 to i8*
  %41 = bitcast %"struct.vllm::vec4_t.0"* %39 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %40, i8* align 8 %41, i64 8, i1 false)
  %42 = load float, float* %21, align 4
  %43 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %23, i32 0, i32 0
  %44 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %43) #23
  store float %44, float* %10, align 4
  %45 = load float, float* %10, align 4
  store float %45, float* %9, align 4
  %46 = load float, float* %9, align 4
  %47 = call float @llvm.nvvm.fabs.f(float %46) #3
  %48 = call contract float @_ZL3maxff(float %42, float %47) #23
  store float %48, float* %21, align 4
  %49 = load float, float* %21, align 4
  %50 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %23, i32 0, i32 1
  %51 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %50) #23
  store float %51, float* %11, align 4
  %52 = load float, float* %11, align 4
  store float %52, float* %8, align 4
  %53 = load float, float* %8, align 4
  %54 = call float @llvm.nvvm.fabs.f(float %53) #3
  %55 = call contract float @_ZL3maxff(float %49, float %54) #23
  store float %55, float* %21, align 4
  %56 = load float, float* %21, align 4
  %57 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %23, i32 0, i32 2
  %58 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %57) #23
  store float %58, float* %12, align 4
  %59 = load float, float* %12, align 4
  store float %59, float* %7, align 4
  %60 = load float, float* %7, align 4
  %61 = call float @llvm.nvvm.fabs.f(float %60) #3
  %62 = call contract float @_ZL3maxff(float %56, float %61) #23
  store float %62, float* %21, align 4
  %63 = load float, float* %21, align 4
  %64 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %23, i32 0, i32 3
  %65 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %64) #23
  store float %65, float* %13, align 4
  %66 = load float, float* %13, align 4
  store float %66, float* %6, align 4
  %67 = load float, float* %6, align 4
  %68 = call float @llvm.nvvm.fabs.f(float %67) #3
  %69 = call contract float @_ZL3maxff(float %63, float %68) #23
  store float %69, float* %21, align 4
  br label %70

70:                                               ; preds = %35
  %71 = load i32, i32* %18, align 4
  %72 = load i32, i32* %22, align 4
  %73 = add nsw i32 %72, %71
  store i32 %73, i32* %22, align 4
  br label %31, !llvm.loop !45

74:                                               ; preds = %31
  %75 = load i32, i32* %20, align 4
  %76 = mul nsw i32 %75, 4
  %77 = load i32, i32* %17, align 4
  %78 = add nsw i32 %76, %77
  store i32 %78, i32* %24, align 4
  br label %79

79:                                               ; preds = %95, %74
  %80 = load i32, i32* %24, align 4
  %81 = sext i32 %80 to i64
  %82 = load i64, i64* %16, align 8
  %83 = icmp slt i64 %81, %82
  br i1 %83, label %84, label %99

84:                                               ; preds = %79
  %85 = load float, float* %21, align 4
  %86 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %15, align 8
  %87 = load i32, i32* %24, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %86, i64 %88
  %90 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %89) #23
  store float %90, float* %14, align 4
  %91 = load float, float* %14, align 4
  store float %91, float* %5, align 4
  %92 = load float, float* %5, align 4
  %93 = call float @llvm.nvvm.fabs.f(float %92) #3
  %94 = call contract float @_ZL3maxff(float %85, float %93) #23
  store float %94, float* %21, align 4
  br label %95

95:                                               ; preds = %84
  %96 = load i32, i32* %18, align 4
  %97 = load i32, i32* %24, align 4
  %98 = add nsw i32 %97, %96
  store i32 %98, i32* %24, align 4
  br label %79, !llvm.loop !46

99:                                               ; preds = %79
  %100 = load float, float* %21, align 4
  ret float %100
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm25scaled_fp8_conversion_vecIN3c104HalfELb0EEEvPNS1_13Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, float %2, i64 %3, i32 %4, i32 %5) #18 comdat {
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca float, align 4
  %12 = alloca %"class.std::ios_base::Init", align 8
  %13 = alloca double, align 8
  %14 = alloca %"class.std::ios_base::Init", align 8
  %15 = alloca %"class.std::ios_base::Init", align 1
  %16 = alloca float, align 4
  %17 = alloca float, align 4
  %18 = alloca float, align 4
  %19 = alloca float, align 4
  %20 = alloca %"class.std::ios_base::Init", align 1
  %21 = alloca %"class.std::ios_base::Init", align 1
  %22 = alloca %"class.std::ios_base::Init", align 1
  %23 = alloca double, align 8
  %24 = alloca double, align 8
  %25 = alloca double, align 8
  %26 = alloca double, align 8
  %27 = alloca float, align 4
  %28 = alloca %"class.std::ios_base::Init", align 8
  %29 = alloca double, align 8
  %30 = alloca %"class.std::ios_base::Init", align 8
  %31 = alloca %"class.std::ios_base::Init", align 1
  %32 = alloca float, align 4
  %33 = alloca float, align 4
  %34 = alloca float, align 4
  %35 = alloca float, align 4
  %36 = alloca %"class.std::ios_base::Init", align 1
  %37 = alloca %"class.std::ios_base::Init", align 1
  %38 = alloca %"class.std::ios_base::Init", align 1
  %39 = alloca double, align 8
  %40 = alloca double, align 8
  %41 = alloca double, align 8
  %42 = alloca double, align 8
  %43 = alloca float, align 4
  %44 = alloca %"class.std::ios_base::Init", align 8
  %45 = alloca double, align 8
  %46 = alloca %"class.std::ios_base::Init", align 8
  %47 = alloca %"class.std::ios_base::Init", align 1
  %48 = alloca float, align 4
  %49 = alloca float, align 4
  %50 = alloca float, align 4
  %51 = alloca float, align 4
  %52 = alloca %"class.std::ios_base::Init", align 1
  %53 = alloca %"class.std::ios_base::Init", align 1
  %54 = alloca %"class.std::ios_base::Init", align 1
  %55 = alloca double, align 8
  %56 = alloca double, align 8
  %57 = alloca double, align 8
  %58 = alloca double, align 8
  %59 = alloca float, align 4
  %60 = alloca %"class.std::ios_base::Init", align 8
  %61 = alloca double, align 8
  %62 = alloca %"class.std::ios_base::Init", align 8
  %63 = alloca %"class.std::ios_base::Init", align 1
  %64 = alloca float, align 4
  %65 = alloca float, align 4
  %66 = alloca float, align 4
  %67 = alloca float, align 4
  %68 = alloca %"class.std::ios_base::Init", align 1
  %69 = alloca %"class.std::ios_base::Init", align 1
  %70 = alloca %"class.std::ios_base::Init", align 1
  %71 = alloca double, align 8
  %72 = alloca double, align 8
  %73 = alloca double, align 8
  %74 = alloca double, align 8
  %75 = alloca float, align 4
  %76 = alloca %"class.std::ios_base::Init", align 8
  %77 = alloca double, align 8
  %78 = alloca %"class.std::ios_base::Init", align 8
  %79 = alloca %"class.std::ios_base::Init", align 1
  %80 = alloca float, align 4
  %81 = alloca float, align 4
  %82 = alloca float, align 4
  %83 = alloca float, align 4
  %84 = alloca %"class.std::ios_base::Init", align 1
  %85 = alloca %"class.std::ios_base::Init", align 1
  %86 = alloca %"class.std::ios_base::Init", align 1
  %87 = alloca %"class.std::ios_base::Init"*, align 8
  %88 = alloca %"class.caffe2::TypeMeta"*, align 8
  %89 = alloca float, align 4
  %90 = alloca i64, align 8
  %91 = alloca i32, align 4
  %92 = alloca i32, align 4
  %93 = alloca %"struct.vllm::vec4_t.0"*, align 8
  %94 = alloca %"struct.vllm::float8x4_t"*, align 8
  %95 = alloca i32, align 4
  %96 = alloca i32, align 4
  %97 = alloca %"struct.vllm::vec4_t.0", align 8
  %98 = alloca %"struct.vllm::float8x4_t", align 4
  %99 = alloca %"class.std::ios_base::Init", align 1
  %100 = alloca %"class.std::ios_base::Init", align 1
  %101 = alloca %"class.std::ios_base::Init", align 1
  %102 = alloca %"class.std::ios_base::Init", align 1
  %103 = alloca i32, align 4
  %104 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %87, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %88, align 8
  store float %2, float* %89, align 4
  store i64 %3, i64* %90, align 8
  store i32 %4, i32* %91, align 4
  store i32 %5, i32* %92, align 4
  %105 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %88, align 8
  %106 = bitcast %"class.caffe2::TypeMeta"* %105 to %"struct.vllm::vec4_t.0"*
  store %"struct.vllm::vec4_t.0"* %106, %"struct.vllm::vec4_t.0"** %93, align 8
  %107 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %108 = bitcast %"class.std::ios_base::Init"* %107 to %"struct.vllm::float8x4_t"*
  store %"struct.vllm::float8x4_t"* %108, %"struct.vllm::float8x4_t"** %94, align 8
  %109 = load i64, i64* %90, align 8
  %110 = ashr i64 %109, 2
  %111 = trunc i64 %110 to i32
  store i32 %111, i32* %95, align 4
  %112 = load i32, i32* %91, align 4
  store i32 %112, i32* %96, align 4
  br label %113

113:                                              ; preds = %294, %6
  %114 = load i32, i32* %96, align 4
  %115 = load i32, i32* %95, align 4
  %116 = icmp slt i32 %114, %115
  br i1 %116, label %117, label %298

117:                                              ; preds = %113
  %118 = load %"struct.vllm::vec4_t.0"*, %"struct.vllm::vec4_t.0"** %93, align 8
  %119 = load i32, i32* %96, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %118, i64 %120
  %122 = bitcast %"struct.vllm::vec4_t.0"* %97 to i8*
  %123 = bitcast %"struct.vllm::vec4_t.0"* %121 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %122, i8* align 8 %123, i64 8, i1 false)
  %124 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 0
  %125 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %124) #23
  %126 = load float, float* %89, align 4
  store float %125, float* %16, align 4
  store float %126, float* %17, align 4
  store float 0.000000e+00, float* %18, align 4
  %127 = load float, float* %16, align 4
  %128 = load float, float* %17, align 4
  %129 = fdiv contract float %127, %128
  store float %129, float* %18, align 4
  %130 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %131 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %21, i32 0, i32 0
  %132 = extractvalue %"class.std::ios_base::Init" %130, 0
  store i8 %132, i8* %131, align 1
  %133 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %21) #23
  %134 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %20, i32 0, i32 0
  %135 = extractvalue %"class.std::ios_base::Init" %133, 0
  store i8 %135, i8* %134, align 1
  %136 = load float, float* %18, align 4
  %137 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %138 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %22, i32 0, i32 0
  %139 = extractvalue %"class.std::ios_base::Init" %137, 0
  store i8 %139, i8* %138, align 1
  %140 = bitcast %"class.std::ios_base::Init"* %12 to i8*
  %141 = bitcast %"class.std::ios_base::Init"* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %140, i8* align 1 %141, i64 1, i1 false) #3
  store float %136, float* %11, align 4
  %142 = load float, float* %11, align 4
  %143 = fpext float %142 to double
  %144 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %12) #23
  %145 = fpext float %144 to double
  store double %143, double* %7, align 8
  store double %145, double* %8, align 8
  %146 = load double, double* %7, align 8
  %147 = load double, double* %8, align 8
  %148 = call double @llvm.nvvm.fmin.d(double %146, double %147) #3
  %149 = bitcast %"class.std::ios_base::Init"* %14 to i8*
  %150 = bitcast %"class.std::ios_base::Init"* %20 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %149, i8* align 1 %150, i64 1, i1 false) #3
  store double %148, double* %13, align 8
  %151 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %14) #23
  %152 = fpext float %151 to double
  %153 = load double, double* %13, align 8
  store double %152, double* %9, align 8
  store double %153, double* %10, align 8
  %154 = load double, double* %9, align 8
  %155 = load double, double* %10, align 8
  %156 = call double @llvm.nvvm.fmax.d(double %154, double %155) #3
  %157 = fptrunc double %156 to float
  store float %157, float* %19, align 4
  %158 = load float, float* %19, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %15, float %158) #23
  %159 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %15, align 1
  %160 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %99, i32 0, i32 0
  %161 = extractvalue %"class.std::ios_base::Init" %159, 0
  store i8 %161, i8* %160, align 1
  %162 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 0
  %163 = bitcast %"class.std::ios_base::Init"* %162 to i8*
  %164 = bitcast %"class.std::ios_base::Init"* %99 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %163, i8* align 1 %164, i64 1, i1 false)
  %165 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 1
  %166 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %165) #23
  %167 = load float, float* %89, align 4
  store float %166, float* %32, align 4
  store float %167, float* %33, align 4
  store float 0.000000e+00, float* %34, align 4
  %168 = load float, float* %32, align 4
  %169 = load float, float* %33, align 4
  %170 = fdiv contract float %168, %169
  store float %170, float* %34, align 4
  %171 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %172 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %37, i32 0, i32 0
  %173 = extractvalue %"class.std::ios_base::Init" %171, 0
  store i8 %173, i8* %172, align 1
  %174 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %37) #23
  %175 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %36, i32 0, i32 0
  %176 = extractvalue %"class.std::ios_base::Init" %174, 0
  store i8 %176, i8* %175, align 1
  %177 = load float, float* %34, align 4
  %178 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %179 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %38, i32 0, i32 0
  %180 = extractvalue %"class.std::ios_base::Init" %178, 0
  store i8 %180, i8* %179, align 1
  %181 = bitcast %"class.std::ios_base::Init"* %28 to i8*
  %182 = bitcast %"class.std::ios_base::Init"* %38 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %181, i8* align 1 %182, i64 1, i1 false) #3
  store float %177, float* %27, align 4
  %183 = load float, float* %27, align 4
  %184 = fpext float %183 to double
  %185 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %28) #23
  %186 = fpext float %185 to double
  store double %184, double* %23, align 8
  store double %186, double* %24, align 8
  %187 = load double, double* %23, align 8
  %188 = load double, double* %24, align 8
  %189 = call double @llvm.nvvm.fmin.d(double %187, double %188) #3
  %190 = bitcast %"class.std::ios_base::Init"* %30 to i8*
  %191 = bitcast %"class.std::ios_base::Init"* %36 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %190, i8* align 1 %191, i64 1, i1 false) #3
  store double %189, double* %29, align 8
  %192 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %30) #23
  %193 = fpext float %192 to double
  %194 = load double, double* %29, align 8
  store double %193, double* %25, align 8
  store double %194, double* %26, align 8
  %195 = load double, double* %25, align 8
  %196 = load double, double* %26, align 8
  %197 = call double @llvm.nvvm.fmax.d(double %195, double %196) #3
  %198 = fptrunc double %197 to float
  store float %198, float* %35, align 4
  %199 = load float, float* %35, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %31, float %199) #23
  %200 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %31, align 1
  %201 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %100, i32 0, i32 0
  %202 = extractvalue %"class.std::ios_base::Init" %200, 0
  store i8 %202, i8* %201, align 1
  %203 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 1
  %204 = bitcast %"class.std::ios_base::Init"* %203 to i8*
  %205 = bitcast %"class.std::ios_base::Init"* %100 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %204, i8* align 1 %205, i64 1, i1 false)
  %206 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 2
  %207 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %206) #23
  %208 = load float, float* %89, align 4
  store float %207, float* %48, align 4
  store float %208, float* %49, align 4
  store float 0.000000e+00, float* %50, align 4
  %209 = load float, float* %48, align 4
  %210 = load float, float* %49, align 4
  %211 = fdiv contract float %209, %210
  store float %211, float* %50, align 4
  %212 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %213 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %53, i32 0, i32 0
  %214 = extractvalue %"class.std::ios_base::Init" %212, 0
  store i8 %214, i8* %213, align 1
  %215 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %53) #23
  %216 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %52, i32 0, i32 0
  %217 = extractvalue %"class.std::ios_base::Init" %215, 0
  store i8 %217, i8* %216, align 1
  %218 = load float, float* %50, align 4
  %219 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %220 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %54, i32 0, i32 0
  %221 = extractvalue %"class.std::ios_base::Init" %219, 0
  store i8 %221, i8* %220, align 1
  %222 = bitcast %"class.std::ios_base::Init"* %44 to i8*
  %223 = bitcast %"class.std::ios_base::Init"* %54 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %222, i8* align 1 %223, i64 1, i1 false) #3
  store float %218, float* %43, align 4
  %224 = load float, float* %43, align 4
  %225 = fpext float %224 to double
  %226 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %44) #23
  %227 = fpext float %226 to double
  store double %225, double* %39, align 8
  store double %227, double* %40, align 8
  %228 = load double, double* %39, align 8
  %229 = load double, double* %40, align 8
  %230 = call double @llvm.nvvm.fmin.d(double %228, double %229) #3
  %231 = bitcast %"class.std::ios_base::Init"* %46 to i8*
  %232 = bitcast %"class.std::ios_base::Init"* %52 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %231, i8* align 1 %232, i64 1, i1 false) #3
  store double %230, double* %45, align 8
  %233 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %46) #23
  %234 = fpext float %233 to double
  %235 = load double, double* %45, align 8
  store double %234, double* %41, align 8
  store double %235, double* %42, align 8
  %236 = load double, double* %41, align 8
  %237 = load double, double* %42, align 8
  %238 = call double @llvm.nvvm.fmax.d(double %236, double %237) #3
  %239 = fptrunc double %238 to float
  store float %239, float* %51, align 4
  %240 = load float, float* %51, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %47, float %240) #23
  %241 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %47, align 1
  %242 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %101, i32 0, i32 0
  %243 = extractvalue %"class.std::ios_base::Init" %241, 0
  store i8 %243, i8* %242, align 1
  %244 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 2
  %245 = bitcast %"class.std::ios_base::Init"* %244 to i8*
  %246 = bitcast %"class.std::ios_base::Init"* %101 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %245, i8* align 1 %246, i64 1, i1 false)
  %247 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 3
  %248 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %247) #23
  %249 = load float, float* %89, align 4
  store float %248, float* %64, align 4
  store float %249, float* %65, align 4
  store float 0.000000e+00, float* %66, align 4
  %250 = load float, float* %64, align 4
  %251 = load float, float* %65, align 4
  %252 = fdiv contract float %250, %251
  store float %252, float* %66, align 4
  %253 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %254 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %69, i32 0, i32 0
  %255 = extractvalue %"class.std::ios_base::Init" %253, 0
  store i8 %255, i8* %254, align 1
  %256 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %69) #23
  %257 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %68, i32 0, i32 0
  %258 = extractvalue %"class.std::ios_base::Init" %256, 0
  store i8 %258, i8* %257, align 1
  %259 = load float, float* %66, align 4
  %260 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %261 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %70, i32 0, i32 0
  %262 = extractvalue %"class.std::ios_base::Init" %260, 0
  store i8 %262, i8* %261, align 1
  %263 = bitcast %"class.std::ios_base::Init"* %60 to i8*
  %264 = bitcast %"class.std::ios_base::Init"* %70 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %263, i8* align 1 %264, i64 1, i1 false) #3
  store float %259, float* %59, align 4
  %265 = load float, float* %59, align 4
  %266 = fpext float %265 to double
  %267 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %60) #23
  %268 = fpext float %267 to double
  store double %266, double* %55, align 8
  store double %268, double* %56, align 8
  %269 = load double, double* %55, align 8
  %270 = load double, double* %56, align 8
  %271 = call double @llvm.nvvm.fmin.d(double %269, double %270) #3
  %272 = bitcast %"class.std::ios_base::Init"* %62 to i8*
  %273 = bitcast %"class.std::ios_base::Init"* %68 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %272, i8* align 1 %273, i64 1, i1 false) #3
  store double %271, double* %61, align 8
  %274 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %62) #23
  %275 = fpext float %274 to double
  %276 = load double, double* %61, align 8
  store double %275, double* %57, align 8
  store double %276, double* %58, align 8
  %277 = load double, double* %57, align 8
  %278 = load double, double* %58, align 8
  %279 = call double @llvm.nvvm.fmax.d(double %277, double %278) #3
  %280 = fptrunc double %279 to float
  store float %280, float* %67, align 4
  %281 = load float, float* %67, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %63, float %281) #23
  %282 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %63, align 1
  %283 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %102, i32 0, i32 0
  %284 = extractvalue %"class.std::ios_base::Init" %282, 0
  store i8 %284, i8* %283, align 1
  %285 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 3
  %286 = bitcast %"class.std::ios_base::Init"* %285 to i8*
  %287 = bitcast %"class.std::ios_base::Init"* %102 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %286, i8* align 1 %287, i64 1, i1 false)
  %288 = load %"struct.vllm::float8x4_t"*, %"struct.vllm::float8x4_t"** %94, align 8
  %289 = load i32, i32* %96, align 4
  %290 = sext i32 %289 to i64
  %291 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %288, i64 %290
  %292 = bitcast %"struct.vllm::float8x4_t"* %291 to i8*
  %293 = bitcast %"struct.vllm::float8x4_t"* %98 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %292, i8* align 4 %293, i64 4, i1 false)
  br label %294

294:                                              ; preds = %117
  %295 = load i32, i32* %92, align 4
  %296 = load i32, i32* %96, align 4
  %297 = add nsw i32 %296, %295
  store i32 %297, i32* %96, align 4
  br label %113, !llvm.loop !47

298:                                              ; preds = %113
  %299 = load i32, i32* %95, align 4
  %300 = mul nsw i32 %299, 4
  %301 = load i32, i32* %91, align 4
  %302 = add nsw i32 %300, %301
  store i32 %302, i32* %103, align 4
  br label %303

303:                                              ; preds = %356, %298
  %304 = load i32, i32* %103, align 4
  %305 = sext i32 %304 to i64
  %306 = load i64, i64* %90, align 8
  %307 = icmp slt i64 %305, %306
  br i1 %307, label %308, label %360

308:                                              ; preds = %303
  %309 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %88, align 8
  %310 = load i32, i32* %103, align 4
  %311 = sext i32 %310 to i64
  %312 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %309, i64 %311
  %313 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %312) #23
  %314 = load float, float* %89, align 4
  store float %313, float* %80, align 4
  store float %314, float* %81, align 4
  store float 0.000000e+00, float* %82, align 4
  %315 = load float, float* %80, align 4
  %316 = load float, float* %81, align 4
  %317 = fdiv contract float %315, %316
  store float %317, float* %82, align 4
  %318 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %319 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %85, i32 0, i32 0
  %320 = extractvalue %"class.std::ios_base::Init" %318, 0
  store i8 %320, i8* %319, align 1
  %321 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %85) #23
  %322 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %84, i32 0, i32 0
  %323 = extractvalue %"class.std::ios_base::Init" %321, 0
  store i8 %323, i8* %322, align 1
  %324 = load float, float* %82, align 4
  %325 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %326 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %86, i32 0, i32 0
  %327 = extractvalue %"class.std::ios_base::Init" %325, 0
  store i8 %327, i8* %326, align 1
  %328 = bitcast %"class.std::ios_base::Init"* %76 to i8*
  %329 = bitcast %"class.std::ios_base::Init"* %86 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %328, i8* align 1 %329, i64 1, i1 false) #3
  store float %324, float* %75, align 4
  %330 = load float, float* %75, align 4
  %331 = fpext float %330 to double
  %332 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %76) #23
  %333 = fpext float %332 to double
  store double %331, double* %71, align 8
  store double %333, double* %72, align 8
  %334 = load double, double* %71, align 8
  %335 = load double, double* %72, align 8
  %336 = call double @llvm.nvvm.fmin.d(double %334, double %335) #3
  %337 = bitcast %"class.std::ios_base::Init"* %78 to i8*
  %338 = bitcast %"class.std::ios_base::Init"* %84 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %337, i8* align 1 %338, i64 1, i1 false) #3
  store double %336, double* %77, align 8
  %339 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %78) #23
  %340 = fpext float %339 to double
  %341 = load double, double* %77, align 8
  store double %340, double* %73, align 8
  store double %341, double* %74, align 8
  %342 = load double, double* %73, align 8
  %343 = load double, double* %74, align 8
  %344 = call double @llvm.nvvm.fmax.d(double %342, double %343) #3
  %345 = fptrunc double %344 to float
  store float %345, float* %83, align 4
  %346 = load float, float* %83, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %79, float %346) #23
  %347 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %79, align 1
  %348 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %104, i32 0, i32 0
  %349 = extractvalue %"class.std::ios_base::Init" %347, 0
  store i8 %349, i8* %348, align 1
  %350 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %351 = load i32, i32* %103, align 4
  %352 = sext i32 %351 to i64
  %353 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %350, i64 %352
  %354 = bitcast %"class.std::ios_base::Init"* %353 to i8*
  %355 = bitcast %"class.std::ios_base::Init"* %104 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %354, i8* align 1 %355, i64 1, i1 false)
  br label %356

356:                                              ; preds = %308
  %357 = load i32, i32* %92, align 4
  %358 = load i32, i32* %103, align 4
  %359 = add nsw i32 %358, %357
  store i32 %359, i32* %103, align 4
  br label %303, !llvm.loop !48

360:                                              ; preds = %303
  ret void
}

; Function Attrs: convergent noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfi(%"class.std::ios_base::Init"* noalias %0, float* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, float* noalias %3, i32 %4) #22 {
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca float, align 4
  %11 = alloca %"class.std::ios_base::Init", align 8
  %12 = alloca double, align 8
  %13 = alloca %"class.std::ios_base::Init", align 8
  %14 = alloca %"class.std::ios_base::Init", align 1
  %15 = alloca float, align 4
  %16 = alloca float, align 4
  %17 = alloca float, align 4
  %18 = alloca float, align 4
  %19 = alloca %"class.std::ios_base::Init", align 1
  %20 = alloca %"class.std::ios_base::Init", align 1
  %21 = alloca %"class.std::ios_base::Init", align 1
  %22 = alloca float, align 4
  %23 = alloca float, align 4
  %24 = alloca %"class.std::ios_base::Init"*, align 8
  %25 = alloca float*, align 8
  %26 = alloca %"class.caffe2::TypeMeta"*, align 8
  %27 = alloca float*, align 8
  %28 = alloca i32, align 4
  %29 = alloca float, align 4
  %30 = alloca %"class.std::ios_base::Init", align 1
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca %"class.caffe2::TypeMeta"*, align 8
  %34 = alloca %"class.std::ios_base::Init"*, align 8
  %35 = alloca i8, align 1
  %36 = alloca float, align 4
  %37 = alloca i32, align 4
  %38 = alloca float, align 4
  %39 = alloca float, align 4
  %40 = alloca %"class.std::ios_base::Init", align 1
  %41 = alloca i32, align 4
  %42 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %24, align 8
  store float* %1, float** %25, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %26, align 8
  store float* %3, float** %27, align 8
  store i32 %4, i32* %28, align 4
  %43 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %44 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %30, i32 0, i32 0
  %45 = extractvalue %"class.std::ios_base::Init" %43, 0
  store i8 %45, i8* %44, align 1
  %46 = call contract float @_ZN3c10mlENS_13Float8_e4m3fnEf(%"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %30, float 5.120000e+02) #23
  %47 = fdiv contract float 1.000000e+00, %46
  store float %47, float* %29, align 4
  %48 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %48, i32* %31, align 4
  %49 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  store i32 %49, i32* %32, align 4
  %50 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %26, align 8
  %51 = load i32, i32* %32, align 4
  %52 = load i32, i32* %28, align 4
  %53 = mul nsw i32 %51, %52
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %50, i64 %54
  store %"class.caffe2::TypeMeta"* %55, %"class.caffe2::TypeMeta"** %33, align 8
  %56 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %24, align 8
  %57 = load i32, i32* %32, align 4
  %58 = load i32, i32* %28, align 4
  %59 = mul nsw i32 %57, %58
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %56, i64 %60
  store %"class.std::ios_base::Init"* %61, %"class.std::ios_base::Init"** %34, align 8
  %62 = load i32, i32* %28, align 4
  %63 = srem i32 %62, 4
  %64 = icmp eq i32 %63, 0
  %65 = zext i1 %64 to i8
  store i8 %65, i8* %35, align 1
  store float 0.000000e+00, float* %36, align 4
  %66 = load i8, i8* %35, align 1
  %67 = trunc i8 %66 to i1
  br i1 %67, label %68, label %75

68:                                               ; preds = %5
  %69 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %33, align 8
  %70 = load i32, i32* %28, align 4
  %71 = sext i32 %70 to i64
  %72 = load i32, i32* %31, align 4
  %73 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %74 = call contract float @_ZN4vllm14thread_max_vecIN3c108BFloat16EEEfPKT_lii(%"class.caffe2::TypeMeta"* %69, i64 %71, i32 %72, i32 %73) #23
  store float %74, float* %36, align 4
  br label %98

75:                                               ; preds = %5
  %76 = load i32, i32* %31, align 4
  store i32 %76, i32* %37, align 4
  br label %77

77:                                               ; preds = %93, %75
  %78 = load i32, i32* %37, align 4
  %79 = load i32, i32* %28, align 4
  %80 = icmp slt i32 %78, %79
  br i1 %80, label %81, label %97

81:                                               ; preds = %77
  %82 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %33, align 8
  %83 = load i32, i32* %37, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %82, i64 %84
  %86 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %85) #23
  store float %86, float* %38, align 4
  %87 = load float, float* %36, align 4
  %88 = load float, float* %38, align 4
  store float %88, float* %23, align 4
  %89 = load float, float* %23, align 4
  store float %89, float* %22, align 4
  %90 = load float, float* %22, align 4
  %91 = call float @llvm.nvvm.fabs.f(float %90) #3
  %92 = call contract float @_ZL3maxff(float %87, float %91) #23
  store float %92, float* %36, align 4
  br label %93

93:                                               ; preds = %81
  %94 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %95 = load i32, i32* %37, align 4
  %96 = add i32 %95, %94
  store i32 %96, i32* %37, align 4
  br label %77, !llvm.loop !49

97:                                               ; preds = %77
  br label %98

98:                                               ; preds = %97, %68
  %99 = load float, float* %36, align 4
  %100 = call contract float @_ZN4vllm14blockReduceMaxIfLi1024EEET_S1_(float %99) #23
  store float %100, float* %39, align 4
  %101 = load i32, i32* %31, align 4
  %102 = icmp eq i32 %101, 0
  br i1 %102, label %103, label %126

103:                                              ; preds = %98
  %104 = load float*, float** %27, align 8
  %105 = icmp ne float* %104, null
  br i1 %105, label %106, label %111

106:                                              ; preds = %103
  %107 = load float, float* %39, align 4
  %108 = load float*, float** %27, align 8
  %109 = load float, float* %108, align 4
  %110 = call contract float @_ZL3minff(float %107, float %109) #23
  store float %110, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  br label %113

111:                                              ; preds = %103
  %112 = load float, float* %39, align 4
  store float %112, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  br label %113

113:                                              ; preds = %111, %106
  %114 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %115 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %116 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %40, i32 0, i32 0
  %117 = extractvalue %"class.std::ios_base::Init" %115, 0
  store i8 %117, i8* %116, align 1
  %118 = call contract float @_ZN3c10dvEfNS_13Float8_e4m3fnE(float %114, %"class.std::ios_base::Init"* byval(%"class.std::ios_base::Init") align 1 %40) #23
  %119 = load float, float* %29, align 4
  %120 = call contract float @_ZL3maxff(float %118, float %119) #23
  store float %120, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %121 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %122 = load float*, float** %25, align 8
  %123 = load i32, i32* %32, align 4
  %124 = sext i32 %123 to i64
  %125 = getelementptr inbounds float, float* %122, i64 %124
  store float %121, float* %125, align 4
  br label %126

126:                                              ; preds = %113, %98
  call void @llvm.nvvm.barrier0()
  %127 = load i8, i8* %35, align 1
  %128 = trunc i8 %127 to i1
  br i1 %128, label %129, label %137

129:                                              ; preds = %126
  %130 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %34, align 8
  %131 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %33, align 8
  %132 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  %133 = load i32, i32* %28, align 4
  %134 = sext i32 %133 to i64
  %135 = load i32, i32* %31, align 4
  %136 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  call void @_ZN4vllm25scaled_fp8_conversion_vecIN3c108BFloat16ELb0EEEvPNS1_13Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* %130, %"class.caffe2::TypeMeta"* %131, float %132, i64 %134, i32 %135, i32 %136) #23
  br label %196

137:                                              ; preds = %126
  %138 = load i32, i32* %31, align 4
  store i32 %138, i32* %41, align 4
  br label %139

139:                                              ; preds = %191, %137
  %140 = load i32, i32* %41, align 4
  %141 = load i32, i32* %28, align 4
  %142 = icmp slt i32 %140, %141
  br i1 %142, label %143, label %195

143:                                              ; preds = %139
  %144 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %33, align 8
  %145 = load i32, i32* %41, align 4
  %146 = sext i32 %145 to i64
  %147 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %144, i64 %146
  %148 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %147) #23
  %149 = load float, float* addrspacecast (float addrspace(3)* @_ZZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfiE11token_scale to float*), align 4
  store float %148, float* %15, align 4
  store float %149, float* %16, align 4
  store float 0.000000e+00, float* %17, align 4
  %150 = load float, float* %15, align 4
  %151 = load float, float* %16, align 4
  %152 = fdiv contract float %150, %151
  store float %152, float* %17, align 4
  %153 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %154 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %20, i32 0, i32 0
  %155 = extractvalue %"class.std::ios_base::Init" %153, 0
  store i8 %155, i8* %154, align 1
  %156 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %20) #23
  %157 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %19, i32 0, i32 0
  %158 = extractvalue %"class.std::ios_base::Init" %156, 0
  store i8 %158, i8* %157, align 1
  %159 = load float, float* %17, align 4
  %160 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %161 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %21, i32 0, i32 0
  %162 = extractvalue %"class.std::ios_base::Init" %160, 0
  store i8 %162, i8* %161, align 1
  %163 = bitcast %"class.std::ios_base::Init"* %11 to i8*
  %164 = bitcast %"class.std::ios_base::Init"* %21 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %163, i8* align 1 %164, i64 1, i1 false) #3
  store float %159, float* %10, align 4
  %165 = load float, float* %10, align 4
  %166 = fpext float %165 to double
  %167 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %11) #23
  %168 = fpext float %167 to double
  store double %166, double* %6, align 8
  store double %168, double* %7, align 8
  %169 = load double, double* %6, align 8
  %170 = load double, double* %7, align 8
  %171 = call double @llvm.nvvm.fmin.d(double %169, double %170) #3
  %172 = bitcast %"class.std::ios_base::Init"* %13 to i8*
  %173 = bitcast %"class.std::ios_base::Init"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %172, i8* align 1 %173, i64 1, i1 false) #3
  store double %171, double* %12, align 8
  %174 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %13) #23
  %175 = fpext float %174 to double
  %176 = load double, double* %12, align 8
  store double %175, double* %8, align 8
  store double %176, double* %9, align 8
  %177 = load double, double* %8, align 8
  %178 = load double, double* %9, align 8
  %179 = call double @llvm.nvvm.fmax.d(double %177, double %178) #3
  %180 = fptrunc double %179 to float
  store float %180, float* %18, align 4
  %181 = load float, float* %18, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %14, float %181) #23
  %182 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %14, align 1
  %183 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %42, i32 0, i32 0
  %184 = extractvalue %"class.std::ios_base::Init" %182, 0
  store i8 %184, i8* %183, align 1
  %185 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %34, align 8
  %186 = load i32, i32* %41, align 4
  %187 = sext i32 %186 to i64
  %188 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %185, i64 %187
  %189 = bitcast %"class.std::ios_base::Init"* %188 to i8*
  %190 = bitcast %"class.std::ios_base::Init"* %42 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %189, i8* align 1 %190, i64 1, i1 false)
  br label %191

191:                                              ; preds = %143
  %192 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %193 = load i32, i32* %41, align 4
  %194 = add i32 %193, %192
  store i32 %194, i32* %41, align 4
  br label %139, !llvm.loop !50

195:                                              ; preds = %139
  br label %196

196:                                              ; preds = %195, %129
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local float @_ZN4vllm14thread_max_vecIN3c108BFloat16EEEfPKT_lii(%"class.caffe2::TypeMeta"* noalias %0, i64 %1, i32 %2, i32 %3) #18 comdat {
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float, align 4
  %13 = alloca float, align 4
  %14 = alloca float, align 4
  %15 = alloca %"class.caffe2::TypeMeta"*, align 8
  %16 = alloca i64, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca %"struct.vllm::vec4_t.0"*, align 8
  %20 = alloca i32, align 4
  %21 = alloca float, align 4
  %22 = alloca i32, align 4
  %23 = alloca %"struct.vllm::vec4_t.0", align 8
  %24 = alloca i32, align 4
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %15, align 8
  store i64 %1, i64* %16, align 8
  store i32 %2, i32* %17, align 4
  store i32 %3, i32* %18, align 4
  %25 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %15, align 8
  %26 = bitcast %"class.caffe2::TypeMeta"* %25 to %"struct.vllm::vec4_t.0"*
  store %"struct.vllm::vec4_t.0"* %26, %"struct.vllm::vec4_t.0"** %19, align 8
  %27 = load i64, i64* %16, align 8
  %28 = ashr i64 %27, 2
  %29 = trunc i64 %28 to i32
  store i32 %29, i32* %20, align 4
  store float 0.000000e+00, float* %21, align 4
  %30 = load i32, i32* %17, align 4
  store i32 %30, i32* %22, align 4
  br label %31

31:                                               ; preds = %70, %4
  %32 = load i32, i32* %22, align 4
  %33 = load i32, i32* %20, align 4
  %34 = icmp slt i32 %32, %33
  br i1 %34, label %35, label %74

35:                                               ; preds = %31
  %36 = load %"struct.vllm::vec4_t.0"*, %"struct.vllm::vec4_t.0"** %19, align 8
  %37 = load i32, i32* %22, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %36, i64 %38
  %40 = bitcast %"struct.vllm::vec4_t.0"* %23 to i8*
  %41 = bitcast %"struct.vllm::vec4_t.0"* %39 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %40, i8* align 8 %41, i64 8, i1 false)
  %42 = load float, float* %21, align 4
  %43 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %23, i32 0, i32 0
  %44 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %43) #23
  store float %44, float* %10, align 4
  %45 = load float, float* %10, align 4
  store float %45, float* %9, align 4
  %46 = load float, float* %9, align 4
  %47 = call float @llvm.nvvm.fabs.f(float %46) #3
  %48 = call contract float @_ZL3maxff(float %42, float %47) #23
  store float %48, float* %21, align 4
  %49 = load float, float* %21, align 4
  %50 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %23, i32 0, i32 1
  %51 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %50) #23
  store float %51, float* %11, align 4
  %52 = load float, float* %11, align 4
  store float %52, float* %8, align 4
  %53 = load float, float* %8, align 4
  %54 = call float @llvm.nvvm.fabs.f(float %53) #3
  %55 = call contract float @_ZL3maxff(float %49, float %54) #23
  store float %55, float* %21, align 4
  %56 = load float, float* %21, align 4
  %57 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %23, i32 0, i32 2
  %58 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %57) #23
  store float %58, float* %12, align 4
  %59 = load float, float* %12, align 4
  store float %59, float* %7, align 4
  %60 = load float, float* %7, align 4
  %61 = call float @llvm.nvvm.fabs.f(float %60) #3
  %62 = call contract float @_ZL3maxff(float %56, float %61) #23
  store float %62, float* %21, align 4
  %63 = load float, float* %21, align 4
  %64 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %23, i32 0, i32 3
  %65 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %64) #23
  store float %65, float* %13, align 4
  %66 = load float, float* %13, align 4
  store float %66, float* %6, align 4
  %67 = load float, float* %6, align 4
  %68 = call float @llvm.nvvm.fabs.f(float %67) #3
  %69 = call contract float @_ZL3maxff(float %63, float %68) #23
  store float %69, float* %21, align 4
  br label %70

70:                                               ; preds = %35
  %71 = load i32, i32* %18, align 4
  %72 = load i32, i32* %22, align 4
  %73 = add nsw i32 %72, %71
  store i32 %73, i32* %22, align 4
  br label %31, !llvm.loop !51

74:                                               ; preds = %31
  %75 = load i32, i32* %20, align 4
  %76 = mul nsw i32 %75, 4
  %77 = load i32, i32* %17, align 4
  %78 = add nsw i32 %76, %77
  store i32 %78, i32* %24, align 4
  br label %79

79:                                               ; preds = %95, %74
  %80 = load i32, i32* %24, align 4
  %81 = sext i32 %80 to i64
  %82 = load i64, i64* %16, align 8
  %83 = icmp slt i64 %81, %82
  br i1 %83, label %84, label %99

84:                                               ; preds = %79
  %85 = load float, float* %21, align 4
  %86 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %15, align 8
  %87 = load i32, i32* %24, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %86, i64 %88
  %90 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %89) #23
  store float %90, float* %14, align 4
  %91 = load float, float* %14, align 4
  store float %91, float* %5, align 4
  %92 = load float, float* %5, align 4
  %93 = call float @llvm.nvvm.fabs.f(float %92) #3
  %94 = call contract float @_ZL3maxff(float %85, float %93) #23
  store float %94, float* %21, align 4
  br label %95

95:                                               ; preds = %84
  %96 = load i32, i32* %18, align 4
  %97 = load i32, i32* %24, align 4
  %98 = add nsw i32 %97, %96
  store i32 %98, i32* %24, align 4
  br label %79, !llvm.loop !52

99:                                               ; preds = %79
  %100 = load float, float* %21, align 4
  ret float %100
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm25scaled_fp8_conversion_vecIN3c108BFloat16ELb0EEEvPNS1_13Float8_e4m3fnEPKT_flii(%"class.std::ios_base::Init"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, float %2, i64 %3, i32 %4, i32 %5) #18 comdat {
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca float, align 4
  %12 = alloca %"class.std::ios_base::Init", align 8
  %13 = alloca double, align 8
  %14 = alloca %"class.std::ios_base::Init", align 8
  %15 = alloca %"class.std::ios_base::Init", align 1
  %16 = alloca float, align 4
  %17 = alloca float, align 4
  %18 = alloca float, align 4
  %19 = alloca float, align 4
  %20 = alloca %"class.std::ios_base::Init", align 1
  %21 = alloca %"class.std::ios_base::Init", align 1
  %22 = alloca %"class.std::ios_base::Init", align 1
  %23 = alloca double, align 8
  %24 = alloca double, align 8
  %25 = alloca double, align 8
  %26 = alloca double, align 8
  %27 = alloca float, align 4
  %28 = alloca %"class.std::ios_base::Init", align 8
  %29 = alloca double, align 8
  %30 = alloca %"class.std::ios_base::Init", align 8
  %31 = alloca %"class.std::ios_base::Init", align 1
  %32 = alloca float, align 4
  %33 = alloca float, align 4
  %34 = alloca float, align 4
  %35 = alloca float, align 4
  %36 = alloca %"class.std::ios_base::Init", align 1
  %37 = alloca %"class.std::ios_base::Init", align 1
  %38 = alloca %"class.std::ios_base::Init", align 1
  %39 = alloca double, align 8
  %40 = alloca double, align 8
  %41 = alloca double, align 8
  %42 = alloca double, align 8
  %43 = alloca float, align 4
  %44 = alloca %"class.std::ios_base::Init", align 8
  %45 = alloca double, align 8
  %46 = alloca %"class.std::ios_base::Init", align 8
  %47 = alloca %"class.std::ios_base::Init", align 1
  %48 = alloca float, align 4
  %49 = alloca float, align 4
  %50 = alloca float, align 4
  %51 = alloca float, align 4
  %52 = alloca %"class.std::ios_base::Init", align 1
  %53 = alloca %"class.std::ios_base::Init", align 1
  %54 = alloca %"class.std::ios_base::Init", align 1
  %55 = alloca double, align 8
  %56 = alloca double, align 8
  %57 = alloca double, align 8
  %58 = alloca double, align 8
  %59 = alloca float, align 4
  %60 = alloca %"class.std::ios_base::Init", align 8
  %61 = alloca double, align 8
  %62 = alloca %"class.std::ios_base::Init", align 8
  %63 = alloca %"class.std::ios_base::Init", align 1
  %64 = alloca float, align 4
  %65 = alloca float, align 4
  %66 = alloca float, align 4
  %67 = alloca float, align 4
  %68 = alloca %"class.std::ios_base::Init", align 1
  %69 = alloca %"class.std::ios_base::Init", align 1
  %70 = alloca %"class.std::ios_base::Init", align 1
  %71 = alloca double, align 8
  %72 = alloca double, align 8
  %73 = alloca double, align 8
  %74 = alloca double, align 8
  %75 = alloca float, align 4
  %76 = alloca %"class.std::ios_base::Init", align 8
  %77 = alloca double, align 8
  %78 = alloca %"class.std::ios_base::Init", align 8
  %79 = alloca %"class.std::ios_base::Init", align 1
  %80 = alloca float, align 4
  %81 = alloca float, align 4
  %82 = alloca float, align 4
  %83 = alloca float, align 4
  %84 = alloca %"class.std::ios_base::Init", align 1
  %85 = alloca %"class.std::ios_base::Init", align 1
  %86 = alloca %"class.std::ios_base::Init", align 1
  %87 = alloca %"class.std::ios_base::Init"*, align 8
  %88 = alloca %"class.caffe2::TypeMeta"*, align 8
  %89 = alloca float, align 4
  %90 = alloca i64, align 8
  %91 = alloca i32, align 4
  %92 = alloca i32, align 4
  %93 = alloca %"struct.vllm::vec4_t.0"*, align 8
  %94 = alloca %"struct.vllm::float8x4_t"*, align 8
  %95 = alloca i32, align 4
  %96 = alloca i32, align 4
  %97 = alloca %"struct.vllm::vec4_t.0", align 8
  %98 = alloca %"struct.vllm::float8x4_t", align 4
  %99 = alloca %"class.std::ios_base::Init", align 1
  %100 = alloca %"class.std::ios_base::Init", align 1
  %101 = alloca %"class.std::ios_base::Init", align 1
  %102 = alloca %"class.std::ios_base::Init", align 1
  %103 = alloca i32, align 4
  %104 = alloca %"class.std::ios_base::Init", align 1
  store %"class.std::ios_base::Init"* %0, %"class.std::ios_base::Init"** %87, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %88, align 8
  store float %2, float* %89, align 4
  store i64 %3, i64* %90, align 8
  store i32 %4, i32* %91, align 4
  store i32 %5, i32* %92, align 4
  %105 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %88, align 8
  %106 = bitcast %"class.caffe2::TypeMeta"* %105 to %"struct.vllm::vec4_t.0"*
  store %"struct.vllm::vec4_t.0"* %106, %"struct.vllm::vec4_t.0"** %93, align 8
  %107 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %108 = bitcast %"class.std::ios_base::Init"* %107 to %"struct.vllm::float8x4_t"*
  store %"struct.vllm::float8x4_t"* %108, %"struct.vllm::float8x4_t"** %94, align 8
  %109 = load i64, i64* %90, align 8
  %110 = ashr i64 %109, 2
  %111 = trunc i64 %110 to i32
  store i32 %111, i32* %95, align 4
  %112 = load i32, i32* %91, align 4
  store i32 %112, i32* %96, align 4
  br label %113

113:                                              ; preds = %294, %6
  %114 = load i32, i32* %96, align 4
  %115 = load i32, i32* %95, align 4
  %116 = icmp slt i32 %114, %115
  br i1 %116, label %117, label %298

117:                                              ; preds = %113
  %118 = load %"struct.vllm::vec4_t.0"*, %"struct.vllm::vec4_t.0"** %93, align 8
  %119 = load i32, i32* %96, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %118, i64 %120
  %122 = bitcast %"struct.vllm::vec4_t.0"* %97 to i8*
  %123 = bitcast %"struct.vllm::vec4_t.0"* %121 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %122, i8* align 8 %123, i64 8, i1 false)
  %124 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 0
  %125 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %124) #23
  %126 = load float, float* %89, align 4
  store float %125, float* %16, align 4
  store float %126, float* %17, align 4
  store float 0.000000e+00, float* %18, align 4
  %127 = load float, float* %16, align 4
  %128 = load float, float* %17, align 4
  %129 = fdiv contract float %127, %128
  store float %129, float* %18, align 4
  %130 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %131 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %21, i32 0, i32 0
  %132 = extractvalue %"class.std::ios_base::Init" %130, 0
  store i8 %132, i8* %131, align 1
  %133 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %21) #23
  %134 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %20, i32 0, i32 0
  %135 = extractvalue %"class.std::ios_base::Init" %133, 0
  store i8 %135, i8* %134, align 1
  %136 = load float, float* %18, align 4
  %137 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %138 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %22, i32 0, i32 0
  %139 = extractvalue %"class.std::ios_base::Init" %137, 0
  store i8 %139, i8* %138, align 1
  %140 = bitcast %"class.std::ios_base::Init"* %12 to i8*
  %141 = bitcast %"class.std::ios_base::Init"* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %140, i8* align 1 %141, i64 1, i1 false) #3
  store float %136, float* %11, align 4
  %142 = load float, float* %11, align 4
  %143 = fpext float %142 to double
  %144 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %12) #23
  %145 = fpext float %144 to double
  store double %143, double* %7, align 8
  store double %145, double* %8, align 8
  %146 = load double, double* %7, align 8
  %147 = load double, double* %8, align 8
  %148 = call double @llvm.nvvm.fmin.d(double %146, double %147) #3
  %149 = bitcast %"class.std::ios_base::Init"* %14 to i8*
  %150 = bitcast %"class.std::ios_base::Init"* %20 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %149, i8* align 1 %150, i64 1, i1 false) #3
  store double %148, double* %13, align 8
  %151 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %14) #23
  %152 = fpext float %151 to double
  %153 = load double, double* %13, align 8
  store double %152, double* %9, align 8
  store double %153, double* %10, align 8
  %154 = load double, double* %9, align 8
  %155 = load double, double* %10, align 8
  %156 = call double @llvm.nvvm.fmax.d(double %154, double %155) #3
  %157 = fptrunc double %156 to float
  store float %157, float* %19, align 4
  %158 = load float, float* %19, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %15, float %158) #23
  %159 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %15, align 1
  %160 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %99, i32 0, i32 0
  %161 = extractvalue %"class.std::ios_base::Init" %159, 0
  store i8 %161, i8* %160, align 1
  %162 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 0
  %163 = bitcast %"class.std::ios_base::Init"* %162 to i8*
  %164 = bitcast %"class.std::ios_base::Init"* %99 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %163, i8* align 1 %164, i64 1, i1 false)
  %165 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 1
  %166 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %165) #23
  %167 = load float, float* %89, align 4
  store float %166, float* %32, align 4
  store float %167, float* %33, align 4
  store float 0.000000e+00, float* %34, align 4
  %168 = load float, float* %32, align 4
  %169 = load float, float* %33, align 4
  %170 = fdiv contract float %168, %169
  store float %170, float* %34, align 4
  %171 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %172 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %37, i32 0, i32 0
  %173 = extractvalue %"class.std::ios_base::Init" %171, 0
  store i8 %173, i8* %172, align 1
  %174 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %37) #23
  %175 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %36, i32 0, i32 0
  %176 = extractvalue %"class.std::ios_base::Init" %174, 0
  store i8 %176, i8* %175, align 1
  %177 = load float, float* %34, align 4
  %178 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %179 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %38, i32 0, i32 0
  %180 = extractvalue %"class.std::ios_base::Init" %178, 0
  store i8 %180, i8* %179, align 1
  %181 = bitcast %"class.std::ios_base::Init"* %28 to i8*
  %182 = bitcast %"class.std::ios_base::Init"* %38 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %181, i8* align 1 %182, i64 1, i1 false) #3
  store float %177, float* %27, align 4
  %183 = load float, float* %27, align 4
  %184 = fpext float %183 to double
  %185 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %28) #23
  %186 = fpext float %185 to double
  store double %184, double* %23, align 8
  store double %186, double* %24, align 8
  %187 = load double, double* %23, align 8
  %188 = load double, double* %24, align 8
  %189 = call double @llvm.nvvm.fmin.d(double %187, double %188) #3
  %190 = bitcast %"class.std::ios_base::Init"* %30 to i8*
  %191 = bitcast %"class.std::ios_base::Init"* %36 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %190, i8* align 1 %191, i64 1, i1 false) #3
  store double %189, double* %29, align 8
  %192 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %30) #23
  %193 = fpext float %192 to double
  %194 = load double, double* %29, align 8
  store double %193, double* %25, align 8
  store double %194, double* %26, align 8
  %195 = load double, double* %25, align 8
  %196 = load double, double* %26, align 8
  %197 = call double @llvm.nvvm.fmax.d(double %195, double %196) #3
  %198 = fptrunc double %197 to float
  store float %198, float* %35, align 4
  %199 = load float, float* %35, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %31, float %199) #23
  %200 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %31, align 1
  %201 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %100, i32 0, i32 0
  %202 = extractvalue %"class.std::ios_base::Init" %200, 0
  store i8 %202, i8* %201, align 1
  %203 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 1
  %204 = bitcast %"class.std::ios_base::Init"* %203 to i8*
  %205 = bitcast %"class.std::ios_base::Init"* %100 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %204, i8* align 1 %205, i64 1, i1 false)
  %206 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 2
  %207 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %206) #23
  %208 = load float, float* %89, align 4
  store float %207, float* %48, align 4
  store float %208, float* %49, align 4
  store float 0.000000e+00, float* %50, align 4
  %209 = load float, float* %48, align 4
  %210 = load float, float* %49, align 4
  %211 = fdiv contract float %209, %210
  store float %211, float* %50, align 4
  %212 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %213 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %53, i32 0, i32 0
  %214 = extractvalue %"class.std::ios_base::Init" %212, 0
  store i8 %214, i8* %213, align 1
  %215 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %53) #23
  %216 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %52, i32 0, i32 0
  %217 = extractvalue %"class.std::ios_base::Init" %215, 0
  store i8 %217, i8* %216, align 1
  %218 = load float, float* %50, align 4
  %219 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %220 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %54, i32 0, i32 0
  %221 = extractvalue %"class.std::ios_base::Init" %219, 0
  store i8 %221, i8* %220, align 1
  %222 = bitcast %"class.std::ios_base::Init"* %44 to i8*
  %223 = bitcast %"class.std::ios_base::Init"* %54 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %222, i8* align 1 %223, i64 1, i1 false) #3
  store float %218, float* %43, align 4
  %224 = load float, float* %43, align 4
  %225 = fpext float %224 to double
  %226 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %44) #23
  %227 = fpext float %226 to double
  store double %225, double* %39, align 8
  store double %227, double* %40, align 8
  %228 = load double, double* %39, align 8
  %229 = load double, double* %40, align 8
  %230 = call double @llvm.nvvm.fmin.d(double %228, double %229) #3
  %231 = bitcast %"class.std::ios_base::Init"* %46 to i8*
  %232 = bitcast %"class.std::ios_base::Init"* %52 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %231, i8* align 1 %232, i64 1, i1 false) #3
  store double %230, double* %45, align 8
  %233 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %46) #23
  %234 = fpext float %233 to double
  %235 = load double, double* %45, align 8
  store double %234, double* %41, align 8
  store double %235, double* %42, align 8
  %236 = load double, double* %41, align 8
  %237 = load double, double* %42, align 8
  %238 = call double @llvm.nvvm.fmax.d(double %236, double %237) #3
  %239 = fptrunc double %238 to float
  store float %239, float* %51, align 4
  %240 = load float, float* %51, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %47, float %240) #23
  %241 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %47, align 1
  %242 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %101, i32 0, i32 0
  %243 = extractvalue %"class.std::ios_base::Init" %241, 0
  store i8 %243, i8* %242, align 1
  %244 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 2
  %245 = bitcast %"class.std::ios_base::Init"* %244 to i8*
  %246 = bitcast %"class.std::ios_base::Init"* %101 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %245, i8* align 1 %246, i64 1, i1 false)
  %247 = getelementptr inbounds %"struct.vllm::vec4_t.0", %"struct.vllm::vec4_t.0"* %97, i32 0, i32 3
  %248 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %247) #23
  %249 = load float, float* %89, align 4
  store float %248, float* %64, align 4
  store float %249, float* %65, align 4
  store float 0.000000e+00, float* %66, align 4
  %250 = load float, float* %64, align 4
  %251 = load float, float* %65, align 4
  %252 = fdiv contract float %250, %251
  store float %252, float* %66, align 4
  %253 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %254 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %69, i32 0, i32 0
  %255 = extractvalue %"class.std::ios_base::Init" %253, 0
  store i8 %255, i8* %254, align 1
  %256 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %69) #23
  %257 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %68, i32 0, i32 0
  %258 = extractvalue %"class.std::ios_base::Init" %256, 0
  store i8 %258, i8* %257, align 1
  %259 = load float, float* %66, align 4
  %260 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %261 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %70, i32 0, i32 0
  %262 = extractvalue %"class.std::ios_base::Init" %260, 0
  store i8 %262, i8* %261, align 1
  %263 = bitcast %"class.std::ios_base::Init"* %60 to i8*
  %264 = bitcast %"class.std::ios_base::Init"* %70 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %263, i8* align 1 %264, i64 1, i1 false) #3
  store float %259, float* %59, align 4
  %265 = load float, float* %59, align 4
  %266 = fpext float %265 to double
  %267 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %60) #23
  %268 = fpext float %267 to double
  store double %266, double* %55, align 8
  store double %268, double* %56, align 8
  %269 = load double, double* %55, align 8
  %270 = load double, double* %56, align 8
  %271 = call double @llvm.nvvm.fmin.d(double %269, double %270) #3
  %272 = bitcast %"class.std::ios_base::Init"* %62 to i8*
  %273 = bitcast %"class.std::ios_base::Init"* %68 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %272, i8* align 1 %273, i64 1, i1 false) #3
  store double %271, double* %61, align 8
  %274 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %62) #23
  %275 = fpext float %274 to double
  %276 = load double, double* %61, align 8
  store double %275, double* %57, align 8
  store double %276, double* %58, align 8
  %277 = load double, double* %57, align 8
  %278 = load double, double* %58, align 8
  %279 = call double @llvm.nvvm.fmax.d(double %277, double %278) #3
  %280 = fptrunc double %279 to float
  store float %280, float* %67, align 4
  %281 = load float, float* %67, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %63, float %281) #23
  %282 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %63, align 1
  %283 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %102, i32 0, i32 0
  %284 = extractvalue %"class.std::ios_base::Init" %282, 0
  store i8 %284, i8* %283, align 1
  %285 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %98, i32 0, i32 3
  %286 = bitcast %"class.std::ios_base::Init"* %285 to i8*
  %287 = bitcast %"class.std::ios_base::Init"* %102 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %286, i8* align 1 %287, i64 1, i1 false)
  %288 = load %"struct.vllm::float8x4_t"*, %"struct.vllm::float8x4_t"** %94, align 8
  %289 = load i32, i32* %96, align 4
  %290 = sext i32 %289 to i64
  %291 = getelementptr inbounds %"struct.vllm::float8x4_t", %"struct.vllm::float8x4_t"* %288, i64 %290
  %292 = bitcast %"struct.vllm::float8x4_t"* %291 to i8*
  %293 = bitcast %"struct.vllm::float8x4_t"* %98 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %292, i8* align 4 %293, i64 4, i1 false)
  br label %294

294:                                              ; preds = %117
  %295 = load i32, i32* %92, align 4
  %296 = load i32, i32* %96, align 4
  %297 = add nsw i32 %296, %295
  store i32 %297, i32* %96, align 4
  br label %113, !llvm.loop !53

298:                                              ; preds = %113
  %299 = load i32, i32* %95, align 4
  %300 = mul nsw i32 %299, 4
  %301 = load i32, i32* %91, align 4
  %302 = add nsw i32 %300, %301
  store i32 %302, i32* %103, align 4
  br label %303

303:                                              ; preds = %356, %298
  %304 = load i32, i32* %103, align 4
  %305 = sext i32 %304 to i64
  %306 = load i64, i64* %90, align 8
  %307 = icmp slt i64 %305, %306
  br i1 %307, label %308, label %360

308:                                              ; preds = %303
  %309 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %88, align 8
  %310 = load i32, i32* %103, align 4
  %311 = sext i32 %310 to i64
  %312 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %309, i64 %311
  %313 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %312) #23
  %314 = load float, float* %89, align 4
  store float %313, float* %80, align 4
  store float %314, float* %81, align 4
  store float 0.000000e+00, float* %82, align 4
  %315 = load float, float* %80, align 4
  %316 = load float, float* %81, align 4
  %317 = fdiv contract float %315, %316
  store float %317, float* %82, align 4
  %318 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %319 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %85, i32 0, i32 0
  %320 = extractvalue %"class.std::ios_base::Init" %318, 0
  store i8 %320, i8* %319, align 1
  %321 = call %"class.std::ios_base::Init" @_ZN3c10ngERKNS_13Float8_e4m3fnE(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %85) #23
  %322 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %84, i32 0, i32 0
  %323 = extractvalue %"class.std::ios_base::Init" %321, 0
  store i8 %323, i8* %322, align 1
  %324 = load float, float* %82, align 4
  %325 = call %"class.std::ios_base::Init" @_ZNSt14numeric_limitsIN3c1013Float8_e4m3fnEE3maxEv() #23
  %326 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %86, i32 0, i32 0
  %327 = extractvalue %"class.std::ios_base::Init" %325, 0
  store i8 %327, i8* %326, align 1
  %328 = bitcast %"class.std::ios_base::Init"* %76 to i8*
  %329 = bitcast %"class.std::ios_base::Init"* %86 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %328, i8* align 1 %329, i64 1, i1 false) #3
  store float %324, float* %75, align 4
  %330 = load float, float* %75, align 4
  %331 = fpext float %330 to double
  %332 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %76) #23
  %333 = fpext float %332 to double
  store double %331, double* %71, align 8
  store double %333, double* %72, align 8
  %334 = load double, double* %71, align 8
  %335 = load double, double* %72, align 8
  %336 = call double @llvm.nvvm.fmin.d(double %334, double %335) #3
  %337 = bitcast %"class.std::ios_base::Init"* %78 to i8*
  %338 = bitcast %"class.std::ios_base::Init"* %84 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %337, i8* align 1 %338, i64 1, i1 false) #3
  store double %336, double* %77, align 8
  %339 = call contract float @_ZNK3c1013Float8_e4m3fncvfEv(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %78) #23
  %340 = fpext float %339 to double
  %341 = load double, double* %77, align 8
  store double %340, double* %73, align 8
  store double %341, double* %74, align 8
  %342 = load double, double* %73, align 8
  %343 = load double, double* %74, align 8
  %344 = call double @llvm.nvvm.fmax.d(double %342, double %343) #3
  %345 = fptrunc double %344 to float
  store float %345, float* %83, align 4
  %346 = load float, float* %83, align 4
  call void @_ZN3c1013Float8_e4m3fnC1Ef(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) %79, float %346) #23
  %347 = load %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %79, align 1
  %348 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %104, i32 0, i32 0
  %349 = extractvalue %"class.std::ios_base::Init" %347, 0
  store i8 %349, i8* %348, align 1
  %350 = load %"class.std::ios_base::Init"*, %"class.std::ios_base::Init"** %87, align 8
  %351 = load i32, i32* %103, align 4
  %352 = sext i32 %351 to i64
  %353 = getelementptr inbounds %"class.std::ios_base::Init", %"class.std::ios_base::Init"* %350, i64 %352
  %354 = bitcast %"class.std::ios_base::Init"* %353 to i8*
  %355 = bitcast %"class.std::ios_base::Init"* %104 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %354, i8* align 1 %355, i64 1, i1 false)
  br label %356

356:                                              ; preds = %308
  %357 = load i32, i32* %92, align 4
  %358 = load i32, i32* %103, align 4
  %359 = add nsw i32 %358, %357
  store i32 %359, i32* %103, align 4
  br label %303, !llvm.loop !54

360:                                              ; preds = %303
  ret void
}

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { mustprogress noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { argmemonly nofree nounwind willreturn }
attributes #7 = { noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { noinline noreturn nounwind }
attributes #10 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { mustprogress noinline noreturn optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #13 = { nobuiltin nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #14 = { cold noreturn nounwind }
attributes #15 = { argmemonly nofree nounwind willreturn writeonly }
attributes #16 = { convergent mustprogress noinline norecurse nounwind optnone "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="sm_80" "target-features"="+ptx72,+sm_80" }
attributes #17 = { nounwind readnone }
attributes #18 = { convergent noinline nounwind optnone "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="sm_80" "target-features"="+ptx72,+sm_80" }
attributes #19 = { convergent mustprogress noinline nounwind optnone "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="sm_80" "target-features"="+ptx72,+sm_80" }
attributes #20 = { convergent noinline nounwind optnone "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="sm_80" "target-features"="+ptx72,+sm_80" }
attributes #21 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #22 = { convergent noinline norecurse nounwind optnone "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="sm_80" "target-features"="+ptx72,+sm_80" }
attributes #23 = { convergent nounwind }
attributes #24 = { convergent inaccessiblememonly nounwind }
attributes #25 = { noreturn }
attributes #26 = { noreturn nounwind }
attributes #27 = { builtin nounwind }
attributes #28 = { convergent nounwind readnone }

!llvm.ident = !{!0, !0, !1}
!llvm.module.flags = !{!2, !3, !4, !5, !6}
!nvvm.annotations = !{!7, !8, !9, !10, !11, !12, !13, !14, !15}
!nvvmir.version = !{!16}

!0 = !{!"Ubuntu clang version 13.0.1-2ubuntu2.2"}
!1 = !{!"clang version 3.8.0 (tags/RELEASE_380/final)"}
!2 = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 2]}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 7, !"uwtable", i32 1}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!7 = !{void (%"class.std::ios_base::Init"*, float*, float*, i64)* @_ZN4vllm23scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPKT_PKfl, !"kernel", i32 1}
!8 = !{void (%"class.std::ios_base::Init"*, %"class.caffe2::TypeMeta"*, float*, i64)* @_ZN4vllm23scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPKT_PKfl, !"kernel", i32 1}
!9 = !{void (%"class.std::ios_base::Init"*, %"class.caffe2::TypeMeta"*, float*, i64)* @_ZN4vllm23scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPKT_PKfl, !"kernel", i32 1}
!10 = !{void (float*, float*, i64)* @_ZN4vllm23segmented_max_reductionIfEEvPfPKT_l, !"kernel", i32 1}
!11 = !{void (float*, %"class.caffe2::TypeMeta"*, i64)* @_ZN4vllm23segmented_max_reductionIN3c104HalfEEEvPfPKT_l, !"kernel", i32 1}
!12 = !{void (float*, %"class.caffe2::TypeMeta"*, i64)* @_ZN4vllm23segmented_max_reductionIN3c108BFloat16EEEvPfPKT_l, !"kernel", i32 1}
!13 = !{void (%"class.std::ios_base::Init"*, float*, float*, float*, i32)* @_ZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIfEEvPN3c1013Float8_e4m3fnEPfPKT_PKfi, !"kernel", i32 1}
!14 = !{void (%"class.std::ios_base::Init"*, float*, %"class.caffe2::TypeMeta"*, float*, i32)* @_ZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c104HalfEEEvPNS1_13Float8_e4m3fnEPfPKT_PKfi, !"kernel", i32 1}
!15 = !{void (%"class.std::ios_base::Init"*, float*, %"class.caffe2::TypeMeta"*, float*, i32)* @_ZN4vllm41dynamic_per_token_scaled_fp8_quant_kernelIN3c108BFloat16EEEvPNS1_13Float8_e4m3fnEPfPKT_PKfi, !"kernel", i32 1}
!16 = !{i32 2, i32 0}
!17 = distinct !{!17, !18, !19}
!18 = !{!"llvm.loop.mustprogress"}
!19 = !{!"llvm.loop.unroll.count", i32 4}
!20 = distinct !{!20, !18}
!21 = distinct !{!21, !18, !19}
!22 = distinct !{!22, !18}
!23 = !{i64 2153427878}
!24 = distinct !{!24, !18, !19}
!25 = distinct !{!25, !18}
!26 = !{i64 2154455951}
!27 = distinct !{!27, !18}
!28 = distinct !{!28, !18}
!29 = distinct !{!29, !18}
!30 = distinct !{!30, !18}
!31 = !{i64 2153363098}
!32 = distinct !{!32, !18}
!33 = distinct !{!33, !18}
!34 = !{i64 2154386525}
!35 = distinct !{!35, !18}
!36 = distinct !{!36, !18}
!37 = distinct !{!37, !18, !19}
!38 = distinct !{!38, !18}
!39 = distinct !{!39, !18, !19}
!40 = distinct !{!40, !18}
!41 = distinct !{!41, !18, !42}
!42 = !{!"llvm.loop.unroll.enable"}
!43 = distinct !{!43, !18}
!44 = distinct !{!44, !18}
!45 = distinct !{!45, !18, !19}
!46 = distinct !{!46, !18}
!47 = distinct !{!47, !18, !19}
!48 = distinct !{!48, !18}
!49 = distinct !{!49, !18}
!50 = distinct !{!50, !18}
!51 = distinct !{!51, !18, !19}
!52 = distinct !{!52, !18}
!53 = distinct !{!53, !18, !19}
!54 = distinct !{!54, !18}
