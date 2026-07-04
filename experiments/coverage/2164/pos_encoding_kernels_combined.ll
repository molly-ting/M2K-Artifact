; ModuleID = '/home/mvh6224/CUDA-BOSolver/coverage-exp/2164/pos_encoding_kernels_combined.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.at::Tensor" = type { %"class.at::TensorBase" }
%"class.at::TensorBase" = type { %"class.c10::intrusive_ptr" }
%"class.c10::intrusive_ptr" = type { %"struct.c10::TensorImpl"* }
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
%struct._object = type { i64, %struct._typeobject* }
%struct._typeobject = type { %struct.PyVarObject, i8*, i64, i64, void (%struct._object*)*, i64, %struct._object* (%struct._object*, i8*)*, i32 (%struct._object*, i8*, %struct._object*)*, %struct.PyAsyncMethods*, %struct._object* (%struct._object*)*, %struct.PyNumberMethods*, %struct.PySequenceMethods*, %struct.PyMappingMethods*, i64 (%struct._object*)*, %struct._object* (%struct._object*, %struct._object*, %struct._object*)*, %struct._object* (%struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, i32 (%struct._object*, %struct._object*, %struct._object*)*, %struct.PyBufferProcs*, i64, i8*, i32 (%struct._object*, i32 (%struct._object*, i8*)*, i8*)*, i32 (%struct._object*)*, %struct._object* (%struct._object*, %struct._object*, i32)*, i64, %struct._object* (%struct._object*)*, %struct._object* (%struct._object*)*, %struct.PyMethodDef*, %struct.PyMemberDef*, %struct.PyGetSetDef*, %struct._typeobject*, %struct._object*, %struct._object* (%struct._object*, %struct._object*, %struct._object*)*, i32 (%struct._object*, %struct._object*, %struct._object*)*, i64, i32 (%struct._object*, %struct._object*, %struct._object*)*, %struct._object* (%struct._typeobject*, i64)*, %struct._object* (%struct._typeobject*, %struct._object*, %struct._object*)*, void (i8*)*, i32 (%struct._object*)*, %struct._object*, %struct._object*, %struct._object*, %struct._object*, %struct._object*, void (%struct._object*)*, i32, void (%struct._object*)*, %struct._object* (%struct._object*, %struct._object**, i64, %struct._object*)* }
%struct.PyVarObject = type { %struct._object, i64 }
%struct.PyAsyncMethods = type { %struct._object* (%struct._object*)*, %struct._object* (%struct._object*)*, %struct._object* (%struct._object*)*, i32 (%struct._object*, %struct._object*, %struct._object**)* }
%struct.PyNumberMethods = type { %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*, %struct._object*)*, %struct._object* (%struct._object*)*, %struct._object* (%struct._object*)*, %struct._object* (%struct._object*)*, i32 (%struct._object*)*, %struct._object* (%struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*)*, i8*, %struct._object* (%struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)* }
%struct.PySequenceMethods = type { i64 (%struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, i64)*, %struct._object* (%struct._object*, i64)*, i8*, i32 (%struct._object*, i64, %struct._object*)*, i8*, i32 (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, %struct._object* (%struct._object*, i64)* }
%struct.PyMappingMethods = type { i64 (%struct._object*)*, %struct._object* (%struct._object*, %struct._object*)*, i32 (%struct._object*, %struct._object*, %struct._object*)* }
%struct.PyBufferProcs = type { i32 (%struct._object*, %struct.bufferinfo*, i32)*, void (%struct._object*, %struct.bufferinfo*)* }
%struct.bufferinfo = type { i8*, %struct._object*, i64, i64, i32, i32, i8*, i64*, i64*, i64*, i8* }
%struct.PyMethodDef = type { i8*, %struct._object* (%struct._object*, %struct._object*)*, i32, i8* }
%struct.PyMemberDef = type opaque
%struct.PyGetSetDef = type { i8*, %struct._object* (%struct._object*, i8*)*, i32 (%struct._object*, %struct._object*, i8*)*, i8*, i8* }
%"class.c10::impl::SizesAndStrides" = type { i64, %union.anon.52 }
%union.anon.52 = type { [10 x i64] }
%"class.caffe2::TypeMeta" = type { i16 }
%"class.std::optional.53" = type { %"struct.std::_Optional_base.54" }
%"struct.std::_Optional_base.54" = type { %"struct.std::_Optional_payload.56" }
%"struct.std::_Optional_payload.56" = type { %"struct.std::_Optional_payload_base.57" }
%"struct.std::_Optional_payload_base.57" = type { %"union.std::_Optional_payload_base<c10::Device>::_Storage", i8 }
%"union.std::_Optional_payload_base<c10::Device>::_Storage" = type { %"struct.c10::Device" }
%"class.c10::SymInt" = type { i64 }
%struct.dim3 = type { i32, i32, i32 }
%struct.CUstream_st = type opaque
%"class.c10::cuda::CUDAStream" = type { %"class.c10::Stream" }
%"class.c10::Stream" = type { %"struct.c10::Device", i64 }
%class.anon = type { %"class.at::Tensor"*, i8*, %struct.dim3*, %struct.dim3*, %struct.CUstream_st**, %"class.at::Tensor"*, %"class.at::Tensor"*, %"class.at::Tensor"*, i32*, i32*, i32*, i32*, i32*, i32* }
%"class.c10::ArrayRef" = type { i64*, i64 }
%class.anon.412 = type { i8*, %struct.dim3*, %struct.dim3*, %struct.CUstream_st**, %"class.at::Tensor"*, %"class.at::Tensor"*, %"class.at::Tensor"*, %"class.at::Tensor"*, i32*, i32*, i32*, i32*, i32*, i32* }
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

$_ZNK2at10TensorBase5numelEv = comdat any

$_ZNK2at10TensorBase4sizeEl = comdat any

$_ZNK2at10TensorBase6strideEl = comdat any

$_ZN4dim3C2Ejjj = comdat any

$_ZSt3minIiEUa9enable_ifILb1EERKT_S2_S2_ = comdat any

$_ZNK3c104cuda10CUDAStreamcvP11CUstream_stEv = comdat any

$_ZNK2at10TensorBase11scalar_typeEv = comdat any

$_ZN6detail11scalar_typeEN3c1010ScalarTypeE = comdat any

$_ZN3c108toStringENS_10ScalarTypeE = comdat any

$_ZN3c106detail17torchCheckMsgImplIJcPKcA24_cS3_A2_cEEEDcS3_DpRKT_ = comdat any

$_ZN3c103strIJcPKcA24_cS2_A2_cEEEDcDpRKT_ = comdat any

$_ZN3c106detail12_str_wrapperIJRKcRKPS2_S4_S6_S4_EE4callB5cxx11ES3_S6_S6_S6_S6_ = comdat any

$_ZN3c106detail4_strIcJPKcS3_S3_S3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strIcEERSoS2_RKT_ = comdat any

$_ZN3c106detail4_strIPKcJS3_S3_S3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strIPKcEERSoS4_RKT_ = comdat any

$_ZN3c106detail4_strIPKcJS3_S3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZN3c106detail4_strIPKcJS3_EEERSoS4_RKT_DpRKT0_ = comdat any

$_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv = comdat any

$_ZNK3c1010TensorImpl5dtypeEv = comdat any

$_ZN3c1020typeMetaToScalarTypeEN6caffe28TypeMetaE = comdat any

$_ZN6caffe28TypeMeta12toScalarTypeEv = comdat any

$_ZNK6caffe28TypeMeta12isScalarTypeEv = comdat any

$_ZNK2at10TensorBase7stridesEv = comdat any

$_ZNK3c108ArrayRefIlE4sizeEv = comdat any

$_ZN3c1014maybe_wrap_dimEllb = comdat any

$_ZNK3c108ArrayRefIlEixEm = comdat any

$_ZN3c1015_maybe_wrap_dimIlEET_S1_S1_b = comdat any

$_ZSt4moveIRlEONSt16remove_referenceIT_E4typeEOS2_ = comdat any

$_ZNK3c1010TensorImpl7stridesEv = comdat any

$_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE = comdat any

$_ZNK3c104impl15SizesAndStrides16strides_arrayrefEv = comdat any

$_ZNK3c104impl15SizesAndStrides12strides_dataEv = comdat any

$_ZNK3c104impl15SizesAndStrides4sizeEv = comdat any

$_ZN3c108ArrayRefIlEC2EPKlm = comdat any

$__clang_call_terminate = comdat any

$_ZN3c108ArrayRefIlE26debugCheckNullptrInvariantEv = comdat any

$_ZN3c103strIJA94_cEEEDcDpRKT_ = comdat any

$_ZN3c106detail12_str_wrapperIJPKcEE4callES3_ = comdat any

$_ZNK3c104impl15SizesAndStrides8isInlineEv = comdat any

$_ZNK3c1010TensorImpl4sizeEl = comdat any

$_ZNK3c1010TensorImpl3dimEv = comdat any

$_ZNK3c104impl15SizesAndStrides17size_at_uncheckedEm = comdat any

$_ZNK3c104impl15SizesAndStrides10sizes_dataEv = comdat any

$_ZNK3c1010TensorImpl5numelEv = comdat any

$_ZN4vllm22apply_rotary_embeddingIfLb1EEEvPT_PKS1_S4_ii = comdat any

$_Z5__ldgPKf = comdat any

$_ZN4vllm22apply_rotary_embeddingIfLb0EEEvPT_PKS1_S4_ii = comdat any

$_ZN4vllm22apply_rotary_embeddingIN3c104HalfELb1EEEvPT_PKS3_S6_ii = comdat any

$_ZN3c105__ldgEPKNS_4HalfE = comdat any

$_ZN3c10mlERKNS_4HalfES2_ = comdat any

$_ZN3c10miERKNS_4HalfES2_ = comdat any

$_ZN3c10plERKNS_4HalfES2_ = comdat any

$_ZNK3c104HalfcvfEv = comdat any

$_ZN3c104HalfC1Ef = comdat any

$_ZN3c104HalfC2Ef = comdat any

$_ZN3c104HalfC1ERK6__half = comdat any

$_ZN3c104HalfC2ERK6__half = comdat any

$_ZN4vllm22apply_rotary_embeddingIN3c104HalfELb0EEEvPT_PKS3_S6_ii = comdat any

$_ZN4vllm22apply_rotary_embeddingIN3c108BFloat16ELb1EEEvPT_PKS3_S6_ii = comdat any

$_ZN3c105__ldgEPKNS_8BFloat16E = comdat any

$_ZN3c10mlERKNS_8BFloat16ES2_ = comdat any

$_ZN3c10miERKNS_8BFloat16ES2_ = comdat any

$_ZN3c10plERKNS_8BFloat16ES2_ = comdat any

$_ZNK3c108BFloat16cvfEv = comdat any

$_ZN3c108BFloat16C1Ef = comdat any

$_ZN3c108BFloat16C2Ef = comdat any

$_ZNK13__nv_bfloat16cv17__nv_bfloat16_rawEv = comdat any

$_ZN3c108BFloat16C1ERK13__nv_bfloat16 = comdat any

$_ZN3c108BFloat16C2ERK13__nv_bfloat16 = comdat any

$_ZN4vllm22apply_rotary_embeddingIN3c108BFloat16ELb0EEEvPT_PKS3_S6_ii = comdat any

@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_pos_encoding_kernels.cu, i8* null }]
@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@.str.37 = private unnamed_addr constant [2 x i8] c"'\00", align 1
@__func__._ZN3c108ArrayRefIlE26debugCheckNullptrInvariantEv = private unnamed_addr constant [27 x i8] c"debugCheckNullptrInvariant\00", align 1
@.str.149 = private unnamed_addr constant [102 x i8] c"/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/ArrayRef.h\00", align 1
@.str.150 = private unnamed_addr constant [198 x i8] c"Data != nullptr || Length == 0 INTERNAL ASSERT FAILED at \22/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/ArrayRef.h\22:64, please report a bug to PyTorch. \00", align 1
@.str.151 = private unnamed_addr constant [94 x i8] c"created ArrayRef with nullptr and non-zero length! std::optional relies on this being illegal\00", align 1
@.str.152 = private unnamed_addr constant [17 x i8] c"rotary_embedding\00", align 1
@__func__._ZZ16rotary_embeddingRN2at6TensorES1_S1_iS1_bENKUlvE_clEv = private unnamed_addr constant [11 x i8] c"operator()\00", align 1
@.str.153 = private unnamed_addr constant [70 x i8] c"/home/mvh6224/CUDA-BOSolver/coverage-exp/2164/pos_encoding_kernels.cu\00", align 1
@.str.154 = private unnamed_addr constant [140 x i8] c"Expected false to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@.str.155 = private unnamed_addr constant [24 x i8] c"\22 not implemented for '\00", align 1
@.str.156 = private unnamed_addr constant [5 x i8] c"Byte\00", align 1
@.str.157 = private unnamed_addr constant [5 x i8] c"Char\00", align 1
@.str.158 = private unnamed_addr constant [6 x i8] c"Short\00", align 1
@.str.159 = private unnamed_addr constant [4 x i8] c"Int\00", align 1
@.str.160 = private unnamed_addr constant [5 x i8] c"Long\00", align 1
@.str.161 = private unnamed_addr constant [5 x i8] c"Half\00", align 1
@.str.162 = private unnamed_addr constant [6 x i8] c"Float\00", align 1
@.str.163 = private unnamed_addr constant [7 x i8] c"Double\00", align 1
@.str.164 = private unnamed_addr constant [12 x i8] c"ComplexHalf\00", align 1
@.str.165 = private unnamed_addr constant [13 x i8] c"ComplexFloat\00", align 1
@.str.166 = private unnamed_addr constant [14 x i8] c"ComplexDouble\00", align 1
@.str.167 = private unnamed_addr constant [5 x i8] c"Bool\00", align 1
@.str.168 = private unnamed_addr constant [6 x i8] c"QInt8\00", align 1
@.str.169 = private unnamed_addr constant [7 x i8] c"QUInt8\00", align 1
@.str.170 = private unnamed_addr constant [7 x i8] c"QInt32\00", align 1
@.str.171 = private unnamed_addr constant [9 x i8] c"BFloat16\00", align 1
@.str.172 = private unnamed_addr constant [9 x i8] c"QUInt4x2\00", align 1
@.str.173 = private unnamed_addr constant [9 x i8] c"QUInt2x4\00", align 1
@.str.174 = private unnamed_addr constant [8 x i8] c"Bits1x8\00", align 1
@.str.175 = private unnamed_addr constant [8 x i8] c"Bits2x4\00", align 1
@.str.176 = private unnamed_addr constant [8 x i8] c"Bits4x2\00", align 1
@.str.177 = private unnamed_addr constant [6 x i8] c"Bits8\00", align 1
@.str.178 = private unnamed_addr constant [7 x i8] c"Bits16\00", align 1
@.str.179 = private unnamed_addr constant [12 x i8] c"Float8_e5m2\00", align 1
@.str.180 = private unnamed_addr constant [14 x i8] c"Float8_e4m3fn\00", align 1
@.str.181 = private unnamed_addr constant [16 x i8] c"Float8_e5m2fnuz\00", align 1
@.str.182 = private unnamed_addr constant [16 x i8] c"Float8_e4m3fnuz\00", align 1
@.str.183 = private unnamed_addr constant [7 x i8] c"UInt16\00", align 1
@.str.184 = private unnamed_addr constant [7 x i8] c"UInt32\00", align 1
@.str.185 = private unnamed_addr constant [7 x i8] c"UInt64\00", align 1
@.str.186 = private unnamed_addr constant [6 x i8] c"UInt1\00", align 1
@.str.187 = private unnamed_addr constant [6 x i8] c"UInt2\00", align 1
@.str.188 = private unnamed_addr constant [6 x i8] c"UInt3\00", align 1
@.str.189 = private unnamed_addr constant [6 x i8] c"UInt4\00", align 1
@.str.190 = private unnamed_addr constant [6 x i8] c"UInt5\00", align 1
@.str.191 = private unnamed_addr constant [6 x i8] c"UInt6\00", align 1
@.str.192 = private unnamed_addr constant [6 x i8] c"UInt7\00", align 1
@.str.193 = private unnamed_addr constant [5 x i8] c"Int1\00", align 1
@.str.194 = private unnamed_addr constant [5 x i8] c"Int2\00", align 1
@.str.195 = private unnamed_addr constant [5 x i8] c"Int3\00", align 1
@.str.196 = private unnamed_addr constant [5 x i8] c"Int4\00", align 1
@.str.197 = private unnamed_addr constant [5 x i8] c"Int5\00", align 1
@.str.198 = private unnamed_addr constant [5 x i8] c"Int6\00", align 1
@.str.199 = private unnamed_addr constant [5 x i8] c"Int7\00", align 1
@.str.200 = private unnamed_addr constant [15 x i8] c"Float8_e8m0fnu\00", align 1
@.str.201 = private unnamed_addr constant [15 x i8] c"UNKNOWN_SCALAR\00", align 1

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_pos_encoding_kernels.cu() #0 section ".text.startup" {
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
define dso_local void @_Z16rotary_embeddingRN2at6TensorES1_S1_iS1_b(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %0, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %1, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %2, i32 %3, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %4, i1 zeroext %5) #4 {
  %7 = alloca %"class.at::Tensor"*, align 8
  %8 = alloca %"class.at::Tensor"*, align 8
  %9 = alloca %"class.at::Tensor"*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %"class.at::Tensor"*, align 8
  %12 = alloca i8, align 1
  %13 = alloca i64, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca %struct.dim3, align 4
  %20 = alloca %struct.dim3, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca %struct.CUstream_st*, align 8
  %24 = alloca %"class.c10::cuda::CUDAStream", align 8
  %25 = alloca %class.anon, align 8
  store %"class.at::Tensor"* %0, %"class.at::Tensor"** %7, align 8
  store %"class.at::Tensor"* %1, %"class.at::Tensor"** %8, align 8
  store %"class.at::Tensor"* %2, %"class.at::Tensor"** %9, align 8
  store i32 %3, i32* %10, align 4
  store %"class.at::Tensor"* %4, %"class.at::Tensor"** %11, align 8
  %26 = zext i1 %5 to i8
  store i8 %26, i8* %12, align 1
  %27 = load %"class.at::Tensor"*, %"class.at::Tensor"** %8, align 8
  %28 = bitcast %"class.at::Tensor"* %27 to %"class.at::TensorBase"*
  %29 = call i64 @_ZNK2at10TensorBase5numelEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %28)
  %30 = load %"class.at::Tensor"*, %"class.at::Tensor"** %8, align 8
  %31 = bitcast %"class.at::Tensor"* %30 to %"class.at::TensorBase"*
  %32 = call i64 @_ZNK2at10TensorBase4sizeEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %31, i64 -1)
  %33 = sdiv i64 %29, %32
  store i64 %33, i64* %13, align 8
  %34 = load %"class.at::Tensor"*, %"class.at::Tensor"** %11, align 8
  %35 = bitcast %"class.at::Tensor"* %34 to %"class.at::TensorBase"*
  %36 = call i64 @_ZNK2at10TensorBase4sizeEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %35, i64 1)
  %37 = trunc i64 %36 to i32
  store i32 %37, i32* %14, align 4
  %38 = load %"class.at::Tensor"*, %"class.at::Tensor"** %8, align 8
  %39 = bitcast %"class.at::Tensor"* %38 to %"class.at::TensorBase"*
  %40 = call i64 @_ZNK2at10TensorBase4sizeEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %39, i64 -1)
  %41 = load i32, i32* %10, align 4
  %42 = sext i32 %41 to i64
  %43 = sdiv i64 %40, %42
  %44 = trunc i64 %43 to i32
  store i32 %44, i32* %15, align 4
  %45 = load %"class.at::Tensor"*, %"class.at::Tensor"** %9, align 8
  %46 = bitcast %"class.at::Tensor"* %45 to %"class.at::TensorBase"*
  %47 = call i64 @_ZNK2at10TensorBase4sizeEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %46, i64 -1)
  %48 = load i32, i32* %10, align 4
  %49 = sext i32 %48 to i64
  %50 = sdiv i64 %47, %49
  %51 = trunc i64 %50 to i32
  store i32 %51, i32* %16, align 4
  %52 = load %"class.at::Tensor"*, %"class.at::Tensor"** %8, align 8
  %53 = bitcast %"class.at::Tensor"* %52 to %"class.at::TensorBase"*
  %54 = call i64 @_ZNK2at10TensorBase6strideEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %53, i64 -2)
  %55 = trunc i64 %54 to i32
  store i32 %55, i32* %17, align 4
  %56 = load %"class.at::Tensor"*, %"class.at::Tensor"** %9, align 8
  %57 = bitcast %"class.at::Tensor"* %56 to %"class.at::TensorBase"*
  %58 = call i64 @_ZNK2at10TensorBase6strideEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %57, i64 -2)
  %59 = trunc i64 %58 to i32
  store i32 %59, i32* %18, align 4
  %60 = load i64, i64* %13, align 8
  %61 = trunc i64 %60 to i32
  call void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %19, i32 %61, i32 1, i32 1)
  %62 = load i32, i32* %15, align 4
  %63 = load i32, i32* %14, align 4
  %64 = mul nsw i32 %62, %63
  %65 = sdiv i32 %64, 2
  store i32 %65, i32* %21, align 4
  store i32 512, i32* %22, align 4
  %66 = call nonnull align 4 dereferenceable(4) i32* @_ZSt3minIiEUa9enable_ifILb1EERKT_S2_S2_(i32* nonnull align 4 dereferenceable(4) %21, i32* nonnull align 4 dereferenceable(4) %22)
  %67 = load i32, i32* %66, align 4
  call void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %20, i32 %67, i32 1, i32 1)
  %68 = call { i64, i64 } @_ZN3c104cuda20getCurrentCUDAStreamEa(i8 signext -1)
  %69 = getelementptr inbounds %"class.c10::cuda::CUDAStream", %"class.c10::cuda::CUDAStream"* %24, i32 0, i32 0
  %70 = bitcast %"class.c10::Stream"* %69 to { i64, i64 }*
  %71 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %70, i32 0, i32 0
  %72 = extractvalue { i64, i64 } %68, 0
  store i64 %72, i64* %71, align 8
  %73 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %70, i32 0, i32 1
  %74 = extractvalue { i64, i64 } %68, 1
  store i64 %74, i64* %73, align 8
  %75 = call %struct.CUstream_st* @_ZNK3c104cuda10CUDAStreamcvP11CUstream_stEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16) %24)
  store %struct.CUstream_st* %75, %struct.CUstream_st** %23, align 8
  %76 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 0
  %77 = load %"class.at::Tensor"*, %"class.at::Tensor"** %8, align 8
  store %"class.at::Tensor"* %77, %"class.at::Tensor"** %76, align 8
  %78 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 1
  store i8* %12, i8** %78, align 8
  %79 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 2
  store %struct.dim3* %19, %struct.dim3** %79, align 8
  %80 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 3
  store %struct.dim3* %20, %struct.dim3** %80, align 8
  %81 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 4
  store %struct.CUstream_st** %23, %struct.CUstream_st*** %81, align 8
  %82 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 5
  %83 = load %"class.at::Tensor"*, %"class.at::Tensor"** %7, align 8
  store %"class.at::Tensor"* %83, %"class.at::Tensor"** %82, align 8
  %84 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 6
  %85 = load %"class.at::Tensor"*, %"class.at::Tensor"** %9, align 8
  store %"class.at::Tensor"* %85, %"class.at::Tensor"** %84, align 8
  %86 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 7
  %87 = load %"class.at::Tensor"*, %"class.at::Tensor"** %11, align 8
  store %"class.at::Tensor"* %87, %"class.at::Tensor"** %86, align 8
  %88 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 8
  store i32* %14, i32** %88, align 8
  %89 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 9
  store i32* %17, i32** %89, align 8
  %90 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 10
  store i32* %18, i32** %90, align 8
  %91 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 11
  store i32* %15, i32** %91, align 8
  %92 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 12
  store i32* %16, i32** %92, align 8
  %93 = getelementptr inbounds %class.anon, %class.anon* %25, i32 0, i32 13
  store i32* %10, i32** %93, align 8
  call void @_ZZ16rotary_embeddingRN2at6TensorES1_S1_iS1_bENKUlvE_clEv(%class.anon* nonnull align 8 dereferenceable(112) %25)
  ret void
}

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

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK2at10TensorBase6strideEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0, i64 %1) #4 comdat align 2 {
  %3 = alloca %"class.at::TensorBase"*, align 8
  %4 = alloca i64, align 8
  %5 = alloca %"class.c10::ArrayRef", align 8
  %6 = alloca i64, align 8
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %3, align 8
  store i64 %1, i64* %4, align 8
  %7 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %3, align 8
  %8 = call { i64*, i64 } @_ZNK2at10TensorBase7stridesEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %7)
  %9 = bitcast %"class.c10::ArrayRef"* %5 to { i64*, i64 }*
  %10 = getelementptr inbounds { i64*, i64 }, { i64*, i64 }* %9, i32 0, i32 0
  %11 = extractvalue { i64*, i64 } %8, 0
  store i64* %11, i64** %10, align 8
  %12 = getelementptr inbounds { i64*, i64 }, { i64*, i64 }* %9, i32 0, i32 1
  %13 = extractvalue { i64*, i64 } %8, 1
  store i64 %13, i64* %12, align 8
  %14 = call i64 @_ZNK3c108ArrayRefIlE4sizeEv(%"class.c10::ArrayRef"* nonnull align 8 dereferenceable(16) %5)
  store i64 %14, i64* %6, align 8
  %15 = load i64, i64* %4, align 8
  %16 = load i64, i64* %6, align 8
  %17 = call i64 @_ZN3c1014maybe_wrap_dimEllb(i64 %15, i64 %16, i1 zeroext false)
  %18 = call nonnull align 8 dereferenceable(8) i64* @_ZNK3c108ArrayRefIlEixEm(%"class.c10::ArrayRef"* nonnull align 8 dereferenceable(16) %5, i64 %17)
  %19 = load i64, i64* %18, align 8
  ret i64 %19
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

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 4 dereferenceable(4) i32* @_ZSt3minIiEUa9enable_ifILb1EERKT_S2_S2_(i32* nonnull align 4 dereferenceable(4) %0, i32* nonnull align 4 dereferenceable(4) %1) #6 comdat {
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
define internal void @_ZZ16rotary_embeddingRN2at6TensorES1_S1_iS1_bENKUlvE_clEv(%class.anon* nonnull align 8 dereferenceable(112) %0) #4 align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %class.anon*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i8, align 1
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  %7 = alloca %class.anon.412, align 8
  %8 = alloca %class.anon.412, align 8
  %9 = alloca %class.anon.412, align 8
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
  store i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.152, i32 0, i32 0), i8** %5, align 8
  %20 = load i8*, i8** %3, align 8
  %21 = load i8, i8* %20, align 1
  %22 = call signext i8 @_ZN6detail11scalar_typeEN3c1010ScalarTypeE(i8 signext %21)
  store i8 %22, i8* %6, align 1
  %23 = load i8, i8* %6, align 1
  switch i8 %23, label %159 [
    i8 6, label %24
    i8 5, label %69
    i8 15, label %114
  ]

24:                                               ; preds = %1
  br label %25

25:                                               ; preds = %24
  br label %26

26:                                               ; preds = %25
  %27 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 0
  %28 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 1
  %29 = load i8*, i8** %28, align 8
  store i8* %29, i8** %27, align 8
  %30 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 1
  %31 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 2
  %32 = load %struct.dim3*, %struct.dim3** %31, align 8
  store %struct.dim3* %32, %struct.dim3** %30, align 8
  %33 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 2
  %34 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 3
  %35 = load %struct.dim3*, %struct.dim3** %34, align 8
  store %struct.dim3* %35, %struct.dim3** %33, align 8
  %36 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 3
  %37 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 4
  %38 = load %struct.CUstream_st**, %struct.CUstream_st*** %37, align 8
  store %struct.CUstream_st** %38, %struct.CUstream_st*** %36, align 8
  %39 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 4
  %40 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 5
  %41 = load %"class.at::Tensor"*, %"class.at::Tensor"** %40, align 8
  store %"class.at::Tensor"* %41, %"class.at::Tensor"** %39, align 8
  %42 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 5
  %43 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 0
  %44 = load %"class.at::Tensor"*, %"class.at::Tensor"** %43, align 8
  store %"class.at::Tensor"* %44, %"class.at::Tensor"** %42, align 8
  %45 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 6
  %46 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 6
  %47 = load %"class.at::Tensor"*, %"class.at::Tensor"** %46, align 8
  store %"class.at::Tensor"* %47, %"class.at::Tensor"** %45, align 8
  %48 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 7
  %49 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 7
  %50 = load %"class.at::Tensor"*, %"class.at::Tensor"** %49, align 8
  store %"class.at::Tensor"* %50, %"class.at::Tensor"** %48, align 8
  %51 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 8
  %52 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 8
  %53 = load i32*, i32** %52, align 8
  store i32* %53, i32** %51, align 8
  %54 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 9
  %55 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 9
  %56 = load i32*, i32** %55, align 8
  store i32* %56, i32** %54, align 8
  %57 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 10
  %58 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 10
  %59 = load i32*, i32** %58, align 8
  store i32* %59, i32** %57, align 8
  %60 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 11
  %61 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 11
  %62 = load i32*, i32** %61, align 8
  store i32* %62, i32** %60, align 8
  %63 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 12
  %64 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 12
  %65 = load i32*, i32** %64, align 8
  store i32* %65, i32** %63, align 8
  %66 = getelementptr inbounds %class.anon.412, %class.anon.412* %7, i32 0, i32 13
  %67 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 13
  %68 = load i32*, i32** %67, align 8
  store i32* %68, i32** %66, align 8
  call void @_ZZZ16rotary_embeddingRN2at6TensorES1_S1_iS1_bENKUlvE_clEvENKUlvE_clEv(%class.anon.412* nonnull align 8 dereferenceable(112) %7)
  br label %167

69:                                               ; preds = %1
  br label %70

70:                                               ; preds = %69
  br label %71

71:                                               ; preds = %70
  %72 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 0
  %73 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 1
  %74 = load i8*, i8** %73, align 8
  store i8* %74, i8** %72, align 8
  %75 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 1
  %76 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 2
  %77 = load %struct.dim3*, %struct.dim3** %76, align 8
  store %struct.dim3* %77, %struct.dim3** %75, align 8
  %78 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 2
  %79 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 3
  %80 = load %struct.dim3*, %struct.dim3** %79, align 8
  store %struct.dim3* %80, %struct.dim3** %78, align 8
  %81 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 3
  %82 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 4
  %83 = load %struct.CUstream_st**, %struct.CUstream_st*** %82, align 8
  store %struct.CUstream_st** %83, %struct.CUstream_st*** %81, align 8
  %84 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 4
  %85 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 5
  %86 = load %"class.at::Tensor"*, %"class.at::Tensor"** %85, align 8
  store %"class.at::Tensor"* %86, %"class.at::Tensor"** %84, align 8
  %87 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 5
  %88 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 0
  %89 = load %"class.at::Tensor"*, %"class.at::Tensor"** %88, align 8
  store %"class.at::Tensor"* %89, %"class.at::Tensor"** %87, align 8
  %90 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 6
  %91 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 6
  %92 = load %"class.at::Tensor"*, %"class.at::Tensor"** %91, align 8
  store %"class.at::Tensor"* %92, %"class.at::Tensor"** %90, align 8
  %93 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 7
  %94 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 7
  %95 = load %"class.at::Tensor"*, %"class.at::Tensor"** %94, align 8
  store %"class.at::Tensor"* %95, %"class.at::Tensor"** %93, align 8
  %96 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 8
  %97 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 8
  %98 = load i32*, i32** %97, align 8
  store i32* %98, i32** %96, align 8
  %99 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 9
  %100 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 9
  %101 = load i32*, i32** %100, align 8
  store i32* %101, i32** %99, align 8
  %102 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 10
  %103 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 10
  %104 = load i32*, i32** %103, align 8
  store i32* %104, i32** %102, align 8
  %105 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 11
  %106 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 11
  %107 = load i32*, i32** %106, align 8
  store i32* %107, i32** %105, align 8
  %108 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 12
  %109 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 12
  %110 = load i32*, i32** %109, align 8
  store i32* %110, i32** %108, align 8
  %111 = getelementptr inbounds %class.anon.412, %class.anon.412* %8, i32 0, i32 13
  %112 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 13
  %113 = load i32*, i32** %112, align 8
  store i32* %113, i32** %111, align 8
  call void @_ZZZ16rotary_embeddingRN2at6TensorES1_S1_iS1_bENKUlvE_clEvENKUlvE0_clEv(%class.anon.412* nonnull align 8 dereferenceable(112) %8)
  br label %167

114:                                              ; preds = %1
  br label %115

115:                                              ; preds = %114
  br label %116

116:                                              ; preds = %115
  %117 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 0
  %118 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 1
  %119 = load i8*, i8** %118, align 8
  store i8* %119, i8** %117, align 8
  %120 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 1
  %121 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 2
  %122 = load %struct.dim3*, %struct.dim3** %121, align 8
  store %struct.dim3* %122, %struct.dim3** %120, align 8
  %123 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 2
  %124 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 3
  %125 = load %struct.dim3*, %struct.dim3** %124, align 8
  store %struct.dim3* %125, %struct.dim3** %123, align 8
  %126 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 3
  %127 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 4
  %128 = load %struct.CUstream_st**, %struct.CUstream_st*** %127, align 8
  store %struct.CUstream_st** %128, %struct.CUstream_st*** %126, align 8
  %129 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 4
  %130 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 5
  %131 = load %"class.at::Tensor"*, %"class.at::Tensor"** %130, align 8
  store %"class.at::Tensor"* %131, %"class.at::Tensor"** %129, align 8
  %132 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 5
  %133 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 0
  %134 = load %"class.at::Tensor"*, %"class.at::Tensor"** %133, align 8
  store %"class.at::Tensor"* %134, %"class.at::Tensor"** %132, align 8
  %135 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 6
  %136 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 6
  %137 = load %"class.at::Tensor"*, %"class.at::Tensor"** %136, align 8
  store %"class.at::Tensor"* %137, %"class.at::Tensor"** %135, align 8
  %138 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 7
  %139 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 7
  %140 = load %"class.at::Tensor"*, %"class.at::Tensor"** %139, align 8
  store %"class.at::Tensor"* %140, %"class.at::Tensor"** %138, align 8
  %141 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 8
  %142 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 8
  %143 = load i32*, i32** %142, align 8
  store i32* %143, i32** %141, align 8
  %144 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 9
  %145 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 9
  %146 = load i32*, i32** %145, align 8
  store i32* %146, i32** %144, align 8
  %147 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 10
  %148 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 10
  %149 = load i32*, i32** %148, align 8
  store i32* %149, i32** %147, align 8
  %150 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 11
  %151 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 11
  %152 = load i32*, i32** %151, align 8
  store i32* %152, i32** %150, align 8
  %153 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 12
  %154 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 12
  %155 = load i32*, i32** %154, align 8
  store i32* %155, i32** %153, align 8
  %156 = getelementptr inbounds %class.anon.412, %class.anon.412* %9, i32 0, i32 13
  %157 = getelementptr inbounds %class.anon, %class.anon* %15, i32 0, i32 13
  %158 = load i32*, i32** %157, align 8
  store i32* %158, i32** %156, align 8
  call void @_ZZZ16rotary_embeddingRN2at6TensorES1_S1_iS1_bENKUlvE_clEvENKUlvE1_clEv(%class.anon.412* nonnull align 8 dereferenceable(112) %9)
  br label %167

159:                                              ; preds = %1
  store i8 34, i8* %11, align 1
  %160 = load i8, i8* %6, align 1
  %161 = call i8* @_ZN3c108toStringENS_10ScalarTypeE(i8 signext %160)
  store i8* %161, i8** %12, align 8
  call void @_ZN3c106detail17torchCheckMsgImplIJcPKcA24_cS3_A2_cEEEDcS3_DpRKT_(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8 %10, i8* getelementptr inbounds ([140 x i8], [140 x i8]* @.str.154, i64 0, i64 0), i8* nonnull align 1 dereferenceable(1) %11, i8** nonnull align 8 dereferenceable(8) %5, [24 x i8]* nonnull align 1 dereferenceable(24) @.str.155, i8** nonnull align 8 dereferenceable(8) %12, [2 x i8]* nonnull align 1 dereferenceable(2) @.str.37)
  invoke void @_ZN3c106detail14torchCheckFailEPKcS2_jRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__func__._ZZ16rotary_embeddingRN2at6TensorES1_S1_iS1_bENKUlvE_clEv, i64 0, i64 0), i8* getelementptr inbounds ([70 x i8], [70 x i8]* @.str.153, i64 0, i64 0), i32 127, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %10) #17
          to label %162 unwind label %163

162:                                              ; preds = %159
  unreachable

163:                                              ; preds = %159
  %164 = landingpad { i8*, i32 }
          cleanup
  %165 = extractvalue { i8*, i32 } %164, 0
  store i8* %165, i8** %13, align 8
  %166 = extractvalue { i8*, i32 } %164, 1
  store i32 %166, i32* %14, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32) %10) #3
  br label %168

167:                                              ; preds = %116, %71, %26
  ret void

168:                                              ; preds = %163
  %169 = load i8*, i8** %13, align 8
  %170 = load i32, i32* %14, align 4
  %171 = insertvalue { i8*, i32 } undef, i8* %169, 0
  %172 = insertvalue { i8*, i32 } %171, i32 %170, 1
  resume { i8*, i32 } %172
}

declare dso_local i32 @__gxx_personality_v0(...)

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
define linkonce_odr dso_local signext i8 @_ZN6detail11scalar_typeEN3c1010ScalarTypeE(i8 signext %0) #6 comdat {
  %2 = alloca i8, align 1
  store i8 %0, i8* %2, align 1
  %3 = load i8, i8* %2, align 1
  ret i8 %3
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ16rotary_embeddingRN2at6TensorES1_S1_iS1_bENKUlvE_clEvENKUlvE_clEv(%class.anon.412* nonnull align 8 dereferenceable(112) %0) #4 align 2 {
  %2 = alloca %class.anon.412*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  %7 = alloca %struct.dim3, align 4
  %8 = alloca %struct.dim3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca { i64, i32 }, align 4
  store %class.anon.412* %0, %class.anon.412** %2, align 8
  %11 = load %class.anon.412*, %class.anon.412** %2, align 8
  %12 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 0
  %13 = load i8*, i8** %12, align 8
  %14 = load i8, i8* %13, align 1
  %15 = trunc i8 %14 to i1
  br i1 %15, label %16, label %79

16:                                               ; preds = %1
  %17 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 1
  %18 = load %struct.dim3*, %struct.dim3** %17, align 8
  %19 = bitcast %struct.dim3* %3 to i8*
  %20 = bitcast %struct.dim3* %18 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %19, i8* align 4 %20, i64 12, i1 false)
  %21 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 2
  %22 = load %struct.dim3*, %struct.dim3** %21, align 8
  %23 = bitcast %struct.dim3* %4 to i8*
  %24 = bitcast %struct.dim3* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %23, i8* align 4 %24, i64 12, i1 false)
  %25 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 3
  %26 = load %struct.CUstream_st**, %struct.CUstream_st*** %25, align 8
  %27 = load %struct.CUstream_st*, %struct.CUstream_st** %26, align 8
  %28 = bitcast %struct.CUstream_st* %27 to i8*
  %29 = bitcast { i64, i32 }* %5 to i8*
  %30 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %29, i8* align 4 %30, i64 12, i1 false)
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %32 = load i64, i64* %31, align 4
  %33 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %34 = load i32, i32* %33, align 4
  %35 = bitcast { i64, i32 }* %6 to i8*
  %36 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %35, i8* align 4 %36, i64 12, i1 false)
  %37 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %38 = load i64, i64* %37, align 4
  %39 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = call i32 @__cudaPushCallConfiguration(i64 %32, i32 %34, i64 %38, i32 %40, i64 0, i8* %28)
  %42 = icmp ne i32 %41, 0
  br i1 %42, label %78, label %43

43:                                               ; preds = %16
  %44 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 4
  %45 = load %"class.at::Tensor"*, %"class.at::Tensor"** %44, align 8
  %46 = bitcast %"class.at::Tensor"* %45 to %"class.at::TensorBase"*
  %47 = call i64* @_ZNK2at10TensorBase8data_ptrIlEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %46)
  %48 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 5
  %49 = load %"class.at::Tensor"*, %"class.at::Tensor"** %48, align 8
  %50 = bitcast %"class.at::Tensor"* %49 to %"class.at::TensorBase"*
  %51 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %50)
  %52 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 6
  %53 = load %"class.at::Tensor"*, %"class.at::Tensor"** %52, align 8
  %54 = bitcast %"class.at::Tensor"* %53 to %"class.at::TensorBase"*
  %55 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %54)
  %56 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 7
  %57 = load %"class.at::Tensor"*, %"class.at::Tensor"** %56, align 8
  %58 = bitcast %"class.at::Tensor"* %57 to %"class.at::TensorBase"*
  %59 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %58)
  %60 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 8
  %61 = load i32*, i32** %60, align 8
  %62 = load i32, i32* %61, align 4
  %63 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 9
  %64 = load i32*, i32** %63, align 8
  %65 = load i32, i32* %64, align 4
  %66 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 10
  %67 = load i32*, i32** %66, align 8
  %68 = load i32, i32* %67, align 4
  %69 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 11
  %70 = load i32*, i32** %69, align 8
  %71 = load i32, i32* %70, align 4
  %72 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 12
  %73 = load i32*, i32** %72, align 8
  %74 = load i32, i32* %73, align 4
  %75 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 13
  %76 = load i32*, i32** %75, align 8
  %77 = load i32, i32* %76, align 4
  call void @_ZN4vllm38__device_stub__rotary_embedding_kernelIfLb1EEEvPKlPT_S4_PKS3_iiiiii(i64* %47, float* %51, float* %55, float* %59, i32 %62, i32 %65, i32 %68, i32 %71, i32 %74, i32 %77)
  br label %78

78:                                               ; preds = %43, %16
  br label %142

79:                                               ; preds = %1
  %80 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 1
  %81 = load %struct.dim3*, %struct.dim3** %80, align 8
  %82 = bitcast %struct.dim3* %7 to i8*
  %83 = bitcast %struct.dim3* %81 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %82, i8* align 4 %83, i64 12, i1 false)
  %84 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 2
  %85 = load %struct.dim3*, %struct.dim3** %84, align 8
  %86 = bitcast %struct.dim3* %8 to i8*
  %87 = bitcast %struct.dim3* %85 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %86, i8* align 4 %87, i64 12, i1 false)
  %88 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 3
  %89 = load %struct.CUstream_st**, %struct.CUstream_st*** %88, align 8
  %90 = load %struct.CUstream_st*, %struct.CUstream_st** %89, align 8
  %91 = bitcast %struct.CUstream_st* %90 to i8*
  %92 = bitcast { i64, i32 }* %9 to i8*
  %93 = bitcast %struct.dim3* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %92, i8* align 4 %93, i64 12, i1 false)
  %94 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 0
  %95 = load i64, i64* %94, align 4
  %96 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 1
  %97 = load i32, i32* %96, align 4
  %98 = bitcast { i64, i32 }* %10 to i8*
  %99 = bitcast %struct.dim3* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %98, i8* align 4 %99, i64 12, i1 false)
  %100 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 0
  %101 = load i64, i64* %100, align 4
  %102 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 1
  %103 = load i32, i32* %102, align 4
  %104 = call i32 @__cudaPushCallConfiguration(i64 %95, i32 %97, i64 %101, i32 %103, i64 0, i8* %91)
  %105 = icmp ne i32 %104, 0
  br i1 %105, label %141, label %106

106:                                              ; preds = %79
  %107 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 4
  %108 = load %"class.at::Tensor"*, %"class.at::Tensor"** %107, align 8
  %109 = bitcast %"class.at::Tensor"* %108 to %"class.at::TensorBase"*
  %110 = call i64* @_ZNK2at10TensorBase8data_ptrIlEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %109)
  %111 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 5
  %112 = load %"class.at::Tensor"*, %"class.at::Tensor"** %111, align 8
  %113 = bitcast %"class.at::Tensor"* %112 to %"class.at::TensorBase"*
  %114 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %113)
  %115 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 6
  %116 = load %"class.at::Tensor"*, %"class.at::Tensor"** %115, align 8
  %117 = bitcast %"class.at::Tensor"* %116 to %"class.at::TensorBase"*
  %118 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %117)
  %119 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 7
  %120 = load %"class.at::Tensor"*, %"class.at::Tensor"** %119, align 8
  %121 = bitcast %"class.at::Tensor"* %120 to %"class.at::TensorBase"*
  %122 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %121)
  %123 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 8
  %124 = load i32*, i32** %123, align 8
  %125 = load i32, i32* %124, align 4
  %126 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 9
  %127 = load i32*, i32** %126, align 8
  %128 = load i32, i32* %127, align 4
  %129 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 10
  %130 = load i32*, i32** %129, align 8
  %131 = load i32, i32* %130, align 4
  %132 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 11
  %133 = load i32*, i32** %132, align 8
  %134 = load i32, i32* %133, align 4
  %135 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 12
  %136 = load i32*, i32** %135, align 8
  %137 = load i32, i32* %136, align 4
  %138 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 13
  %139 = load i32*, i32** %138, align 8
  %140 = load i32, i32* %139, align 4
  call void @_ZN4vllm38__device_stub__rotary_embedding_kernelIfLb0EEEvPKlPT_S4_PKS3_iiiiii(i64* %110, float* %114, float* %118, float* %122, i32 %125, i32 %128, i32 %131, i32 %134, i32 %137, i32 %140)
  br label %141

141:                                              ; preds = %106, %79
  br label %142

142:                                              ; preds = %141, %78
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ16rotary_embeddingRN2at6TensorES1_S1_iS1_bENKUlvE_clEvENKUlvE0_clEv(%class.anon.412* nonnull align 8 dereferenceable(112) %0) #4 align 2 {
  %2 = alloca %class.anon.412*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  %7 = alloca %struct.dim3, align 4
  %8 = alloca %struct.dim3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca { i64, i32 }, align 4
  store %class.anon.412* %0, %class.anon.412** %2, align 8
  %11 = load %class.anon.412*, %class.anon.412** %2, align 8
  %12 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 0
  %13 = load i8*, i8** %12, align 8
  %14 = load i8, i8* %13, align 1
  %15 = trunc i8 %14 to i1
  br i1 %15, label %16, label %79

16:                                               ; preds = %1
  %17 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 1
  %18 = load %struct.dim3*, %struct.dim3** %17, align 8
  %19 = bitcast %struct.dim3* %3 to i8*
  %20 = bitcast %struct.dim3* %18 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %19, i8* align 4 %20, i64 12, i1 false)
  %21 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 2
  %22 = load %struct.dim3*, %struct.dim3** %21, align 8
  %23 = bitcast %struct.dim3* %4 to i8*
  %24 = bitcast %struct.dim3* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %23, i8* align 4 %24, i64 12, i1 false)
  %25 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 3
  %26 = load %struct.CUstream_st**, %struct.CUstream_st*** %25, align 8
  %27 = load %struct.CUstream_st*, %struct.CUstream_st** %26, align 8
  %28 = bitcast %struct.CUstream_st* %27 to i8*
  %29 = bitcast { i64, i32 }* %5 to i8*
  %30 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %29, i8* align 4 %30, i64 12, i1 false)
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %32 = load i64, i64* %31, align 4
  %33 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %34 = load i32, i32* %33, align 4
  %35 = bitcast { i64, i32 }* %6 to i8*
  %36 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %35, i8* align 4 %36, i64 12, i1 false)
  %37 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %38 = load i64, i64* %37, align 4
  %39 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = call i32 @__cudaPushCallConfiguration(i64 %32, i32 %34, i64 %38, i32 %40, i64 0, i8* %28)
  %42 = icmp ne i32 %41, 0
  br i1 %42, label %78, label %43

43:                                               ; preds = %16
  %44 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 4
  %45 = load %"class.at::Tensor"*, %"class.at::Tensor"** %44, align 8
  %46 = bitcast %"class.at::Tensor"* %45 to %"class.at::TensorBase"*
  %47 = call i64* @_ZNK2at10TensorBase8data_ptrIlEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %46)
  %48 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 5
  %49 = load %"class.at::Tensor"*, %"class.at::Tensor"** %48, align 8
  %50 = bitcast %"class.at::Tensor"* %49 to %"class.at::TensorBase"*
  %51 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %50)
  %52 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 6
  %53 = load %"class.at::Tensor"*, %"class.at::Tensor"** %52, align 8
  %54 = bitcast %"class.at::Tensor"* %53 to %"class.at::TensorBase"*
  %55 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %54)
  %56 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 7
  %57 = load %"class.at::Tensor"*, %"class.at::Tensor"** %56, align 8
  %58 = bitcast %"class.at::Tensor"* %57 to %"class.at::TensorBase"*
  %59 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %58)
  %60 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 8
  %61 = load i32*, i32** %60, align 8
  %62 = load i32, i32* %61, align 4
  %63 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 9
  %64 = load i32*, i32** %63, align 8
  %65 = load i32, i32* %64, align 4
  %66 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 10
  %67 = load i32*, i32** %66, align 8
  %68 = load i32, i32* %67, align 4
  %69 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 11
  %70 = load i32*, i32** %69, align 8
  %71 = load i32, i32* %70, align 4
  %72 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 12
  %73 = load i32*, i32** %72, align 8
  %74 = load i32, i32* %73, align 4
  %75 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 13
  %76 = load i32*, i32** %75, align 8
  %77 = load i32, i32* %76, align 4
  call void @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c104HalfELb1EEEvPKlPT_S6_PKS5_iiiiii(i64* %47, %"class.caffe2::TypeMeta"* %51, %"class.caffe2::TypeMeta"* %55, %"class.caffe2::TypeMeta"* %59, i32 %62, i32 %65, i32 %68, i32 %71, i32 %74, i32 %77)
  br label %78

78:                                               ; preds = %43, %16
  br label %142

79:                                               ; preds = %1
  %80 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 1
  %81 = load %struct.dim3*, %struct.dim3** %80, align 8
  %82 = bitcast %struct.dim3* %7 to i8*
  %83 = bitcast %struct.dim3* %81 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %82, i8* align 4 %83, i64 12, i1 false)
  %84 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 2
  %85 = load %struct.dim3*, %struct.dim3** %84, align 8
  %86 = bitcast %struct.dim3* %8 to i8*
  %87 = bitcast %struct.dim3* %85 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %86, i8* align 4 %87, i64 12, i1 false)
  %88 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 3
  %89 = load %struct.CUstream_st**, %struct.CUstream_st*** %88, align 8
  %90 = load %struct.CUstream_st*, %struct.CUstream_st** %89, align 8
  %91 = bitcast %struct.CUstream_st* %90 to i8*
  %92 = bitcast { i64, i32 }* %9 to i8*
  %93 = bitcast %struct.dim3* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %92, i8* align 4 %93, i64 12, i1 false)
  %94 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 0
  %95 = load i64, i64* %94, align 4
  %96 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 1
  %97 = load i32, i32* %96, align 4
  %98 = bitcast { i64, i32 }* %10 to i8*
  %99 = bitcast %struct.dim3* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %98, i8* align 4 %99, i64 12, i1 false)
  %100 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 0
  %101 = load i64, i64* %100, align 4
  %102 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 1
  %103 = load i32, i32* %102, align 4
  %104 = call i32 @__cudaPushCallConfiguration(i64 %95, i32 %97, i64 %101, i32 %103, i64 0, i8* %91)
  %105 = icmp ne i32 %104, 0
  br i1 %105, label %141, label %106

106:                                              ; preds = %79
  %107 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 4
  %108 = load %"class.at::Tensor"*, %"class.at::Tensor"** %107, align 8
  %109 = bitcast %"class.at::Tensor"* %108 to %"class.at::TensorBase"*
  %110 = call i64* @_ZNK2at10TensorBase8data_ptrIlEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %109)
  %111 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 5
  %112 = load %"class.at::Tensor"*, %"class.at::Tensor"** %111, align 8
  %113 = bitcast %"class.at::Tensor"* %112 to %"class.at::TensorBase"*
  %114 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %113)
  %115 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 6
  %116 = load %"class.at::Tensor"*, %"class.at::Tensor"** %115, align 8
  %117 = bitcast %"class.at::Tensor"* %116 to %"class.at::TensorBase"*
  %118 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %117)
  %119 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 7
  %120 = load %"class.at::Tensor"*, %"class.at::Tensor"** %119, align 8
  %121 = bitcast %"class.at::Tensor"* %120 to %"class.at::TensorBase"*
  %122 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %121)
  %123 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 8
  %124 = load i32*, i32** %123, align 8
  %125 = load i32, i32* %124, align 4
  %126 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 9
  %127 = load i32*, i32** %126, align 8
  %128 = load i32, i32* %127, align 4
  %129 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 10
  %130 = load i32*, i32** %129, align 8
  %131 = load i32, i32* %130, align 4
  %132 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 11
  %133 = load i32*, i32** %132, align 8
  %134 = load i32, i32* %133, align 4
  %135 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 12
  %136 = load i32*, i32** %135, align 8
  %137 = load i32, i32* %136, align 4
  %138 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 13
  %139 = load i32*, i32** %138, align 8
  %140 = load i32, i32* %139, align 4
  call void @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c104HalfELb0EEEvPKlPT_S6_PKS5_iiiiii(i64* %110, %"class.caffe2::TypeMeta"* %114, %"class.caffe2::TypeMeta"* %118, %"class.caffe2::TypeMeta"* %122, i32 %125, i32 %128, i32 %131, i32 %134, i32 %137, i32 %140)
  br label %141

141:                                              ; preds = %106, %79
  br label %142

142:                                              ; preds = %141, %78
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define internal void @_ZZZ16rotary_embeddingRN2at6TensorES1_S1_iS1_bENKUlvE_clEvENKUlvE1_clEv(%class.anon.412* nonnull align 8 dereferenceable(112) %0) #4 align 2 {
  %2 = alloca %class.anon.412*, align 8
  %3 = alloca %struct.dim3, align 4
  %4 = alloca %struct.dim3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 4
  %7 = alloca %struct.dim3, align 4
  %8 = alloca %struct.dim3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca { i64, i32 }, align 4
  store %class.anon.412* %0, %class.anon.412** %2, align 8
  %11 = load %class.anon.412*, %class.anon.412** %2, align 8
  %12 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 0
  %13 = load i8*, i8** %12, align 8
  %14 = load i8, i8* %13, align 1
  %15 = trunc i8 %14 to i1
  br i1 %15, label %16, label %79

16:                                               ; preds = %1
  %17 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 1
  %18 = load %struct.dim3*, %struct.dim3** %17, align 8
  %19 = bitcast %struct.dim3* %3 to i8*
  %20 = bitcast %struct.dim3* %18 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %19, i8* align 4 %20, i64 12, i1 false)
  %21 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 2
  %22 = load %struct.dim3*, %struct.dim3** %21, align 8
  %23 = bitcast %struct.dim3* %4 to i8*
  %24 = bitcast %struct.dim3* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %23, i8* align 4 %24, i64 12, i1 false)
  %25 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 3
  %26 = load %struct.CUstream_st**, %struct.CUstream_st*** %25, align 8
  %27 = load %struct.CUstream_st*, %struct.CUstream_st** %26, align 8
  %28 = bitcast %struct.CUstream_st* %27 to i8*
  %29 = bitcast { i64, i32 }* %5 to i8*
  %30 = bitcast %struct.dim3* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %29, i8* align 4 %30, i64 12, i1 false)
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %32 = load i64, i64* %31, align 4
  %33 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %34 = load i32, i32* %33, align 4
  %35 = bitcast { i64, i32 }* %6 to i8*
  %36 = bitcast %struct.dim3* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %35, i8* align 4 %36, i64 12, i1 false)
  %37 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  %38 = load i64, i64* %37, align 4
  %39 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = call i32 @__cudaPushCallConfiguration(i64 %32, i32 %34, i64 %38, i32 %40, i64 0, i8* %28)
  %42 = icmp ne i32 %41, 0
  br i1 %42, label %78, label %43

43:                                               ; preds = %16
  %44 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 4
  %45 = load %"class.at::Tensor"*, %"class.at::Tensor"** %44, align 8
  %46 = bitcast %"class.at::Tensor"* %45 to %"class.at::TensorBase"*
  %47 = call i64* @_ZNK2at10TensorBase8data_ptrIlEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %46)
  %48 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 5
  %49 = load %"class.at::Tensor"*, %"class.at::Tensor"** %48, align 8
  %50 = bitcast %"class.at::Tensor"* %49 to %"class.at::TensorBase"*
  %51 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %50)
  %52 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 6
  %53 = load %"class.at::Tensor"*, %"class.at::Tensor"** %52, align 8
  %54 = bitcast %"class.at::Tensor"* %53 to %"class.at::TensorBase"*
  %55 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %54)
  %56 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 7
  %57 = load %"class.at::Tensor"*, %"class.at::Tensor"** %56, align 8
  %58 = bitcast %"class.at::Tensor"* %57 to %"class.at::TensorBase"*
  %59 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %58)
  %60 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 8
  %61 = load i32*, i32** %60, align 8
  %62 = load i32, i32* %61, align 4
  %63 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 9
  %64 = load i32*, i32** %63, align 8
  %65 = load i32, i32* %64, align 4
  %66 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 10
  %67 = load i32*, i32** %66, align 8
  %68 = load i32, i32* %67, align 4
  %69 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 11
  %70 = load i32*, i32** %69, align 8
  %71 = load i32, i32* %70, align 4
  %72 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 12
  %73 = load i32*, i32** %72, align 8
  %74 = load i32, i32* %73, align 4
  %75 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 13
  %76 = load i32*, i32** %75, align 8
  %77 = load i32, i32* %76, align 4
  call void @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c108BFloat16ELb1EEEvPKlPT_S6_PKS5_iiiiii(i64* %47, %"class.caffe2::TypeMeta"* %51, %"class.caffe2::TypeMeta"* %55, %"class.caffe2::TypeMeta"* %59, i32 %62, i32 %65, i32 %68, i32 %71, i32 %74, i32 %77)
  br label %78

78:                                               ; preds = %43, %16
  br label %142

79:                                               ; preds = %1
  %80 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 1
  %81 = load %struct.dim3*, %struct.dim3** %80, align 8
  %82 = bitcast %struct.dim3* %7 to i8*
  %83 = bitcast %struct.dim3* %81 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %82, i8* align 4 %83, i64 12, i1 false)
  %84 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 2
  %85 = load %struct.dim3*, %struct.dim3** %84, align 8
  %86 = bitcast %struct.dim3* %8 to i8*
  %87 = bitcast %struct.dim3* %85 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %86, i8* align 4 %87, i64 12, i1 false)
  %88 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 3
  %89 = load %struct.CUstream_st**, %struct.CUstream_st*** %88, align 8
  %90 = load %struct.CUstream_st*, %struct.CUstream_st** %89, align 8
  %91 = bitcast %struct.CUstream_st* %90 to i8*
  %92 = bitcast { i64, i32 }* %9 to i8*
  %93 = bitcast %struct.dim3* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %92, i8* align 4 %93, i64 12, i1 false)
  %94 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 0
  %95 = load i64, i64* %94, align 4
  %96 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 1
  %97 = load i32, i32* %96, align 4
  %98 = bitcast { i64, i32 }* %10 to i8*
  %99 = bitcast %struct.dim3* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %98, i8* align 4 %99, i64 12, i1 false)
  %100 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 0
  %101 = load i64, i64* %100, align 4
  %102 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %10, i32 0, i32 1
  %103 = load i32, i32* %102, align 4
  %104 = call i32 @__cudaPushCallConfiguration(i64 %95, i32 %97, i64 %101, i32 %103, i64 0, i8* %91)
  %105 = icmp ne i32 %104, 0
  br i1 %105, label %141, label %106

106:                                              ; preds = %79
  %107 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 4
  %108 = load %"class.at::Tensor"*, %"class.at::Tensor"** %107, align 8
  %109 = bitcast %"class.at::Tensor"* %108 to %"class.at::TensorBase"*
  %110 = call i64* @_ZNK2at10TensorBase8data_ptrIlEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %109)
  %111 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 5
  %112 = load %"class.at::Tensor"*, %"class.at::Tensor"** %111, align 8
  %113 = bitcast %"class.at::Tensor"* %112 to %"class.at::TensorBase"*
  %114 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %113)
  %115 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 6
  %116 = load %"class.at::Tensor"*, %"class.at::Tensor"** %115, align 8
  %117 = bitcast %"class.at::Tensor"* %116 to %"class.at::TensorBase"*
  %118 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %117)
  %119 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 7
  %120 = load %"class.at::Tensor"*, %"class.at::Tensor"** %119, align 8
  %121 = bitcast %"class.at::Tensor"* %120 to %"class.at::TensorBase"*
  %122 = call %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %121)
  %123 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 8
  %124 = load i32*, i32** %123, align 8
  %125 = load i32, i32* %124, align 4
  %126 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 9
  %127 = load i32*, i32** %126, align 8
  %128 = load i32, i32* %127, align 4
  %129 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 10
  %130 = load i32*, i32** %129, align 8
  %131 = load i32, i32* %130, align 4
  %132 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 11
  %133 = load i32*, i32** %132, align 8
  %134 = load i32, i32* %133, align 4
  %135 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 12
  %136 = load i32*, i32** %135, align 8
  %137 = load i32, i32* %136, align 4
  %138 = getelementptr inbounds %class.anon.412, %class.anon.412* %11, i32 0, i32 13
  %139 = load i32*, i32** %138, align 8
  %140 = load i32, i32* %139, align 4
  call void @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c108BFloat16ELb0EEEvPKlPT_S6_PKS5_iiiiii(i64* %110, %"class.caffe2::TypeMeta"* %114, %"class.caffe2::TypeMeta"* %118, %"class.caffe2::TypeMeta"* %122, i32 %125, i32 %128, i32 %131, i32 %134, i32 %137, i32 %140)
  br label %141

141:                                              ; preds = %106, %79
  br label %142

142:                                              ; preds = %141, %78
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i8* @_ZN3c108toStringENS_10ScalarTypeE(i8 signext %0) #6 comdat {
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
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.156, i64 0, i64 0), i8** %2, align 8
  br label %51

6:                                                ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.157, i64 0, i64 0), i8** %2, align 8
  br label %51

7:                                                ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.158, i64 0, i64 0), i8** %2, align 8
  br label %51

8:                                                ; preds = %1
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.159, i64 0, i64 0), i8** %2, align 8
  br label %51

9:                                                ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.160, i64 0, i64 0), i8** %2, align 8
  br label %51

10:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.161, i64 0, i64 0), i8** %2, align 8
  br label %51

11:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.162, i64 0, i64 0), i8** %2, align 8
  br label %51

12:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.163, i64 0, i64 0), i8** %2, align 8
  br label %51

13:                                               ; preds = %1
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.164, i64 0, i64 0), i8** %2, align 8
  br label %51

14:                                               ; preds = %1
  store i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.165, i64 0, i64 0), i8** %2, align 8
  br label %51

15:                                               ; preds = %1
  store i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.166, i64 0, i64 0), i8** %2, align 8
  br label %51

16:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.167, i64 0, i64 0), i8** %2, align 8
  br label %51

17:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.168, i64 0, i64 0), i8** %2, align 8
  br label %51

18:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.169, i64 0, i64 0), i8** %2, align 8
  br label %51

19:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.170, i64 0, i64 0), i8** %2, align 8
  br label %51

20:                                               ; preds = %1
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.171, i64 0, i64 0), i8** %2, align 8
  br label %51

21:                                               ; preds = %1
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.172, i64 0, i64 0), i8** %2, align 8
  br label %51

22:                                               ; preds = %1
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.173, i64 0, i64 0), i8** %2, align 8
  br label %51

23:                                               ; preds = %1
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.174, i64 0, i64 0), i8** %2, align 8
  br label %51

24:                                               ; preds = %1
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.175, i64 0, i64 0), i8** %2, align 8
  br label %51

25:                                               ; preds = %1
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.176, i64 0, i64 0), i8** %2, align 8
  br label %51

26:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.177, i64 0, i64 0), i8** %2, align 8
  br label %51

27:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.178, i64 0, i64 0), i8** %2, align 8
  br label %51

28:                                               ; preds = %1
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.179, i64 0, i64 0), i8** %2, align 8
  br label %51

29:                                               ; preds = %1
  store i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.180, i64 0, i64 0), i8** %2, align 8
  br label %51

30:                                               ; preds = %1
  store i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.181, i64 0, i64 0), i8** %2, align 8
  br label %51

31:                                               ; preds = %1
  store i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.182, i64 0, i64 0), i8** %2, align 8
  br label %51

32:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.183, i64 0, i64 0), i8** %2, align 8
  br label %51

33:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.184, i64 0, i64 0), i8** %2, align 8
  br label %51

34:                                               ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.185, i64 0, i64 0), i8** %2, align 8
  br label %51

35:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.186, i64 0, i64 0), i8** %2, align 8
  br label %51

36:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.187, i64 0, i64 0), i8** %2, align 8
  br label %51

37:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.188, i64 0, i64 0), i8** %2, align 8
  br label %51

38:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.189, i64 0, i64 0), i8** %2, align 8
  br label %51

39:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.190, i64 0, i64 0), i8** %2, align 8
  br label %51

40:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.191, i64 0, i64 0), i8** %2, align 8
  br label %51

41:                                               ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.192, i64 0, i64 0), i8** %2, align 8
  br label %51

42:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.193, i64 0, i64 0), i8** %2, align 8
  br label %51

43:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.194, i64 0, i64 0), i8** %2, align 8
  br label %51

44:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.195, i64 0, i64 0), i8** %2, align 8
  br label %51

45:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.196, i64 0, i64 0), i8** %2, align 8
  br label %51

46:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.197, i64 0, i64 0), i8** %2, align 8
  br label %51

47:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.198, i64 0, i64 0), i8** %2, align 8
  br label %51

48:                                               ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.199, i64 0, i64 0), i8** %2, align 8
  br label %51

49:                                               ; preds = %1
  store i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.200, i64 0, i64 0), i8** %2, align 8
  br label %51

50:                                               ; preds = %1
  store i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.201, i64 0, i64 0), i8** %2, align 8
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
declare dso_local void @_ZN3c106detail14torchCheckFailEPKcS2_jRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(i8*, i8*, i32, %"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32)) #7

; Function Attrs: nounwind
declare dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* nonnull align 8 dereferenceable(32)) unnamed_addr #2

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

declare dso_local void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112)) unnamed_addr #1

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

declare dso_local void @_ZNKSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEE3strEv(%"class.std::__cxx11::basic_string"* sret(%"class.std::__cxx11::basic_string") align 8, %"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112)) #1

; Function Attrs: nounwind
declare dso_local void @_ZNSt7__cxx1119basic_ostringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_ostringstream"* nonnull align 8 dereferenceable(112)) unnamed_addr #2

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

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8*) #1

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8 signext) #1

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #8

declare dso_local i32 @__cudaPushCallConfiguration(i64, i32, i64, i32, i64, i8*) #1

declare dso_local i64* @_ZNK2at10TensorBase8data_ptrIlEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8)) #1

declare dso_local %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c108BFloat16EEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8)) #1

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c108BFloat16ELb1EEEvPKlPT_S6_PKS5_iiiiii(i64* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, %"class.caffe2::TypeMeta"* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #9 {
  %11 = alloca i64*, align 8
  %12 = alloca %"class.caffe2::TypeMeta"*, align 8
  %13 = alloca %"class.caffe2::TypeMeta"*, align 8
  %14 = alloca %"class.caffe2::TypeMeta"*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca %struct.dim3, align 8
  %22 = alloca %struct.dim3, align 8
  %23 = alloca i64, align 8
  %24 = alloca i8*, align 8
  %25 = alloca { i64, i32 }, align 8
  %26 = alloca { i64, i32 }, align 8
  store i64* %0, i64** %11, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %12, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %13, align 8
  store %"class.caffe2::TypeMeta"* %3, %"class.caffe2::TypeMeta"** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %27 = alloca i8*, i64 10, align 16
  %28 = bitcast i64** %11 to i8*
  %29 = getelementptr i8*, i8** %27, i32 0
  store i8* %28, i8** %29, align 8
  %30 = bitcast %"class.caffe2::TypeMeta"** %12 to i8*
  %31 = getelementptr i8*, i8** %27, i32 1
  store i8* %30, i8** %31, align 8
  %32 = bitcast %"class.caffe2::TypeMeta"** %13 to i8*
  %33 = getelementptr i8*, i8** %27, i32 2
  store i8* %32, i8** %33, align 8
  %34 = bitcast %"class.caffe2::TypeMeta"** %14 to i8*
  %35 = getelementptr i8*, i8** %27, i32 3
  store i8* %34, i8** %35, align 8
  %36 = bitcast i32* %15 to i8*
  %37 = getelementptr i8*, i8** %27, i32 4
  store i8* %36, i8** %37, align 8
  %38 = bitcast i32* %16 to i8*
  %39 = getelementptr i8*, i8** %27, i32 5
  store i8* %38, i8** %39, align 8
  %40 = bitcast i32* %17 to i8*
  %41 = getelementptr i8*, i8** %27, i32 6
  store i8* %40, i8** %41, align 8
  %42 = bitcast i32* %18 to i8*
  %43 = getelementptr i8*, i8** %27, i32 7
  store i8* %42, i8** %43, align 8
  %44 = bitcast i32* %19 to i8*
  %45 = getelementptr i8*, i8** %27, i32 8
  store i8* %44, i8** %45, align 8
  %46 = bitcast i32* %20 to i8*
  %47 = getelementptr i8*, i8** %27, i32 9
  store i8* %46, i8** %47, align 8
  %48 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %21, %struct.dim3* %22, i64* %23, i8** %24)
  %49 = load i64, i64* %23, align 8
  %50 = load i8*, i8** %24, align 8
  %51 = bitcast { i64, i32 }* %25 to i8*
  %52 = bitcast %struct.dim3* %21 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %51, i8* align 8 %52, i64 12, i1 false)
  %53 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 0
  %54 = load i64, i64* %53, align 8
  %55 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 1
  %56 = load i32, i32* %55, align 8
  %57 = bitcast { i64, i32 }* %26 to i8*
  %58 = bitcast %struct.dim3* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %57, i8* align 8 %58, i64 12, i1 false)
  %59 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 0
  %60 = load i64, i64* %59, align 8
  %61 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 1
  %62 = load i32, i32* %61, align 8
  %63 = bitcast i8* %50 to %struct.CUstream_st*
  %64 = call i32 @cudaLaunchKernel(i8* bitcast (void (i64*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c108BFloat16ELb1EEEvPKlPT_S6_PKS5_iiiiii to i8*), i64 %54, i32 %56, i64 %60, i32 %62, i8** %27, i64 %49, %struct.CUstream_st* %63)
  br label %65

65:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c108BFloat16ELb0EEEvPKlPT_S6_PKS5_iiiiii(i64* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, %"class.caffe2::TypeMeta"* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #9 {
  %11 = alloca i64*, align 8
  %12 = alloca %"class.caffe2::TypeMeta"*, align 8
  %13 = alloca %"class.caffe2::TypeMeta"*, align 8
  %14 = alloca %"class.caffe2::TypeMeta"*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca %struct.dim3, align 8
  %22 = alloca %struct.dim3, align 8
  %23 = alloca i64, align 8
  %24 = alloca i8*, align 8
  %25 = alloca { i64, i32 }, align 8
  %26 = alloca { i64, i32 }, align 8
  store i64* %0, i64** %11, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %12, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %13, align 8
  store %"class.caffe2::TypeMeta"* %3, %"class.caffe2::TypeMeta"** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %27 = alloca i8*, i64 10, align 16
  %28 = bitcast i64** %11 to i8*
  %29 = getelementptr i8*, i8** %27, i32 0
  store i8* %28, i8** %29, align 8
  %30 = bitcast %"class.caffe2::TypeMeta"** %12 to i8*
  %31 = getelementptr i8*, i8** %27, i32 1
  store i8* %30, i8** %31, align 8
  %32 = bitcast %"class.caffe2::TypeMeta"** %13 to i8*
  %33 = getelementptr i8*, i8** %27, i32 2
  store i8* %32, i8** %33, align 8
  %34 = bitcast %"class.caffe2::TypeMeta"** %14 to i8*
  %35 = getelementptr i8*, i8** %27, i32 3
  store i8* %34, i8** %35, align 8
  %36 = bitcast i32* %15 to i8*
  %37 = getelementptr i8*, i8** %27, i32 4
  store i8* %36, i8** %37, align 8
  %38 = bitcast i32* %16 to i8*
  %39 = getelementptr i8*, i8** %27, i32 5
  store i8* %38, i8** %39, align 8
  %40 = bitcast i32* %17 to i8*
  %41 = getelementptr i8*, i8** %27, i32 6
  store i8* %40, i8** %41, align 8
  %42 = bitcast i32* %18 to i8*
  %43 = getelementptr i8*, i8** %27, i32 7
  store i8* %42, i8** %43, align 8
  %44 = bitcast i32* %19 to i8*
  %45 = getelementptr i8*, i8** %27, i32 8
  store i8* %44, i8** %45, align 8
  %46 = bitcast i32* %20 to i8*
  %47 = getelementptr i8*, i8** %27, i32 9
  store i8* %46, i8** %47, align 8
  %48 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %21, %struct.dim3* %22, i64* %23, i8** %24)
  %49 = load i64, i64* %23, align 8
  %50 = load i8*, i8** %24, align 8
  %51 = bitcast { i64, i32 }* %25 to i8*
  %52 = bitcast %struct.dim3* %21 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %51, i8* align 8 %52, i64 12, i1 false)
  %53 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 0
  %54 = load i64, i64* %53, align 8
  %55 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 1
  %56 = load i32, i32* %55, align 8
  %57 = bitcast { i64, i32 }* %26 to i8*
  %58 = bitcast %struct.dim3* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %57, i8* align 8 %58, i64 12, i1 false)
  %59 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 0
  %60 = load i64, i64* %59, align 8
  %61 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 1
  %62 = load i32, i32* %61, align 8
  %63 = bitcast i8* %50 to %struct.CUstream_st*
  %64 = call i32 @cudaLaunchKernel(i8* bitcast (void (i64*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c108BFloat16ELb0EEEvPKlPT_S6_PKS5_iiiiii to i8*), i64 %54, i32 %56, i64 %60, i32 %62, i8** %27, i64 %49, %struct.CUstream_st* %63)
  br label %65

65:                                               ; preds = %10
  ret void
}

declare dso_local i32 @__cudaPopCallConfiguration(%struct.dim3*, %struct.dim3*, i64*, i8**)

declare dso_local i32 @cudaLaunchKernel(i8*, i64, i32, i64, i32, i8**, i64, %struct.CUstream_st*)

declare dso_local %"class.caffe2::TypeMeta"* @_ZNK2at10TensorBase8data_ptrIN3c104HalfEEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8)) #1

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c104HalfELb1EEEvPKlPT_S6_PKS5_iiiiii(i64* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, %"class.caffe2::TypeMeta"* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #9 {
  %11 = alloca i64*, align 8
  %12 = alloca %"class.caffe2::TypeMeta"*, align 8
  %13 = alloca %"class.caffe2::TypeMeta"*, align 8
  %14 = alloca %"class.caffe2::TypeMeta"*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca %struct.dim3, align 8
  %22 = alloca %struct.dim3, align 8
  %23 = alloca i64, align 8
  %24 = alloca i8*, align 8
  %25 = alloca { i64, i32 }, align 8
  %26 = alloca { i64, i32 }, align 8
  store i64* %0, i64** %11, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %12, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %13, align 8
  store %"class.caffe2::TypeMeta"* %3, %"class.caffe2::TypeMeta"** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %27 = alloca i8*, i64 10, align 16
  %28 = bitcast i64** %11 to i8*
  %29 = getelementptr i8*, i8** %27, i32 0
  store i8* %28, i8** %29, align 8
  %30 = bitcast %"class.caffe2::TypeMeta"** %12 to i8*
  %31 = getelementptr i8*, i8** %27, i32 1
  store i8* %30, i8** %31, align 8
  %32 = bitcast %"class.caffe2::TypeMeta"** %13 to i8*
  %33 = getelementptr i8*, i8** %27, i32 2
  store i8* %32, i8** %33, align 8
  %34 = bitcast %"class.caffe2::TypeMeta"** %14 to i8*
  %35 = getelementptr i8*, i8** %27, i32 3
  store i8* %34, i8** %35, align 8
  %36 = bitcast i32* %15 to i8*
  %37 = getelementptr i8*, i8** %27, i32 4
  store i8* %36, i8** %37, align 8
  %38 = bitcast i32* %16 to i8*
  %39 = getelementptr i8*, i8** %27, i32 5
  store i8* %38, i8** %39, align 8
  %40 = bitcast i32* %17 to i8*
  %41 = getelementptr i8*, i8** %27, i32 6
  store i8* %40, i8** %41, align 8
  %42 = bitcast i32* %18 to i8*
  %43 = getelementptr i8*, i8** %27, i32 7
  store i8* %42, i8** %43, align 8
  %44 = bitcast i32* %19 to i8*
  %45 = getelementptr i8*, i8** %27, i32 8
  store i8* %44, i8** %45, align 8
  %46 = bitcast i32* %20 to i8*
  %47 = getelementptr i8*, i8** %27, i32 9
  store i8* %46, i8** %47, align 8
  %48 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %21, %struct.dim3* %22, i64* %23, i8** %24)
  %49 = load i64, i64* %23, align 8
  %50 = load i8*, i8** %24, align 8
  %51 = bitcast { i64, i32 }* %25 to i8*
  %52 = bitcast %struct.dim3* %21 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %51, i8* align 8 %52, i64 12, i1 false)
  %53 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 0
  %54 = load i64, i64* %53, align 8
  %55 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 1
  %56 = load i32, i32* %55, align 8
  %57 = bitcast { i64, i32 }* %26 to i8*
  %58 = bitcast %struct.dim3* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %57, i8* align 8 %58, i64 12, i1 false)
  %59 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 0
  %60 = load i64, i64* %59, align 8
  %61 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 1
  %62 = load i32, i32* %61, align 8
  %63 = bitcast i8* %50 to %struct.CUstream_st*
  %64 = call i32 @cudaLaunchKernel(i8* bitcast (void (i64*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c104HalfELb1EEEvPKlPT_S6_PKS5_iiiiii to i8*), i64 %54, i32 %56, i64 %60, i32 %62, i8** %27, i64 %49, %struct.CUstream_st* %63)
  br label %65

65:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c104HalfELb0EEEvPKlPT_S6_PKS5_iiiiii(i64* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, %"class.caffe2::TypeMeta"* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #9 {
  %11 = alloca i64*, align 8
  %12 = alloca %"class.caffe2::TypeMeta"*, align 8
  %13 = alloca %"class.caffe2::TypeMeta"*, align 8
  %14 = alloca %"class.caffe2::TypeMeta"*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca %struct.dim3, align 8
  %22 = alloca %struct.dim3, align 8
  %23 = alloca i64, align 8
  %24 = alloca i8*, align 8
  %25 = alloca { i64, i32 }, align 8
  %26 = alloca { i64, i32 }, align 8
  store i64* %0, i64** %11, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %12, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %13, align 8
  store %"class.caffe2::TypeMeta"* %3, %"class.caffe2::TypeMeta"** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %27 = alloca i8*, i64 10, align 16
  %28 = bitcast i64** %11 to i8*
  %29 = getelementptr i8*, i8** %27, i32 0
  store i8* %28, i8** %29, align 8
  %30 = bitcast %"class.caffe2::TypeMeta"** %12 to i8*
  %31 = getelementptr i8*, i8** %27, i32 1
  store i8* %30, i8** %31, align 8
  %32 = bitcast %"class.caffe2::TypeMeta"** %13 to i8*
  %33 = getelementptr i8*, i8** %27, i32 2
  store i8* %32, i8** %33, align 8
  %34 = bitcast %"class.caffe2::TypeMeta"** %14 to i8*
  %35 = getelementptr i8*, i8** %27, i32 3
  store i8* %34, i8** %35, align 8
  %36 = bitcast i32* %15 to i8*
  %37 = getelementptr i8*, i8** %27, i32 4
  store i8* %36, i8** %37, align 8
  %38 = bitcast i32* %16 to i8*
  %39 = getelementptr i8*, i8** %27, i32 5
  store i8* %38, i8** %39, align 8
  %40 = bitcast i32* %17 to i8*
  %41 = getelementptr i8*, i8** %27, i32 6
  store i8* %40, i8** %41, align 8
  %42 = bitcast i32* %18 to i8*
  %43 = getelementptr i8*, i8** %27, i32 7
  store i8* %42, i8** %43, align 8
  %44 = bitcast i32* %19 to i8*
  %45 = getelementptr i8*, i8** %27, i32 8
  store i8* %44, i8** %45, align 8
  %46 = bitcast i32* %20 to i8*
  %47 = getelementptr i8*, i8** %27, i32 9
  store i8* %46, i8** %47, align 8
  %48 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %21, %struct.dim3* %22, i64* %23, i8** %24)
  %49 = load i64, i64* %23, align 8
  %50 = load i8*, i8** %24, align 8
  %51 = bitcast { i64, i32 }* %25 to i8*
  %52 = bitcast %struct.dim3* %21 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %51, i8* align 8 %52, i64 12, i1 false)
  %53 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 0
  %54 = load i64, i64* %53, align 8
  %55 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 1
  %56 = load i32, i32* %55, align 8
  %57 = bitcast { i64, i32 }* %26 to i8*
  %58 = bitcast %struct.dim3* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %57, i8* align 8 %58, i64 12, i1 false)
  %59 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 0
  %60 = load i64, i64* %59, align 8
  %61 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 1
  %62 = load i32, i32* %61, align 8
  %63 = bitcast i8* %50 to %struct.CUstream_st*
  %64 = call i32 @cudaLaunchKernel(i8* bitcast (void (i64*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm38__device_stub__rotary_embedding_kernelIN3c104HalfELb0EEEvPKlPT_S6_PKS5_iiiiii to i8*), i64 %54, i32 %56, i64 %60, i32 %62, i8** %27, i64 %49, %struct.CUstream_st* %63)
  br label %65

65:                                               ; preds = %10
  ret void
}

declare dso_local float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8)) #1

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__rotary_embedding_kernelIfLb1EEEvPKlPT_S4_PKS3_iiiiii(i64* noalias %0, float* noalias %1, float* noalias %2, float* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #9 {
  %11 = alloca i64*, align 8
  %12 = alloca float*, align 8
  %13 = alloca float*, align 8
  %14 = alloca float*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca %struct.dim3, align 8
  %22 = alloca %struct.dim3, align 8
  %23 = alloca i64, align 8
  %24 = alloca i8*, align 8
  %25 = alloca { i64, i32 }, align 8
  %26 = alloca { i64, i32 }, align 8
  store i64* %0, i64** %11, align 8
  store float* %1, float** %12, align 8
  store float* %2, float** %13, align 8
  store float* %3, float** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %27 = alloca i8*, i64 10, align 16
  %28 = bitcast i64** %11 to i8*
  %29 = getelementptr i8*, i8** %27, i32 0
  store i8* %28, i8** %29, align 8
  %30 = bitcast float** %12 to i8*
  %31 = getelementptr i8*, i8** %27, i32 1
  store i8* %30, i8** %31, align 8
  %32 = bitcast float** %13 to i8*
  %33 = getelementptr i8*, i8** %27, i32 2
  store i8* %32, i8** %33, align 8
  %34 = bitcast float** %14 to i8*
  %35 = getelementptr i8*, i8** %27, i32 3
  store i8* %34, i8** %35, align 8
  %36 = bitcast i32* %15 to i8*
  %37 = getelementptr i8*, i8** %27, i32 4
  store i8* %36, i8** %37, align 8
  %38 = bitcast i32* %16 to i8*
  %39 = getelementptr i8*, i8** %27, i32 5
  store i8* %38, i8** %39, align 8
  %40 = bitcast i32* %17 to i8*
  %41 = getelementptr i8*, i8** %27, i32 6
  store i8* %40, i8** %41, align 8
  %42 = bitcast i32* %18 to i8*
  %43 = getelementptr i8*, i8** %27, i32 7
  store i8* %42, i8** %43, align 8
  %44 = bitcast i32* %19 to i8*
  %45 = getelementptr i8*, i8** %27, i32 8
  store i8* %44, i8** %45, align 8
  %46 = bitcast i32* %20 to i8*
  %47 = getelementptr i8*, i8** %27, i32 9
  store i8* %46, i8** %47, align 8
  %48 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %21, %struct.dim3* %22, i64* %23, i8** %24)
  %49 = load i64, i64* %23, align 8
  %50 = load i8*, i8** %24, align 8
  %51 = bitcast { i64, i32 }* %25 to i8*
  %52 = bitcast %struct.dim3* %21 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %51, i8* align 8 %52, i64 12, i1 false)
  %53 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 0
  %54 = load i64, i64* %53, align 8
  %55 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 1
  %56 = load i32, i32* %55, align 8
  %57 = bitcast { i64, i32 }* %26 to i8*
  %58 = bitcast %struct.dim3* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %57, i8* align 8 %58, i64 12, i1 false)
  %59 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 0
  %60 = load i64, i64* %59, align 8
  %61 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 1
  %62 = load i32, i32* %61, align 8
  %63 = bitcast i8* %50 to %struct.CUstream_st*
  %64 = call i32 @cudaLaunchKernel(i8* bitcast (void (i64*, float*, float*, float*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm38__device_stub__rotary_embedding_kernelIfLb1EEEvPKlPT_S4_PKS3_iiiiii to i8*), i64 %54, i32 %56, i64 %60, i32 %62, i8** %27, i64 %49, %struct.CUstream_st* %63)
  br label %65

65:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline norecurse optnone uwtable
define linkonce_odr dso_local void @_ZN4vllm38__device_stub__rotary_embedding_kernelIfLb0EEEvPKlPT_S4_PKS3_iiiiii(i64* noalias %0, float* noalias %1, float* noalias %2, float* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #9 {
  %11 = alloca i64*, align 8
  %12 = alloca float*, align 8
  %13 = alloca float*, align 8
  %14 = alloca float*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca %struct.dim3, align 8
  %22 = alloca %struct.dim3, align 8
  %23 = alloca i64, align 8
  %24 = alloca i8*, align 8
  %25 = alloca { i64, i32 }, align 8
  %26 = alloca { i64, i32 }, align 8
  store i64* %0, i64** %11, align 8
  store float* %1, float** %12, align 8
  store float* %2, float** %13, align 8
  store float* %3, float** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %27 = alloca i8*, i64 10, align 16
  %28 = bitcast i64** %11 to i8*
  %29 = getelementptr i8*, i8** %27, i32 0
  store i8* %28, i8** %29, align 8
  %30 = bitcast float** %12 to i8*
  %31 = getelementptr i8*, i8** %27, i32 1
  store i8* %30, i8** %31, align 8
  %32 = bitcast float** %13 to i8*
  %33 = getelementptr i8*, i8** %27, i32 2
  store i8* %32, i8** %33, align 8
  %34 = bitcast float** %14 to i8*
  %35 = getelementptr i8*, i8** %27, i32 3
  store i8* %34, i8** %35, align 8
  %36 = bitcast i32* %15 to i8*
  %37 = getelementptr i8*, i8** %27, i32 4
  store i8* %36, i8** %37, align 8
  %38 = bitcast i32* %16 to i8*
  %39 = getelementptr i8*, i8** %27, i32 5
  store i8* %38, i8** %39, align 8
  %40 = bitcast i32* %17 to i8*
  %41 = getelementptr i8*, i8** %27, i32 6
  store i8* %40, i8** %41, align 8
  %42 = bitcast i32* %18 to i8*
  %43 = getelementptr i8*, i8** %27, i32 7
  store i8* %42, i8** %43, align 8
  %44 = bitcast i32* %19 to i8*
  %45 = getelementptr i8*, i8** %27, i32 8
  store i8* %44, i8** %45, align 8
  %46 = bitcast i32* %20 to i8*
  %47 = getelementptr i8*, i8** %27, i32 9
  store i8* %46, i8** %47, align 8
  %48 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %21, %struct.dim3* %22, i64* %23, i8** %24)
  %49 = load i64, i64* %23, align 8
  %50 = load i8*, i8** %24, align 8
  %51 = bitcast { i64, i32 }* %25 to i8*
  %52 = bitcast %struct.dim3* %21 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %51, i8* align 8 %52, i64 12, i1 false)
  %53 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 0
  %54 = load i64, i64* %53, align 8
  %55 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %25, i32 0, i32 1
  %56 = load i32, i32* %55, align 8
  %57 = bitcast { i64, i32 }* %26 to i8*
  %58 = bitcast %struct.dim3* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %57, i8* align 8 %58, i64 12, i1 false)
  %59 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 0
  %60 = load i64, i64* %59, align 8
  %61 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %26, i32 0, i32 1
  %62 = load i32, i32* %61, align 8
  %63 = bitcast i8* %50 to %struct.CUstream_st*
  %64 = call i32 @cudaLaunchKernel(i8* bitcast (void (i64*, float*, float*, float*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm38__device_stub__rotary_embedding_kernelIfLb0EEEvPKlPT_S4_PKS3_iiiiii to i8*), i64 %54, i32 %56, i64 %60, i32 %62, i8** %27, i64 %49, %struct.CUstream_st* %63)
  br label %65

65:                                               ; preds = %10
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %0) #6 comdat align 2 {
  %2 = alloca %"class.c10::intrusive_ptr"*, align 8
  store %"class.c10::intrusive_ptr"* %0, %"class.c10::intrusive_ptr"** %2, align 8
  %3 = load %"class.c10::intrusive_ptr"*, %"class.c10::intrusive_ptr"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::intrusive_ptr", %"class.c10::intrusive_ptr"* %3, i32 0, i32 0
  %5 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %4, align 8
  ret %"struct.c10::TensorImpl"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i16 @_ZNK3c1010TensorImpl5dtypeEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #6 comdat align 2 {
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
  call void @_ZN6caffe28TypeMeta26error_unsupported_typemetaES0_(i16 %14) #17
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK6caffe28TypeMeta12isScalarTypeEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #6 comdat align 2 {
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
declare dso_local void @_ZN6caffe28TypeMeta26error_unsupported_typemetaES0_(i16) #7

declare dso_local %struct.CUstream_st* @_ZNK3c104cuda10CUDAStream6streamEv(%"class.c10::cuda::CUDAStream"* nonnull align 8 dereferenceable(16)) #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64*, i64 } @_ZNK2at10TensorBase7stridesEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0) #4 comdat align 2 {
  %2 = alloca %"class.c10::ArrayRef", align 8
  %3 = alloca %"class.at::TensorBase"*, align 8
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %3, align 8
  %4 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %3, align 8
  %5 = getelementptr inbounds %"class.at::TensorBase", %"class.at::TensorBase"* %4, i32 0, i32 0
  %6 = call %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %5) #3
  %7 = call { i64*, i64 } @_ZNK3c1010TensorImpl7stridesEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6)
  %8 = bitcast %"class.c10::ArrayRef"* %2 to { i64*, i64 }*
  %9 = getelementptr inbounds { i64*, i64 }, { i64*, i64 }* %8, i32 0, i32 0
  %10 = extractvalue { i64*, i64 } %7, 0
  store i64* %10, i64** %9, align 8
  %11 = getelementptr inbounds { i64*, i64 }, { i64*, i64 }* %8, i32 0, i32 1
  %12 = extractvalue { i64*, i64 } %7, 1
  store i64 %12, i64* %11, align 8
  %13 = bitcast %"class.c10::ArrayRef"* %2 to { i64*, i64 }*
  %14 = load { i64*, i64 }, { i64*, i64 }* %13, align 8
  ret { i64*, i64 } %14
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c108ArrayRefIlE4sizeEv(%"class.c10::ArrayRef"* nonnull align 8 dereferenceable(16) %0) #6 comdat align 2 {
  %2 = alloca %"class.c10::ArrayRef"*, align 8
  store %"class.c10::ArrayRef"* %0, %"class.c10::ArrayRef"** %2, align 8
  %3 = load %"class.c10::ArrayRef"*, %"class.c10::ArrayRef"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::ArrayRef", %"class.c10::ArrayRef"* %3, i32 0, i32 1
  %5 = load i64, i64* %4, align 8
  ret i64 %5
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
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) i64* @_ZNK3c108ArrayRefIlEixEm(%"class.c10::ArrayRef"* nonnull align 8 dereferenceable(16) %0, i64 %1) #6 comdat align 2 {
  %3 = alloca %"class.c10::ArrayRef"*, align 8
  %4 = alloca i64, align 8
  store %"class.c10::ArrayRef"* %0, %"class.c10::ArrayRef"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"class.c10::ArrayRef"*, %"class.c10::ArrayRef"** %3, align 8
  %6 = getelementptr inbounds %"class.c10::ArrayRef", %"class.c10::ArrayRef"* %5, i32 0, i32 0
  %7 = load i64*, i64** %6, align 8
  %8 = load i64, i64* %4, align 8
  %9 = getelementptr inbounds i64, i64* %7, i64 %8
  ret i64* %9
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
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) i64* @_ZSt4moveIRlEONSt16remove_referenceIT_E4typeEOS2_(i64* nonnull align 8 dereferenceable(8) %0) #6 comdat {
  %2 = alloca i64*, align 8
  store i64* %0, i64** %2, align 8
  %3 = load i64*, i64** %2, align 8
  ret i64* %3
}

declare dso_local i64 @_ZN3c106detail19maybe_wrap_dim_slowIlEET_S2_S2_b(i64, i64, i1 zeroext) #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local { i64*, i64 } @_ZNK3c1010TensorImpl7stridesEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #4 comdat align 2 {
  %2 = alloca %"class.c10::ArrayRef", align 8
  %3 = alloca %"struct.c10::TensorImpl"*, align 8
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %3, align 8
  %4 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %3, align 8
  %5 = call zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4, i8 zeroext 1)
  br i1 %5, label %6, label %17

6:                                                ; preds = %1
  %7 = bitcast %"struct.c10::TensorImpl"* %4 to { i64*, i64 } (%"struct.c10::TensorImpl"*)***
  %8 = load { i64*, i64 } (%"struct.c10::TensorImpl"*)**, { i64*, i64 } (%"struct.c10::TensorImpl"*)*** %7, align 8
  %9 = getelementptr inbounds { i64*, i64 } (%"struct.c10::TensorImpl"*)*, { i64*, i64 } (%"struct.c10::TensorImpl"*)** %8, i64 9
  %10 = load { i64*, i64 } (%"struct.c10::TensorImpl"*)*, { i64*, i64 } (%"struct.c10::TensorImpl"*)** %9, align 8
  %11 = call { i64*, i64 } %10(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4)
  %12 = bitcast %"class.c10::ArrayRef"* %2 to { i64*, i64 }*
  %13 = getelementptr inbounds { i64*, i64 }, { i64*, i64 }* %12, i32 0, i32 0
  %14 = extractvalue { i64*, i64 } %11, 0
  store i64* %14, i64** %13, align 8
  %15 = getelementptr inbounds { i64*, i64 }, { i64*, i64 }* %12, i32 0, i32 1
  %16 = extractvalue { i64*, i64 } %11, 1
  store i64 %16, i64* %15, align 8
  br label %25

17:                                               ; preds = %1
  %18 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %4, i32 0, i32 6
  %19 = call { i64*, i64 } @_ZNK3c104impl15SizesAndStrides16strides_arrayrefEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %18) #3
  %20 = bitcast %"class.c10::ArrayRef"* %2 to { i64*, i64 }*
  %21 = getelementptr inbounds { i64*, i64 }, { i64*, i64 }* %20, i32 0, i32 0
  %22 = extractvalue { i64*, i64 } %19, 0
  store i64* %22, i64** %21, align 8
  %23 = getelementptr inbounds { i64*, i64 }, { i64*, i64 }* %20, i32 0, i32 1
  %24 = extractvalue { i64*, i64 } %19, 1
  store i64 %24, i64* %23, align 8
  br label %25

25:                                               ; preds = %17, %6
  %26 = bitcast %"class.c10::ArrayRef"* %2 to { i64*, i64 }*
  %27 = load { i64*, i64 }, { i64*, i64 }* %26, align 8
  ret { i64*, i64 } %27
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0, i8 zeroext %1) #6 comdat align 2 {
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

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local { i64*, i64 } @_ZNK3c104impl15SizesAndStrides16strides_arrayrefEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #6 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.c10::ArrayRef", align 8
  %3 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %3, align 8
  %4 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %3, align 8
  %5 = call i64* @_ZNK3c104impl15SizesAndStrides12strides_dataEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %4) #3
  %6 = call i64 @_ZNK3c104impl15SizesAndStrides4sizeEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %4) #3
  invoke void @_ZN3c108ArrayRefIlEC2EPKlm(%"class.c10::ArrayRef"* nonnull align 8 dereferenceable(16) %2, i64* %5, i64 %6)
          to label %7 unwind label %10

7:                                                ; preds = %1
  %8 = bitcast %"class.c10::ArrayRef"* %2 to { i64*, i64 }*
  %9 = load { i64*, i64 }, { i64*, i64 }* %8, align 8
  ret { i64*, i64 } %9

10:                                               ; preds = %1
  %11 = landingpad { i8*, i32 }
          catch i8* null
  %12 = extractvalue { i8*, i32 } %11, 0
  call void @__clang_call_terminate(i8* %12) #18
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i64* @_ZNK3c104impl15SizesAndStrides12strides_dataEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #6 comdat align 2 {
  %2 = alloca i64*, align 8
  %3 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %3, align 8
  %4 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %3, align 8
  %5 = call zeroext i1 @_ZNK3c104impl15SizesAndStrides8isInlineEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %4) #3
  br i1 %5, label %6, label %10

6:                                                ; preds = %1
  %7 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %4, i32 0, i32 1
  %8 = bitcast %union.anon.52* %7 to [10 x i64]*
  %9 = getelementptr inbounds [10 x i64], [10 x i64]* %8, i64 0, i64 5
  store i64* %9, i64** %2, align 8
  br label %16

10:                                               ; preds = %1
  %11 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %4, i32 0, i32 1
  %12 = bitcast %union.anon.52* %11 to i64**
  %13 = load i64*, i64** %12, align 8
  %14 = call i64 @_ZNK3c104impl15SizesAndStrides4sizeEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %4) #3
  %15 = getelementptr inbounds i64, i64* %13, i64 %14
  store i64* %15, i64** %2, align 8
  br label %16

16:                                               ; preds = %10, %6
  %17 = load i64*, i64** %2, align 8
  ret i64* %17
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c104impl15SizesAndStrides4sizeEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #6 comdat align 2 {
  %2 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %2, align 8
  %3 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %3, i32 0, i32 0
  %5 = load i64, i64* %4, align 8
  ret i64 %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c108ArrayRefIlEC2EPKlm(%"class.c10::ArrayRef"* nonnull align 8 dereferenceable(16) %0, i64* %1, i64 %2) unnamed_addr #10 comdat align 2 {
  %4 = alloca %"class.c10::ArrayRef"*, align 8
  %5 = alloca i64*, align 8
  %6 = alloca i64, align 8
  store %"class.c10::ArrayRef"* %0, %"class.c10::ArrayRef"** %4, align 8
  store i64* %1, i64** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.c10::ArrayRef"*, %"class.c10::ArrayRef"** %4, align 8
  %8 = getelementptr inbounds %"class.c10::ArrayRef", %"class.c10::ArrayRef"* %7, i32 0, i32 0
  %9 = load i64*, i64** %5, align 8
  store i64* %9, i64** %8, align 8
  %10 = getelementptr inbounds %"class.c10::ArrayRef", %"class.c10::ArrayRef"* %7, i32 0, i32 1
  %11 = load i64, i64* %6, align 8
  store i64 %11, i64* %10, align 8
  call void @_ZN3c108ArrayRefIlE26debugCheckNullptrInvariantEv(%"class.c10::ArrayRef"* nonnull align 8 dereferenceable(16) %7)
  ret void
}

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8* %0) #11 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #3
  call void @_ZSt9terminatev() #18
  unreachable
}

declare dso_local i8* @__cxa_begin_catch(i8*)

declare dso_local void @_ZSt9terminatev()

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c108ArrayRefIlE26debugCheckNullptrInvariantEv(%"class.c10::ArrayRef"* nonnull align 8 dereferenceable(16) %0) #4 comdat align 2 {
  %2 = alloca %"class.c10::ArrayRef"*, align 8
  store %"class.c10::ArrayRef"* %0, %"class.c10::ArrayRef"** %2, align 8
  %3 = load %"class.c10::ArrayRef"*, %"class.c10::ArrayRef"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::ArrayRef", %"class.c10::ArrayRef"* %3, i32 0, i32 0
  %5 = load i64*, i64** %4, align 8
  %6 = icmp ne i64* %5, null
  br i1 %6, label %13, label %7

7:                                                ; preds = %1
  %8 = getelementptr inbounds %"class.c10::ArrayRef", %"class.c10::ArrayRef"* %3, i32 0, i32 1
  %9 = load i64, i64* %8, align 8
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %13, label %11

11:                                               ; preds = %7
  %12 = call i8* @_ZN3c103strIJA94_cEEEDcDpRKT_([94 x i8]* nonnull align 1 dereferenceable(94) @.str.151)
  call void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_S2_(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__func__._ZN3c108ArrayRefIlE26debugCheckNullptrInvariantEv, i64 0, i64 0), i8* getelementptr inbounds ([102 x i8], [102 x i8]* @.str.149, i64 0, i64 0), i32 64, i8* getelementptr inbounds ([198 x i8], [198 x i8]* @.str.150, i64 0, i64 0), i8* %12) #17
  unreachable

13:                                               ; preds = %7, %1
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i8* @_ZN3c103strIJA94_cEEEDcDpRKT_([94 x i8]* nonnull align 1 dereferenceable(94) %0) #4 comdat {
  %2 = alloca [94 x i8]*, align 8
  store [94 x i8]* %0, [94 x i8]** %2, align 8
  %3 = load [94 x i8]*, [94 x i8]** %2, align 8
  %4 = getelementptr inbounds [94 x i8], [94 x i8]* %3, i64 0, i64 0
  %5 = call i8* @_ZN3c106detail12_str_wrapperIJPKcEE4callES3_(i8* %4)
  ret i8* %5
}

; Function Attrs: noreturn
declare dso_local void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_S2_(i8*, i8*, i32, i8*, i8*) #7

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i8* @_ZN3c106detail12_str_wrapperIJPKcEE4callES3_(i8* %0) #6 comdat align 2 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  ret i8* %3
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c104impl15SizesAndStrides8isInlineEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #6 comdat align 2 {
  %2 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %2, align 8
  %3 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %3, i32 0, i32 0
  %5 = load i64, i64* %4, align 8
  %6 = icmp ule i64 %5, 5
  ret i1 %6
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

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c104impl15SizesAndStrides17size_at_uncheckedEm(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0, i64 %1) #6 comdat align 2 {
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
define linkonce_odr dso_local i64* @_ZNK3c104impl15SizesAndStrides10sizes_dataEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #6 comdat align 2 {
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

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23rotary_embedding_kernelIfLb1EEEvPKlPT_S4_PKS3_iiiiii(i64* noalias %0, float* noalias %1, float* noalias %2, float* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #12 {
  %11 = alloca i64*, align 8
  %12 = alloca float*, align 8
  %13 = alloca float*, align 8
  %14 = alloca float*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i64, align 8
  %23 = alloca float*, align 8
  %24 = alloca i32, align 4
  %25 = alloca float*, align 8
  %26 = alloca float*, align 8
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  store i64* %0, i64** %11, align 8
  store float* %1, float** %12, align 8
  store float* %2, float** %13, align 8
  store float* %3, float** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %37 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  store i32 %37, i32* %21, align 4
  %38 = load i64*, i64** %11, align 8
  %39 = load i32, i32* %21, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i64, i64* %38, i64 %40
  %42 = load i64, i64* %41, align 8
  store i64 %42, i64* %22, align 8
  %43 = load float*, float** %14, align 8
  %44 = load i64, i64* %22, align 8
  %45 = load i32, i32* %15, align 4
  %46 = sext i32 %45 to i64
  %47 = mul nsw i64 %44, %46
  %48 = getelementptr inbounds float, float* %43, i64 %47
  store float* %48, float** %23, align 8
  %49 = load i32, i32* %15, align 4
  %50 = sdiv i32 %49, 2
  store i32 %50, i32* %24, align 4
  %51 = load float*, float** %23, align 8
  store float* %51, float** %25, align 8
  %52 = load float*, float** %23, align 8
  %53 = load i32, i32* %24, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds float, float* %52, i64 %54
  store float* %55, float** %26, align 8
  %56 = load i32, i32* %18, align 4
  %57 = load i32, i32* %24, align 4
  %58 = mul nsw i32 %56, %57
  store i32 %58, i32* %27, align 4
  %59 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %59, i32* %28, align 4
  br label %60

60:                                               ; preds = %86, %10
  %61 = load i32, i32* %28, align 4
  %62 = load i32, i32* %27, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %90

64:                                               ; preds = %60
  %65 = load i32, i32* %28, align 4
  %66 = load i32, i32* %24, align 4
  %67 = sdiv i32 %65, %66
  store i32 %67, i32* %29, align 4
  %68 = load i32, i32* %21, align 4
  %69 = load i32, i32* %16, align 4
  %70 = mul nsw i32 %68, %69
  %71 = load i32, i32* %29, align 4
  %72 = load i32, i32* %20, align 4
  %73 = mul nsw i32 %71, %72
  %74 = add nsw i32 %70, %73
  store i32 %74, i32* %30, align 4
  %75 = load i32, i32* %28, align 4
  %76 = load i32, i32* %24, align 4
  %77 = srem i32 %75, %76
  store i32 %77, i32* %31, align 4
  %78 = load float*, float** %12, align 8
  %79 = load i32, i32* %30, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds float, float* %78, i64 %80
  %82 = load float*, float** %25, align 8
  %83 = load float*, float** %26, align 8
  %84 = load i32, i32* %31, align 4
  %85 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIfLb1EEEvPT_PKS1_S4_ii(float* %81, float* %82, float* %83, i32 %84, i32 %85) #19
  br label %86

86:                                               ; preds = %64
  %87 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %88 = load i32, i32* %28, align 4
  %89 = add i32 %88, %87
  store i32 %89, i32* %28, align 4
  br label %60, !llvm.loop !14

90:                                               ; preds = %60
  %91 = load i32, i32* %19, align 4
  %92 = load i32, i32* %24, align 4
  %93 = mul nsw i32 %91, %92
  store i32 %93, i32* %32, align 4
  %94 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %94, i32* %33, align 4
  br label %95

95:                                               ; preds = %121, %90
  %96 = load i32, i32* %33, align 4
  %97 = load i32, i32* %32, align 4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %125

99:                                               ; preds = %95
  %100 = load i32, i32* %33, align 4
  %101 = load i32, i32* %24, align 4
  %102 = sdiv i32 %100, %101
  store i32 %102, i32* %34, align 4
  %103 = load i32, i32* %21, align 4
  %104 = load i32, i32* %17, align 4
  %105 = mul nsw i32 %103, %104
  %106 = load i32, i32* %34, align 4
  %107 = load i32, i32* %20, align 4
  %108 = mul nsw i32 %106, %107
  %109 = add nsw i32 %105, %108
  store i32 %109, i32* %35, align 4
  %110 = load i32, i32* %33, align 4
  %111 = load i32, i32* %24, align 4
  %112 = srem i32 %110, %111
  store i32 %112, i32* %36, align 4
  %113 = load float*, float** %13, align 8
  %114 = load i32, i32* %35, align 4
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds float, float* %113, i64 %115
  %117 = load float*, float** %25, align 8
  %118 = load float*, float** %26, align 8
  %119 = load i32, i32* %36, align 4
  %120 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIfLb1EEEvPT_PKS1_S4_ii(float* %116, float* %117, float* %118, i32 %119, i32 %120) #19
  br label %121

121:                                              ; preds = %99
  %122 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %123 = load i32, i32* %33, align 4
  %124 = add i32 %123, %122
  store i32 %124, i32* %33, align 4
  br label %95, !llvm.loop !16

125:                                              ; preds = %95
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #13

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #13

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm22apply_rotary_embeddingIfLb1EEEvPT_PKS1_S4_ii(float* noalias %0, float* noalias %1, float* noalias %2, i32 %3, i32 %4) #14 comdat {
  %6 = alloca float*, align 8
  %7 = alloca float*, align 8
  %8 = alloca float*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca float, align 4
  %14 = alloca float, align 4
  %15 = alloca float, align 4
  %16 = alloca float, align 4
  store float* %0, float** %6, align 8
  store float* %1, float** %7, align 8
  store float* %2, float** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %17 = load i32, i32* %9, align 4
  store i32 %17, i32* %11, align 4
  %18 = load i32, i32* %10, align 4
  %19 = load i32, i32* %9, align 4
  %20 = add nsw i32 %18, %19
  store i32 %20, i32* %12, align 4
  %21 = load float*, float** %7, align 8
  %22 = load i32, i32* %11, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds float, float* %21, i64 %23
  %25 = call contract float @_Z5__ldgPKf(float* %24) #19
  store float %25, float* %13, align 4
  %26 = load float*, float** %8, align 8
  %27 = load i32, i32* %11, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds float, float* %26, i64 %28
  %30 = call contract float @_Z5__ldgPKf(float* %29) #19
  store float %30, float* %14, align 4
  %31 = load float*, float** %6, align 8
  %32 = load i32, i32* %11, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds float, float* %31, i64 %33
  %35 = load float, float* %34, align 4
  store float %35, float* %15, align 4
  %36 = load float*, float** %6, align 8
  %37 = load i32, i32* %12, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds float, float* %36, i64 %38
  %40 = load float, float* %39, align 4
  store float %40, float* %16, align 4
  %41 = load float, float* %15, align 4
  %42 = load float, float* %13, align 4
  %43 = fmul contract float %41, %42
  %44 = load float, float* %16, align 4
  %45 = load float, float* %14, align 4
  %46 = fmul contract float %44, %45
  %47 = fsub contract float %43, %46
  %48 = load float*, float** %6, align 8
  %49 = load i32, i32* %11, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds float, float* %48, i64 %50
  store float %47, float* %51, align 4
  %52 = load float, float* %16, align 4
  %53 = load float, float* %13, align 4
  %54 = fmul contract float %52, %53
  %55 = load float, float* %15, align 4
  %56 = load float, float* %14, align 4
  %57 = fmul contract float %55, %56
  %58 = fadd contract float %54, %57
  %59 = load float*, float** %6, align 8
  %60 = load i32, i32* %12, align 4
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds float, float* %59, i64 %61
  store float %58, float* %62, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #13

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_Z5__ldgPKf(float* %0) #14 comdat {
  %2 = alloca float*, align 8
  store float* %0, float** %2, align 8
  %3 = load float*, float** %2, align 8
  %4 = call contract float @llvm.nvvm.ldg.global.f.f32.p0f32(float* %3, i32 4)
  ret float %4
}

; Function Attrs: argmemonly nounwind readonly
declare float @llvm.nvvm.ldg.global.f.f32.p0f32(float* nocapture, i32) #15

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23rotary_embedding_kernelIfLb0EEEvPKlPT_S4_PKS3_iiiiii(i64* noalias %0, float* noalias %1, float* noalias %2, float* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #12 {
  %11 = alloca i64*, align 8
  %12 = alloca float*, align 8
  %13 = alloca float*, align 8
  %14 = alloca float*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i64, align 8
  %23 = alloca float*, align 8
  %24 = alloca i32, align 4
  %25 = alloca float*, align 8
  %26 = alloca float*, align 8
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  store i64* %0, i64** %11, align 8
  store float* %1, float** %12, align 8
  store float* %2, float** %13, align 8
  store float* %3, float** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %37 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  store i32 %37, i32* %21, align 4
  %38 = load i64*, i64** %11, align 8
  %39 = load i32, i32* %21, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i64, i64* %38, i64 %40
  %42 = load i64, i64* %41, align 8
  store i64 %42, i64* %22, align 8
  %43 = load float*, float** %14, align 8
  %44 = load i64, i64* %22, align 8
  %45 = load i32, i32* %15, align 4
  %46 = sext i32 %45 to i64
  %47 = mul nsw i64 %44, %46
  %48 = getelementptr inbounds float, float* %43, i64 %47
  store float* %48, float** %23, align 8
  %49 = load i32, i32* %15, align 4
  %50 = sdiv i32 %49, 2
  store i32 %50, i32* %24, align 4
  %51 = load float*, float** %23, align 8
  store float* %51, float** %25, align 8
  %52 = load float*, float** %23, align 8
  %53 = load i32, i32* %24, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds float, float* %52, i64 %54
  store float* %55, float** %26, align 8
  %56 = load i32, i32* %18, align 4
  %57 = load i32, i32* %24, align 4
  %58 = mul nsw i32 %56, %57
  store i32 %58, i32* %27, align 4
  %59 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %59, i32* %28, align 4
  br label %60

60:                                               ; preds = %86, %10
  %61 = load i32, i32* %28, align 4
  %62 = load i32, i32* %27, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %90

64:                                               ; preds = %60
  %65 = load i32, i32* %28, align 4
  %66 = load i32, i32* %24, align 4
  %67 = sdiv i32 %65, %66
  store i32 %67, i32* %29, align 4
  %68 = load i32, i32* %21, align 4
  %69 = load i32, i32* %16, align 4
  %70 = mul nsw i32 %68, %69
  %71 = load i32, i32* %29, align 4
  %72 = load i32, i32* %20, align 4
  %73 = mul nsw i32 %71, %72
  %74 = add nsw i32 %70, %73
  store i32 %74, i32* %30, align 4
  %75 = load i32, i32* %28, align 4
  %76 = load i32, i32* %24, align 4
  %77 = srem i32 %75, %76
  store i32 %77, i32* %31, align 4
  %78 = load float*, float** %12, align 8
  %79 = load i32, i32* %30, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds float, float* %78, i64 %80
  %82 = load float*, float** %25, align 8
  %83 = load float*, float** %26, align 8
  %84 = load i32, i32* %31, align 4
  %85 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIfLb0EEEvPT_PKS1_S4_ii(float* %81, float* %82, float* %83, i32 %84, i32 %85) #19
  br label %86

86:                                               ; preds = %64
  %87 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %88 = load i32, i32* %28, align 4
  %89 = add i32 %88, %87
  store i32 %89, i32* %28, align 4
  br label %60, !llvm.loop !17

90:                                               ; preds = %60
  %91 = load i32, i32* %19, align 4
  %92 = load i32, i32* %24, align 4
  %93 = mul nsw i32 %91, %92
  store i32 %93, i32* %32, align 4
  %94 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %94, i32* %33, align 4
  br label %95

95:                                               ; preds = %121, %90
  %96 = load i32, i32* %33, align 4
  %97 = load i32, i32* %32, align 4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %125

99:                                               ; preds = %95
  %100 = load i32, i32* %33, align 4
  %101 = load i32, i32* %24, align 4
  %102 = sdiv i32 %100, %101
  store i32 %102, i32* %34, align 4
  %103 = load i32, i32* %21, align 4
  %104 = load i32, i32* %17, align 4
  %105 = mul nsw i32 %103, %104
  %106 = load i32, i32* %34, align 4
  %107 = load i32, i32* %20, align 4
  %108 = mul nsw i32 %106, %107
  %109 = add nsw i32 %105, %108
  store i32 %109, i32* %35, align 4
  %110 = load i32, i32* %33, align 4
  %111 = load i32, i32* %24, align 4
  %112 = srem i32 %110, %111
  store i32 %112, i32* %36, align 4
  %113 = load float*, float** %13, align 8
  %114 = load i32, i32* %35, align 4
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds float, float* %113, i64 %115
  %117 = load float*, float** %25, align 8
  %118 = load float*, float** %26, align 8
  %119 = load i32, i32* %36, align 4
  %120 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIfLb0EEEvPT_PKS1_S4_ii(float* %116, float* %117, float* %118, i32 %119, i32 %120) #19
  br label %121

121:                                              ; preds = %99
  %122 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %123 = load i32, i32* %33, align 4
  %124 = add i32 %123, %122
  store i32 %124, i32* %33, align 4
  br label %95, !llvm.loop !18

125:                                              ; preds = %95
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm22apply_rotary_embeddingIfLb0EEEvPT_PKS1_S4_ii(float* noalias %0, float* noalias %1, float* noalias %2, i32 %3, i32 %4) #14 comdat {
  %6 = alloca float*, align 8
  %7 = alloca float*, align 8
  %8 = alloca float*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca float, align 4
  %14 = alloca float, align 4
  %15 = alloca float, align 4
  %16 = alloca float, align 4
  store float* %0, float** %6, align 8
  store float* %1, float** %7, align 8
  store float* %2, float** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %17 = load i32, i32* %9, align 4
  %18 = mul nsw i32 2, %17
  store i32 %18, i32* %11, align 4
  %19 = load i32, i32* %9, align 4
  %20 = mul nsw i32 2, %19
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %12, align 4
  %22 = load float*, float** %7, align 8
  %23 = load i32, i32* %11, align 4
  %24 = sdiv i32 %23, 2
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds float, float* %22, i64 %25
  %27 = call contract float @_Z5__ldgPKf(float* %26) #19
  store float %27, float* %13, align 4
  %28 = load float*, float** %8, align 8
  %29 = load i32, i32* %11, align 4
  %30 = sdiv i32 %29, 2
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds float, float* %28, i64 %31
  %33 = call contract float @_Z5__ldgPKf(float* %32) #19
  store float %33, float* %14, align 4
  %34 = load float*, float** %6, align 8
  %35 = load i32, i32* %11, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds float, float* %34, i64 %36
  %38 = load float, float* %37, align 4
  store float %38, float* %15, align 4
  %39 = load float*, float** %6, align 8
  %40 = load i32, i32* %12, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds float, float* %39, i64 %41
  %43 = load float, float* %42, align 4
  store float %43, float* %16, align 4
  %44 = load float, float* %15, align 4
  %45 = load float, float* %13, align 4
  %46 = fmul contract float %44, %45
  %47 = load float, float* %16, align 4
  %48 = load float, float* %14, align 4
  %49 = fmul contract float %47, %48
  %50 = fsub contract float %46, %49
  %51 = load float*, float** %6, align 8
  %52 = load i32, i32* %11, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds float, float* %51, i64 %53
  store float %50, float* %54, align 4
  %55 = load float, float* %16, align 4
  %56 = load float, float* %13, align 4
  %57 = fmul contract float %55, %56
  %58 = load float, float* %15, align 4
  %59 = load float, float* %14, align 4
  %60 = fmul contract float %58, %59
  %61 = fadd contract float %57, %60
  %62 = load float*, float** %6, align 8
  %63 = load i32, i32* %12, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds float, float* %62, i64 %64
  store float %61, float* %65, align 4
  ret void
}

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23rotary_embedding_kernelIN3c104HalfELb1EEEvPKlPT_S6_PKS5_iiiiii(i64* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, %"class.caffe2::TypeMeta"* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #12 {
  %11 = alloca i64*, align 8
  %12 = alloca %"class.caffe2::TypeMeta"*, align 8
  %13 = alloca %"class.caffe2::TypeMeta"*, align 8
  %14 = alloca %"class.caffe2::TypeMeta"*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i64, align 8
  %23 = alloca %"class.caffe2::TypeMeta"*, align 8
  %24 = alloca i32, align 4
  %25 = alloca %"class.caffe2::TypeMeta"*, align 8
  %26 = alloca %"class.caffe2::TypeMeta"*, align 8
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  store i64* %0, i64** %11, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %12, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %13, align 8
  store %"class.caffe2::TypeMeta"* %3, %"class.caffe2::TypeMeta"** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %37 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  store i32 %37, i32* %21, align 4
  %38 = load i64*, i64** %11, align 8
  %39 = load i32, i32* %21, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i64, i64* %38, i64 %40
  %42 = load i64, i64* %41, align 8
  store i64 %42, i64* %22, align 8
  %43 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %14, align 8
  %44 = load i64, i64* %22, align 8
  %45 = load i32, i32* %15, align 4
  %46 = sext i32 %45 to i64
  %47 = mul nsw i64 %44, %46
  %48 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %43, i64 %47
  store %"class.caffe2::TypeMeta"* %48, %"class.caffe2::TypeMeta"** %23, align 8
  %49 = load i32, i32* %15, align 4
  %50 = sdiv i32 %49, 2
  store i32 %50, i32* %24, align 4
  %51 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %23, align 8
  store %"class.caffe2::TypeMeta"* %51, %"class.caffe2::TypeMeta"** %25, align 8
  %52 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %23, align 8
  %53 = load i32, i32* %24, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %52, i64 %54
  store %"class.caffe2::TypeMeta"* %55, %"class.caffe2::TypeMeta"** %26, align 8
  %56 = load i32, i32* %18, align 4
  %57 = load i32, i32* %24, align 4
  %58 = mul nsw i32 %56, %57
  store i32 %58, i32* %27, align 4
  %59 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %59, i32* %28, align 4
  br label %60

60:                                               ; preds = %86, %10
  %61 = load i32, i32* %28, align 4
  %62 = load i32, i32* %27, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %90

64:                                               ; preds = %60
  %65 = load i32, i32* %28, align 4
  %66 = load i32, i32* %24, align 4
  %67 = sdiv i32 %65, %66
  store i32 %67, i32* %29, align 4
  %68 = load i32, i32* %21, align 4
  %69 = load i32, i32* %16, align 4
  %70 = mul nsw i32 %68, %69
  %71 = load i32, i32* %29, align 4
  %72 = load i32, i32* %20, align 4
  %73 = mul nsw i32 %71, %72
  %74 = add nsw i32 %70, %73
  store i32 %74, i32* %30, align 4
  %75 = load i32, i32* %28, align 4
  %76 = load i32, i32* %24, align 4
  %77 = srem i32 %75, %76
  store i32 %77, i32* %31, align 4
  %78 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %12, align 8
  %79 = load i32, i32* %30, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %78, i64 %80
  %82 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %25, align 8
  %83 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %26, align 8
  %84 = load i32, i32* %31, align 4
  %85 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIN3c104HalfELb1EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* %81, %"class.caffe2::TypeMeta"* %82, %"class.caffe2::TypeMeta"* %83, i32 %84, i32 %85) #19
  br label %86

86:                                               ; preds = %64
  %87 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %88 = load i32, i32* %28, align 4
  %89 = add i32 %88, %87
  store i32 %89, i32* %28, align 4
  br label %60, !llvm.loop !19

90:                                               ; preds = %60
  %91 = load i32, i32* %19, align 4
  %92 = load i32, i32* %24, align 4
  %93 = mul nsw i32 %91, %92
  store i32 %93, i32* %32, align 4
  %94 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %94, i32* %33, align 4
  br label %95

95:                                               ; preds = %121, %90
  %96 = load i32, i32* %33, align 4
  %97 = load i32, i32* %32, align 4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %125

99:                                               ; preds = %95
  %100 = load i32, i32* %33, align 4
  %101 = load i32, i32* %24, align 4
  %102 = sdiv i32 %100, %101
  store i32 %102, i32* %34, align 4
  %103 = load i32, i32* %21, align 4
  %104 = load i32, i32* %17, align 4
  %105 = mul nsw i32 %103, %104
  %106 = load i32, i32* %34, align 4
  %107 = load i32, i32* %20, align 4
  %108 = mul nsw i32 %106, %107
  %109 = add nsw i32 %105, %108
  store i32 %109, i32* %35, align 4
  %110 = load i32, i32* %33, align 4
  %111 = load i32, i32* %24, align 4
  %112 = srem i32 %110, %111
  store i32 %112, i32* %36, align 4
  %113 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %13, align 8
  %114 = load i32, i32* %35, align 4
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %113, i64 %115
  %117 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %25, align 8
  %118 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %26, align 8
  %119 = load i32, i32* %36, align 4
  %120 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIN3c104HalfELb1EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* %116, %"class.caffe2::TypeMeta"* %117, %"class.caffe2::TypeMeta"* %118, i32 %119, i32 %120) #19
  br label %121

121:                                              ; preds = %99
  %122 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %123 = load i32, i32* %33, align 4
  %124 = add i32 %123, %122
  store i32 %124, i32* %33, align 4
  br label %95, !llvm.loop !20

125:                                              ; preds = %95
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm22apply_rotary_embeddingIN3c104HalfELb1EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, i32 %3, i32 %4) #14 comdat {
  %6 = alloca %"class.caffe2::TypeMeta"*, align 8
  %7 = alloca %"class.caffe2::TypeMeta"*, align 8
  %8 = alloca %"class.caffe2::TypeMeta"*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %"class.caffe2::TypeMeta", align 2
  %14 = alloca %"class.caffe2::TypeMeta", align 2
  %15 = alloca %"class.caffe2::TypeMeta", align 2
  %16 = alloca %"class.caffe2::TypeMeta", align 2
  %17 = alloca %"class.caffe2::TypeMeta", align 2
  %18 = alloca %"class.caffe2::TypeMeta", align 2
  %19 = alloca %"class.caffe2::TypeMeta", align 2
  %20 = alloca %"class.caffe2::TypeMeta", align 2
  %21 = alloca %"class.caffe2::TypeMeta", align 2
  %22 = alloca %"class.caffe2::TypeMeta", align 2
  %23 = alloca %"class.caffe2::TypeMeta", align 2
  %24 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %6, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %7, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %25 = load i32, i32* %9, align 4
  store i32 %25, i32* %11, align 4
  %26 = load i32, i32* %10, align 4
  %27 = load i32, i32* %9, align 4
  %28 = add nsw i32 %26, %27
  store i32 %28, i32* %12, align 4
  %29 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %7, align 8
  %30 = load i32, i32* %11, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %29, i64 %31
  %33 = call %"class.caffe2::TypeMeta" @_ZN3c105__ldgEPKNS_4HalfE(%"class.caffe2::TypeMeta"* %32) #19
  %34 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %15, i32 0, i32 0
  %35 = extractvalue %"class.caffe2::TypeMeta" %33, 0
  store i16 %35, i16* %34, align 2
  %36 = bitcast %"class.caffe2::TypeMeta"* %13 to i8*
  %37 = bitcast %"class.caffe2::TypeMeta"* %15 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %36, i8* align 2 %37, i64 2, i1 false)
  %38 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %8, align 8
  %39 = load i32, i32* %11, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %38, i64 %40
  %42 = call %"class.caffe2::TypeMeta" @_ZN3c105__ldgEPKNS_4HalfE(%"class.caffe2::TypeMeta"* %41) #19
  %43 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %16, i32 0, i32 0
  %44 = extractvalue %"class.caffe2::TypeMeta" %42, 0
  store i16 %44, i16* %43, align 2
  %45 = bitcast %"class.caffe2::TypeMeta"* %14 to i8*
  %46 = bitcast %"class.caffe2::TypeMeta"* %16 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %45, i8* align 2 %46, i64 2, i1 false)
  %47 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %48 = load i32, i32* %11, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %47, i64 %49
  %51 = bitcast %"class.caffe2::TypeMeta"* %17 to i8*
  %52 = bitcast %"class.caffe2::TypeMeta"* %50 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %51, i8* align 2 %52, i64 2, i1 false)
  %53 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %54 = load i32, i32* %12, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %53, i64 %55
  %57 = bitcast %"class.caffe2::TypeMeta"* %18 to i8*
  %58 = bitcast %"class.caffe2::TypeMeta"* %56 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %57, i8* align 2 %58, i64 2, i1 false)
  %59 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %13) #19
  %60 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %20, i32 0, i32 0
  %61 = extractvalue %"class.caffe2::TypeMeta" %59, 0
  store i16 %61, i16* %60, align 2
  %62 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %18, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %14) #19
  %63 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %21, i32 0, i32 0
  %64 = extractvalue %"class.caffe2::TypeMeta" %62, 0
  store i16 %64, i16* %63, align 2
  %65 = call %"class.caffe2::TypeMeta" @_ZN3c10miERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %20, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %21) #19
  %66 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %19, i32 0, i32 0
  %67 = extractvalue %"class.caffe2::TypeMeta" %65, 0
  store i16 %67, i16* %66, align 2
  %68 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %69 = load i32, i32* %11, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %68, i64 %70
  %72 = bitcast %"class.caffe2::TypeMeta"* %71 to i8*
  %73 = bitcast %"class.caffe2::TypeMeta"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %72, i8* align 2 %73, i64 2, i1 false)
  %74 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %18, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %13) #19
  %75 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %23, i32 0, i32 0
  %76 = extractvalue %"class.caffe2::TypeMeta" %74, 0
  store i16 %76, i16* %75, align 2
  %77 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %14) #19
  %78 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %24, i32 0, i32 0
  %79 = extractvalue %"class.caffe2::TypeMeta" %77, 0
  store i16 %79, i16* %78, align 2
  %80 = call %"class.caffe2::TypeMeta" @_ZN3c10plERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %23, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %24) #19
  %81 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %22, i32 0, i32 0
  %82 = extractvalue %"class.caffe2::TypeMeta" %80, 0
  store i16 %82, i16* %81, align 2
  %83 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %84 = load i32, i32* %12, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %83, i64 %85
  %87 = bitcast %"class.caffe2::TypeMeta"* %86 to i8*
  %88 = bitcast %"class.caffe2::TypeMeta"* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %87, i8* align 2 %88, i64 2, i1 false)
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.caffe2::TypeMeta" @_ZN3c105__ldgEPKNS_4HalfE(%"class.caffe2::TypeMeta"* %0) #14 comdat {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = bitcast %"class.caffe2::TypeMeta"* %5 to %"class.caffe2::TypeMeta"*
  %7 = call %"class.caffe2::TypeMeta" @_ZL5__ldgPK6__half(%"class.caffe2::TypeMeta"* %6) #19
  %8 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %4, i32 0, i32 0
  %9 = extractvalue %"class.caffe2::TypeMeta" %7, 0
  store i16 %9, i16* %8, align 2
  call void @_ZN3c104HalfC1ERK6__half(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %2, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %4) #19
  %10 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, align 2
  ret %"class.caffe2::TypeMeta" %10
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %1) #14 comdat {
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  %4 = alloca %"class.caffe2::TypeMeta"*, align 8
  %5 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %4, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %5, align 8
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %4, align 8
  %7 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %6) #19
  %8 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %5, align 8
  %9 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %8) #19
  %10 = fmul contract float %7, %9
  call void @_ZN3c104HalfC1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %3, float %10) #19
  %11 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %3, align 2
  ret %"class.caffe2::TypeMeta" %11
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.caffe2::TypeMeta" @_ZN3c10miERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %1) #14 comdat {
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  %4 = alloca %"class.caffe2::TypeMeta"*, align 8
  %5 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %4, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %5, align 8
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %4, align 8
  %7 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %6) #19
  %8 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %5, align 8
  %9 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %8) #19
  %10 = fsub contract float %7, %9
  call void @_ZN3c104HalfC1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %3, float %10) #19
  %11 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %3, align 2
  ret %"class.caffe2::TypeMeta" %11
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.caffe2::TypeMeta" @_ZN3c10plERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %1) #14 comdat {
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  %4 = alloca %"class.caffe2::TypeMeta"*, align 8
  %5 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %4, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %5, align 8
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %4, align 8
  %7 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %6) #19
  %8 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %5, align 8
  %9 = call contract float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %8) #19
  %10 = fadd contract float %7, %9
  call void @_ZN3c104HalfC1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %3, float %10) #19
  %11 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %3, align 2
  ret %"class.caffe2::TypeMeta" %11
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZNK3c104HalfcvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #14 comdat align 2 {
  %2 = alloca %"class.caffe2::TypeMeta"*, align 8
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %2, align 8
  %4 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %2, align 8
  %5 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %4, i32 0, i32 0
  %6 = bitcast i16* %5 to %"class.caffe2::TypeMeta"*
  %7 = bitcast %"class.caffe2::TypeMeta"* %3 to i8*
  %8 = bitcast %"class.caffe2::TypeMeta"* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %7, i8* align 2 %8, i64 2, i1 false)
  %9 = call contract float @_ZL12__half2float6__half(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %3) #19
  ret float %9
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c104HalfC1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, float %1) unnamed_addr #16 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca float, align 4
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store float %1, float* %4, align 4
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = load float, float* %4, align 4
  call void @_ZN3c104HalfC2Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %5, float %6) #19
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c104HalfC2Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, float %1) unnamed_addr #16 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca float, align 4
  %5 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store float %1, float* %4, align 4
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %7 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %6, i32 0, i32 0
  %8 = load float, float* %4, align 4
  %9 = call %"class.caffe2::TypeMeta" @_ZL12__float2halff(float %8) #19
  %10 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %5, i32 0, i32 0
  %11 = extractvalue %"class.caffe2::TypeMeta" %9, 0
  store i16 %11, i16* %10, align 2
  %12 = call signext i16 @_ZL15__half_as_short6__half(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %5) #19
  store i16 %12, i16* %7, align 2
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal %"class.caffe2::TypeMeta" @_ZL12__float2halff(float %0) #14 {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = alloca float, align 4
  store float %0, float* %3, align 4
  %4 = bitcast %"class.caffe2::TypeMeta"* %2 to i16*
  %5 = load float, float* %3, align 4
  %6 = call i16 asm "{  cvt.rn.f16.f32 $0, $1;}\0A", "=h,f"(float %5) #20, !srcloc !21
  store i16 %6, i16* %4, align 2
  %7 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, align 2
  ret %"class.caffe2::TypeMeta" %7
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal signext i16 @_ZL15__half_as_short6__half(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %0) #14 {
  %2 = bitcast %"class.caffe2::TypeMeta"* %0 to i16*
  %3 = load i16, i16* %2, align 2
  ret i16 %3
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal float @_ZL12__half2float6__half(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %0) #14 {
  %2 = alloca float, align 4
  %3 = bitcast %"class.caffe2::TypeMeta"* %0 to i16*
  %4 = load i16, i16* %3, align 2
  %5 = call contract float asm "{  cvt.f32.f16 $0, $1;}\0A", "=f,h"(i16 %4) #20, !srcloc !22
  store float %5, float* %2, align 4
  %6 = load float, float* %2, align 4
  ret float %6
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal %"class.caffe2::TypeMeta" @_ZL5__ldgPK6__half(%"class.caffe2::TypeMeta"* %0) #14 {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  %4 = bitcast %"class.caffe2::TypeMeta"* %2 to i16*
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = call i16 asm "ld.global.nc.b16 $0, [$1];", "=h,l"(%"class.caffe2::TypeMeta"* %5) #20, !srcloc !23
  store i16 %6, i16* %4, align 2
  %7 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, align 2
  ret %"class.caffe2::TypeMeta" %7
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c104HalfC1ERK6__half(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %1) unnamed_addr #16 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %4, align 8
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %4, align 8
  call void @_ZN3c104HalfC2ERK6__half(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %5, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %6) #19
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c104HalfC2ERK6__half(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %1) unnamed_addr #16 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %4, align 8
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %4, align 8
  %7 = bitcast %"class.caffe2::TypeMeta"* %6 to i16*
  %8 = load i16, i16* %7, align 2
  %9 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %5, i32 0, i32 0
  store i16 %8, i16* %9, align 2
  ret void
}

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23rotary_embedding_kernelIN3c104HalfELb0EEEvPKlPT_S6_PKS5_iiiiii(i64* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, %"class.caffe2::TypeMeta"* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #12 {
  %11 = alloca i64*, align 8
  %12 = alloca %"class.caffe2::TypeMeta"*, align 8
  %13 = alloca %"class.caffe2::TypeMeta"*, align 8
  %14 = alloca %"class.caffe2::TypeMeta"*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i64, align 8
  %23 = alloca %"class.caffe2::TypeMeta"*, align 8
  %24 = alloca i32, align 4
  %25 = alloca %"class.caffe2::TypeMeta"*, align 8
  %26 = alloca %"class.caffe2::TypeMeta"*, align 8
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  store i64* %0, i64** %11, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %12, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %13, align 8
  store %"class.caffe2::TypeMeta"* %3, %"class.caffe2::TypeMeta"** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %37 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  store i32 %37, i32* %21, align 4
  %38 = load i64*, i64** %11, align 8
  %39 = load i32, i32* %21, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i64, i64* %38, i64 %40
  %42 = load i64, i64* %41, align 8
  store i64 %42, i64* %22, align 8
  %43 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %14, align 8
  %44 = load i64, i64* %22, align 8
  %45 = load i32, i32* %15, align 4
  %46 = sext i32 %45 to i64
  %47 = mul nsw i64 %44, %46
  %48 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %43, i64 %47
  store %"class.caffe2::TypeMeta"* %48, %"class.caffe2::TypeMeta"** %23, align 8
  %49 = load i32, i32* %15, align 4
  %50 = sdiv i32 %49, 2
  store i32 %50, i32* %24, align 4
  %51 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %23, align 8
  store %"class.caffe2::TypeMeta"* %51, %"class.caffe2::TypeMeta"** %25, align 8
  %52 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %23, align 8
  %53 = load i32, i32* %24, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %52, i64 %54
  store %"class.caffe2::TypeMeta"* %55, %"class.caffe2::TypeMeta"** %26, align 8
  %56 = load i32, i32* %18, align 4
  %57 = load i32, i32* %24, align 4
  %58 = mul nsw i32 %56, %57
  store i32 %58, i32* %27, align 4
  %59 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %59, i32* %28, align 4
  br label %60

60:                                               ; preds = %86, %10
  %61 = load i32, i32* %28, align 4
  %62 = load i32, i32* %27, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %90

64:                                               ; preds = %60
  %65 = load i32, i32* %28, align 4
  %66 = load i32, i32* %24, align 4
  %67 = sdiv i32 %65, %66
  store i32 %67, i32* %29, align 4
  %68 = load i32, i32* %21, align 4
  %69 = load i32, i32* %16, align 4
  %70 = mul nsw i32 %68, %69
  %71 = load i32, i32* %29, align 4
  %72 = load i32, i32* %20, align 4
  %73 = mul nsw i32 %71, %72
  %74 = add nsw i32 %70, %73
  store i32 %74, i32* %30, align 4
  %75 = load i32, i32* %28, align 4
  %76 = load i32, i32* %24, align 4
  %77 = srem i32 %75, %76
  store i32 %77, i32* %31, align 4
  %78 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %12, align 8
  %79 = load i32, i32* %30, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %78, i64 %80
  %82 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %25, align 8
  %83 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %26, align 8
  %84 = load i32, i32* %31, align 4
  %85 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIN3c104HalfELb0EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* %81, %"class.caffe2::TypeMeta"* %82, %"class.caffe2::TypeMeta"* %83, i32 %84, i32 %85) #19
  br label %86

86:                                               ; preds = %64
  %87 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %88 = load i32, i32* %28, align 4
  %89 = add i32 %88, %87
  store i32 %89, i32* %28, align 4
  br label %60, !llvm.loop !24

90:                                               ; preds = %60
  %91 = load i32, i32* %19, align 4
  %92 = load i32, i32* %24, align 4
  %93 = mul nsw i32 %91, %92
  store i32 %93, i32* %32, align 4
  %94 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %94, i32* %33, align 4
  br label %95

95:                                               ; preds = %121, %90
  %96 = load i32, i32* %33, align 4
  %97 = load i32, i32* %32, align 4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %125

99:                                               ; preds = %95
  %100 = load i32, i32* %33, align 4
  %101 = load i32, i32* %24, align 4
  %102 = sdiv i32 %100, %101
  store i32 %102, i32* %34, align 4
  %103 = load i32, i32* %21, align 4
  %104 = load i32, i32* %17, align 4
  %105 = mul nsw i32 %103, %104
  %106 = load i32, i32* %34, align 4
  %107 = load i32, i32* %20, align 4
  %108 = mul nsw i32 %106, %107
  %109 = add nsw i32 %105, %108
  store i32 %109, i32* %35, align 4
  %110 = load i32, i32* %33, align 4
  %111 = load i32, i32* %24, align 4
  %112 = srem i32 %110, %111
  store i32 %112, i32* %36, align 4
  %113 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %13, align 8
  %114 = load i32, i32* %35, align 4
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %113, i64 %115
  %117 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %25, align 8
  %118 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %26, align 8
  %119 = load i32, i32* %36, align 4
  %120 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIN3c104HalfELb0EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* %116, %"class.caffe2::TypeMeta"* %117, %"class.caffe2::TypeMeta"* %118, i32 %119, i32 %120) #19
  br label %121

121:                                              ; preds = %99
  %122 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %123 = load i32, i32* %33, align 4
  %124 = add i32 %123, %122
  store i32 %124, i32* %33, align 4
  br label %95, !llvm.loop !25

125:                                              ; preds = %95
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm22apply_rotary_embeddingIN3c104HalfELb0EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, i32 %3, i32 %4) #14 comdat {
  %6 = alloca %"class.caffe2::TypeMeta"*, align 8
  %7 = alloca %"class.caffe2::TypeMeta"*, align 8
  %8 = alloca %"class.caffe2::TypeMeta"*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %"class.caffe2::TypeMeta", align 2
  %14 = alloca %"class.caffe2::TypeMeta", align 2
  %15 = alloca %"class.caffe2::TypeMeta", align 2
  %16 = alloca %"class.caffe2::TypeMeta", align 2
  %17 = alloca %"class.caffe2::TypeMeta", align 2
  %18 = alloca %"class.caffe2::TypeMeta", align 2
  %19 = alloca %"class.caffe2::TypeMeta", align 2
  %20 = alloca %"class.caffe2::TypeMeta", align 2
  %21 = alloca %"class.caffe2::TypeMeta", align 2
  %22 = alloca %"class.caffe2::TypeMeta", align 2
  %23 = alloca %"class.caffe2::TypeMeta", align 2
  %24 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %6, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %7, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %25 = load i32, i32* %9, align 4
  %26 = mul nsw i32 2, %25
  store i32 %26, i32* %11, align 4
  %27 = load i32, i32* %9, align 4
  %28 = mul nsw i32 2, %27
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* %12, align 4
  %30 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %7, align 8
  %31 = load i32, i32* %11, align 4
  %32 = sdiv i32 %31, 2
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %30, i64 %33
  %35 = call %"class.caffe2::TypeMeta" @_ZN3c105__ldgEPKNS_4HalfE(%"class.caffe2::TypeMeta"* %34) #19
  %36 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %15, i32 0, i32 0
  %37 = extractvalue %"class.caffe2::TypeMeta" %35, 0
  store i16 %37, i16* %36, align 2
  %38 = bitcast %"class.caffe2::TypeMeta"* %13 to i8*
  %39 = bitcast %"class.caffe2::TypeMeta"* %15 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %38, i8* align 2 %39, i64 2, i1 false)
  %40 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %8, align 8
  %41 = load i32, i32* %11, align 4
  %42 = sdiv i32 %41, 2
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %40, i64 %43
  %45 = call %"class.caffe2::TypeMeta" @_ZN3c105__ldgEPKNS_4HalfE(%"class.caffe2::TypeMeta"* %44) #19
  %46 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %16, i32 0, i32 0
  %47 = extractvalue %"class.caffe2::TypeMeta" %45, 0
  store i16 %47, i16* %46, align 2
  %48 = bitcast %"class.caffe2::TypeMeta"* %14 to i8*
  %49 = bitcast %"class.caffe2::TypeMeta"* %16 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %48, i8* align 2 %49, i64 2, i1 false)
  %50 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %51 = load i32, i32* %11, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %50, i64 %52
  %54 = bitcast %"class.caffe2::TypeMeta"* %17 to i8*
  %55 = bitcast %"class.caffe2::TypeMeta"* %53 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %54, i8* align 2 %55, i64 2, i1 false)
  %56 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %57 = load i32, i32* %12, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %56, i64 %58
  %60 = bitcast %"class.caffe2::TypeMeta"* %18 to i8*
  %61 = bitcast %"class.caffe2::TypeMeta"* %59 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %60, i8* align 2 %61, i64 2, i1 false)
  %62 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %13) #19
  %63 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %20, i32 0, i32 0
  %64 = extractvalue %"class.caffe2::TypeMeta" %62, 0
  store i16 %64, i16* %63, align 2
  %65 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %18, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %14) #19
  %66 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %21, i32 0, i32 0
  %67 = extractvalue %"class.caffe2::TypeMeta" %65, 0
  store i16 %67, i16* %66, align 2
  %68 = call %"class.caffe2::TypeMeta" @_ZN3c10miERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %20, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %21) #19
  %69 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %19, i32 0, i32 0
  %70 = extractvalue %"class.caffe2::TypeMeta" %68, 0
  store i16 %70, i16* %69, align 2
  %71 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %72 = load i32, i32* %11, align 4
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %71, i64 %73
  %75 = bitcast %"class.caffe2::TypeMeta"* %74 to i8*
  %76 = bitcast %"class.caffe2::TypeMeta"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %75, i8* align 2 %76, i64 2, i1 false)
  %77 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %18, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %13) #19
  %78 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %23, i32 0, i32 0
  %79 = extractvalue %"class.caffe2::TypeMeta" %77, 0
  store i16 %79, i16* %78, align 2
  %80 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %14) #19
  %81 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %24, i32 0, i32 0
  %82 = extractvalue %"class.caffe2::TypeMeta" %80, 0
  store i16 %82, i16* %81, align 2
  %83 = call %"class.caffe2::TypeMeta" @_ZN3c10plERKNS_4HalfES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %23, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %24) #19
  %84 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %22, i32 0, i32 0
  %85 = extractvalue %"class.caffe2::TypeMeta" %83, 0
  store i16 %85, i16* %84, align 2
  %86 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %87 = load i32, i32* %12, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %86, i64 %88
  %90 = bitcast %"class.caffe2::TypeMeta"* %89 to i8*
  %91 = bitcast %"class.caffe2::TypeMeta"* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %90, i8* align 2 %91, i64 2, i1 false)
  ret void
}

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23rotary_embedding_kernelIN3c108BFloat16ELb1EEEvPKlPT_S6_PKS5_iiiiii(i64* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, %"class.caffe2::TypeMeta"* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #12 {
  %11 = alloca i64*, align 8
  %12 = alloca %"class.caffe2::TypeMeta"*, align 8
  %13 = alloca %"class.caffe2::TypeMeta"*, align 8
  %14 = alloca %"class.caffe2::TypeMeta"*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i64, align 8
  %23 = alloca %"class.caffe2::TypeMeta"*, align 8
  %24 = alloca i32, align 4
  %25 = alloca %"class.caffe2::TypeMeta"*, align 8
  %26 = alloca %"class.caffe2::TypeMeta"*, align 8
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  store i64* %0, i64** %11, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %12, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %13, align 8
  store %"class.caffe2::TypeMeta"* %3, %"class.caffe2::TypeMeta"** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %37 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  store i32 %37, i32* %21, align 4
  %38 = load i64*, i64** %11, align 8
  %39 = load i32, i32* %21, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i64, i64* %38, i64 %40
  %42 = load i64, i64* %41, align 8
  store i64 %42, i64* %22, align 8
  %43 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %14, align 8
  %44 = load i64, i64* %22, align 8
  %45 = load i32, i32* %15, align 4
  %46 = sext i32 %45 to i64
  %47 = mul nsw i64 %44, %46
  %48 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %43, i64 %47
  store %"class.caffe2::TypeMeta"* %48, %"class.caffe2::TypeMeta"** %23, align 8
  %49 = load i32, i32* %15, align 4
  %50 = sdiv i32 %49, 2
  store i32 %50, i32* %24, align 4
  %51 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %23, align 8
  store %"class.caffe2::TypeMeta"* %51, %"class.caffe2::TypeMeta"** %25, align 8
  %52 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %23, align 8
  %53 = load i32, i32* %24, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %52, i64 %54
  store %"class.caffe2::TypeMeta"* %55, %"class.caffe2::TypeMeta"** %26, align 8
  %56 = load i32, i32* %18, align 4
  %57 = load i32, i32* %24, align 4
  %58 = mul nsw i32 %56, %57
  store i32 %58, i32* %27, align 4
  %59 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %59, i32* %28, align 4
  br label %60

60:                                               ; preds = %86, %10
  %61 = load i32, i32* %28, align 4
  %62 = load i32, i32* %27, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %90

64:                                               ; preds = %60
  %65 = load i32, i32* %28, align 4
  %66 = load i32, i32* %24, align 4
  %67 = sdiv i32 %65, %66
  store i32 %67, i32* %29, align 4
  %68 = load i32, i32* %21, align 4
  %69 = load i32, i32* %16, align 4
  %70 = mul nsw i32 %68, %69
  %71 = load i32, i32* %29, align 4
  %72 = load i32, i32* %20, align 4
  %73 = mul nsw i32 %71, %72
  %74 = add nsw i32 %70, %73
  store i32 %74, i32* %30, align 4
  %75 = load i32, i32* %28, align 4
  %76 = load i32, i32* %24, align 4
  %77 = srem i32 %75, %76
  store i32 %77, i32* %31, align 4
  %78 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %12, align 8
  %79 = load i32, i32* %30, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %78, i64 %80
  %82 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %25, align 8
  %83 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %26, align 8
  %84 = load i32, i32* %31, align 4
  %85 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIN3c108BFloat16ELb1EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* %81, %"class.caffe2::TypeMeta"* %82, %"class.caffe2::TypeMeta"* %83, i32 %84, i32 %85) #19
  br label %86

86:                                               ; preds = %64
  %87 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %88 = load i32, i32* %28, align 4
  %89 = add i32 %88, %87
  store i32 %89, i32* %28, align 4
  br label %60, !llvm.loop !26

90:                                               ; preds = %60
  %91 = load i32, i32* %19, align 4
  %92 = load i32, i32* %24, align 4
  %93 = mul nsw i32 %91, %92
  store i32 %93, i32* %32, align 4
  %94 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %94, i32* %33, align 4
  br label %95

95:                                               ; preds = %121, %90
  %96 = load i32, i32* %33, align 4
  %97 = load i32, i32* %32, align 4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %125

99:                                               ; preds = %95
  %100 = load i32, i32* %33, align 4
  %101 = load i32, i32* %24, align 4
  %102 = sdiv i32 %100, %101
  store i32 %102, i32* %34, align 4
  %103 = load i32, i32* %21, align 4
  %104 = load i32, i32* %17, align 4
  %105 = mul nsw i32 %103, %104
  %106 = load i32, i32* %34, align 4
  %107 = load i32, i32* %20, align 4
  %108 = mul nsw i32 %106, %107
  %109 = add nsw i32 %105, %108
  store i32 %109, i32* %35, align 4
  %110 = load i32, i32* %33, align 4
  %111 = load i32, i32* %24, align 4
  %112 = srem i32 %110, %111
  store i32 %112, i32* %36, align 4
  %113 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %13, align 8
  %114 = load i32, i32* %35, align 4
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %113, i64 %115
  %117 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %25, align 8
  %118 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %26, align 8
  %119 = load i32, i32* %36, align 4
  %120 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIN3c108BFloat16ELb1EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* %116, %"class.caffe2::TypeMeta"* %117, %"class.caffe2::TypeMeta"* %118, i32 %119, i32 %120) #19
  br label %121

121:                                              ; preds = %99
  %122 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %123 = load i32, i32* %33, align 4
  %124 = add i32 %123, %122
  store i32 %124, i32* %33, align 4
  br label %95, !llvm.loop !27

125:                                              ; preds = %95
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm22apply_rotary_embeddingIN3c108BFloat16ELb1EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, i32 %3, i32 %4) #14 comdat {
  %6 = alloca %"class.caffe2::TypeMeta"*, align 8
  %7 = alloca %"class.caffe2::TypeMeta"*, align 8
  %8 = alloca %"class.caffe2::TypeMeta"*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %"class.caffe2::TypeMeta", align 2
  %14 = alloca %"class.caffe2::TypeMeta", align 2
  %15 = alloca %"class.caffe2::TypeMeta", align 2
  %16 = alloca %"class.caffe2::TypeMeta", align 2
  %17 = alloca %"class.caffe2::TypeMeta", align 2
  %18 = alloca %"class.caffe2::TypeMeta", align 2
  %19 = alloca %"class.caffe2::TypeMeta", align 2
  %20 = alloca %"class.caffe2::TypeMeta", align 2
  %21 = alloca %"class.caffe2::TypeMeta", align 2
  %22 = alloca %"class.caffe2::TypeMeta", align 2
  %23 = alloca %"class.caffe2::TypeMeta", align 2
  %24 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %6, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %7, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %25 = load i32, i32* %9, align 4
  store i32 %25, i32* %11, align 4
  %26 = load i32, i32* %10, align 4
  %27 = load i32, i32* %9, align 4
  %28 = add nsw i32 %26, %27
  store i32 %28, i32* %12, align 4
  %29 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %7, align 8
  %30 = load i32, i32* %11, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %29, i64 %31
  %33 = call %"class.caffe2::TypeMeta" @_ZN3c105__ldgEPKNS_8BFloat16E(%"class.caffe2::TypeMeta"* %32) #19
  %34 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %15, i32 0, i32 0
  %35 = extractvalue %"class.caffe2::TypeMeta" %33, 0
  store i16 %35, i16* %34, align 2
  %36 = bitcast %"class.caffe2::TypeMeta"* %13 to i8*
  %37 = bitcast %"class.caffe2::TypeMeta"* %15 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %36, i8* align 2 %37, i64 2, i1 false)
  %38 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %8, align 8
  %39 = load i32, i32* %11, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %38, i64 %40
  %42 = call %"class.caffe2::TypeMeta" @_ZN3c105__ldgEPKNS_8BFloat16E(%"class.caffe2::TypeMeta"* %41) #19
  %43 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %16, i32 0, i32 0
  %44 = extractvalue %"class.caffe2::TypeMeta" %42, 0
  store i16 %44, i16* %43, align 2
  %45 = bitcast %"class.caffe2::TypeMeta"* %14 to i8*
  %46 = bitcast %"class.caffe2::TypeMeta"* %16 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %45, i8* align 2 %46, i64 2, i1 false)
  %47 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %48 = load i32, i32* %11, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %47, i64 %49
  %51 = bitcast %"class.caffe2::TypeMeta"* %17 to i8*
  %52 = bitcast %"class.caffe2::TypeMeta"* %50 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %51, i8* align 2 %52, i64 2, i1 false)
  %53 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %54 = load i32, i32* %12, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %53, i64 %55
  %57 = bitcast %"class.caffe2::TypeMeta"* %18 to i8*
  %58 = bitcast %"class.caffe2::TypeMeta"* %56 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %57, i8* align 2 %58, i64 2, i1 false)
  %59 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %13) #19
  %60 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %20, i32 0, i32 0
  %61 = extractvalue %"class.caffe2::TypeMeta" %59, 0
  store i16 %61, i16* %60, align 2
  %62 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %18, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %14) #19
  %63 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %21, i32 0, i32 0
  %64 = extractvalue %"class.caffe2::TypeMeta" %62, 0
  store i16 %64, i16* %63, align 2
  %65 = call %"class.caffe2::TypeMeta" @_ZN3c10miERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %20, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %21) #19
  %66 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %19, i32 0, i32 0
  %67 = extractvalue %"class.caffe2::TypeMeta" %65, 0
  store i16 %67, i16* %66, align 2
  %68 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %69 = load i32, i32* %11, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %68, i64 %70
  %72 = bitcast %"class.caffe2::TypeMeta"* %71 to i8*
  %73 = bitcast %"class.caffe2::TypeMeta"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %72, i8* align 2 %73, i64 2, i1 false)
  %74 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %18, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %13) #19
  %75 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %23, i32 0, i32 0
  %76 = extractvalue %"class.caffe2::TypeMeta" %74, 0
  store i16 %76, i16* %75, align 2
  %77 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %14) #19
  %78 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %24, i32 0, i32 0
  %79 = extractvalue %"class.caffe2::TypeMeta" %77, 0
  store i16 %79, i16* %78, align 2
  %80 = call %"class.caffe2::TypeMeta" @_ZN3c10plERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %23, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %24) #19
  %81 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %22, i32 0, i32 0
  %82 = extractvalue %"class.caffe2::TypeMeta" %80, 0
  store i16 %82, i16* %81, align 2
  %83 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %84 = load i32, i32* %12, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %83, i64 %85
  %87 = bitcast %"class.caffe2::TypeMeta"* %86 to i8*
  %88 = bitcast %"class.caffe2::TypeMeta"* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %87, i8* align 2 %88, i64 2, i1 false)
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.caffe2::TypeMeta" @_ZN3c105__ldgEPKNS_8BFloat16E(%"class.caffe2::TypeMeta"* %0) #14 comdat {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = bitcast %"class.caffe2::TypeMeta"* %5 to %"class.caffe2::TypeMeta"*
  %7 = call %"class.caffe2::TypeMeta" @_ZL5__ldgPK13__nv_bfloat16(%"class.caffe2::TypeMeta"* %6) #19
  %8 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %4, i32 0, i32 0
  %9 = extractvalue %"class.caffe2::TypeMeta" %7, 0
  store i16 %9, i16* %8, align 2
  call void @_ZN3c108BFloat16C1ERK13__nv_bfloat16(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %2, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %4) #19
  %10 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, align 2
  ret %"class.caffe2::TypeMeta" %10
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %1) #14 comdat {
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  %4 = alloca %"class.caffe2::TypeMeta"*, align 8
  %5 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %4, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %5, align 8
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %4, align 8
  %7 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %6) #19
  %8 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %5, align 8
  %9 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %8) #19
  %10 = fmul contract float %7, %9
  call void @_ZN3c108BFloat16C1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %3, float %10) #19
  %11 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %3, align 2
  ret %"class.caffe2::TypeMeta" %11
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.caffe2::TypeMeta" @_ZN3c10miERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %1) #14 comdat {
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  %4 = alloca %"class.caffe2::TypeMeta"*, align 8
  %5 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %4, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %5, align 8
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %4, align 8
  %7 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %6) #19
  %8 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %5, align 8
  %9 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %8) #19
  %10 = fsub contract float %7, %9
  call void @_ZN3c108BFloat16C1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %3, float %10) #19
  %11 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %3, align 2
  ret %"class.caffe2::TypeMeta" %11
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.caffe2::TypeMeta" @_ZN3c10plERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %1) #14 comdat {
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  %4 = alloca %"class.caffe2::TypeMeta"*, align 8
  %5 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %4, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %5, align 8
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %4, align 8
  %7 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %6) #19
  %8 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %5, align 8
  %9 = call contract float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %8) #19
  %10 = fadd contract float %7, %9
  call void @_ZN3c108BFloat16C1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %3, float %10) #19
  %11 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %3, align 2
  ret %"class.caffe2::TypeMeta" %11
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local float @_ZNK3c108BFloat16cvfEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #14 comdat align 2 {
  %2 = alloca %"class.caffe2::TypeMeta"*, align 8
  %3 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %2, align 8
  %4 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %2, align 8
  %5 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %4, i32 0, i32 0
  %6 = bitcast i16* %5 to %"class.caffe2::TypeMeta"*
  %7 = bitcast %"class.caffe2::TypeMeta"* %3 to i8*
  %8 = bitcast %"class.caffe2::TypeMeta"* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %7, i8* align 2 %8, i64 2, i1 false)
  %9 = call contract float @_ZL16__bfloat162float13__nv_bfloat16(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %3) #19
  ret float %9
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c108BFloat16C1Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, float %1) unnamed_addr #16 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca float, align 4
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store float %1, float* %4, align 4
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = load float, float* %4, align 4
  call void @_ZN3c108BFloat16C2Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %5, float %6) #19
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c108BFloat16C2Ef(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, float %1) unnamed_addr #16 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca float, align 4
  %5 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store float %1, float* %4, align 4
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %7 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %6, i32 0, i32 0
  %8 = load float, float* %4, align 4
  %9 = call %"class.caffe2::TypeMeta" @_ZL16__float2bfloat16f(float %8) #19
  %10 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %5, i32 0, i32 0
  %11 = extractvalue %"class.caffe2::TypeMeta" %9, 0
  store i16 %11, i16* %10, align 2
  %12 = call zeroext i16 @_ZL20__bfloat16_as_ushort13__nv_bfloat16(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %5) #19
  store i16 %12, i16* %7, align 2
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal %"class.caffe2::TypeMeta" @_ZL16__float2bfloat16f(float %0) #14 {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = alloca float, align 4
  store float %0, float* %3, align 4
  %4 = bitcast %"class.caffe2::TypeMeta"* %2 to i16*
  %5 = load float, float* %3, align 4
  %6 = call i16 asm "{  cvt.rn.bf16.f32 $0, $1;}\0A", "=h,f"(float %5) #20, !srcloc !28
  store i16 %6, i16* %4, align 2
  %7 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, align 2
  ret %"class.caffe2::TypeMeta" %7
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal zeroext i16 @_ZL20__bfloat16_as_ushort13__nv_bfloat16(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %0) #14 {
  %2 = bitcast %"class.caffe2::TypeMeta"* %0 to i16*
  %3 = load i16, i16* %2, align 2
  ret i16 %3
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal float @_ZL16__bfloat162float13__nv_bfloat16(%"class.caffe2::TypeMeta"* byval(%"class.caffe2::TypeMeta") align 2 %0) #14 {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = call %"class.caffe2::TypeMeta" @_ZNK13__nv_bfloat16cv17__nv_bfloat16_rawEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #19
  %4 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, i32 0, i32 0
  %5 = extractvalue %"class.caffe2::TypeMeta" %3, 0
  store i16 %5, i16* %4, align 2
  %6 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, i32 0, i32 0
  %7 = load i16, i16* %6, align 2
  %8 = call contract float @_ZL25__internal_bfloat162floatt(i16 zeroext %7) #19
  ret float %8
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local %"class.caffe2::TypeMeta" @_ZNK13__nv_bfloat16cv17__nv_bfloat16_rawEv(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0) #14 comdat align 2 {
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
define internal float @_ZL25__internal_bfloat162floatt(i16 zeroext %0) #14 {
  %2 = alloca i16, align 2
  %3 = alloca float, align 4
  store i16 %0, i16* %2, align 2
  %4 = load i16, i16* %2, align 2
  %5 = call contract float @_ZL32__internal_device_bfloat162floatt(i16 zeroext %4) #19
  store float %5, float* %3, align 4
  %6 = load float, float* %3, align 4
  ret float %6
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal float @_ZL32__internal_device_bfloat162floatt(i16 zeroext %0) #14 {
  %2 = alloca i16, align 2
  %3 = alloca float, align 4
  store i16 %0, i16* %2, align 2
  %4 = load i16, i16* %2, align 2
  %5 = call contract float asm "{ mov.b32 $0, {0,$1};}\0A", "=f,h"(i16 %4) #20, !srcloc !29
  store float %5, float* %3, align 4
  %6 = load float, float* %3, align 4
  ret float %6
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define internal %"class.caffe2::TypeMeta" @_ZL5__ldgPK13__nv_bfloat16(%"class.caffe2::TypeMeta"* %0) #14 {
  %2 = alloca %"class.caffe2::TypeMeta", align 2
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  %4 = bitcast %"class.caffe2::TypeMeta"* %2 to i16*
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = call i16 asm "ld.global.nc.b16 $0, [$1];", "=h,l"(%"class.caffe2::TypeMeta"* %5) #20, !srcloc !30
  store i16 %6, i16* %4, align 2
  %7 = load %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %2, align 2
  ret %"class.caffe2::TypeMeta" %7
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c108BFloat16C1ERK13__nv_bfloat16(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %1) unnamed_addr #16 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %4, align 8
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %4, align 8
  call void @_ZN3c108BFloat16C2ERK13__nv_bfloat16(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %5, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %6) #19
  ret void
}

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local void @_ZN3c108BFloat16C2ERK13__nv_bfloat16(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %0, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %1) unnamed_addr #16 comdat align 2 {
  %3 = alloca %"class.caffe2::TypeMeta"*, align 8
  %4 = alloca %"class.caffe2::TypeMeta"*, align 8
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %3, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %4, align 8
  %5 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %3, align 8
  %6 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %4, align 8
  %7 = bitcast %"class.caffe2::TypeMeta"* %6 to i16*
  %8 = load i16, i16* %7, align 2
  %9 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %5, i32 0, i32 0
  store i16 %8, i16* %9, align 2
  ret void
}

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define dso_local void @_ZN4vllm23rotary_embedding_kernelIN3c108BFloat16ELb0EEEvPKlPT_S6_PKS5_iiiiii(i64* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, %"class.caffe2::TypeMeta"* noalias %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9) #12 {
  %11 = alloca i64*, align 8
  %12 = alloca %"class.caffe2::TypeMeta"*, align 8
  %13 = alloca %"class.caffe2::TypeMeta"*, align 8
  %14 = alloca %"class.caffe2::TypeMeta"*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i64, align 8
  %23 = alloca %"class.caffe2::TypeMeta"*, align 8
  %24 = alloca i32, align 4
  %25 = alloca %"class.caffe2::TypeMeta"*, align 8
  %26 = alloca %"class.caffe2::TypeMeta"*, align 8
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  store i64* %0, i64** %11, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %12, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %13, align 8
  store %"class.caffe2::TypeMeta"* %3, %"class.caffe2::TypeMeta"** %14, align 8
  store i32 %4, i32* %15, align 4
  store i32 %5, i32* %16, align 4
  store i32 %6, i32* %17, align 4
  store i32 %7, i32* %18, align 4
  store i32 %8, i32* %19, align 4
  store i32 %9, i32* %20, align 4
  %37 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3
  store i32 %37, i32* %21, align 4
  %38 = load i64*, i64** %11, align 8
  %39 = load i32, i32* %21, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i64, i64* %38, i64 %40
  %42 = load i64, i64* %41, align 8
  store i64 %42, i64* %22, align 8
  %43 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %14, align 8
  %44 = load i64, i64* %22, align 8
  %45 = load i32, i32* %15, align 4
  %46 = sext i32 %45 to i64
  %47 = mul nsw i64 %44, %46
  %48 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %43, i64 %47
  store %"class.caffe2::TypeMeta"* %48, %"class.caffe2::TypeMeta"** %23, align 8
  %49 = load i32, i32* %15, align 4
  %50 = sdiv i32 %49, 2
  store i32 %50, i32* %24, align 4
  %51 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %23, align 8
  store %"class.caffe2::TypeMeta"* %51, %"class.caffe2::TypeMeta"** %25, align 8
  %52 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %23, align 8
  %53 = load i32, i32* %24, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %52, i64 %54
  store %"class.caffe2::TypeMeta"* %55, %"class.caffe2::TypeMeta"** %26, align 8
  %56 = load i32, i32* %18, align 4
  %57 = load i32, i32* %24, align 4
  %58 = mul nsw i32 %56, %57
  store i32 %58, i32* %27, align 4
  %59 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %59, i32* %28, align 4
  br label %60

60:                                               ; preds = %86, %10
  %61 = load i32, i32* %28, align 4
  %62 = load i32, i32* %27, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %90

64:                                               ; preds = %60
  %65 = load i32, i32* %28, align 4
  %66 = load i32, i32* %24, align 4
  %67 = sdiv i32 %65, %66
  store i32 %67, i32* %29, align 4
  %68 = load i32, i32* %21, align 4
  %69 = load i32, i32* %16, align 4
  %70 = mul nsw i32 %68, %69
  %71 = load i32, i32* %29, align 4
  %72 = load i32, i32* %20, align 4
  %73 = mul nsw i32 %71, %72
  %74 = add nsw i32 %70, %73
  store i32 %74, i32* %30, align 4
  %75 = load i32, i32* %28, align 4
  %76 = load i32, i32* %24, align 4
  %77 = srem i32 %75, %76
  store i32 %77, i32* %31, align 4
  %78 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %12, align 8
  %79 = load i32, i32* %30, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %78, i64 %80
  %82 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %25, align 8
  %83 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %26, align 8
  %84 = load i32, i32* %31, align 4
  %85 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIN3c108BFloat16ELb0EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* %81, %"class.caffe2::TypeMeta"* %82, %"class.caffe2::TypeMeta"* %83, i32 %84, i32 %85) #19
  br label %86

86:                                               ; preds = %64
  %87 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %88 = load i32, i32* %28, align 4
  %89 = add i32 %88, %87
  store i32 %89, i32* %28, align 4
  br label %60, !llvm.loop !31

90:                                               ; preds = %60
  %91 = load i32, i32* %19, align 4
  %92 = load i32, i32* %24, align 4
  %93 = mul nsw i32 %91, %92
  store i32 %93, i32* %32, align 4
  %94 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3
  store i32 %94, i32* %33, align 4
  br label %95

95:                                               ; preds = %121, %90
  %96 = load i32, i32* %33, align 4
  %97 = load i32, i32* %32, align 4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %125

99:                                               ; preds = %95
  %100 = load i32, i32* %33, align 4
  %101 = load i32, i32* %24, align 4
  %102 = sdiv i32 %100, %101
  store i32 %102, i32* %34, align 4
  %103 = load i32, i32* %21, align 4
  %104 = load i32, i32* %17, align 4
  %105 = mul nsw i32 %103, %104
  %106 = load i32, i32* %34, align 4
  %107 = load i32, i32* %20, align 4
  %108 = mul nsw i32 %106, %107
  %109 = add nsw i32 %105, %108
  store i32 %109, i32* %35, align 4
  %110 = load i32, i32* %33, align 4
  %111 = load i32, i32* %24, align 4
  %112 = srem i32 %110, %111
  store i32 %112, i32* %36, align 4
  %113 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %13, align 8
  %114 = load i32, i32* %35, align 4
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %113, i64 %115
  %117 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %25, align 8
  %118 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %26, align 8
  %119 = load i32, i32* %36, align 4
  %120 = load i32, i32* %24, align 4
  call void @_ZN4vllm22apply_rotary_embeddingIN3c108BFloat16ELb0EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* %116, %"class.caffe2::TypeMeta"* %117, %"class.caffe2::TypeMeta"* %118, i32 %119, i32 %120) #19
  br label %121

121:                                              ; preds = %99
  %122 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3
  %123 = load i32, i32* %33, align 4
  %124 = add i32 %123, %122
  store i32 %124, i32* %33, align 4
  br label %95, !llvm.loop !32

125:                                              ; preds = %95
  ret void
}

; Function Attrs: convergent mustprogress noinline nounwind optnone
define linkonce_odr dso_local void @_ZN4vllm22apply_rotary_embeddingIN3c108BFloat16ELb0EEEvPT_PKS3_S6_ii(%"class.caffe2::TypeMeta"* noalias %0, %"class.caffe2::TypeMeta"* noalias %1, %"class.caffe2::TypeMeta"* noalias %2, i32 %3, i32 %4) #14 comdat {
  %6 = alloca %"class.caffe2::TypeMeta"*, align 8
  %7 = alloca %"class.caffe2::TypeMeta"*, align 8
  %8 = alloca %"class.caffe2::TypeMeta"*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %"class.caffe2::TypeMeta", align 2
  %14 = alloca %"class.caffe2::TypeMeta", align 2
  %15 = alloca %"class.caffe2::TypeMeta", align 2
  %16 = alloca %"class.caffe2::TypeMeta", align 2
  %17 = alloca %"class.caffe2::TypeMeta", align 2
  %18 = alloca %"class.caffe2::TypeMeta", align 2
  %19 = alloca %"class.caffe2::TypeMeta", align 2
  %20 = alloca %"class.caffe2::TypeMeta", align 2
  %21 = alloca %"class.caffe2::TypeMeta", align 2
  %22 = alloca %"class.caffe2::TypeMeta", align 2
  %23 = alloca %"class.caffe2::TypeMeta", align 2
  %24 = alloca %"class.caffe2::TypeMeta", align 2
  store %"class.caffe2::TypeMeta"* %0, %"class.caffe2::TypeMeta"** %6, align 8
  store %"class.caffe2::TypeMeta"* %1, %"class.caffe2::TypeMeta"** %7, align 8
  store %"class.caffe2::TypeMeta"* %2, %"class.caffe2::TypeMeta"** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %25 = load i32, i32* %9, align 4
  %26 = mul nsw i32 2, %25
  store i32 %26, i32* %11, align 4
  %27 = load i32, i32* %9, align 4
  %28 = mul nsw i32 2, %27
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* %12, align 4
  %30 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %7, align 8
  %31 = load i32, i32* %11, align 4
  %32 = sdiv i32 %31, 2
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %30, i64 %33
  %35 = call %"class.caffe2::TypeMeta" @_ZN3c105__ldgEPKNS_8BFloat16E(%"class.caffe2::TypeMeta"* %34) #19
  %36 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %15, i32 0, i32 0
  %37 = extractvalue %"class.caffe2::TypeMeta" %35, 0
  store i16 %37, i16* %36, align 2
  %38 = bitcast %"class.caffe2::TypeMeta"* %13 to i8*
  %39 = bitcast %"class.caffe2::TypeMeta"* %15 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %38, i8* align 2 %39, i64 2, i1 false)
  %40 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %8, align 8
  %41 = load i32, i32* %11, align 4
  %42 = sdiv i32 %41, 2
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %40, i64 %43
  %45 = call %"class.caffe2::TypeMeta" @_ZN3c105__ldgEPKNS_8BFloat16E(%"class.caffe2::TypeMeta"* %44) #19
  %46 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %16, i32 0, i32 0
  %47 = extractvalue %"class.caffe2::TypeMeta" %45, 0
  store i16 %47, i16* %46, align 2
  %48 = bitcast %"class.caffe2::TypeMeta"* %14 to i8*
  %49 = bitcast %"class.caffe2::TypeMeta"* %16 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %48, i8* align 2 %49, i64 2, i1 false)
  %50 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %51 = load i32, i32* %11, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %50, i64 %52
  %54 = bitcast %"class.caffe2::TypeMeta"* %17 to i8*
  %55 = bitcast %"class.caffe2::TypeMeta"* %53 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %54, i8* align 2 %55, i64 2, i1 false)
  %56 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %57 = load i32, i32* %12, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %56, i64 %58
  %60 = bitcast %"class.caffe2::TypeMeta"* %18 to i8*
  %61 = bitcast %"class.caffe2::TypeMeta"* %59 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %60, i8* align 2 %61, i64 2, i1 false)
  %62 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %13) #19
  %63 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %20, i32 0, i32 0
  %64 = extractvalue %"class.caffe2::TypeMeta" %62, 0
  store i16 %64, i16* %63, align 2
  %65 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %18, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %14) #19
  %66 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %21, i32 0, i32 0
  %67 = extractvalue %"class.caffe2::TypeMeta" %65, 0
  store i16 %67, i16* %66, align 2
  %68 = call %"class.caffe2::TypeMeta" @_ZN3c10miERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %20, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %21) #19
  %69 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %19, i32 0, i32 0
  %70 = extractvalue %"class.caffe2::TypeMeta" %68, 0
  store i16 %70, i16* %69, align 2
  %71 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %72 = load i32, i32* %11, align 4
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %71, i64 %73
  %75 = bitcast %"class.caffe2::TypeMeta"* %74 to i8*
  %76 = bitcast %"class.caffe2::TypeMeta"* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %75, i8* align 2 %76, i64 2, i1 false)
  %77 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %18, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %13) #19
  %78 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %23, i32 0, i32 0
  %79 = extractvalue %"class.caffe2::TypeMeta" %77, 0
  store i16 %79, i16* %78, align 2
  %80 = call %"class.caffe2::TypeMeta" @_ZN3c10mlERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %17, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %14) #19
  %81 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %24, i32 0, i32 0
  %82 = extractvalue %"class.caffe2::TypeMeta" %80, 0
  store i16 %82, i16* %81, align 2
  %83 = call %"class.caffe2::TypeMeta" @_ZN3c10plERKNS_8BFloat16ES2_(%"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %23, %"class.caffe2::TypeMeta"* nonnull align 2 dereferenceable(2) %24) #19
  %84 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %22, i32 0, i32 0
  %85 = extractvalue %"class.caffe2::TypeMeta" %83, 0
  store i16 %85, i16* %84, align 2
  %86 = load %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"** %6, align 8
  %87 = load i32, i32* %12, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds %"class.caffe2::TypeMeta", %"class.caffe2::TypeMeta"* %86, i64 %88
  %90 = bitcast %"class.caffe2::TypeMeta"* %89 to i8*
  %91 = bitcast %"class.caffe2::TypeMeta"* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %90, i8* align 2 %91, i64 2, i1 false)
  ret void
}

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { mustprogress noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { argmemonly nofree nounwind willreturn }
attributes #9 = { noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { noinline noreturn nounwind }
attributes #12 = { convergent mustprogress noinline norecurse nounwind optnone "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="sm_80" "target-features"="+ptx72,+sm_80" }
attributes #13 = { nounwind readnone }
attributes #14 = { convergent mustprogress noinline nounwind optnone "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="sm_80" "target-features"="+ptx72,+sm_80" }
attributes #15 = { argmemonly nounwind readonly }
attributes #16 = { convergent noinline nounwind optnone "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="sm_80" "target-features"="+ptx72,+sm_80" }
attributes #17 = { noreturn }
attributes #18 = { noreturn nounwind }
attributes #19 = { convergent nounwind }
attributes #20 = { convergent nounwind readnone }

!llvm.ident = !{!0, !0, !1}
!llvm.module.flags = !{!2, !3, !4, !5, !6}
!nvvm.annotations = !{!7, !8, !9, !10, !11, !12}
!nvvmir.version = !{!13}

!0 = !{!"Ubuntu clang version 13.0.1-2ubuntu2.2"}
!1 = !{!"clang version 3.8.0 (tags/RELEASE_380/final)"}
!2 = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 2]}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 7, !"uwtable", i32 1}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!7 = !{void (i64*, float*, float*, float*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm23rotary_embedding_kernelIfLb1EEEvPKlPT_S4_PKS3_iiiiii, !"kernel", i32 1}
!8 = !{void (i64*, float*, float*, float*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm23rotary_embedding_kernelIfLb0EEEvPKlPT_S4_PKS3_iiiiii, !"kernel", i32 1}
!9 = !{void (i64*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm23rotary_embedding_kernelIN3c104HalfELb1EEEvPKlPT_S6_PKS5_iiiiii, !"kernel", i32 1}
!10 = !{void (i64*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm23rotary_embedding_kernelIN3c104HalfELb0EEEvPKlPT_S6_PKS5_iiiiii, !"kernel", i32 1}
!11 = !{void (i64*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm23rotary_embedding_kernelIN3c108BFloat16ELb1EEEvPKlPT_S6_PKS5_iiiiii, !"kernel", i32 1}
!12 = !{void (i64*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, %"class.caffe2::TypeMeta"*, i32, i32, i32, i32, i32, i32)* @_ZN4vllm23rotary_embedding_kernelIN3c108BFloat16ELb0EEEvPKlPT_S6_PKS5_iiiiii, !"kernel", i32 1}
!13 = !{i32 2, i32 0}
!14 = distinct !{!14, !15}
!15 = !{!"llvm.loop.mustprogress"}
!16 = distinct !{!16, !15}
!17 = distinct !{!17, !15}
!18 = distinct !{!18, !15}
!19 = distinct !{!19, !15}
!20 = distinct !{!20, !15}
!21 = !{i64 2159576755}
!22 = !{i64 2159641535}
!23 = !{i64 12018264}
!24 = distinct !{!24, !15}
!25 = distinct !{!25, !15}
!26 = distinct !{!26, !15}
!27 = distinct !{!27, !15}
!28 = !{i64 2156778197}
!29 = !{i64 2156847623}
!30 = !{i64 9198958}
!31 = distinct !{!31, !15}
!32 = distinct !{!32, !15}
