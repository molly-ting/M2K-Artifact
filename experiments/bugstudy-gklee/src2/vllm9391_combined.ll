; ModuleID = 'vllm9391_combined.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%struct.dim3 = type { i32, i32, i32 }
%struct.CUstream_st = type opaque
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

$_ZNK2at10TensorBase13is_contiguousEN3c1012MemoryFormatE = comdat any

$_ZN3c106detail17torchCheckMsgImplEPKc = comdat any

$_ZNK2at10TensorBase5numelEv = comdat any

$_ZNK2at10TensorBase4sizeEl = comdat any

$_ZN4dim3C2Ejjj = comdat any

$_ZSt3minIiEUa9enable_ifILb1EERKT_S2_S2_ = comdat any

$_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv = comdat any

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

$_ZNK3c1010TensorImpl13is_contiguousENS_12MemoryFormatE = comdat any

$_ZNK3c1010TensorImpl21is_contiguous_defaultENS_12MemoryFormatE = comdat any

$_ZNK3c1010TensorImpl19symbolic_shape_metaEv = comdat any

$_ZNK3c1017SymbolicShapeMeta27is_channels_last_contiguousEv = comdat any

$_ZNK3c1017SymbolicShapeMeta30is_channels_last_3d_contiguousEv = comdat any

$_ZNK3c1017SymbolicShapeMeta13is_contiguousEv = comdat any

$_ZNK3c1017SymbolicShapeMeta17has_is_contiguousEv = comdat any

$_ZStanSt12memory_orderSt23__memory_order_modifier = comdat any

$__clang_call_terminate = comdat any

$_ZNK3c1017SymbolicShapeMeta34has_is_channels_last_3d_contiguousEv = comdat any

$_ZNK3c1017SymbolicShapeMeta31has_is_channels_last_contiguousEv = comdat any

$_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEcvbEv = comdat any

$_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEptEv = comdat any

$_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEcvbEv = comdat any

$_ZN3c103strIJEEEDcDpRKT_ = comdat any

$_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_NS0_22CompileTimeEmptyStringE = comdat any

$_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEdeEv = comdat any

$_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE3getEv = comdat any

$_ZNKSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE6_M_ptrEv = comdat any

$_ZSt3getILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_ = comdat any

$_ZSt12__get_helperILm0EPN3c1017SymbolicShapeMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE = comdat any

$_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_headERKS5_ = comdat any

$_ZNSt10_Head_baseILm0EPN3c1017SymbolicShapeMetaELb0EE7_M_headERKS3_ = comdat any

$_ZN3c106detail12_str_wrapperIJEE4callEv = comdat any

$_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE3getEv = comdat any

$_ZNKSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE6_M_ptrEv = comdat any

$_ZSt3getILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_ = comdat any

$_ZSt12__get_helperILm0EPN3c109ExtraMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE = comdat any

$_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_headERKS5_ = comdat any

$_ZNSt10_Head_baseILm0EPN3c109ExtraMetaELb0EE7_M_headERKS3_ = comdat any

$_Z16float_to_int8_rnf = comdat any

@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_vllm9391.cu, i8* null }]
@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1, !dbg !0
@__dso_handle = external hidden global i8
@__func__._Z24static_scaled_int8_quantRN2at6TensorERKS0_S3_ = private unnamed_addr constant [25 x i8] c"static_scaled_int8_quant\00", align 1
@.str = private unnamed_addr constant [60 x i8] c"/home/mvh6224/CUDA-BOSolver/bugstudy-gklee/src2/vllm9391.cu\00", align 1
@.str.1 = private unnamed_addr constant [156 x i8] c"Expected input.is_contiguous() to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@.str.2 = private unnamed_addr constant [154 x i8] c"Expected out.is_contiguous() to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@.str.3 = private unnamed_addr constant [153 x i8] c"Expected scale.numel() == 1 to be true, but got false.  (Could this error message be improved?  If so, please report an enhancement request to PyTorch.)\00", align 1
@.str.4 = private unnamed_addr constant [104 x i8] c"/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/TensorImpl.h\00", align 1
@__func__._ZNK3c1010TensorImpl19symbolic_shape_metaEv = private unnamed_addr constant [20 x i8] c"symbolic_shape_meta\00", align 1
@.str.5 = private unnamed_addr constant [220 x i8] c"extra_meta_ && extra_meta_->symbolic_shape_meta_ INTERNAL ASSERT FAILED at \22/home/mvh6224/CUDA-BOSolver/.vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/TensorImpl.h\22:1733, please report a bug to PyTorch. \00", align 1

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_vllm9391.cu() #0 section ".text.startup" !dbg !7240 {
  call void @__cxx_global_var_init(), !dbg !7242
  ret void
}

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" !dbg !7243 {
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) @_ZStL8__ioinit), !dbg !7244
  %1 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #3, !dbg !7246
  ret void, !dbg !7244
}

declare dso_local void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nounwind
declare dso_local void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #2

; Function Attrs: nounwind
declare dso_local i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #3

; Function Attrs: noinline norecurse optnone uwtable
define dso_local void @_Z52__device_stub__static_scaled_int8_quant_kernel_buggyPKfPaS0_i(float* noalias %0, i8* noalias %1, float* noalias %2, i32 %3) #4 !dbg !7247 {
  %5 = alloca float*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca float*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.dim3, align 8
  %10 = alloca %struct.dim3, align 8
  %11 = alloca i64, align 8
  %12 = alloca i8*, align 8
  %13 = alloca { i64, i32 }, align 8
  %14 = alloca { i64, i32 }, align 8
  store float* %0, float** %5, align 8
  call void @llvm.dbg.declare(metadata float** %5, metadata !7255, metadata !DIExpression()), !dbg !7256
  store i8* %1, i8** %6, align 8
  call void @llvm.dbg.declare(metadata i8** %6, metadata !7257, metadata !DIExpression()), !dbg !7258
  store float* %2, float** %7, align 8
  call void @llvm.dbg.declare(metadata float** %7, metadata !7259, metadata !DIExpression()), !dbg !7260
  store i32 %3, i32* %8, align 4
  call void @llvm.dbg.declare(metadata i32* %8, metadata !7261, metadata !DIExpression()), !dbg !7262
  %15 = alloca i8*, i64 4, align 16, !dbg !7263
  %16 = bitcast float** %5 to i8*, !dbg !7263
  %17 = getelementptr i8*, i8** %15, i32 0, !dbg !7263
  store i8* %16, i8** %17, align 8, !dbg !7263
  %18 = bitcast i8** %6 to i8*, !dbg !7263
  %19 = getelementptr i8*, i8** %15, i32 1, !dbg !7263
  store i8* %18, i8** %19, align 8, !dbg !7263
  %20 = bitcast float** %7 to i8*, !dbg !7263
  %21 = getelementptr i8*, i8** %15, i32 2, !dbg !7263
  store i8* %20, i8** %21, align 8, !dbg !7263
  %22 = bitcast i32* %8 to i8*, !dbg !7263
  %23 = getelementptr i8*, i8** %15, i32 3, !dbg !7263
  store i8* %22, i8** %23, align 8, !dbg !7263
  %24 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %9, %struct.dim3* %10, i64* %11, i8** %12), !dbg !7263
  %25 = load i64, i64* %11, align 8, !dbg !7263
  %26 = load i8*, i8** %12, align 8, !dbg !7263
  %27 = bitcast { i64, i32 }* %13 to i8*, !dbg !7263
  %28 = bitcast %struct.dim3* %9 to i8*, !dbg !7263
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %27, i8* align 8 %28, i64 12, i1 false), !dbg !7263
  %29 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %13, i32 0, i32 0, !dbg !7263
  %30 = load i64, i64* %29, align 8, !dbg !7263
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %13, i32 0, i32 1, !dbg !7263
  %32 = load i32, i32* %31, align 8, !dbg !7263
  %33 = bitcast { i64, i32 }* %14 to i8*, !dbg !7263
  %34 = bitcast %struct.dim3* %10 to i8*, !dbg !7263
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %33, i8* align 8 %34, i64 12, i1 false), !dbg !7263
  %35 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %14, i32 0, i32 0, !dbg !7263
  %36 = load i64, i64* %35, align 8, !dbg !7263
  %37 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %14, i32 0, i32 1, !dbg !7263
  %38 = load i32, i32* %37, align 8, !dbg !7263
  %39 = bitcast i8* %26 to %struct.CUstream_st*, !dbg !7263
  %40 = call i32 @cudaLaunchKernel(i8* bitcast (void (float*, i8*, float*, i32)* @_Z52__device_stub__static_scaled_int8_quant_kernel_buggyPKfPaS0_i to i8*), i64 %30, i32 %32, i64 %36, i32 %38, i8** %15, i64 %25, %struct.CUstream_st* %39), !dbg !7263
  br label %41, !dbg !7263

41:                                               ; preds = %4
  ret void, !dbg !7264
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #5

declare dso_local i32 @__cudaPopCallConfiguration(%struct.dim3*, %struct.dim3*, i64*, i8**)

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #6

declare dso_local i32 @cudaLaunchKernel(i8*, i64, i32, i64, i32, i8**, i64, %struct.CUstream_st*)

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_Z24static_scaled_int8_quantRN2at6TensorERKS0_S3_(%"class.at::Tensor"* nonnull align 8 dereferenceable(8) %0, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %1, %"class.at::Tensor"* nonnull align 8 dereferenceable(8) %2) #7 !dbg !7265 {
  %4 = alloca %"class.at::Tensor"*, align 8
  %5 = alloca %"class.at::Tensor"*, align 8
  %6 = alloca %"class.at::Tensor"*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %struct.dim3, align 4
  %10 = alloca %struct.dim3, align 4
  %11 = alloca i32, align 4
  %12 = alloca %struct.dim3, align 4
  %13 = alloca %struct.dim3, align 4
  %14 = alloca { i64, i32 }, align 4
  %15 = alloca { i64, i32 }, align 4
  store %"class.at::Tensor"* %0, %"class.at::Tensor"** %4, align 8
  call void @llvm.dbg.declare(metadata %"class.at::Tensor"** %4, metadata !7271, metadata !DIExpression()), !dbg !7272
  store %"class.at::Tensor"* %1, %"class.at::Tensor"** %5, align 8
  call void @llvm.dbg.declare(metadata %"class.at::Tensor"** %5, metadata !7273, metadata !DIExpression()), !dbg !7274
  store %"class.at::Tensor"* %2, %"class.at::Tensor"** %6, align 8
  call void @llvm.dbg.declare(metadata %"class.at::Tensor"** %6, metadata !7275, metadata !DIExpression()), !dbg !7276
  %16 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8, !dbg !7277
  %17 = bitcast %"class.at::Tensor"* %16 to %"class.at::TensorBase"*, !dbg !7277
  %18 = call zeroext i1 @_ZNK2at10TensorBase13is_contiguousEN3c1012MemoryFormatE(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %17, i8 signext 0), !dbg !7277
  br i1 %18, label %21, label %19, !dbg !7279

19:                                               ; preds = %3
  %20 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKc(i8* getelementptr inbounds ([156 x i8], [156 x i8]* @.str.1, i64 0, i64 0)), !dbg !7280
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__func__._Z24static_scaled_int8_quantRN2at6TensorERKS0_S3_, i64 0, i64 0), i8* getelementptr inbounds ([60 x i8], [60 x i8]* @.str, i64 0, i64 0), i32 48, i8* %20) #16, !dbg !7280
  unreachable, !dbg !7280

21:                                               ; preds = %3
  %22 = load %"class.at::Tensor"*, %"class.at::Tensor"** %4, align 8, !dbg !7282
  %23 = bitcast %"class.at::Tensor"* %22 to %"class.at::TensorBase"*, !dbg !7282
  %24 = call zeroext i1 @_ZNK2at10TensorBase13is_contiguousEN3c1012MemoryFormatE(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %23, i8 signext 0), !dbg !7282
  br i1 %24, label %27, label %25, !dbg !7284

25:                                               ; preds = %21
  %26 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKc(i8* getelementptr inbounds ([154 x i8], [154 x i8]* @.str.2, i64 0, i64 0)), !dbg !7285
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__func__._Z24static_scaled_int8_quantRN2at6TensorERKS0_S3_, i64 0, i64 0), i8* getelementptr inbounds ([60 x i8], [60 x i8]* @.str, i64 0, i64 0), i32 49, i8* %26) #16, !dbg !7285
  unreachable, !dbg !7285

27:                                               ; preds = %21
  %28 = load %"class.at::Tensor"*, %"class.at::Tensor"** %6, align 8, !dbg !7287
  %29 = bitcast %"class.at::Tensor"* %28 to %"class.at::TensorBase"*, !dbg !7287
  %30 = call i64 @_ZNK2at10TensorBase5numelEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %29), !dbg !7287
  %31 = icmp eq i64 %30, 1, !dbg !7287
  br i1 %31, label %34, label %32, !dbg !7289

32:                                               ; preds = %27
  %33 = call i8* @_ZN3c106detail17torchCheckMsgImplEPKc(i8* getelementptr inbounds ([153 x i8], [153 x i8]* @.str.3, i64 0, i64 0)), !dbg !7290
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__func__._Z24static_scaled_int8_quantRN2at6TensorERKS0_S3_, i64 0, i64 0), i8* getelementptr inbounds ([60 x i8], [60 x i8]* @.str, i64 0, i64 0), i32 50, i8* %33) #16, !dbg !7290
  unreachable, !dbg !7290

34:                                               ; preds = %27
  call void @llvm.dbg.declare(metadata i32* %7, metadata !7292, metadata !DIExpression()), !dbg !7293
  %35 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8, !dbg !7294
  %36 = bitcast %"class.at::Tensor"* %35 to %"class.at::TensorBase"*, !dbg !7294
  %37 = call i64 @_ZNK2at10TensorBase4sizeEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %36, i64 -1), !dbg !7295
  %38 = trunc i64 %37 to i32, !dbg !7294
  store i32 %38, i32* %7, align 4, !dbg !7293
  call void @llvm.dbg.declare(metadata i32* %8, metadata !7296, metadata !DIExpression()), !dbg !7297
  %39 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8, !dbg !7298
  %40 = bitcast %"class.at::Tensor"* %39 to %"class.at::TensorBase"*, !dbg !7298
  %41 = call i64 @_ZNK2at10TensorBase5numelEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %40), !dbg !7299
  %42 = load i32, i32* %7, align 4, !dbg !7300
  %43 = sext i32 %42 to i64, !dbg !7300
  %44 = sdiv i64 %41, %43, !dbg !7301
  %45 = trunc i64 %44 to i32, !dbg !7298
  store i32 %45, i32* %8, align 4, !dbg !7297
  call void @llvm.dbg.declare(metadata %struct.dim3* %9, metadata !7302, metadata !DIExpression()), !dbg !7305
  %46 = load i32, i32* %8, align 4, !dbg !7306
  call void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %9, i32 %46, i32 1, i32 1), !dbg !7305
  call void @llvm.dbg.declare(metadata %struct.dim3* %10, metadata !7307, metadata !DIExpression()), !dbg !7308
  store i32 1024, i32* %11, align 4, !dbg !7309
  %47 = call nonnull align 4 dereferenceable(4) i32* @_ZSt3minIiEUa9enable_ifILb1EERKT_S2_S2_(i32* nonnull align 4 dereferenceable(4) %7, i32* nonnull align 4 dereferenceable(4) %11), !dbg !7310
  %48 = load i32, i32* %47, align 4, !dbg !7310
  call void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %10, i32 %48, i32 1, i32 1), !dbg !7308
  %49 = bitcast %struct.dim3* %12 to i8*, !dbg !7311
  %50 = bitcast %struct.dim3* %9 to i8*, !dbg !7311
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %49, i8* align 4 %50, i64 12, i1 false), !dbg !7311
  %51 = bitcast %struct.dim3* %13 to i8*, !dbg !7312
  %52 = bitcast %struct.dim3* %10 to i8*, !dbg !7312
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %51, i8* align 4 %52, i64 12, i1 false), !dbg !7312
  %53 = bitcast { i64, i32 }* %14 to i8*, !dbg !7313
  %54 = bitcast %struct.dim3* %12 to i8*, !dbg !7313
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %53, i8* align 4 %54, i64 12, i1 false), !dbg !7313
  %55 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %14, i32 0, i32 0, !dbg !7313
  %56 = load i64, i64* %55, align 4, !dbg !7313
  %57 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %14, i32 0, i32 1, !dbg !7313
  %58 = load i32, i32* %57, align 4, !dbg !7313
  %59 = bitcast { i64, i32 }* %15 to i8*, !dbg !7313
  %60 = bitcast %struct.dim3* %13 to i8*, !dbg !7313
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %59, i8* align 4 %60, i64 12, i1 false), !dbg !7313
  %61 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %15, i32 0, i32 0, !dbg !7313
  %62 = load i64, i64* %61, align 4, !dbg !7313
  %63 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %15, i32 0, i32 1, !dbg !7313
  %64 = load i32, i32* %63, align 4, !dbg !7313
  %65 = call i32 @__cudaPushCallConfiguration(i64 %56, i32 %58, i64 %62, i32 %64, i64 0, i8* null), !dbg !7313
  %66 = icmp ne i32 %65, 0, !dbg !7313
  br i1 %66, label %78, label %67, !dbg !7314

67:                                               ; preds = %34
  %68 = load %"class.at::Tensor"*, %"class.at::Tensor"** %5, align 8, !dbg !7315
  %69 = bitcast %"class.at::Tensor"* %68 to %"class.at::TensorBase"*, !dbg !7315
  %70 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %69), !dbg !7316
  %71 = load %"class.at::Tensor"*, %"class.at::Tensor"** %4, align 8, !dbg !7317
  %72 = bitcast %"class.at::Tensor"* %71 to %"class.at::TensorBase"*, !dbg !7317
  %73 = call i8* @_ZNK2at10TensorBase8data_ptrIaEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %72), !dbg !7318
  %74 = load %"class.at::Tensor"*, %"class.at::Tensor"** %6, align 8, !dbg !7319
  %75 = bitcast %"class.at::Tensor"* %74 to %"class.at::TensorBase"*, !dbg !7319
  %76 = call float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %75), !dbg !7320
  %77 = load i32, i32* %7, align 4, !dbg !7321
  call void @_Z52__device_stub__static_scaled_int8_quant_kernel_buggyPKfPaS0_i(float* %70, i8* %73, float* %76, i32 %77), !dbg !7314
  br label %78, !dbg !7314

78:                                               ; preds = %67, %34
  ret void, !dbg !7322
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK2at10TensorBase13is_contiguousEN3c1012MemoryFormatE(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0, i8 signext %1) #7 comdat align 2 !dbg !7323 {
  %3 = alloca %"class.at::TensorBase"*, align 8
  %4 = alloca i8, align 1
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %3, align 8
  call void @llvm.dbg.declare(metadata %"class.at::TensorBase"** %3, metadata !7331, metadata !DIExpression()), !dbg !7333
  store i8 %1, i8* %4, align 1
  call void @llvm.dbg.declare(metadata i8* %4, metadata !7334, metadata !DIExpression()), !dbg !7335
  %5 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %3, align 8
  %6 = getelementptr inbounds %"class.at::TensorBase", %"class.at::TensorBase"* %5, i32 0, i32 0, !dbg !7336
  %7 = call %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %6) #3, !dbg !7336
  %8 = load i8, i8* %4, align 1, !dbg !7337
  %9 = call zeroext i1 @_ZNK3c1010TensorImpl13is_contiguousENS_12MemoryFormatE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %7, i8 signext %8), !dbg !7338
  ret i1 %9, !dbg !7339
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i8* @_ZN3c106detail17torchCheckMsgImplEPKc(i8* %0) #8 comdat !dbg !7340 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  call void @llvm.dbg.declare(metadata i8** %2, metadata !7345, metadata !DIExpression()), !dbg !7346
  %3 = load i8*, i8** %2, align 8, !dbg !7347
  ret i8* %3, !dbg !7348
}

; Function Attrs: noreturn
declare dso_local void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8*, i8*, i32, i8*) #9

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK2at10TensorBase5numelEv(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0) #7 comdat align 2 !dbg !7349 {
  %2 = alloca %"class.at::TensorBase"*, align 8
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.at::TensorBase"** %2, metadata !7353, metadata !DIExpression()), !dbg !7354
  %3 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %2, align 8
  %4 = getelementptr inbounds %"class.at::TensorBase", %"class.at::TensorBase"* %3, i32 0, i32 0, !dbg !7355
  %5 = call %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %4) #3, !dbg !7355
  %6 = call i64 @_ZNK3c1010TensorImpl5numelEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %5), !dbg !7356
  ret i64 %6, !dbg !7357
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK2at10TensorBase4sizeEl(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8) %0, i64 %1) #7 comdat align 2 !dbg !7358 {
  %3 = alloca %"class.at::TensorBase"*, align 8
  %4 = alloca i64, align 8
  store %"class.at::TensorBase"* %0, %"class.at::TensorBase"** %3, align 8
  call void @llvm.dbg.declare(metadata %"class.at::TensorBase"** %3, metadata !7362, metadata !DIExpression()), !dbg !7363
  store i64 %1, i64* %4, align 8
  call void @llvm.dbg.declare(metadata i64* %4, metadata !7364, metadata !DIExpression()), !dbg !7365
  %5 = load %"class.at::TensorBase"*, %"class.at::TensorBase"** %3, align 8
  %6 = getelementptr inbounds %"class.at::TensorBase", %"class.at::TensorBase"* %5, i32 0, i32 0, !dbg !7366
  %7 = call %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %6) #3, !dbg !7366
  %8 = load i64, i64* %4, align 8, !dbg !7367
  %9 = call i64 @_ZNK3c1010TensorImpl4sizeEl(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %7, i64 %8), !dbg !7368
  ret i64 %9, !dbg !7369
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN4dim3C2Ejjj(%struct.dim3* nonnull align 4 dereferenceable(12) %0, i32 %1, i32 %2, i32 %3) unnamed_addr #10 comdat align 2 !dbg !7370 {
  %5 = alloca %struct.dim3*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.dim3* %0, %struct.dim3** %5, align 8
  call void @llvm.dbg.declare(metadata %struct.dim3** %5, metadata !7371, metadata !DIExpression()), !dbg !7373
  store i32 %1, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !7374, metadata !DIExpression()), !dbg !7375
  store i32 %2, i32* %7, align 4
  call void @llvm.dbg.declare(metadata i32* %7, metadata !7376, metadata !DIExpression()), !dbg !7377
  store i32 %3, i32* %8, align 4
  call void @llvm.dbg.declare(metadata i32* %8, metadata !7378, metadata !DIExpression()), !dbg !7379
  %9 = load %struct.dim3*, %struct.dim3** %5, align 8
  %10 = getelementptr inbounds %struct.dim3, %struct.dim3* %9, i32 0, i32 0, !dbg !7380
  %11 = load i32, i32* %6, align 4, !dbg !7381
  store i32 %11, i32* %10, align 4, !dbg !7380
  %12 = getelementptr inbounds %struct.dim3, %struct.dim3* %9, i32 0, i32 1, !dbg !7382
  %13 = load i32, i32* %7, align 4, !dbg !7383
  store i32 %13, i32* %12, align 4, !dbg !7382
  %14 = getelementptr inbounds %struct.dim3, %struct.dim3* %9, i32 0, i32 2, !dbg !7384
  %15 = load i32, i32* %8, align 4, !dbg !7385
  store i32 %15, i32* %14, align 4, !dbg !7384
  ret void, !dbg !7386
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 4 dereferenceable(4) i32* @_ZSt3minIiEUa9enable_ifILb1EERKT_S2_S2_(i32* nonnull align 4 dereferenceable(4) %0, i32* nonnull align 4 dereferenceable(4) %1) #8 comdat !dbg !7387 {
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  store i32* %0, i32** %3, align 8
  call void @llvm.dbg.declare(metadata i32** %3, metadata !7394, metadata !DIExpression()), !dbg !7395
  store i32* %1, i32** %4, align 8
  call void @llvm.dbg.declare(metadata i32** %4, metadata !7396, metadata !DIExpression()), !dbg !7397
  %5 = load i32*, i32** %3, align 8, !dbg !7398
  %6 = load i32, i32* %5, align 4, !dbg !7398
  %7 = load i32*, i32** %4, align 8, !dbg !7399
  %8 = load i32, i32* %7, align 4, !dbg !7399
  %9 = icmp slt i32 %6, %8, !dbg !7400
  br i1 %9, label %10, label %12, !dbg !7398

10:                                               ; preds = %2
  %11 = load i32*, i32** %3, align 8, !dbg !7401
  br label %14, !dbg !7398

12:                                               ; preds = %2
  %13 = load i32*, i32** %4, align 8, !dbg !7402
  br label %14, !dbg !7398

14:                                               ; preds = %12, %10
  %15 = phi i32* [ %11, %10 ], [ %13, %12 ], !dbg !7398
  ret i32* %15, !dbg !7403
}

declare dso_local i32 @__cudaPushCallConfiguration(i64, i32, i64, i32, i64, i8*) #1

declare dso_local float* @_ZNK2at10TensorBase8data_ptrIfEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8)) #1

declare dso_local i8* @_ZNK2at10TensorBase8data_ptrIaEEPT_v(%"class.at::TensorBase"* nonnull align 8 dereferenceable(8)) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::TensorImpl"* @_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv(%"class.c10::intrusive_ptr"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7404 {
  %2 = alloca %"class.c10::intrusive_ptr"*, align 8
  store %"class.c10::intrusive_ptr"* %0, %"class.c10::intrusive_ptr"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::intrusive_ptr"** %2, metadata !7412, metadata !DIExpression()), !dbg !7414
  %3 = load %"class.c10::intrusive_ptr"*, %"class.c10::intrusive_ptr"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::intrusive_ptr", %"class.c10::intrusive_ptr"* %3, i32 0, i32 0, !dbg !7415
  %5 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %4, align 8, !dbg !7415
  ret %"struct.c10::TensorImpl"* %5, !dbg !7416
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c1010TensorImpl4sizeEl(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0, i64 %1) #7 comdat align 2 !dbg !7417 {
  %3 = alloca i64, align 8
  %4 = alloca %"struct.c10::TensorImpl"*, align 8
  %5 = alloca i64, align 8
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %4, align 8
  call void @llvm.dbg.declare(metadata %"struct.c10::TensorImpl"** %4, metadata !7423, metadata !DIExpression()), !dbg !7425
  store i64 %1, i64* %5, align 8
  call void @llvm.dbg.declare(metadata i64* %5, metadata !7426, metadata !DIExpression()), !dbg !7427
  %6 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %4, align 8
  %7 = call zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6, i8 zeroext 2), !dbg !7428
  br i1 %7, label %8, label %15, !dbg !7430

8:                                                ; preds = %2
  %9 = load i64, i64* %5, align 8, !dbg !7431
  %10 = bitcast %"struct.c10::TensorImpl"* %6 to i64 (%"struct.c10::TensorImpl"*, i64)***, !dbg !7433
  %11 = load i64 (%"struct.c10::TensorImpl"*, i64)**, i64 (%"struct.c10::TensorImpl"*, i64)*** %10, align 8, !dbg !7433
  %12 = getelementptr inbounds i64 (%"struct.c10::TensorImpl"*, i64)*, i64 (%"struct.c10::TensorImpl"*, i64)** %11, i64 6, !dbg !7433
  %13 = load i64 (%"struct.c10::TensorImpl"*, i64)*, i64 (%"struct.c10::TensorImpl"*, i64)** %12, align 8, !dbg !7433
  %14 = call i64 %13(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6, i64 %9), !dbg !7433
  store i64 %14, i64* %3, align 8, !dbg !7434
  br label %22, !dbg !7434

15:                                               ; preds = %2
  %16 = load i64, i64* %5, align 8, !dbg !7435
  %17 = call i64 @_ZNK3c1010TensorImpl3dimEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6), !dbg !7436
  %18 = call i64 @_ZN3c1014maybe_wrap_dimEllb(i64 %16, i64 %17, i1 zeroext false), !dbg !7437
  store i64 %18, i64* %5, align 8, !dbg !7438
  %19 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %6, i32 0, i32 6, !dbg !7439
  %20 = load i64, i64* %5, align 8, !dbg !7440
  %21 = call i64 @_ZNK3c104impl15SizesAndStrides17size_at_uncheckedEm(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %19, i64 %20) #3, !dbg !7441
  store i64 %21, i64* %3, align 8, !dbg !7442
  br label %22, !dbg !7442

22:                                               ; preds = %15, %8
  %23 = load i64, i64* %3, align 8, !dbg !7443
  ret i64 %23, !dbg !7443
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0, i8 zeroext %1) #8 comdat align 2 !dbg !7444 {
  %3 = alloca %"struct.c10::TensorImpl"*, align 8
  %4 = alloca i8, align 1
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %3, align 8
  call void @llvm.dbg.declare(metadata %"struct.c10::TensorImpl"** %3, metadata !7448, metadata !DIExpression()), !dbg !7449
  store i8 %1, i8* %4, align 1
  call void @llvm.dbg.declare(metadata i8* %4, metadata !7450, metadata !DIExpression()), !dbg !7451
  %5 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %3, align 8
  %6 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %5, i32 0, i32 11, !dbg !7452
  %7 = bitcast [3 x i8]* %6 to i24*, !dbg !7452
  %8 = load i24, i24* %7, align 1, !dbg !7452
  %9 = lshr i24 %8, 10, !dbg !7452
  %10 = and i24 %9, 3, !dbg !7452
  %11 = trunc i24 %10 to i8, !dbg !7452
  %12 = zext i8 %11 to i32, !dbg !7452
  %13 = load i8, i8* %4, align 1, !dbg !7453
  %14 = zext i8 %13 to i32, !dbg !7454
  %15 = icmp sge i32 %12, %14, !dbg !7455
  ret i1 %15, !dbg !7456
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c1010TensorImpl3dimEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #7 comdat align 2 !dbg !7457 {
  %2 = alloca i64, align 8
  %3 = alloca %"struct.c10::TensorImpl"*, align 8
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %3, align 8
  call void @llvm.dbg.declare(metadata %"struct.c10::TensorImpl"** %3, metadata !7461, metadata !DIExpression()), !dbg !7462
  %4 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %3, align 8
  %5 = call zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4, i8 zeroext 2), !dbg !7463
  br i1 %5, label %6, label %12, !dbg !7465

6:                                                ; preds = %1
  %7 = bitcast %"struct.c10::TensorImpl"* %4 to i64 (%"struct.c10::TensorImpl"*)***, !dbg !7466
  %8 = load i64 (%"struct.c10::TensorImpl"*)**, i64 (%"struct.c10::TensorImpl"*)*** %7, align 8, !dbg !7466
  %9 = getelementptr inbounds i64 (%"struct.c10::TensorImpl"*)*, i64 (%"struct.c10::TensorImpl"*)** %8, i64 12, !dbg !7466
  %10 = load i64 (%"struct.c10::TensorImpl"*)*, i64 (%"struct.c10::TensorImpl"*)** %9, align 8, !dbg !7466
  %11 = call i64 %10(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4), !dbg !7466
  store i64 %11, i64* %2, align 8, !dbg !7468
  br label %15, !dbg !7468

12:                                               ; preds = %1
  %13 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %4, i32 0, i32 6, !dbg !7469
  %14 = call i64 @_ZNK3c104impl15SizesAndStrides4sizeEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %13) #3, !dbg !7470
  store i64 %14, i64* %2, align 8, !dbg !7471
  br label %15, !dbg !7471

15:                                               ; preds = %12, %6
  %16 = load i64, i64* %2, align 8, !dbg !7472
  ret i64 %16, !dbg !7472
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZN3c1014maybe_wrap_dimEllb(i64 %0, i64 %1, i1 zeroext %2) #7 comdat !dbg !7473 {
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8, align 1
  store i64 %0, i64* %4, align 8
  call void @llvm.dbg.declare(metadata i64* %4, metadata !7476, metadata !DIExpression()), !dbg !7477
  store i64 %1, i64* %5, align 8
  call void @llvm.dbg.declare(metadata i64* %5, metadata !7478, metadata !DIExpression()), !dbg !7479
  %7 = zext i1 %2 to i8
  store i8 %7, i8* %6, align 1
  call void @llvm.dbg.declare(metadata i8* %6, metadata !7480, metadata !DIExpression()), !dbg !7481
  %8 = load i64, i64* %4, align 8, !dbg !7482
  %9 = load i64, i64* %5, align 8, !dbg !7483
  %10 = load i8, i8* %6, align 1, !dbg !7484
  %11 = trunc i8 %10 to i1, !dbg !7484
  %12 = call i64 @_ZN3c1015_maybe_wrap_dimIlEET_S1_S1_b(i64 %8, i64 %9, i1 zeroext %11), !dbg !7485
  ret i64 %12, !dbg !7486
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c104impl15SizesAndStrides17size_at_uncheckedEm(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0, i64 %1) #8 comdat align 2 !dbg !7487 {
  %3 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  %4 = alloca i64, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %3, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::impl::SizesAndStrides"** %3, metadata !7496, metadata !DIExpression()), !dbg !7498
  store i64 %1, i64* %4, align 8
  call void @llvm.dbg.declare(metadata i64* %4, metadata !7499, metadata !DIExpression()), !dbg !7500
  %5 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %3, align 8
  %6 = call i64* @_ZNK3c104impl15SizesAndStrides10sizes_dataEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %5) #3, !dbg !7501
  %7 = load i64, i64* %4, align 8, !dbg !7502
  %8 = getelementptr inbounds i64, i64* %6, i64 %7, !dbg !7501
  %9 = load i64, i64* %8, align 8, !dbg !7501
  ret i64 %9, !dbg !7503
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i64* @_ZNK3c104impl15SizesAndStrides10sizes_dataEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #8 comdat align 2 !dbg !7504 {
  %2 = alloca i64*, align 8
  %3 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %3, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::impl::SizesAndStrides"** %3, metadata !7510, metadata !DIExpression()), !dbg !7511
  %4 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %3, align 8
  %5 = call zeroext i1 @_ZNK3c104impl15SizesAndStrides8isInlineEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %4) #3, !dbg !7512
  br i1 %5, label %6, label %10, !dbg !7514

6:                                                ; preds = %1
  %7 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %4, i32 0, i32 1, !dbg !7515
  %8 = bitcast %union.anon.52* %7 to [10 x i64]*, !dbg !7515
  %9 = getelementptr inbounds [10 x i64], [10 x i64]* %8, i64 0, i64 0, !dbg !7515
  store i64* %9, i64** %2, align 8, !dbg !7517
  br label %15, !dbg !7517

10:                                               ; preds = %1
  %11 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %4, i32 0, i32 1, !dbg !7518
  %12 = bitcast %union.anon.52* %11 to i64**, !dbg !7518
  %13 = load i64*, i64** %12, align 8, !dbg !7518
  %14 = getelementptr inbounds i64, i64* %13, i64 0, !dbg !7518
  store i64* %14, i64** %2, align 8, !dbg !7520
  br label %15, !dbg !7520

15:                                               ; preds = %10, %6
  %16 = load i64*, i64** %2, align 8, !dbg !7521
  ret i64* %16, !dbg !7521
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c104impl15SizesAndStrides8isInlineEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #8 comdat align 2 !dbg !7522 {
  %2 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::impl::SizesAndStrides"** %2, metadata !7526, metadata !DIExpression()), !dbg !7527
  %3 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %3, i32 0, i32 0, !dbg !7528
  %5 = load i64, i64* %4, align 8, !dbg !7528
  %6 = icmp ule i64 %5, 5, !dbg !7529
  ret i1 %6, !dbg !7530
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZN3c1015_maybe_wrap_dimIlEET_S1_S1_b(i64 %0, i64 %1, i1 zeroext %2) #7 comdat !dbg !7531 {
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8, align 1
  store i64 %0, i64* %5, align 8
  call void @llvm.dbg.declare(metadata i64* %5, metadata !7536, metadata !DIExpression()), !dbg !7537
  store i64 %1, i64* %6, align 8
  call void @llvm.dbg.declare(metadata i64* %6, metadata !7538, metadata !DIExpression()), !dbg !7539
  %8 = zext i1 %2 to i8
  store i8 %8, i8* %7, align 1
  call void @llvm.dbg.declare(metadata i8* %7, metadata !7540, metadata !DIExpression()), !dbg !7541
  %9 = load i64, i64* %6, align 8, !dbg !7542
  %10 = mul nsw i64 %9, -1, !dbg !7542
  %11 = load i64, i64* %5, align 8, !dbg !7542
  %12 = icmp sle i64 %10, %11, !dbg !7542
  br i1 %12, label %13, label %17, !dbg !7542

13:                                               ; preds = %3
  %14 = load i64, i64* %5, align 8, !dbg !7542
  %15 = load i64, i64* %6, align 8, !dbg !7542
  %16 = icmp slt i64 %14, %15, !dbg !7542
  br label %17

17:                                               ; preds = %13, %3
  %18 = phi i1 [ false, %3 ], [ %16, %13 ], !dbg !7544
  br i1 %18, label %19, label %28, !dbg !7545

19:                                               ; preds = %17
  %20 = load i64, i64* %5, align 8, !dbg !7546
  %21 = icmp slt i64 %20, 0, !dbg !7549
  br i1 %21, label %22, label %26, !dbg !7550

22:                                               ; preds = %19
  %23 = load i64, i64* %5, align 8, !dbg !7551
  %24 = load i64, i64* %6, align 8, !dbg !7553
  %25 = add nsw i64 %23, %24, !dbg !7554
  store i64 %25, i64* %4, align 8, !dbg !7555
  br label %36, !dbg !7555

26:                                               ; preds = %19
  %27 = load i64, i64* %5, align 8, !dbg !7556
  store i64 %27, i64* %4, align 8, !dbg !7557
  br label %36, !dbg !7557

28:                                               ; preds = %17
  %29 = call nonnull align 8 dereferenceable(8) i64* @_ZSt4moveIRlEONSt16remove_referenceIT_E4typeEOS2_(i64* nonnull align 8 dereferenceable(8) %5) #3, !dbg !7558
  %30 = load i64, i64* %29, align 8, !dbg !7558
  %31 = call nonnull align 8 dereferenceable(8) i64* @_ZSt4moveIRlEONSt16remove_referenceIT_E4typeEOS2_(i64* nonnull align 8 dereferenceable(8) %6) #3, !dbg !7559
  %32 = load i64, i64* %31, align 8, !dbg !7559
  %33 = load i8, i8* %7, align 1, !dbg !7560
  %34 = trunc i8 %33 to i1, !dbg !7560
  %35 = call i64 @_ZN3c106detail19maybe_wrap_dim_slowIlEET_S2_S2_b(i64 %30, i64 %32, i1 zeroext %34), !dbg !7561
  store i64 %35, i64* %4, align 8, !dbg !7562
  br label %36, !dbg !7562

36:                                               ; preds = %28, %26, %22
  %37 = load i64, i64* %4, align 8, !dbg !7563
  ret i64 %37, !dbg !7563
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) i64* @_ZSt4moveIRlEONSt16remove_referenceIT_E4typeEOS2_(i64* nonnull align 8 dereferenceable(8) %0) #8 comdat !dbg !7564 {
  %2 = alloca i64*, align 8
  store i64* %0, i64** %2, align 8
  call void @llvm.dbg.declare(metadata i64** %2, metadata !7574, metadata !DIExpression()), !dbg !7575
  %3 = load i64*, i64** %2, align 8, !dbg !7576
  ret i64* %3, !dbg !7577
}

declare dso_local i64 @_ZN3c106detail19maybe_wrap_dim_slowIlEET_S2_S2_b(i64, i64, i1 zeroext) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c104impl15SizesAndStrides4sizeEv(%"class.c10::impl::SizesAndStrides"* nonnull align 8 dereferenceable(88) %0) #8 comdat align 2 !dbg !7578 {
  %2 = alloca %"class.c10::impl::SizesAndStrides"*, align 8
  store %"class.c10::impl::SizesAndStrides"* %0, %"class.c10::impl::SizesAndStrides"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::impl::SizesAndStrides"** %2, metadata !7582, metadata !DIExpression()), !dbg !7583
  %3 = load %"class.c10::impl::SizesAndStrides"*, %"class.c10::impl::SizesAndStrides"** %2, align 8
  %4 = getelementptr inbounds %"class.c10::impl::SizesAndStrides", %"class.c10::impl::SizesAndStrides"* %3, i32 0, i32 0, !dbg !7584
  %5 = load i64, i64* %4, align 8, !dbg !7584
  ret i64 %5, !dbg !7585
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local i64 @_ZNK3c1010TensorImpl5numelEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #7 comdat align 2 !dbg !7586 {
  %2 = alloca i64, align 8
  %3 = alloca %"struct.c10::TensorImpl"*, align 8
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %3, align 8
  call void @llvm.dbg.declare(metadata %"struct.c10::TensorImpl"** %3, metadata !7588, metadata !DIExpression()), !dbg !7589
  %4 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %3, align 8
  %5 = call zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4, i8 zeroext 2), !dbg !7590
  br i1 %5, label %6, label %12, !dbg !7592

6:                                                ; preds = %1
  %7 = bitcast %"struct.c10::TensorImpl"* %4 to i64 (%"struct.c10::TensorImpl"*)***, !dbg !7593
  %8 = load i64 (%"struct.c10::TensorImpl"*)**, i64 (%"struct.c10::TensorImpl"*)*** %7, align 8, !dbg !7593
  %9 = getelementptr inbounds i64 (%"struct.c10::TensorImpl"*)*, i64 (%"struct.c10::TensorImpl"*)** %8, i64 10, !dbg !7593
  %10 = load i64 (%"struct.c10::TensorImpl"*)*, i64 (%"struct.c10::TensorImpl"*)** %9, align 8, !dbg !7593
  %11 = call i64 %10(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %4), !dbg !7593
  store i64 %11, i64* %2, align 8, !dbg !7595
  br label %15, !dbg !7595

12:                                               ; preds = %1
  %13 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %4, i32 0, i32 8, !dbg !7596
  %14 = load i64, i64* %13, align 8, !dbg !7596
  store i64 %14, i64* %2, align 8, !dbg !7597
  br label %15, !dbg !7597

15:                                               ; preds = %12, %6
  %16 = load i64, i64* %2, align 8, !dbg !7598
  ret i64 %16, !dbg !7598
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1010TensorImpl13is_contiguousENS_12MemoryFormatE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0, i8 signext %1) #7 comdat align 2 !dbg !7599 {
  %3 = alloca i1, align 1
  %4 = alloca %"struct.c10::TensorImpl"*, align 8
  %5 = alloca i8, align 1
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %4, align 8
  call void @llvm.dbg.declare(metadata %"struct.c10::TensorImpl"** %4, metadata !7603, metadata !DIExpression()), !dbg !7604
  store i8 %1, i8* %5, align 1
  call void @llvm.dbg.declare(metadata i8* %5, metadata !7605, metadata !DIExpression()), !dbg !7606
  %6 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %4, align 8
  %7 = call zeroext i1 @_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6, i8 zeroext 1), !dbg !7607
  br i1 %7, label %8, label %15, !dbg !7609

8:                                                ; preds = %2
  %9 = load i8, i8* %5, align 1, !dbg !7610
  %10 = bitcast %"struct.c10::TensorImpl"* %6 to i1 (%"struct.c10::TensorImpl"*, i8)***, !dbg !7612
  %11 = load i1 (%"struct.c10::TensorImpl"*, i8)**, i1 (%"struct.c10::TensorImpl"*, i8)*** %10, align 8, !dbg !7612
  %12 = getelementptr inbounds i1 (%"struct.c10::TensorImpl"*, i8)*, i1 (%"struct.c10::TensorImpl"*, i8)** %11, i64 3, !dbg !7612
  %13 = load i1 (%"struct.c10::TensorImpl"*, i8)*, i1 (%"struct.c10::TensorImpl"*, i8)** %12, align 8, !dbg !7612
  %14 = call zeroext i1 %13(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6, i8 signext %9), !dbg !7612
  store i1 %14, i1* %3, align 1, !dbg !7613
  br label %18, !dbg !7613

15:                                               ; preds = %2
  %16 = load i8, i8* %5, align 1, !dbg !7614
  %17 = call zeroext i1 @_ZNK3c1010TensorImpl21is_contiguous_defaultENS_12MemoryFormatE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6, i8 signext %16), !dbg !7615
  store i1 %17, i1* %3, align 1, !dbg !7616
  br label %18, !dbg !7616

18:                                               ; preds = %15, %8
  %19 = load i1, i1* %3, align 1, !dbg !7617
  ret i1 %19, !dbg !7617
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1010TensorImpl21is_contiguous_defaultENS_12MemoryFormatE(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0, i8 signext %1) #7 comdat align 2 !dbg !7618 {
  %3 = alloca i1, align 1
  %4 = alloca %"struct.c10::TensorImpl"*, align 8
  %5 = alloca i8, align 1
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %4, align 8
  call void @llvm.dbg.declare(metadata %"struct.c10::TensorImpl"** %4, metadata !7620, metadata !DIExpression()), !dbg !7621
  store i8 %1, i8* %5, align 1
  call void @llvm.dbg.declare(metadata i8* %5, metadata !7622, metadata !DIExpression()), !dbg !7623
  %6 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %4, align 8
  %7 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %6, i32 0, i32 11, !dbg !7624
  %8 = bitcast [3 x i8]* %7 to i24*, !dbg !7624
  %9 = load i24, i24* %8, align 1, !dbg !7624
  %10 = lshr i24 %9, 12, !dbg !7624
  %11 = and i24 %10, 1, !dbg !7624
  %12 = trunc i24 %11 to i1, !dbg !7624
  br i1 %12, label %13, label %32, !dbg !7626

13:                                               ; preds = %2
  %14 = load i8, i8* %5, align 1, !dbg !7627
  %15 = icmp eq i8 %14, 2, !dbg !7630
  br i1 %15, label %16, label %20, !dbg !7631

16:                                               ; preds = %13
  %17 = call nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNK3c1010TensorImpl19symbolic_shape_metaEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6), !dbg !7632
  %18 = call nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta27is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %17), !dbg !7634
  %19 = call zeroext i1 @_ZNK3c107SymBool10guard_boolEPKcl(%"class.c10::SymBool"* nonnull align 8 dereferenceable(16) %18, i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.4, i64 0, i64 0), i64 836), !dbg !7635
  store i1 %19, i1* %3, align 1, !dbg !7636
  br label %59, !dbg !7636

20:                                               ; preds = %13
  %21 = load i8, i8* %5, align 1, !dbg !7637
  %22 = icmp eq i8 %21, 3, !dbg !7639
  br i1 %22, label %23, label %27, !dbg !7640

23:                                               ; preds = %20
  %24 = call nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNK3c1010TensorImpl19symbolic_shape_metaEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6), !dbg !7641
  %25 = call nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta30is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %24), !dbg !7643
  %26 = call zeroext i1 @_ZNK3c107SymBool10guard_boolEPKcl(%"class.c10::SymBool"* nonnull align 8 dereferenceable(16) %25, i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.4, i64 0, i64 0), i64 840), !dbg !7644
  store i1 %26, i1* %3, align 1, !dbg !7645
  br label %59, !dbg !7645

27:                                               ; preds = %20
  br label %28

28:                                               ; preds = %27
  %29 = call nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNK3c1010TensorImpl19symbolic_shape_metaEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %6), !dbg !7646
  %30 = call nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta13is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %29), !dbg !7647
  %31 = call zeroext i1 @_ZNK3c107SymBool10guard_boolEPKcl(%"class.c10::SymBool"* nonnull align 8 dereferenceable(16) %30, i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.4, i64 0, i64 0), i64 843), !dbg !7648
  store i1 %31, i1* %3, align 1, !dbg !7649
  br label %59, !dbg !7649

32:                                               ; preds = %2
  %33 = load i8, i8* %5, align 1, !dbg !7650
  %34 = icmp eq i8 %33, 2, !dbg !7652
  br i1 %34, label %35, label %42, !dbg !7653

35:                                               ; preds = %32
  %36 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %6, i32 0, i32 11, !dbg !7654
  %37 = bitcast [3 x i8]* %36 to i24*, !dbg !7654
  %38 = load i24, i24* %37, align 1, !dbg !7654
  %39 = lshr i24 %38, 3, !dbg !7654
  %40 = and i24 %39, 1, !dbg !7654
  %41 = trunc i24 %40 to i1, !dbg !7654
  store i1 %41, i1* %3, align 1, !dbg !7656
  br label %59, !dbg !7656

42:                                               ; preds = %32
  %43 = load i8, i8* %5, align 1, !dbg !7657
  %44 = icmp eq i8 %43, 3, !dbg !7659
  br i1 %44, label %45, label %52, !dbg !7660

45:                                               ; preds = %42
  %46 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %6, i32 0, i32 11, !dbg !7661
  %47 = bitcast [3 x i8]* %46 to i24*, !dbg !7661
  %48 = load i24, i24* %47, align 1, !dbg !7661
  %49 = lshr i24 %48, 5, !dbg !7661
  %50 = and i24 %49, 1, !dbg !7661
  %51 = trunc i24 %50 to i1, !dbg !7661
  store i1 %51, i1* %3, align 1, !dbg !7663
  br label %59, !dbg !7663

52:                                               ; preds = %42
  br label %53

53:                                               ; preds = %52
  %54 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %6, i32 0, i32 11, !dbg !7664
  %55 = bitcast [3 x i8]* %54 to i24*, !dbg !7664
  %56 = load i24, i24* %55, align 1, !dbg !7664
  %57 = and i24 %56, 1, !dbg !7664
  %58 = trunc i24 %57 to i1, !dbg !7664
  store i1 %58, i1* %3, align 1, !dbg !7665
  br label %59, !dbg !7665

59:                                               ; preds = %53, %45, %35, %28, %23, %16
  %60 = load i1, i1* %3, align 1, !dbg !7666
  ret i1 %60, !dbg !7666
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNK3c1010TensorImpl19symbolic_shape_metaEv(%"struct.c10::TensorImpl"* nonnull align 8 dereferenceable(184) %0) #7 comdat align 2 !dbg !7667 {
  %2 = alloca %"struct.c10::TensorImpl"*, align 8
  %3 = alloca %"class.std::ios_base::Init", align 1
  %4 = alloca %"class.std::ios_base::Init", align 1
  store %"struct.c10::TensorImpl"* %0, %"struct.c10::TensorImpl"** %2, align 8
  call void @llvm.dbg.declare(metadata %"struct.c10::TensorImpl"** %2, metadata !7671, metadata !DIExpression()), !dbg !7672
  %5 = load %"struct.c10::TensorImpl"*, %"struct.c10::TensorImpl"** %2, align 8
  %6 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %5, i32 0, i32 3, !dbg !7673
  %7 = call zeroext i1 @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEcvbEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %6) #3, !dbg !7673
  br i1 %7, label %8, label %13, !dbg !7673

8:                                                ; preds = %1
  %9 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %5, i32 0, i32 3, !dbg !7673
  %10 = call %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEptEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %9) #3, !dbg !7673
  %11 = getelementptr inbounds %"struct.c10::ExtraMeta", %"struct.c10::ExtraMeta"* %10, i32 0, i32 0, !dbg !7673
  %12 = call zeroext i1 @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEcvbEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %11) #3, !dbg !7673
  br i1 %12, label %14, label %13, !dbg !7675

13:                                               ; preds = %8, %1
  call void @_ZN3c103strIJEEEDcDpRKT_(), !dbg !7676
  call void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_NS0_22CompileTimeEmptyStringE(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @__func__._ZNK3c1010TensorImpl19symbolic_shape_metaEv, i64 0, i64 0), i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.4, i64 0, i64 0), i32 1733, i8* getelementptr inbounds ([220 x i8], [220 x i8]* @.str.5, i64 0, i64 0)) #16, !dbg !7676
  unreachable, !dbg !7676

14:                                               ; preds = %8
  %15 = getelementptr inbounds %"struct.c10::TensorImpl", %"struct.c10::TensorImpl"* %5, i32 0, i32 3, !dbg !7678
  %16 = call %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEptEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %15) #3, !dbg !7678
  %17 = getelementptr inbounds %"struct.c10::ExtraMeta", %"struct.c10::ExtraMeta"* %16, i32 0, i32 0, !dbg !7679
  %18 = call nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEdeEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %17), !dbg !7680
  ret %"class.c10::SymbolicShapeMeta"* %18, !dbg !7681
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta27is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #7 comdat align 2 !dbg !7682 {
  %2 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::SymbolicShapeMeta"** %2, metadata !7683, metadata !DIExpression()), !dbg !7685
  %3 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %2, align 8
  %4 = call zeroext i1 @_ZNK3c1017SymbolicShapeMeta31has_is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3), !dbg !7686
  %5 = xor i1 %4, true, !dbg !7686
  br i1 %5, label %6, label %7, !dbg !7688

6:                                                ; preds = %1
  call void @_ZNK3c1017SymbolicShapeMeta32init_is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3), !dbg !7689
  br label %7, !dbg !7691

7:                                                ; preds = %6, %1
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %3, i32 0, i32 8, !dbg !7692
  ret %"class.c10::SymBool"* %8, !dbg !7693
}

declare dso_local zeroext i1 @_ZNK3c107SymBool10guard_boolEPKcl(%"class.c10::SymBool"* nonnull align 8 dereferenceable(16), i8*, i64) #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta30is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #7 comdat align 2 !dbg !7694 {
  %2 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::SymbolicShapeMeta"** %2, metadata !7695, metadata !DIExpression()), !dbg !7696
  %3 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %2, align 8
  %4 = call zeroext i1 @_ZNK3c1017SymbolicShapeMeta34has_is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3), !dbg !7697
  %5 = xor i1 %4, true, !dbg !7697
  br i1 %5, label %6, label %7, !dbg !7699

6:                                                ; preds = %1
  call void @_ZNK3c1017SymbolicShapeMeta35init_is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3), !dbg !7700
  br label %7, !dbg !7702

7:                                                ; preds = %6, %1
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %3, i32 0, i32 9, !dbg !7703
  ret %"class.c10::SymBool"* %8, !dbg !7704
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(16) %"class.c10::SymBool"* @_ZNK3c1017SymbolicShapeMeta13is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #7 comdat align 2 !dbg !7705 {
  %2 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::SymbolicShapeMeta"** %2, metadata !7706, metadata !DIExpression()), !dbg !7707
  %3 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %2, align 8
  %4 = call zeroext i1 @_ZNK3c1017SymbolicShapeMeta17has_is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3), !dbg !7708
  %5 = xor i1 %4, true, !dbg !7708
  br i1 %5, label %6, label %7, !dbg !7710

6:                                                ; preds = %1
  call void @_ZNK3c1017SymbolicShapeMeta18init_is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %3), !dbg !7711
  br label %7, !dbg !7713

7:                                                ; preds = %6, %1
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %3, i32 0, i32 7, !dbg !7714
  ret %"class.c10::SymBool"* %8, !dbg !7715
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1017SymbolicShapeMeta17has_is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #8 comdat align 2 personality i32 (...)* @__gxx_personality_v0 !dbg !7716 {
  %2 = alloca %"struct.std::__atomic_base"*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %6, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::SymbolicShapeMeta"** %6, metadata !7717, metadata !DIExpression()), !dbg !7718
  %7 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %6, align 8
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %7, i32 0, i32 4, !dbg !7719
  %9 = bitcast %"struct.std::atomic"* %8 to %"struct.std::__atomic_base"*, !dbg !7719
  store %"struct.std::__atomic_base"* %9, %"struct.std::__atomic_base"** %2, align 8
  call void @llvm.dbg.declare(metadata %"struct.std::__atomic_base"** %2, metadata !7720, metadata !DIExpression()) #3, !dbg !7723
  store i32 5, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !7725, metadata !DIExpression()) #3, !dbg !7726
  %10 = load %"struct.std::__atomic_base"*, %"struct.std::__atomic_base"** %2, align 8
  call void @llvm.dbg.declare(metadata i32* %4, metadata !7727, metadata !DIExpression()) #3, !dbg !7728
  %11 = load i32, i32* %3, align 4, !dbg !7729
  %12 = invoke i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %11, i32 65535)
          to label %13 unwind label %22, !dbg !7730

13:                                               ; preds = %1
  store i32 %12, i32* %4, align 4, !dbg !7728
  %14 = getelementptr inbounds %"struct.std::__atomic_base", %"struct.std::__atomic_base"* %10, i32 0, i32 0, !dbg !7731
  %15 = load i32, i32* %3, align 4, !dbg !7732
  switch i32 %15, label %16 [
    i32 1, label %18
    i32 2, label %18
    i32 5, label %20
  ], !dbg !7733

16:                                               ; preds = %13
  %17 = load atomic i32, i32* %14 monotonic, align 4, !dbg !7733
  store i32 %17, i32* %5, align 4, !dbg !7733
  br label %25, !dbg !7733

18:                                               ; preds = %13, %13
  %19 = load atomic i32, i32* %14 acquire, align 4, !dbg !7733
  store i32 %19, i32* %5, align 4, !dbg !7733
  br label %25, !dbg !7733

20:                                               ; preds = %13
  %21 = load atomic i32, i32* %14 seq_cst, align 4, !dbg !7733
  store i32 %21, i32* %5, align 4, !dbg !7733
  br label %25, !dbg !7733

22:                                               ; preds = %1
  %23 = landingpad { i8*, i32 }
          catch i8* null, !dbg !7730
  %24 = extractvalue { i8*, i32 } %23, 0, !dbg !7730
  call void @__clang_call_terminate(i8* %24) #17, !dbg !7730
  unreachable, !dbg !7730

25:                                               ; preds = %16, %18, %20
  %26 = load i32, i32* %5, align 4, !dbg !7733
  %27 = and i32 %26, 2, !dbg !7734
  %28 = icmp ne i32 %27, 0, !dbg !7719
  ret i1 %28, !dbg !7735
}

declare dso_local void @_ZNK3c1017SymbolicShapeMeta18init_is_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272)) #1

declare dso_local i32 @__gxx_personality_v0(...)

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %0, i32 %1) #8 comdat !dbg !7736 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !7739, metadata !DIExpression()), !dbg !7740
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !7741, metadata !DIExpression()), !dbg !7742
  %5 = load i32, i32* %3, align 4, !dbg !7743
  %6 = load i32, i32* %4, align 4, !dbg !7744
  %7 = and i32 %5, %6, !dbg !7745
  ret i32 %7, !dbg !7746
}

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8* %0) #11 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #3
  call void @_ZSt9terminatev() #17
  unreachable
}

declare dso_local i8* @__cxa_begin_catch(i8*)

declare dso_local void @_ZSt9terminatev()

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1017SymbolicShapeMeta34has_is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #8 comdat align 2 personality i32 (...)* @__gxx_personality_v0 !dbg !7747 {
  %2 = alloca %"struct.std::__atomic_base"*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %6, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::SymbolicShapeMeta"** %6, metadata !7748, metadata !DIExpression()), !dbg !7749
  %7 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %6, align 8
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %7, i32 0, i32 4, !dbg !7750
  %9 = bitcast %"struct.std::atomic"* %8 to %"struct.std::__atomic_base"*, !dbg !7750
  store %"struct.std::__atomic_base"* %9, %"struct.std::__atomic_base"** %2, align 8
  call void @llvm.dbg.declare(metadata %"struct.std::__atomic_base"** %2, metadata !7720, metadata !DIExpression()) #3, !dbg !7751
  store i32 5, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !7725, metadata !DIExpression()) #3, !dbg !7753
  %10 = load %"struct.std::__atomic_base"*, %"struct.std::__atomic_base"** %2, align 8
  call void @llvm.dbg.declare(metadata i32* %4, metadata !7727, metadata !DIExpression()) #3, !dbg !7754
  %11 = load i32, i32* %3, align 4, !dbg !7755
  %12 = invoke i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %11, i32 65535)
          to label %13 unwind label %22, !dbg !7756

13:                                               ; preds = %1
  store i32 %12, i32* %4, align 4, !dbg !7754
  %14 = getelementptr inbounds %"struct.std::__atomic_base", %"struct.std::__atomic_base"* %10, i32 0, i32 0, !dbg !7757
  %15 = load i32, i32* %3, align 4, !dbg !7758
  switch i32 %15, label %16 [
    i32 1, label %18
    i32 2, label %18
    i32 5, label %20
  ], !dbg !7759

16:                                               ; preds = %13
  %17 = load atomic i32, i32* %14 monotonic, align 4, !dbg !7759
  store i32 %17, i32* %5, align 4, !dbg !7759
  br label %25, !dbg !7759

18:                                               ; preds = %13, %13
  %19 = load atomic i32, i32* %14 acquire, align 4, !dbg !7759
  store i32 %19, i32* %5, align 4, !dbg !7759
  br label %25, !dbg !7759

20:                                               ; preds = %13
  %21 = load atomic i32, i32* %14 seq_cst, align 4, !dbg !7759
  store i32 %21, i32* %5, align 4, !dbg !7759
  br label %25, !dbg !7759

22:                                               ; preds = %1
  %23 = landingpad { i8*, i32 }
          catch i8* null, !dbg !7756
  %24 = extractvalue { i8*, i32 } %23, 0, !dbg !7756
  call void @__clang_call_terminate(i8* %24) #17, !dbg !7756
  unreachable, !dbg !7756

25:                                               ; preds = %16, %18, %20
  %26 = load i32, i32* %5, align 4, !dbg !7759
  %27 = and i32 %26, 8, !dbg !7760
  %28 = icmp ne i32 %27, 0, !dbg !7750
  ret i1 %28, !dbg !7761
}

declare dso_local void @_ZNK3c1017SymbolicShapeMeta35init_is_channels_last_3d_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272)) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNK3c1017SymbolicShapeMeta31has_is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272) %0) #8 comdat align 2 personality i32 (...)* @__gxx_personality_v0 !dbg !7762 {
  %2 = alloca %"struct.std::__atomic_base"*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %"class.c10::SymbolicShapeMeta"*, align 8
  store %"class.c10::SymbolicShapeMeta"* %0, %"class.c10::SymbolicShapeMeta"** %6, align 8
  call void @llvm.dbg.declare(metadata %"class.c10::SymbolicShapeMeta"** %6, metadata !7763, metadata !DIExpression()), !dbg !7764
  %7 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %6, align 8
  %8 = getelementptr inbounds %"class.c10::SymbolicShapeMeta", %"class.c10::SymbolicShapeMeta"* %7, i32 0, i32 4, !dbg !7765
  %9 = bitcast %"struct.std::atomic"* %8 to %"struct.std::__atomic_base"*, !dbg !7765
  store %"struct.std::__atomic_base"* %9, %"struct.std::__atomic_base"** %2, align 8
  call void @llvm.dbg.declare(metadata %"struct.std::__atomic_base"** %2, metadata !7720, metadata !DIExpression()) #3, !dbg !7766
  store i32 5, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !7725, metadata !DIExpression()) #3, !dbg !7768
  %10 = load %"struct.std::__atomic_base"*, %"struct.std::__atomic_base"** %2, align 8
  call void @llvm.dbg.declare(metadata i32* %4, metadata !7727, metadata !DIExpression()) #3, !dbg !7769
  %11 = load i32, i32* %3, align 4, !dbg !7770
  %12 = invoke i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 %11, i32 65535)
          to label %13 unwind label %22, !dbg !7771

13:                                               ; preds = %1
  store i32 %12, i32* %4, align 4, !dbg !7769
  %14 = getelementptr inbounds %"struct.std::__atomic_base", %"struct.std::__atomic_base"* %10, i32 0, i32 0, !dbg !7772
  %15 = load i32, i32* %3, align 4, !dbg !7773
  switch i32 %15, label %16 [
    i32 1, label %18
    i32 2, label %18
    i32 5, label %20
  ], !dbg !7774

16:                                               ; preds = %13
  %17 = load atomic i32, i32* %14 monotonic, align 4, !dbg !7774
  store i32 %17, i32* %5, align 4, !dbg !7774
  br label %25, !dbg !7774

18:                                               ; preds = %13, %13
  %19 = load atomic i32, i32* %14 acquire, align 4, !dbg !7774
  store i32 %19, i32* %5, align 4, !dbg !7774
  br label %25, !dbg !7774

20:                                               ; preds = %13
  %21 = load atomic i32, i32* %14 seq_cst, align 4, !dbg !7774
  store i32 %21, i32* %5, align 4, !dbg !7774
  br label %25, !dbg !7774

22:                                               ; preds = %1
  %23 = landingpad { i8*, i32 }
          catch i8* null, !dbg !7771
  %24 = extractvalue { i8*, i32 } %23, 0, !dbg !7771
  call void @__clang_call_terminate(i8* %24) #17, !dbg !7771
  unreachable, !dbg !7771

25:                                               ; preds = %16, %18, %20
  %26 = load i32, i32* %5, align 4, !dbg !7774
  %27 = and i32 %26, 4, !dbg !7775
  %28 = icmp ne i32 %27, 0, !dbg !7765
  ret i1 %28, !dbg !7776
}

declare dso_local void @_ZNK3c1017SymbolicShapeMeta32init_is_channels_last_contiguousEv(%"class.c10::SymbolicShapeMeta"* nonnull align 8 dereferenceable(272)) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEcvbEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7777 {
  %2 = alloca %"class.std::unique_ptr.23"*, align 8
  store %"class.std::unique_ptr.23"* %0, %"class.std::unique_ptr.23"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.std::unique_ptr.23"** %2, metadata !7778, metadata !DIExpression()), !dbg !7780
  %3 = load %"class.std::unique_ptr.23"*, %"class.std::unique_ptr.23"** %2, align 8
  %4 = call %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %3) #3, !dbg !7781
  %5 = icmp eq %"struct.c10::ExtraMeta"* %4, null, !dbg !7782
  %6 = zext i1 %5 to i64, !dbg !7781
  %7 = select i1 %5, i1 false, i1 true, !dbg !7781
  ret i1 %7, !dbg !7783
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEptEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7784 {
  %2 = alloca %"class.std::unique_ptr.23"*, align 8
  store %"class.std::unique_ptr.23"* %0, %"class.std::unique_ptr.23"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.std::unique_ptr.23"** %2, metadata !7785, metadata !DIExpression()), !dbg !7786
  %3 = load %"class.std::unique_ptr.23"*, %"class.std::unique_ptr.23"** %2, align 8
  %4 = call %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %3) #3, !dbg !7787
  ret %"struct.c10::ExtraMeta"* %4, !dbg !7788
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local zeroext i1 @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEcvbEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7789 {
  %2 = alloca %"class.std::unique_ptr.31"*, align 8
  store %"class.std::unique_ptr.31"* %0, %"class.std::unique_ptr.31"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.std::unique_ptr.31"** %2, metadata !7790, metadata !DIExpression()), !dbg !7792
  %3 = load %"class.std::unique_ptr.31"*, %"class.std::unique_ptr.31"** %2, align 8
  %4 = call %"class.c10::SymbolicShapeMeta"* @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %3) #3, !dbg !7793
  %5 = icmp eq %"class.c10::SymbolicShapeMeta"* %4, null, !dbg !7794
  %6 = zext i1 %5 to i64, !dbg !7793
  %7 = select i1 %5, i1 false, i1 true, !dbg !7793
  ret i1 %7, !dbg !7795
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN3c103strIJEEEDcDpRKT_() #7 comdat !dbg !7796 {
  %1 = alloca %"class.std::ios_base::Init", align 1
  call void @_ZN3c106detail12_str_wrapperIJEE4callEv(), !dbg !7812
  ret void, !dbg !7813
}

; Function Attrs: mustprogress noinline noreturn optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_NS0_22CompileTimeEmptyStringE(i8* %0, i8* %1, i32 %2, i8* %3) #12 comdat !dbg !7814 {
  %5 = alloca %"class.std::ios_base::Init", align 1
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i8*, align 8
  store i8* %0, i8** %6, align 8
  call void @llvm.dbg.declare(metadata i8** %6, metadata !7817, metadata !DIExpression()), !dbg !7818
  store i8* %1, i8** %7, align 8
  call void @llvm.dbg.declare(metadata i8** %7, metadata !7819, metadata !DIExpression()), !dbg !7820
  store i32 %2, i32* %8, align 4
  call void @llvm.dbg.declare(metadata i32* %8, metadata !7821, metadata !DIExpression()), !dbg !7822
  store i8* %3, i8** %9, align 8
  call void @llvm.dbg.declare(metadata i8** %9, metadata !7823, metadata !DIExpression()), !dbg !7824
  call void @llvm.dbg.declare(metadata %"class.std::ios_base::Init"* %5, metadata !7825, metadata !DIExpression()), !dbg !7826
  %10 = load i8*, i8** %6, align 8, !dbg !7827
  %11 = load i8*, i8** %7, align 8, !dbg !7828
  %12 = load i32, i32* %8, align 4, !dbg !7829
  %13 = load i8*, i8** %9, align 8, !dbg !7830
  call void @_ZN3c106detail14torchCheckFailEPKcS2_jS2_(i8* %10, i8* %11, i32 %12, i8* %13) #16, !dbg !7831
  unreachable, !dbg !7831
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(272) %"class.c10::SymbolicShapeMeta"* @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEdeEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7832 {
  %2 = alloca %"class.std::unique_ptr.31"*, align 8
  store %"class.std::unique_ptr.31"* %0, %"class.std::unique_ptr.31"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.std::unique_ptr.31"** %2, metadata !7833, metadata !DIExpression()), !dbg !7834
  %3 = load %"class.std::unique_ptr.31"*, %"class.std::unique_ptr.31"** %2, align 8
  br label %4, !dbg !7835

4:                                                ; preds = %1
  br label %5, !dbg !7836

5:                                                ; preds = %4
  %6 = call %"class.c10::SymbolicShapeMeta"* @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %3) #3, !dbg !7838
  ret %"class.c10::SymbolicShapeMeta"* %6, !dbg !7839
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"class.c10::SymbolicShapeMeta"* @_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.31"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) !dbg !7840 {
  %2 = alloca %"class.std::unique_ptr.31"*, align 8
  store %"class.std::unique_ptr.31"* %0, %"class.std::unique_ptr.31"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.std::unique_ptr.31"** %2, metadata !7841, metadata !DIExpression()), !dbg !7842
  %3 = load %"class.std::unique_ptr.31"*, %"class.std::unique_ptr.31"** %2, align 8
  %4 = getelementptr inbounds %"class.std::unique_ptr.31", %"class.std::unique_ptr.31"* %3, i32 0, i32 0, !dbg !7843
  %5 = bitcast %"struct.std::__uniq_ptr_data.32"* %4 to %"class.std::__uniq_ptr_impl.33"*, !dbg !7843
  %6 = invoke %"class.c10::SymbolicShapeMeta"* @_ZNKSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.33"* nonnull align 8 dereferenceable(8) %5)
          to label %7 unwind label %8, !dbg !7844

7:                                                ; preds = %1
  ret %"class.c10::SymbolicShapeMeta"* %6, !dbg !7845

8:                                                ; preds = %1
  %9 = landingpad { i8*, i32 }
          catch i8* null, !dbg !7844
  %10 = extractvalue { i8*, i32 } %9, 0, !dbg !7844
  call void @__clang_call_terminate(i8* %10) #17, !dbg !7844
  unreachable, !dbg !7844
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"class.c10::SymbolicShapeMeta"* @_ZNKSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.33"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7846 {
  %2 = alloca %"class.std::__uniq_ptr_impl.33"*, align 8
  store %"class.std::__uniq_ptr_impl.33"* %0, %"class.std::__uniq_ptr_impl.33"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.std::__uniq_ptr_impl.33"** %2, metadata !7847, metadata !DIExpression()), !dbg !7849
  %3 = load %"class.std::__uniq_ptr_impl.33"*, %"class.std::__uniq_ptr_impl.33"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__uniq_ptr_impl.33", %"class.std::__uniq_ptr_impl.33"* %3, i32 0, i32 0, !dbg !7850
  %5 = call nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZSt3getILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_(%"class.std::tuple.34"* nonnull align 8 dereferenceable(8) %4) #3, !dbg !7851
  %6 = load %"class.c10::SymbolicShapeMeta"*, %"class.c10::SymbolicShapeMeta"** %5, align 8, !dbg !7851
  ret %"class.c10::SymbolicShapeMeta"* %6, !dbg !7852
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZSt3getILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_(%"class.std::tuple.34"* nonnull align 8 dereferenceable(8) %0) #8 comdat !dbg !7853 {
  %2 = alloca %"class.std::tuple.34"*, align 8
  store %"class.std::tuple.34"* %0, %"class.std::tuple.34"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.std::tuple.34"** %2, metadata !7867, metadata !DIExpression()), !dbg !7868
  %3 = load %"class.std::tuple.34"*, %"class.std::tuple.34"** %2, align 8, !dbg !7869
  %4 = bitcast %"class.std::tuple.34"* %3 to %"struct.std::_Tuple_impl.35"*, !dbg !7869
  %5 = call nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZSt12__get_helperILm0EPN3c1017SymbolicShapeMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.35"* nonnull align 8 dereferenceable(8) %4) #3, !dbg !7870
  ret %"class.c10::SymbolicShapeMeta"** %5, !dbg !7871
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZSt12__get_helperILm0EPN3c1017SymbolicShapeMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.35"* nonnull align 8 dereferenceable(8) %0) #8 comdat !dbg !7872 {
  %2 = alloca %"struct.std::_Tuple_impl.35"*, align 8
  store %"struct.std::_Tuple_impl.35"* %0, %"struct.std::_Tuple_impl.35"** %2, align 8
  call void @llvm.dbg.declare(metadata %"struct.std::_Tuple_impl.35"** %2, metadata !7875, metadata !DIExpression()), !dbg !7876
  %3 = load %"struct.std::_Tuple_impl.35"*, %"struct.std::_Tuple_impl.35"** %2, align 8, !dbg !7877
  %4 = call nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_headERKS5_(%"struct.std::_Tuple_impl.35"* nonnull align 8 dereferenceable(8) %3) #3, !dbg !7878
  ret %"class.c10::SymbolicShapeMeta"** %4, !dbg !7879
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_headERKS5_(%"struct.std::_Tuple_impl.35"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7880 {
  %2 = alloca %"struct.std::_Tuple_impl.35"*, align 8
  store %"struct.std::_Tuple_impl.35"* %0, %"struct.std::_Tuple_impl.35"** %2, align 8
  call void @llvm.dbg.declare(metadata %"struct.std::_Tuple_impl.35"** %2, metadata !7881, metadata !DIExpression()), !dbg !7882
  %3 = load %"struct.std::_Tuple_impl.35"*, %"struct.std::_Tuple_impl.35"** %2, align 8, !dbg !7883
  %4 = bitcast %"struct.std::_Tuple_impl.35"* %3 to %"struct.std::_Head_base.38"*, !dbg !7883
  %5 = call nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZNSt10_Head_baseILm0EPN3c1017SymbolicShapeMetaELb0EE7_M_headERKS3_(%"struct.std::_Head_base.38"* nonnull align 8 dereferenceable(8) %4) #3, !dbg !7884
  ret %"class.c10::SymbolicShapeMeta"** %5, !dbg !7885
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"class.c10::SymbolicShapeMeta"** @_ZNSt10_Head_baseILm0EPN3c1017SymbolicShapeMetaELb0EE7_M_headERKS3_(%"struct.std::_Head_base.38"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7886 {
  %2 = alloca %"struct.std::_Head_base.38"*, align 8
  store %"struct.std::_Head_base.38"* %0, %"struct.std::_Head_base.38"** %2, align 8
  call void @llvm.dbg.declare(metadata %"struct.std::_Head_base.38"** %2, metadata !7887, metadata !DIExpression()), !dbg !7888
  %3 = load %"struct.std::_Head_base.38"*, %"struct.std::_Head_base.38"** %2, align 8, !dbg !7889
  %4 = getelementptr inbounds %"struct.std::_Head_base.38", %"struct.std::_Head_base.38"* %3, i32 0, i32 0, !dbg !7890
  ret %"class.c10::SymbolicShapeMeta"** %4, !dbg !7891
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN3c106detail12_str_wrapperIJEE4callEv() #8 comdat align 2 !dbg !7892 {
  ret void, !dbg !7896
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::ExtraMeta"* @_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.23"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) !dbg !7897 {
  %2 = alloca %"class.std::unique_ptr.23"*, align 8
  store %"class.std::unique_ptr.23"* %0, %"class.std::unique_ptr.23"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.std::unique_ptr.23"** %2, metadata !7898, metadata !DIExpression()), !dbg !7899
  %3 = load %"class.std::unique_ptr.23"*, %"class.std::unique_ptr.23"** %2, align 8
  %4 = getelementptr inbounds %"class.std::unique_ptr.23", %"class.std::unique_ptr.23"* %3, i32 0, i32 0, !dbg !7900
  %5 = bitcast %"struct.std::__uniq_ptr_data.24"* %4 to %"class.std::__uniq_ptr_impl.25"*, !dbg !7900
  %6 = invoke %"struct.c10::ExtraMeta"* @_ZNKSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.25"* nonnull align 8 dereferenceable(8) %5)
          to label %7 unwind label %8, !dbg !7901

7:                                                ; preds = %1
  ret %"struct.c10::ExtraMeta"* %6, !dbg !7902

8:                                                ; preds = %1
  %9 = landingpad { i8*, i32 }
          catch i8* null, !dbg !7901
  %10 = extractvalue { i8*, i32 } %9, 0, !dbg !7901
  call void @__clang_call_terminate(i8* %10) #17, !dbg !7901
  unreachable, !dbg !7901
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local %"struct.c10::ExtraMeta"* @_ZNKSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.25"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7903 {
  %2 = alloca %"class.std::__uniq_ptr_impl.25"*, align 8
  store %"class.std::__uniq_ptr_impl.25"* %0, %"class.std::__uniq_ptr_impl.25"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.std::__uniq_ptr_impl.25"** %2, metadata !7904, metadata !DIExpression()), !dbg !7906
  %3 = load %"class.std::__uniq_ptr_impl.25"*, %"class.std::__uniq_ptr_impl.25"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__uniq_ptr_impl.25", %"class.std::__uniq_ptr_impl.25"* %3, i32 0, i32 0, !dbg !7907
  %5 = call nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZSt3getILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_(%"class.std::tuple.26"* nonnull align 8 dereferenceable(8) %4) #3, !dbg !7908
  %6 = load %"struct.c10::ExtraMeta"*, %"struct.c10::ExtraMeta"** %5, align 8, !dbg !7908
  ret %"struct.c10::ExtraMeta"* %6, !dbg !7909
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZSt3getILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_(%"class.std::tuple.26"* nonnull align 8 dereferenceable(8) %0) #8 comdat !dbg !7910 {
  %2 = alloca %"class.std::tuple.26"*, align 8
  store %"class.std::tuple.26"* %0, %"class.std::tuple.26"** %2, align 8
  call void @llvm.dbg.declare(metadata %"class.std::tuple.26"** %2, metadata !7921, metadata !DIExpression()), !dbg !7922
  %3 = load %"class.std::tuple.26"*, %"class.std::tuple.26"** %2, align 8, !dbg !7923
  %4 = bitcast %"class.std::tuple.26"* %3 to %"struct.std::_Tuple_impl.27"*, !dbg !7923
  %5 = call nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZSt12__get_helperILm0EPN3c109ExtraMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.27"* nonnull align 8 dereferenceable(8) %4) #3, !dbg !7924
  ret %"struct.c10::ExtraMeta"** %5, !dbg !7925
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZSt12__get_helperILm0EPN3c109ExtraMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.27"* nonnull align 8 dereferenceable(8) %0) #8 comdat !dbg !7926 {
  %2 = alloca %"struct.std::_Tuple_impl.27"*, align 8
  store %"struct.std::_Tuple_impl.27"* %0, %"struct.std::_Tuple_impl.27"** %2, align 8
  call void @llvm.dbg.declare(metadata %"struct.std::_Tuple_impl.27"** %2, metadata !7929, metadata !DIExpression()), !dbg !7930
  %3 = load %"struct.std::_Tuple_impl.27"*, %"struct.std::_Tuple_impl.27"** %2, align 8, !dbg !7931
  %4 = call nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_headERKS5_(%"struct.std::_Tuple_impl.27"* nonnull align 8 dereferenceable(8) %3) #3, !dbg !7932
  ret %"struct.c10::ExtraMeta"** %4, !dbg !7933
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_headERKS5_(%"struct.std::_Tuple_impl.27"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7934 {
  %2 = alloca %"struct.std::_Tuple_impl.27"*, align 8
  store %"struct.std::_Tuple_impl.27"* %0, %"struct.std::_Tuple_impl.27"** %2, align 8
  call void @llvm.dbg.declare(metadata %"struct.std::_Tuple_impl.27"** %2, metadata !7935, metadata !DIExpression()), !dbg !7936
  %3 = load %"struct.std::_Tuple_impl.27"*, %"struct.std::_Tuple_impl.27"** %2, align 8, !dbg !7937
  %4 = bitcast %"struct.std::_Tuple_impl.27"* %3 to %"struct.std::_Head_base.30"*, !dbg !7937
  %5 = call nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZNSt10_Head_baseILm0EPN3c109ExtraMetaELb0EE7_M_headERKS3_(%"struct.std::_Head_base.30"* nonnull align 8 dereferenceable(8) %4) #3, !dbg !7938
  ret %"struct.c10::ExtraMeta"** %5, !dbg !7939
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local nonnull align 8 dereferenceable(8) %"struct.c10::ExtraMeta"** @_ZNSt10_Head_baseILm0EPN3c109ExtraMetaELb0EE7_M_headERKS3_(%"struct.std::_Head_base.30"* nonnull align 8 dereferenceable(8) %0) #8 comdat align 2 !dbg !7940 {
  %2 = alloca %"struct.std::_Head_base.30"*, align 8
  store %"struct.std::_Head_base.30"* %0, %"struct.std::_Head_base.30"** %2, align 8
  call void @llvm.dbg.declare(metadata %"struct.std::_Head_base.30"** %2, metadata !7941, metadata !DIExpression()), !dbg !7942
  %3 = load %"struct.std::_Head_base.30"*, %"struct.std::_Head_base.30"** %2, align 8, !dbg !7943
  %4 = getelementptr inbounds %"struct.std::_Head_base.30", %"struct.std::_Head_base.30"* %3, i32 0, i32 0, !dbg !7944
  ret %"struct.c10::ExtraMeta"** %4, !dbg !7945
}

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define dso_local void @_Z37static_scaled_int8_quant_kernel_buggyPKfPaS0_i(float* noalias %0, i8* noalias %1, float* noalias %2, i32 %3) #13 !dbg !7946 {
  %5 = alloca float*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca float*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca float, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca float, align 4
  store float* %0, float** %5, align 8
  call void @llvm.dbg.declare(metadata float** %5, metadata !7947, metadata !DIExpression()), !dbg !7948
  store i8* %1, i8** %6, align 8
  call void @llvm.dbg.declare(metadata i8** %6, metadata !7949, metadata !DIExpression()), !dbg !7950
  store float* %2, float** %7, align 8
  call void @llvm.dbg.declare(metadata float** %7, metadata !7951, metadata !DIExpression()), !dbg !7952
  store i32 %3, i32* %8, align 4
  call void @llvm.dbg.declare(metadata i32* %8, metadata !7953, metadata !DIExpression()), !dbg !7954
  call void @llvm.dbg.declare(metadata i32* %9, metadata !7955, metadata !DIExpression()), !dbg !7956
  %15 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3, !dbg !7957
  store i32 %15, i32* %9, align 4, !dbg !7956
  call void @llvm.dbg.declare(metadata i32* %10, metadata !7960, metadata !DIExpression()), !dbg !7961
  %16 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3, !dbg !7962
  store i32 %16, i32* %10, align 4, !dbg !7961
  call void @llvm.dbg.declare(metadata float* %11, metadata !7965, metadata !DIExpression()), !dbg !7966
  %17 = load float*, float** %7, align 8, !dbg !7967
  %18 = load float, float* %17, align 4, !dbg !7968
  store float %18, float* %11, align 4, !dbg !7966
  %19 = load i32, i32* %10, align 4, !dbg !7969
  %20 = load i32, i32* %8, align 4, !dbg !7970
  %21 = mul nsw i32 %19, %20, !dbg !7971
  %22 = load i8*, i8** %6, align 8, !dbg !7972
  %23 = sext i32 %21 to i64, !dbg !7972
  %24 = getelementptr inbounds i8, i8* %22, i64 %23, !dbg !7972
  store i8* %24, i8** %6, align 8, !dbg !7972
  %25 = load i32, i32* %10, align 4, !dbg !7973
  %26 = load i32, i32* %8, align 4, !dbg !7974
  %27 = mul nsw i32 %25, %26, !dbg !7975
  %28 = load float*, float** %5, align 8, !dbg !7976
  %29 = sext i32 %27 to i64, !dbg !7976
  %30 = getelementptr inbounds float, float* %28, i64 %29, !dbg !7976
  store float* %30, float** %5, align 8, !dbg !7976
  call void @llvm.dbg.declare(metadata i32* %12, metadata !7977, metadata !DIExpression()), !dbg !7979
  %31 = load i32, i32* %9, align 4, !dbg !7980
  store i32 %31, i32* %12, align 4, !dbg !7979
  br label %32, !dbg !7981

32:                                               ; preds = %55, %4
  %33 = load i32, i32* %12, align 4, !dbg !7982
  %34 = load i32, i32* %8, align 4, !dbg !7984
  %35 = icmp slt i32 %33, %34, !dbg !7985
  br i1 %35, label %36, label %59, !dbg !7986

36:                                               ; preds = %32
  call void @llvm.dbg.declare(metadata i32* %13, metadata !7987, metadata !DIExpression()), !dbg !7989
  %37 = load i32, i32* %10, align 4, !dbg !7990
  %38 = load i32, i32* %8, align 4, !dbg !7991
  %39 = mul nsw i32 %37, %38, !dbg !7992
  %40 = load i32, i32* %12, align 4, !dbg !7993
  %41 = add nsw i32 %39, %40, !dbg !7994
  store i32 %41, i32* %13, align 4, !dbg !7989
  call void @llvm.dbg.declare(metadata float* %14, metadata !7995, metadata !DIExpression()), !dbg !7996
  %42 = load float*, float** %5, align 8, !dbg !7997
  %43 = load i32, i32* %13, align 4, !dbg !7998
  %44 = sext i32 %43 to i64, !dbg !7997
  %45 = getelementptr inbounds float, float* %42, i64 %44, !dbg !7997
  %46 = load float, float* %45, align 4, !dbg !7997
  %47 = load float, float* %11, align 4, !dbg !7999
  %48 = fdiv contract float %46, %47, !dbg !8000
  store float %48, float* %14, align 4, !dbg !7996
  %49 = load float, float* %14, align 4, !dbg !8001
  %50 = call signext i8 @_Z16float_to_int8_rnf(float %49) #18, !dbg !8002
  %51 = load i8*, i8** %6, align 8, !dbg !8003
  %52 = load i32, i32* %13, align 4, !dbg !8004
  %53 = sext i32 %52 to i64, !dbg !8003
  %54 = getelementptr inbounds i8, i8* %51, i64 %53, !dbg !8003
  store i8 %50, i8* %54, align 1, !dbg !8005
  br label %55, !dbg !8006

55:                                               ; preds = %36
  %56 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #3, !dbg !8007
  %57 = load i32, i32* %12, align 4, !dbg !8010
  %58 = add i32 %57, %56, !dbg !8010
  store i32 %58, i32* %12, align 4, !dbg !8010
  br label %32, !dbg !8011, !llvm.loop !8012

59:                                               ; preds = %32
  ret void, !dbg !8015
}

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #14

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #14

; Function Attrs: convergent noinline nounwind optnone
define linkonce_odr dso_local signext i8 @_Z16float_to_int8_rnf(float %0) #15 comdat !dbg !8016 {
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  %4 = alloca i32, align 4
  store float %0, float* %3, align 4
  call void @llvm.dbg.declare(metadata float* %3, metadata !8019, metadata !DIExpression()), !dbg !8020
  call void @llvm.dbg.declare(metadata i32* %4, metadata !8021, metadata !DIExpression()), !dbg !8022
  %5 = load float, float* %3, align 4, !dbg !8023
  store float %5, float* %2, align 4
  call void @llvm.dbg.declare(metadata float* %2, metadata !8024, metadata !DIExpression()) #3, !dbg !8026
  %6 = load float, float* %2, align 4, !dbg !8028
  %7 = call i32 @llvm.nvvm.f2i.rn(float %6) #3, !dbg !8029
  store i32 %7, i32* %4, align 4, !dbg !8022
  %8 = load i32, i32* %4, align 4, !dbg !8030
  %9 = icmp slt i32 %8, -128, !dbg !8032
  br i1 %9, label %10, label %11, !dbg !8033

10:                                               ; preds = %1
  store i32 -128, i32* %4, align 4, !dbg !8034
  br label %11, !dbg !8035

11:                                               ; preds = %10, %1
  %12 = load i32, i32* %4, align 4, !dbg !8036
  %13 = icmp sgt i32 %12, 127, !dbg !8038
  br i1 %13, label %14, label %15, !dbg !8039

14:                                               ; preds = %11
  store i32 127, i32* %4, align 4, !dbg !8040
  br label %15, !dbg !8041

15:                                               ; preds = %14, %11
  %16 = load i32, i32* %4, align 4, !dbg !8042
  %17 = trunc i32 %16 to i8, !dbg !8042
  ret i8 %17, !dbg !8043
}

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #14

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.f2i.rn(float) #14

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #6 = { argmemonly nofree nounwind willreturn }
attributes #7 = { mustprogress noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { noinline noreturn nounwind }
attributes #12 = { mustprogress noinline noreturn optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #13 = { convergent mustprogress noinline norecurse nounwind optnone "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="sm_80" "target-features"="+ptx72,+sm_80" }
attributes #14 = { nounwind readnone }
attributes #15 = { convergent noinline nounwind optnone "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="sm_80" "target-features"="+ptx72,+sm_80" }
attributes #16 = { noreturn }
attributes #17 = { noreturn nounwind }
attributes #18 = { convergent nounwind }

!llvm.dbg.cu = !{!7, !6904}
!llvm.ident = !{!7229, !7229, !7230}
!llvm.module.flags = !{!7231, !7232, !7233, !7234, !7235, !7236, !7237}
!nvvm.annotations = !{!7238}
!nvvmir.version = !{!7239}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "__ioinit", linkageName: "_ZStL8__ioinit", scope: !2, file: !3, line: 74, type: !4, isLocal: true, isDefinition: true)
!2 = !DINamespace(name: "std", scope: null)
!3 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/iostream", directory: "")
!4 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "Init", scope: !6, file: !5, line: 626, size: 8, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSNSt8ios_base4InitE")
!5 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/ios_base.h", directory: "")
!6 = !DICompositeType(tag: DW_TAG_class_type, name: "ios_base", scope: !2, file: !5, line: 228, size: 1728, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!7 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !8, producer: "Ubuntu clang version 13.0.1-2ubuntu2.2", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !9, retainedTypes: !731, globals: !4726, imports: !4727, splitDebugInlining: false, nameTableKind: None)
!8 = !DIFile(filename: "/home/mvh6224/CUDA-BOSolver/bugstudy-gklee/src2/vllm9391.cu", directory: "/home/mvh6224/CUDA-BOSolver/bugstudy-gklee/src2")
!9 = !{!10, !34, !65, !73, !248, !259, !271, !279, !323, !336, !348, !355, !364, !725}
!10 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "sm_selector", scope: !12, file: !11, line: 88, baseType: !15, size: 64, flags: DIFlagEnumClass, elements: !17, identifier: "_ZTSN2nv6target6detail11sm_selectorE")
!11 = !DIFile(filename: "/usr/local/cuda/include/nv/target", directory: "")
!12 = !DINamespace(name: "detail", scope: !13)
!13 = !DINamespace(name: "target", scope: !14)
!14 = !DINamespace(name: "nv", scope: null)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "base_int_t", scope: !12, file: !11, line: 50, baseType: !16)
!16 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!17 = !{!18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33}
!18 = !DIEnumerator(name: "sm_35", value: 35, isUnsigned: true)
!19 = !DIEnumerator(name: "sm_37", value: 37, isUnsigned: true)
!20 = !DIEnumerator(name: "sm_50", value: 50, isUnsigned: true)
!21 = !DIEnumerator(name: "sm_52", value: 52, isUnsigned: true)
!22 = !DIEnumerator(name: "sm_53", value: 53, isUnsigned: true)
!23 = !DIEnumerator(name: "sm_60", value: 60, isUnsigned: true)
!24 = !DIEnumerator(name: "sm_61", value: 61, isUnsigned: true)
!25 = !DIEnumerator(name: "sm_62", value: 62, isUnsigned: true)
!26 = !DIEnumerator(name: "sm_70", value: 70, isUnsigned: true)
!27 = !DIEnumerator(name: "sm_72", value: 72, isUnsigned: true)
!28 = !DIEnumerator(name: "sm_75", value: 75, isUnsigned: true)
!29 = !DIEnumerator(name: "sm_80", value: 80, isUnsigned: true)
!30 = !DIEnumerator(name: "sm_86", value: 86, isUnsigned: true)
!31 = !DIEnumerator(name: "sm_87", value: 87, isUnsigned: true)
!32 = !DIEnumerator(name: "sm_89", value: 89, isUnsigned: true)
!33 = !DIEnumerator(name: "sm_90", value: 90, isUnsigned: true)
!34 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "DeviceType", scope: !36, file: !35, line: 36, baseType: !37, size: 8, flags: DIFlagEnumClass, elements: !42, identifier: "_ZTSN3c1010DeviceTypeE")
!35 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/DeviceType.h", directory: "/home/mvh6224/CUDA-BOSolver")
!36 = !DINamespace(name: "c10", scope: null)
!37 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !38, line: 24, baseType: !39)
!38 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "")
!39 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !40, line: 37, baseType: !41)
!40 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!41 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!42 = !{!43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !53, !54, !55, !56, !57, !58, !59, !60, !61, !62, !63, !64}
!43 = !DIEnumerator(name: "CPU", value: 0)
!44 = !DIEnumerator(name: "CUDA", value: 1)
!45 = !DIEnumerator(name: "MKLDNN", value: 2)
!46 = !DIEnumerator(name: "OPENGL", value: 3)
!47 = !DIEnumerator(name: "OPENCL", value: 4)
!48 = !DIEnumerator(name: "IDEEP", value: 5)
!49 = !DIEnumerator(name: "HIP", value: 6)
!50 = !DIEnumerator(name: "FPGA", value: 7)
!51 = !DIEnumerator(name: "MAIA", value: 8)
!52 = !DIEnumerator(name: "XLA", value: 9)
!53 = !DIEnumerator(name: "Vulkan", value: 10)
!54 = !DIEnumerator(name: "Metal", value: 11)
!55 = !DIEnumerator(name: "XPU", value: 12)
!56 = !DIEnumerator(name: "MPS", value: 13)
!57 = !DIEnumerator(name: "Meta", value: 14)
!58 = !DIEnumerator(name: "HPU", value: 15)
!59 = !DIEnumerator(name: "VE", value: 16)
!60 = !DIEnumerator(name: "Lazy", value: 17)
!61 = !DIEnumerator(name: "IPU", value: 18)
!62 = !DIEnumerator(name: "MTIA", value: 19)
!63 = !DIEnumerator(name: "PrivateUse1", value: 20)
!64 = !DIEnumerator(name: "COMPILE_TIME_MAX_DEVICE_TYPES", value: 21)
!65 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "_Lock_policy", scope: !67, file: !66, line: 49, baseType: !68, size: 32, elements: !69, identifier: "_ZTSN9__gnu_cxx12_Lock_policyE")
!66 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/ext/concurrence.h", directory: "")
!67 = !DINamespace(name: "__gnu_cxx", scope: null)
!68 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!69 = !{!70, !71, !72}
!70 = !DIEnumerator(name: "_S_single", value: 0, isUnsigned: true)
!71 = !DIEnumerator(name: "_S_mutex", value: 1, isUnsigned: true)
!72 = !DIEnumerator(name: "_S_atomic", value: 2, isUnsigned: true)
!73 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "DispatchKey", scope: !36, file: !74, line: 135, baseType: !75, size: 16, flags: DIFlagEnumClass, elements: !79, identifier: "_ZTSN3c1011DispatchKeyE")
!74 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/DispatchKey.h", directory: "/home/mvh6224/CUDA-BOSolver")
!75 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !76, line: 25, baseType: !77)
!76 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "")
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !40, line: 40, baseType: !78)
!78 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!79 = !{!80, !81, !82, !83, !84, !85, !86, !87, !88, !89, !90, !91, !92, !93, !94, !95, !96, !97, !98, !99, !100, !101, !102, !103, !104, !105, !106, !107, !108, !109, !110, !111, !112, !113, !114, !115, !116, !117, !118, !119, !120, !121, !122, !123, !124, !125, !126, !127, !128, !129, !130, !131, !132, !133, !134, !135, !136, !137, !138, !139, !140, !141, !142, !143, !144, !145, !146, !147, !148, !149, !150, !151, !152, !153, !154, !155, !156, !157, !158, !159, !160, !161, !162, !163, !164, !165, !166, !167, !168, !169, !170, !171, !172, !173, !174, !175, !176, !177, !178, !179, !180, !181, !182, !183, !184, !185, !186, !187, !188, !189, !190, !191, !192, !193, !194, !195, !196, !197, !198, !199, !200, !201, !202, !203, !204, !205, !206, !207, !208, !209, !210, !211, !212, !213, !214, !215, !216, !217, !218, !219, !220, !221, !222, !223, !224, !225, !226, !227, !228, !229, !230, !231, !232, !233, !234, !235, !236, !237, !238, !239, !240, !241, !242, !243, !244, !245, !246, !247}
!80 = !DIEnumerator(name: "Undefined", value: 0, isUnsigned: true)
!81 = !DIEnumerator(name: "CatchAll", value: 0, isUnsigned: true)
!82 = !DIEnumerator(name: "Dense", value: 1, isUnsigned: true)
!83 = !DIEnumerator(name: "FPGA", value: 2, isUnsigned: true)
!84 = !DIEnumerator(name: "MAIA", value: 3, isUnsigned: true)
!85 = !DIEnumerator(name: "Vulkan", value: 4, isUnsigned: true)
!86 = !DIEnumerator(name: "Metal", value: 5, isUnsigned: true)
!87 = !DIEnumerator(name: "Quantized", value: 6, isUnsigned: true)
!88 = !DIEnumerator(name: "CustomRNGKeyId", value: 7, isUnsigned: true)
!89 = !DIEnumerator(name: "MkldnnCPU", value: 8, isUnsigned: true)
!90 = !DIEnumerator(name: "Sparse", value: 9, isUnsigned: true)
!91 = !DIEnumerator(name: "SparseCsr", value: 10, isUnsigned: true)
!92 = !DIEnumerator(name: "NestedTensor", value: 11, isUnsigned: true)
!93 = !DIEnumerator(name: "BackendSelect", value: 12, isUnsigned: true)
!94 = !DIEnumerator(name: "Python", value: 13, isUnsigned: true)
!95 = !DIEnumerator(name: "Fake", value: 14, isUnsigned: true)
!96 = !DIEnumerator(name: "FuncTorchDynamicLayerBackMode", value: 15, isUnsigned: true)
!97 = !DIEnumerator(name: "Functionalize", value: 16, isUnsigned: true)
!98 = !DIEnumerator(name: "Named", value: 17, isUnsigned: true)
!99 = !DIEnumerator(name: "Conjugate", value: 18, isUnsigned: true)
!100 = !DIEnumerator(name: "Negative", value: 19, isUnsigned: true)
!101 = !DIEnumerator(name: "ZeroTensor", value: 20, isUnsigned: true)
!102 = !DIEnumerator(name: "ADInplaceOrView", value: 21, isUnsigned: true)
!103 = !DIEnumerator(name: "AutogradOther", value: 22, isUnsigned: true)
!104 = !DIEnumerator(name: "AutogradFunctionality", value: 23, isUnsigned: true)
!105 = !DIEnumerator(name: "AutogradNestedTensor", value: 24, isUnsigned: true)
!106 = !DIEnumerator(name: "Tracer", value: 25, isUnsigned: true)
!107 = !DIEnumerator(name: "AutocastCPU", value: 26, isUnsigned: true)
!108 = !DIEnumerator(name: "AutocastMTIA", value: 27, isUnsigned: true)
!109 = !DIEnumerator(name: "AutocastXPU", value: 28, isUnsigned: true)
!110 = !DIEnumerator(name: "AutocastIPU", value: 29, isUnsigned: true)
!111 = !DIEnumerator(name: "AutocastHPU", value: 30, isUnsigned: true)
!112 = !DIEnumerator(name: "AutocastXLA", value: 31, isUnsigned: true)
!113 = !DIEnumerator(name: "AutocastMPS", value: 32, isUnsigned: true)
!114 = !DIEnumerator(name: "AutocastCUDA", value: 33, isUnsigned: true)
!115 = !DIEnumerator(name: "AutocastPrivateUse1", value: 34, isUnsigned: true)
!116 = !DIEnumerator(name: "FuncTorchBatched", value: 35, isUnsigned: true)
!117 = !DIEnumerator(name: "BatchedNestedTensor", value: 36, isUnsigned: true)
!118 = !DIEnumerator(name: "FuncTorchVmapMode", value: 37, isUnsigned: true)
!119 = !DIEnumerator(name: "Batched", value: 38, isUnsigned: true)
!120 = !DIEnumerator(name: "VmapMode", value: 39, isUnsigned: true)
!121 = !DIEnumerator(name: "FuncTorchGradWrapper", value: 40, isUnsigned: true)
!122 = !DIEnumerator(name: "DeferredInit", value: 41, isUnsigned: true)
!123 = !DIEnumerator(name: "PythonTLSSnapshot", value: 42, isUnsigned: true)
!124 = !DIEnumerator(name: "FuncTorchDynamicLayerFrontMode", value: 43, isUnsigned: true)
!125 = !DIEnumerator(name: "TESTING_ONLY_GenericWrapper", value: 44, isUnsigned: true)
!126 = !DIEnumerator(name: "TESTING_ONLY_GenericMode", value: 45, isUnsigned: true)
!127 = !DIEnumerator(name: "PreDispatch", value: 46, isUnsigned: true)
!128 = !DIEnumerator(name: "PythonDispatcher", value: 47, isUnsigned: true)
!129 = !DIEnumerator(name: "EndOfFunctionalityKeys", value: 48, isUnsigned: true)
!130 = !DIEnumerator(name: "StartOfDenseBackends", value: 49, isUnsigned: true)
!131 = !DIEnumerator(name: "CPU", value: 50, isUnsigned: true)
!132 = !DIEnumerator(name: "CUDA", value: 51, isUnsigned: true)
!133 = !DIEnumerator(name: "HIP", value: 52, isUnsigned: true)
!134 = !DIEnumerator(name: "XLA", value: 53, isUnsigned: true)
!135 = !DIEnumerator(name: "MPS", value: 54, isUnsigned: true)
!136 = !DIEnumerator(name: "IPU", value: 55, isUnsigned: true)
!137 = !DIEnumerator(name: "XPU", value: 56, isUnsigned: true)
!138 = !DIEnumerator(name: "HPU", value: 57, isUnsigned: true)
!139 = !DIEnumerator(name: "VE", value: 58, isUnsigned: true)
!140 = !DIEnumerator(name: "Lazy", value: 59, isUnsigned: true)
!141 = !DIEnumerator(name: "MTIA", value: 60, isUnsigned: true)
!142 = !DIEnumerator(name: "PrivateUse1", value: 61, isUnsigned: true)
!143 = !DIEnumerator(name: "PrivateUse2", value: 62, isUnsigned: true)
!144 = !DIEnumerator(name: "PrivateUse3", value: 63, isUnsigned: true)
!145 = !DIEnumerator(name: "Meta", value: 64, isUnsigned: true)
!146 = !DIEnumerator(name: "EndOfDenseBackends", value: 64, isUnsigned: true)
!147 = !DIEnumerator(name: "StartOfQuantizedBackends", value: 65, isUnsigned: true)
!148 = !DIEnumerator(name: "QuantizedCPU", value: 66, isUnsigned: true)
!149 = !DIEnumerator(name: "QuantizedCUDA", value: 67, isUnsigned: true)
!150 = !DIEnumerator(name: "QuantizedHIP", value: 68, isUnsigned: true)
!151 = !DIEnumerator(name: "QuantizedXLA", value: 69, isUnsigned: true)
!152 = !DIEnumerator(name: "QuantizedMPS", value: 70, isUnsigned: true)
!153 = !DIEnumerator(name: "QuantizedIPU", value: 71, isUnsigned: true)
!154 = !DIEnumerator(name: "QuantizedXPU", value: 72, isUnsigned: true)
!155 = !DIEnumerator(name: "QuantizedHPU", value: 73, isUnsigned: true)
!156 = !DIEnumerator(name: "QuantizedVE", value: 74, isUnsigned: true)
!157 = !DIEnumerator(name: "QuantizedLazy", value: 75, isUnsigned: true)
!158 = !DIEnumerator(name: "QuantizedMTIA", value: 76, isUnsigned: true)
!159 = !DIEnumerator(name: "QuantizedPrivateUse1", value: 77, isUnsigned: true)
!160 = !DIEnumerator(name: "QuantizedPrivateUse2", value: 78, isUnsigned: true)
!161 = !DIEnumerator(name: "QuantizedPrivateUse3", value: 79, isUnsigned: true)
!162 = !DIEnumerator(name: "QuantizedMeta", value: 80, isUnsigned: true)
!163 = !DIEnumerator(name: "EndOfQuantizedBackends", value: 80, isUnsigned: true)
!164 = !DIEnumerator(name: "StartOfSparseBackends", value: 81, isUnsigned: true)
!165 = !DIEnumerator(name: "SparseCPU", value: 82, isUnsigned: true)
!166 = !DIEnumerator(name: "SparseCUDA", value: 83, isUnsigned: true)
!167 = !DIEnumerator(name: "SparseHIP", value: 84, isUnsigned: true)
!168 = !DIEnumerator(name: "SparseXLA", value: 85, isUnsigned: true)
!169 = !DIEnumerator(name: "SparseMPS", value: 86, isUnsigned: true)
!170 = !DIEnumerator(name: "SparseIPU", value: 87, isUnsigned: true)
!171 = !DIEnumerator(name: "SparseXPU", value: 88, isUnsigned: true)
!172 = !DIEnumerator(name: "SparseHPU", value: 89, isUnsigned: true)
!173 = !DIEnumerator(name: "SparseVE", value: 90, isUnsigned: true)
!174 = !DIEnumerator(name: "SparseLazy", value: 91, isUnsigned: true)
!175 = !DIEnumerator(name: "SparseMTIA", value: 92, isUnsigned: true)
!176 = !DIEnumerator(name: "SparsePrivateUse1", value: 93, isUnsigned: true)
!177 = !DIEnumerator(name: "SparsePrivateUse2", value: 94, isUnsigned: true)
!178 = !DIEnumerator(name: "SparsePrivateUse3", value: 95, isUnsigned: true)
!179 = !DIEnumerator(name: "SparseMeta", value: 96, isUnsigned: true)
!180 = !DIEnumerator(name: "EndOfSparseBackends", value: 96, isUnsigned: true)
!181 = !DIEnumerator(name: "StartOfSparseCsrBackends", value: 97, isUnsigned: true)
!182 = !DIEnumerator(name: "SparseCsrCPU", value: 98, isUnsigned: true)
!183 = !DIEnumerator(name: "SparseCsrCUDA", value: 99, isUnsigned: true)
!184 = !DIEnumerator(name: "SparseCsrHIP", value: 100, isUnsigned: true)
!185 = !DIEnumerator(name: "SparseCsrXLA", value: 101, isUnsigned: true)
!186 = !DIEnumerator(name: "SparseCsrMPS", value: 102, isUnsigned: true)
!187 = !DIEnumerator(name: "SparseCsrIPU", value: 103, isUnsigned: true)
!188 = !DIEnumerator(name: "SparseCsrXPU", value: 104, isUnsigned: true)
!189 = !DIEnumerator(name: "SparseCsrHPU", value: 105, isUnsigned: true)
!190 = !DIEnumerator(name: "SparseCsrVE", value: 106, isUnsigned: true)
!191 = !DIEnumerator(name: "SparseCsrLazy", value: 107, isUnsigned: true)
!192 = !DIEnumerator(name: "SparseCsrMTIA", value: 108, isUnsigned: true)
!193 = !DIEnumerator(name: "SparseCsrPrivateUse1", value: 109, isUnsigned: true)
!194 = !DIEnumerator(name: "SparseCsrPrivateUse2", value: 110, isUnsigned: true)
!195 = !DIEnumerator(name: "SparseCsrPrivateUse3", value: 111, isUnsigned: true)
!196 = !DIEnumerator(name: "SparseCsrMeta", value: 112, isUnsigned: true)
!197 = !DIEnumerator(name: "EndOfSparseCsrBackends", value: 112, isUnsigned: true)
!198 = !DIEnumerator(name: "StartOfNestedTensorBackends", value: 113, isUnsigned: true)
!199 = !DIEnumerator(name: "NestedTensorCPU", value: 114, isUnsigned: true)
!200 = !DIEnumerator(name: "NestedTensorCUDA", value: 115, isUnsigned: true)
!201 = !DIEnumerator(name: "NestedTensorHIP", value: 116, isUnsigned: true)
!202 = !DIEnumerator(name: "NestedTensorXLA", value: 117, isUnsigned: true)
!203 = !DIEnumerator(name: "NestedTensorMPS", value: 118, isUnsigned: true)
!204 = !DIEnumerator(name: "NestedTensorIPU", value: 119, isUnsigned: true)
!205 = !DIEnumerator(name: "NestedTensorXPU", value: 120, isUnsigned: true)
!206 = !DIEnumerator(name: "NestedTensorHPU", value: 121, isUnsigned: true)
!207 = !DIEnumerator(name: "NestedTensorVE", value: 122, isUnsigned: true)
!208 = !DIEnumerator(name: "NestedTensorLazy", value: 123, isUnsigned: true)
!209 = !DIEnumerator(name: "NestedTensorMTIA", value: 124, isUnsigned: true)
!210 = !DIEnumerator(name: "NestedTensorPrivateUse1", value: 125, isUnsigned: true)
!211 = !DIEnumerator(name: "NestedTensorPrivateUse2", value: 126, isUnsigned: true)
!212 = !DIEnumerator(name: "NestedTensorPrivateUse3", value: 127, isUnsigned: true)
!213 = !DIEnumerator(name: "NestedTensorMeta", value: 128, isUnsigned: true)
!214 = !DIEnumerator(name: "EndOfNestedTensorBackends", value: 128, isUnsigned: true)
!215 = !DIEnumerator(name: "StartOfAutogradFunctionalityBackends", value: 129, isUnsigned: true)
!216 = !DIEnumerator(name: "AutogradCPU", value: 130, isUnsigned: true)
!217 = !DIEnumerator(name: "AutogradCUDA", value: 131, isUnsigned: true)
!218 = !DIEnumerator(name: "AutogradHIP", value: 132, isUnsigned: true)
!219 = !DIEnumerator(name: "AutogradXLA", value: 133, isUnsigned: true)
!220 = !DIEnumerator(name: "AutogradMPS", value: 134, isUnsigned: true)
!221 = !DIEnumerator(name: "AutogradIPU", value: 135, isUnsigned: true)
!222 = !DIEnumerator(name: "AutogradXPU", value: 136, isUnsigned: true)
!223 = !DIEnumerator(name: "AutogradHPU", value: 137, isUnsigned: true)
!224 = !DIEnumerator(name: "AutogradVE", value: 138, isUnsigned: true)
!225 = !DIEnumerator(name: "AutogradLazy", value: 139, isUnsigned: true)
!226 = !DIEnumerator(name: "AutogradMTIA", value: 140, isUnsigned: true)
!227 = !DIEnumerator(name: "AutogradPrivateUse1", value: 141, isUnsigned: true)
!228 = !DIEnumerator(name: "AutogradPrivateUse2", value: 142, isUnsigned: true)
!229 = !DIEnumerator(name: "AutogradPrivateUse3", value: 143, isUnsigned: true)
!230 = !DIEnumerator(name: "AutogradMeta", value: 144, isUnsigned: true)
!231 = !DIEnumerator(name: "EndOfAutogradFunctionalityBackends", value: 144, isUnsigned: true)
!232 = !DIEnumerator(name: "EndOfRuntimeBackendKeys", value: 144, isUnsigned: true)
!233 = !DIEnumerator(name: "Autograd", value: 145, isUnsigned: true)
!234 = !DIEnumerator(name: "CompositeImplicitAutograd", value: 146, isUnsigned: true)
!235 = !DIEnumerator(name: "FuncTorchBatchedDecomposition", value: 147, isUnsigned: true)
!236 = !DIEnumerator(name: "CompositeImplicitAutogradNestedTensor", value: 148, isUnsigned: true)
!237 = !DIEnumerator(name: "CompositeExplicitAutograd", value: 149, isUnsigned: true)
!238 = !DIEnumerator(name: "CompositeExplicitAutogradNonFunctional", value: 150, isUnsigned: true)
!239 = !DIEnumerator(name: "StartOfAliasKeys", value: 145, isUnsigned: true)
!240 = !DIEnumerator(name: "EndOfAliasKeys", value: 150, isUnsigned: true)
!241 = !DIEnumerator(name: "CPUTensorId", value: 50, isUnsigned: true)
!242 = !DIEnumerator(name: "CUDATensorId", value: 51, isUnsigned: true)
!243 = !DIEnumerator(name: "DefaultBackend", value: 149, isUnsigned: true)
!244 = !DIEnumerator(name: "PrivateUse1_PreAutograd", value: 141, isUnsigned: true)
!245 = !DIEnumerator(name: "PrivateUse2_PreAutograd", value: 142, isUnsigned: true)
!246 = !DIEnumerator(name: "PrivateUse3_PreAutograd", value: 143, isUnsigned: true)
!247 = !DIEnumerator(name: "Autocast", value: 33, isUnsigned: true)
!248 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "_Construct", scope: !250, file: !249, line: 75, baseType: !256, size: 32, flags: DIFlagEnumClass, elements: !257, identifier: "_ZTSNSt9nullopt_t10_ConstructE")
!249 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/optional", directory: "")
!250 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "nullopt_t", scope: !2, file: !249, line: 68, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !251, identifier: "_ZTSSt9nullopt_t")
!251 = !{!252}
!252 = !DISubprogram(name: "nullopt_t", scope: !250, file: !249, line: 78, type: !253, scopeLine: 78, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!253 = !DISubroutineType(types: !254)
!254 = !{null, !255, !248}
!255 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !250, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!256 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!257 = !{!258}
!258 = !DIEnumerator(name: "_Token", value: 0)
!259 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "QScheme", scope: !36, file: !260, line: 15, baseType: !261, size: 8, flags: DIFlagEnumClass, elements: !264, identifier: "_ZTSN3c107QSchemeE")
!260 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/QScheme.h", directory: "/home/mvh6224/CUDA-BOSolver")
!261 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !76, line: 24, baseType: !262)
!262 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !40, line: 38, baseType: !263)
!263 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!264 = !{!265, !266, !267, !268, !269, !270}
!265 = !DIEnumerator(name: "PER_TENSOR_AFFINE", value: 0, isUnsigned: true)
!266 = !DIEnumerator(name: "PER_CHANNEL_AFFINE", value: 1, isUnsigned: true)
!267 = !DIEnumerator(name: "PER_TENSOR_SYMMETRIC", value: 2, isUnsigned: true)
!268 = !DIEnumerator(name: "PER_CHANNEL_SYMMETRIC", value: 3, isUnsigned: true)
!269 = !DIEnumerator(name: "PER_CHANNEL_AFFINE_FLOAT_QPARAMS", value: 4, isUnsigned: true)
!270 = !DIEnumerator(name: "COMPILE_TIME_NUM_QSCHEMES", value: 5, isUnsigned: true)
!271 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "MemoryFormat", scope: !36, file: !272, line: 29, baseType: !37, size: 8, flags: DIFlagEnumClass, elements: !273, identifier: "_ZTSN3c1012MemoryFormatE")
!272 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/MemoryFormat.h", directory: "/home/mvh6224/CUDA-BOSolver")
!273 = !{!274, !275, !276, !277, !278}
!274 = !DIEnumerator(name: "Contiguous", value: 0)
!275 = !DIEnumerator(name: "Preserve", value: 1)
!276 = !DIEnumerator(name: "ChannelsLast", value: 2)
!277 = !DIEnumerator(name: "ChannelsLast3d", value: 3)
!278 = !DIEnumerator(name: "NumOptions", value: 4)
!279 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "TypeKind", scope: !36, file: !280, line: 64, baseType: !256, size: 32, flags: DIFlagEnumClass, elements: !281, identifier: "_ZTSN3c108TypeKindE")
!280 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/jit_type_base.h", directory: "/home/mvh6224/CUDA-BOSolver")
!281 = !{!282, !283, !284, !285, !286, !287, !288, !289, !290, !291, !292, !293, !294, !295, !296, !297, !298, !299, !300, !301, !302, !303, !304, !305, !306, !307, !308, !309, !310, !311, !312, !313, !314, !315, !316, !317, !318, !319, !320, !321, !322}
!282 = !DIEnumerator(name: "AnyType", value: 0)
!283 = !DIEnumerator(name: "EnumType", value: 1)
!284 = !DIEnumerator(name: "AnyEnumType", value: 2)
!285 = !DIEnumerator(name: "TensorType", value: 3)
!286 = !DIEnumerator(name: "StorageType", value: 4)
!287 = !DIEnumerator(name: "TupleType", value: 5)
!288 = !DIEnumerator(name: "ListType", value: 6)
!289 = !DIEnumerator(name: "DictType", value: 7)
!290 = !DIEnumerator(name: "NumberType", value: 8)
!291 = !DIEnumerator(name: "FloatType", value: 9)
!292 = !DIEnumerator(name: "ComplexType", value: 10)
!293 = !DIEnumerator(name: "FutureType", value: 11)
!294 = !DIEnumerator(name: "AwaitType", value: 12)
!295 = !DIEnumerator(name: "RRefType", value: 13)
!296 = !DIEnumerator(name: "IntType", value: 14)
!297 = !DIEnumerator(name: "NoneType", value: 15)
!298 = !DIEnumerator(name: "StringType", value: 16)
!299 = !DIEnumerator(name: "GeneratorType", value: 17)
!300 = !DIEnumerator(name: "QuantizerType", value: 18)
!301 = !DIEnumerator(name: "BoolType", value: 19)
!302 = !DIEnumerator(name: "OptionalType", value: 20)
!303 = !DIEnumerator(name: "VarType", value: 21)
!304 = !DIEnumerator(name: "DeviceObjType", value: 22)
!305 = !DIEnumerator(name: "StreamObjType", value: 23)
!306 = !DIEnumerator(name: "FunctionType", value: 24)
!307 = !DIEnumerator(name: "ClassType", value: 25)
!308 = !DIEnumerator(name: "PyObjectType", value: 26)
!309 = !DIEnumerator(name: "CapsuleType", value: 27)
!310 = !DIEnumerator(name: "InterfaceType", value: 28)
!311 = !DIEnumerator(name: "QSchemeType", value: 29)
!312 = !DIEnumerator(name: "ScalarTypeType", value: 30)
!313 = !DIEnumerator(name: "LayoutType", value: 31)
!314 = !DIEnumerator(name: "MemoryFormatType", value: 32)
!315 = !DIEnumerator(name: "AnyListType", value: 33)
!316 = !DIEnumerator(name: "AnyTupleType", value: 34)
!317 = !DIEnumerator(name: "AnyClassType", value: 35)
!318 = !DIEnumerator(name: "SymIntType", value: 36)
!319 = !DIEnumerator(name: "SymFloatType", value: 37)
!320 = !DIEnumerator(name: "SymBoolType", value: 38)
!321 = !DIEnumerator(name: "UnionType", value: 39)
!322 = !DIEnumerator(name: "DynamicType", value: 40)
!323 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "ActivityType", scope: !325, file: !324, line: 13, baseType: !256, size: 32, flags: DIFlagEnumClass, elements: !328, identifier: "_ZTSN5torch8profiler4impl12ActivityTypeE")
!324 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/profiler/orchestration/observer.h", directory: "/home/mvh6224/CUDA-BOSolver")
!325 = !DINamespace(name: "impl", scope: !326)
!326 = !DINamespace(name: "profiler", scope: !327)
!327 = !DINamespace(name: "torch", scope: null)
!328 = !{!329, !330, !331, !332, !333, !334, !335}
!329 = !DIEnumerator(name: "CPU", value: 0)
!330 = !DIEnumerator(name: "XPU", value: 1)
!331 = !DIEnumerator(name: "CUDA", value: 2)
!332 = !DIEnumerator(name: "HPU", value: 3)
!333 = !DIEnumerator(name: "MTIA", value: 4)
!334 = !DIEnumerator(name: "PrivateUse1", value: 5)
!335 = !DIEnumerator(name: "NUM_KINETO_ACTIVITIES", value: 6)
!336 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "ProfilerState", scope: !325, file: !324, line: 31, baseType: !256, size: 32, flags: DIFlagEnumClass, elements: !337, identifier: "_ZTSN5torch8profiler4impl13ProfilerStateE")
!337 = !{!338, !339, !331, !340, !341, !342, !343, !344, !345, !346, !347}
!338 = !DIEnumerator(name: "Disabled", value: 0)
!339 = !DIEnumerator(name: "CPU", value: 1)
!340 = !DIEnumerator(name: "NVTX", value: 3)
!341 = !DIEnumerator(name: "ITT", value: 4)
!342 = !DIEnumerator(name: "PRIVATEUSE1", value: 5)
!343 = !DIEnumerator(name: "KINETO", value: 6)
!344 = !DIEnumerator(name: "KINETO_GPU_FALLBACK", value: 7)
!345 = !DIEnumerator(name: "KINETO_PRIVATEUSE1_FALLBACK", value: 8)
!346 = !DIEnumerator(name: "KINETO_ONDEMAND", value: 9)
!347 = !DIEnumerator(name: "NUM_PROFILER_STATES", value: 10)
!348 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "SizesStridesPolicy", scope: !350, file: !349, line: 930, baseType: !261, size: 8, flags: DIFlagEnumClass, elements: !351, identifier: "_ZTSN3c1010TensorImpl18SizesStridesPolicyE")
!349 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/TensorImpl.h", directory: "/home/mvh6224/CUDA-BOSolver")
!350 = !DICompositeType(tag: DW_TAG_structure_type, name: "TensorImpl", scope: !36, file: !349, line: 509, size: 1472, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!351 = !{!352, !353, !354}
!352 = !DIEnumerator(name: "Default", value: 0, isUnsigned: true)
!353 = !DIEnumerator(name: "CustomStrides", value: 1, isUnsigned: true)
!354 = !DIEnumerator(name: "CustomSizes", value: 2, isUnsigned: true)
!355 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "memory_order", scope: !2, file: !356, line: 78, baseType: !68, size: 32, elements: !357, identifier: "_ZTSSt12memory_order")
!356 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/atomic_base.h", directory: "")
!357 = !{!358, !359, !360, !361, !362, !363}
!358 = !DIEnumerator(name: "memory_order_relaxed", value: 0, isUnsigned: true)
!359 = !DIEnumerator(name: "memory_order_consume", value: 1, isUnsigned: true)
!360 = !DIEnumerator(name: "memory_order_acquire", value: 2, isUnsigned: true)
!361 = !DIEnumerator(name: "memory_order_release", value: 3, isUnsigned: true)
!362 = !DIEnumerator(name: "memory_order_acq_rel", value: 4, isUnsigned: true)
!363 = !DIEnumerator(name: "memory_order_seq_cst", value: 5, isUnsigned: true)
!364 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "avail", scope: !366, file: !365, line: 197, baseType: !68, size: 32, elements: !717, identifier: "_ZTSN3c1017SymbolicShapeMeta5availE")
!365 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/SymbolicShapeMeta.h", directory: "/home/mvh6224/CUDA-BOSolver")
!366 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SymbolicShapeMeta", scope: !36, file: !365, line: 15, size: 2176, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !367, identifier: "_ZTSN3c1017SymbolicShapeMetaE")
!367 = !{!368, !373, !374, !377, !379, !534, !613, !614, !617, !618, !619, !620, !621, !622, !626, !627, !632, !636, !640, !643, !644, !645, !651, !654, !655, !656, !657, !658, !659, !660, !665, !670, !671, !672, !673, !674, !675, !678, !679, !680, !681, !682, !683, !686, !687, !688, !689, !690, !691, !692, !693, !694, !695, !696, !697, !700, !701, !702, !703, !704, !705, !706, !709, !712, !713, !714, !715, !716}
!368 = !DIDerivedType(tag: DW_TAG_member, name: "sizes_", scope: !366, file: !365, line: 18, baseType: !369, size: 448, flags: DIFlagPublic)
!369 = !DIDerivedType(tag: DW_TAG_typedef, name: "SymDimVector", scope: !36, file: !370, line: 15, baseType: !371)
!370 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/DimVector.h", directory: "/home/mvh6224/CUDA-BOSolver")
!371 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SmallVector<c10::SymInt, 5>", scope: !36, file: !372, line: 1274, size: 448, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1011SmallVectorINS_6SymIntELj5EEE")
!372 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/SmallVector.h", directory: "/home/mvh6224/CUDA-BOSolver")
!373 = !DIDerivedType(tag: DW_TAG_member, name: "strides_", scope: !366, file: !365, line: 19, baseType: !369, size: 448, offset: 448, flags: DIFlagPublic)
!374 = !DIDerivedType(tag: DW_TAG_member, name: "storage_offset_", scope: !366, file: !365, line: 20, baseType: !375, size: 64, offset: 896, flags: DIFlagPublic)
!375 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SymInt", scope: !36, file: !376, line: 35, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c106SymIntE")
!376 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/SymInt.h", directory: "/home/mvh6224/CUDA-BOSolver")
!377 = !DIDerivedType(tag: DW_TAG_member, name: "strides_valid_", scope: !366, file: !365, line: 22, baseType: !378, size: 8, offset: 960, flags: DIFlagPublic)
!378 = !DIBasicType(name: "bool", size: 8, encoding: DW_ATE_boolean)
!379 = !DIDerivedType(tag: DW_TAG_member, name: "available_", scope: !366, file: !365, line: 196, baseType: !380, size: 32, offset: 992)
!380 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "atomic<int>", scope: !2, file: !381, line: 822, size: 32, flags: DIFlagTypePassByReference, elements: !382, templateParams: !532, identifier: "_ZTSSt6atomicIiE")
!381 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/atomic", directory: "")
!382 = !{!383, !507, !509, !513, !514, !519, !523, !528}
!383 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !380, baseType: !384, extraData: i32 0)
!384 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__atomic_base<int>", scope: !2, file: !356, line: 324, size: 32, flags: DIFlagTypePassByReference, elements: !385, templateParams: !505, identifier: "_ZTSSt13__atomic_baseIiE")
!385 = !{!386, !388, !390, !394, !395, !400, !404, !409, !412, !416, !421, !424, !427, !430, !433, !434, !435, !438, !441, !442, !443, !444, !445, !446, !447, !448, !449, !450, !451, !452, !453, !456, !459, !463, !466, !469, !472, !475, !478, !482, !485, !488, !491, !492, !493, !494, !495, !496, !497, !498, !499, !500, !501, !502, !503, !504}
!386 = !DIDerivedType(tag: DW_TAG_member, name: "_S_alignment", scope: !384, file: !356, line: 332, baseType: !387, flags: DIFlagPrivate | DIFlagStaticMember, extraData: i32 4)
!387 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !256)
!388 = !DIDerivedType(tag: DW_TAG_member, name: "_M_i", scope: !384, file: !356, line: 335, baseType: !389, size: 32, align: 32, flags: DIFlagPrivate)
!389 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_type", scope: !384, file: !356, line: 330, baseType: !256)
!390 = !DISubprogram(name: "__atomic_base", scope: !384, file: !356, line: 338, type: !391, scopeLine: 338, flags: DIFlagPrototyped, spFlags: 0)
!391 = !DISubroutineType(types: !392)
!392 = !{null, !393}
!393 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !384, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!394 = !DISubprogram(name: "~__atomic_base", scope: !384, file: !356, line: 339, type: !391, scopeLine: 339, flags: DIFlagPrototyped, spFlags: 0)
!395 = !DISubprogram(name: "__atomic_base", scope: !384, file: !356, line: 340, type: !396, scopeLine: 340, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!396 = !DISubroutineType(types: !397)
!397 = !{null, !393, !398}
!398 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !399, size: 64)
!399 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !384)
!400 = !DISubprogram(name: "operator=", linkageName: "_ZNSt13__atomic_baseIiEaSERKS0_", scope: !384, file: !356, line: 341, type: !401, scopeLine: 341, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!401 = !DISubroutineType(types: !402)
!402 = !{!403, !393, !398}
!403 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !384, size: 64)
!404 = !DISubprogram(name: "operator=", linkageName: "_ZNVSt13__atomic_baseIiEaSERKS0_", scope: !384, file: !356, line: 342, type: !405, scopeLine: 342, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!405 = !DISubroutineType(types: !406)
!406 = !{!403, !407, !398}
!407 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !408, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!408 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !384)
!409 = !DISubprogram(name: "__atomic_base", scope: !384, file: !356, line: 345, type: !410, scopeLine: 345, flags: DIFlagPrototyped, spFlags: 0)
!410 = !DISubroutineType(types: !411)
!411 = !{null, !393, !389}
!412 = !DISubprogram(name: "operator int", linkageName: "_ZNKSt13__atomic_baseIiEcviEv", scope: !384, file: !356, line: 347, type: !413, scopeLine: 347, flags: DIFlagPrototyped, spFlags: 0)
!413 = !DISubroutineType(types: !414)
!414 = !{!389, !415}
!415 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !399, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!416 = !DISubprogram(name: "operator int", linkageName: "_ZNVKSt13__atomic_baseIiEcviEv", scope: !384, file: !356, line: 350, type: !417, scopeLine: 350, flags: DIFlagPrototyped, spFlags: 0)
!417 = !DISubroutineType(types: !418)
!418 = !{!389, !419}
!419 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !420, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!420 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !408)
!421 = !DISubprogram(name: "operator=", linkageName: "_ZNSt13__atomic_baseIiEaSEi", scope: !384, file: !356, line: 354, type: !422, scopeLine: 354, flags: DIFlagPrototyped, spFlags: 0)
!422 = !DISubroutineType(types: !423)
!423 = !{!389, !393, !389}
!424 = !DISubprogram(name: "operator=", linkageName: "_ZNVSt13__atomic_baseIiEaSEi", scope: !384, file: !356, line: 361, type: !425, scopeLine: 361, flags: DIFlagPrototyped, spFlags: 0)
!425 = !DISubroutineType(types: !426)
!426 = !{!389, !407, !389}
!427 = !DISubprogram(name: "operator++", linkageName: "_ZNSt13__atomic_baseIiEppEi", scope: !384, file: !356, line: 368, type: !428, scopeLine: 368, flags: DIFlagPrototyped, spFlags: 0)
!428 = !DISubroutineType(types: !429)
!429 = !{!389, !393, !256}
!430 = !DISubprogram(name: "operator++", linkageName: "_ZNVSt13__atomic_baseIiEppEi", scope: !384, file: !356, line: 372, type: !431, scopeLine: 372, flags: DIFlagPrototyped, spFlags: 0)
!431 = !DISubroutineType(types: !432)
!432 = !{!389, !407, !256}
!433 = !DISubprogram(name: "operator--", linkageName: "_ZNSt13__atomic_baseIiEmmEi", scope: !384, file: !356, line: 376, type: !428, scopeLine: 376, flags: DIFlagPrototyped, spFlags: 0)
!434 = !DISubprogram(name: "operator--", linkageName: "_ZNVSt13__atomic_baseIiEmmEi", scope: !384, file: !356, line: 380, type: !431, scopeLine: 380, flags: DIFlagPrototyped, spFlags: 0)
!435 = !DISubprogram(name: "operator++", linkageName: "_ZNSt13__atomic_baseIiEppEv", scope: !384, file: !356, line: 384, type: !436, scopeLine: 384, flags: DIFlagPrototyped, spFlags: 0)
!436 = !DISubroutineType(types: !437)
!437 = !{!389, !393}
!438 = !DISubprogram(name: "operator++", linkageName: "_ZNVSt13__atomic_baseIiEppEv", scope: !384, file: !356, line: 388, type: !439, scopeLine: 388, flags: DIFlagPrototyped, spFlags: 0)
!439 = !DISubroutineType(types: !440)
!440 = !{!389, !407}
!441 = !DISubprogram(name: "operator--", linkageName: "_ZNSt13__atomic_baseIiEmmEv", scope: !384, file: !356, line: 392, type: !436, scopeLine: 392, flags: DIFlagPrototyped, spFlags: 0)
!442 = !DISubprogram(name: "operator--", linkageName: "_ZNVSt13__atomic_baseIiEmmEv", scope: !384, file: !356, line: 396, type: !439, scopeLine: 396, flags: DIFlagPrototyped, spFlags: 0)
!443 = !DISubprogram(name: "operator+=", linkageName: "_ZNSt13__atomic_baseIiEpLEi", scope: !384, file: !356, line: 400, type: !422, scopeLine: 400, flags: DIFlagPrototyped, spFlags: 0)
!444 = !DISubprogram(name: "operator+=", linkageName: "_ZNVSt13__atomic_baseIiEpLEi", scope: !384, file: !356, line: 404, type: !425, scopeLine: 404, flags: DIFlagPrototyped, spFlags: 0)
!445 = !DISubprogram(name: "operator-=", linkageName: "_ZNSt13__atomic_baseIiEmIEi", scope: !384, file: !356, line: 408, type: !422, scopeLine: 408, flags: DIFlagPrototyped, spFlags: 0)
!446 = !DISubprogram(name: "operator-=", linkageName: "_ZNVSt13__atomic_baseIiEmIEi", scope: !384, file: !356, line: 412, type: !425, scopeLine: 412, flags: DIFlagPrototyped, spFlags: 0)
!447 = !DISubprogram(name: "operator&=", linkageName: "_ZNSt13__atomic_baseIiEaNEi", scope: !384, file: !356, line: 416, type: !422, scopeLine: 416, flags: DIFlagPrototyped, spFlags: 0)
!448 = !DISubprogram(name: "operator&=", linkageName: "_ZNVSt13__atomic_baseIiEaNEi", scope: !384, file: !356, line: 420, type: !425, scopeLine: 420, flags: DIFlagPrototyped, spFlags: 0)
!449 = !DISubprogram(name: "operator|=", linkageName: "_ZNSt13__atomic_baseIiEoREi", scope: !384, file: !356, line: 424, type: !422, scopeLine: 424, flags: DIFlagPrototyped, spFlags: 0)
!450 = !DISubprogram(name: "operator|=", linkageName: "_ZNVSt13__atomic_baseIiEoREi", scope: !384, file: !356, line: 428, type: !425, scopeLine: 428, flags: DIFlagPrototyped, spFlags: 0)
!451 = !DISubprogram(name: "operator^=", linkageName: "_ZNSt13__atomic_baseIiEeOEi", scope: !384, file: !356, line: 432, type: !422, scopeLine: 432, flags: DIFlagPrototyped, spFlags: 0)
!452 = !DISubprogram(name: "operator^=", linkageName: "_ZNVSt13__atomic_baseIiEeOEi", scope: !384, file: !356, line: 436, type: !425, scopeLine: 436, flags: DIFlagPrototyped, spFlags: 0)
!453 = !DISubprogram(name: "is_lock_free", linkageName: "_ZNKSt13__atomic_baseIiE12is_lock_freeEv", scope: !384, file: !356, line: 440, type: !454, scopeLine: 440, flags: DIFlagPrototyped, spFlags: 0)
!454 = !DISubroutineType(types: !455)
!455 = !{!378, !415}
!456 = !DISubprogram(name: "is_lock_free", linkageName: "_ZNVKSt13__atomic_baseIiE12is_lock_freeEv", scope: !384, file: !356, line: 448, type: !457, scopeLine: 448, flags: DIFlagPrototyped, spFlags: 0)
!457 = !DISubroutineType(types: !458)
!458 = !{!378, !419}
!459 = !DISubprogram(name: "store", linkageName: "_ZNSt13__atomic_baseIiE5storeEiSt12memory_order", scope: !384, file: !356, line: 456, type: !460, scopeLine: 456, flags: DIFlagPrototyped, spFlags: 0)
!460 = !DISubroutineType(types: !461)
!461 = !{null, !393, !389, !462}
!462 = !DIDerivedType(tag: DW_TAG_typedef, name: "memory_order", scope: !2, file: !356, line: 86, baseType: !355)
!463 = !DISubprogram(name: "store", linkageName: "_ZNVSt13__atomic_baseIiE5storeEiSt12memory_order", scope: !384, file: !356, line: 468, type: !464, scopeLine: 468, flags: DIFlagPrototyped, spFlags: 0)
!464 = !DISubroutineType(types: !465)
!465 = !{null, !407, !389, !462}
!466 = !DISubprogram(name: "load", linkageName: "_ZNKSt13__atomic_baseIiE4loadESt12memory_order", scope: !384, file: !356, line: 481, type: !467, scopeLine: 481, flags: DIFlagPrototyped, spFlags: 0)
!467 = !DISubroutineType(types: !468)
!468 = !{!389, !415, !462}
!469 = !DISubprogram(name: "load", linkageName: "_ZNVKSt13__atomic_baseIiE4loadESt12memory_order", scope: !384, file: !356, line: 492, type: !470, scopeLine: 492, flags: DIFlagPrototyped, spFlags: 0)
!470 = !DISubroutineType(types: !471)
!471 = !{!389, !419, !462}
!472 = !DISubprogram(name: "exchange", linkageName: "_ZNSt13__atomic_baseIiE8exchangeEiSt12memory_order", scope: !384, file: !356, line: 503, type: !473, scopeLine: 503, flags: DIFlagPrototyped, spFlags: 0)
!473 = !DISubroutineType(types: !474)
!474 = !{!389, !393, !389, !462}
!475 = !DISubprogram(name: "exchange", linkageName: "_ZNVSt13__atomic_baseIiE8exchangeEiSt12memory_order", scope: !384, file: !356, line: 511, type: !476, scopeLine: 511, flags: DIFlagPrototyped, spFlags: 0)
!476 = !DISubroutineType(types: !477)
!477 = !{!389, !407, !389, !462}
!478 = !DISubprogram(name: "compare_exchange_weak", linkageName: "_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_", scope: !384, file: !356, line: 518, type: !479, scopeLine: 518, flags: DIFlagPrototyped, spFlags: 0)
!479 = !DISubroutineType(types: !480)
!480 = !{!378, !393, !481, !389, !462, !462}
!481 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !389, size: 64)
!482 = !DISubprogram(name: "compare_exchange_weak", linkageName: "_ZNVSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_orderS2_", scope: !384, file: !356, line: 528, type: !483, scopeLine: 528, flags: DIFlagPrototyped, spFlags: 0)
!483 = !DISubroutineType(types: !484)
!484 = !{!378, !407, !481, !389, !462, !462}
!485 = !DISubprogram(name: "compare_exchange_weak", linkageName: "_ZNSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_order", scope: !384, file: !356, line: 539, type: !486, scopeLine: 539, flags: DIFlagPrototyped, spFlags: 0)
!486 = !DISubroutineType(types: !487)
!487 = !{!378, !393, !481, !389, !462}
!488 = !DISubprogram(name: "compare_exchange_weak", linkageName: "_ZNVSt13__atomic_baseIiE21compare_exchange_weakERiiSt12memory_order", scope: !384, file: !356, line: 547, type: !489, scopeLine: 547, flags: DIFlagPrototyped, spFlags: 0)
!489 = !DISubroutineType(types: !490)
!490 = !{!378, !407, !481, !389, !462}
!491 = !DISubprogram(name: "compare_exchange_strong", linkageName: "_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_", scope: !384, file: !356, line: 555, type: !479, scopeLine: 555, flags: DIFlagPrototyped, spFlags: 0)
!492 = !DISubprogram(name: "compare_exchange_strong", linkageName: "_ZNVSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_orderS2_", scope: !384, file: !356, line: 565, type: !483, scopeLine: 565, flags: DIFlagPrototyped, spFlags: 0)
!493 = !DISubprogram(name: "compare_exchange_strong", linkageName: "_ZNSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_order", scope: !384, file: !356, line: 576, type: !486, scopeLine: 576, flags: DIFlagPrototyped, spFlags: 0)
!494 = !DISubprogram(name: "compare_exchange_strong", linkageName: "_ZNVSt13__atomic_baseIiE23compare_exchange_strongERiiSt12memory_order", scope: !384, file: !356, line: 584, type: !489, scopeLine: 584, flags: DIFlagPrototyped, spFlags: 0)
!495 = !DISubprogram(name: "fetch_add", linkageName: "_ZNSt13__atomic_baseIiE9fetch_addEiSt12memory_order", scope: !384, file: !356, line: 616, type: !473, scopeLine: 616, flags: DIFlagPrototyped, spFlags: 0)
!496 = !DISubprogram(name: "fetch_add", linkageName: "_ZNVSt13__atomic_baseIiE9fetch_addEiSt12memory_order", scope: !384, file: !356, line: 621, type: !476, scopeLine: 621, flags: DIFlagPrototyped, spFlags: 0)
!497 = !DISubprogram(name: "fetch_sub", linkageName: "_ZNSt13__atomic_baseIiE9fetch_subEiSt12memory_order", scope: !384, file: !356, line: 626, type: !473, scopeLine: 626, flags: DIFlagPrototyped, spFlags: 0)
!498 = !DISubprogram(name: "fetch_sub", linkageName: "_ZNVSt13__atomic_baseIiE9fetch_subEiSt12memory_order", scope: !384, file: !356, line: 631, type: !476, scopeLine: 631, flags: DIFlagPrototyped, spFlags: 0)
!499 = !DISubprogram(name: "fetch_and", linkageName: "_ZNSt13__atomic_baseIiE9fetch_andEiSt12memory_order", scope: !384, file: !356, line: 636, type: !473, scopeLine: 636, flags: DIFlagPrototyped, spFlags: 0)
!500 = !DISubprogram(name: "fetch_and", linkageName: "_ZNVSt13__atomic_baseIiE9fetch_andEiSt12memory_order", scope: !384, file: !356, line: 641, type: !476, scopeLine: 641, flags: DIFlagPrototyped, spFlags: 0)
!501 = !DISubprogram(name: "fetch_or", linkageName: "_ZNSt13__atomic_baseIiE8fetch_orEiSt12memory_order", scope: !384, file: !356, line: 646, type: !473, scopeLine: 646, flags: DIFlagPrototyped, spFlags: 0)
!502 = !DISubprogram(name: "fetch_or", linkageName: "_ZNVSt13__atomic_baseIiE8fetch_orEiSt12memory_order", scope: !384, file: !356, line: 651, type: !476, scopeLine: 651, flags: DIFlagPrototyped, spFlags: 0)
!503 = !DISubprogram(name: "fetch_xor", linkageName: "_ZNSt13__atomic_baseIiE9fetch_xorEiSt12memory_order", scope: !384, file: !356, line: 656, type: !473, scopeLine: 656, flags: DIFlagPrototyped, spFlags: 0)
!504 = !DISubprogram(name: "fetch_xor", linkageName: "_ZNVSt13__atomic_baseIiE9fetch_xorEiSt12memory_order", scope: !384, file: !356, line: 661, type: !476, scopeLine: 661, flags: DIFlagPrototyped, spFlags: 0)
!505 = !{!506}
!506 = !DITemplateTypeParameter(name: "_ITp", type: !256)
!507 = !DIDerivedType(tag: DW_TAG_member, name: "is_always_lock_free", scope: !380, file: !381, line: 839, baseType: !508, flags: DIFlagStaticMember, extraData: i1 true)
!508 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !378)
!509 = !DISubprogram(name: "atomic", scope: !380, file: !381, line: 827, type: !510, scopeLine: 827, flags: DIFlagPrototyped, spFlags: 0)
!510 = !DISubroutineType(types: !511)
!511 = !{null, !512}
!512 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !380, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!513 = !DISubprogram(name: "~atomic", scope: !380, file: !381, line: 828, type: !510, scopeLine: 828, flags: DIFlagPrototyped, spFlags: 0)
!514 = !DISubprogram(name: "atomic", scope: !380, file: !381, line: 829, type: !515, scopeLine: 829, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!515 = !DISubroutineType(types: !516)
!516 = !{null, !512, !517}
!517 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !518, size: 64)
!518 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !380)
!519 = !DISubprogram(name: "operator=", linkageName: "_ZNSt6atomicIiEaSERKS0_", scope: !380, file: !381, line: 830, type: !520, scopeLine: 830, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!520 = !DISubroutineType(types: !521)
!521 = !{!522, !512, !517}
!522 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !380, size: 64)
!523 = !DISubprogram(name: "operator=", linkageName: "_ZNVSt6atomicIiEaSERKS0_", scope: !380, file: !381, line: 831, type: !524, scopeLine: 831, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!524 = !DISubroutineType(types: !525)
!525 = !{!522, !526, !517}
!526 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !527, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!527 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !380)
!528 = !DISubprogram(name: "atomic", scope: !380, file: !381, line: 833, type: !529, scopeLine: 833, flags: DIFlagPrototyped, spFlags: 0)
!529 = !DISubroutineType(types: !530)
!530 = !{null, !512, !531}
!531 = !DIDerivedType(tag: DW_TAG_typedef, name: "__integral_type", scope: !380, file: !381, line: 824, baseType: !256)
!532 = !{!533}
!533 = !DITemplateTypeParameter(name: "_Tp", type: !256)
!534 = !DIDerivedType(tag: DW_TAG_member, name: "mutables_", scope: !366, file: !365, line: 208, baseType: !535, size: 320, offset: 1024)
!535 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "mutex", scope: !2, file: !536, line: 83, size: 320, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !537, identifier: "_ZTSSt5mutex")
!536 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/std_mutex.h", directory: "")
!537 = !{!538, !589, !593, !594, !599, !603, !604, !607, !608}
!538 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !535, baseType: !539, extraData: i32 0)
!539 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__mutex_base", scope: !2, file: !536, line: 57, size: 320, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !540, identifier: "_ZTSSt12__mutex_base")
!540 = !{!541, !576, !580, !585}
!541 = !DIDerivedType(tag: DW_TAG_member, name: "_M_mutex", scope: !539, file: !536, line: 63, baseType: !542, size: 320, flags: DIFlagProtected)
!542 = !DIDerivedType(tag: DW_TAG_typedef, name: "__native_type", scope: !539, file: !536, line: 60, baseType: !543)
!543 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gthread_mutex_t", file: !544, line: 50, baseType: !545)
!544 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/x86_64-linux-gnu/c++/11/bits/gthr-default.h", directory: "")
!545 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_mutex_t", file: !546, line: 72, baseType: !547)
!546 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "")
!547 = distinct !DICompositeType(tag: DW_TAG_union_type, file: !546, line: 67, size: 320, flags: DIFlagTypePassByValue, elements: !548, identifier: "_ZTS15pthread_mutex_t")
!548 = !{!549, !569, !574}
!549 = !DIDerivedType(tag: DW_TAG_member, name: "__data", scope: !547, file: !546, line: 69, baseType: !550, size: 320)
!550 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__pthread_mutex_s", file: !551, line: 22, size: 320, flags: DIFlagTypePassByValue, elements: !552, identifier: "_ZTS17__pthread_mutex_s")
!551 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/struct_mutex.h", directory: "")
!552 = !{!553, !554, !555, !556, !557, !558, !560, !561}
!553 = !DIDerivedType(tag: DW_TAG_member, name: "__lock", scope: !550, file: !551, line: 24, baseType: !256, size: 32)
!554 = !DIDerivedType(tag: DW_TAG_member, name: "__count", scope: !550, file: !551, line: 25, baseType: !68, size: 32, offset: 32)
!555 = !DIDerivedType(tag: DW_TAG_member, name: "__owner", scope: !550, file: !551, line: 26, baseType: !256, size: 32, offset: 64)
!556 = !DIDerivedType(tag: DW_TAG_member, name: "__nusers", scope: !550, file: !551, line: 28, baseType: !68, size: 32, offset: 96)
!557 = !DIDerivedType(tag: DW_TAG_member, name: "__kind", scope: !550, file: !551, line: 32, baseType: !256, size: 32, offset: 128)
!558 = !DIDerivedType(tag: DW_TAG_member, name: "__spins", scope: !550, file: !551, line: 34, baseType: !559, size: 16, offset: 160)
!559 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!560 = !DIDerivedType(tag: DW_TAG_member, name: "__elision", scope: !550, file: !551, line: 35, baseType: !559, size: 16, offset: 176)
!561 = !DIDerivedType(tag: DW_TAG_member, name: "__list", scope: !550, file: !551, line: 36, baseType: !562, size: 128, offset: 192)
!562 = !DIDerivedType(tag: DW_TAG_typedef, name: "__pthread_list_t", file: !563, line: 55, baseType: !564)
!563 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/thread-shared-types.h", directory: "")
!564 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__pthread_internal_list", file: !563, line: 51, size: 128, flags: DIFlagTypePassByValue, elements: !565, identifier: "_ZTS23__pthread_internal_list")
!565 = !{!566, !568}
!566 = !DIDerivedType(tag: DW_TAG_member, name: "__prev", scope: !564, file: !563, line: 53, baseType: !567, size: 64)
!567 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !564, size: 64)
!568 = !DIDerivedType(tag: DW_TAG_member, name: "__next", scope: !564, file: !563, line: 54, baseType: !567, size: 64, offset: 64)
!569 = !DIDerivedType(tag: DW_TAG_member, name: "__size", scope: !547, file: !546, line: 70, baseType: !570, size: 320)
!570 = !DICompositeType(tag: DW_TAG_array_type, baseType: !571, size: 320, elements: !572)
!571 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!572 = !{!573}
!573 = !DISubrange(count: 40)
!574 = !DIDerivedType(tag: DW_TAG_member, name: "__align", scope: !547, file: !546, line: 71, baseType: !575, size: 64)
!575 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!576 = !DISubprogram(name: "__mutex_base", scope: !539, file: !536, line: 65, type: !577, scopeLine: 65, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!577 = !DISubroutineType(types: !578)
!578 = !{null, !579}
!579 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !539, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!580 = !DISubprogram(name: "__mutex_base", scope: !539, file: !536, line: 78, type: !581, scopeLine: 78, flags: DIFlagProtected | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!581 = !DISubroutineType(types: !582)
!582 = !{null, !579, !583}
!583 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !584, size: 64)
!584 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !539)
!585 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__mutex_baseaSERKS_", scope: !539, file: !536, line: 79, type: !586, scopeLine: 79, flags: DIFlagProtected | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!586 = !DISubroutineType(types: !587)
!587 = !{!588, !579, !583}
!588 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !539, size: 64)
!589 = !DISubprogram(name: "mutex", scope: !535, file: !536, line: 91, type: !590, scopeLine: 91, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!590 = !DISubroutineType(types: !591)
!591 = !{null, !592}
!592 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !535, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!593 = !DISubprogram(name: "~mutex", scope: !535, file: !536, line: 92, type: !590, scopeLine: 92, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!594 = !DISubprogram(name: "mutex", scope: !535, file: !536, line: 94, type: !595, scopeLine: 94, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!595 = !DISubroutineType(types: !596)
!596 = !{null, !592, !597}
!597 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !598, size: 64)
!598 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !535)
!599 = !DISubprogram(name: "operator=", linkageName: "_ZNSt5mutexaSERKS_", scope: !535, file: !536, line: 95, type: !600, scopeLine: 95, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!600 = !DISubroutineType(types: !601)
!601 = !{!602, !592, !597}
!602 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !535, size: 64)
!603 = !DISubprogram(name: "lock", linkageName: "_ZNSt5mutex4lockEv", scope: !535, file: !536, line: 98, type: !590, scopeLine: 98, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!604 = !DISubprogram(name: "try_lock", linkageName: "_ZNSt5mutex8try_lockEv", scope: !535, file: !536, line: 108, type: !605, scopeLine: 108, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!605 = !DISubroutineType(types: !606)
!606 = !{!378, !592}
!607 = !DISubprogram(name: "unlock", linkageName: "_ZNSt5mutex6unlockEv", scope: !535, file: !536, line: 115, type: !590, scopeLine: 115, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!608 = !DISubprogram(name: "native_handle", linkageName: "_ZNSt5mutex13native_handleEv", scope: !535, file: !536, line: 122, type: !609, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!609 = !DISubroutineType(types: !610)
!610 = !{!611, !592}
!611 = !DIDerivedType(tag: DW_TAG_typedef, name: "native_handle_type", scope: !535, file: !536, line: 86, baseType: !612)
!612 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !542, size: 64)
!613 = !DIDerivedType(tag: DW_TAG_member, name: "numel_", scope: !366, file: !365, line: 209, baseType: !375, size: 64, offset: 1344)
!614 = !DIDerivedType(tag: DW_TAG_member, name: "is_contiguous_", scope: !366, file: !365, line: 210, baseType: !615, size: 128, offset: 1408)
!615 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SymBool", scope: !36, file: !616, line: 14, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c107SymBoolE")
!616 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/SymBool.h", directory: "/home/mvh6224/CUDA-BOSolver")
!617 = !DIDerivedType(tag: DW_TAG_member, name: "is_channels_last_contiguous_", scope: !366, file: !365, line: 211, baseType: !615, size: 128, offset: 1536)
!618 = !DIDerivedType(tag: DW_TAG_member, name: "is_channels_last_3d_contiguous_", scope: !366, file: !365, line: 212, baseType: !615, size: 128, offset: 1664)
!619 = !DIDerivedType(tag: DW_TAG_member, name: "is_channels_last_", scope: !366, file: !365, line: 213, baseType: !615, size: 128, offset: 1792)
!620 = !DIDerivedType(tag: DW_TAG_member, name: "is_channels_last_3d_", scope: !366, file: !365, line: 214, baseType: !615, size: 128, offset: 1920)
!621 = !DIDerivedType(tag: DW_TAG_member, name: "is_non_overlapping_and_dense_", scope: !366, file: !365, line: 215, baseType: !615, size: 128, offset: 2048)
!622 = !DISubprogram(name: "SymbolicShapeMeta", scope: !366, file: !365, line: 24, type: !623, scopeLine: 24, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!623 = !DISubroutineType(types: !624)
!624 = !{null, !625}
!625 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !366, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!626 = !DISubprogram(name: "~SymbolicShapeMeta", scope: !366, file: !365, line: 25, type: !623, scopeLine: 25, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!627 = !DISubprogram(name: "SymbolicShapeMeta", scope: !366, file: !365, line: 26, type: !628, scopeLine: 26, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!628 = !DISubroutineType(types: !629)
!629 = !{null, !625, !630}
!630 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !631, size: 64)
!631 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !366)
!632 = !DISubprogram(name: "SymbolicShapeMeta", scope: !366, file: !365, line: 27, type: !633, scopeLine: 27, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!633 = !DISubroutineType(types: !634)
!634 = !{null, !625, !635}
!635 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !366, size: 64)
!636 = !DISubprogram(name: "operator=", linkageName: "_ZN3c1017SymbolicShapeMetaaSERKS0_", scope: !366, file: !365, line: 28, type: !637, scopeLine: 28, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!637 = !DISubroutineType(types: !638)
!638 = !{!639, !625, !630}
!639 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !366, size: 64)
!640 = !DISubprogram(name: "operator=", linkageName: "_ZN3c1017SymbolicShapeMetaaSEOS0_", scope: !366, file: !365, line: 29, type: !641, scopeLine: 29, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!641 = !DISubroutineType(types: !642)
!642 = !{!639, !625, !635}
!643 = !DISubprogram(name: "refresh_numel", linkageName: "_ZN3c1017SymbolicShapeMeta13refresh_numelEv", scope: !366, file: !365, line: 31, type: !623, scopeLine: 31, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!644 = !DISubprogram(name: "refresh_contiguous", linkageName: "_ZN3c1017SymbolicShapeMeta18refresh_contiguousEv", scope: !366, file: !365, line: 37, type: !623, scopeLine: 37, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!645 = !DISubprogram(name: "dim", linkageName: "_ZNK3c1017SymbolicShapeMeta3dimEv", scope: !366, file: !365, line: 48, type: !646, scopeLine: 48, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!646 = !DISubroutineType(types: !647)
!647 = !{!648, !650}
!648 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !38, line: 27, baseType: !649)
!649 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !40, line: 44, baseType: !575)
!650 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !631, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!651 = !DISubprogram(name: "has_numel", linkageName: "_ZNK3c1017SymbolicShapeMeta9has_numelEv", scope: !366, file: !365, line: 54, type: !652, scopeLine: 54, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!652 = !DISubroutineType(types: !653)
!653 = !{!378, !650}
!654 = !DISubprogram(name: "has_is_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta17has_is_contiguousEv", scope: !366, file: !365, line: 57, type: !652, scopeLine: 57, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!655 = !DISubprogram(name: "has_is_channels_last_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta31has_is_channels_last_contiguousEv", scope: !366, file: !365, line: 60, type: !652, scopeLine: 60, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!656 = !DISubprogram(name: "has_is_channels_last_3d_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta34has_is_channels_last_3d_contiguousEv", scope: !366, file: !365, line: 63, type: !652, scopeLine: 63, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!657 = !DISubprogram(name: "has_is_channels_last", linkageName: "_ZNK3c1017SymbolicShapeMeta20has_is_channels_lastEv", scope: !366, file: !365, line: 66, type: !652, scopeLine: 66, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!658 = !DISubprogram(name: "has_is_channels_last_3d", linkageName: "_ZNK3c1017SymbolicShapeMeta23has_is_channels_last_3dEv", scope: !366, file: !365, line: 69, type: !652, scopeLine: 69, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!659 = !DISubprogram(name: "has_is_non_overlapping_and_dense", linkageName: "_ZNK3c1017SymbolicShapeMeta32has_is_non_overlapping_and_denseEv", scope: !366, file: !365, line: 72, type: !652, scopeLine: 72, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!660 = !DISubprogram(name: "numel", linkageName: "_ZNK3c1017SymbolicShapeMeta5numelEv", scope: !366, file: !365, line: 78, type: !661, scopeLine: 78, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!661 = !DISubroutineType(types: !662)
!662 = !{!663, !650}
!663 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !664, size: 64)
!664 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !375)
!665 = !DISubprogram(name: "is_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta13is_contiguousEv", scope: !366, file: !365, line: 85, type: !666, scopeLine: 85, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!666 = !DISubroutineType(types: !667)
!667 = !{!668, !650}
!668 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !669, size: 64)
!669 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !615)
!670 = !DISubprogram(name: "is_channels_last_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta27is_channels_last_contiguousEv", scope: !366, file: !365, line: 92, type: !666, scopeLine: 92, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!671 = !DISubprogram(name: "is_channels_last_3d_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta30is_channels_last_3d_contiguousEv", scope: !366, file: !365, line: 99, type: !666, scopeLine: 99, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!672 = !DISubprogram(name: "is_channels_last", linkageName: "_ZNK3c1017SymbolicShapeMeta16is_channels_lastEv", scope: !366, file: !365, line: 106, type: !666, scopeLine: 106, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!673 = !DISubprogram(name: "is_channels_last_3d", linkageName: "_ZNK3c1017SymbolicShapeMeta19is_channels_last_3dEv", scope: !366, file: !365, line: 113, type: !666, scopeLine: 113, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!674 = !DISubprogram(name: "is_non_overlapping_and_dense", linkageName: "_ZNK3c1017SymbolicShapeMeta28is_non_overlapping_and_denseEv", scope: !366, file: !365, line: 120, type: !666, scopeLine: 120, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!675 = !DISubprogram(name: "assume_contiguous", linkageName: "_ZN3c1017SymbolicShapeMeta17assume_contiguousENS_7SymBoolE", scope: !366, file: !365, line: 129, type: !676, scopeLine: 129, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!676 = !DISubroutineType(types: !677)
!677 = !{null, !625, !615}
!678 = !DISubprogram(name: "assume_channels_last_contiguous", linkageName: "_ZN3c1017SymbolicShapeMeta31assume_channels_last_contiguousENS_7SymBoolE", scope: !366, file: !365, line: 133, type: !676, scopeLine: 133, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!679 = !DISubprogram(name: "assume_channels_last_3d_contiguous", linkageName: "_ZN3c1017SymbolicShapeMeta34assume_channels_last_3d_contiguousENS_7SymBoolE", scope: !366, file: !365, line: 137, type: !676, scopeLine: 137, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!680 = !DISubprogram(name: "assume_channels_last", linkageName: "_ZN3c1017SymbolicShapeMeta20assume_channels_lastENS_7SymBoolE", scope: !366, file: !365, line: 141, type: !676, scopeLine: 141, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!681 = !DISubprogram(name: "assume_channels_last_3d", linkageName: "_ZN3c1017SymbolicShapeMeta23assume_channels_last_3dENS_7SymBoolE", scope: !366, file: !365, line: 145, type: !676, scopeLine: 145, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!682 = !DISubprogram(name: "assume_non_overlapping_and_dense", linkageName: "_ZN3c1017SymbolicShapeMeta32assume_non_overlapping_and_denseENS_7SymBoolE", scope: !366, file: !365, line: 149, type: !676, scopeLine: 149, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!683 = !DISubprogram(name: "compute_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta18compute_contiguousEv", scope: !366, file: !365, line: 155, type: !684, scopeLine: 155, flags: DIFlagPrototyped, spFlags: 0)
!684 = !DISubroutineType(types: !685)
!685 = !{!615, !650}
!686 = !DISubprogram(name: "compute_channels_last_contiguous_2d", linkageName: "_ZNK3c1017SymbolicShapeMeta35compute_channels_last_contiguous_2dEv", scope: !366, file: !365, line: 156, type: !684, scopeLine: 156, flags: DIFlagPrototyped, spFlags: 0)
!687 = !DISubprogram(name: "compute_channels_last_contiguous_3d", linkageName: "_ZNK3c1017SymbolicShapeMeta35compute_channels_last_contiguous_3dEv", scope: !366, file: !365, line: 157, type: !684, scopeLine: 157, flags: DIFlagPrototyped, spFlags: 0)
!688 = !DISubprogram(name: "compute_strides_like_channels_last_2d", linkageName: "_ZNK3c1017SymbolicShapeMeta37compute_strides_like_channels_last_2dEv", scope: !366, file: !365, line: 158, type: !684, scopeLine: 158, flags: DIFlagPrototyped, spFlags: 0)
!689 = !DISubprogram(name: "compute_strides_like_channels_last_3d", linkageName: "_ZNK3c1017SymbolicShapeMeta37compute_strides_like_channels_last_3dEv", scope: !366, file: !365, line: 159, type: !684, scopeLine: 159, flags: DIFlagPrototyped, spFlags: 0)
!690 = !DISubprogram(name: "compute_non_overlapping_and_dense", linkageName: "_ZNK3c1017SymbolicShapeMeta33compute_non_overlapping_and_denseEv", scope: !366, file: !365, line: 160, type: !684, scopeLine: 160, flags: DIFlagPrototyped, spFlags: 0)
!691 = !DISubprogram(name: "compute_channels_last_contiguous_3d_dim5", linkageName: "_ZNK3c1017SymbolicShapeMeta40compute_channels_last_contiguous_3d_dim5Ev", scope: !366, file: !365, line: 170, type: !684, scopeLine: 170, flags: DIFlagPrototyped, spFlags: 0)
!692 = !DISubprogram(name: "compute_channels_last_2d_dim5", linkageName: "_ZNK3c1017SymbolicShapeMeta29compute_channels_last_2d_dim5Ev", scope: !366, file: !365, line: 171, type: !684, scopeLine: 171, flags: DIFlagPrototyped, spFlags: 0)
!693 = !DISubprogram(name: "compute_channels_last_3d_dim5", linkageName: "_ZNK3c1017SymbolicShapeMeta29compute_channels_last_3d_dim5Ev", scope: !366, file: !365, line: 172, type: !684, scopeLine: 172, flags: DIFlagPrototyped, spFlags: 0)
!694 = !DISubprogram(name: "compute_is_non_overlapping_and_dense_dim4", linkageName: "_ZNK3c1017SymbolicShapeMeta41compute_is_non_overlapping_and_dense_dim4Ev", scope: !366, file: !365, line: 173, type: !684, scopeLine: 173, flags: DIFlagPrototyped, spFlags: 0)
!695 = !DISubprogram(name: "compute_is_non_overlapping_and_dense_dim5", linkageName: "_ZNK3c1017SymbolicShapeMeta41compute_is_non_overlapping_and_dense_dim5Ev", scope: !366, file: !365, line: 174, type: !684, scopeLine: 174, flags: DIFlagPrototyped, spFlags: 0)
!696 = !DISubprogram(name: "compute_is_non_overlapping_and_dense_anydim", linkageName: "_ZNK3c1017SymbolicShapeMeta43compute_is_non_overlapping_and_dense_anydimEv", scope: !366, file: !365, line: 175, type: !684, scopeLine: 175, flags: DIFlagPrototyped, spFlags: 0)
!697 = !DISubprogram(name: "init_numel", linkageName: "_ZNK3c1017SymbolicShapeMeta10init_numelEv", scope: !366, file: !365, line: 177, type: !698, scopeLine: 177, flags: DIFlagPrototyped, spFlags: 0)
!698 = !DISubroutineType(types: !699)
!699 = !{null, !650}
!700 = !DISubprogram(name: "init_is_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta18init_is_contiguousEv", scope: !366, file: !365, line: 178, type: !698, scopeLine: 178, flags: DIFlagPrototyped, spFlags: 0)
!701 = !DISubprogram(name: "init_is_channels_last_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta32init_is_channels_last_contiguousEv", scope: !366, file: !365, line: 179, type: !698, scopeLine: 179, flags: DIFlagPrototyped, spFlags: 0)
!702 = !DISubprogram(name: "init_is_channels_last_3d_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta35init_is_channels_last_3d_contiguousEv", scope: !366, file: !365, line: 180, type: !698, scopeLine: 180, flags: DIFlagPrototyped, spFlags: 0)
!703 = !DISubprogram(name: "init_is_channels_last", linkageName: "_ZNK3c1017SymbolicShapeMeta21init_is_channels_lastEv", scope: !366, file: !365, line: 181, type: !698, scopeLine: 181, flags: DIFlagPrototyped, spFlags: 0)
!704 = !DISubprogram(name: "init_is_channels_last_3d", linkageName: "_ZNK3c1017SymbolicShapeMeta24init_is_channels_last_3dEv", scope: !366, file: !365, line: 182, type: !698, scopeLine: 182, flags: DIFlagPrototyped, spFlags: 0)
!705 = !DISubprogram(name: "init_is_non_overlapping_and_dense", linkageName: "_ZNK3c1017SymbolicShapeMeta33init_is_non_overlapping_and_denseEv", scope: !366, file: !365, line: 183, type: !698, scopeLine: 183, flags: DIFlagPrototyped, spFlags: 0)
!706 = !DISubprogram(name: "set_numel", linkageName: "_ZNK3c1017SymbolicShapeMeta9set_numelENS_6SymIntE", scope: !366, file: !365, line: 186, type: !707, scopeLine: 186, flags: DIFlagPrototyped, spFlags: 0)
!707 = !DISubroutineType(types: !708)
!708 = !{null, !650, !375}
!709 = !DISubprogram(name: "set_is_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta17set_is_contiguousENS_7SymBoolE", scope: !366, file: !365, line: 187, type: !710, scopeLine: 187, flags: DIFlagPrototyped, spFlags: 0)
!710 = !DISubroutineType(types: !711)
!711 = !{null, !650, !615}
!712 = !DISubprogram(name: "set_is_channels_last_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta31set_is_channels_last_contiguousENS_7SymBoolE", scope: !366, file: !365, line: 188, type: !710, scopeLine: 188, flags: DIFlagPrototyped, spFlags: 0)
!713 = !DISubprogram(name: "set_is_channels_last_3d_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta34set_is_channels_last_3d_contiguousENS_7SymBoolE", scope: !366, file: !365, line: 189, type: !710, scopeLine: 189, flags: DIFlagPrototyped, spFlags: 0)
!714 = !DISubprogram(name: "set_is_channels_last", linkageName: "_ZNK3c1017SymbolicShapeMeta20set_is_channels_lastENS_7SymBoolE", scope: !366, file: !365, line: 190, type: !710, scopeLine: 190, flags: DIFlagPrototyped, spFlags: 0)
!715 = !DISubprogram(name: "set_is_channels_last_3d", linkageName: "_ZNK3c1017SymbolicShapeMeta23set_is_channels_last_3dENS_7SymBoolE", scope: !366, file: !365, line: 191, type: !710, scopeLine: 191, flags: DIFlagPrototyped, spFlags: 0)
!716 = !DISubprogram(name: "set_is_non_overlapping_and_dense", linkageName: "_ZNK3c1017SymbolicShapeMeta32set_is_non_overlapping_and_denseENS_7SymBoolE", scope: !366, file: !365, line: 192, type: !710, scopeLine: 192, flags: DIFlagPrototyped, spFlags: 0)
!717 = !{!718, !719, !720, !721, !722, !723, !724}
!718 = !DIEnumerator(name: "numel_avail", value: 1, isUnsigned: true)
!719 = !DIEnumerator(name: "is_contiguous_avail", value: 2, isUnsigned: true)
!720 = !DIEnumerator(name: "is_channels_last_contiguous_avail", value: 4, isUnsigned: true)
!721 = !DIEnumerator(name: "is_channels_last_3d_contiguous_avail", value: 8, isUnsigned: true)
!722 = !DIEnumerator(name: "is_channels_last_avail", value: 16, isUnsigned: true)
!723 = !DIEnumerator(name: "is_channels_last_3d_avail", value: 32, isUnsigned: true)
!724 = !DIEnumerator(name: "is_non_overlapping_and_dense_avail", value: 64, isUnsigned: true)
!725 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "__memory_order_modifier", scope: !2, file: !356, line: 89, baseType: !68, size: 32, elements: !726, identifier: "_ZTSSt23__memory_order_modifier")
!726 = !{!727, !728, !729, !730}
!727 = !DIEnumerator(name: "__memory_order_mask", value: 65535, isUnsigned: true)
!728 = !DIEnumerator(name: "__memory_order_modifier_mask", value: 4294901760, isUnsigned: true)
!729 = !DIEnumerator(name: "__memory_order_hle_acquire", value: 65536, isUnsigned: true)
!730 = !DIEnumerator(name: "__memory_order_hle_release", value: 131072, isUnsigned: true)
!731 = !{!732, !378, !261, !256, !462, !648, !734, !741, !786, !825, !250, !852, !867, !915, !954, !1077, !1110, !1111, !1169, !1177, !1222, !1281, !1310, !1395, !1462, !1539, !1571, !1690, !1722, !1840, !1872, !1990, !2022, !2098, !2130, !2206, !2238, !2314, !2346, !2422, !2454, !2530, !2562, !2638, !2670, !2746, !2778, !2854, !2886, !2963, !2995, !3013, !3037, !3068, !3104, !3139, !3186, !3228, !3277, !3290, !3351, !3469, !3501, !1643, !1943, !1030, !3422, !1793, !384, !380, !539, !535, !366, !3525, !3539, !3572, !3608, !3642, !3689, !3722, !3770, !3783, !3843, !3858, !3891, !3927, !3961, !4008, !4041, !4089, !4102, !4163, !4164, !4222, !4247, !4272, !4317, !4371, !4428, !4425, !4422, !4506, !4419, !4416, !4413, !4410, !4407}
!732 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !76, line: 26, baseType: !733)
!733 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !40, line: 42, baseType: !68)
!734 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "target_description", scope: !12, file: !11, line: 81, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !735, identifier: "_ZTSN2nv6target6detail18target_descriptionE")
!735 = !{!736, !737}
!736 = !DIDerivedType(tag: DW_TAG_member, name: "targets", scope: !734, file: !11, line: 82, baseType: !15, size: 64)
!737 = !DISubprogram(name: "target_description", scope: !734, file: !11, line: 84, type: !738, scopeLine: 84, flags: DIFlagPrototyped, spFlags: 0)
!738 = !DISubroutineType(types: !739)
!739 = !{null, !740, !15}
!740 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !734, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!741 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "integral_constant<bool, true>", scope: !743, file: !742, line: 40, size: 8, flags: DIFlagTypePassByValue, elements: !745, templateParams: !783, identifier: "_ZTSN6thrust6detail17integral_constantIbLb1EEE")
!742 = !DIFile(filename: "/usr/local/cuda/include/thrust/detail/type_traits.h", directory: "")
!743 = !DINamespace(name: "detail", scope: !744)
!744 = !DINamespace(name: "thrust", scope: null)
!745 = !{!746, !747, !751, !756, !760, !777, !782}
!746 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !741, file: !742, line: 42, baseType: !508, flags: DIFlagStaticMember, extraData: i1 true)
!747 = !DISubprogram(name: "integral_constant", scope: !741, file: !742, line: 50, type: !748, scopeLine: 50, flags: DIFlagPrototyped, spFlags: 0)
!748 = !DISubroutineType(types: !749)
!749 = !{null, !750}
!750 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !741, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!751 = !DISubprogram(name: "integral_constant", scope: !741, file: !742, line: 52, type: !752, scopeLine: 52, flags: DIFlagPrototyped, spFlags: 0)
!752 = !DISubroutineType(types: !753)
!753 = !{null, !750, !754}
!754 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !755, size: 64)
!755 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !741)
!756 = !DISubprogram(name: "operator=", linkageName: "_ZN6thrust6detail17integral_constantIbLb1EEaSERKS2_", scope: !741, file: !742, line: 54, type: !757, scopeLine: 54, flags: DIFlagPrototyped, spFlags: 0)
!757 = !DISubroutineType(types: !758)
!758 = !{!759, !750, !754}
!759 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !741, size: 64)
!760 = !DISubprogram(name: "integral_constant", scope: !741, file: !742, line: 57, type: !761, scopeLine: 57, flags: DIFlagPrototyped, spFlags: 0)
!761 = !DISubroutineType(types: !762)
!762 = !{null, !750, !763}
!763 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "integral_constant<bool, true>", scope: !2, file: !764, line: 65, size: 8, flags: DIFlagTypePassByValue, elements: !765, templateParams: !774, identifier: "_ZTSSt17integral_constantIbLb1EE")
!764 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/type_traits", directory: "")
!765 = !{!766, !767, !773}
!766 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !763, file: !764, line: 67, baseType: !508, flags: DIFlagStaticMember, extraData: i1 true)
!767 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt17integral_constantIbLb1EEcvbEv", scope: !763, file: !764, line: 70, type: !768, scopeLine: 70, flags: DIFlagPrototyped, spFlags: 0)
!768 = !DISubroutineType(types: !769)
!769 = !{!770, !771}
!770 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !763, file: !764, line: 68, baseType: !378)
!771 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !772, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!772 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !763)
!773 = !DISubprogram(name: "operator()", linkageName: "_ZNKSt17integral_constantIbLb1EEclEv", scope: !763, file: !764, line: 75, type: !768, scopeLine: 75, flags: DIFlagPrototyped, spFlags: 0)
!774 = !{!775, !776}
!775 = !DITemplateTypeParameter(name: "_Tp", type: !378)
!776 = !DITemplateValueParameter(name: "__v", type: !378, value: i1 true)
!777 = !DISubprogram(name: "operator bool", linkageName: "_ZNK6thrust6detail17integral_constantIbLb1EEcvbEv", scope: !741, file: !742, line: 59, type: !778, scopeLine: 59, flags: DIFlagPrototyped, spFlags: 0)
!778 = !DISubroutineType(types: !779)
!779 = !{!780, !781}
!780 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !741, file: !742, line: 44, baseType: !378)
!781 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !755, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!782 = !DISubprogram(name: "operator()", linkageName: "_ZNK6thrust6detail17integral_constantIbLb1EEclEv", scope: !741, file: !742, line: 60, type: !778, scopeLine: 60, flags: DIFlagPrototyped, spFlags: 0)
!783 = !{!784, !785}
!784 = !DITemplateTypeParameter(name: "T", type: !378)
!785 = !DITemplateValueParameter(name: "v", type: !378, value: i1 true)
!786 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "integral_constant<bool, false>", scope: !743, file: !742, line: 40, size: 8, flags: DIFlagTypePassByValue, elements: !787, templateParams: !823, identifier: "_ZTSN6thrust6detail17integral_constantIbLb0EEE")
!787 = !{!788, !789, !793, !798, !802, !817, !822}
!788 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !786, file: !742, line: 42, baseType: !508, flags: DIFlagStaticMember, extraData: i1 false)
!789 = !DISubprogram(name: "integral_constant", scope: !786, file: !742, line: 50, type: !790, scopeLine: 50, flags: DIFlagPrototyped, spFlags: 0)
!790 = !DISubroutineType(types: !791)
!791 = !{null, !792}
!792 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !786, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!793 = !DISubprogram(name: "integral_constant", scope: !786, file: !742, line: 52, type: !794, scopeLine: 52, flags: DIFlagPrototyped, spFlags: 0)
!794 = !DISubroutineType(types: !795)
!795 = !{null, !792, !796}
!796 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !797, size: 64)
!797 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !786)
!798 = !DISubprogram(name: "operator=", linkageName: "_ZN6thrust6detail17integral_constantIbLb0EEaSERKS2_", scope: !786, file: !742, line: 54, type: !799, scopeLine: 54, flags: DIFlagPrototyped, spFlags: 0)
!799 = !DISubroutineType(types: !800)
!800 = !{!801, !792, !796}
!801 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !786, size: 64)
!802 = !DISubprogram(name: "integral_constant", scope: !786, file: !742, line: 57, type: !803, scopeLine: 57, flags: DIFlagPrototyped, spFlags: 0)
!803 = !DISubroutineType(types: !804)
!804 = !{null, !792, !805}
!805 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "integral_constant<bool, false>", scope: !2, file: !764, line: 65, size: 8, flags: DIFlagTypePassByValue, elements: !806, templateParams: !815, identifier: "_ZTSSt17integral_constantIbLb0EE")
!806 = !{!807, !808, !814}
!807 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !805, file: !764, line: 67, baseType: !508, flags: DIFlagStaticMember, extraData: i1 false)
!808 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt17integral_constantIbLb0EEcvbEv", scope: !805, file: !764, line: 70, type: !809, scopeLine: 70, flags: DIFlagPrototyped, spFlags: 0)
!809 = !DISubroutineType(types: !810)
!810 = !{!811, !812}
!811 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !805, file: !764, line: 68, baseType: !378)
!812 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !813, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!813 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !805)
!814 = !DISubprogram(name: "operator()", linkageName: "_ZNKSt17integral_constantIbLb0EEclEv", scope: !805, file: !764, line: 75, type: !809, scopeLine: 75, flags: DIFlagPrototyped, spFlags: 0)
!815 = !{!775, !816}
!816 = !DITemplateValueParameter(name: "__v", type: !378, value: i1 false)
!817 = !DISubprogram(name: "operator bool", linkageName: "_ZNK6thrust6detail17integral_constantIbLb0EEcvbEv", scope: !786, file: !742, line: 59, type: !818, scopeLine: 59, flags: DIFlagPrototyped, spFlags: 0)
!818 = !DISubroutineType(types: !819)
!819 = !{!820, !821}
!820 = !DIDerivedType(tag: DW_TAG_typedef, name: "value_type", scope: !786, file: !742, line: 44, baseType: !378)
!821 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !797, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!822 = !DISubprogram(name: "operator()", linkageName: "_ZNK6thrust6detail17integral_constantIbLb0EEclEv", scope: !786, file: !742, line: 60, type: !818, scopeLine: 60, flags: DIFlagPrototyped, spFlags: 0)
!823 = !{!784, !824}
!824 = !DITemplateValueParameter(name: "v", type: !378, value: i1 false)
!825 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tag", scope: !827, file: !826, line: 50, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !830, identifier: "_ZTSN6thrust6system6detail10sequential3tagE")
!826 = !DIFile(filename: "/usr/local/cuda/include/thrust/system/detail/sequential/execution_policy.h", directory: "")
!827 = !DINamespace(name: "sequential", scope: !828)
!828 = !DINamespace(name: "detail", scope: !829)
!829 = !DINamespace(name: "system", scope: !744)
!830 = !{!831, !848}
!831 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !825, baseType: !832, extraData: i32 0)
!832 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy<thrust::system::detail::sequential::tag>", scope: !827, file: !826, line: 45, size: 8, flags: DIFlagTypePassByValue, elements: !833, templateParams: !846, identifier: "_ZTSN6thrust6system6detail10sequential16execution_policyINS2_3tagEEE")
!833 = !{!834}
!834 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !832, baseType: !835, extraData: i32 0)
!835 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy<thrust::system::detail::sequential::tag>", scope: !744, file: !836, line: 72, size: 8, flags: DIFlagTypePassByValue, elements: !837, templateParams: !844, identifier: "_ZTSN6thrust16execution_policyINS_6system6detail10sequential3tagEEE")
!836 = !DIFile(filename: "/usr/local/cuda/include/thrust/detail/execution_policy.h", directory: "")
!837 = !{!838}
!838 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !835, baseType: !839, extraData: i32 0)
!839 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy_base<thrust::system::detail::sequential::tag>", scope: !743, file: !836, line: 43, size: 8, flags: DIFlagTypePassByValue, elements: !840, templateParams: !844, identifier: "_ZTSN6thrust6detail21execution_policy_baseINS_6system6detail10sequential3tagEEE")
!840 = !{!841}
!841 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !839, baseType: !842, extraData: i32 0)
!842 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy_marker", scope: !743, file: !836, line: 26, size: 8, flags: DIFlagTypePassByValue, elements: !843, identifier: "_ZTSN6thrust6detail23execution_policy_markerE")
!843 = !{}
!844 = !{!845}
!845 = !DITemplateTypeParameter(name: "DerivedPolicy", type: !825)
!846 = !{!847}
!847 = !DITemplateTypeParameter(type: !825)
!848 = !DISubprogram(name: "tag", scope: !825, file: !826, line: 52, type: !849, scopeLine: 52, flags: DIFlagPrototyped, spFlags: 0)
!849 = !DISubroutineType(types: !850)
!850 = !{null, !851}
!851 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !825, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!852 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_count<__gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 578, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !854, templateParams: !910, identifier: "_ZTSSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE")
!853 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/shared_ptr_base.h", directory: "")
!854 = !{!855, !858, !862, !912, !922, !923, !926, !930, !933, !937, !940, !948, !951}
!855 = !DIDerivedType(tag: DW_TAG_member, name: "_M_pi", scope: !852, file: !853, line: 766, baseType: !856, size: 64)
!856 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !857, size: 64)
!857 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "_Sp_counted_base<__gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 122, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE")
!858 = !DISubprogram(name: "__shared_count", scope: !852, file: !853, line: 587, type: !859, scopeLine: 587, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!859 = !DISubroutineType(types: !860)
!860 = !{null, !861}
!861 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !852, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!862 = !DISubprogram(name: "__shared_count", scope: !852, file: !853, line: 696, type: !863, scopeLine: 696, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!863 = !DISubroutineType(types: !864)
!864 = !{null, !861, !865}
!865 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !866, size: 64)
!866 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !867)
!867 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_count<__gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 771, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !868, templateParams: !910, identifier: "_ZTSSt12__weak_countILN9__gnu_cxx12_Lock_policyE2EE")
!868 = !{!869, !870, !874, !879, !882, !886, !887, !891, !894, !897, !900, !904, !907}
!869 = !DIDerivedType(tag: DW_TAG_member, name: "_M_pi", scope: !867, file: !853, line: 863, baseType: !856, size: 64)
!870 = !DISubprogram(name: "__weak_count", scope: !867, file: !853, line: 774, type: !871, scopeLine: 774, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!871 = !DISubroutineType(types: !872)
!872 = !{null, !873}
!873 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !867, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!874 = !DISubprogram(name: "__weak_count", scope: !867, file: !853, line: 777, type: !875, scopeLine: 777, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!875 = !DISubroutineType(types: !876)
!876 = !{null, !873, !877}
!877 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !878, size: 64)
!878 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !852)
!879 = !DISubprogram(name: "__weak_count", scope: !867, file: !853, line: 784, type: !880, scopeLine: 784, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!880 = !DISubroutineType(types: !881)
!881 = !{null, !873, !865}
!882 = !DISubprogram(name: "__weak_count", scope: !867, file: !853, line: 791, type: !883, scopeLine: 791, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!883 = !DISubroutineType(types: !884)
!884 = !{null, !873, !885}
!885 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !867, size: 64)
!886 = !DISubprogram(name: "~__weak_count", scope: !867, file: !853, line: 795, type: !871, scopeLine: 795, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!887 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__weak_countILN9__gnu_cxx12_Lock_policyE2EEaSERKSt14__shared_countILS1_2EE", scope: !867, file: !853, line: 802, type: !888, scopeLine: 802, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!888 = !DISubroutineType(types: !889)
!889 = !{!890, !873, !877}
!890 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !867, size: 64)
!891 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__weak_countILN9__gnu_cxx12_Lock_policyE2EEaSERKS2_", scope: !867, file: !853, line: 814, type: !892, scopeLine: 814, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!892 = !DISubroutineType(types: !893)
!893 = !{!890, !873, !865}
!894 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__weak_countILN9__gnu_cxx12_Lock_policyE2EEaSEOS2_", scope: !867, file: !853, line: 826, type: !895, scopeLine: 826, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!895 = !DISubroutineType(types: !896)
!896 = !{!890, !873, !885}
!897 = !DISubprogram(name: "_M_swap", linkageName: "_ZNSt12__weak_countILN9__gnu_cxx12_Lock_policyE2EE7_M_swapERS2_", scope: !867, file: !853, line: 836, type: !898, scopeLine: 836, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!898 = !DISubroutineType(types: !899)
!899 = !{null, !873, !890}
!900 = !DISubprogram(name: "_M_get_use_count", linkageName: "_ZNKSt12__weak_countILN9__gnu_cxx12_Lock_policyE2EE16_M_get_use_countEv", scope: !867, file: !853, line: 844, type: !901, scopeLine: 844, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!901 = !DISubroutineType(types: !902)
!902 = !{!575, !903}
!903 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !866, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!904 = !DISubprogram(name: "_M_less", linkageName: "_ZNKSt12__weak_countILN9__gnu_cxx12_Lock_policyE2EE7_M_lessERKS2_", scope: !867, file: !853, line: 848, type: !905, scopeLine: 848, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!905 = !DISubroutineType(types: !906)
!906 = !{!378, !903, !865}
!907 = !DISubprogram(name: "_M_less", linkageName: "_ZNKSt12__weak_countILN9__gnu_cxx12_Lock_policyE2EE7_M_lessERKSt14__shared_countILS1_2EE", scope: !867, file: !853, line: 852, type: !908, scopeLine: 852, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!908 = !DISubroutineType(types: !909)
!909 = !{!378, !903, !877}
!910 = !{!911}
!911 = !DITemplateValueParameter(name: "_Lp", type: !65, value: i32 2)
!912 = !DISubprogram(name: "__shared_count", scope: !852, file: !853, line: 700, type: !913, scopeLine: 700, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!913 = !DISubroutineType(types: !914)
!914 = !{null, !861, !865, !915}
!915 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "nothrow_t", scope: !2, file: !916, line: 92, size: 8, flags: DIFlagTypePassByValue, elements: !917, identifier: "_ZTSSt9nothrow_t")
!916 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/new", directory: "")
!917 = !{!918}
!918 = !DISubprogram(name: "nothrow_t", scope: !915, file: !916, line: 95, type: !919, scopeLine: 95, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!919 = !DISubroutineType(types: !920)
!920 = !{null, !921}
!921 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !915, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!922 = !DISubprogram(name: "~__shared_count", scope: !852, file: !853, line: 702, type: !859, scopeLine: 702, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!923 = !DISubprogram(name: "__shared_count", scope: !852, file: !853, line: 708, type: !924, scopeLine: 708, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!924 = !DISubroutineType(types: !925)
!925 = !{null, !861, !877}
!926 = !DISubprogram(name: "operator=", linkageName: "_ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EEaSERKS2_", scope: !852, file: !853, line: 716, type: !927, scopeLine: 716, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!927 = !DISubroutineType(types: !928)
!928 = !{!929, !861, !877}
!929 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !852, size: 64)
!930 = !DISubprogram(name: "_M_swap", linkageName: "_ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE7_M_swapERS2_", scope: !852, file: !853, line: 731, type: !931, scopeLine: 731, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!931 = !DISubroutineType(types: !932)
!932 = !{null, !861, !929}
!933 = !DISubprogram(name: "_M_get_use_count", linkageName: "_ZNKSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE16_M_get_use_countEv", scope: !852, file: !853, line: 739, type: !934, scopeLine: 739, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!934 = !DISubroutineType(types: !935)
!935 = !{!575, !936}
!936 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !878, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!937 = !DISubprogram(name: "_M_unique", linkageName: "_ZNKSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE9_M_uniqueEv", scope: !852, file: !853, line: 743, type: !938, scopeLine: 743, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!938 = !DISubroutineType(types: !939)
!939 = !{!378, !936}
!940 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !852, file: !853, line: 747, type: !941, scopeLine: 747, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!941 = !DISubroutineType(types: !942)
!942 = !{!943, !936, !944}
!943 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!944 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !945, size: 64)
!945 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !946)
!946 = !DICompositeType(tag: DW_TAG_class_type, name: "type_info", scope: !2, file: !947, line: 88, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!947 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/typeinfo", directory: "")
!948 = !DISubprogram(name: "_M_less", linkageName: "_ZNKSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE7_M_lessERKS2_", scope: !852, file: !853, line: 751, type: !949, scopeLine: 751, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!949 = !DISubroutineType(types: !950)
!950 = !{!378, !936, !877}
!951 = !DISubprogram(name: "_M_less", linkageName: "_ZNKSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE7_M_lessERKSt12__weak_countILS1_2EE", scope: !852, file: !853, line: 755, type: !952, scopeLine: 755, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!952 = !DISubroutineType(types: !953)
!953 = !{!378, !936, !865}
!954 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::ClassType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !955, templateParams: !1073, identifier: "_ZTSSt12__shared_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE")
!955 = !{!956, !976, !982, !983, !987, !992, !996, !997, !1001, !1007, !1010, !1011, !1015, !1018, !1019, !1022, !1025, !1074}
!956 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !954, baseType: !957, flags: DIFlagPublic, extraData: i32 0)
!957 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::ClassType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !958, templateParams: !973, identifier: "_ZTSSt19__shared_ptr_accessIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!958 = !{!959, !968, !972}
!959 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !957, file: !853, line: 977, type: !960, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!960 = !DISubroutineType(types: !961)
!961 = !{!962, !966}
!962 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !963, size: 64)
!963 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !957, file: !853, line: 974, baseType: !964)
!964 = !DICompositeType(tag: DW_TAG_structure_type, name: "ClassType", scope: !36, file: !965, line: 66, size: 3648, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!965 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/class_type.h", directory: "/home/mvh6224/CUDA-BOSolver")
!966 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !967, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!967 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !957)
!968 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !957, file: !853, line: 984, type: !969, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!969 = !DISubroutineType(types: !970)
!970 = !{!971, !966}
!971 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !963, size: 64)
!972 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !957, file: !853, line: 992, type: !969, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!973 = !{!974, !911, !975, !975}
!974 = !DITemplateTypeParameter(name: "_Tp", type: !964)
!975 = !DITemplateValueParameter(type: !378, value: i1 false)
!976 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !954, file: !853, line: 1402, baseType: !977, size: 64)
!977 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !978, size: 64)
!978 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !954, file: !853, line: 1056, baseType: !979)
!979 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !980, file: !764, line: 1982, baseType: !964)
!980 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::ClassType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !981, identifier: "_ZTSSt13remove_extentIN3c109ClassTypeEE")
!981 = !{!974}
!982 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !954, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!983 = !DISubprogram(name: "__shared_ptr", scope: !954, file: !853, line: 1092, type: !984, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!984 = !DISubroutineType(types: !985)
!985 = !{null, !986}
!986 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !954, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!987 = !DISubprogram(name: "__shared_ptr", scope: !954, file: !853, line: 1152, type: !988, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!988 = !DISubroutineType(types: !989)
!989 = !{null, !986, !990}
!990 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !991, size: 64)
!991 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !954)
!992 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !954, file: !853, line: 1153, type: !993, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!993 = !DISubroutineType(types: !994)
!994 = !{!995, !986, !990}
!995 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !954, size: 64)
!996 = !DISubprogram(name: "~__shared_ptr", scope: !954, file: !853, line: 1154, type: !984, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!997 = !DISubprogram(name: "__shared_ptr", scope: !954, file: !853, line: 1161, type: !998, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!998 = !DISubroutineType(types: !999)
!999 = !{null, !986, !1000}
!1000 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !954, size: 64)
!1001 = !DISubprogram(name: "__shared_ptr", scope: !954, file: !853, line: 1223, type: !1002, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1002 = !DISubroutineType(types: !1003)
!1003 = !{null, !986, !1004}
!1004 = !DIDerivedType(tag: DW_TAG_typedef, name: "nullptr_t", scope: !2, file: !1005, line: 284, baseType: !1006)
!1005 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/x86_64-linux-gnu/c++/11/bits/c++config.h", directory: "")
!1006 = !DIBasicType(tag: DW_TAG_unspecified_type, name: "decltype(nullptr)")
!1007 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !954, file: !853, line: 1248, type: !1008, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1008 = !DISubroutineType(types: !1009)
!1009 = !{!995, !986, !1000}
!1010 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !954, file: !853, line: 1271, type: !984, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1011 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !954, file: !853, line: 1295, type: !1012, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1012 = !DISubroutineType(types: !1013)
!1013 = !{!977, !1014}
!1014 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !991, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1015 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !954, file: !853, line: 1299, type: !1016, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!1016 = !DISubroutineType(types: !1017)
!1017 = !{!378, !1014}
!1018 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !954, file: !853, line: 1304, type: !1016, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1019 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !954, file: !853, line: 1309, type: !1020, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1020 = !DISubroutineType(types: !1021)
!1021 = !{!575, !1014}
!1022 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !954, file: !853, line: 1314, type: !1023, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1023 = !DISubroutineType(types: !1024)
!1024 = !{null, !986, !995}
!1025 = !DISubprogram(name: "__shared_ptr", scope: !954, file: !853, line: 1352, type: !1026, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!1026 = !DISubroutineType(types: !1027)
!1027 = !{null, !986, !1028, !915}
!1028 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1029, size: 64)
!1029 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1030)
!1030 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::ClassType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1591, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1031, templateParams: !1073, identifier: "_ZTSSt10__weak_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE")
!1031 = !{!1032, !1035, !1036, !1040, !1043, !1044, !1048, !1052, !1055, !1059, !1062, !1065, !1066, !1069}
!1032 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !1030, file: !853, line: 1733, baseType: !1033, size: 64)
!1033 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1034, size: 64)
!1034 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1030, file: !853, line: 1602, baseType: !979)
!1035 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !1030, file: !853, line: 1734, baseType: !867, size: 64, offset: 64)
!1036 = !DISubprogram(name: "__weak_ptr", scope: !1030, file: !853, line: 1604, type: !1037, scopeLine: 1604, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1037 = !DISubroutineType(types: !1038)
!1038 = !{null, !1039}
!1039 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1030, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1040 = !DISubprogram(name: "__weak_ptr", scope: !1030, file: !853, line: 1608, type: !1041, scopeLine: 1608, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1041 = !DISubroutineType(types: !1042)
!1042 = !{null, !1039, !1028}
!1043 = !DISubprogram(name: "~__weak_ptr", scope: !1030, file: !853, line: 1610, type: !1037, scopeLine: 1610, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1044 = !DISubprogram(name: "__weak_ptr", scope: !1030, file: !853, line: 1636, type: !1045, scopeLine: 1636, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1045 = !DISubroutineType(types: !1046)
!1046 = !{null, !1039, !1047}
!1047 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1030, size: 64)
!1048 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10__weak_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !1030, file: !853, line: 1646, type: !1049, scopeLine: 1646, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1049 = !DISubroutineType(types: !1050)
!1050 = !{!1051, !1039, !1028}
!1051 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1030, size: 64)
!1052 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10__weak_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !1030, file: !853, line: 1667, type: !1053, scopeLine: 1667, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1053 = !DISubroutineType(types: !1054)
!1054 = !{!1051, !1039, !1047}
!1055 = !DISubprogram(name: "lock", linkageName: "_ZNKSt10__weak_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE4lockEv", scope: !1030, file: !853, line: 1684, type: !1056, scopeLine: 1684, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1056 = !DISubroutineType(types: !1057)
!1057 = !{!954, !1058}
!1058 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1029, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1059 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt10__weak_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !1030, file: !853, line: 1688, type: !1060, scopeLine: 1688, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1060 = !DISubroutineType(types: !1061)
!1061 = !{!575, !1058}
!1062 = !DISubprogram(name: "expired", linkageName: "_ZNKSt10__weak_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE7expiredEv", scope: !1030, file: !853, line: 1692, type: !1063, scopeLine: 1692, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1063 = !DISubroutineType(types: !1064)
!1064 = !{!378, !1058}
!1065 = !DISubprogram(name: "reset", linkageName: "_ZNSt10__weak_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !1030, file: !853, line: 1706, type: !1037, scopeLine: 1706, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1066 = !DISubprogram(name: "swap", linkageName: "_ZNSt10__weak_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !1030, file: !853, line: 1710, type: !1067, scopeLine: 1710, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1067 = !DISubroutineType(types: !1068)
!1068 = !{null, !1039, !1051}
!1069 = !DISubprogram(name: "_M_assign", linkageName: "_ZNSt10__weak_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE9_M_assignEPS1_RKSt14__shared_countILS3_2EE", scope: !1030, file: !853, line: 1719, type: !1070, scopeLine: 1719, flags: DIFlagPrototyped, spFlags: 0)
!1070 = !DISubroutineType(types: !1071)
!1071 = !{null, !1039, !1072, !877}
!1072 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !964, size: 64)
!1073 = !{!974, !911}
!1074 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c109ClassTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !954, file: !853, line: 1390, type: !1075, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!1075 = !DISubroutineType(types: !1076)
!1076 = !{!943, !1014, !944}
!1077 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::ClassType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1079, templateParams: !981, identifier: "_ZTSSt10shared_ptrIN3c109ClassTypeEE")
!1078 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/shared_ptr.h", directory: "")
!1079 = !{!1080, !1081, !1085, !1090, !1094, !1097, !1101, !1104}
!1080 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1077, baseType: !954, flags: DIFlagPublic, extraData: i32 0)
!1081 = !DISubprogram(name: "shared_ptr", scope: !1077, file: !1078, line: 148, type: !1082, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1082 = !DISubroutineType(types: !1083)
!1083 = !{null, !1084}
!1084 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1077, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1085 = !DISubprogram(name: "shared_ptr", scope: !1077, file: !1078, line: 150, type: !1086, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1086 = !DISubroutineType(types: !1087)
!1087 = !{null, !1084, !1088}
!1088 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1089, size: 64)
!1089 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1077)
!1090 = !DISubprogram(name: "shared_ptr", scope: !1077, file: !1078, line: 304, type: !1091, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1091 = !DISubroutineType(types: !1092)
!1092 = !{null, !1084, !1093}
!1093 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1077, size: 64)
!1094 = !DISubprogram(name: "shared_ptr", scope: !1077, file: !1078, line: 357, type: !1095, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1095 = !DISubroutineType(types: !1096)
!1096 = !{null, !1084, !1004}
!1097 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c109ClassTypeEEaSERKS2_", scope: !1077, file: !1078, line: 359, type: !1098, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1098 = !DISubroutineType(types: !1099)
!1099 = !{!1100, !1084, !1088}
!1100 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1077, size: 64)
!1101 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c109ClassTypeEEaSEOS2_", scope: !1077, file: !1078, line: 383, type: !1102, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1102 = !DISubroutineType(types: !1103)
!1103 = !{!1100, !1084, !1093}
!1104 = !DISubprogram(name: "shared_ptr", scope: !1077, file: !1078, line: 417, type: !1105, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!1105 = !DISubroutineType(types: !1106)
!1106 = !{null, !1084, !1107, !915}
!1107 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1108, size: 64)
!1108 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1109)
!1109 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::ClassType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c109ClassTypeEE")
!1110 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "_Storage<c10::DeviceType, true>", scope: !1111, file: !249, line: 198, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1158, templateParams: !1166, identifier: "_ZTSNSt22_Optional_payload_baseIN3c1010DeviceTypeEE8_StorageIS1_Lb1EEE")
!1111 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Optional_payload_base<c10::DeviceType>", scope: !2, file: !249, line: 107, size: 16, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1112, templateParams: !1156, identifier: "_ZTSSt22_Optional_payload_baseIN3c1010DeviceTypeEE")
!1112 = !{!1113, !1114, !1115, !1119, !1120, !1125, !1129, !1132, !1135, !1139, !1142, !1143, !1144, !1145, !1149, !1155}
!1113 = !DIDerivedType(tag: DW_TAG_member, name: "_M_payload", scope: !1111, file: !249, line: 242, baseType: !1110, size: 8)
!1114 = !DIDerivedType(tag: DW_TAG_member, name: "_M_engaged", scope: !1111, file: !249, line: 244, baseType: !378, size: 8, offset: 8)
!1115 = !DISubprogram(name: "_Optional_payload_base", scope: !1111, file: !249, line: 111, type: !1116, scopeLine: 111, flags: DIFlagPrototyped, spFlags: 0)
!1116 = !DISubroutineType(types: !1117)
!1117 = !{null, !1118}
!1118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1111, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1119 = !DISubprogram(name: "~_Optional_payload_base", scope: !1111, file: !249, line: 112, type: !1116, scopeLine: 112, flags: DIFlagPrototyped, spFlags: 0)
!1120 = !DISubprogram(name: "_Optional_payload_base", scope: !1111, file: !249, line: 132, type: !1121, scopeLine: 132, flags: DIFlagPrototyped, spFlags: 0)
!1121 = !DISubroutineType(types: !1122)
!1122 = !{null, !1118, !378, !1123}
!1123 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1124, size: 64)
!1124 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1111)
!1125 = !DISubprogram(name: "_Optional_payload_base", scope: !1111, file: !249, line: 142, type: !1126, scopeLine: 142, flags: DIFlagPrototyped, spFlags: 0)
!1126 = !DISubroutineType(types: !1127)
!1127 = !{null, !1118, !378, !1128}
!1128 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1111, size: 64)
!1129 = !DISubprogram(name: "_Optional_payload_base", scope: !1111, file: !249, line: 151, type: !1130, scopeLine: 151, flags: DIFlagPrototyped, spFlags: 0)
!1130 = !DISubroutineType(types: !1131)
!1131 = !{null, !1118, !1123}
!1132 = !DISubprogram(name: "_Optional_payload_base", scope: !1111, file: !249, line: 155, type: !1133, scopeLine: 155, flags: DIFlagPrototyped, spFlags: 0)
!1133 = !DISubroutineType(types: !1134)
!1134 = !{null, !1118, !1128}
!1135 = !DISubprogram(name: "operator=", linkageName: "_ZNSt22_Optional_payload_baseIN3c1010DeviceTypeEEaSERKS2_", scope: !1111, file: !249, line: 158, type: !1136, scopeLine: 158, flags: DIFlagPrototyped, spFlags: 0)
!1136 = !DISubroutineType(types: !1137)
!1137 = !{!1138, !1118, !1123}
!1138 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1111, size: 64)
!1139 = !DISubprogram(name: "operator=", linkageName: "_ZNSt22_Optional_payload_baseIN3c1010DeviceTypeEEaSEOS2_", scope: !1111, file: !249, line: 161, type: !1140, scopeLine: 161, flags: DIFlagPrototyped, spFlags: 0)
!1140 = !DISubroutineType(types: !1141)
!1141 = !{!1138, !1118, !1128}
!1142 = !DISubprogram(name: "_M_copy_assign", linkageName: "_ZNSt22_Optional_payload_baseIN3c1010DeviceTypeEE14_M_copy_assignERKS2_", scope: !1111, file: !249, line: 165, type: !1130, scopeLine: 165, flags: DIFlagPrototyped, spFlags: 0)
!1143 = !DISubprogram(name: "_M_move_assign", linkageName: "_ZNSt22_Optional_payload_baseIN3c1010DeviceTypeEE14_M_move_assignEOS2_", scope: !1111, file: !249, line: 180, type: !1133, scopeLine: 180, flags: DIFlagPrototyped, spFlags: 0)
!1144 = !DISubprogram(name: "_M_destroy", linkageName: "_ZNSt22_Optional_payload_baseIN3c1010DeviceTypeEE10_M_destroyEv", scope: !1111, file: !249, line: 257, type: !1116, scopeLine: 257, flags: DIFlagPrototyped, spFlags: 0)
!1145 = !DISubprogram(name: "_M_get", linkageName: "_ZNSt22_Optional_payload_baseIN3c1010DeviceTypeEE6_M_getEv", scope: !1111, file: !249, line: 268, type: !1146, scopeLine: 268, flags: DIFlagPrototyped, spFlags: 0)
!1146 = !DISubroutineType(types: !1147)
!1147 = !{!1148, !1118}
!1148 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !34, size: 64)
!1149 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt22_Optional_payload_baseIN3c1010DeviceTypeEE6_M_getEv", scope: !1111, file: !249, line: 272, type: !1150, scopeLine: 272, flags: DIFlagPrototyped, spFlags: 0)
!1150 = !DISubroutineType(types: !1151)
!1151 = !{!1152, !1154}
!1152 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1153, size: 64)
!1153 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !34)
!1154 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1124, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1155 = !DISubprogram(name: "_M_reset", linkageName: "_ZNSt22_Optional_payload_baseIN3c1010DeviceTypeEE8_M_resetEv", scope: !1111, file: !249, line: 277, type: !1116, scopeLine: 277, flags: DIFlagPrototyped, spFlags: 0)
!1156 = !{!1157}
!1157 = !DITemplateTypeParameter(name: "_Tp", type: !34)
!1158 = !{!1159, !1161, !1162}
!1159 = !DIDerivedType(tag: DW_TAG_member, name: "_M_empty", scope: !1110, file: !249, line: 214, baseType: !1160, size: 8)
!1160 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Empty_byte", scope: !1111, file: !249, line: 195, size: 8, flags: DIFlagTypePassByValue, elements: !843, identifier: "_ZTSNSt22_Optional_payload_baseIN3c1010DeviceTypeEE11_Empty_byteE")
!1161 = !DIDerivedType(tag: DW_TAG_member, name: "_M_value", scope: !1110, file: !249, line: 215, baseType: !34, size: 8)
!1162 = !DISubprogram(name: "_Storage", scope: !1110, file: !249, line: 200, type: !1163, scopeLine: 200, flags: DIFlagPrototyped, spFlags: 0)
!1163 = !DISubroutineType(types: !1164)
!1164 = !{null, !1165}
!1165 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1110, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1166 = !{!1167, !1168}
!1167 = !DITemplateTypeParameter(name: "_Up", type: !34)
!1168 = !DITemplateValueParameter(type: !378, value: i1 true)
!1169 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Optional_payload<c10::DeviceType, true, true, true>", scope: !2, file: !249, line: 298, size: 16, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1170, templateParams: !1176, identifier: "_ZTSSt17_Optional_payloadIN3c1010DeviceTypeELb1ELb1ELb1EE")
!1170 = !{!1171, !1172}
!1171 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1169, baseType: !1111, extraData: i32 0)
!1172 = !DISubprogram(name: "_Optional_payload", scope: !1169, file: !249, line: 303, type: !1173, scopeLine: 303, flags: DIFlagPrototyped, spFlags: 0)
!1173 = !DISubroutineType(types: !1174)
!1174 = !{null, !1175}
!1175 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1169, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1176 = !{!1157, !1168, !1168, !1168}
!1177 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Optional_base<c10::DeviceType, true, true>", scope: !2, file: !249, line: 601, size: 16, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1178, templateParams: !1221, identifier: "_ZTSSt14_Optional_baseIN3c1010DeviceTypeELb1ELb1EE")
!1178 = !{!1179, !1200, !1201, !1205, !1210, !1214, !1218}
!1179 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1177, baseType: !1180, extraData: i32 0)
!1180 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "_Optional_base_impl<c10::DeviceType, std::_Optional_base<c10::DeviceType, true, true> >", scope: !2, file: !249, line: 407, size: 8, flags: DIFlagTypePassByValue, elements: !1181, templateParams: !1198, identifier: "_ZTSSt19_Optional_base_implIN3c1010DeviceTypeESt14_Optional_baseIS1_Lb1ELb1EEE")
!1181 = !{!1182, !1186, !1187, !1192, !1195}
!1182 = !DISubprogram(name: "_M_destruct", linkageName: "_ZNSt19_Optional_base_implIN3c1010DeviceTypeESt14_Optional_baseIS1_Lb1ELb1EEE11_M_destructEv", scope: !1180, file: !249, line: 424, type: !1183, scopeLine: 424, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!1183 = !DISubroutineType(types: !1184)
!1184 = !{null, !1185}
!1185 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1180, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1186 = !DISubprogram(name: "_M_reset", linkageName: "_ZNSt19_Optional_base_implIN3c1010DeviceTypeESt14_Optional_baseIS1_Lb1ELb1EEE8_M_resetEv", scope: !1180, file: !249, line: 429, type: !1183, scopeLine: 429, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!1187 = !DISubprogram(name: "_M_is_engaged", linkageName: "_ZNKSt19_Optional_base_implIN3c1010DeviceTypeESt14_Optional_baseIS1_Lb1ELb1EEE13_M_is_engagedEv", scope: !1180, file: !249, line: 432, type: !1188, scopeLine: 432, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!1188 = !DISubroutineType(types: !1189)
!1189 = !{!378, !1190}
!1190 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1191, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1191 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1180)
!1192 = !DISubprogram(name: "_M_get", linkageName: "_ZNSt19_Optional_base_implIN3c1010DeviceTypeESt14_Optional_baseIS1_Lb1ELb1EEE6_M_getEv", scope: !1180, file: !249, line: 437, type: !1193, scopeLine: 437, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!1193 = !DISubroutineType(types: !1194)
!1194 = !{!1148, !1185}
!1195 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19_Optional_base_implIN3c1010DeviceTypeESt14_Optional_baseIS1_Lb1ELb1EEE6_M_getEv", scope: !1180, file: !249, line: 444, type: !1196, scopeLine: 444, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!1196 = !DISubroutineType(types: !1197)
!1197 = !{!1152, !1190}
!1198 = !{!1157, !1199}
!1199 = !DITemplateTypeParameter(name: "_Dp", type: !1177)
!1200 = !DIDerivedType(tag: DW_TAG_member, name: "_M_payload", scope: !1177, file: !249, line: 634, baseType: !1169, size: 16)
!1201 = !DISubprogram(name: "_Optional_base", scope: !1177, file: !249, line: 605, type: !1202, scopeLine: 605, flags: DIFlagPrototyped, spFlags: 0)
!1202 = !DISubroutineType(types: !1203)
!1203 = !{null, !1204}
!1204 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1177, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1205 = !DISubprogram(name: "_Optional_base", scope: !1177, file: !249, line: 627, type: !1206, scopeLine: 627, flags: DIFlagPrototyped, spFlags: 0)
!1206 = !DISubroutineType(types: !1207)
!1207 = !{null, !1204, !1208}
!1208 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1209, size: 64)
!1209 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1177)
!1210 = !DISubprogram(name: "_Optional_base", scope: !1177, file: !249, line: 628, type: !1211, scopeLine: 628, flags: DIFlagPrototyped, spFlags: 0)
!1211 = !DISubroutineType(types: !1212)
!1212 = !{null, !1204, !1213}
!1213 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1177, size: 64)
!1214 = !DISubprogram(name: "operator=", linkageName: "_ZNSt14_Optional_baseIN3c1010DeviceTypeELb1ELb1EEaSERKS2_", scope: !1177, file: !249, line: 631, type: !1215, scopeLine: 631, flags: DIFlagPrototyped, spFlags: 0)
!1215 = !DISubroutineType(types: !1216)
!1216 = !{!1217, !1204, !1208}
!1217 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1177, size: 64)
!1218 = !DISubprogram(name: "operator=", linkageName: "_ZNSt14_Optional_baseIN3c1010DeviceTypeELb1ELb1EEaSEOS2_", scope: !1177, file: !249, line: 632, type: !1219, scopeLine: 632, flags: DIFlagPrototyped, spFlags: 0)
!1219 = !DISubroutineType(types: !1220)
!1220 = !{!1217, !1204, !1213}
!1221 = !{!1157, !1168, !1168}
!1222 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "optional<c10::DeviceType>", scope: !2, file: !249, line: 662, size: 16, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1223, templateParams: !1156, identifier: "_ZTSSt8optionalIN3c1010DeviceTypeEE")
!1223 = !{!1224, !1225, !1234, !1238, !1241, !1245, !1248, !1254, !1258, !1261, !1264, !1268, !1272, !1275, !1276, !1277, !1278, !1279, !1280}
!1224 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1222, baseType: !1177, extraData: i32 0)
!1225 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1222, baseType: !1226, extraData: i32 0)
!1226 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Enable_copy_move<true, true, true, true, std::optional<c10::DeviceType> >", scope: !2, file: !1227, line: 87, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !1228, identifier: "_ZTSSt17_Enable_copy_moveILb1ELb1ELb1ELb1ESt8optionalIN3c1010DeviceTypeEEE")
!1227 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/enable_special_members.h", directory: "")
!1228 = !{!1229, !1230, !1231, !1232, !1233}
!1229 = !DITemplateValueParameter(name: "_Copy", type: !378, value: i1 true)
!1230 = !DITemplateValueParameter(name: "_CopyAssignment", type: !378, value: i1 true)
!1231 = !DITemplateValueParameter(name: "_Move", type: !378, value: i1 true)
!1232 = !DITemplateValueParameter(name: "_MoveAssignment", type: !378, value: i1 true)
!1233 = !DITemplateTypeParameter(name: "_Tag", type: !1222)
!1234 = !DISubprogram(name: "optional", scope: !1222, file: !249, line: 694, type: !1235, scopeLine: 694, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1235 = !DISubroutineType(types: !1236)
!1236 = !{null, !1237}
!1237 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1222, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1238 = !DISubprogram(name: "optional", scope: !1222, file: !249, line: 696, type: !1239, scopeLine: 696, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1239 = !DISubroutineType(types: !1240)
!1240 = !{null, !1237, !250}
!1241 = !DISubprogram(name: "operator=", linkageName: "_ZNSt8optionalIN3c1010DeviceTypeEEaSESt9nullopt_t", scope: !1222, file: !249, line: 789, type: !1242, scopeLine: 789, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1242 = !DISubroutineType(types: !1243)
!1243 = !{!1244, !1237, !250}
!1244 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1222, size: 64)
!1245 = !DISubprogram(name: "swap", linkageName: "_ZNSt8optionalIN3c1010DeviceTypeEE4swapERS2_", scope: !1222, file: !249, line: 896, type: !1246, scopeLine: 896, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1246 = !DISubroutineType(types: !1247)
!1247 = !{null, !1237, !1244}
!1248 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt8optionalIN3c1010DeviceTypeEEptEv", scope: !1222, file: !249, line: 918, type: !1249, scopeLine: 918, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1249 = !DISubroutineType(types: !1250)
!1250 = !{!1251, !1252}
!1251 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1153, size: 64)
!1252 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1253, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1253 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1222)
!1254 = !DISubprogram(name: "operator->", linkageName: "_ZNSt8optionalIN3c1010DeviceTypeEEptEv", scope: !1222, file: !249, line: 922, type: !1255, scopeLine: 922, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1255 = !DISubroutineType(types: !1256)
!1256 = !{!1257, !1237}
!1257 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!1258 = !DISubprogram(name: "operator*", linkageName: "_ZNKRSt8optionalIN3c1010DeviceTypeEEdeEv", scope: !1222, file: !249, line: 926, type: !1259, scopeLine: 926, flags: DIFlagPublic | DIFlagPrototyped | DIFlagLValueReference, spFlags: 0)
!1259 = !DISubroutineType(flags: DIFlagLValueReference, types: !1260)
!1260 = !{!1152, !1252}
!1261 = !DISubprogram(name: "operator*", linkageName: "_ZNRSt8optionalIN3c1010DeviceTypeEEdeEv", scope: !1222, file: !249, line: 930, type: !1262, scopeLine: 930, flags: DIFlagPublic | DIFlagPrototyped | DIFlagLValueReference, spFlags: 0)
!1262 = !DISubroutineType(flags: DIFlagLValueReference, types: !1263)
!1263 = !{!1148, !1237}
!1264 = !DISubprogram(name: "operator*", linkageName: "_ZNOSt8optionalIN3c1010DeviceTypeEEdeEv", scope: !1222, file: !249, line: 934, type: !1265, scopeLine: 934, flags: DIFlagPublic | DIFlagPrototyped | DIFlagRValueReference, spFlags: 0)
!1265 = !DISubroutineType(flags: DIFlagRValueReference, types: !1266)
!1266 = !{!1267, !1237}
!1267 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !34, size: 64)
!1268 = !DISubprogram(name: "operator*", linkageName: "_ZNKOSt8optionalIN3c1010DeviceTypeEEdeEv", scope: !1222, file: !249, line: 938, type: !1269, scopeLine: 938, flags: DIFlagPublic | DIFlagPrototyped | DIFlagRValueReference, spFlags: 0)
!1269 = !DISubroutineType(flags: DIFlagRValueReference, types: !1270)
!1270 = !{!1271, !1252}
!1271 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1153, size: 64)
!1272 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt8optionalIN3c1010DeviceTypeEEcvbEv", scope: !1222, file: !249, line: 941, type: !1273, scopeLine: 941, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!1273 = !DISubroutineType(types: !1274)
!1274 = !{!378, !1252}
!1275 = !DISubprogram(name: "has_value", linkageName: "_ZNKSt8optionalIN3c1010DeviceTypeEE9has_valueEv", scope: !1222, file: !249, line: 944, type: !1273, scopeLine: 944, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1276 = !DISubprogram(name: "value", linkageName: "_ZNKRSt8optionalIN3c1010DeviceTypeEE5valueEv", scope: !1222, file: !249, line: 948, type: !1259, scopeLine: 948, flags: DIFlagPublic | DIFlagPrototyped | DIFlagLValueReference, spFlags: 0)
!1277 = !DISubprogram(name: "value", linkageName: "_ZNRSt8optionalIN3c1010DeviceTypeEE5valueEv", scope: !1222, file: !249, line: 956, type: !1262, scopeLine: 956, flags: DIFlagPublic | DIFlagPrototyped | DIFlagLValueReference, spFlags: 0)
!1278 = !DISubprogram(name: "value", linkageName: "_ZNOSt8optionalIN3c1010DeviceTypeEE5valueEv", scope: !1222, file: !249, line: 964, type: !1265, scopeLine: 964, flags: DIFlagPublic | DIFlagPrototyped | DIFlagRValueReference, spFlags: 0)
!1279 = !DISubprogram(name: "value", linkageName: "_ZNKOSt8optionalIN3c1010DeviceTypeEE5valueEv", scope: !1222, file: !249, line: 972, type: !1269, scopeLine: 972, flags: DIFlagPublic | DIFlagPrototyped | DIFlagRValueReference, spFlags: 0)
!1280 = !DISubprogram(name: "reset", linkageName: "_ZNSt8optionalIN3c1010DeviceTypeEE5resetEv", scope: !1222, file: !249, line: 1005, type: !1235, scopeLine: 1005, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1281 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "ArrayRef<c10::SymInt>", scope: !36, file: !1282, line: 45, size: 128, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1283, templateParams: !1393, identifier: "_ZTSN3c108ArrayRefINS_6SymIntEEE")
!1282 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/ArrayRef.h", directory: "/home/mvh6224/CUDA-BOSolver")
!1283 = !{!1284, !1286, !1291, !1295, !1296, !1299, !1302, !1305, !1336, !1342, !1343, !1347, !1348, !1354, !1355, !1362, !1365, !1368, !1371, !1374, !1375, !1378, !1381, !1384, !1387, !1388}
!1284 = !DIDerivedType(tag: DW_TAG_member, name: "Data", scope: !1281, file: !1282, line: 56, baseType: !1285, size: 64)
!1285 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !664, size: 64)
!1286 = !DIDerivedType(tag: DW_TAG_member, name: "Length", scope: !1281, file: !1282, line: 59, baseType: !1287, size: 64, offset: 64)
!1287 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_type", file: !1282, line: 49, baseType: !1288)
!1288 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !1289, line: 46, baseType: !1290)
!1289 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/stddef.h", directory: "")
!1290 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!1291 = !DISubprogram(name: "debugCheckNullptrInvariant", linkageName: "_ZN3c108ArrayRefINS_6SymIntEE26debugCheckNullptrInvariantEv", scope: !1281, file: !1282, line: 61, type: !1292, scopeLine: 61, flags: DIFlagPrototyped, spFlags: 0)
!1292 = !DISubroutineType(types: !1293)
!1293 = !{null, !1294}
!1294 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1281, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1295 = !DISubprogram(name: "ArrayRef", scope: !1281, file: !1282, line: 72, type: !1292, scopeLine: 72, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1296 = !DISubprogram(name: "ArrayRef", scope: !1281, file: !1282, line: 76, type: !1297, scopeLine: 76, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1297 = !DISubroutineType(types: !1298)
!1298 = !{null, !1294, !663}
!1299 = !DISubprogram(name: "ArrayRef", scope: !1281, file: !1282, line: 79, type: !1300, scopeLine: 79, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1300 = !DISubroutineType(types: !1301)
!1301 = !{null, !1294, !1285, !1288}
!1302 = !DISubprogram(name: "ArrayRef", scope: !1281, file: !1282, line: 85, type: !1303, scopeLine: 85, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1303 = !DISubroutineType(types: !1304)
!1304 = !{null, !1294, !1285, !1285}
!1305 = !DISubprogram(name: "ArrayRef", scope: !1281, file: !1282, line: 132, type: !1306, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1306 = !DISubroutineType(types: !1307)
!1307 = !{null, !1294, !1308}
!1308 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1309, size: 64)
!1309 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1310)
!1310 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "initializer_list<c10::SymInt>", scope: !2, file: !1311, line: 47, size: 128, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1312, templateParams: !1334, identifier: "_ZTSSt16initializer_listIN3c106SymIntEE")
!1311 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/initializer_list", directory: "")
!1312 = !{!1313, !1315, !1318, !1323, !1326, !1330, !1333}
!1313 = !DIDerivedType(tag: DW_TAG_member, name: "_M_array", scope: !1310, file: !1311, line: 58, baseType: !1314, size: 64)
!1314 = !DIDerivedType(tag: DW_TAG_typedef, name: "iterator", scope: !1310, file: !1311, line: 54, baseType: !1285)
!1315 = !DIDerivedType(tag: DW_TAG_member, name: "_M_len", scope: !1310, file: !1311, line: 59, baseType: !1316, size: 64, offset: 64)
!1316 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_type", file: !1311, line: 53, baseType: !1317)
!1317 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", scope: !2, file: !1005, line: 280, baseType: !1290)
!1318 = !DISubprogram(name: "initializer_list", scope: !1310, file: !1311, line: 62, type: !1319, scopeLine: 62, flags: DIFlagPrototyped, spFlags: 0)
!1319 = !DISubroutineType(types: !1320)
!1320 = !{null, !1321, !1322, !1316}
!1321 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1310, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1322 = !DIDerivedType(tag: DW_TAG_typedef, name: "const_iterator", scope: !1310, file: !1311, line: 55, baseType: !1285)
!1323 = !DISubprogram(name: "initializer_list", scope: !1310, file: !1311, line: 66, type: !1324, scopeLine: 66, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1324 = !DISubroutineType(types: !1325)
!1325 = !{null, !1321}
!1326 = !DISubprogram(name: "size", linkageName: "_ZNKSt16initializer_listIN3c106SymIntEE4sizeEv", scope: !1310, file: !1311, line: 71, type: !1327, scopeLine: 71, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1327 = !DISubroutineType(types: !1328)
!1328 = !{!1316, !1329}
!1329 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1309, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1330 = !DISubprogram(name: "begin", linkageName: "_ZNKSt16initializer_listIN3c106SymIntEE5beginEv", scope: !1310, file: !1311, line: 75, type: !1331, scopeLine: 75, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1331 = !DISubroutineType(types: !1332)
!1332 = !{!1322, !1329}
!1333 = !DISubprogram(name: "end", linkageName: "_ZNKSt16initializer_listIN3c106SymIntEE3endEv", scope: !1310, file: !1311, line: 79, type: !1331, scopeLine: 79, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1334 = !{!1335}
!1335 = !DITemplateTypeParameter(name: "_E", type: !375)
!1336 = !DISubprogram(name: "begin", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE5beginEv", scope: !1281, file: !1282, line: 142, type: !1337, scopeLine: 142, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1337 = !DISubroutineType(types: !1338)
!1338 = !{!1339, !1340}
!1339 = !DIDerivedType(tag: DW_TAG_typedef, name: "iterator", scope: !1281, file: !1282, line: 47, baseType: !1285)
!1340 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1341, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1341 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1281)
!1342 = !DISubprogram(name: "end", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE3endEv", scope: !1281, file: !1282, line: 145, type: !1337, scopeLine: 145, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1343 = !DISubprogram(name: "cbegin", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE6cbeginEv", scope: !1281, file: !1282, line: 151, type: !1344, scopeLine: 151, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1344 = !DISubroutineType(types: !1345)
!1345 = !{!1346, !1340}
!1346 = !DIDerivedType(tag: DW_TAG_typedef, name: "const_iterator", scope: !1281, file: !1282, line: 48, baseType: !1285)
!1347 = !DISubprogram(name: "cend", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE4cendEv", scope: !1281, file: !1282, line: 154, type: !1344, scopeLine: 154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1348 = !DISubprogram(name: "rbegin", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE6rbeginEv", scope: !1281, file: !1282, line: 158, type: !1349, scopeLine: 158, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1349 = !DISubroutineType(types: !1350)
!1350 = !{!1351, !1340}
!1351 = !DIDerivedType(tag: DW_TAG_typedef, name: "reverse_iterator", scope: !1281, file: !1282, line: 52, baseType: !1352)
!1352 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "reverse_iterator<const c10::SymInt *>", scope: !2, file: !1353, line: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt16reverse_iteratorIPKN3c106SymIntEE")
!1353 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/stl_iterator.h", directory: "")
!1354 = !DISubprogram(name: "rend", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE4rendEv", scope: !1281, file: !1282, line: 161, type: !1349, scopeLine: 161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1355 = !DISubprogram(name: "allMatch", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE8allMatchERKSt8functionIFbRKS1_EE", scope: !1281, file: !1282, line: 166, type: !1356, scopeLine: 166, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1356 = !DISubroutineType(types: !1357)
!1357 = !{!378, !1340, !1358}
!1358 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1359, size: 64)
!1359 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1360)
!1360 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "function<bool (const c10::SymInt &)>", scope: !2, file: !1361, line: 111, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8functionIFbRKN3c106SymIntEEE")
!1361 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/std_function.h", directory: "")
!1362 = !DISubprogram(name: "empty", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE5emptyEv", scope: !1281, file: !1282, line: 171, type: !1363, scopeLine: 171, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1363 = !DISubroutineType(types: !1364)
!1364 = !{!378, !1340}
!1365 = !DISubprogram(name: "data", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE4dataEv", scope: !1281, file: !1282, line: 175, type: !1366, scopeLine: 175, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1366 = !DISubroutineType(types: !1367)
!1367 = !{!1285, !1340}
!1368 = !DISubprogram(name: "size", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE4sizeEv", scope: !1281, file: !1282, line: 180, type: !1369, scopeLine: 180, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1369 = !DISubroutineType(types: !1370)
!1370 = !{!1288, !1340}
!1371 = !DISubprogram(name: "front", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE5frontEv", scope: !1281, file: !1282, line: 185, type: !1372, scopeLine: 185, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1372 = !DISubroutineType(types: !1373)
!1373 = !{!663, !1340}
!1374 = !DISubprogram(name: "back", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE4backEv", scope: !1281, file: !1282, line: 192, type: !1372, scopeLine: 192, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1375 = !DISubprogram(name: "equals", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE6equalsES2_", scope: !1281, file: !1282, line: 198, type: !1376, scopeLine: 198, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1376 = !DISubroutineType(types: !1377)
!1377 = !{!378, !1340, !1281}
!1378 = !DISubprogram(name: "slice", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE5sliceEmm", scope: !1281, file: !1282, line: 203, type: !1379, scopeLine: 203, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1379 = !DISubroutineType(types: !1380)
!1380 = !{!1281, !1340, !1288, !1288}
!1381 = !DISubprogram(name: "slice", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE5sliceEm", scope: !1281, file: !1282, line: 216, type: !1382, scopeLine: 216, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1382 = !DISubroutineType(types: !1383)
!1383 = !{!1281, !1340, !1288}
!1384 = !DISubprogram(name: "operator[]", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEEixEm", scope: !1281, file: !1282, line: 225, type: !1385, scopeLine: 225, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1385 = !DISubroutineType(types: !1386)
!1386 = !{!663, !1340, !1288}
!1387 = !DISubprogram(name: "at", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE2atEm", scope: !1281, file: !1282, line: 230, type: !1385, scopeLine: 230, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1388 = !DISubprogram(name: "vec", linkageName: "_ZNK3c108ArrayRefINS_6SymIntEE3vecEv", scope: !1281, file: !1282, line: 260, type: !1389, scopeLine: 260, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1389 = !DISubroutineType(types: !1390)
!1390 = !{!1391, !1340}
!1391 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "vector<c10::SymInt, std::allocator<c10::SymInt> >", scope: !2, file: !1392, line: 389, size: 192, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt6vectorIN3c106SymIntESaIS1_EE")
!1392 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/stl_vector.h", directory: "")
!1393 = !{!1394}
!1394 = !DITemplateTypeParameter(name: "T", type: !375)
!1395 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Symbol", scope: !36, file: !1396, line: 53, size: 32, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !1397, identifier: "_ZTSN3c106SymbolE")
!1396 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/symbol.h", directory: "/home/mvh6224/CUDA-BOSolver")
!1397 = !{!1398, !1400, !1404, !1407, !1417, !1420, !1421, !1422, !1423, !1424, !1425, !1426, !1427, !1428, !1429, !1434, !1435, !1436, !1437, !1438, !1439, !1440, !1441, !1442, !1443, !1446, !1449, !1454, !1455, !1456, !1459}
!1398 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !1395, file: !1396, line: 120, baseType: !1399, size: 32, flags: DIFlagPrivate)
!1399 = !DIDerivedType(tag: DW_TAG_typedef, name: "unique_t", scope: !36, file: !1396, line: 46, baseType: !732)
!1400 = !DISubprogram(name: "Symbol", scope: !1395, file: !1396, line: 54, type: !1401, scopeLine: 54, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!1401 = !DISubroutineType(types: !1402)
!1402 = !{null, !1403}
!1403 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1395, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1404 = !DISubprogram(name: "Symbol", scope: !1395, file: !1396, line: 55, type: !1405, scopeLine: 55, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!1405 = !DISubroutineType(types: !1406)
!1406 = !{null, !1403, !1399}
!1407 = !DISubprogram(name: "fromQualString", linkageName: "_ZN3c106Symbol14fromQualStringERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !1395, file: !1396, line: 59, type: !1408, scopeLine: 59, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1408 = !DISubroutineType(types: !1409)
!1409 = !{!1395, !1410}
!1410 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1411, size: 64)
!1411 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1412)
!1412 = !DIDerivedType(tag: DW_TAG_typedef, name: "string", scope: !2, file: !1413, line: 79, baseType: !1414)
!1413 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/stringfwd.h", directory: "")
!1414 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "basic_string<char, std::char_traits<char>, std::allocator<char> >", scope: !1416, file: !1415, line: 1627, size: 256, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE")
!1415 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/basic_string.tcc", directory: "")
!1416 = !DINamespace(name: "__cxx11", scope: !2, exportSymbols: true)
!1417 = !DISubprogram(name: "fromDomainAndUnqualString", linkageName: "_ZN3c106Symbol25fromDomainAndUnqualStringERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_", scope: !1395, file: !1396, line: 62, type: !1418, scopeLine: 62, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1418 = !DISubroutineType(types: !1419)
!1419 = !{!1395, !1410, !1410}
!1420 = !DISubprogram(name: "attr", linkageName: "_ZN3c106Symbol4attrERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !1395, file: !1396, line: 69, type: !1408, scopeLine: 69, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1421 = !DISubprogram(name: "aten", linkageName: "_ZN3c106Symbol4atenERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !1395, file: !1396, line: 70, type: !1408, scopeLine: 70, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1422 = !DISubprogram(name: "cuda", linkageName: "_ZN3c106Symbol4cudaERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !1395, file: !1396, line: 71, type: !1408, scopeLine: 71, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1423 = !DISubprogram(name: "onnx", linkageName: "_ZN3c106Symbol4onnxERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !1395, file: !1396, line: 72, type: !1408, scopeLine: 72, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1424 = !DISubprogram(name: "prim", linkageName: "_ZN3c106Symbol4primERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !1395, file: !1396, line: 73, type: !1408, scopeLine: 73, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1425 = !DISubprogram(name: "user", linkageName: "_ZN3c106Symbol4userERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !1395, file: !1396, line: 74, type: !1408, scopeLine: 74, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1426 = !DISubprogram(name: "caffe2", linkageName: "_ZN3c106Symbol6caffe2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !1395, file: !1396, line: 75, type: !1408, scopeLine: 75, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1427 = !DISubprogram(name: "dimname", linkageName: "_ZN3c106Symbol7dimnameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !1395, file: !1396, line: 76, type: !1408, scopeLine: 76, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1428 = !DISubprogram(name: "scope", linkageName: "_ZN3c106Symbol5scopeERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !1395, file: !1396, line: 78, type: !1408, scopeLine: 78, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!1429 = !DISubprogram(name: "is_attr", linkageName: "_ZNK3c106Symbol7is_attrEv", scope: !1395, file: !1396, line: 80, type: !1430, scopeLine: 80, flags: DIFlagPrototyped, spFlags: 0)
!1430 = !DISubroutineType(types: !1431)
!1431 = !{!378, !1432}
!1432 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1433, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1433 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1395)
!1434 = !DISubprogram(name: "is_aten", linkageName: "_ZNK3c106Symbol7is_atenEv", scope: !1395, file: !1396, line: 81, type: !1430, scopeLine: 81, flags: DIFlagPrototyped, spFlags: 0)
!1435 = !DISubprogram(name: "is_cuda", linkageName: "_ZNK3c106Symbol7is_cudaEv", scope: !1395, file: !1396, line: 82, type: !1430, scopeLine: 82, flags: DIFlagPrototyped, spFlags: 0)
!1436 = !DISubprogram(name: "is_prim", linkageName: "_ZNK3c106Symbol7is_primEv", scope: !1395, file: !1396, line: 83, type: !1430, scopeLine: 83, flags: DIFlagPrototyped, spFlags: 0)
!1437 = !DISubprogram(name: "is_prims", linkageName: "_ZNK3c106Symbol8is_primsEv", scope: !1395, file: !1396, line: 84, type: !1430, scopeLine: 84, flags: DIFlagPrototyped, spFlags: 0)
!1438 = !DISubprogram(name: "is_nvprims", linkageName: "_ZNK3c106Symbol10is_nvprimsEv", scope: !1395, file: !1396, line: 85, type: !1430, scopeLine: 85, flags: DIFlagPrototyped, spFlags: 0)
!1439 = !DISubprogram(name: "is_onnx", linkageName: "_ZNK3c106Symbol7is_onnxEv", scope: !1395, file: !1396, line: 86, type: !1430, scopeLine: 86, flags: DIFlagPrototyped, spFlags: 0)
!1440 = !DISubprogram(name: "is_user", linkageName: "_ZNK3c106Symbol7is_userEv", scope: !1395, file: !1396, line: 87, type: !1430, scopeLine: 87, flags: DIFlagPrototyped, spFlags: 0)
!1441 = !DISubprogram(name: "is_caffe2", linkageName: "_ZNK3c106Symbol9is_caffe2Ev", scope: !1395, file: !1396, line: 88, type: !1430, scopeLine: 88, flags: DIFlagPrototyped, spFlags: 0)
!1442 = !DISubprogram(name: "is_dimname", linkageName: "_ZNK3c106Symbol10is_dimnameEv", scope: !1395, file: !1396, line: 89, type: !1430, scopeLine: 89, flags: DIFlagPrototyped, spFlags: 0)
!1443 = !DISubprogram(name: "operator unsigned int", linkageName: "_ZNK3c106SymbolcvjEv", scope: !1395, file: !1396, line: 92, type: !1444, scopeLine: 92, flags: DIFlagPrototyped, spFlags: 0)
!1444 = !DISubroutineType(types: !1445)
!1445 = !{!1399, !1432}
!1446 = !DISubprogram(name: "ns", linkageName: "_ZNK3c106Symbol2nsEv", scope: !1395, file: !1396, line: 96, type: !1447, scopeLine: 96, flags: DIFlagPrototyped, spFlags: 0)
!1447 = !DISubroutineType(types: !1448)
!1448 = !{!1395, !1432}
!1449 = !DISubprogram(name: "toUnqualString", linkageName: "_ZNK3c106Symbol14toUnqualStringEv", scope: !1395, file: !1396, line: 101, type: !1450, scopeLine: 101, flags: DIFlagPrototyped, spFlags: 0)
!1450 = !DISubroutineType(types: !1451)
!1451 = !{!1452, !1432}
!1452 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1453, size: 64)
!1453 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !571)
!1454 = !DISubprogram(name: "toQualString", linkageName: "_ZNK3c106Symbol12toQualStringEv", scope: !1395, file: !1396, line: 106, type: !1450, scopeLine: 106, flags: DIFlagPrototyped, spFlags: 0)
!1455 = !DISubprogram(name: "toDisplayString", linkageName: "_ZNK3c106Symbol15toDisplayStringEv", scope: !1395, file: !1396, line: 111, type: !1450, scopeLine: 111, flags: DIFlagPrototyped, spFlags: 0)
!1456 = !DISubprogram(name: "domainString", linkageName: "_ZNK3c106Symbol12domainStringB5cxx11Ev", scope: !1395, file: !1396, line: 115, type: !1457, scopeLine: 115, flags: DIFlagPrototyped, spFlags: 0)
!1457 = !DISubroutineType(types: !1458)
!1458 = !{!1412, !1432}
!1459 = !DISubprogram(name: "Symbol", scope: !1395, file: !1396, line: 119, type: !1460, scopeLine: 119, flags: DIFlagPrivate | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!1460 = !DISubroutineType(types: !1461)
!1461 = !{null, !1403, !1395, !1410}
!1462 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::EnumType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1463, templateParams: !1538, identifier: "_ZTSSt12__shared_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EE")
!1463 = !{!1464, !1483, !1489, !1490, !1494, !1499, !1503, !1504, !1508, !1511, !1514, !1515, !1519, !1522, !1523, !1526, !1529, !1535}
!1464 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1462, baseType: !1465, flags: DIFlagPublic, extraData: i32 0)
!1465 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::EnumType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !1466, templateParams: !1481, identifier: "_ZTSSt19__shared_ptr_accessIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!1466 = !{!1467, !1476, !1480}
!1467 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !1465, file: !853, line: 977, type: !1468, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1468 = !DISubroutineType(types: !1469)
!1469 = !{!1470, !1474}
!1470 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1471, size: 64)
!1471 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1465, file: !853, line: 974, baseType: !1472)
!1472 = !DICompositeType(tag: DW_TAG_structure_type, name: "EnumType", scope: !36, file: !1473, line: 12, size: 1728, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!1473 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/enum_type.h", directory: "/home/mvh6224/CUDA-BOSolver")
!1474 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1475, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1475 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1465)
!1476 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !1465, file: !853, line: 984, type: !1477, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1477 = !DISubroutineType(types: !1478)
!1478 = !{!1479, !1474}
!1479 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1471, size: 64)
!1480 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !1465, file: !853, line: 992, type: !1477, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!1481 = !{!1482, !911, !975, !975}
!1482 = !DITemplateTypeParameter(name: "_Tp", type: !1472)
!1483 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !1462, file: !853, line: 1402, baseType: !1484, size: 64)
!1484 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1485, size: 64)
!1485 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1462, file: !853, line: 1056, baseType: !1486)
!1486 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1487, file: !764, line: 1982, baseType: !1472)
!1487 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::EnumType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !1488, identifier: "_ZTSSt13remove_extentIN3c108EnumTypeEE")
!1488 = !{!1482}
!1489 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !1462, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!1490 = !DISubprogram(name: "__shared_ptr", scope: !1462, file: !853, line: 1092, type: !1491, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1491 = !DISubroutineType(types: !1492)
!1492 = !{null, !1493}
!1493 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1462, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1494 = !DISubprogram(name: "__shared_ptr", scope: !1462, file: !853, line: 1152, type: !1495, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1495 = !DISubroutineType(types: !1496)
!1496 = !{null, !1493, !1497}
!1497 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1498, size: 64)
!1498 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1462)
!1499 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !1462, file: !853, line: 1153, type: !1500, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1500 = !DISubroutineType(types: !1501)
!1501 = !{!1502, !1493, !1497}
!1502 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1462, size: 64)
!1503 = !DISubprogram(name: "~__shared_ptr", scope: !1462, file: !853, line: 1154, type: !1491, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1504 = !DISubprogram(name: "__shared_ptr", scope: !1462, file: !853, line: 1161, type: !1505, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1505 = !DISubroutineType(types: !1506)
!1506 = !{null, !1493, !1507}
!1507 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1462, size: 64)
!1508 = !DISubprogram(name: "__shared_ptr", scope: !1462, file: !853, line: 1223, type: !1509, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1509 = !DISubroutineType(types: !1510)
!1510 = !{null, !1493, !1004}
!1511 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !1462, file: !853, line: 1248, type: !1512, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1512 = !DISubroutineType(types: !1513)
!1513 = !{!1502, !1493, !1507}
!1514 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !1462, file: !853, line: 1271, type: !1491, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1515 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !1462, file: !853, line: 1295, type: !1516, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1516 = !DISubroutineType(types: !1517)
!1517 = !{!1484, !1518}
!1518 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1498, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1519 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !1462, file: !853, line: 1299, type: !1520, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!1520 = !DISubroutineType(types: !1521)
!1521 = !{!378, !1518}
!1522 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !1462, file: !853, line: 1304, type: !1520, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1523 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !1462, file: !853, line: 1309, type: !1524, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1524 = !DISubroutineType(types: !1525)
!1525 = !{!575, !1518}
!1526 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !1462, file: !853, line: 1314, type: !1527, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1527 = !DISubroutineType(types: !1528)
!1528 = !{null, !1493, !1502}
!1529 = !DISubprogram(name: "__shared_ptr", scope: !1462, file: !853, line: 1352, type: !1530, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!1530 = !DISubroutineType(types: !1531)
!1531 = !{null, !1493, !1532, !915}
!1532 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1533, size: 64)
!1533 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1534)
!1534 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::EnumType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 313, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__weak_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EE")
!1535 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c108EnumTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !1462, file: !853, line: 1390, type: !1536, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!1536 = !DISubroutineType(types: !1537)
!1537 = !{!943, !1518, !944}
!1538 = !{!1482, !911}
!1539 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::EnumType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1540, templateParams: !1488, identifier: "_ZTSSt10shared_ptrIN3c108EnumTypeEE")
!1540 = !{!1541, !1542, !1546, !1551, !1555, !1558, !1562, !1565}
!1541 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1539, baseType: !1462, flags: DIFlagPublic, extraData: i32 0)
!1542 = !DISubprogram(name: "shared_ptr", scope: !1539, file: !1078, line: 148, type: !1543, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1543 = !DISubroutineType(types: !1544)
!1544 = !{null, !1545}
!1545 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1539, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1546 = !DISubprogram(name: "shared_ptr", scope: !1539, file: !1078, line: 150, type: !1547, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1547 = !DISubroutineType(types: !1548)
!1548 = !{null, !1545, !1549}
!1549 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1550, size: 64)
!1550 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1539)
!1551 = !DISubprogram(name: "shared_ptr", scope: !1539, file: !1078, line: 304, type: !1552, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1552 = !DISubroutineType(types: !1553)
!1553 = !{null, !1545, !1554}
!1554 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1539, size: 64)
!1555 = !DISubprogram(name: "shared_ptr", scope: !1539, file: !1078, line: 357, type: !1556, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1556 = !DISubroutineType(types: !1557)
!1557 = !{null, !1545, !1004}
!1558 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c108EnumTypeEEaSERKS2_", scope: !1539, file: !1078, line: 359, type: !1559, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1559 = !DISubroutineType(types: !1560)
!1560 = !{!1561, !1545, !1549}
!1561 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1539, size: 64)
!1562 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c108EnumTypeEEaSEOS2_", scope: !1539, file: !1078, line: 383, type: !1563, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1563 = !DISubroutineType(types: !1564)
!1564 = !{!1561, !1545, !1554}
!1565 = !DISubprogram(name: "shared_ptr", scope: !1539, file: !1078, line: 417, type: !1566, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!1566 = !DISubroutineType(types: !1567)
!1567 = !{null, !1545, !1568, !915}
!1568 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1569, size: 64)
!1569 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1570)
!1570 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::EnumType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c108EnumTypeEE")
!1571 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::TensorType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1572, templateParams: !1686, identifier: "_ZTSSt12__shared_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE")
!1572 = !{!1573, !1592, !1598, !1599, !1603, !1608, !1612, !1613, !1617, !1620, !1623, !1624, !1628, !1631, !1632, !1635, !1638, !1687}
!1573 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1571, baseType: !1574, flags: DIFlagPublic, extraData: i32 0)
!1574 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::TensorType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !1575, templateParams: !1590, identifier: "_ZTSSt19__shared_ptr_accessIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!1575 = !{!1576, !1585, !1589}
!1576 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !1574, file: !853, line: 977, type: !1577, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1577 = !DISubroutineType(types: !1578)
!1578 = !{!1579, !1583}
!1579 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1580, size: 64)
!1580 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1574, file: !853, line: 974, baseType: !1581)
!1581 = !DICompositeType(tag: DW_TAG_structure_type, name: "TensorType", scope: !36, file: !1582, line: 578, size: 896, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!1582 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/jit_type.h", directory: "/home/mvh6224/CUDA-BOSolver")
!1583 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1584, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1584 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1574)
!1585 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !1574, file: !853, line: 984, type: !1586, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1586 = !DISubroutineType(types: !1587)
!1587 = !{!1588, !1583}
!1588 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1580, size: 64)
!1589 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !1574, file: !853, line: 992, type: !1586, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!1590 = !{!1591, !911, !975, !975}
!1591 = !DITemplateTypeParameter(name: "_Tp", type: !1581)
!1592 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !1571, file: !853, line: 1402, baseType: !1593, size: 64)
!1593 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1594, size: 64)
!1594 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1571, file: !853, line: 1056, baseType: !1595)
!1595 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1596, file: !764, line: 1982, baseType: !1581)
!1596 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::TensorType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !1597, identifier: "_ZTSSt13remove_extentIN3c1010TensorTypeEE")
!1597 = !{!1591}
!1598 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !1571, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!1599 = !DISubprogram(name: "__shared_ptr", scope: !1571, file: !853, line: 1092, type: !1600, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1600 = !DISubroutineType(types: !1601)
!1601 = !{null, !1602}
!1602 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1571, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1603 = !DISubprogram(name: "__shared_ptr", scope: !1571, file: !853, line: 1152, type: !1604, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1604 = !DISubroutineType(types: !1605)
!1605 = !{null, !1602, !1606}
!1606 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1607, size: 64)
!1607 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1571)
!1608 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !1571, file: !853, line: 1153, type: !1609, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1609 = !DISubroutineType(types: !1610)
!1610 = !{!1611, !1602, !1606}
!1611 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1571, size: 64)
!1612 = !DISubprogram(name: "~__shared_ptr", scope: !1571, file: !853, line: 1154, type: !1600, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1613 = !DISubprogram(name: "__shared_ptr", scope: !1571, file: !853, line: 1161, type: !1614, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1614 = !DISubroutineType(types: !1615)
!1615 = !{null, !1602, !1616}
!1616 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1571, size: 64)
!1617 = !DISubprogram(name: "__shared_ptr", scope: !1571, file: !853, line: 1223, type: !1618, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1618 = !DISubroutineType(types: !1619)
!1619 = !{null, !1602, !1004}
!1620 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !1571, file: !853, line: 1248, type: !1621, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1621 = !DISubroutineType(types: !1622)
!1622 = !{!1611, !1602, !1616}
!1623 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !1571, file: !853, line: 1271, type: !1600, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1624 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !1571, file: !853, line: 1295, type: !1625, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1625 = !DISubroutineType(types: !1626)
!1626 = !{!1593, !1627}
!1627 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1607, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1628 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !1571, file: !853, line: 1299, type: !1629, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!1629 = !DISubroutineType(types: !1630)
!1630 = !{!378, !1627}
!1631 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !1571, file: !853, line: 1304, type: !1629, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1632 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !1571, file: !853, line: 1309, type: !1633, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1633 = !DISubroutineType(types: !1634)
!1634 = !{!575, !1627}
!1635 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !1571, file: !853, line: 1314, type: !1636, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1636 = !DISubroutineType(types: !1637)
!1637 = !{null, !1602, !1611}
!1638 = !DISubprogram(name: "__shared_ptr", scope: !1571, file: !853, line: 1352, type: !1639, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!1639 = !DISubroutineType(types: !1640)
!1640 = !{null, !1602, !1641, !915}
!1641 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1642, size: 64)
!1642 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1643)
!1643 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::TensorType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1591, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1644, templateParams: !1686, identifier: "_ZTSSt10__weak_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE")
!1644 = !{!1645, !1648, !1649, !1653, !1656, !1657, !1661, !1665, !1668, !1672, !1675, !1678, !1679, !1682}
!1645 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !1643, file: !853, line: 1733, baseType: !1646, size: 64)
!1646 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1647, size: 64)
!1647 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1643, file: !853, line: 1602, baseType: !1595)
!1648 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !1643, file: !853, line: 1734, baseType: !867, size: 64, offset: 64)
!1649 = !DISubprogram(name: "__weak_ptr", scope: !1643, file: !853, line: 1604, type: !1650, scopeLine: 1604, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1650 = !DISubroutineType(types: !1651)
!1651 = !{null, !1652}
!1652 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1643, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1653 = !DISubprogram(name: "__weak_ptr", scope: !1643, file: !853, line: 1608, type: !1654, scopeLine: 1608, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1654 = !DISubroutineType(types: !1655)
!1655 = !{null, !1652, !1641}
!1656 = !DISubprogram(name: "~__weak_ptr", scope: !1643, file: !853, line: 1610, type: !1650, scopeLine: 1610, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1657 = !DISubprogram(name: "__weak_ptr", scope: !1643, file: !853, line: 1636, type: !1658, scopeLine: 1636, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1658 = !DISubroutineType(types: !1659)
!1659 = !{null, !1652, !1660}
!1660 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1643, size: 64)
!1661 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10__weak_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !1643, file: !853, line: 1646, type: !1662, scopeLine: 1646, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1662 = !DISubroutineType(types: !1663)
!1663 = !{!1664, !1652, !1641}
!1664 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1643, size: 64)
!1665 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10__weak_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !1643, file: !853, line: 1667, type: !1666, scopeLine: 1667, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1666 = !DISubroutineType(types: !1667)
!1667 = !{!1664, !1652, !1660}
!1668 = !DISubprogram(name: "lock", linkageName: "_ZNKSt10__weak_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE4lockEv", scope: !1643, file: !853, line: 1684, type: !1669, scopeLine: 1684, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1669 = !DISubroutineType(types: !1670)
!1670 = !{!1571, !1671}
!1671 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1642, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1672 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt10__weak_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !1643, file: !853, line: 1688, type: !1673, scopeLine: 1688, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1673 = !DISubroutineType(types: !1674)
!1674 = !{!575, !1671}
!1675 = !DISubprogram(name: "expired", linkageName: "_ZNKSt10__weak_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE7expiredEv", scope: !1643, file: !853, line: 1692, type: !1676, scopeLine: 1692, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1676 = !DISubroutineType(types: !1677)
!1677 = !{!378, !1671}
!1678 = !DISubprogram(name: "reset", linkageName: "_ZNSt10__weak_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !1643, file: !853, line: 1706, type: !1650, scopeLine: 1706, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1679 = !DISubprogram(name: "swap", linkageName: "_ZNSt10__weak_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !1643, file: !853, line: 1710, type: !1680, scopeLine: 1710, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1680 = !DISubroutineType(types: !1681)
!1681 = !{null, !1652, !1664}
!1682 = !DISubprogram(name: "_M_assign", linkageName: "_ZNSt10__weak_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE9_M_assignEPS1_RKSt14__shared_countILS3_2EE", scope: !1643, file: !853, line: 1719, type: !1683, scopeLine: 1719, flags: DIFlagPrototyped, spFlags: 0)
!1683 = !DISubroutineType(types: !1684)
!1684 = !{null, !1652, !1685, !877}
!1685 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1581, size: 64)
!1686 = !{!1591, !911}
!1687 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c1010TensorTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !1571, file: !853, line: 1390, type: !1688, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!1688 = !DISubroutineType(types: !1689)
!1689 = !{!943, !1627, !944}
!1690 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::TensorType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1691, templateParams: !1597, identifier: "_ZTSSt10shared_ptrIN3c1010TensorTypeEE")
!1691 = !{!1692, !1693, !1697, !1702, !1706, !1709, !1713, !1716}
!1692 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1690, baseType: !1571, flags: DIFlagPublic, extraData: i32 0)
!1693 = !DISubprogram(name: "shared_ptr", scope: !1690, file: !1078, line: 148, type: !1694, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1694 = !DISubroutineType(types: !1695)
!1695 = !{null, !1696}
!1696 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1690, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1697 = !DISubprogram(name: "shared_ptr", scope: !1690, file: !1078, line: 150, type: !1698, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1698 = !DISubroutineType(types: !1699)
!1699 = !{null, !1696, !1700}
!1700 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1701, size: 64)
!1701 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1690)
!1702 = !DISubprogram(name: "shared_ptr", scope: !1690, file: !1078, line: 304, type: !1703, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1703 = !DISubroutineType(types: !1704)
!1704 = !{null, !1696, !1705}
!1705 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1690, size: 64)
!1706 = !DISubprogram(name: "shared_ptr", scope: !1690, file: !1078, line: 357, type: !1707, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1707 = !DISubroutineType(types: !1708)
!1708 = !{null, !1696, !1004}
!1709 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1010TensorTypeEEaSERKS2_", scope: !1690, file: !1078, line: 359, type: !1710, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1710 = !DISubroutineType(types: !1711)
!1711 = !{!1712, !1696, !1700}
!1712 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1690, size: 64)
!1713 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1010TensorTypeEEaSEOS2_", scope: !1690, file: !1078, line: 383, type: !1714, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1714 = !DISubroutineType(types: !1715)
!1715 = !{!1712, !1696, !1705}
!1716 = !DISubprogram(name: "shared_ptr", scope: !1690, file: !1078, line: 417, type: !1717, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!1717 = !DISubroutineType(types: !1718)
!1718 = !{null, !1696, !1719, !915}
!1719 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1720, size: 64)
!1720 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1721)
!1721 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::TensorType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c1010TensorTypeEE")
!1722 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::TupleType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1723, templateParams: !1836, identifier: "_ZTSSt12__shared_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE")
!1723 = !{!1724, !1742, !1748, !1749, !1753, !1758, !1762, !1763, !1767, !1770, !1773, !1774, !1778, !1781, !1782, !1785, !1788, !1837}
!1724 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1722, baseType: !1725, flags: DIFlagPublic, extraData: i32 0)
!1725 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::TupleType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !1726, templateParams: !1740, identifier: "_ZTSSt19__shared_ptr_accessIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!1726 = !{!1727, !1735, !1739}
!1727 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !1725, file: !853, line: 977, type: !1728, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1728 = !DISubroutineType(types: !1729)
!1729 = !{!1730, !1733}
!1730 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1731, size: 64)
!1731 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1725, file: !853, line: 974, baseType: !1732)
!1732 = !DICompositeType(tag: DW_TAG_structure_type, name: "TupleType", scope: !36, file: !1582, line: 1147, size: 1664, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!1733 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1734, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1734 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1725)
!1735 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !1725, file: !853, line: 984, type: !1736, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1736 = !DISubroutineType(types: !1737)
!1737 = !{!1738, !1733}
!1738 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1731, size: 64)
!1739 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !1725, file: !853, line: 992, type: !1736, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!1740 = !{!1741, !911, !975, !975}
!1741 = !DITemplateTypeParameter(name: "_Tp", type: !1732)
!1742 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !1722, file: !853, line: 1402, baseType: !1743, size: 64)
!1743 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1744, size: 64)
!1744 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1722, file: !853, line: 1056, baseType: !1745)
!1745 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1746, file: !764, line: 1982, baseType: !1732)
!1746 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::TupleType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !1747, identifier: "_ZTSSt13remove_extentIN3c109TupleTypeEE")
!1747 = !{!1741}
!1748 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !1722, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!1749 = !DISubprogram(name: "__shared_ptr", scope: !1722, file: !853, line: 1092, type: !1750, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1750 = !DISubroutineType(types: !1751)
!1751 = !{null, !1752}
!1752 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1722, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1753 = !DISubprogram(name: "__shared_ptr", scope: !1722, file: !853, line: 1152, type: !1754, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1754 = !DISubroutineType(types: !1755)
!1755 = !{null, !1752, !1756}
!1756 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1757, size: 64)
!1757 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1722)
!1758 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !1722, file: !853, line: 1153, type: !1759, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1759 = !DISubroutineType(types: !1760)
!1760 = !{!1761, !1752, !1756}
!1761 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1722, size: 64)
!1762 = !DISubprogram(name: "~__shared_ptr", scope: !1722, file: !853, line: 1154, type: !1750, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1763 = !DISubprogram(name: "__shared_ptr", scope: !1722, file: !853, line: 1161, type: !1764, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1764 = !DISubroutineType(types: !1765)
!1765 = !{null, !1752, !1766}
!1766 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1722, size: 64)
!1767 = !DISubprogram(name: "__shared_ptr", scope: !1722, file: !853, line: 1223, type: !1768, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1768 = !DISubroutineType(types: !1769)
!1769 = !{null, !1752, !1004}
!1770 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !1722, file: !853, line: 1248, type: !1771, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1771 = !DISubroutineType(types: !1772)
!1772 = !{!1761, !1752, !1766}
!1773 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !1722, file: !853, line: 1271, type: !1750, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1774 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !1722, file: !853, line: 1295, type: !1775, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1775 = !DISubroutineType(types: !1776)
!1776 = !{!1743, !1777}
!1777 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1757, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1778 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !1722, file: !853, line: 1299, type: !1779, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!1779 = !DISubroutineType(types: !1780)
!1780 = !{!378, !1777}
!1781 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !1722, file: !853, line: 1304, type: !1779, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1782 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !1722, file: !853, line: 1309, type: !1783, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1783 = !DISubroutineType(types: !1784)
!1784 = !{!575, !1777}
!1785 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !1722, file: !853, line: 1314, type: !1786, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1786 = !DISubroutineType(types: !1787)
!1787 = !{null, !1752, !1761}
!1788 = !DISubprogram(name: "__shared_ptr", scope: !1722, file: !853, line: 1352, type: !1789, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!1789 = !DISubroutineType(types: !1790)
!1790 = !{null, !1752, !1791, !915}
!1791 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1792, size: 64)
!1792 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1793)
!1793 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::TupleType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1591, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1794, templateParams: !1836, identifier: "_ZTSSt10__weak_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE")
!1794 = !{!1795, !1798, !1799, !1803, !1806, !1807, !1811, !1815, !1818, !1822, !1825, !1828, !1829, !1832}
!1795 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !1793, file: !853, line: 1733, baseType: !1796, size: 64)
!1796 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1797, size: 64)
!1797 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1793, file: !853, line: 1602, baseType: !1745)
!1798 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !1793, file: !853, line: 1734, baseType: !867, size: 64, offset: 64)
!1799 = !DISubprogram(name: "__weak_ptr", scope: !1793, file: !853, line: 1604, type: !1800, scopeLine: 1604, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1800 = !DISubroutineType(types: !1801)
!1801 = !{null, !1802}
!1802 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1793, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1803 = !DISubprogram(name: "__weak_ptr", scope: !1793, file: !853, line: 1608, type: !1804, scopeLine: 1608, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1804 = !DISubroutineType(types: !1805)
!1805 = !{null, !1802, !1791}
!1806 = !DISubprogram(name: "~__weak_ptr", scope: !1793, file: !853, line: 1610, type: !1800, scopeLine: 1610, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1807 = !DISubprogram(name: "__weak_ptr", scope: !1793, file: !853, line: 1636, type: !1808, scopeLine: 1636, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1808 = !DISubroutineType(types: !1809)
!1809 = !{null, !1802, !1810}
!1810 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1793, size: 64)
!1811 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10__weak_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !1793, file: !853, line: 1646, type: !1812, scopeLine: 1646, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1812 = !DISubroutineType(types: !1813)
!1813 = !{!1814, !1802, !1791}
!1814 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1793, size: 64)
!1815 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10__weak_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !1793, file: !853, line: 1667, type: !1816, scopeLine: 1667, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1816 = !DISubroutineType(types: !1817)
!1817 = !{!1814, !1802, !1810}
!1818 = !DISubprogram(name: "lock", linkageName: "_ZNKSt10__weak_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE4lockEv", scope: !1793, file: !853, line: 1684, type: !1819, scopeLine: 1684, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1819 = !DISubroutineType(types: !1820)
!1820 = !{!1722, !1821}
!1821 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1792, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1822 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt10__weak_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !1793, file: !853, line: 1688, type: !1823, scopeLine: 1688, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1823 = !DISubroutineType(types: !1824)
!1824 = !{!575, !1821}
!1825 = !DISubprogram(name: "expired", linkageName: "_ZNKSt10__weak_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE7expiredEv", scope: !1793, file: !853, line: 1692, type: !1826, scopeLine: 1692, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1826 = !DISubroutineType(types: !1827)
!1827 = !{!378, !1821}
!1828 = !DISubprogram(name: "reset", linkageName: "_ZNSt10__weak_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !1793, file: !853, line: 1706, type: !1800, scopeLine: 1706, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1829 = !DISubprogram(name: "swap", linkageName: "_ZNSt10__weak_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !1793, file: !853, line: 1710, type: !1830, scopeLine: 1710, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1830 = !DISubroutineType(types: !1831)
!1831 = !{null, !1802, !1814}
!1832 = !DISubprogram(name: "_M_assign", linkageName: "_ZNSt10__weak_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE9_M_assignEPS1_RKSt14__shared_countILS3_2EE", scope: !1793, file: !853, line: 1719, type: !1833, scopeLine: 1719, flags: DIFlagPrototyped, spFlags: 0)
!1833 = !DISubroutineType(types: !1834)
!1834 = !{null, !1802, !1835, !877}
!1835 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1732, size: 64)
!1836 = !{!1741, !911}
!1837 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c109TupleTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !1722, file: !853, line: 1390, type: !1838, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!1838 = !DISubroutineType(types: !1839)
!1839 = !{!943, !1777, !944}
!1840 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::TupleType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1841, templateParams: !1747, identifier: "_ZTSSt10shared_ptrIN3c109TupleTypeEE")
!1841 = !{!1842, !1843, !1847, !1852, !1856, !1859, !1863, !1866}
!1842 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1840, baseType: !1722, flags: DIFlagPublic, extraData: i32 0)
!1843 = !DISubprogram(name: "shared_ptr", scope: !1840, file: !1078, line: 148, type: !1844, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1844 = !DISubroutineType(types: !1845)
!1845 = !{null, !1846}
!1846 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1840, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1847 = !DISubprogram(name: "shared_ptr", scope: !1840, file: !1078, line: 150, type: !1848, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1848 = !DISubroutineType(types: !1849)
!1849 = !{null, !1846, !1850}
!1850 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1851, size: 64)
!1851 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1840)
!1852 = !DISubprogram(name: "shared_ptr", scope: !1840, file: !1078, line: 304, type: !1853, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1853 = !DISubroutineType(types: !1854)
!1854 = !{null, !1846, !1855}
!1855 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1840, size: 64)
!1856 = !DISubprogram(name: "shared_ptr", scope: !1840, file: !1078, line: 357, type: !1857, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1857 = !DISubroutineType(types: !1858)
!1858 = !{null, !1846, !1004}
!1859 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c109TupleTypeEEaSERKS2_", scope: !1840, file: !1078, line: 359, type: !1860, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1860 = !DISubroutineType(types: !1861)
!1861 = !{!1862, !1846, !1850}
!1862 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1840, size: 64)
!1863 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c109TupleTypeEEaSEOS2_", scope: !1840, file: !1078, line: 383, type: !1864, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1864 = !DISubroutineType(types: !1865)
!1865 = !{!1862, !1846, !1855}
!1866 = !DISubprogram(name: "shared_ptr", scope: !1840, file: !1078, line: 417, type: !1867, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!1867 = !DISubroutineType(types: !1868)
!1868 = !{null, !1846, !1869, !915}
!1869 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1870, size: 64)
!1870 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1871)
!1871 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::TupleType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c109TupleTypeEE")
!1872 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::ListType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1873, templateParams: !1986, identifier: "_ZTSSt12__shared_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE")
!1873 = !{!1874, !1892, !1898, !1899, !1903, !1908, !1912, !1913, !1917, !1920, !1923, !1924, !1928, !1931, !1932, !1935, !1938, !1987}
!1874 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1872, baseType: !1875, flags: DIFlagPublic, extraData: i32 0)
!1875 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::ListType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !1876, templateParams: !1890, identifier: "_ZTSSt19__shared_ptr_accessIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!1876 = !{!1877, !1885, !1889}
!1877 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !1875, file: !853, line: 977, type: !1878, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1878 = !DISubroutineType(types: !1879)
!1879 = !{!1880, !1883}
!1880 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1881, size: 64)
!1881 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1875, file: !853, line: 974, baseType: !1882)
!1882 = !DICompositeType(tag: DW_TAG_structure_type, name: "ListType", scope: !36, file: !1582, line: 869, size: 384, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!1883 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1884, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1884 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1875)
!1885 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !1875, file: !853, line: 984, type: !1886, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1886 = !DISubroutineType(types: !1887)
!1887 = !{!1888, !1883}
!1888 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1881, size: 64)
!1889 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !1875, file: !853, line: 992, type: !1886, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!1890 = !{!1891, !911, !975, !975}
!1891 = !DITemplateTypeParameter(name: "_Tp", type: !1882)
!1892 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !1872, file: !853, line: 1402, baseType: !1893, size: 64)
!1893 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1894, size: 64)
!1894 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1872, file: !853, line: 1056, baseType: !1895)
!1895 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !1896, file: !764, line: 1982, baseType: !1882)
!1896 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::ListType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !1897, identifier: "_ZTSSt13remove_extentIN3c108ListTypeEE")
!1897 = !{!1891}
!1898 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !1872, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!1899 = !DISubprogram(name: "__shared_ptr", scope: !1872, file: !853, line: 1092, type: !1900, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1900 = !DISubroutineType(types: !1901)
!1901 = !{null, !1902}
!1902 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1872, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1903 = !DISubprogram(name: "__shared_ptr", scope: !1872, file: !853, line: 1152, type: !1904, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1904 = !DISubroutineType(types: !1905)
!1905 = !{null, !1902, !1906}
!1906 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1907, size: 64)
!1907 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1872)
!1908 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !1872, file: !853, line: 1153, type: !1909, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1909 = !DISubroutineType(types: !1910)
!1910 = !{!1911, !1902, !1906}
!1911 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1872, size: 64)
!1912 = !DISubprogram(name: "~__shared_ptr", scope: !1872, file: !853, line: 1154, type: !1900, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1913 = !DISubprogram(name: "__shared_ptr", scope: !1872, file: !853, line: 1161, type: !1914, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1914 = !DISubroutineType(types: !1915)
!1915 = !{null, !1902, !1916}
!1916 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1872, size: 64)
!1917 = !DISubprogram(name: "__shared_ptr", scope: !1872, file: !853, line: 1223, type: !1918, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1918 = !DISubroutineType(types: !1919)
!1919 = !{null, !1902, !1004}
!1920 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !1872, file: !853, line: 1248, type: !1921, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1921 = !DISubroutineType(types: !1922)
!1922 = !{!1911, !1902, !1916}
!1923 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !1872, file: !853, line: 1271, type: !1900, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1924 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !1872, file: !853, line: 1295, type: !1925, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1925 = !DISubroutineType(types: !1926)
!1926 = !{!1893, !1927}
!1927 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1907, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1928 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !1872, file: !853, line: 1299, type: !1929, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!1929 = !DISubroutineType(types: !1930)
!1930 = !{!378, !1927}
!1931 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !1872, file: !853, line: 1304, type: !1929, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1932 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !1872, file: !853, line: 1309, type: !1933, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1933 = !DISubroutineType(types: !1934)
!1934 = !{!575, !1927}
!1935 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !1872, file: !853, line: 1314, type: !1936, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1936 = !DISubroutineType(types: !1937)
!1937 = !{null, !1902, !1911}
!1938 = !DISubprogram(name: "__shared_ptr", scope: !1872, file: !853, line: 1352, type: !1939, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!1939 = !DISubroutineType(types: !1940)
!1940 = !{null, !1902, !1941, !915}
!1941 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1942, size: 64)
!1942 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1943)
!1943 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::ListType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1591, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1944, templateParams: !1986, identifier: "_ZTSSt10__weak_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE")
!1944 = !{!1945, !1948, !1949, !1953, !1956, !1957, !1961, !1965, !1968, !1972, !1975, !1978, !1979, !1982}
!1945 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !1943, file: !853, line: 1733, baseType: !1946, size: 64)
!1946 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1947, size: 64)
!1947 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !1943, file: !853, line: 1602, baseType: !1895)
!1948 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !1943, file: !853, line: 1734, baseType: !867, size: 64, offset: 64)
!1949 = !DISubprogram(name: "__weak_ptr", scope: !1943, file: !853, line: 1604, type: !1950, scopeLine: 1604, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1950 = !DISubroutineType(types: !1951)
!1951 = !{null, !1952}
!1952 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1943, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1953 = !DISubprogram(name: "__weak_ptr", scope: !1943, file: !853, line: 1608, type: !1954, scopeLine: 1608, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1954 = !DISubroutineType(types: !1955)
!1955 = !{null, !1952, !1941}
!1956 = !DISubprogram(name: "~__weak_ptr", scope: !1943, file: !853, line: 1610, type: !1950, scopeLine: 1610, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1957 = !DISubprogram(name: "__weak_ptr", scope: !1943, file: !853, line: 1636, type: !1958, scopeLine: 1636, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1958 = !DISubroutineType(types: !1959)
!1959 = !{null, !1952, !1960}
!1960 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1943, size: 64)
!1961 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10__weak_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !1943, file: !853, line: 1646, type: !1962, scopeLine: 1646, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1962 = !DISubroutineType(types: !1963)
!1963 = !{!1964, !1952, !1941}
!1964 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1943, size: 64)
!1965 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10__weak_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !1943, file: !853, line: 1667, type: !1966, scopeLine: 1667, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1966 = !DISubroutineType(types: !1967)
!1967 = !{!1964, !1952, !1960}
!1968 = !DISubprogram(name: "lock", linkageName: "_ZNKSt10__weak_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE4lockEv", scope: !1943, file: !853, line: 1684, type: !1969, scopeLine: 1684, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1969 = !DISubroutineType(types: !1970)
!1970 = !{!1872, !1971}
!1971 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1942, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1972 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt10__weak_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !1943, file: !853, line: 1688, type: !1973, scopeLine: 1688, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1973 = !DISubroutineType(types: !1974)
!1974 = !{!575, !1971}
!1975 = !DISubprogram(name: "expired", linkageName: "_ZNKSt10__weak_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE7expiredEv", scope: !1943, file: !853, line: 1692, type: !1976, scopeLine: 1692, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1976 = !DISubroutineType(types: !1977)
!1977 = !{!378, !1971}
!1978 = !DISubprogram(name: "reset", linkageName: "_ZNSt10__weak_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !1943, file: !853, line: 1706, type: !1950, scopeLine: 1706, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1979 = !DISubprogram(name: "swap", linkageName: "_ZNSt10__weak_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !1943, file: !853, line: 1710, type: !1980, scopeLine: 1710, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1980 = !DISubroutineType(types: !1981)
!1981 = !{null, !1952, !1964}
!1982 = !DISubprogram(name: "_M_assign", linkageName: "_ZNSt10__weak_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE9_M_assignEPS1_RKSt14__shared_countILS3_2EE", scope: !1943, file: !853, line: 1719, type: !1983, scopeLine: 1719, flags: DIFlagPrototyped, spFlags: 0)
!1983 = !DISubroutineType(types: !1984)
!1984 = !{null, !1952, !1985, !877}
!1985 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1882, size: 64)
!1986 = !{!1891, !911}
!1987 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c108ListTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !1872, file: !853, line: 1390, type: !1988, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!1988 = !DISubroutineType(types: !1989)
!1989 = !{!943, !1927, !944}
!1990 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::ListType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !1991, templateParams: !1897, identifier: "_ZTSSt10shared_ptrIN3c108ListTypeEE")
!1991 = !{!1992, !1993, !1997, !2002, !2006, !2009, !2013, !2016}
!1992 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !1990, baseType: !1872, flags: DIFlagPublic, extraData: i32 0)
!1993 = !DISubprogram(name: "shared_ptr", scope: !1990, file: !1078, line: 148, type: !1994, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1994 = !DISubroutineType(types: !1995)
!1995 = !{null, !1996}
!1996 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1990, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!1997 = !DISubprogram(name: "shared_ptr", scope: !1990, file: !1078, line: 150, type: !1998, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!1998 = !DISubroutineType(types: !1999)
!1999 = !{null, !1996, !2000}
!2000 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2001, size: 64)
!2001 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1990)
!2002 = !DISubprogram(name: "shared_ptr", scope: !1990, file: !1078, line: 304, type: !2003, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2003 = !DISubroutineType(types: !2004)
!2004 = !{null, !1996, !2005}
!2005 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1990, size: 64)
!2006 = !DISubprogram(name: "shared_ptr", scope: !1990, file: !1078, line: 357, type: !2007, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2007 = !DISubroutineType(types: !2008)
!2008 = !{null, !1996, !1004}
!2009 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c108ListTypeEEaSERKS2_", scope: !1990, file: !1078, line: 359, type: !2010, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2010 = !DISubroutineType(types: !2011)
!2011 = !{!2012, !1996, !2000}
!2012 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1990, size: 64)
!2013 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c108ListTypeEEaSEOS2_", scope: !1990, file: !1078, line: 383, type: !2014, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2014 = !DISubroutineType(types: !2015)
!2015 = !{!2012, !1996, !2005}
!2016 = !DISubprogram(name: "shared_ptr", scope: !1990, file: !1078, line: 417, type: !2017, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!2017 = !DISubroutineType(types: !2018)
!2018 = !{null, !1996, !2019, !915}
!2019 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2020, size: 64)
!2020 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2021)
!2021 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::ListType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c108ListTypeEE")
!2022 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::DictType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2023, templateParams: !2097, identifier: "_ZTSSt12__shared_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2023 = !{!2024, !2042, !2048, !2049, !2053, !2058, !2062, !2063, !2067, !2070, !2073, !2074, !2078, !2081, !2082, !2085, !2088, !2094}
!2024 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2022, baseType: !2025, flags: DIFlagPublic, extraData: i32 0)
!2025 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::DictType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !2026, templateParams: !2040, identifier: "_ZTSSt19__shared_ptr_accessIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!2026 = !{!2027, !2035, !2039}
!2027 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !2025, file: !853, line: 977, type: !2028, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2028 = !DISubroutineType(types: !2029)
!2029 = !{!2030, !2033}
!2030 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2031, size: 64)
!2031 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2025, file: !853, line: 974, baseType: !2032)
!2032 = !DICompositeType(tag: DW_TAG_structure_type, name: "DictType", scope: !36, file: !1582, line: 923, size: 512, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!2033 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2034, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2034 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2025)
!2035 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !2025, file: !853, line: 984, type: !2036, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2036 = !DISubroutineType(types: !2037)
!2037 = !{!2038, !2033}
!2038 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2031, size: 64)
!2039 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !2025, file: !853, line: 992, type: !2036, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!2040 = !{!2041, !911, !975, !975}
!2041 = !DITemplateTypeParameter(name: "_Tp", type: !2032)
!2042 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !2022, file: !853, line: 1402, baseType: !2043, size: 64)
!2043 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2044, size: 64)
!2044 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2022, file: !853, line: 1056, baseType: !2045)
!2045 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2046, file: !764, line: 1982, baseType: !2032)
!2046 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::DictType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !2047, identifier: "_ZTSSt13remove_extentIN3c108DictTypeEE")
!2047 = !{!2041}
!2048 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !2022, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!2049 = !DISubprogram(name: "__shared_ptr", scope: !2022, file: !853, line: 1092, type: !2050, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2050 = !DISubroutineType(types: !2051)
!2051 = !{null, !2052}
!2052 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2022, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2053 = !DISubprogram(name: "__shared_ptr", scope: !2022, file: !853, line: 1152, type: !2054, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2054 = !DISubroutineType(types: !2055)
!2055 = !{null, !2052, !2056}
!2056 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2057, size: 64)
!2057 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2022)
!2058 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !2022, file: !853, line: 1153, type: !2059, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2059 = !DISubroutineType(types: !2060)
!2060 = !{!2061, !2052, !2056}
!2061 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2022, size: 64)
!2062 = !DISubprogram(name: "~__shared_ptr", scope: !2022, file: !853, line: 1154, type: !2050, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2063 = !DISubprogram(name: "__shared_ptr", scope: !2022, file: !853, line: 1161, type: !2064, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2064 = !DISubroutineType(types: !2065)
!2065 = !{null, !2052, !2066}
!2066 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2022, size: 64)
!2067 = !DISubprogram(name: "__shared_ptr", scope: !2022, file: !853, line: 1223, type: !2068, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2068 = !DISubroutineType(types: !2069)
!2069 = !{null, !2052, !1004}
!2070 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !2022, file: !853, line: 1248, type: !2071, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2071 = !DISubroutineType(types: !2072)
!2072 = !{!2061, !2052, !2066}
!2073 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !2022, file: !853, line: 1271, type: !2050, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2074 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !2022, file: !853, line: 1295, type: !2075, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2075 = !DISubroutineType(types: !2076)
!2076 = !{!2043, !2077}
!2077 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2057, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2078 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !2022, file: !853, line: 1299, type: !2079, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!2079 = !DISubroutineType(types: !2080)
!2080 = !{!378, !2077}
!2081 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !2022, file: !853, line: 1304, type: !2079, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2082 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !2022, file: !853, line: 1309, type: !2083, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2083 = !DISubroutineType(types: !2084)
!2084 = !{!575, !2077}
!2085 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !2022, file: !853, line: 1314, type: !2086, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2086 = !DISubroutineType(types: !2087)
!2087 = !{null, !2052, !2061}
!2088 = !DISubprogram(name: "__shared_ptr", scope: !2022, file: !853, line: 1352, type: !2089, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!2089 = !DISubroutineType(types: !2090)
!2090 = !{null, !2052, !2091, !915}
!2091 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2092, size: 64)
!2092 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2093)
!2093 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::DictType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 313, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__weak_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2094 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c108DictTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !2022, file: !853, line: 1390, type: !2095, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!2095 = !DISubroutineType(types: !2096)
!2096 = !{!943, !2077, !944}
!2097 = !{!2041, !911}
!2098 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::DictType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2099, templateParams: !2047, identifier: "_ZTSSt10shared_ptrIN3c108DictTypeEE")
!2099 = !{!2100, !2101, !2105, !2110, !2114, !2117, !2121, !2124}
!2100 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2098, baseType: !2022, flags: DIFlagPublic, extraData: i32 0)
!2101 = !DISubprogram(name: "shared_ptr", scope: !2098, file: !1078, line: 148, type: !2102, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2102 = !DISubroutineType(types: !2103)
!2103 = !{null, !2104}
!2104 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2098, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2105 = !DISubprogram(name: "shared_ptr", scope: !2098, file: !1078, line: 150, type: !2106, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2106 = !DISubroutineType(types: !2107)
!2107 = !{null, !2104, !2108}
!2108 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2109, size: 64)
!2109 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2098)
!2110 = !DISubprogram(name: "shared_ptr", scope: !2098, file: !1078, line: 304, type: !2111, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2111 = !DISubroutineType(types: !2112)
!2112 = !{null, !2104, !2113}
!2113 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2098, size: 64)
!2114 = !DISubprogram(name: "shared_ptr", scope: !2098, file: !1078, line: 357, type: !2115, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2115 = !DISubroutineType(types: !2116)
!2116 = !{null, !2104, !1004}
!2117 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c108DictTypeEEaSERKS2_", scope: !2098, file: !1078, line: 359, type: !2118, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2118 = !DISubroutineType(types: !2119)
!2119 = !{!2120, !2104, !2108}
!2120 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2098, size: 64)
!2121 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c108DictTypeEEaSEOS2_", scope: !2098, file: !1078, line: 383, type: !2122, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2122 = !DISubroutineType(types: !2123)
!2123 = !{!2120, !2104, !2113}
!2124 = !DISubprogram(name: "shared_ptr", scope: !2098, file: !1078, line: 417, type: !2125, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!2125 = !DISubroutineType(types: !2126)
!2126 = !{null, !2104, !2127, !915}
!2127 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2128, size: 64)
!2128 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2129)
!2129 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::DictType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c108DictTypeEE")
!2130 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::FutureType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2131, templateParams: !2205, identifier: "_ZTSSt12__shared_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2131 = !{!2132, !2150, !2156, !2157, !2161, !2166, !2170, !2171, !2175, !2178, !2181, !2182, !2186, !2189, !2190, !2193, !2196, !2202}
!2132 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2130, baseType: !2133, flags: DIFlagPublic, extraData: i32 0)
!2133 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::FutureType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !2134, templateParams: !2148, identifier: "_ZTSSt19__shared_ptr_accessIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!2134 = !{!2135, !2143, !2147}
!2135 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !2133, file: !853, line: 977, type: !2136, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2136 = !DISubroutineType(types: !2137)
!2137 = !{!2138, !2141}
!2138 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2139, size: 64)
!2139 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2133, file: !853, line: 974, baseType: !2140)
!2140 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "FutureType", scope: !36, file: !1582, line: 1017, size: 384, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1010FutureTypeE")
!2141 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2142, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2142 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2133)
!2143 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !2133, file: !853, line: 984, type: !2144, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2144 = !DISubroutineType(types: !2145)
!2145 = !{!2146, !2141}
!2146 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2139, size: 64)
!2147 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !2133, file: !853, line: 992, type: !2144, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!2148 = !{!2149, !911, !975, !975}
!2149 = !DITemplateTypeParameter(name: "_Tp", type: !2140)
!2150 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !2130, file: !853, line: 1402, baseType: !2151, size: 64)
!2151 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2152, size: 64)
!2152 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2130, file: !853, line: 1056, baseType: !2153)
!2153 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2154, file: !764, line: 1982, baseType: !2140)
!2154 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::FutureType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !2155, identifier: "_ZTSSt13remove_extentIN3c1010FutureTypeEE")
!2155 = !{!2149}
!2156 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !2130, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!2157 = !DISubprogram(name: "__shared_ptr", scope: !2130, file: !853, line: 1092, type: !2158, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2158 = !DISubroutineType(types: !2159)
!2159 = !{null, !2160}
!2160 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2130, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2161 = !DISubprogram(name: "__shared_ptr", scope: !2130, file: !853, line: 1152, type: !2162, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2162 = !DISubroutineType(types: !2163)
!2163 = !{null, !2160, !2164}
!2164 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2165, size: 64)
!2165 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2130)
!2166 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !2130, file: !853, line: 1153, type: !2167, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2167 = !DISubroutineType(types: !2168)
!2168 = !{!2169, !2160, !2164}
!2169 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2130, size: 64)
!2170 = !DISubprogram(name: "~__shared_ptr", scope: !2130, file: !853, line: 1154, type: !2158, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2171 = !DISubprogram(name: "__shared_ptr", scope: !2130, file: !853, line: 1161, type: !2172, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2172 = !DISubroutineType(types: !2173)
!2173 = !{null, !2160, !2174}
!2174 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2130, size: 64)
!2175 = !DISubprogram(name: "__shared_ptr", scope: !2130, file: !853, line: 1223, type: !2176, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2176 = !DISubroutineType(types: !2177)
!2177 = !{null, !2160, !1004}
!2178 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !2130, file: !853, line: 1248, type: !2179, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2179 = !DISubroutineType(types: !2180)
!2180 = !{!2169, !2160, !2174}
!2181 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !2130, file: !853, line: 1271, type: !2158, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2182 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !2130, file: !853, line: 1295, type: !2183, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2183 = !DISubroutineType(types: !2184)
!2184 = !{!2151, !2185}
!2185 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2165, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2186 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !2130, file: !853, line: 1299, type: !2187, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!2187 = !DISubroutineType(types: !2188)
!2188 = !{!378, !2185}
!2189 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !2130, file: !853, line: 1304, type: !2187, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2190 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !2130, file: !853, line: 1309, type: !2191, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2191 = !DISubroutineType(types: !2192)
!2192 = !{!575, !2185}
!2193 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !2130, file: !853, line: 1314, type: !2194, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2194 = !DISubroutineType(types: !2195)
!2195 = !{null, !2160, !2169}
!2196 = !DISubprogram(name: "__shared_ptr", scope: !2130, file: !853, line: 1352, type: !2197, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!2197 = !DISubroutineType(types: !2198)
!2198 = !{null, !2160, !2199, !915}
!2199 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2200, size: 64)
!2200 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2201)
!2201 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::FutureType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 313, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__weak_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2202 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c1010FutureTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !2130, file: !853, line: 1390, type: !2203, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!2203 = !DISubroutineType(types: !2204)
!2204 = !{!943, !2185, !944}
!2205 = !{!2149, !911}
!2206 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::FutureType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2207, templateParams: !2155, identifier: "_ZTSSt10shared_ptrIN3c1010FutureTypeEE")
!2207 = !{!2208, !2209, !2213, !2218, !2222, !2225, !2229, !2232}
!2208 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2206, baseType: !2130, flags: DIFlagPublic, extraData: i32 0)
!2209 = !DISubprogram(name: "shared_ptr", scope: !2206, file: !1078, line: 148, type: !2210, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2210 = !DISubroutineType(types: !2211)
!2211 = !{null, !2212}
!2212 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2206, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2213 = !DISubprogram(name: "shared_ptr", scope: !2206, file: !1078, line: 150, type: !2214, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2214 = !DISubroutineType(types: !2215)
!2215 = !{null, !2212, !2216}
!2216 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2217, size: 64)
!2217 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2206)
!2218 = !DISubprogram(name: "shared_ptr", scope: !2206, file: !1078, line: 304, type: !2219, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2219 = !DISubroutineType(types: !2220)
!2220 = !{null, !2212, !2221}
!2221 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2206, size: 64)
!2222 = !DISubprogram(name: "shared_ptr", scope: !2206, file: !1078, line: 357, type: !2223, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2223 = !DISubroutineType(types: !2224)
!2224 = !{null, !2212, !1004}
!2225 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1010FutureTypeEEaSERKS2_", scope: !2206, file: !1078, line: 359, type: !2226, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2226 = !DISubroutineType(types: !2227)
!2227 = !{!2228, !2212, !2216}
!2228 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2206, size: 64)
!2229 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1010FutureTypeEEaSEOS2_", scope: !2206, file: !1078, line: 383, type: !2230, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2230 = !DISubroutineType(types: !2231)
!2231 = !{!2228, !2212, !2221}
!2232 = !DISubprogram(name: "shared_ptr", scope: !2206, file: !1078, line: 417, type: !2233, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!2233 = !DISubroutineType(types: !2234)
!2234 = !{null, !2212, !2235, !915}
!2235 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2236, size: 64)
!2236 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2237)
!2237 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::FutureType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c1010FutureTypeEE")
!2238 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::AwaitType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2239, templateParams: !2313, identifier: "_ZTSSt12__shared_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2239 = !{!2240, !2258, !2264, !2265, !2269, !2274, !2278, !2279, !2283, !2286, !2289, !2290, !2294, !2297, !2298, !2301, !2304, !2310}
!2240 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2238, baseType: !2241, flags: DIFlagPublic, extraData: i32 0)
!2241 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::AwaitType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !2242, templateParams: !2256, identifier: "_ZTSSt19__shared_ptr_accessIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!2242 = !{!2243, !2251, !2255}
!2243 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !2241, file: !853, line: 977, type: !2244, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2244 = !DISubroutineType(types: !2245)
!2245 = !{!2246, !2249}
!2246 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2247, size: 64)
!2247 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2241, file: !853, line: 974, baseType: !2248)
!2248 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AwaitType", scope: !36, file: !1582, line: 1059, size: 384, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c109AwaitTypeE")
!2249 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2250, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2250 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2241)
!2251 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !2241, file: !853, line: 984, type: !2252, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2252 = !DISubroutineType(types: !2253)
!2253 = !{!2254, !2249}
!2254 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2247, size: 64)
!2255 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !2241, file: !853, line: 992, type: !2252, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!2256 = !{!2257, !911, !975, !975}
!2257 = !DITemplateTypeParameter(name: "_Tp", type: !2248)
!2258 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !2238, file: !853, line: 1402, baseType: !2259, size: 64)
!2259 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2260, size: 64)
!2260 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2238, file: !853, line: 1056, baseType: !2261)
!2261 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2262, file: !764, line: 1982, baseType: !2248)
!2262 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::AwaitType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !2263, identifier: "_ZTSSt13remove_extentIN3c109AwaitTypeEE")
!2263 = !{!2257}
!2264 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !2238, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!2265 = !DISubprogram(name: "__shared_ptr", scope: !2238, file: !853, line: 1092, type: !2266, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2266 = !DISubroutineType(types: !2267)
!2267 = !{null, !2268}
!2268 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2238, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2269 = !DISubprogram(name: "__shared_ptr", scope: !2238, file: !853, line: 1152, type: !2270, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2270 = !DISubroutineType(types: !2271)
!2271 = !{null, !2268, !2272}
!2272 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2273, size: 64)
!2273 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2238)
!2274 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !2238, file: !853, line: 1153, type: !2275, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2275 = !DISubroutineType(types: !2276)
!2276 = !{!2277, !2268, !2272}
!2277 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2238, size: 64)
!2278 = !DISubprogram(name: "~__shared_ptr", scope: !2238, file: !853, line: 1154, type: !2266, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2279 = !DISubprogram(name: "__shared_ptr", scope: !2238, file: !853, line: 1161, type: !2280, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2280 = !DISubroutineType(types: !2281)
!2281 = !{null, !2268, !2282}
!2282 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2238, size: 64)
!2283 = !DISubprogram(name: "__shared_ptr", scope: !2238, file: !853, line: 1223, type: !2284, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2284 = !DISubroutineType(types: !2285)
!2285 = !{null, !2268, !1004}
!2286 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !2238, file: !853, line: 1248, type: !2287, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2287 = !DISubroutineType(types: !2288)
!2288 = !{!2277, !2268, !2282}
!2289 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !2238, file: !853, line: 1271, type: !2266, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2290 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !2238, file: !853, line: 1295, type: !2291, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2291 = !DISubroutineType(types: !2292)
!2292 = !{!2259, !2293}
!2293 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2273, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2294 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !2238, file: !853, line: 1299, type: !2295, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!2295 = !DISubroutineType(types: !2296)
!2296 = !{!378, !2293}
!2297 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !2238, file: !853, line: 1304, type: !2295, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2298 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !2238, file: !853, line: 1309, type: !2299, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2299 = !DISubroutineType(types: !2300)
!2300 = !{!575, !2293}
!2301 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !2238, file: !853, line: 1314, type: !2302, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2302 = !DISubroutineType(types: !2303)
!2303 = !{null, !2268, !2277}
!2304 = !DISubprogram(name: "__shared_ptr", scope: !2238, file: !853, line: 1352, type: !2305, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!2305 = !DISubroutineType(types: !2306)
!2306 = !{null, !2268, !2307, !915}
!2307 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2308, size: 64)
!2308 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2309)
!2309 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::AwaitType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 313, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__weak_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2310 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c109AwaitTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !2238, file: !853, line: 1390, type: !2311, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!2311 = !DISubroutineType(types: !2312)
!2312 = !{!943, !2293, !944}
!2313 = !{!2257, !911}
!2314 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::AwaitType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2315, templateParams: !2263, identifier: "_ZTSSt10shared_ptrIN3c109AwaitTypeEE")
!2315 = !{!2316, !2317, !2321, !2326, !2330, !2333, !2337, !2340}
!2316 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2314, baseType: !2238, flags: DIFlagPublic, extraData: i32 0)
!2317 = !DISubprogram(name: "shared_ptr", scope: !2314, file: !1078, line: 148, type: !2318, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2318 = !DISubroutineType(types: !2319)
!2319 = !{null, !2320}
!2320 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2314, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2321 = !DISubprogram(name: "shared_ptr", scope: !2314, file: !1078, line: 150, type: !2322, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2322 = !DISubroutineType(types: !2323)
!2323 = !{null, !2320, !2324}
!2324 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2325, size: 64)
!2325 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2314)
!2326 = !DISubprogram(name: "shared_ptr", scope: !2314, file: !1078, line: 304, type: !2327, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2327 = !DISubroutineType(types: !2328)
!2328 = !{null, !2320, !2329}
!2329 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2314, size: 64)
!2330 = !DISubprogram(name: "shared_ptr", scope: !2314, file: !1078, line: 357, type: !2331, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2331 = !DISubroutineType(types: !2332)
!2332 = !{null, !2320, !1004}
!2333 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c109AwaitTypeEEaSERKS2_", scope: !2314, file: !1078, line: 359, type: !2334, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2334 = !DISubroutineType(types: !2335)
!2335 = !{!2336, !2320, !2324}
!2336 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2314, size: 64)
!2337 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c109AwaitTypeEEaSEOS2_", scope: !2314, file: !1078, line: 383, type: !2338, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2338 = !DISubroutineType(types: !2339)
!2339 = !{!2336, !2320, !2329}
!2340 = !DISubprogram(name: "shared_ptr", scope: !2314, file: !1078, line: 417, type: !2341, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!2341 = !DISubroutineType(types: !2342)
!2342 = !{null, !2320, !2343, !915}
!2343 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2344, size: 64)
!2344 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2345)
!2345 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::AwaitType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c109AwaitTypeEE")
!2346 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::RRefType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2347, templateParams: !2421, identifier: "_ZTSSt12__shared_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2347 = !{!2348, !2366, !2372, !2373, !2377, !2382, !2386, !2387, !2391, !2394, !2397, !2398, !2402, !2405, !2406, !2409, !2412, !2418}
!2348 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2346, baseType: !2349, flags: DIFlagPublic, extraData: i32 0)
!2349 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::RRefType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !2350, templateParams: !2364, identifier: "_ZTSSt19__shared_ptr_accessIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!2350 = !{!2351, !2359, !2363}
!2351 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !2349, file: !853, line: 977, type: !2352, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2352 = !DISubroutineType(types: !2353)
!2353 = !{!2354, !2357}
!2354 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2355, size: 64)
!2355 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2349, file: !853, line: 974, baseType: !2356)
!2356 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "RRefType", scope: !36, file: !1582, line: 1101, size: 384, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c108RRefTypeE")
!2357 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2358, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2358 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2349)
!2359 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !2349, file: !853, line: 984, type: !2360, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2360 = !DISubroutineType(types: !2361)
!2361 = !{!2362, !2357}
!2362 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2355, size: 64)
!2363 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !2349, file: !853, line: 992, type: !2360, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!2364 = !{!2365, !911, !975, !975}
!2365 = !DITemplateTypeParameter(name: "_Tp", type: !2356)
!2366 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !2346, file: !853, line: 1402, baseType: !2367, size: 64)
!2367 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2368, size: 64)
!2368 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2346, file: !853, line: 1056, baseType: !2369)
!2369 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2370, file: !764, line: 1982, baseType: !2356)
!2370 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::RRefType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !2371, identifier: "_ZTSSt13remove_extentIN3c108RRefTypeEE")
!2371 = !{!2365}
!2372 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !2346, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!2373 = !DISubprogram(name: "__shared_ptr", scope: !2346, file: !853, line: 1092, type: !2374, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2374 = !DISubroutineType(types: !2375)
!2375 = !{null, !2376}
!2376 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2346, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2377 = !DISubprogram(name: "__shared_ptr", scope: !2346, file: !853, line: 1152, type: !2378, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2378 = !DISubroutineType(types: !2379)
!2379 = !{null, !2376, !2380}
!2380 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2381, size: 64)
!2381 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2346)
!2382 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !2346, file: !853, line: 1153, type: !2383, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2383 = !DISubroutineType(types: !2384)
!2384 = !{!2385, !2376, !2380}
!2385 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2346, size: 64)
!2386 = !DISubprogram(name: "~__shared_ptr", scope: !2346, file: !853, line: 1154, type: !2374, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2387 = !DISubprogram(name: "__shared_ptr", scope: !2346, file: !853, line: 1161, type: !2388, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2388 = !DISubroutineType(types: !2389)
!2389 = !{null, !2376, !2390}
!2390 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2346, size: 64)
!2391 = !DISubprogram(name: "__shared_ptr", scope: !2346, file: !853, line: 1223, type: !2392, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2392 = !DISubroutineType(types: !2393)
!2393 = !{null, !2376, !1004}
!2394 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !2346, file: !853, line: 1248, type: !2395, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2395 = !DISubroutineType(types: !2396)
!2396 = !{!2385, !2376, !2390}
!2397 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !2346, file: !853, line: 1271, type: !2374, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2398 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !2346, file: !853, line: 1295, type: !2399, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2399 = !DISubroutineType(types: !2400)
!2400 = !{!2367, !2401}
!2401 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2381, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2402 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !2346, file: !853, line: 1299, type: !2403, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!2403 = !DISubroutineType(types: !2404)
!2404 = !{!378, !2401}
!2405 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !2346, file: !853, line: 1304, type: !2403, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2406 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !2346, file: !853, line: 1309, type: !2407, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2407 = !DISubroutineType(types: !2408)
!2408 = !{!575, !2401}
!2409 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !2346, file: !853, line: 1314, type: !2410, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2410 = !DISubroutineType(types: !2411)
!2411 = !{null, !2376, !2385}
!2412 = !DISubprogram(name: "__shared_ptr", scope: !2346, file: !853, line: 1352, type: !2413, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!2413 = !DISubroutineType(types: !2414)
!2414 = !{null, !2376, !2415, !915}
!2415 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2416, size: 64)
!2416 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2417)
!2417 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::RRefType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 313, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__weak_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2418 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c108RRefTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !2346, file: !853, line: 1390, type: !2419, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!2419 = !DISubroutineType(types: !2420)
!2420 = !{!943, !2401, !944}
!2421 = !{!2365, !911}
!2422 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::RRefType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2423, templateParams: !2371, identifier: "_ZTSSt10shared_ptrIN3c108RRefTypeEE")
!2423 = !{!2424, !2425, !2429, !2434, !2438, !2441, !2445, !2448}
!2424 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2422, baseType: !2346, flags: DIFlagPublic, extraData: i32 0)
!2425 = !DISubprogram(name: "shared_ptr", scope: !2422, file: !1078, line: 148, type: !2426, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2426 = !DISubroutineType(types: !2427)
!2427 = !{null, !2428}
!2428 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2422, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2429 = !DISubprogram(name: "shared_ptr", scope: !2422, file: !1078, line: 150, type: !2430, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2430 = !DISubroutineType(types: !2431)
!2431 = !{null, !2428, !2432}
!2432 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2433, size: 64)
!2433 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2422)
!2434 = !DISubprogram(name: "shared_ptr", scope: !2422, file: !1078, line: 304, type: !2435, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2435 = !DISubroutineType(types: !2436)
!2436 = !{null, !2428, !2437}
!2437 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2422, size: 64)
!2438 = !DISubprogram(name: "shared_ptr", scope: !2422, file: !1078, line: 357, type: !2439, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2439 = !DISubroutineType(types: !2440)
!2440 = !{null, !2428, !1004}
!2441 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c108RRefTypeEEaSERKS2_", scope: !2422, file: !1078, line: 359, type: !2442, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2442 = !DISubroutineType(types: !2443)
!2443 = !{!2444, !2428, !2432}
!2444 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2422, size: 64)
!2445 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c108RRefTypeEEaSEOS2_", scope: !2422, file: !1078, line: 383, type: !2446, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2446 = !DISubroutineType(types: !2447)
!2447 = !{!2444, !2428, !2437}
!2448 = !DISubprogram(name: "shared_ptr", scope: !2422, file: !1078, line: 417, type: !2449, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!2449 = !DISubroutineType(types: !2450)
!2450 = !{null, !2428, !2451, !915}
!2451 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2452, size: 64)
!2452 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2453)
!2453 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::RRefType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c108RRefTypeEE")
!2454 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::OptionalType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2455, templateParams: !2529, identifier: "_ZTSSt12__shared_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2455 = !{!2456, !2474, !2480, !2481, !2485, !2490, !2494, !2495, !2499, !2502, !2505, !2506, !2510, !2513, !2514, !2517, !2520, !2526}
!2456 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2454, baseType: !2457, flags: DIFlagPublic, extraData: i32 0)
!2457 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::OptionalType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !2458, templateParams: !2472, identifier: "_ZTSSt19__shared_ptr_accessIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!2458 = !{!2459, !2467, !2471}
!2459 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !2457, file: !853, line: 977, type: !2460, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2460 = !DISubroutineType(types: !2461)
!2461 = !{!2462, !2465}
!2462 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2463, size: 64)
!2463 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2457, file: !853, line: 974, baseType: !2464)
!2464 = !DICompositeType(tag: DW_TAG_structure_type, name: "OptionalType", scope: !36, file: !1582, line: 196, size: 704, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!2465 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2466, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2466 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2457)
!2467 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !2457, file: !853, line: 984, type: !2468, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2468 = !DISubroutineType(types: !2469)
!2469 = !{!2470, !2465}
!2470 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2463, size: 64)
!2471 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !2457, file: !853, line: 992, type: !2468, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!2472 = !{!2473, !911, !975, !975}
!2473 = !DITemplateTypeParameter(name: "_Tp", type: !2464)
!2474 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !2454, file: !853, line: 1402, baseType: !2475, size: 64)
!2475 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2476, size: 64)
!2476 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2454, file: !853, line: 1056, baseType: !2477)
!2477 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2478, file: !764, line: 1982, baseType: !2464)
!2478 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::OptionalType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !2479, identifier: "_ZTSSt13remove_extentIN3c1012OptionalTypeEE")
!2479 = !{!2473}
!2480 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !2454, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!2481 = !DISubprogram(name: "__shared_ptr", scope: !2454, file: !853, line: 1092, type: !2482, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2482 = !DISubroutineType(types: !2483)
!2483 = !{null, !2484}
!2484 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2454, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2485 = !DISubprogram(name: "__shared_ptr", scope: !2454, file: !853, line: 1152, type: !2486, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2486 = !DISubroutineType(types: !2487)
!2487 = !{null, !2484, !2488}
!2488 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2489, size: 64)
!2489 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2454)
!2490 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !2454, file: !853, line: 1153, type: !2491, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2491 = !DISubroutineType(types: !2492)
!2492 = !{!2493, !2484, !2488}
!2493 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2454, size: 64)
!2494 = !DISubprogram(name: "~__shared_ptr", scope: !2454, file: !853, line: 1154, type: !2482, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2495 = !DISubprogram(name: "__shared_ptr", scope: !2454, file: !853, line: 1161, type: !2496, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2496 = !DISubroutineType(types: !2497)
!2497 = !{null, !2484, !2498}
!2498 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2454, size: 64)
!2499 = !DISubprogram(name: "__shared_ptr", scope: !2454, file: !853, line: 1223, type: !2500, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2500 = !DISubroutineType(types: !2501)
!2501 = !{null, !2484, !1004}
!2502 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !2454, file: !853, line: 1248, type: !2503, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2503 = !DISubroutineType(types: !2504)
!2504 = !{!2493, !2484, !2498}
!2505 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !2454, file: !853, line: 1271, type: !2482, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2506 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !2454, file: !853, line: 1295, type: !2507, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2507 = !DISubroutineType(types: !2508)
!2508 = !{!2475, !2509}
!2509 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2489, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2510 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !2454, file: !853, line: 1299, type: !2511, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!2511 = !DISubroutineType(types: !2512)
!2512 = !{!378, !2509}
!2513 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !2454, file: !853, line: 1304, type: !2511, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2514 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !2454, file: !853, line: 1309, type: !2515, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2515 = !DISubroutineType(types: !2516)
!2516 = !{!575, !2509}
!2517 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !2454, file: !853, line: 1314, type: !2518, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2518 = !DISubroutineType(types: !2519)
!2519 = !{null, !2484, !2493}
!2520 = !DISubprogram(name: "__shared_ptr", scope: !2454, file: !853, line: 1352, type: !2521, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!2521 = !DISubroutineType(types: !2522)
!2522 = !{null, !2484, !2523, !915}
!2523 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2524, size: 64)
!2524 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2525)
!2525 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::OptionalType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 313, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__weak_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2526 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c1012OptionalTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !2454, file: !853, line: 1390, type: !2527, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!2527 = !DISubroutineType(types: !2528)
!2528 = !{!943, !2509, !944}
!2529 = !{!2473, !911}
!2530 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::OptionalType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2531, templateParams: !2479, identifier: "_ZTSSt10shared_ptrIN3c1012OptionalTypeEE")
!2531 = !{!2532, !2533, !2537, !2542, !2546, !2549, !2553, !2556}
!2532 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2530, baseType: !2454, flags: DIFlagPublic, extraData: i32 0)
!2533 = !DISubprogram(name: "shared_ptr", scope: !2530, file: !1078, line: 148, type: !2534, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2534 = !DISubroutineType(types: !2535)
!2535 = !{null, !2536}
!2536 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2530, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2537 = !DISubprogram(name: "shared_ptr", scope: !2530, file: !1078, line: 150, type: !2538, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2538 = !DISubroutineType(types: !2539)
!2539 = !{null, !2536, !2540}
!2540 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2541, size: 64)
!2541 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2530)
!2542 = !DISubprogram(name: "shared_ptr", scope: !2530, file: !1078, line: 304, type: !2543, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2543 = !DISubroutineType(types: !2544)
!2544 = !{null, !2536, !2545}
!2545 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2530, size: 64)
!2546 = !DISubprogram(name: "shared_ptr", scope: !2530, file: !1078, line: 357, type: !2547, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2547 = !DISubroutineType(types: !2548)
!2548 = !{null, !2536, !1004}
!2549 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1012OptionalTypeEEaSERKS2_", scope: !2530, file: !1078, line: 359, type: !2550, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2550 = !DISubroutineType(types: !2551)
!2551 = !{!2552, !2536, !2540}
!2552 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2530, size: 64)
!2553 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1012OptionalTypeEEaSEOS2_", scope: !2530, file: !1078, line: 383, type: !2554, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2554 = !DISubroutineType(types: !2555)
!2555 = !{!2552, !2536, !2545}
!2556 = !DISubprogram(name: "shared_ptr", scope: !2530, file: !1078, line: 417, type: !2557, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!2557 = !DISubroutineType(types: !2558)
!2558 = !{null, !2536, !2559, !915}
!2559 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2560, size: 64)
!2560 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2561)
!2561 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::OptionalType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c1012OptionalTypeEE")
!2562 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::VarType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2563, templateParams: !2637, identifier: "_ZTSSt12__shared_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2563 = !{!2564, !2582, !2588, !2589, !2593, !2598, !2602, !2603, !2607, !2610, !2613, !2614, !2618, !2621, !2622, !2625, !2628, !2634}
!2564 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2562, baseType: !2565, flags: DIFlagPublic, extraData: i32 0)
!2565 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::VarType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !2566, templateParams: !2580, identifier: "_ZTSSt19__shared_ptr_accessIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!2566 = !{!2567, !2575, !2579}
!2567 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !2565, file: !853, line: 977, type: !2568, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2568 = !DISubroutineType(types: !2569)
!2569 = !{!2570, !2573}
!2570 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2571, size: 64)
!2571 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2565, file: !853, line: 974, baseType: !2572)
!2572 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "VarType", scope: !36, file: !1582, line: 1640, size: 512, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c107VarTypeE")
!2573 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2574, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2574 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2565)
!2575 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !2565, file: !853, line: 984, type: !2576, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2576 = !DISubroutineType(types: !2577)
!2577 = !{!2578, !2573}
!2578 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2571, size: 64)
!2579 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !2565, file: !853, line: 992, type: !2576, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!2580 = !{!2581, !911, !975, !975}
!2581 = !DITemplateTypeParameter(name: "_Tp", type: !2572)
!2582 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !2562, file: !853, line: 1402, baseType: !2583, size: 64)
!2583 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2584, size: 64)
!2584 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2562, file: !853, line: 1056, baseType: !2585)
!2585 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2586, file: !764, line: 1982, baseType: !2572)
!2586 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::VarType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !2587, identifier: "_ZTSSt13remove_extentIN3c107VarTypeEE")
!2587 = !{!2581}
!2588 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !2562, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!2589 = !DISubprogram(name: "__shared_ptr", scope: !2562, file: !853, line: 1092, type: !2590, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2590 = !DISubroutineType(types: !2591)
!2591 = !{null, !2592}
!2592 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2562, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2593 = !DISubprogram(name: "__shared_ptr", scope: !2562, file: !853, line: 1152, type: !2594, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2594 = !DISubroutineType(types: !2595)
!2595 = !{null, !2592, !2596}
!2596 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2597, size: 64)
!2597 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2562)
!2598 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !2562, file: !853, line: 1153, type: !2599, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2599 = !DISubroutineType(types: !2600)
!2600 = !{!2601, !2592, !2596}
!2601 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2562, size: 64)
!2602 = !DISubprogram(name: "~__shared_ptr", scope: !2562, file: !853, line: 1154, type: !2590, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2603 = !DISubprogram(name: "__shared_ptr", scope: !2562, file: !853, line: 1161, type: !2604, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2604 = !DISubroutineType(types: !2605)
!2605 = !{null, !2592, !2606}
!2606 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2562, size: 64)
!2607 = !DISubprogram(name: "__shared_ptr", scope: !2562, file: !853, line: 1223, type: !2608, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2608 = !DISubroutineType(types: !2609)
!2609 = !{null, !2592, !1004}
!2610 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !2562, file: !853, line: 1248, type: !2611, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2611 = !DISubroutineType(types: !2612)
!2612 = !{!2601, !2592, !2606}
!2613 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !2562, file: !853, line: 1271, type: !2590, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2614 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !2562, file: !853, line: 1295, type: !2615, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2615 = !DISubroutineType(types: !2616)
!2616 = !{!2583, !2617}
!2617 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2597, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2618 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !2562, file: !853, line: 1299, type: !2619, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!2619 = !DISubroutineType(types: !2620)
!2620 = !{!378, !2617}
!2621 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !2562, file: !853, line: 1304, type: !2619, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2622 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !2562, file: !853, line: 1309, type: !2623, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2623 = !DISubroutineType(types: !2624)
!2624 = !{!575, !2617}
!2625 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !2562, file: !853, line: 1314, type: !2626, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2626 = !DISubroutineType(types: !2627)
!2627 = !{null, !2592, !2601}
!2628 = !DISubprogram(name: "__shared_ptr", scope: !2562, file: !853, line: 1352, type: !2629, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!2629 = !DISubroutineType(types: !2630)
!2630 = !{null, !2592, !2631, !915}
!2631 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2632, size: 64)
!2632 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2633)
!2633 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::VarType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 313, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__weak_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2634 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c107VarTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !2562, file: !853, line: 1390, type: !2635, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!2635 = !DISubroutineType(types: !2636)
!2636 = !{!943, !2617, !944}
!2637 = !{!2581, !911}
!2638 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::VarType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2639, templateParams: !2587, identifier: "_ZTSSt10shared_ptrIN3c107VarTypeEE")
!2639 = !{!2640, !2641, !2645, !2650, !2654, !2657, !2661, !2664}
!2640 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2638, baseType: !2562, flags: DIFlagPublic, extraData: i32 0)
!2641 = !DISubprogram(name: "shared_ptr", scope: !2638, file: !1078, line: 148, type: !2642, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2642 = !DISubroutineType(types: !2643)
!2643 = !{null, !2644}
!2644 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2638, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2645 = !DISubprogram(name: "shared_ptr", scope: !2638, file: !1078, line: 150, type: !2646, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2646 = !DISubroutineType(types: !2647)
!2647 = !{null, !2644, !2648}
!2648 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2649, size: 64)
!2649 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2638)
!2650 = !DISubprogram(name: "shared_ptr", scope: !2638, file: !1078, line: 304, type: !2651, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2651 = !DISubroutineType(types: !2652)
!2652 = !{null, !2644, !2653}
!2653 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2638, size: 64)
!2654 = !DISubprogram(name: "shared_ptr", scope: !2638, file: !1078, line: 357, type: !2655, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2655 = !DISubroutineType(types: !2656)
!2656 = !{null, !2644, !1004}
!2657 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c107VarTypeEEaSERKS2_", scope: !2638, file: !1078, line: 359, type: !2658, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2658 = !DISubroutineType(types: !2659)
!2659 = !{!2660, !2644, !2648}
!2660 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2638, size: 64)
!2661 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c107VarTypeEEaSEOS2_", scope: !2638, file: !1078, line: 383, type: !2662, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2662 = !DISubroutineType(types: !2663)
!2663 = !{!2660, !2644, !2653}
!2664 = !DISubprogram(name: "shared_ptr", scope: !2638, file: !1078, line: 417, type: !2665, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!2665 = !DISubroutineType(types: !2666)
!2666 = !{null, !2644, !2667, !915}
!2667 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2668, size: 64)
!2668 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2669)
!2669 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::VarType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c107VarTypeEE")
!2670 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::FunctionType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2671, templateParams: !2745, identifier: "_ZTSSt12__shared_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2671 = !{!2672, !2690, !2696, !2697, !2701, !2706, !2710, !2711, !2715, !2718, !2721, !2722, !2726, !2729, !2730, !2733, !2736, !2742}
!2672 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2670, baseType: !2673, flags: DIFlagPublic, extraData: i32 0)
!2673 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::FunctionType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !2674, templateParams: !2688, identifier: "_ZTSSt19__shared_ptr_accessIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!2674 = !{!2675, !2683, !2687}
!2675 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !2673, file: !853, line: 977, type: !2676, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2676 = !DISubroutineType(types: !2677)
!2677 = !{!2678, !2681}
!2678 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2679, size: 64)
!2679 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2673, file: !853, line: 974, baseType: !2680)
!2680 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "FunctionType", scope: !36, file: !1582, line: 1497, size: 1344, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1012FunctionTypeE")
!2681 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2682, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2682 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2673)
!2683 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !2673, file: !853, line: 984, type: !2684, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2684 = !DISubroutineType(types: !2685)
!2685 = !{!2686, !2681}
!2686 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2679, size: 64)
!2687 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !2673, file: !853, line: 992, type: !2684, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!2688 = !{!2689, !911, !975, !975}
!2689 = !DITemplateTypeParameter(name: "_Tp", type: !2680)
!2690 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !2670, file: !853, line: 1402, baseType: !2691, size: 64)
!2691 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2692, size: 64)
!2692 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2670, file: !853, line: 1056, baseType: !2693)
!2693 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2694, file: !764, line: 1982, baseType: !2680)
!2694 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::FunctionType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !2695, identifier: "_ZTSSt13remove_extentIN3c1012FunctionTypeEE")
!2695 = !{!2689}
!2696 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !2670, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!2697 = !DISubprogram(name: "__shared_ptr", scope: !2670, file: !853, line: 1092, type: !2698, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2698 = !DISubroutineType(types: !2699)
!2699 = !{null, !2700}
!2700 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2670, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2701 = !DISubprogram(name: "__shared_ptr", scope: !2670, file: !853, line: 1152, type: !2702, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2702 = !DISubroutineType(types: !2703)
!2703 = !{null, !2700, !2704}
!2704 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2705, size: 64)
!2705 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2670)
!2706 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !2670, file: !853, line: 1153, type: !2707, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2707 = !DISubroutineType(types: !2708)
!2708 = !{!2709, !2700, !2704}
!2709 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2670, size: 64)
!2710 = !DISubprogram(name: "~__shared_ptr", scope: !2670, file: !853, line: 1154, type: !2698, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2711 = !DISubprogram(name: "__shared_ptr", scope: !2670, file: !853, line: 1161, type: !2712, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2712 = !DISubroutineType(types: !2713)
!2713 = !{null, !2700, !2714}
!2714 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2670, size: 64)
!2715 = !DISubprogram(name: "__shared_ptr", scope: !2670, file: !853, line: 1223, type: !2716, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2716 = !DISubroutineType(types: !2717)
!2717 = !{null, !2700, !1004}
!2718 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !2670, file: !853, line: 1248, type: !2719, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2719 = !DISubroutineType(types: !2720)
!2720 = !{!2709, !2700, !2714}
!2721 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !2670, file: !853, line: 1271, type: !2698, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2722 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !2670, file: !853, line: 1295, type: !2723, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2723 = !DISubroutineType(types: !2724)
!2724 = !{!2691, !2725}
!2725 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2705, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2726 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !2670, file: !853, line: 1299, type: !2727, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!2727 = !DISubroutineType(types: !2728)
!2728 = !{!378, !2725}
!2729 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !2670, file: !853, line: 1304, type: !2727, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2730 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !2670, file: !853, line: 1309, type: !2731, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2731 = !DISubroutineType(types: !2732)
!2732 = !{!575, !2725}
!2733 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !2670, file: !853, line: 1314, type: !2734, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2734 = !DISubroutineType(types: !2735)
!2735 = !{null, !2700, !2709}
!2736 = !DISubprogram(name: "__shared_ptr", scope: !2670, file: !853, line: 1352, type: !2737, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!2737 = !DISubroutineType(types: !2738)
!2738 = !{null, !2700, !2739, !915}
!2739 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2740, size: 64)
!2740 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2741)
!2741 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::FunctionType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 313, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__weak_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2742 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c1012FunctionTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !2670, file: !853, line: 1390, type: !2743, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!2743 = !DISubroutineType(types: !2744)
!2744 = !{!943, !2725, !944}
!2745 = !{!2689, !911}
!2746 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::FunctionType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2747, templateParams: !2695, identifier: "_ZTSSt10shared_ptrIN3c1012FunctionTypeEE")
!2747 = !{!2748, !2749, !2753, !2758, !2762, !2765, !2769, !2772}
!2748 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2746, baseType: !2670, flags: DIFlagPublic, extraData: i32 0)
!2749 = !DISubprogram(name: "shared_ptr", scope: !2746, file: !1078, line: 148, type: !2750, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2750 = !DISubroutineType(types: !2751)
!2751 = !{null, !2752}
!2752 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2746, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2753 = !DISubprogram(name: "shared_ptr", scope: !2746, file: !1078, line: 150, type: !2754, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2754 = !DISubroutineType(types: !2755)
!2755 = !{null, !2752, !2756}
!2756 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2757, size: 64)
!2757 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2746)
!2758 = !DISubprogram(name: "shared_ptr", scope: !2746, file: !1078, line: 304, type: !2759, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2759 = !DISubroutineType(types: !2760)
!2760 = !{null, !2752, !2761}
!2761 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2746, size: 64)
!2762 = !DISubprogram(name: "shared_ptr", scope: !2746, file: !1078, line: 357, type: !2763, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2763 = !DISubroutineType(types: !2764)
!2764 = !{null, !2752, !1004}
!2765 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1012FunctionTypeEEaSERKS2_", scope: !2746, file: !1078, line: 359, type: !2766, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2766 = !DISubroutineType(types: !2767)
!2767 = !{!2768, !2752, !2756}
!2768 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2746, size: 64)
!2769 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1012FunctionTypeEEaSEOS2_", scope: !2746, file: !1078, line: 383, type: !2770, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2770 = !DISubroutineType(types: !2771)
!2771 = !{!2768, !2752, !2761}
!2772 = !DISubprogram(name: "shared_ptr", scope: !2746, file: !1078, line: 417, type: !2773, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!2773 = !DISubroutineType(types: !2774)
!2774 = !{null, !2752, !2775, !915}
!2775 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2776, size: 64)
!2776 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2777)
!2777 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::FunctionType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c1012FunctionTypeEE")
!2778 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::UnionType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2779, templateParams: !2853, identifier: "_ZTSSt12__shared_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2779 = !{!2780, !2798, !2804, !2805, !2809, !2814, !2818, !2819, !2823, !2826, !2829, !2830, !2834, !2837, !2838, !2841, !2844, !2850}
!2780 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2778, baseType: !2781, flags: DIFlagPublic, extraData: i32 0)
!2781 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::UnionType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !2782, templateParams: !2796, identifier: "_ZTSSt19__shared_ptr_accessIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!2782 = !{!2783, !2791, !2795}
!2783 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !2781, file: !853, line: 977, type: !2784, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2784 = !DISubroutineType(types: !2785)
!2785 = !{!2786, !2789}
!2786 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2787, size: 64)
!2787 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2781, file: !853, line: 974, baseType: !2788)
!2788 = !DICompositeType(tag: DW_TAG_structure_type, name: "UnionType", scope: !36, file: !1582, line: 131, size: 576, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!2789 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2790, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2790 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2781)
!2791 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !2781, file: !853, line: 984, type: !2792, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2792 = !DISubroutineType(types: !2793)
!2793 = !{!2794, !2789}
!2794 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2787, size: 64)
!2795 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !2781, file: !853, line: 992, type: !2792, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!2796 = !{!2797, !911, !975, !975}
!2797 = !DITemplateTypeParameter(name: "_Tp", type: !2788)
!2798 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !2778, file: !853, line: 1402, baseType: !2799, size: 64)
!2799 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2800, size: 64)
!2800 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2778, file: !853, line: 1056, baseType: !2801)
!2801 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2802, file: !764, line: 1982, baseType: !2788)
!2802 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::UnionType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !2803, identifier: "_ZTSSt13remove_extentIN3c109UnionTypeEE")
!2803 = !{!2797}
!2804 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !2778, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!2805 = !DISubprogram(name: "__shared_ptr", scope: !2778, file: !853, line: 1092, type: !2806, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2806 = !DISubroutineType(types: !2807)
!2807 = !{null, !2808}
!2808 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2778, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2809 = !DISubprogram(name: "__shared_ptr", scope: !2778, file: !853, line: 1152, type: !2810, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2810 = !DISubroutineType(types: !2811)
!2811 = !{null, !2808, !2812}
!2812 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2813, size: 64)
!2813 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2778)
!2814 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !2778, file: !853, line: 1153, type: !2815, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2815 = !DISubroutineType(types: !2816)
!2816 = !{!2817, !2808, !2812}
!2817 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2778, size: 64)
!2818 = !DISubprogram(name: "~__shared_ptr", scope: !2778, file: !853, line: 1154, type: !2806, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2819 = !DISubprogram(name: "__shared_ptr", scope: !2778, file: !853, line: 1161, type: !2820, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2820 = !DISubroutineType(types: !2821)
!2821 = !{null, !2808, !2822}
!2822 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2778, size: 64)
!2823 = !DISubprogram(name: "__shared_ptr", scope: !2778, file: !853, line: 1223, type: !2824, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2824 = !DISubroutineType(types: !2825)
!2825 = !{null, !2808, !1004}
!2826 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !2778, file: !853, line: 1248, type: !2827, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2827 = !DISubroutineType(types: !2828)
!2828 = !{!2817, !2808, !2822}
!2829 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !2778, file: !853, line: 1271, type: !2806, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2830 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !2778, file: !853, line: 1295, type: !2831, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2831 = !DISubroutineType(types: !2832)
!2832 = !{!2799, !2833}
!2833 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2813, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2834 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !2778, file: !853, line: 1299, type: !2835, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!2835 = !DISubroutineType(types: !2836)
!2836 = !{!378, !2833}
!2837 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !2778, file: !853, line: 1304, type: !2835, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2838 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !2778, file: !853, line: 1309, type: !2839, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2839 = !DISubroutineType(types: !2840)
!2840 = !{!575, !2833}
!2841 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !2778, file: !853, line: 1314, type: !2842, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2842 = !DISubroutineType(types: !2843)
!2843 = !{null, !2808, !2817}
!2844 = !DISubprogram(name: "__shared_ptr", scope: !2778, file: !853, line: 1352, type: !2845, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!2845 = !DISubroutineType(types: !2846)
!2846 = !{null, !2808, !2847, !915}
!2847 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2848, size: 64)
!2848 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2849)
!2849 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::UnionType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 313, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__weak_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2850 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c109UnionTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !2778, file: !853, line: 1390, type: !2851, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!2851 = !DISubroutineType(types: !2852)
!2852 = !{!943, !2833, !944}
!2853 = !{!2797, !911}
!2854 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::UnionType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2855, templateParams: !2803, identifier: "_ZTSSt10shared_ptrIN3c109UnionTypeEE")
!2855 = !{!2856, !2857, !2861, !2866, !2870, !2873, !2877, !2880}
!2856 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2854, baseType: !2778, flags: DIFlagPublic, extraData: i32 0)
!2857 = !DISubprogram(name: "shared_ptr", scope: !2854, file: !1078, line: 148, type: !2858, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2858 = !DISubroutineType(types: !2859)
!2859 = !{null, !2860}
!2860 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2854, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2861 = !DISubprogram(name: "shared_ptr", scope: !2854, file: !1078, line: 150, type: !2862, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2862 = !DISubroutineType(types: !2863)
!2863 = !{null, !2860, !2864}
!2864 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2865, size: 64)
!2865 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2854)
!2866 = !DISubprogram(name: "shared_ptr", scope: !2854, file: !1078, line: 304, type: !2867, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2867 = !DISubroutineType(types: !2868)
!2868 = !{null, !2860, !2869}
!2869 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2854, size: 64)
!2870 = !DISubprogram(name: "shared_ptr", scope: !2854, file: !1078, line: 357, type: !2871, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2871 = !DISubroutineType(types: !2872)
!2872 = !{null, !2860, !1004}
!2873 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c109UnionTypeEEaSERKS2_", scope: !2854, file: !1078, line: 359, type: !2874, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2874 = !DISubroutineType(types: !2875)
!2875 = !{!2876, !2860, !2864}
!2876 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2854, size: 64)
!2877 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c109UnionTypeEEaSEOS2_", scope: !2854, file: !1078, line: 383, type: !2878, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2878 = !DISubroutineType(types: !2879)
!2879 = !{!2876, !2860, !2869}
!2880 = !DISubprogram(name: "shared_ptr", scope: !2854, file: !1078, line: 417, type: !2881, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!2881 = !DISubroutineType(types: !2882)
!2882 = !{null, !2860, !2883, !915}
!2883 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2884, size: 64)
!2884 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2885)
!2885 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::UnionType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c109UnionTypeEE")
!2886 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::DynamicType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2887, templateParams: !2962, identifier: "_ZTSSt12__shared_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2887 = !{!2888, !2907, !2913, !2914, !2918, !2923, !2927, !2928, !2932, !2935, !2938, !2939, !2943, !2946, !2947, !2950, !2953, !2959}
!2888 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2886, baseType: !2889, flags: DIFlagPublic, extraData: i32 0)
!2889 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::DynamicType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !2890, templateParams: !2905, identifier: "_ZTSSt19__shared_ptr_accessIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!2890 = !{!2891, !2900, !2904}
!2891 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !2889, file: !853, line: 977, type: !2892, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2892 = !DISubroutineType(types: !2893)
!2893 = !{!2894, !2898}
!2894 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2895, size: 64)
!2895 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2889, file: !853, line: 974, baseType: !2896)
!2896 = !DICompositeType(tag: DW_TAG_class_type, name: "DynamicType", scope: !36, file: !2897, line: 117, size: 832, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!2897 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/dynamic_type.h", directory: "/home/mvh6224/CUDA-BOSolver")
!2898 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2899, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2899 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2889)
!2900 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !2889, file: !853, line: 984, type: !2901, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2901 = !DISubroutineType(types: !2902)
!2902 = !{!2903, !2898}
!2903 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2895, size: 64)
!2904 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !2889, file: !853, line: 992, type: !2901, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!2905 = !{!2906, !911, !975, !975}
!2906 = !DITemplateTypeParameter(name: "_Tp", type: !2896)
!2907 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !2886, file: !853, line: 1402, baseType: !2908, size: 64)
!2908 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2909, size: 64)
!2909 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !2886, file: !853, line: 1056, baseType: !2910)
!2910 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !2911, file: !764, line: 1982, baseType: !2896)
!2911 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::DynamicType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !2912, identifier: "_ZTSSt13remove_extentIN3c1011DynamicTypeEE")
!2912 = !{!2906}
!2913 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !2886, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!2914 = !DISubprogram(name: "__shared_ptr", scope: !2886, file: !853, line: 1092, type: !2915, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2915 = !DISubroutineType(types: !2916)
!2916 = !{null, !2917}
!2917 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2886, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2918 = !DISubprogram(name: "__shared_ptr", scope: !2886, file: !853, line: 1152, type: !2919, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2919 = !DISubroutineType(types: !2920)
!2920 = !{null, !2917, !2921}
!2921 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2922, size: 64)
!2922 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2886)
!2923 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !2886, file: !853, line: 1153, type: !2924, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2924 = !DISubroutineType(types: !2925)
!2925 = !{!2926, !2917, !2921}
!2926 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2886, size: 64)
!2927 = !DISubprogram(name: "~__shared_ptr", scope: !2886, file: !853, line: 1154, type: !2915, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2928 = !DISubprogram(name: "__shared_ptr", scope: !2886, file: !853, line: 1161, type: !2929, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2929 = !DISubroutineType(types: !2930)
!2930 = !{null, !2917, !2931}
!2931 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2886, size: 64)
!2932 = !DISubprogram(name: "__shared_ptr", scope: !2886, file: !853, line: 1223, type: !2933, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2933 = !DISubroutineType(types: !2934)
!2934 = !{null, !2917, !1004}
!2935 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !2886, file: !853, line: 1248, type: !2936, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2936 = !DISubroutineType(types: !2937)
!2937 = !{!2926, !2917, !2931}
!2938 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !2886, file: !853, line: 1271, type: !2915, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2939 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !2886, file: !853, line: 1295, type: !2940, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2940 = !DISubroutineType(types: !2941)
!2941 = !{!2908, !2942}
!2942 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2922, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2943 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !2886, file: !853, line: 1299, type: !2944, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!2944 = !DISubroutineType(types: !2945)
!2945 = !{!378, !2942}
!2946 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !2886, file: !853, line: 1304, type: !2944, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2947 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !2886, file: !853, line: 1309, type: !2948, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2948 = !DISubroutineType(types: !2949)
!2949 = !{!575, !2942}
!2950 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !2886, file: !853, line: 1314, type: !2951, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2951 = !DISubroutineType(types: !2952)
!2952 = !{null, !2917, !2926}
!2953 = !DISubprogram(name: "__shared_ptr", scope: !2886, file: !853, line: 1352, type: !2954, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!2954 = !DISubroutineType(types: !2955)
!2955 = !{null, !2917, !2956, !915}
!2956 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2957, size: 64)
!2957 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2958)
!2958 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::DynamicType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 313, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__weak_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EE")
!2959 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c1011DynamicTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !2886, file: !853, line: 1390, type: !2960, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!2960 = !DISubroutineType(types: !2961)
!2961 = !{!943, !2942, !944}
!2962 = !{!2906, !911}
!2963 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::DynamicType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !2964, templateParams: !2912, identifier: "_ZTSSt10shared_ptrIN3c1011DynamicTypeEE")
!2964 = !{!2965, !2966, !2970, !2975, !2979, !2982, !2986, !2989}
!2965 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !2963, baseType: !2886, flags: DIFlagPublic, extraData: i32 0)
!2966 = !DISubprogram(name: "shared_ptr", scope: !2963, file: !1078, line: 148, type: !2967, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2967 = !DISubroutineType(types: !2968)
!2968 = !{null, !2969}
!2969 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2963, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!2970 = !DISubprogram(name: "shared_ptr", scope: !2963, file: !1078, line: 150, type: !2971, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2971 = !DISubroutineType(types: !2972)
!2972 = !{null, !2969, !2973}
!2973 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2974, size: 64)
!2974 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2963)
!2975 = !DISubprogram(name: "shared_ptr", scope: !2963, file: !1078, line: 304, type: !2976, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2976 = !DISubroutineType(types: !2977)
!2977 = !{null, !2969, !2978}
!2978 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !2963, size: 64)
!2979 = !DISubprogram(name: "shared_ptr", scope: !2963, file: !1078, line: 357, type: !2980, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2980 = !DISubroutineType(types: !2981)
!2981 = !{null, !2969, !1004}
!2982 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1011DynamicTypeEEaSERKS2_", scope: !2963, file: !1078, line: 359, type: !2983, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2983 = !DISubroutineType(types: !2984)
!2984 = !{!2985, !2969, !2973}
!2985 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2963, size: 64)
!2986 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1011DynamicTypeEEaSEOS2_", scope: !2963, file: !1078, line: 383, type: !2987, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!2987 = !DISubroutineType(types: !2988)
!2988 = !{!2985, !2969, !2978}
!2989 = !DISubprogram(name: "shared_ptr", scope: !2963, file: !1078, line: 417, type: !2990, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!2990 = !DISubroutineType(types: !2991)
!2991 = !{null, !2969, !2992, !915}
!2992 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2993, size: 64)
!2993 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2994)
!2994 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::DynamicType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c1011DynamicTypeEE")
!2995 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "default_delete<torch::jit::Function>", scope: !2, file: !2996, line: 63, size: 8, flags: DIFlagTypePassByValue, elements: !2997, templateParams: !3011, identifier: "_ZTSSt14default_deleteIN5torch3jit8FunctionEE")
!2996 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/unique_ptr.h", directory: "")
!2997 = !{!2998, !3002}
!2998 = !DISubprogram(name: "default_delete", scope: !2995, file: !2996, line: 66, type: !2999, scopeLine: 66, flags: DIFlagPrototyped, spFlags: 0)
!2999 = !DISubroutineType(types: !3000)
!3000 = !{null, !3001}
!3001 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2995, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3002 = !DISubprogram(name: "operator()", linkageName: "_ZNKSt14default_deleteIN5torch3jit8FunctionEEclEPS2_", scope: !2995, file: !2996, line: 79, type: !3003, scopeLine: 79, flags: DIFlagPrototyped, spFlags: 0)
!3003 = !DISubroutineType(types: !3004)
!3004 = !{null, !3005, !3007}
!3005 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3006, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3006 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !2995)
!3007 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3008, size: 64)
!3008 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Function", scope: !3010, file: !3009, line: 39, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN5torch3jit8FunctionE")
!3009 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/function.h", directory: "/home/mvh6224/CUDA-BOSolver")
!3010 = !DINamespace(name: "jit", scope: !327)
!3011 = !{!3012}
!3012 = !DITemplateTypeParameter(name: "_Tp", type: !3008)
!3013 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Head_base<1, std::default_delete<torch::jit::Function>, true>", scope: !2, file: !3014, line: 78, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !3015, templateParams: !3065, identifier: "_ZTSSt10_Head_baseILm1ESt14default_deleteIN5torch3jit8FunctionEELb1EE")
!3014 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/tuple", directory: "")
!3015 = !{!3016, !3017, !3021, !3025, !3030, !3034, !3057, !3062}
!3016 = !DIDerivedType(tag: DW_TAG_member, name: "_M_head_impl", scope: !3013, file: !3014, line: 129, baseType: !2995, size: 8)
!3017 = !DISubprogram(name: "_Head_base", scope: !3013, file: !3014, line: 80, type: !3018, scopeLine: 80, flags: DIFlagPrototyped, spFlags: 0)
!3018 = !DISubroutineType(types: !3019)
!3019 = !{null, !3020}
!3020 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3013, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3021 = !DISubprogram(name: "_Head_base", scope: !3013, file: !3014, line: 83, type: !3022, scopeLine: 83, flags: DIFlagPrototyped, spFlags: 0)
!3022 = !DISubroutineType(types: !3023)
!3023 = !{null, !3020, !3024}
!3024 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3006, size: 64)
!3025 = !DISubprogram(name: "_Head_base", scope: !3013, file: !3014, line: 86, type: !3026, scopeLine: 86, flags: DIFlagPrototyped, spFlags: 0)
!3026 = !DISubroutineType(types: !3027)
!3027 = !{null, !3020, !3028}
!3028 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3029, size: 64)
!3029 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3013)
!3030 = !DISubprogram(name: "_Head_base", scope: !3013, file: !3014, line: 87, type: !3031, scopeLine: 87, flags: DIFlagPrototyped, spFlags: 0)
!3031 = !DISubroutineType(types: !3032)
!3032 = !{null, !3020, !3033}
!3033 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3013, size: 64)
!3034 = !DISubprogram(name: "_Head_base", scope: !3013, file: !3014, line: 94, type: !3035, scopeLine: 94, flags: DIFlagPrototyped, spFlags: 0)
!3035 = !DISubroutineType(types: !3036)
!3036 = !{null, !3020, !3037, !3044}
!3037 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "allocator_arg_t", scope: !2, file: !3038, line: 51, size: 8, flags: DIFlagTypePassByValue, elements: !3039, identifier: "_ZTSSt15allocator_arg_t")
!3038 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/uses_allocator.h", directory: "")
!3039 = !{!3040}
!3040 = !DISubprogram(name: "allocator_arg_t", scope: !3037, file: !3038, line: 51, type: !3041, scopeLine: 51, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!3041 = !DISubroutineType(types: !3042)
!3042 = !{null, !3043}
!3043 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3037, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3044 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__uses_alloc0", scope: !2, file: !3038, line: 74, size: 8, flags: DIFlagTypePassByValue, elements: !3045, identifier: "_ZTSSt13__uses_alloc0")
!3045 = !{!3046, !3048}
!3046 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3044, baseType: !3047, extraData: i32 0)
!3047 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__uses_alloc_base", scope: !2, file: !3038, line: 72, size: 8, flags: DIFlagTypePassByValue, elements: !843, identifier: "_ZTSSt17__uses_alloc_base")
!3048 = !DIDerivedType(tag: DW_TAG_member, name: "_M_a", scope: !3044, file: !3038, line: 76, baseType: !3049, size: 8)
!3049 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Sink", scope: !3044, file: !3038, line: 76, size: 8, flags: DIFlagTypePassByValue, elements: !3050, identifier: "_ZTSNSt13__uses_alloc05_SinkE")
!3050 = !{!3051}
!3051 = !DISubprogram(name: "operator=", linkageName: "_ZNSt13__uses_alloc05_SinkaSEPKv", scope: !3049, file: !3038, line: 76, type: !3052, scopeLine: 76, flags: DIFlagPrototyped, spFlags: 0)
!3052 = !DISubroutineType(types: !3053)
!3053 = !{null, !3054, !3055}
!3054 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3049, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3055 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3056, size: 64)
!3056 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!3057 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm1ESt14default_deleteIN5torch3jit8FunctionEELb1EE7_M_headERS5_", scope: !3013, file: !3014, line: 124, type: !3058, scopeLine: 124, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3058 = !DISubroutineType(types: !3059)
!3059 = !{!3060, !3061}
!3060 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !2995, size: 64)
!3061 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3013, size: 64)
!3062 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm1ESt14default_deleteIN5torch3jit8FunctionEELb1EE7_M_headERKS5_", scope: !3013, file: !3014, line: 127, type: !3063, scopeLine: 127, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3063 = !DISubroutineType(types: !3064)
!3064 = !{!3024, !3028}
!3065 = !{!3066, !3067, !1168}
!3066 = !DITemplateValueParameter(name: "_Idx", type: !1290, value: i64 1)
!3067 = !DITemplateTypeParameter(name: "_Head", type: !2995)
!3068 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Tuple_impl<1, std::default_delete<torch::jit::Function> >", scope: !2, file: !3014, line: 416, size: 8, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3069, templateParams: !3100, identifier: "_ZTSSt11_Tuple_implILm1EJSt14default_deleteIN5torch3jit8FunctionEEEE")
!3069 = !{!3070, !3071, !3075, !3080, !3084, !3087, !3090, !3093, !3097}
!3070 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3068, baseType: !3013, flags: DIFlagPrivate, extraData: i32 0)
!3071 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN5torch3jit8FunctionEEEE7_M_headERS5_", scope: !3068, file: !3014, line: 424, type: !3072, scopeLine: 424, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3072 = !DISubroutineType(types: !3073)
!3073 = !{!3060, !3074}
!3074 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3068, size: 64)
!3075 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN5torch3jit8FunctionEEEE7_M_headERKS5_", scope: !3068, file: !3014, line: 427, type: !3076, scopeLine: 427, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3076 = !DISubroutineType(types: !3077)
!3077 = !{!3024, !3078}
!3078 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3079, size: 64)
!3079 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3068)
!3080 = !DISubprogram(name: "_Tuple_impl", scope: !3068, file: !3014, line: 430, type: !3081, scopeLine: 430, flags: DIFlagPrototyped, spFlags: 0)
!3081 = !DISubroutineType(types: !3082)
!3082 = !{null, !3083}
!3083 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3068, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3084 = !DISubprogram(name: "_Tuple_impl", scope: !3068, file: !3014, line: 434, type: !3085, scopeLine: 434, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!3085 = !DISubroutineType(types: !3086)
!3086 = !{null, !3083, !3024}
!3087 = !DISubprogram(name: "_Tuple_impl", scope: !3068, file: !3014, line: 444, type: !3088, scopeLine: 444, flags: DIFlagPrototyped, spFlags: 0)
!3088 = !DISubroutineType(types: !3089)
!3089 = !{null, !3083, !3078}
!3090 = !DISubprogram(name: "operator=", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN5torch3jit8FunctionEEEEaSERKS5_", scope: !3068, file: !3014, line: 448, type: !3091, scopeLine: 448, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!3091 = !DISubroutineType(types: !3092)
!3092 = !{!3074, !3083, !3078}
!3093 = !DISubprogram(name: "_Tuple_impl", scope: !3068, file: !3014, line: 454, type: !3094, scopeLine: 454, flags: DIFlagPrototyped, spFlags: 0)
!3094 = !DISubroutineType(types: !3095)
!3095 = !{null, !3083, !3096}
!3096 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3068, size: 64)
!3097 = !DISubprogram(name: "_M_swap", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN5torch3jit8FunctionEEEE7_M_swapERS5_", scope: !3068, file: !3014, line: 544, type: !3098, scopeLine: 544, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!3098 = !DISubroutineType(types: !3099)
!3099 = !{null, !3083, !3074}
!3100 = !{!3066, !3101}
!3101 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "_Elements", value: !3102)
!3102 = !{!3103}
!3103 = !DITemplateTypeParameter(type: !2995)
!3104 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Head_base<0, torch::jit::Function *, false>", scope: !2, file: !3014, line: 187, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !3105, templateParams: !3136, identifier: "_ZTSSt10_Head_baseILm0EPN5torch3jit8FunctionELb0EE")
!3105 = !{!3106, !3107, !3111, !3116, !3121, !3125, !3128, !3133}
!3106 = !DIDerivedType(tag: DW_TAG_member, name: "_M_head_impl", scope: !3104, file: !3014, line: 238, baseType: !3007, size: 64)
!3107 = !DISubprogram(name: "_Head_base", scope: !3104, file: !3014, line: 189, type: !3108, scopeLine: 189, flags: DIFlagPrototyped, spFlags: 0)
!3108 = !DISubroutineType(types: !3109)
!3109 = !{null, !3110}
!3110 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3104, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3111 = !DISubprogram(name: "_Head_base", scope: !3104, file: !3014, line: 192, type: !3112, scopeLine: 192, flags: DIFlagPrototyped, spFlags: 0)
!3112 = !DISubroutineType(types: !3113)
!3113 = !{null, !3110, !3114}
!3114 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3115, size: 64)
!3115 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3007)
!3116 = !DISubprogram(name: "_Head_base", scope: !3104, file: !3014, line: 195, type: !3117, scopeLine: 195, flags: DIFlagPrototyped, spFlags: 0)
!3117 = !DISubroutineType(types: !3118)
!3118 = !{null, !3110, !3119}
!3119 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3120, size: 64)
!3120 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3104)
!3121 = !DISubprogram(name: "_Head_base", scope: !3104, file: !3014, line: 196, type: !3122, scopeLine: 196, flags: DIFlagPrototyped, spFlags: 0)
!3122 = !DISubroutineType(types: !3123)
!3123 = !{null, !3110, !3124}
!3124 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3104, size: 64)
!3125 = !DISubprogram(name: "_Head_base", scope: !3104, file: !3014, line: 203, type: !3126, scopeLine: 203, flags: DIFlagPrototyped, spFlags: 0)
!3126 = !DISubroutineType(types: !3127)
!3127 = !{null, !3110, !3037, !3044}
!3128 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm0EPN5torch3jit8FunctionELb0EE7_M_headERS4_", scope: !3104, file: !3014, line: 233, type: !3129, scopeLine: 233, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3129 = !DISubroutineType(types: !3130)
!3130 = !{!3131, !3132}
!3131 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3007, size: 64)
!3132 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3104, size: 64)
!3133 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm0EPN5torch3jit8FunctionELb0EE7_M_headERKS4_", scope: !3104, file: !3014, line: 236, type: !3134, scopeLine: 236, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3134 = !DISubroutineType(types: !3135)
!3135 = !{!3114, !3119}
!3136 = !{!3137, !3138, !975}
!3137 = !DITemplateValueParameter(name: "_Idx", type: !1290, value: i64 0)
!3138 = !DITemplateTypeParameter(name: "_Head", type: !3007)
!3139 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Tuple_impl<0, torch::jit::Function *, std::default_delete<torch::jit::Function> >", scope: !2, file: !3014, line: 258, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3140, templateParams: !3182, identifier: "_ZTSSt11_Tuple_implILm0EJPN5torch3jit8FunctionESt14default_deleteIS2_EEE")
!3140 = !{!3141, !3142, !3143, !3147, !3152, !3157, !3162, !3166, !3169, !3172, !3175, !3179}
!3141 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3139, baseType: !3068, extraData: i32 0)
!3142 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3139, baseType: !3104, flags: DIFlagPrivate, extraData: i32 0)
!3143 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm0EJPN5torch3jit8FunctionESt14default_deleteIS2_EEE7_M_headERS6_", scope: !3139, file: !3014, line: 268, type: !3144, scopeLine: 268, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3144 = !DISubroutineType(types: !3145)
!3145 = !{!3131, !3146}
!3146 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3139, size: 64)
!3147 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm0EJPN5torch3jit8FunctionESt14default_deleteIS2_EEE7_M_headERKS6_", scope: !3139, file: !3014, line: 271, type: !3148, scopeLine: 271, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3148 = !DISubroutineType(types: !3149)
!3149 = !{!3114, !3150}
!3150 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3151, size: 64)
!3151 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3139)
!3152 = !DISubprogram(name: "_M_tail", linkageName: "_ZNSt11_Tuple_implILm0EJPN5torch3jit8FunctionESt14default_deleteIS2_EEE7_M_tailERS6_", scope: !3139, file: !3014, line: 274, type: !3153, scopeLine: 274, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3153 = !DISubroutineType(types: !3154)
!3154 = !{!3155, !3146}
!3155 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3156, size: 64)
!3156 = !DIDerivedType(tag: DW_TAG_typedef, name: "_Inherited", scope: !3139, file: !3014, line: 264, baseType: !3068)
!3157 = !DISubprogram(name: "_M_tail", linkageName: "_ZNSt11_Tuple_implILm0EJPN5torch3jit8FunctionESt14default_deleteIS2_EEE7_M_tailERKS6_", scope: !3139, file: !3014, line: 277, type: !3158, scopeLine: 277, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3158 = !DISubroutineType(types: !3159)
!3159 = !{!3160, !3150}
!3160 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3161, size: 64)
!3161 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3156)
!3162 = !DISubprogram(name: "_Tuple_impl", scope: !3139, file: !3014, line: 279, type: !3163, scopeLine: 279, flags: DIFlagPrototyped, spFlags: 0)
!3163 = !DISubroutineType(types: !3164)
!3164 = !{null, !3165}
!3165 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3139, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3166 = !DISubprogram(name: "_Tuple_impl", scope: !3139, file: !3014, line: 283, type: !3167, scopeLine: 283, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!3167 = !DISubroutineType(types: !3168)
!3168 = !{null, !3165, !3114, !3024}
!3169 = !DISubprogram(name: "_Tuple_impl", scope: !3139, file: !3014, line: 295, type: !3170, scopeLine: 295, flags: DIFlagPrototyped, spFlags: 0)
!3170 = !DISubroutineType(types: !3171)
!3171 = !{null, !3165, !3150}
!3172 = !DISubprogram(name: "operator=", linkageName: "_ZNSt11_Tuple_implILm0EJPN5torch3jit8FunctionESt14default_deleteIS2_EEEaSERKS6_", scope: !3139, file: !3014, line: 299, type: !3173, scopeLine: 299, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!3173 = !DISubroutineType(types: !3174)
!3174 = !{!3146, !3165, !3150}
!3175 = !DISubprogram(name: "_Tuple_impl", scope: !3139, file: !3014, line: 301, type: !3176, scopeLine: 301, flags: DIFlagPrototyped, spFlags: 0)
!3176 = !DISubroutineType(types: !3177)
!3177 = !{null, !3165, !3178}
!3178 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3139, size: 64)
!3179 = !DISubprogram(name: "_M_swap", linkageName: "_ZNSt11_Tuple_implILm0EJPN5torch3jit8FunctionESt14default_deleteIS2_EEE7_M_swapERS6_", scope: !3139, file: !3014, line: 406, type: !3180, scopeLine: 406, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!3180 = !DISubroutineType(types: !3181)
!3181 = !{null, !3165, !3146}
!3182 = !{!3137, !3183}
!3183 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "_Elements", value: !3184)
!3184 = !{!3185, !3103}
!3185 = !DITemplateTypeParameter(type: !3007)
!3186 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "tuple<torch::jit::Function *, std::default_delete<torch::jit::Function> >", scope: !2, file: !3014, line: 981, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3187, templateParams: !3227, identifier: "_ZTSSt5tupleIJPN5torch3jit8FunctionESt14default_deleteIS2_EEE")
!3187 = !{!3188, !3189, !3192, !3198, !3202, !3215, !3224}
!3188 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3186, baseType: !3139, flags: DIFlagPublic, extraData: i32 0)
!3189 = !DISubprogram(name: "__nothrow_default_constructible", linkageName: "_ZNSt5tupleIJPN5torch3jit8FunctionESt14default_deleteIS2_EEE31__nothrow_default_constructibleEv", scope: !3186, file: !3014, line: 1035, type: !3190, scopeLine: 1035, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3190 = !DISubroutineType(types: !3191)
!3191 = !{!378}
!3192 = !DISubprogram(name: "tuple", scope: !3186, file: !3014, line: 1088, type: !3193, scopeLine: 1088, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3193 = !DISubroutineType(types: !3194)
!3194 = !{null, !3195, !3196}
!3195 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3186, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3196 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3197, size: 64)
!3197 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3186)
!3198 = !DISubprogram(name: "tuple", scope: !3186, file: !3014, line: 1090, type: !3199, scopeLine: 1090, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3199 = !DISubroutineType(types: !3200)
!3200 = !{null, !3195, !3201}
!3201 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3186, size: 64)
!3202 = !DISubprogram(name: "operator=", linkageName: "_ZNSt5tupleIJPN5torch3jit8FunctionESt14default_deleteIS2_EEEaSERKS6_", scope: !3186, file: !3014, line: 1267, type: !3203, scopeLine: 1267, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3203 = !DISubroutineType(types: !3204)
!3204 = !{!3205, !3195, !3206}
!3205 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3186, size: 64)
!3206 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !3207, file: !764, line: 2221, baseType: !3196)
!3207 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "conditional<true, const std::tuple<torch::jit::Function *, std::default_delete<torch::jit::Function> > &, const std::__nonesuch &>", scope: !2, file: !764, line: 2220, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !3208, identifier: "_ZTSSt11conditionalILb1ERKSt5tupleIJPN5torch3jit8FunctionESt14default_deleteIS3_EEERKSt10__nonesuchE")
!3208 = !{!3209, !3210, !3211}
!3209 = !DITemplateValueParameter(name: "_Cond", type: !378, value: i1 true)
!3210 = !DITemplateTypeParameter(name: "_Iftrue", type: !3196)
!3211 = !DITemplateTypeParameter(name: "_Iffalse", type: !3212)
!3212 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3213, size: 64)
!3213 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3214)
!3214 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__nonesuch", scope: !2, file: !764, line: 2991, size: 8, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt10__nonesuch")
!3215 = !DISubprogram(name: "operator=", linkageName: "_ZNSt5tupleIJPN5torch3jit8FunctionESt14default_deleteIS2_EEEaSEOS6_", scope: !3186, file: !3014, line: 1278, type: !3216, scopeLine: 1278, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3216 = !DISubroutineType(types: !3217)
!3217 = !{!3205, !3195, !3218}
!3218 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !3219, file: !764, line: 2221, baseType: !3201)
!3219 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "conditional<true, std::tuple<torch::jit::Function *, std::default_delete<torch::jit::Function> > &&, std::__nonesuch &&>", scope: !2, file: !764, line: 2220, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !3220, identifier: "_ZTSSt11conditionalILb1EOSt5tupleIJPN5torch3jit8FunctionESt14default_deleteIS3_EEEOSt10__nonesuchE")
!3220 = !{!3209, !3221, !3222}
!3221 = !DITemplateTypeParameter(name: "_Iftrue", type: !3201)
!3222 = !DITemplateTypeParameter(name: "_Iffalse", type: !3223)
!3223 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3214, size: 64)
!3224 = !DISubprogram(name: "swap", linkageName: "_ZNSt5tupleIJPN5torch3jit8FunctionESt14default_deleteIS2_EEE4swapERS6_", scope: !3186, file: !3014, line: 1331, type: !3225, scopeLine: 1331, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3225 = !DISubroutineType(types: !3226)
!3226 = !{null, !3195, !3205}
!3227 = !{!3183}
!3228 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__uniq_ptr_impl<torch::jit::Function, std::default_delete<torch::jit::Function> >", scope: !2, file: !2996, line: 128, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3229, templateParams: !3275, identifier: "_ZTSSt15__uniq_ptr_implIN5torch3jit8FunctionESt14default_deleteIS2_EE")
!3229 = !{!3230, !3231, !3235, !3245, !3249, !3253, !3257, !3262, !3265, !3268, !3269, !3272}
!3230 = !DIDerivedType(tag: DW_TAG_member, name: "_M_t", scope: !3228, file: !2996, line: 201, baseType: !3186, size: 64)
!3231 = !DISubprogram(name: "__uniq_ptr_impl", scope: !3228, file: !2996, line: 154, type: !3232, scopeLine: 154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3232 = !DISubroutineType(types: !3233)
!3233 = !{null, !3234}
!3234 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3228, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3235 = !DISubprogram(name: "__uniq_ptr_impl", scope: !3228, file: !2996, line: 155, type: !3236, scopeLine: 155, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3236 = !DISubroutineType(types: !3237)
!3237 = !{null, !3234, !3238}
!3238 = !DIDerivedType(tag: DW_TAG_typedef, name: "pointer", scope: !3228, file: !2996, line: 148, baseType: !3239)
!3239 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !3240, file: !2996, line: 133, baseType: !3007)
!3240 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Ptr<torch::jit::Function, std::default_delete<torch::jit::Function>, void>", scope: !3228, file: !2996, line: 131, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !3241, identifier: "_ZTSNSt15__uniq_ptr_implIN5torch3jit8FunctionESt14default_deleteIS2_EE4_PtrIS2_S4_vEE")
!3241 = !{!3242, !3243, !3244}
!3242 = !DITemplateTypeParameter(name: "_Up", type: !3008)
!3243 = !DITemplateTypeParameter(name: "_Ep", type: !2995)
!3244 = !DITemplateTypeParameter(type: null, defaulted: true)
!3245 = !DISubprogram(name: "__uniq_ptr_impl", scope: !3228, file: !2996, line: 161, type: !3246, scopeLine: 161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3246 = !DISubroutineType(types: !3247)
!3247 = !{null, !3234, !3248}
!3248 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3228, size: 64)
!3249 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__uniq_ptr_implIN5torch3jit8FunctionESt14default_deleteIS2_EEaSEOS5_", scope: !3228, file: !2996, line: 165, type: !3250, scopeLine: 165, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3250 = !DISubroutineType(types: !3251)
!3251 = !{!3252, !3234, !3248}
!3252 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3228, size: 64)
!3253 = !DISubprogram(name: "_M_ptr", linkageName: "_ZNSt15__uniq_ptr_implIN5torch3jit8FunctionESt14default_deleteIS2_EE6_M_ptrEv", scope: !3228, file: !2996, line: 172, type: !3254, scopeLine: 172, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3254 = !DISubroutineType(types: !3255)
!3255 = !{!3256, !3234}
!3256 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3238, size: 64)
!3257 = !DISubprogram(name: "_M_ptr", linkageName: "_ZNKSt15__uniq_ptr_implIN5torch3jit8FunctionESt14default_deleteIS2_EE6_M_ptrEv", scope: !3228, file: !2996, line: 173, type: !3258, scopeLine: 173, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3258 = !DISubroutineType(types: !3259)
!3259 = !{!3238, !3260}
!3260 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3261, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3261 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3228)
!3262 = !DISubprogram(name: "_M_deleter", linkageName: "_ZNSt15__uniq_ptr_implIN5torch3jit8FunctionESt14default_deleteIS2_EE10_M_deleterEv", scope: !3228, file: !2996, line: 174, type: !3263, scopeLine: 174, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3263 = !DISubroutineType(types: !3264)
!3264 = !{!3060, !3234}
!3265 = !DISubprogram(name: "_M_deleter", linkageName: "_ZNKSt15__uniq_ptr_implIN5torch3jit8FunctionESt14default_deleteIS2_EE10_M_deleterEv", scope: !3228, file: !2996, line: 175, type: !3266, scopeLine: 175, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3266 = !DISubroutineType(types: !3267)
!3267 = !{!3024, !3260}
!3268 = !DISubprogram(name: "reset", linkageName: "_ZNSt15__uniq_ptr_implIN5torch3jit8FunctionESt14default_deleteIS2_EE5resetEPS2_", scope: !3228, file: !2996, line: 177, type: !3236, scopeLine: 177, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3269 = !DISubprogram(name: "release", linkageName: "_ZNSt15__uniq_ptr_implIN5torch3jit8FunctionESt14default_deleteIS2_EE7releaseEv", scope: !3228, file: !2996, line: 185, type: !3270, scopeLine: 185, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3270 = !DISubroutineType(types: !3271)
!3271 = !{!3238, !3234}
!3272 = !DISubprogram(name: "swap", linkageName: "_ZNSt15__uniq_ptr_implIN5torch3jit8FunctionESt14default_deleteIS2_EE4swapERS5_", scope: !3228, file: !2996, line: 193, type: !3273, scopeLine: 193, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3273 = !DISubroutineType(types: !3274)
!3274 = !{null, !3234, !3252}
!3275 = !{!3012, !3276}
!3276 = !DITemplateTypeParameter(name: "_Dp", type: !2995)
!3277 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__uniq_ptr_data<torch::jit::Function, std::default_delete<torch::jit::Function>, true, true>", scope: !2, file: !2996, line: 208, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3278, templateParams: !3289, identifier: "_ZTSSt15__uniq_ptr_dataIN5torch3jit8FunctionESt14default_deleteIS2_ELb1ELb1EE")
!3278 = !{!3279, !3280, !3285}
!3279 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3277, baseType: !3228, extraData: i32 0)
!3280 = !DISubprogram(name: "__uniq_ptr_data", scope: !3277, file: !2996, line: 211, type: !3281, scopeLine: 211, flags: DIFlagPrototyped, spFlags: 0)
!3281 = !DISubroutineType(types: !3282)
!3282 = !{null, !3283, !3284}
!3283 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3277, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3284 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3277, size: 64)
!3285 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__uniq_ptr_dataIN5torch3jit8FunctionESt14default_deleteIS2_ELb1ELb1EEaSEOS5_", scope: !3277, file: !2996, line: 212, type: !3286, scopeLine: 212, flags: DIFlagPrototyped, spFlags: 0)
!3286 = !DISubroutineType(types: !3287)
!3287 = !{!3288, !3283, !3284}
!3288 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3277, size: 64)
!3289 = !{!3012, !3276, !1168, !1168}
!3290 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "unique_ptr<torch::jit::Function, std::default_delete<torch::jit::Function> >", scope: !2, file: !2996, line: 242, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3291, templateParams: !3275, identifier: "_ZTSSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EE")
!3291 = !{!3292, !3293, !3298, !3301, !3305, !3308, !3317, !3321, !3322, !3327, !3332, !3335, !3338, !3341, !3344, !3348}
!3292 = !DIDerivedType(tag: DW_TAG_member, name: "_M_t", scope: !3290, file: !2996, line: 248, baseType: !3277, size: 64)
!3293 = !DISubprogram(name: "unique_ptr", scope: !3290, file: !2996, line: 327, type: !3294, scopeLine: 327, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3294 = !DISubroutineType(types: !3295)
!3295 = !{null, !3296, !3297}
!3296 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3290, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3297 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3290, size: 64)
!3298 = !DISubprogram(name: "~unique_ptr", scope: !3290, file: !2996, line: 355, type: !3299, scopeLine: 355, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3299 = !DISubroutineType(types: !3300)
!3300 = !{null, !3296}
!3301 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EEaSEOS5_", scope: !3290, file: !2996, line: 371, type: !3302, scopeLine: 371, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3302 = !DISubroutineType(types: !3303)
!3303 = !{!3304, !3296, !3297}
!3304 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3290, size: 64)
!3305 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EEaSEDn", scope: !3290, file: !2996, line: 395, type: !3306, scopeLine: 395, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3306 = !DISubroutineType(types: !3307)
!3307 = !{!3304, !3296, !1004}
!3308 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EEdeEv", scope: !3290, file: !2996, line: 405, type: !3309, scopeLine: 405, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3309 = !DISubroutineType(types: !3310)
!3310 = !{!3311, !3315}
!3311 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !3312, file: !764, line: 1614, baseType: !3314)
!3312 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__add_lvalue_reference_helper<torch::jit::Function, true>", scope: !2, file: !764, line: 1613, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !3313, identifier: "_ZTSSt29__add_lvalue_reference_helperIN5torch3jit8FunctionELb1EE")
!3313 = !{!3012, !1168}
!3314 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3008, size: 64)
!3315 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3316, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3316 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3290)
!3317 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EEptEv", scope: !3290, file: !2996, line: 413, type: !3318, scopeLine: 413, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3318 = !DISubroutineType(types: !3319)
!3319 = !{!3320, !3315}
!3320 = !DIDerivedType(tag: DW_TAG_typedef, name: "pointer", scope: !3290, file: !2996, line: 251, baseType: !3238)
!3321 = !DISubprogram(name: "get", linkageName: "_ZNKSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EE3getEv", scope: !3290, file: !2996, line: 421, type: !3318, scopeLine: 421, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3322 = !DISubprogram(name: "get_deleter", linkageName: "_ZNSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EE11get_deleterEv", scope: !3290, file: !2996, line: 426, type: !3323, scopeLine: 426, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3323 = !DISubroutineType(types: !3324)
!3324 = !{!3325, !3296}
!3325 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3326, size: 64)
!3326 = !DIDerivedType(tag: DW_TAG_typedef, name: "deleter_type", scope: !3290, file: !2996, line: 253, baseType: !2995)
!3327 = !DISubprogram(name: "get_deleter", linkageName: "_ZNKSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EE11get_deleterEv", scope: !3290, file: !2996, line: 431, type: !3328, scopeLine: 431, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3328 = !DISubroutineType(types: !3329)
!3329 = !{!3330, !3315}
!3330 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3331, size: 64)
!3331 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3326)
!3332 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EEcvbEv", scope: !3290, file: !2996, line: 435, type: !3333, scopeLine: 435, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!3333 = !DISubroutineType(types: !3334)
!3334 = !{!378, !3315}
!3335 = !DISubprogram(name: "release", linkageName: "_ZNSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EE7releaseEv", scope: !3290, file: !2996, line: 442, type: !3336, scopeLine: 442, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3336 = !DISubroutineType(types: !3337)
!3337 = !{!3320, !3296}
!3338 = !DISubprogram(name: "reset", linkageName: "_ZNSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EE5resetEPS2_", scope: !3290, file: !2996, line: 452, type: !3339, scopeLine: 452, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3339 = !DISubroutineType(types: !3340)
!3340 = !{null, !3296, !3320}
!3341 = !DISubprogram(name: "swap", linkageName: "_ZNSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EE4swapERS5_", scope: !3290, file: !2996, line: 461, type: !3342, scopeLine: 461, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3342 = !DISubroutineType(types: !3343)
!3343 = !{null, !3296, !3304}
!3344 = !DISubprogram(name: "unique_ptr", scope: !3290, file: !2996, line: 468, type: !3345, scopeLine: 468, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!3345 = !DISubroutineType(types: !3346)
!3346 = !{null, !3296, !3347}
!3347 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3316, size: 64)
!3348 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN5torch3jit8FunctionESt14default_deleteIS2_EEaSERKS5_", scope: !3290, file: !2996, line: 469, type: !3349, scopeLine: 469, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!3349 = !DISubroutineType(types: !3350)
!3350 = !{!3304, !3296, !3347}
!3351 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr<c10::InterfaceType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1052, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3352, templateParams: !3465, identifier: "_ZTSSt12__shared_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE")
!3352 = !{!3353, !3371, !3377, !3378, !3382, !3387, !3391, !3392, !3396, !3399, !3402, !3403, !3407, !3410, !3411, !3414, !3417, !3466}
!3353 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3351, baseType: !3354, flags: DIFlagPublic, extraData: i32 0)
!3354 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__shared_ptr_access<c10::InterfaceType, __gnu_cxx::_S_atomic, false, false>", scope: !2, file: !853, line: 971, size: 8, flags: DIFlagTypePassByValue, elements: !3355, templateParams: !3369, identifier: "_ZTSSt19__shared_ptr_accessIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE")
!3355 = !{!3356, !3364, !3368}
!3356 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEdeEv", scope: !3354, file: !853, line: 977, type: !3357, scopeLine: 977, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3357 = !DISubroutineType(types: !3358)
!3358 = !{!3359, !3362}
!3359 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3360, size: 64)
!3360 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !3354, file: !853, line: 974, baseType: !3361)
!3361 = !DICompositeType(tag: DW_TAG_structure_type, name: "InterfaceType", scope: !36, file: !1582, line: 2174, size: 1472, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!3362 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3363, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3363 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3354)
!3364 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EEptEv", scope: !3354, file: !853, line: 984, type: !3365, scopeLine: 984, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3365 = !DISubroutineType(types: !3366)
!3366 = !{!3367, !3362}
!3367 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3360, size: 64)
!3368 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19__shared_ptr_accessIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2ELb0ELb0EE6_M_getEv", scope: !3354, file: !853, line: 992, type: !3365, scopeLine: 992, flags: DIFlagPrototyped, spFlags: 0)
!3369 = !{!3370, !911, !975, !975}
!3370 = !DITemplateTypeParameter(name: "_Tp", type: !3361)
!3371 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !3351, file: !853, line: 1402, baseType: !3372, size: 64)
!3372 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3373, size: 64)
!3373 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !3351, file: !853, line: 1056, baseType: !3374)
!3374 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !3375, file: !764, line: 1982, baseType: !3361)
!3375 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_extent<c10::InterfaceType>", scope: !2, file: !764, line: 1981, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !3376, identifier: "_ZTSSt13remove_extentIN3c1013InterfaceTypeEE")
!3376 = !{!3370}
!3377 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !3351, file: !853, line: 1403, baseType: !852, size: 64, offset: 64)
!3378 = !DISubprogram(name: "__shared_ptr", scope: !3351, file: !853, line: 1092, type: !3379, scopeLine: 1092, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3379 = !DISubroutineType(types: !3380)
!3380 = !{null, !3381}
!3381 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3351, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3382 = !DISubprogram(name: "__shared_ptr", scope: !3351, file: !853, line: 1152, type: !3383, scopeLine: 1152, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3383 = !DISubroutineType(types: !3384)
!3384 = !{null, !3381, !3385}
!3385 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3386, size: 64)
!3386 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3351)
!3387 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !3351, file: !853, line: 1153, type: !3388, scopeLine: 1153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3388 = !DISubroutineType(types: !3389)
!3389 = !{!3390, !3381, !3385}
!3390 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3351, size: 64)
!3391 = !DISubprogram(name: "~__shared_ptr", scope: !3351, file: !853, line: 1154, type: !3379, scopeLine: 1154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3392 = !DISubprogram(name: "__shared_ptr", scope: !3351, file: !853, line: 1161, type: !3393, scopeLine: 1161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3393 = !DISubroutineType(types: !3394)
!3394 = !{null, !3381, !3395}
!3395 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3351, size: 64)
!3396 = !DISubprogram(name: "__shared_ptr", scope: !3351, file: !853, line: 1223, type: !3397, scopeLine: 1223, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3397 = !DISubroutineType(types: !3398)
!3398 = !{null, !3381, !1004}
!3399 = !DISubprogram(name: "operator=", linkageName: "_ZNSt12__shared_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !3351, file: !853, line: 1248, type: !3400, scopeLine: 1248, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3400 = !DISubroutineType(types: !3401)
!3401 = !{!3390, !3381, !3395}
!3402 = !DISubprogram(name: "reset", linkageName: "_ZNSt12__shared_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !3351, file: !853, line: 1271, type: !3379, scopeLine: 1271, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3403 = !DISubprogram(name: "get", linkageName: "_ZNKSt12__shared_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE3getEv", scope: !3351, file: !853, line: 1295, type: !3404, scopeLine: 1295, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3404 = !DISubroutineType(types: !3405)
!3405 = !{!3372, !3406}
!3406 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3386, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3407 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt12__shared_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EEcvbEv", scope: !3351, file: !853, line: 1299, type: !3408, scopeLine: 1299, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!3408 = !DISubroutineType(types: !3409)
!3409 = !{!378, !3406}
!3410 = !DISubprogram(name: "unique", linkageName: "_ZNKSt12__shared_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE6uniqueEv", scope: !3351, file: !853, line: 1304, type: !3408, scopeLine: 1304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3411 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt12__shared_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !3351, file: !853, line: 1309, type: !3412, scopeLine: 1309, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3412 = !DISubroutineType(types: !3413)
!3413 = !{!575, !3406}
!3414 = !DISubprogram(name: "swap", linkageName: "_ZNSt12__shared_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !3351, file: !853, line: 1314, type: !3415, scopeLine: 1314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3415 = !DISubroutineType(types: !3416)
!3416 = !{null, !3381, !3390}
!3417 = !DISubprogram(name: "__shared_ptr", scope: !3351, file: !853, line: 1352, type: !3418, scopeLine: 1352, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!3418 = !DISubroutineType(types: !3419)
!3419 = !{null, !3381, !3420, !915}
!3420 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3421, size: 64)
!3421 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3422)
!3422 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__weak_ptr<c10::InterfaceType, __gnu_cxx::_S_atomic>", scope: !2, file: !853, line: 1591, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3423, templateParams: !3465, identifier: "_ZTSSt10__weak_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE")
!3423 = !{!3424, !3427, !3428, !3432, !3435, !3436, !3440, !3444, !3447, !3451, !3454, !3457, !3458, !3461}
!3424 = !DIDerivedType(tag: DW_TAG_member, name: "_M_ptr", scope: !3422, file: !853, line: 1733, baseType: !3425, size: 64)
!3425 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3426, size: 64)
!3426 = !DIDerivedType(tag: DW_TAG_typedef, name: "element_type", scope: !3422, file: !853, line: 1602, baseType: !3374)
!3427 = !DIDerivedType(tag: DW_TAG_member, name: "_M_refcount", scope: !3422, file: !853, line: 1734, baseType: !867, size: 64, offset: 64)
!3428 = !DISubprogram(name: "__weak_ptr", scope: !3422, file: !853, line: 1604, type: !3429, scopeLine: 1604, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3429 = !DISubroutineType(types: !3430)
!3430 = !{null, !3431}
!3431 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3422, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3432 = !DISubprogram(name: "__weak_ptr", scope: !3422, file: !853, line: 1608, type: !3433, scopeLine: 1608, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3433 = !DISubroutineType(types: !3434)
!3434 = !{null, !3431, !3420}
!3435 = !DISubprogram(name: "~__weak_ptr", scope: !3422, file: !853, line: 1610, type: !3429, scopeLine: 1610, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3436 = !DISubprogram(name: "__weak_ptr", scope: !3422, file: !853, line: 1636, type: !3437, scopeLine: 1636, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3437 = !DISubroutineType(types: !3438)
!3438 = !{null, !3431, !3439}
!3439 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3422, size: 64)
!3440 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10__weak_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EEaSERKS4_", scope: !3422, file: !853, line: 1646, type: !3441, scopeLine: 1646, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3441 = !DISubroutineType(types: !3442)
!3442 = !{!3443, !3431, !3420}
!3443 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3422, size: 64)
!3444 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10__weak_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_", scope: !3422, file: !853, line: 1667, type: !3445, scopeLine: 1667, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3445 = !DISubroutineType(types: !3446)
!3446 = !{!3443, !3431, !3439}
!3447 = !DISubprogram(name: "lock", linkageName: "_ZNKSt10__weak_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE4lockEv", scope: !3422, file: !853, line: 1684, type: !3448, scopeLine: 1684, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3448 = !DISubroutineType(types: !3449)
!3449 = !{!3351, !3450}
!3450 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3421, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3451 = !DISubprogram(name: "use_count", linkageName: "_ZNKSt10__weak_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE9use_countEv", scope: !3422, file: !853, line: 1688, type: !3452, scopeLine: 1688, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3452 = !DISubroutineType(types: !3453)
!3453 = !{!575, !3450}
!3454 = !DISubprogram(name: "expired", linkageName: "_ZNKSt10__weak_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE7expiredEv", scope: !3422, file: !853, line: 1692, type: !3455, scopeLine: 1692, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3455 = !DISubroutineType(types: !3456)
!3456 = !{!378, !3450}
!3457 = !DISubprogram(name: "reset", linkageName: "_ZNSt10__weak_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE5resetEv", scope: !3422, file: !853, line: 1706, type: !3429, scopeLine: 1706, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3458 = !DISubprogram(name: "swap", linkageName: "_ZNSt10__weak_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_", scope: !3422, file: !853, line: 1710, type: !3459, scopeLine: 1710, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3459 = !DISubroutineType(types: !3460)
!3460 = !{null, !3431, !3443}
!3461 = !DISubprogram(name: "_M_assign", linkageName: "_ZNSt10__weak_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE9_M_assignEPS1_RKSt14__shared_countILS3_2EE", scope: !3422, file: !853, line: 1719, type: !3462, scopeLine: 1719, flags: DIFlagPrototyped, spFlags: 0)
!3462 = !DISubroutineType(types: !3463)
!3463 = !{null, !3431, !3464, !877}
!3464 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3361, size: 64)
!3465 = !{!3370, !911}
!3466 = !DISubprogram(name: "_M_get_deleter", linkageName: "_ZNKSt12__shared_ptrIN3c1013InterfaceTypeELN9__gnu_cxx12_Lock_policyE2EE14_M_get_deleterERKSt9type_info", scope: !3351, file: !853, line: 1390, type: !3467, scopeLine: 1390, flags: DIFlagPrototyped, spFlags: 0)
!3467 = !DISubroutineType(types: !3468)
!3468 = !{!943, !3406, !944}
!3469 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "shared_ptr<c10::InterfaceType>", scope: !2, file: !1078, line: 122, size: 128, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3470, templateParams: !3376, identifier: "_ZTSSt10shared_ptrIN3c1013InterfaceTypeEE")
!3470 = !{!3471, !3472, !3476, !3481, !3485, !3488, !3492, !3495}
!3471 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3469, baseType: !3351, flags: DIFlagPublic, extraData: i32 0)
!3472 = !DISubprogram(name: "shared_ptr", scope: !3469, file: !1078, line: 148, type: !3473, scopeLine: 148, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3473 = !DISubroutineType(types: !3474)
!3474 = !{null, !3475}
!3475 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3469, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3476 = !DISubprogram(name: "shared_ptr", scope: !3469, file: !1078, line: 150, type: !3477, scopeLine: 150, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3477 = !DISubroutineType(types: !3478)
!3478 = !{null, !3475, !3479}
!3479 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3480, size: 64)
!3480 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3469)
!3481 = !DISubprogram(name: "shared_ptr", scope: !3469, file: !1078, line: 304, type: !3482, scopeLine: 304, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3482 = !DISubroutineType(types: !3483)
!3483 = !{null, !3475, !3484}
!3484 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3469, size: 64)
!3485 = !DISubprogram(name: "shared_ptr", scope: !3469, file: !1078, line: 357, type: !3486, scopeLine: 357, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3486 = !DISubroutineType(types: !3487)
!3487 = !{null, !3475, !1004}
!3488 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1013InterfaceTypeEEaSERKS2_", scope: !3469, file: !1078, line: 359, type: !3489, scopeLine: 359, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3489 = !DISubroutineType(types: !3490)
!3490 = !{!3491, !3475, !3479}
!3491 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3469, size: 64)
!3492 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10shared_ptrIN3c1013InterfaceTypeEEaSEOS2_", scope: !3469, file: !1078, line: 383, type: !3493, scopeLine: 383, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3493 = !DISubroutineType(types: !3494)
!3494 = !{!3491, !3475, !3484}
!3495 = !DISubprogram(name: "shared_ptr", scope: !3469, file: !1078, line: 417, type: !3496, scopeLine: 417, flags: DIFlagPrototyped, spFlags: 0)
!3496 = !DISubroutineType(types: !3497)
!3497 = !{null, !3475, !3498, !915}
!3498 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3499, size: 64)
!3499 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3500)
!3500 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "weak_ptr<c10::InterfaceType>", scope: !2, file: !853, line: 322, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8weak_ptrIN3c1013InterfaceTypeEE")
!3501 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "dim3", file: !3502, line: 418, size: 96, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !3503, identifier: "_ZTS4dim3")
!3502 = !DIFile(filename: "/usr/local/cuda/include/vector_types.h", directory: "")
!3503 = !{!3504, !3505, !3506, !3507, !3511, !3520}
!3504 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !3501, file: !3502, line: 420, baseType: !68, size: 32)
!3505 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !3501, file: !3502, line: 420, baseType: !68, size: 32, offset: 32)
!3506 = !DIDerivedType(tag: DW_TAG_member, name: "z", scope: !3501, file: !3502, line: 420, baseType: !68, size: 32, offset: 64)
!3507 = !DISubprogram(name: "dim3", scope: !3501, file: !3502, line: 423, type: !3508, scopeLine: 423, flags: DIFlagPrototyped, spFlags: 0)
!3508 = !DISubroutineType(types: !3509)
!3509 = !{null, !3510, !68, !68, !68}
!3510 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3501, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3511 = !DISubprogram(name: "dim3", scope: !3501, file: !3502, line: 424, type: !3512, scopeLine: 424, flags: DIFlagPrototyped, spFlags: 0)
!3512 = !DISubroutineType(types: !3513)
!3513 = !{null, !3510, !3514}
!3514 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint3", file: !3502, line: 384, baseType: !3515)
!3515 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "uint3", file: !3502, line: 192, size: 96, flags: DIFlagTypePassByValue, elements: !3516, identifier: "_ZTS5uint3")
!3516 = !{!3517, !3518, !3519}
!3517 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !3515, file: !3502, line: 194, baseType: !68, size: 32)
!3518 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !3515, file: !3502, line: 194, baseType: !68, size: 32, offset: 32)
!3519 = !DIDerivedType(tag: DW_TAG_member, name: "z", scope: !3515, file: !3502, line: 194, baseType: !68, size: 32, offset: 64)
!3520 = !DISubprogram(name: "operator uint3", linkageName: "_ZNK4dim3cv5uint3Ev", scope: !3501, file: !3502, line: 425, type: !3521, scopeLine: 425, flags: DIFlagPrototyped, spFlags: 0)
!3521 = !DISubroutineType(types: !3522)
!3522 = !{!3514, !3523}
!3523 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3524, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3524 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3501)
!3525 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "default_delete<c10::SymbolicShapeMeta>", scope: !2, file: !2996, line: 63, size: 8, flags: DIFlagTypePassByValue, elements: !3526, templateParams: !3537, identifier: "_ZTSSt14default_deleteIN3c1017SymbolicShapeMetaEE")
!3526 = !{!3527, !3531}
!3527 = !DISubprogram(name: "default_delete", scope: !3525, file: !2996, line: 66, type: !3528, scopeLine: 66, flags: DIFlagPrototyped, spFlags: 0)
!3528 = !DISubroutineType(types: !3529)
!3529 = !{null, !3530}
!3530 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3525, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3531 = !DISubprogram(name: "operator()", linkageName: "_ZNKSt14default_deleteIN3c1017SymbolicShapeMetaEEclEPS1_", scope: !3525, file: !2996, line: 79, type: !3532, scopeLine: 79, flags: DIFlagPrototyped, spFlags: 0)
!3532 = !DISubroutineType(types: !3533)
!3533 = !{null, !3534, !3536}
!3534 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3535, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3535 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3525)
!3536 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !366, size: 64)
!3537 = !{!3538}
!3538 = !DITemplateTypeParameter(name: "_Tp", type: !366)
!3539 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Head_base<1, std::default_delete<c10::SymbolicShapeMeta>, true>", scope: !2, file: !3014, line: 78, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !3540, templateParams: !3570, identifier: "_ZTSSt10_Head_baseILm1ESt14default_deleteIN3c1017SymbolicShapeMetaEELb1EE")
!3540 = !{!3541, !3542, !3546, !3550, !3555, !3559, !3562, !3567}
!3541 = !DIDerivedType(tag: DW_TAG_member, name: "_M_head_impl", scope: !3539, file: !3014, line: 129, baseType: !3525, size: 8)
!3542 = !DISubprogram(name: "_Head_base", scope: !3539, file: !3014, line: 80, type: !3543, scopeLine: 80, flags: DIFlagPrototyped, spFlags: 0)
!3543 = !DISubroutineType(types: !3544)
!3544 = !{null, !3545}
!3545 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3539, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3546 = !DISubprogram(name: "_Head_base", scope: !3539, file: !3014, line: 83, type: !3547, scopeLine: 83, flags: DIFlagPrototyped, spFlags: 0)
!3547 = !DISubroutineType(types: !3548)
!3548 = !{null, !3545, !3549}
!3549 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3535, size: 64)
!3550 = !DISubprogram(name: "_Head_base", scope: !3539, file: !3014, line: 86, type: !3551, scopeLine: 86, flags: DIFlagPrototyped, spFlags: 0)
!3551 = !DISubroutineType(types: !3552)
!3552 = !{null, !3545, !3553}
!3553 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3554, size: 64)
!3554 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3539)
!3555 = !DISubprogram(name: "_Head_base", scope: !3539, file: !3014, line: 87, type: !3556, scopeLine: 87, flags: DIFlagPrototyped, spFlags: 0)
!3556 = !DISubroutineType(types: !3557)
!3557 = !{null, !3545, !3558}
!3558 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3539, size: 64)
!3559 = !DISubprogram(name: "_Head_base", scope: !3539, file: !3014, line: 94, type: !3560, scopeLine: 94, flags: DIFlagPrototyped, spFlags: 0)
!3560 = !DISubroutineType(types: !3561)
!3561 = !{null, !3545, !3037, !3044}
!3562 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm1ESt14default_deleteIN3c1017SymbolicShapeMetaEELb1EE7_M_headERS4_", scope: !3539, file: !3014, line: 124, type: !3563, scopeLine: 124, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3563 = !DISubroutineType(types: !3564)
!3564 = !{!3565, !3566}
!3565 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3525, size: 64)
!3566 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3539, size: 64)
!3567 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm1ESt14default_deleteIN3c1017SymbolicShapeMetaEELb1EE7_M_headERKS4_", scope: !3539, file: !3014, line: 127, type: !3568, scopeLine: 127, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3568 = !DISubroutineType(types: !3569)
!3569 = !{!3549, !3553}
!3570 = !{!3066, !3571, !1168}
!3571 = !DITemplateTypeParameter(name: "_Head", type: !3525)
!3572 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Tuple_impl<1, std::default_delete<c10::SymbolicShapeMeta> >", scope: !2, file: !3014, line: 416, size: 8, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3573, templateParams: !3604, identifier: "_ZTSSt11_Tuple_implILm1EJSt14default_deleteIN3c1017SymbolicShapeMetaEEEE")
!3573 = !{!3574, !3575, !3579, !3584, !3588, !3591, !3594, !3597, !3601}
!3574 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3572, baseType: !3539, flags: DIFlagPrivate, extraData: i32 0)
!3575 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c1017SymbolicShapeMetaEEEE7_M_headERS4_", scope: !3572, file: !3014, line: 424, type: !3576, scopeLine: 424, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3576 = !DISubroutineType(types: !3577)
!3577 = !{!3565, !3578}
!3578 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3572, size: 64)
!3579 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c1017SymbolicShapeMetaEEEE7_M_headERKS4_", scope: !3572, file: !3014, line: 427, type: !3580, scopeLine: 427, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3580 = !DISubroutineType(types: !3581)
!3581 = !{!3549, !3582}
!3582 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3583, size: 64)
!3583 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3572)
!3584 = !DISubprogram(name: "_Tuple_impl", scope: !3572, file: !3014, line: 430, type: !3585, scopeLine: 430, flags: DIFlagPrototyped, spFlags: 0)
!3585 = !DISubroutineType(types: !3586)
!3586 = !{null, !3587}
!3587 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3572, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3588 = !DISubprogram(name: "_Tuple_impl", scope: !3572, file: !3014, line: 434, type: !3589, scopeLine: 434, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!3589 = !DISubroutineType(types: !3590)
!3590 = !{null, !3587, !3549}
!3591 = !DISubprogram(name: "_Tuple_impl", scope: !3572, file: !3014, line: 444, type: !3592, scopeLine: 444, flags: DIFlagPrototyped, spFlags: 0)
!3592 = !DISubroutineType(types: !3593)
!3593 = !{null, !3587, !3582}
!3594 = !DISubprogram(name: "operator=", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c1017SymbolicShapeMetaEEEEaSERKS4_", scope: !3572, file: !3014, line: 448, type: !3595, scopeLine: 448, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!3595 = !DISubroutineType(types: !3596)
!3596 = !{!3578, !3587, !3582}
!3597 = !DISubprogram(name: "_Tuple_impl", scope: !3572, file: !3014, line: 454, type: !3598, scopeLine: 454, flags: DIFlagPrototyped, spFlags: 0)
!3598 = !DISubroutineType(types: !3599)
!3599 = !{null, !3587, !3600}
!3600 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3572, size: 64)
!3601 = !DISubprogram(name: "_M_swap", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c1017SymbolicShapeMetaEEEE7_M_swapERS4_", scope: !3572, file: !3014, line: 544, type: !3602, scopeLine: 544, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!3602 = !DISubroutineType(types: !3603)
!3603 = !{null, !3587, !3578}
!3604 = !{!3066, !3605}
!3605 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "_Elements", value: !3606)
!3606 = !{!3607}
!3607 = !DITemplateTypeParameter(type: !3525)
!3608 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Head_base<0, c10::SymbolicShapeMeta *, false>", scope: !2, file: !3014, line: 187, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !3609, templateParams: !3640, identifier: "_ZTSSt10_Head_baseILm0EPN3c1017SymbolicShapeMetaELb0EE")
!3609 = !{!3610, !3611, !3615, !3620, !3625, !3629, !3632, !3637}
!3610 = !DIDerivedType(tag: DW_TAG_member, name: "_M_head_impl", scope: !3608, file: !3014, line: 238, baseType: !3536, size: 64)
!3611 = !DISubprogram(name: "_Head_base", scope: !3608, file: !3014, line: 189, type: !3612, scopeLine: 189, flags: DIFlagPrototyped, spFlags: 0)
!3612 = !DISubroutineType(types: !3613)
!3613 = !{null, !3614}
!3614 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3608, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3615 = !DISubprogram(name: "_Head_base", scope: !3608, file: !3014, line: 192, type: !3616, scopeLine: 192, flags: DIFlagPrototyped, spFlags: 0)
!3616 = !DISubroutineType(types: !3617)
!3617 = !{null, !3614, !3618}
!3618 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3619, size: 64)
!3619 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3536)
!3620 = !DISubprogram(name: "_Head_base", scope: !3608, file: !3014, line: 195, type: !3621, scopeLine: 195, flags: DIFlagPrototyped, spFlags: 0)
!3621 = !DISubroutineType(types: !3622)
!3622 = !{null, !3614, !3623}
!3623 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3624, size: 64)
!3624 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3608)
!3625 = !DISubprogram(name: "_Head_base", scope: !3608, file: !3014, line: 196, type: !3626, scopeLine: 196, flags: DIFlagPrototyped, spFlags: 0)
!3626 = !DISubroutineType(types: !3627)
!3627 = !{null, !3614, !3628}
!3628 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3608, size: 64)
!3629 = !DISubprogram(name: "_Head_base", scope: !3608, file: !3014, line: 203, type: !3630, scopeLine: 203, flags: DIFlagPrototyped, spFlags: 0)
!3630 = !DISubroutineType(types: !3631)
!3631 = !{null, !3614, !3037, !3044}
!3632 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm0EPN3c1017SymbolicShapeMetaELb0EE7_M_headERS3_", scope: !3608, file: !3014, line: 233, type: !3633, scopeLine: 233, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3633 = !DISubroutineType(types: !3634)
!3634 = !{!3635, !3636}
!3635 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3536, size: 64)
!3636 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3608, size: 64)
!3637 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm0EPN3c1017SymbolicShapeMetaELb0EE7_M_headERKS3_", scope: !3608, file: !3014, line: 236, type: !3638, scopeLine: 236, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3638 = !DISubroutineType(types: !3639)
!3639 = !{!3618, !3623}
!3640 = !{!3137, !3641, !975}
!3641 = !DITemplateTypeParameter(name: "_Head", type: !3536)
!3642 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Tuple_impl<0, c10::SymbolicShapeMeta *, std::default_delete<c10::SymbolicShapeMeta> >", scope: !2, file: !3014, line: 258, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3643, templateParams: !3685, identifier: "_ZTSSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE")
!3643 = !{!3644, !3645, !3646, !3650, !3655, !3660, !3665, !3669, !3672, !3675, !3678, !3682}
!3644 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3642, baseType: !3572, extraData: i32 0)
!3645 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3642, baseType: !3608, flags: DIFlagPrivate, extraData: i32 0)
!3646 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_headERS5_", scope: !3642, file: !3014, line: 268, type: !3647, scopeLine: 268, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3647 = !DISubroutineType(types: !3648)
!3648 = !{!3635, !3649}
!3649 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3642, size: 64)
!3650 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_headERKS5_", scope: !3642, file: !3014, line: 271, type: !3651, scopeLine: 271, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3651 = !DISubroutineType(types: !3652)
!3652 = !{!3618, !3653}
!3653 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3654, size: 64)
!3654 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3642)
!3655 = !DISubprogram(name: "_M_tail", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_tailERS5_", scope: !3642, file: !3014, line: 274, type: !3656, scopeLine: 274, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3656 = !DISubroutineType(types: !3657)
!3657 = !{!3658, !3649}
!3658 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3659, size: 64)
!3659 = !DIDerivedType(tag: DW_TAG_typedef, name: "_Inherited", scope: !3642, file: !3014, line: 264, baseType: !3572)
!3660 = !DISubprogram(name: "_M_tail", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_tailERKS5_", scope: !3642, file: !3014, line: 277, type: !3661, scopeLine: 277, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3661 = !DISubroutineType(types: !3662)
!3662 = !{!3663, !3653}
!3663 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3664, size: 64)
!3664 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3659)
!3665 = !DISubprogram(name: "_Tuple_impl", scope: !3642, file: !3014, line: 279, type: !3666, scopeLine: 279, flags: DIFlagPrototyped, spFlags: 0)
!3666 = !DISubroutineType(types: !3667)
!3667 = !{null, !3668}
!3668 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3642, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3669 = !DISubprogram(name: "_Tuple_impl", scope: !3642, file: !3014, line: 283, type: !3670, scopeLine: 283, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!3670 = !DISubroutineType(types: !3671)
!3671 = !{null, !3668, !3618, !3549}
!3672 = !DISubprogram(name: "_Tuple_impl", scope: !3642, file: !3014, line: 295, type: !3673, scopeLine: 295, flags: DIFlagPrototyped, spFlags: 0)
!3673 = !DISubroutineType(types: !3674)
!3674 = !{null, !3668, !3653}
!3675 = !DISubprogram(name: "operator=", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEEaSERKS5_", scope: !3642, file: !3014, line: 299, type: !3676, scopeLine: 299, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!3676 = !DISubroutineType(types: !3677)
!3677 = !{!3649, !3668, !3653}
!3678 = !DISubprogram(name: "_Tuple_impl", scope: !3642, file: !3014, line: 301, type: !3679, scopeLine: 301, flags: DIFlagPrototyped, spFlags: 0)
!3679 = !DISubroutineType(types: !3680)
!3680 = !{null, !3668, !3681}
!3681 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3642, size: 64)
!3682 = !DISubprogram(name: "_M_swap", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_swapERS5_", scope: !3642, file: !3014, line: 406, type: !3683, scopeLine: 406, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!3683 = !DISubroutineType(types: !3684)
!3684 = !{null, !3668, !3649}
!3685 = !{!3137, !3686}
!3686 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "_Elements", value: !3687)
!3687 = !{!3688, !3607}
!3688 = !DITemplateTypeParameter(type: !3536)
!3689 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "tuple<c10::SymbolicShapeMeta *, std::default_delete<c10::SymbolicShapeMeta> >", scope: !2, file: !3014, line: 981, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3690, templateParams: !3721, identifier: "_ZTSSt5tupleIJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE")
!3690 = !{!3691, !3692, !3693, !3699, !3703, !3711, !3718}
!3691 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3689, baseType: !3642, flags: DIFlagPublic, extraData: i32 0)
!3692 = !DISubprogram(name: "__nothrow_default_constructible", linkageName: "_ZNSt5tupleIJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE31__nothrow_default_constructibleEv", scope: !3689, file: !3014, line: 1035, type: !3190, scopeLine: 1035, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3693 = !DISubprogram(name: "tuple", scope: !3689, file: !3014, line: 1088, type: !3694, scopeLine: 1088, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3694 = !DISubroutineType(types: !3695)
!3695 = !{null, !3696, !3697}
!3696 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3689, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3697 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3698, size: 64)
!3698 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3689)
!3699 = !DISubprogram(name: "tuple", scope: !3689, file: !3014, line: 1090, type: !3700, scopeLine: 1090, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3700 = !DISubroutineType(types: !3701)
!3701 = !{null, !3696, !3702}
!3702 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3689, size: 64)
!3703 = !DISubprogram(name: "operator=", linkageName: "_ZNSt5tupleIJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEEaSERKS5_", scope: !3689, file: !3014, line: 1267, type: !3704, scopeLine: 1267, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3704 = !DISubroutineType(types: !3705)
!3705 = !{!3706, !3696, !3707}
!3706 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3689, size: 64)
!3707 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !3708, file: !764, line: 2221, baseType: !3697)
!3708 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "conditional<true, const std::tuple<c10::SymbolicShapeMeta *, std::default_delete<c10::SymbolicShapeMeta> > &, const std::__nonesuch &>", scope: !2, file: !764, line: 2220, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !3709, identifier: "_ZTSSt11conditionalILb1ERKSt5tupleIJPN3c1017SymbolicShapeMetaESt14default_deleteIS2_EEERKSt10__nonesuchE")
!3709 = !{!3209, !3710, !3211}
!3710 = !DITemplateTypeParameter(name: "_Iftrue", type: !3697)
!3711 = !DISubprogram(name: "operator=", linkageName: "_ZNSt5tupleIJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEEaSEOS5_", scope: !3689, file: !3014, line: 1278, type: !3712, scopeLine: 1278, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3712 = !DISubroutineType(types: !3713)
!3713 = !{!3706, !3696, !3714}
!3714 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !3715, file: !764, line: 2221, baseType: !3702)
!3715 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "conditional<true, std::tuple<c10::SymbolicShapeMeta *, std::default_delete<c10::SymbolicShapeMeta> > &&, std::__nonesuch &&>", scope: !2, file: !764, line: 2220, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !3716, identifier: "_ZTSSt11conditionalILb1EOSt5tupleIJPN3c1017SymbolicShapeMetaESt14default_deleteIS2_EEEOSt10__nonesuchE")
!3716 = !{!3209, !3717, !3222}
!3717 = !DITemplateTypeParameter(name: "_Iftrue", type: !3702)
!3718 = !DISubprogram(name: "swap", linkageName: "_ZNSt5tupleIJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE4swapERS5_", scope: !3689, file: !3014, line: 1331, type: !3719, scopeLine: 1331, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3719 = !DISubroutineType(types: !3720)
!3720 = !{null, !3696, !3706}
!3721 = !{!3686}
!3722 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__uniq_ptr_impl<c10::SymbolicShapeMeta, std::default_delete<c10::SymbolicShapeMeta> >", scope: !2, file: !2996, line: 128, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3723, templateParams: !3768, identifier: "_ZTSSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE")
!3723 = !{!3724, !3725, !3729, !3738, !3742, !3746, !3750, !3755, !3758, !3761, !3762, !3765}
!3724 = !DIDerivedType(tag: DW_TAG_member, name: "_M_t", scope: !3722, file: !2996, line: 201, baseType: !3689, size: 64)
!3725 = !DISubprogram(name: "__uniq_ptr_impl", scope: !3722, file: !2996, line: 154, type: !3726, scopeLine: 154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3726 = !DISubroutineType(types: !3727)
!3727 = !{null, !3728}
!3728 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3722, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3729 = !DISubprogram(name: "__uniq_ptr_impl", scope: !3722, file: !2996, line: 155, type: !3730, scopeLine: 155, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3730 = !DISubroutineType(types: !3731)
!3731 = !{null, !3728, !3732}
!3732 = !DIDerivedType(tag: DW_TAG_typedef, name: "pointer", scope: !3722, file: !2996, line: 148, baseType: !3733)
!3733 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !3734, file: !2996, line: 133, baseType: !3536)
!3734 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Ptr<c10::SymbolicShapeMeta, std::default_delete<c10::SymbolicShapeMeta>, void>", scope: !3722, file: !2996, line: 131, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !3735, identifier: "_ZTSNSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE4_PtrIS1_S3_vEE")
!3735 = !{!3736, !3737, !3244}
!3736 = !DITemplateTypeParameter(name: "_Up", type: !366)
!3737 = !DITemplateTypeParameter(name: "_Ep", type: !3525)
!3738 = !DISubprogram(name: "__uniq_ptr_impl", scope: !3722, file: !2996, line: 161, type: !3739, scopeLine: 161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3739 = !DISubroutineType(types: !3740)
!3740 = !{null, !3728, !3741}
!3741 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3722, size: 64)
!3742 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEaSEOS4_", scope: !3722, file: !2996, line: 165, type: !3743, scopeLine: 165, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3743 = !DISubroutineType(types: !3744)
!3744 = !{!3745, !3728, !3741}
!3745 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3722, size: 64)
!3746 = !DISubprogram(name: "_M_ptr", linkageName: "_ZNSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE6_M_ptrEv", scope: !3722, file: !2996, line: 172, type: !3747, scopeLine: 172, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3747 = !DISubroutineType(types: !3748)
!3748 = !{!3749, !3728}
!3749 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3732, size: 64)
!3750 = !DISubprogram(name: "_M_ptr", linkageName: "_ZNKSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE6_M_ptrEv", scope: !3722, file: !2996, line: 173, type: !3751, scopeLine: 173, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3751 = !DISubroutineType(types: !3752)
!3752 = !{!3732, !3753}
!3753 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3754, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3754 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3722)
!3755 = !DISubprogram(name: "_M_deleter", linkageName: "_ZNSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE10_M_deleterEv", scope: !3722, file: !2996, line: 174, type: !3756, scopeLine: 174, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3756 = !DISubroutineType(types: !3757)
!3757 = !{!3565, !3728}
!3758 = !DISubprogram(name: "_M_deleter", linkageName: "_ZNKSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE10_M_deleterEv", scope: !3722, file: !2996, line: 175, type: !3759, scopeLine: 175, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3759 = !DISubroutineType(types: !3760)
!3760 = !{!3549, !3753}
!3761 = !DISubprogram(name: "reset", linkageName: "_ZNSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE5resetEPS1_", scope: !3722, file: !2996, line: 177, type: !3730, scopeLine: 177, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3762 = !DISubprogram(name: "release", linkageName: "_ZNSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE7releaseEv", scope: !3722, file: !2996, line: 185, type: !3763, scopeLine: 185, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3763 = !DISubroutineType(types: !3764)
!3764 = !{!3732, !3728}
!3765 = !DISubprogram(name: "swap", linkageName: "_ZNSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE4swapERS4_", scope: !3722, file: !2996, line: 193, type: !3766, scopeLine: 193, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3766 = !DISubroutineType(types: !3767)
!3767 = !{null, !3728, !3745}
!3768 = !{!3538, !3769}
!3769 = !DITemplateTypeParameter(name: "_Dp", type: !3525)
!3770 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__uniq_ptr_data<c10::SymbolicShapeMeta, std::default_delete<c10::SymbolicShapeMeta>, true, true>", scope: !2, file: !2996, line: 208, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3771, templateParams: !3782, identifier: "_ZTSSt15__uniq_ptr_dataIN3c1017SymbolicShapeMetaESt14default_deleteIS1_ELb1ELb1EE")
!3771 = !{!3772, !3773, !3778}
!3772 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3770, baseType: !3722, extraData: i32 0)
!3773 = !DISubprogram(name: "__uniq_ptr_data", scope: !3770, file: !2996, line: 211, type: !3774, scopeLine: 211, flags: DIFlagPrototyped, spFlags: 0)
!3774 = !DISubroutineType(types: !3775)
!3775 = !{null, !3776, !3777}
!3776 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3770, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3777 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3770, size: 64)
!3778 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__uniq_ptr_dataIN3c1017SymbolicShapeMetaESt14default_deleteIS1_ELb1ELb1EEaSEOS4_", scope: !3770, file: !2996, line: 212, type: !3779, scopeLine: 212, flags: DIFlagPrototyped, spFlags: 0)
!3779 = !DISubroutineType(types: !3780)
!3780 = !{!3781, !3776, !3777}
!3781 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3770, size: 64)
!3782 = !{!3538, !3769, !1168, !1168}
!3783 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "unique_ptr<c10::SymbolicShapeMeta, std::default_delete<c10::SymbolicShapeMeta> >", scope: !2, file: !2996, line: 242, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3784, templateParams: !3768, identifier: "_ZTSSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE")
!3784 = !{!3785, !3786, !3791, !3794, !3798, !3801, !3809, !3813, !3814, !3819, !3824, !3827, !3830, !3833, !3836, !3840}
!3785 = !DIDerivedType(tag: DW_TAG_member, name: "_M_t", scope: !3783, file: !2996, line: 248, baseType: !3770, size: 64)
!3786 = !DISubprogram(name: "unique_ptr", scope: !3783, file: !2996, line: 327, type: !3787, scopeLine: 327, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3787 = !DISubroutineType(types: !3788)
!3788 = !{null, !3789, !3790}
!3789 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3783, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3790 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3783, size: 64)
!3791 = !DISubprogram(name: "~unique_ptr", scope: !3783, file: !2996, line: 355, type: !3792, scopeLine: 355, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3792 = !DISubroutineType(types: !3793)
!3793 = !{null, !3789}
!3794 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEaSEOS4_", scope: !3783, file: !2996, line: 371, type: !3795, scopeLine: 371, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3795 = !DISubroutineType(types: !3796)
!3796 = !{!3797, !3789, !3790}
!3797 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3783, size: 64)
!3798 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEaSEDn", scope: !3783, file: !2996, line: 395, type: !3799, scopeLine: 395, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3799 = !DISubroutineType(types: !3800)
!3800 = !{!3797, !3789, !1004}
!3801 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEdeEv", scope: !3783, file: !2996, line: 405, type: !3802, scopeLine: 405, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3802 = !DISubroutineType(types: !3803)
!3803 = !{!3804, !3807}
!3804 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !3805, file: !764, line: 1614, baseType: !639)
!3805 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__add_lvalue_reference_helper<c10::SymbolicShapeMeta, true>", scope: !2, file: !764, line: 1613, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !3806, identifier: "_ZTSSt29__add_lvalue_reference_helperIN3c1017SymbolicShapeMetaELb1EE")
!3806 = !{!3538, !1168}
!3807 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3808, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3808 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3783)
!3809 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEptEv", scope: !3783, file: !2996, line: 413, type: !3810, scopeLine: 413, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3810 = !DISubroutineType(types: !3811)
!3811 = !{!3812, !3807}
!3812 = !DIDerivedType(tag: DW_TAG_typedef, name: "pointer", scope: !3783, file: !2996, line: 251, baseType: !3732)
!3813 = !DISubprogram(name: "get", linkageName: "_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE3getEv", scope: !3783, file: !2996, line: 421, type: !3810, scopeLine: 421, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3814 = !DISubprogram(name: "get_deleter", linkageName: "_ZNSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE11get_deleterEv", scope: !3783, file: !2996, line: 426, type: !3815, scopeLine: 426, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3815 = !DISubroutineType(types: !3816)
!3816 = !{!3817, !3789}
!3817 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3818, size: 64)
!3818 = !DIDerivedType(tag: DW_TAG_typedef, name: "deleter_type", scope: !3783, file: !2996, line: 253, baseType: !3525)
!3819 = !DISubprogram(name: "get_deleter", linkageName: "_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE11get_deleterEv", scope: !3783, file: !2996, line: 431, type: !3820, scopeLine: 431, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3820 = !DISubroutineType(types: !3821)
!3821 = !{!3822, !3807}
!3822 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3823, size: 64)
!3823 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3818)
!3824 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEcvbEv", scope: !3783, file: !2996, line: 435, type: !3825, scopeLine: 435, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!3825 = !DISubroutineType(types: !3826)
!3826 = !{!378, !3807}
!3827 = !DISubprogram(name: "release", linkageName: "_ZNSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE7releaseEv", scope: !3783, file: !2996, line: 442, type: !3828, scopeLine: 442, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3828 = !DISubroutineType(types: !3829)
!3829 = !{!3812, !3789}
!3830 = !DISubprogram(name: "reset", linkageName: "_ZNSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE5resetEPS1_", scope: !3783, file: !2996, line: 452, type: !3831, scopeLine: 452, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3831 = !DISubroutineType(types: !3832)
!3832 = !{null, !3789, !3812}
!3833 = !DISubprogram(name: "swap", linkageName: "_ZNSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE4swapERS4_", scope: !3783, file: !2996, line: 461, type: !3834, scopeLine: 461, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!3834 = !DISubroutineType(types: !3835)
!3835 = !{null, !3789, !3797}
!3836 = !DISubprogram(name: "unique_ptr", scope: !3783, file: !2996, line: 468, type: !3837, scopeLine: 468, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!3837 = !DISubroutineType(types: !3838)
!3838 = !{null, !3789, !3839}
!3839 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3808, size: 64)
!3840 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEaSERKS4_", scope: !3783, file: !2996, line: 469, type: !3841, scopeLine: 469, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!3841 = !DISubroutineType(types: !3842)
!3842 = !{!3797, !3789, !3839}
!3843 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "default_delete<c10::NamedTensorMetaInterface>", scope: !2, file: !2996, line: 63, size: 8, flags: DIFlagTypePassByValue, elements: !3844, templateParams: !3856, identifier: "_ZTSSt14default_deleteIN3c1024NamedTensorMetaInterfaceEE")
!3844 = !{!3845, !3849}
!3845 = !DISubprogram(name: "default_delete", scope: !3843, file: !2996, line: 66, type: !3846, scopeLine: 66, flags: DIFlagPrototyped, spFlags: 0)
!3846 = !DISubroutineType(types: !3847)
!3847 = !{null, !3848}
!3848 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3843, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3849 = !DISubprogram(name: "operator()", linkageName: "_ZNKSt14default_deleteIN3c1024NamedTensorMetaInterfaceEEclEPS1_", scope: !3843, file: !2996, line: 79, type: !3850, scopeLine: 79, flags: DIFlagPrototyped, spFlags: 0)
!3850 = !DISubroutineType(types: !3851)
!3851 = !{null, !3852, !3854}
!3852 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3853, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3853 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3843)
!3854 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3855, size: 64)
!3855 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "NamedTensorMetaInterface", scope: !36, file: !349, line: 204, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1024NamedTensorMetaInterfaceE")
!3856 = !{!3857}
!3857 = !DITemplateTypeParameter(name: "_Tp", type: !3855)
!3858 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Head_base<1, std::default_delete<c10::NamedTensorMetaInterface>, true>", scope: !2, file: !3014, line: 78, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !3859, templateParams: !3889, identifier: "_ZTSSt10_Head_baseILm1ESt14default_deleteIN3c1024NamedTensorMetaInterfaceEELb1EE")
!3859 = !{!3860, !3861, !3865, !3869, !3874, !3878, !3881, !3886}
!3860 = !DIDerivedType(tag: DW_TAG_member, name: "_M_head_impl", scope: !3858, file: !3014, line: 129, baseType: !3843, size: 8)
!3861 = !DISubprogram(name: "_Head_base", scope: !3858, file: !3014, line: 80, type: !3862, scopeLine: 80, flags: DIFlagPrototyped, spFlags: 0)
!3862 = !DISubroutineType(types: !3863)
!3863 = !{null, !3864}
!3864 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3858, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3865 = !DISubprogram(name: "_Head_base", scope: !3858, file: !3014, line: 83, type: !3866, scopeLine: 83, flags: DIFlagPrototyped, spFlags: 0)
!3866 = !DISubroutineType(types: !3867)
!3867 = !{null, !3864, !3868}
!3868 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3853, size: 64)
!3869 = !DISubprogram(name: "_Head_base", scope: !3858, file: !3014, line: 86, type: !3870, scopeLine: 86, flags: DIFlagPrototyped, spFlags: 0)
!3870 = !DISubroutineType(types: !3871)
!3871 = !{null, !3864, !3872}
!3872 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3873, size: 64)
!3873 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3858)
!3874 = !DISubprogram(name: "_Head_base", scope: !3858, file: !3014, line: 87, type: !3875, scopeLine: 87, flags: DIFlagPrototyped, spFlags: 0)
!3875 = !DISubroutineType(types: !3876)
!3876 = !{null, !3864, !3877}
!3877 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3858, size: 64)
!3878 = !DISubprogram(name: "_Head_base", scope: !3858, file: !3014, line: 94, type: !3879, scopeLine: 94, flags: DIFlagPrototyped, spFlags: 0)
!3879 = !DISubroutineType(types: !3880)
!3880 = !{null, !3864, !3037, !3044}
!3881 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm1ESt14default_deleteIN3c1024NamedTensorMetaInterfaceEELb1EE7_M_headERS4_", scope: !3858, file: !3014, line: 124, type: !3882, scopeLine: 124, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3882 = !DISubroutineType(types: !3883)
!3883 = !{!3884, !3885}
!3884 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3843, size: 64)
!3885 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3858, size: 64)
!3886 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm1ESt14default_deleteIN3c1024NamedTensorMetaInterfaceEELb1EE7_M_headERKS4_", scope: !3858, file: !3014, line: 127, type: !3887, scopeLine: 127, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3887 = !DISubroutineType(types: !3888)
!3888 = !{!3868, !3872}
!3889 = !{!3066, !3890, !1168}
!3890 = !DITemplateTypeParameter(name: "_Head", type: !3843)
!3891 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Tuple_impl<1, std::default_delete<c10::NamedTensorMetaInterface> >", scope: !2, file: !3014, line: 416, size: 8, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3892, templateParams: !3923, identifier: "_ZTSSt11_Tuple_implILm1EJSt14default_deleteIN3c1024NamedTensorMetaInterfaceEEEE")
!3892 = !{!3893, !3894, !3898, !3903, !3907, !3910, !3913, !3916, !3920}
!3893 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3891, baseType: !3858, flags: DIFlagPrivate, extraData: i32 0)
!3894 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c1024NamedTensorMetaInterfaceEEEE7_M_headERS4_", scope: !3891, file: !3014, line: 424, type: !3895, scopeLine: 424, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3895 = !DISubroutineType(types: !3896)
!3896 = !{!3884, !3897}
!3897 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3891, size: 64)
!3898 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c1024NamedTensorMetaInterfaceEEEE7_M_headERKS4_", scope: !3891, file: !3014, line: 427, type: !3899, scopeLine: 427, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3899 = !DISubroutineType(types: !3900)
!3900 = !{!3868, !3901}
!3901 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3902, size: 64)
!3902 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3891)
!3903 = !DISubprogram(name: "_Tuple_impl", scope: !3891, file: !3014, line: 430, type: !3904, scopeLine: 430, flags: DIFlagPrototyped, spFlags: 0)
!3904 = !DISubroutineType(types: !3905)
!3905 = !{null, !3906}
!3906 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3891, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3907 = !DISubprogram(name: "_Tuple_impl", scope: !3891, file: !3014, line: 434, type: !3908, scopeLine: 434, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!3908 = !DISubroutineType(types: !3909)
!3909 = !{null, !3906, !3868}
!3910 = !DISubprogram(name: "_Tuple_impl", scope: !3891, file: !3014, line: 444, type: !3911, scopeLine: 444, flags: DIFlagPrototyped, spFlags: 0)
!3911 = !DISubroutineType(types: !3912)
!3912 = !{null, !3906, !3901}
!3913 = !DISubprogram(name: "operator=", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c1024NamedTensorMetaInterfaceEEEEaSERKS4_", scope: !3891, file: !3014, line: 448, type: !3914, scopeLine: 448, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!3914 = !DISubroutineType(types: !3915)
!3915 = !{!3897, !3906, !3901}
!3916 = !DISubprogram(name: "_Tuple_impl", scope: !3891, file: !3014, line: 454, type: !3917, scopeLine: 454, flags: DIFlagPrototyped, spFlags: 0)
!3917 = !DISubroutineType(types: !3918)
!3918 = !{null, !3906, !3919}
!3919 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3891, size: 64)
!3920 = !DISubprogram(name: "_M_swap", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c1024NamedTensorMetaInterfaceEEEE7_M_swapERS4_", scope: !3891, file: !3014, line: 544, type: !3921, scopeLine: 544, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!3921 = !DISubroutineType(types: !3922)
!3922 = !{null, !3906, !3897}
!3923 = !{!3066, !3924}
!3924 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "_Elements", value: !3925)
!3925 = !{!3926}
!3926 = !DITemplateTypeParameter(type: !3843)
!3927 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Head_base<0, c10::NamedTensorMetaInterface *, false>", scope: !2, file: !3014, line: 187, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !3928, templateParams: !3959, identifier: "_ZTSSt10_Head_baseILm0EPN3c1024NamedTensorMetaInterfaceELb0EE")
!3928 = !{!3929, !3930, !3934, !3939, !3944, !3948, !3951, !3956}
!3929 = !DIDerivedType(tag: DW_TAG_member, name: "_M_head_impl", scope: !3927, file: !3014, line: 238, baseType: !3854, size: 64)
!3930 = !DISubprogram(name: "_Head_base", scope: !3927, file: !3014, line: 189, type: !3931, scopeLine: 189, flags: DIFlagPrototyped, spFlags: 0)
!3931 = !DISubroutineType(types: !3932)
!3932 = !{null, !3933}
!3933 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3927, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3934 = !DISubprogram(name: "_Head_base", scope: !3927, file: !3014, line: 192, type: !3935, scopeLine: 192, flags: DIFlagPrototyped, spFlags: 0)
!3935 = !DISubroutineType(types: !3936)
!3936 = !{null, !3933, !3937}
!3937 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3938, size: 64)
!3938 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3854)
!3939 = !DISubprogram(name: "_Head_base", scope: !3927, file: !3014, line: 195, type: !3940, scopeLine: 195, flags: DIFlagPrototyped, spFlags: 0)
!3940 = !DISubroutineType(types: !3941)
!3941 = !{null, !3933, !3942}
!3942 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3943, size: 64)
!3943 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3927)
!3944 = !DISubprogram(name: "_Head_base", scope: !3927, file: !3014, line: 196, type: !3945, scopeLine: 196, flags: DIFlagPrototyped, spFlags: 0)
!3945 = !DISubroutineType(types: !3946)
!3946 = !{null, !3933, !3947}
!3947 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3927, size: 64)
!3948 = !DISubprogram(name: "_Head_base", scope: !3927, file: !3014, line: 203, type: !3949, scopeLine: 203, flags: DIFlagPrototyped, spFlags: 0)
!3949 = !DISubroutineType(types: !3950)
!3950 = !{null, !3933, !3037, !3044}
!3951 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm0EPN3c1024NamedTensorMetaInterfaceELb0EE7_M_headERS3_", scope: !3927, file: !3014, line: 233, type: !3952, scopeLine: 233, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3952 = !DISubroutineType(types: !3953)
!3953 = !{!3954, !3955}
!3954 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3854, size: 64)
!3955 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3927, size: 64)
!3956 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm0EPN3c1024NamedTensorMetaInterfaceELb0EE7_M_headERKS3_", scope: !3927, file: !3014, line: 236, type: !3957, scopeLine: 236, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3957 = !DISubroutineType(types: !3958)
!3958 = !{!3937, !3942}
!3959 = !{!3137, !3960, !975}
!3960 = !DITemplateTypeParameter(name: "_Head", type: !3854)
!3961 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Tuple_impl<0, c10::NamedTensorMetaInterface *, std::default_delete<c10::NamedTensorMetaInterface> >", scope: !2, file: !3014, line: 258, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !3962, templateParams: !4004, identifier: "_ZTSSt11_Tuple_implILm0EJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEE")
!3962 = !{!3963, !3964, !3965, !3969, !3974, !3979, !3984, !3988, !3991, !3994, !3997, !4001}
!3963 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3961, baseType: !3891, extraData: i32 0)
!3964 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !3961, baseType: !3927, flags: DIFlagPrivate, extraData: i32 0)
!3965 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEE7_M_headERS5_", scope: !3961, file: !3014, line: 268, type: !3966, scopeLine: 268, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3966 = !DISubroutineType(types: !3967)
!3967 = !{!3954, !3968}
!3968 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3961, size: 64)
!3969 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEE7_M_headERKS5_", scope: !3961, file: !3014, line: 271, type: !3970, scopeLine: 271, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3970 = !DISubroutineType(types: !3971)
!3971 = !{!3937, !3972}
!3972 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3973, size: 64)
!3973 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3961)
!3974 = !DISubprogram(name: "_M_tail", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEE7_M_tailERS5_", scope: !3961, file: !3014, line: 274, type: !3975, scopeLine: 274, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3975 = !DISubroutineType(types: !3976)
!3976 = !{!3977, !3968}
!3977 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3978, size: 64)
!3978 = !DIDerivedType(tag: DW_TAG_typedef, name: "_Inherited", scope: !3961, file: !3014, line: 264, baseType: !3891)
!3979 = !DISubprogram(name: "_M_tail", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEE7_M_tailERKS5_", scope: !3961, file: !3014, line: 277, type: !3980, scopeLine: 277, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!3980 = !DISubroutineType(types: !3981)
!3981 = !{!3982, !3972}
!3982 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3983, size: 64)
!3983 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3978)
!3984 = !DISubprogram(name: "_Tuple_impl", scope: !3961, file: !3014, line: 279, type: !3985, scopeLine: 279, flags: DIFlagPrototyped, spFlags: 0)
!3985 = !DISubroutineType(types: !3986)
!3986 = !{null, !3987}
!3987 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3961, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!3988 = !DISubprogram(name: "_Tuple_impl", scope: !3961, file: !3014, line: 283, type: !3989, scopeLine: 283, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!3989 = !DISubroutineType(types: !3990)
!3990 = !{null, !3987, !3937, !3868}
!3991 = !DISubprogram(name: "_Tuple_impl", scope: !3961, file: !3014, line: 295, type: !3992, scopeLine: 295, flags: DIFlagPrototyped, spFlags: 0)
!3992 = !DISubroutineType(types: !3993)
!3993 = !{null, !3987, !3972}
!3994 = !DISubprogram(name: "operator=", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEEaSERKS5_", scope: !3961, file: !3014, line: 299, type: !3995, scopeLine: 299, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!3995 = !DISubroutineType(types: !3996)
!3996 = !{!3968, !3987, !3972}
!3997 = !DISubprogram(name: "_Tuple_impl", scope: !3961, file: !3014, line: 301, type: !3998, scopeLine: 301, flags: DIFlagPrototyped, spFlags: 0)
!3998 = !DISubroutineType(types: !3999)
!3999 = !{null, !3987, !4000}
!4000 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !3961, size: 64)
!4001 = !DISubprogram(name: "_M_swap", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEE7_M_swapERS5_", scope: !3961, file: !3014, line: 406, type: !4002, scopeLine: 406, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!4002 = !DISubroutineType(types: !4003)
!4003 = !{null, !3987, !3968}
!4004 = !{!3137, !4005}
!4005 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "_Elements", value: !4006)
!4006 = !{!4007, !3926}
!4007 = !DITemplateTypeParameter(type: !3854)
!4008 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "tuple<c10::NamedTensorMetaInterface *, std::default_delete<c10::NamedTensorMetaInterface> >", scope: !2, file: !3014, line: 981, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4009, templateParams: !4040, identifier: "_ZTSSt5tupleIJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEE")
!4009 = !{!4010, !4011, !4012, !4018, !4022, !4030, !4037}
!4010 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4008, baseType: !3961, flags: DIFlagPublic, extraData: i32 0)
!4011 = !DISubprogram(name: "__nothrow_default_constructible", linkageName: "_ZNSt5tupleIJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEE31__nothrow_default_constructibleEv", scope: !4008, file: !3014, line: 1035, type: !3190, scopeLine: 1035, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4012 = !DISubprogram(name: "tuple", scope: !4008, file: !3014, line: 1088, type: !4013, scopeLine: 1088, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4013 = !DISubroutineType(types: !4014)
!4014 = !{null, !4015, !4016}
!4015 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4008, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4016 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4017, size: 64)
!4017 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4008)
!4018 = !DISubprogram(name: "tuple", scope: !4008, file: !3014, line: 1090, type: !4019, scopeLine: 1090, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4019 = !DISubroutineType(types: !4020)
!4020 = !{null, !4015, !4021}
!4021 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4008, size: 64)
!4022 = !DISubprogram(name: "operator=", linkageName: "_ZNSt5tupleIJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEEaSERKS5_", scope: !4008, file: !3014, line: 1267, type: !4023, scopeLine: 1267, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4023 = !DISubroutineType(types: !4024)
!4024 = !{!4025, !4015, !4026}
!4025 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4008, size: 64)
!4026 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !4027, file: !764, line: 2221, baseType: !4016)
!4027 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "conditional<true, const std::tuple<c10::NamedTensorMetaInterface *, std::default_delete<c10::NamedTensorMetaInterface> > &, const std::__nonesuch &>", scope: !2, file: !764, line: 2220, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !4028, identifier: "_ZTSSt11conditionalILb1ERKSt5tupleIJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS2_EEERKSt10__nonesuchE")
!4028 = !{!3209, !4029, !3211}
!4029 = !DITemplateTypeParameter(name: "_Iftrue", type: !4016)
!4030 = !DISubprogram(name: "operator=", linkageName: "_ZNSt5tupleIJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEEaSEOS5_", scope: !4008, file: !3014, line: 1278, type: !4031, scopeLine: 1278, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4031 = !DISubroutineType(types: !4032)
!4032 = !{!4025, !4015, !4033}
!4033 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !4034, file: !764, line: 2221, baseType: !4021)
!4034 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "conditional<true, std::tuple<c10::NamedTensorMetaInterface *, std::default_delete<c10::NamedTensorMetaInterface> > &&, std::__nonesuch &&>", scope: !2, file: !764, line: 2220, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !4035, identifier: "_ZTSSt11conditionalILb1EOSt5tupleIJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS2_EEEOSt10__nonesuchE")
!4035 = !{!3209, !4036, !3222}
!4036 = !DITemplateTypeParameter(name: "_Iftrue", type: !4021)
!4037 = !DISubprogram(name: "swap", linkageName: "_ZNSt5tupleIJPN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEE4swapERS5_", scope: !4008, file: !3014, line: 1331, type: !4038, scopeLine: 1331, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4038 = !DISubroutineType(types: !4039)
!4039 = !{null, !4015, !4025}
!4040 = !{!4005}
!4041 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__uniq_ptr_impl<c10::NamedTensorMetaInterface, std::default_delete<c10::NamedTensorMetaInterface> >", scope: !2, file: !2996, line: 128, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4042, templateParams: !4087, identifier: "_ZTSSt15__uniq_ptr_implIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE")
!4042 = !{!4043, !4044, !4048, !4057, !4061, !4065, !4069, !4074, !4077, !4080, !4081, !4084}
!4043 = !DIDerivedType(tag: DW_TAG_member, name: "_M_t", scope: !4041, file: !2996, line: 201, baseType: !4008, size: 64)
!4044 = !DISubprogram(name: "__uniq_ptr_impl", scope: !4041, file: !2996, line: 154, type: !4045, scopeLine: 154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4045 = !DISubroutineType(types: !4046)
!4046 = !{null, !4047}
!4047 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4041, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4048 = !DISubprogram(name: "__uniq_ptr_impl", scope: !4041, file: !2996, line: 155, type: !4049, scopeLine: 155, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4049 = !DISubroutineType(types: !4050)
!4050 = !{null, !4047, !4051}
!4051 = !DIDerivedType(tag: DW_TAG_typedef, name: "pointer", scope: !4041, file: !2996, line: 148, baseType: !4052)
!4052 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !4053, file: !2996, line: 133, baseType: !3854)
!4053 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Ptr<c10::NamedTensorMetaInterface, std::default_delete<c10::NamedTensorMetaInterface>, void>", scope: !4041, file: !2996, line: 131, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !4054, identifier: "_ZTSNSt15__uniq_ptr_implIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE4_PtrIS1_S3_vEE")
!4054 = !{!4055, !4056, !3244}
!4055 = !DITemplateTypeParameter(name: "_Up", type: !3855)
!4056 = !DITemplateTypeParameter(name: "_Ep", type: !3843)
!4057 = !DISubprogram(name: "__uniq_ptr_impl", scope: !4041, file: !2996, line: 161, type: !4058, scopeLine: 161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4058 = !DISubroutineType(types: !4059)
!4059 = !{null, !4047, !4060}
!4060 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4041, size: 64)
!4061 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__uniq_ptr_implIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEaSEOS4_", scope: !4041, file: !2996, line: 165, type: !4062, scopeLine: 165, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4062 = !DISubroutineType(types: !4063)
!4063 = !{!4064, !4047, !4060}
!4064 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4041, size: 64)
!4065 = !DISubprogram(name: "_M_ptr", linkageName: "_ZNSt15__uniq_ptr_implIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE6_M_ptrEv", scope: !4041, file: !2996, line: 172, type: !4066, scopeLine: 172, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4066 = !DISubroutineType(types: !4067)
!4067 = !{!4068, !4047}
!4068 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4051, size: 64)
!4069 = !DISubprogram(name: "_M_ptr", linkageName: "_ZNKSt15__uniq_ptr_implIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE6_M_ptrEv", scope: !4041, file: !2996, line: 173, type: !4070, scopeLine: 173, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4070 = !DISubroutineType(types: !4071)
!4071 = !{!4051, !4072}
!4072 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4073, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4073 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4041)
!4074 = !DISubprogram(name: "_M_deleter", linkageName: "_ZNSt15__uniq_ptr_implIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE10_M_deleterEv", scope: !4041, file: !2996, line: 174, type: !4075, scopeLine: 174, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4075 = !DISubroutineType(types: !4076)
!4076 = !{!3884, !4047}
!4077 = !DISubprogram(name: "_M_deleter", linkageName: "_ZNKSt15__uniq_ptr_implIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE10_M_deleterEv", scope: !4041, file: !2996, line: 175, type: !4078, scopeLine: 175, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4078 = !DISubroutineType(types: !4079)
!4079 = !{!3868, !4072}
!4080 = !DISubprogram(name: "reset", linkageName: "_ZNSt15__uniq_ptr_implIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE5resetEPS1_", scope: !4041, file: !2996, line: 177, type: !4049, scopeLine: 177, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4081 = !DISubprogram(name: "release", linkageName: "_ZNSt15__uniq_ptr_implIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE7releaseEv", scope: !4041, file: !2996, line: 185, type: !4082, scopeLine: 185, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4082 = !DISubroutineType(types: !4083)
!4083 = !{!4051, !4047}
!4084 = !DISubprogram(name: "swap", linkageName: "_ZNSt15__uniq_ptr_implIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE4swapERS4_", scope: !4041, file: !2996, line: 193, type: !4085, scopeLine: 193, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4085 = !DISubroutineType(types: !4086)
!4086 = !{null, !4047, !4064}
!4087 = !{!3857, !4088}
!4088 = !DITemplateTypeParameter(name: "_Dp", type: !3843)
!4089 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__uniq_ptr_data<c10::NamedTensorMetaInterface, std::default_delete<c10::NamedTensorMetaInterface>, true, true>", scope: !2, file: !2996, line: 208, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4090, templateParams: !4101, identifier: "_ZTSSt15__uniq_ptr_dataIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_ELb1ELb1EE")
!4090 = !{!4091, !4092, !4097}
!4091 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4089, baseType: !4041, extraData: i32 0)
!4092 = !DISubprogram(name: "__uniq_ptr_data", scope: !4089, file: !2996, line: 211, type: !4093, scopeLine: 211, flags: DIFlagPrototyped, spFlags: 0)
!4093 = !DISubroutineType(types: !4094)
!4094 = !{null, !4095, !4096}
!4095 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4089, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4096 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4089, size: 64)
!4097 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__uniq_ptr_dataIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_ELb1ELb1EEaSEOS4_", scope: !4089, file: !2996, line: 212, type: !4098, scopeLine: 212, flags: DIFlagPrototyped, spFlags: 0)
!4098 = !DISubroutineType(types: !4099)
!4099 = !{!4100, !4095, !4096}
!4100 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4089, size: 64)
!4101 = !{!3857, !4088, !1168, !1168}
!4102 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "unique_ptr<c10::NamedTensorMetaInterface, std::default_delete<c10::NamedTensorMetaInterface> >", scope: !2, file: !2996, line: 242, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4103, templateParams: !4087, identifier: "_ZTSSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE")
!4103 = !{!4104, !4105, !4110, !4113, !4117, !4120, !4129, !4133, !4134, !4139, !4144, !4147, !4150, !4153, !4156, !4160}
!4104 = !DIDerivedType(tag: DW_TAG_member, name: "_M_t", scope: !4102, file: !2996, line: 248, baseType: !4089, size: 64)
!4105 = !DISubprogram(name: "unique_ptr", scope: !4102, file: !2996, line: 327, type: !4106, scopeLine: 327, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4106 = !DISubroutineType(types: !4107)
!4107 = !{null, !4108, !4109}
!4108 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4102, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4109 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4102, size: 64)
!4110 = !DISubprogram(name: "~unique_ptr", scope: !4102, file: !2996, line: 355, type: !4111, scopeLine: 355, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4111 = !DISubroutineType(types: !4112)
!4112 = !{null, !4108}
!4113 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEaSEOS4_", scope: !4102, file: !2996, line: 371, type: !4114, scopeLine: 371, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4114 = !DISubroutineType(types: !4115)
!4115 = !{!4116, !4108, !4109}
!4116 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4102, size: 64)
!4117 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEaSEDn", scope: !4102, file: !2996, line: 395, type: !4118, scopeLine: 395, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4118 = !DISubroutineType(types: !4119)
!4119 = !{!4116, !4108, !1004}
!4120 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEdeEv", scope: !4102, file: !2996, line: 405, type: !4121, scopeLine: 405, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4121 = !DISubroutineType(types: !4122)
!4122 = !{!4123, !4127}
!4123 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !4124, file: !764, line: 1614, baseType: !4126)
!4124 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__add_lvalue_reference_helper<c10::NamedTensorMetaInterface, true>", scope: !2, file: !764, line: 1613, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !4125, identifier: "_ZTSSt29__add_lvalue_reference_helperIN3c1024NamedTensorMetaInterfaceELb1EE")
!4125 = !{!3857, !1168}
!4126 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !3855, size: 64)
!4127 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4128, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4128 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4102)
!4129 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEptEv", scope: !4102, file: !2996, line: 413, type: !4130, scopeLine: 413, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4130 = !DISubroutineType(types: !4131)
!4131 = !{!4132, !4127}
!4132 = !DIDerivedType(tag: DW_TAG_typedef, name: "pointer", scope: !4102, file: !2996, line: 251, baseType: !4051)
!4133 = !DISubprogram(name: "get", linkageName: "_ZNKSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE3getEv", scope: !4102, file: !2996, line: 421, type: !4130, scopeLine: 421, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4134 = !DISubprogram(name: "get_deleter", linkageName: "_ZNSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE11get_deleterEv", scope: !4102, file: !2996, line: 426, type: !4135, scopeLine: 426, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4135 = !DISubroutineType(types: !4136)
!4136 = !{!4137, !4108}
!4137 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4138, size: 64)
!4138 = !DIDerivedType(tag: DW_TAG_typedef, name: "deleter_type", scope: !4102, file: !2996, line: 253, baseType: !3843)
!4139 = !DISubprogram(name: "get_deleter", linkageName: "_ZNKSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE11get_deleterEv", scope: !4102, file: !2996, line: 431, type: !4140, scopeLine: 431, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4140 = !DISubroutineType(types: !4141)
!4141 = !{!4142, !4127}
!4142 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4143, size: 64)
!4143 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4138)
!4144 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEcvbEv", scope: !4102, file: !2996, line: 435, type: !4145, scopeLine: 435, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!4145 = !DISubroutineType(types: !4146)
!4146 = !{!378, !4127}
!4147 = !DISubprogram(name: "release", linkageName: "_ZNSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE7releaseEv", scope: !4102, file: !2996, line: 442, type: !4148, scopeLine: 442, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4148 = !DISubroutineType(types: !4149)
!4149 = !{!4132, !4108}
!4150 = !DISubprogram(name: "reset", linkageName: "_ZNSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE5resetEPS1_", scope: !4102, file: !2996, line: 452, type: !4151, scopeLine: 452, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4151 = !DISubroutineType(types: !4152)
!4152 = !{null, !4108, !4132}
!4153 = !DISubprogram(name: "swap", linkageName: "_ZNSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EE4swapERS4_", scope: !4102, file: !2996, line: 461, type: !4154, scopeLine: 461, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4154 = !DISubroutineType(types: !4155)
!4155 = !{null, !4108, !4116}
!4156 = !DISubprogram(name: "unique_ptr", scope: !4102, file: !2996, line: 468, type: !4157, scopeLine: 468, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4157 = !DISubroutineType(types: !4158)
!4158 = !{null, !4108, !4159}
!4159 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4128, size: 64)
!4160 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN3c1024NamedTensorMetaInterfaceESt14default_deleteIS1_EEaSERKS4_", scope: !4102, file: !2996, line: 469, type: !4161, scopeLine: 469, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4161 = !DISubroutineType(types: !4162)
!4162 = !{!4116, !4108, !4159}
!4163 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "_Storage<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, false>", scope: !4164, file: !249, line: 219, size: 256, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4211, templateParams: !4220, identifier: "_ZTSNSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE8_StorageIS5_Lb0EEE")
!4164 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Optional_payload_base<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >", scope: !2, file: !249, line: 107, size: 320, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4165, templateParams: !4209, identifier: "_ZTSSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE")
!4165 = !{!4166, !4167, !4168, !4172, !4173, !4178, !4182, !4185, !4188, !4192, !4195, !4196, !4197, !4198, !4202, !4208}
!4166 = !DIDerivedType(tag: DW_TAG_member, name: "_M_payload", scope: !4164, file: !249, line: 242, baseType: !4163, size: 256)
!4167 = !DIDerivedType(tag: DW_TAG_member, name: "_M_engaged", scope: !4164, file: !249, line: 244, baseType: !378, size: 8, offset: 256)
!4168 = !DISubprogram(name: "_Optional_payload_base", scope: !4164, file: !249, line: 111, type: !4169, scopeLine: 111, flags: DIFlagPrototyped, spFlags: 0)
!4169 = !DISubroutineType(types: !4170)
!4170 = !{null, !4171}
!4171 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4164, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4172 = !DISubprogram(name: "~_Optional_payload_base", scope: !4164, file: !249, line: 112, type: !4169, scopeLine: 112, flags: DIFlagPrototyped, spFlags: 0)
!4173 = !DISubprogram(name: "_Optional_payload_base", scope: !4164, file: !249, line: 132, type: !4174, scopeLine: 132, flags: DIFlagPrototyped, spFlags: 0)
!4174 = !DISubroutineType(types: !4175)
!4175 = !{null, !4171, !378, !4176}
!4176 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4177, size: 64)
!4177 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4164)
!4178 = !DISubprogram(name: "_Optional_payload_base", scope: !4164, file: !249, line: 142, type: !4179, scopeLine: 142, flags: DIFlagPrototyped, spFlags: 0)
!4179 = !DISubroutineType(types: !4180)
!4180 = !{null, !4171, !378, !4181}
!4181 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4164, size: 64)
!4182 = !DISubprogram(name: "_Optional_payload_base", scope: !4164, file: !249, line: 151, type: !4183, scopeLine: 151, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4183 = !DISubroutineType(types: !4184)
!4184 = !{null, !4171, !4176}
!4185 = !DISubprogram(name: "_Optional_payload_base", scope: !4164, file: !249, line: 155, type: !4186, scopeLine: 155, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4186 = !DISubroutineType(types: !4187)
!4187 = !{null, !4171, !4181}
!4188 = !DISubprogram(name: "operator=", linkageName: "_ZNSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEaSERKS6_", scope: !4164, file: !249, line: 158, type: !4189, scopeLine: 158, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4189 = !DISubroutineType(types: !4190)
!4190 = !{!4191, !4171, !4176}
!4191 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4164, size: 64)
!4192 = !DISubprogram(name: "operator=", linkageName: "_ZNSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEaSEOS6_", scope: !4164, file: !249, line: 161, type: !4193, scopeLine: 161, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4193 = !DISubroutineType(types: !4194)
!4194 = !{!4191, !4171, !4181}
!4195 = !DISubprogram(name: "_M_copy_assign", linkageName: "_ZNSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE14_M_copy_assignERKS6_", scope: !4164, file: !249, line: 165, type: !4183, scopeLine: 165, flags: DIFlagPrototyped, spFlags: 0)
!4196 = !DISubprogram(name: "_M_move_assign", linkageName: "_ZNSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE14_M_move_assignEOS6_", scope: !4164, file: !249, line: 180, type: !4186, scopeLine: 180, flags: DIFlagPrototyped, spFlags: 0)
!4197 = !DISubprogram(name: "_M_destroy", linkageName: "_ZNSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE10_M_destroyEv", scope: !4164, file: !249, line: 257, type: !4169, scopeLine: 257, flags: DIFlagPrototyped, spFlags: 0)
!4198 = !DISubprogram(name: "_M_get", linkageName: "_ZNSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE6_M_getEv", scope: !4164, file: !249, line: 268, type: !4199, scopeLine: 268, flags: DIFlagPrototyped, spFlags: 0)
!4199 = !DISubroutineType(types: !4200)
!4200 = !{!4201, !4171}
!4201 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !1414, size: 64)
!4202 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE6_M_getEv", scope: !4164, file: !249, line: 272, type: !4203, scopeLine: 272, flags: DIFlagPrototyped, spFlags: 0)
!4203 = !DISubroutineType(types: !4204)
!4204 = !{!4205, !4207}
!4205 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4206, size: 64)
!4206 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1414)
!4207 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4177, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4208 = !DISubprogram(name: "_M_reset", linkageName: "_ZNSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE8_M_resetEv", scope: !4164, file: !249, line: 277, type: !4169, scopeLine: 277, flags: DIFlagPrototyped, spFlags: 0)
!4209 = !{!4210}
!4210 = !DITemplateTypeParameter(name: "_Tp", type: !1414)
!4211 = !{!4212, !4214, !4215, !4219}
!4212 = !DIDerivedType(tag: DW_TAG_member, name: "_M_empty", scope: !4163, file: !249, line: 238, baseType: !4213, size: 8)
!4213 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Empty_byte", scope: !4164, file: !249, line: 195, size: 8, flags: DIFlagTypePassByValue, elements: !843, identifier: "_ZTSNSt22_Optional_payload_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE11_Empty_byteE")
!4214 = !DIDerivedType(tag: DW_TAG_member, name: "_M_value", scope: !4163, file: !249, line: 239, baseType: !1414, size: 256)
!4215 = !DISubprogram(name: "_Storage", scope: !4163, file: !249, line: 221, type: !4216, scopeLine: 221, flags: DIFlagPrototyped, spFlags: 0)
!4216 = !DISubroutineType(types: !4217)
!4217 = !{null, !4218}
!4218 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4163, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4219 = !DISubprogram(name: "~_Storage", scope: !4163, file: !249, line: 236, type: !4216, scopeLine: 236, flags: DIFlagPrototyped, spFlags: 0)
!4220 = !{!4221, !975}
!4221 = !DITemplateTypeParameter(name: "_Up", type: !1414)
!4222 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Optional_payload<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, true, false, false>", scope: !2, file: !249, line: 356, size: 320, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4223, templateParams: !4246, identifier: "_ZTSSt17_Optional_payloadINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb1ELb0ELb0EE")
!4223 = !{!4224, !4225, !4229, !4230, !4235, !4239, !4243}
!4224 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4222, baseType: !4164, extraData: i32 0)
!4225 = !DISubprogram(name: "_Optional_payload", scope: !4222, file: !249, line: 361, type: !4226, scopeLine: 361, flags: DIFlagPrototyped, spFlags: 0)
!4226 = !DISubroutineType(types: !4227)
!4227 = !{null, !4228}
!4228 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4222, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4229 = !DISubprogram(name: "~_Optional_payload", scope: !4222, file: !249, line: 362, type: !4226, scopeLine: 362, flags: DIFlagPrototyped, spFlags: 0)
!4230 = !DISubprogram(name: "_Optional_payload", scope: !4222, file: !249, line: 363, type: !4231, scopeLine: 363, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4231 = !DISubroutineType(types: !4232)
!4232 = !{null, !4228, !4233}
!4233 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4234, size: 64)
!4234 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4222)
!4235 = !DISubprogram(name: "_Optional_payload", scope: !4222, file: !249, line: 364, type: !4236, scopeLine: 364, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4236 = !DISubroutineType(types: !4237)
!4237 = !{null, !4228, !4238}
!4238 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4222, size: 64)
!4239 = !DISubprogram(name: "operator=", linkageName: "_ZNSt17_Optional_payloadINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb1ELb0ELb0EEaSERKS6_", scope: !4222, file: !249, line: 369, type: !4240, scopeLine: 369, flags: DIFlagPrototyped, spFlags: 0)
!4240 = !DISubroutineType(types: !4241)
!4241 = !{!4242, !4228, !4233}
!4242 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4222, size: 64)
!4243 = !DISubprogram(name: "operator=", linkageName: "_ZNSt17_Optional_payloadINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb1ELb0ELb0EEaSEOS6_", scope: !4222, file: !249, line: 378, type: !4244, scopeLine: 378, flags: DIFlagPrototyped, spFlags: 0)
!4244 = !DISubroutineType(types: !4245)
!4245 = !{!4242, !4228, !4238}
!4246 = !{!4210, !1168, !975, !975}
!4247 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Optional_payload<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, false, false, false>", scope: !2, file: !249, line: 389, size: 320, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4248, templateParams: !4271, identifier: "_ZTSSt17_Optional_payloadINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0ELb0ELb0EE")
!4248 = !{!4249, !4250, !4254, !4259, !4263, !4267, !4270}
!4249 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4247, baseType: !4222, extraData: i32 0)
!4250 = !DISubprogram(name: "_Optional_payload", scope: !4247, file: !249, line: 394, type: !4251, scopeLine: 394, flags: DIFlagPrototyped, spFlags: 0)
!4251 = !DISubroutineType(types: !4252)
!4252 = !{null, !4253}
!4253 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4247, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4254 = !DISubprogram(name: "_Optional_payload", scope: !4247, file: !249, line: 395, type: !4255, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4255 = !DISubroutineType(types: !4256)
!4256 = !{null, !4253, !4257}
!4257 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4258, size: 64)
!4258 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4247)
!4259 = !DISubprogram(name: "_Optional_payload", scope: !4247, file: !249, line: 396, type: !4260, scopeLine: 396, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4260 = !DISubroutineType(types: !4261)
!4261 = !{null, !4253, !4262}
!4262 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4247, size: 64)
!4263 = !DISubprogram(name: "operator=", linkageName: "_ZNSt17_Optional_payloadINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0ELb0ELb0EEaSERKS6_", scope: !4247, file: !249, line: 397, type: !4264, scopeLine: 397, flags: DIFlagPrototyped, spFlags: 0)
!4264 = !DISubroutineType(types: !4265)
!4265 = !{!4266, !4253, !4257}
!4266 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4247, size: 64)
!4267 = !DISubprogram(name: "operator=", linkageName: "_ZNSt17_Optional_payloadINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0ELb0ELb0EEaSEOS6_", scope: !4247, file: !249, line: 398, type: !4268, scopeLine: 398, flags: DIFlagPrototyped, spFlags: 0)
!4268 = !DISubroutineType(types: !4269)
!4269 = !{!4266, !4253, !4262}
!4270 = !DISubprogram(name: "~_Optional_payload", scope: !4247, file: !249, line: 401, type: !4251, scopeLine: 401, flags: DIFlagPrototyped, spFlags: 0)
!4271 = !{!4210, !975, !975, !975}
!4272 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Optional_base<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, false, false>", scope: !2, file: !249, line: 472, size: 320, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4273, templateParams: !4316, identifier: "_ZTSSt14_Optional_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0ELb0EE")
!4273 = !{!4274, !4295, !4296, !4300, !4305, !4309, !4313}
!4274 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4272, baseType: !4275, extraData: i32 0)
!4275 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "_Optional_base_impl<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::_Optional_base<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, false, false> >", scope: !2, file: !249, line: 407, size: 8, flags: DIFlagTypePassByValue, elements: !4276, templateParams: !4293, identifier: "_ZTSSt19_Optional_base_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14_Optional_baseIS5_Lb0ELb0EEE")
!4276 = !{!4277, !4281, !4282, !4287, !4290}
!4277 = !DISubprogram(name: "_M_destruct", linkageName: "_ZNSt19_Optional_base_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14_Optional_baseIS5_Lb0ELb0EEE11_M_destructEv", scope: !4275, file: !249, line: 424, type: !4278, scopeLine: 424, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!4278 = !DISubroutineType(types: !4279)
!4279 = !{null, !4280}
!4280 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4275, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4281 = !DISubprogram(name: "_M_reset", linkageName: "_ZNSt19_Optional_base_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14_Optional_baseIS5_Lb0ELb0EEE8_M_resetEv", scope: !4275, file: !249, line: 429, type: !4278, scopeLine: 429, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!4282 = !DISubprogram(name: "_M_is_engaged", linkageName: "_ZNKSt19_Optional_base_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14_Optional_baseIS5_Lb0ELb0EEE13_M_is_engagedEv", scope: !4275, file: !249, line: 432, type: !4283, scopeLine: 432, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!4283 = !DISubroutineType(types: !4284)
!4284 = !{!378, !4285}
!4285 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4286, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4286 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4275)
!4287 = !DISubprogram(name: "_M_get", linkageName: "_ZNSt19_Optional_base_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14_Optional_baseIS5_Lb0ELb0EEE6_M_getEv", scope: !4275, file: !249, line: 437, type: !4288, scopeLine: 437, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!4288 = !DISubroutineType(types: !4289)
!4289 = !{!4201, !4280}
!4290 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt19_Optional_base_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14_Optional_baseIS5_Lb0ELb0EEE6_M_getEv", scope: !4275, file: !249, line: 444, type: !4291, scopeLine: 444, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!4291 = !DISubroutineType(types: !4292)
!4292 = !{!4205, !4285}
!4293 = !{!4210, !4294}
!4294 = !DITemplateTypeParameter(name: "_Dp", type: !4272)
!4295 = !DIDerivedType(tag: DW_TAG_member, name: "_M_payload", scope: !4272, file: !249, line: 514, baseType: !4247, size: 320)
!4296 = !DISubprogram(name: "_Optional_base", scope: !4272, file: !249, line: 476, type: !4297, scopeLine: 476, flags: DIFlagPrototyped, spFlags: 0)
!4297 = !DISubroutineType(types: !4298)
!4298 = !{null, !4299}
!4299 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4272, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4300 = !DISubprogram(name: "_Optional_base", scope: !4272, file: !249, line: 499, type: !4301, scopeLine: 499, flags: DIFlagPrototyped, spFlags: 0)
!4301 = !DISubroutineType(types: !4302)
!4302 = !{null, !4299, !4303}
!4303 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4304, size: 64)
!4304 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4272)
!4305 = !DISubprogram(name: "_Optional_base", scope: !4272, file: !249, line: 504, type: !4306, scopeLine: 504, flags: DIFlagPrototyped, spFlags: 0)
!4306 = !DISubroutineType(types: !4307)
!4307 = !{null, !4299, !4308}
!4308 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4272, size: 64)
!4309 = !DISubprogram(name: "operator=", linkageName: "_ZNSt14_Optional_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0ELb0EEaSERKS6_", scope: !4272, file: !249, line: 511, type: !4310, scopeLine: 511, flags: DIFlagPrototyped, spFlags: 0)
!4310 = !DISubroutineType(types: !4311)
!4311 = !{!4312, !4299, !4303}
!4312 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4272, size: 64)
!4313 = !DISubprogram(name: "operator=", linkageName: "_ZNSt14_Optional_baseINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0ELb0EEaSEOS6_", scope: !4272, file: !249, line: 512, type: !4314, scopeLine: 512, flags: DIFlagPrototyped, spFlags: 0)
!4314 = !DISubroutineType(types: !4315)
!4315 = !{!4312, !4299, !4308}
!4316 = !{!4210, !975, !975}
!4317 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "optional<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >", scope: !2, file: !249, line: 662, size: 320, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4318, templateParams: !4209, identifier: "_ZTSSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE")
!4318 = !{!4319, !4320, !4324, !4328, !4331, !4335, !4338, !4344, !4348, !4351, !4354, !4358, !4362, !4365, !4366, !4367, !4368, !4369, !4370}
!4319 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4317, baseType: !4272, extraData: i32 0)
!4320 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4317, baseType: !4321, extraData: i32 0)
!4321 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Enable_copy_move<true, true, true, true, std::optional<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > >", scope: !2, file: !1227, line: 87, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !4322, identifier: "_ZTSSt17_Enable_copy_moveILb1ELb1ELb1ELb1ESt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEE")
!4322 = !{!1229, !1230, !1231, !1232, !4323}
!4323 = !DITemplateTypeParameter(name: "_Tag", type: !4317)
!4324 = !DISubprogram(name: "optional", scope: !4317, file: !249, line: 694, type: !4325, scopeLine: 694, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4325 = !DISubroutineType(types: !4326)
!4326 = !{null, !4327}
!4327 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4317, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4328 = !DISubprogram(name: "optional", scope: !4317, file: !249, line: 696, type: !4329, scopeLine: 696, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4329 = !DISubroutineType(types: !4330)
!4330 = !{null, !4327, !250}
!4331 = !DISubprogram(name: "operator=", linkageName: "_ZNSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEaSESt9nullopt_t", scope: !4317, file: !249, line: 789, type: !4332, scopeLine: 789, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4332 = !DISubroutineType(types: !4333)
!4333 = !{!4334, !4327, !250}
!4334 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4317, size: 64)
!4335 = !DISubprogram(name: "swap", linkageName: "_ZNSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE4swapERS6_", scope: !4317, file: !249, line: 896, type: !4336, scopeLine: 896, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4336 = !DISubroutineType(types: !4337)
!4337 = !{null, !4327, !4334}
!4338 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEptEv", scope: !4317, file: !249, line: 918, type: !4339, scopeLine: 918, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4339 = !DISubroutineType(types: !4340)
!4340 = !{!4341, !4342}
!4341 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4206, size: 64)
!4342 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4343, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4343 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4317)
!4344 = !DISubprogram(name: "operator->", linkageName: "_ZNSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEptEv", scope: !4317, file: !249, line: 922, type: !4345, scopeLine: 922, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4345 = !DISubroutineType(types: !4346)
!4346 = !{!4347, !4327}
!4347 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1414, size: 64)
!4348 = !DISubprogram(name: "operator*", linkageName: "_ZNKRSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEdeEv", scope: !4317, file: !249, line: 926, type: !4349, scopeLine: 926, flags: DIFlagPublic | DIFlagPrototyped | DIFlagLValueReference, spFlags: 0)
!4349 = !DISubroutineType(flags: DIFlagLValueReference, types: !4350)
!4350 = !{!4205, !4342}
!4351 = !DISubprogram(name: "operator*", linkageName: "_ZNRSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEdeEv", scope: !4317, file: !249, line: 930, type: !4352, scopeLine: 930, flags: DIFlagPublic | DIFlagPrototyped | DIFlagLValueReference, spFlags: 0)
!4352 = !DISubroutineType(flags: DIFlagLValueReference, types: !4353)
!4353 = !{!4201, !4327}
!4354 = !DISubprogram(name: "operator*", linkageName: "_ZNOSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEdeEv", scope: !4317, file: !249, line: 934, type: !4355, scopeLine: 934, flags: DIFlagPublic | DIFlagPrototyped | DIFlagRValueReference, spFlags: 0)
!4355 = !DISubroutineType(flags: DIFlagRValueReference, types: !4356)
!4356 = !{!4357, !4327}
!4357 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !1414, size: 64)
!4358 = !DISubprogram(name: "operator*", linkageName: "_ZNKOSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEdeEv", scope: !4317, file: !249, line: 938, type: !4359, scopeLine: 938, flags: DIFlagPublic | DIFlagPrototyped | DIFlagRValueReference, spFlags: 0)
!4359 = !DISubroutineType(flags: DIFlagRValueReference, types: !4360)
!4360 = !{!4361, !4342}
!4361 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4206, size: 64)
!4362 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEcvbEv", scope: !4317, file: !249, line: 941, type: !4363, scopeLine: 941, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!4363 = !DISubroutineType(types: !4364)
!4364 = !{!378, !4342}
!4365 = !DISubprogram(name: "has_value", linkageName: "_ZNKSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE9has_valueEv", scope: !4317, file: !249, line: 944, type: !4363, scopeLine: 944, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4366 = !DISubprogram(name: "value", linkageName: "_ZNKRSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE5valueEv", scope: !4317, file: !249, line: 948, type: !4349, scopeLine: 948, flags: DIFlagPublic | DIFlagPrototyped | DIFlagLValueReference, spFlags: 0)
!4367 = !DISubprogram(name: "value", linkageName: "_ZNRSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE5valueEv", scope: !4317, file: !249, line: 956, type: !4352, scopeLine: 956, flags: DIFlagPublic | DIFlagPrototyped | DIFlagLValueReference, spFlags: 0)
!4368 = !DISubprogram(name: "value", linkageName: "_ZNOSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE5valueEv", scope: !4317, file: !249, line: 964, type: !4355, scopeLine: 964, flags: DIFlagPublic | DIFlagPrototyped | DIFlagRValueReference, spFlags: 0)
!4369 = !DISubprogram(name: "value", linkageName: "_ZNKOSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE5valueEv", scope: !4317, file: !249, line: 972, type: !4359, scopeLine: 972, flags: DIFlagPublic | DIFlagPrototyped | DIFlagRValueReference, spFlags: 0)
!4370 = !DISubprogram(name: "reset", linkageName: "_ZNSt8optionalINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEE5resetEv", scope: !4317, file: !249, line: 1005, type: !4325, scopeLine: 1005, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4371 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ExtraMeta", scope: !36, file: !349, line: 238, size: 832, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4372, identifier: "_ZTSN3c109ExtraMetaE")
!4372 = !{!4373, !4374, !4375, !4378, !4379, !4380, !4384, !4385, !4390, !4394, !4398, !4401, !4404}
!4373 = !DIDerivedType(tag: DW_TAG_member, name: "symbolic_shape_meta_", scope: !4371, file: !349, line: 239, baseType: !3783, size: 64)
!4374 = !DIDerivedType(tag: DW_TAG_member, name: "named_tensor_meta_", scope: !4371, file: !349, line: 240, baseType: !4102, size: 64, offset: 64)
!4375 = !DIDerivedType(tag: DW_TAG_member, name: "backend_meta_", scope: !4371, file: !349, line: 241, baseType: !4376, size: 64, offset: 128)
!4376 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "intrusive_ptr<c10::BackendMeta, c10::detail::intrusive_target_default_null_type<c10::BackendMeta> >", scope: !36, file: !4377, line: 229, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1013intrusive_ptrINS_11BackendMetaENS_6detail34intrusive_target_default_null_typeIS1_EEEE")
!4377 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/intrusive_ptr.h", directory: "/home/mvh6224/CUDA-BOSolver")
!4378 = !DIDerivedType(tag: DW_TAG_member, name: "custom_data_ptr_error_msg_", scope: !4371, file: !349, line: 242, baseType: !4317, size: 320, offset: 192)
!4379 = !DIDerivedType(tag: DW_TAG_member, name: "custom_storage_error_msg_", scope: !4371, file: !349, line: 243, baseType: !4317, size: 320, offset: 512)
!4380 = !DISubprogram(name: "ExtraMeta", scope: !4371, file: !349, line: 245, type: !4381, scopeLine: 245, flags: DIFlagPrototyped, spFlags: 0)
!4381 = !DISubroutineType(types: !4382)
!4382 = !{null, !4383}
!4383 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4371, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4384 = !DISubprogram(name: "~ExtraMeta", scope: !4371, file: !349, line: 246, type: !4381, scopeLine: 246, flags: DIFlagPrototyped, spFlags: 0)
!4385 = !DISubprogram(name: "ExtraMeta", scope: !4371, file: !349, line: 247, type: !4386, scopeLine: 247, flags: DIFlagPrototyped, spFlags: 0)
!4386 = !DISubroutineType(types: !4387)
!4387 = !{null, !4383, !4388}
!4388 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4389, size: 64)
!4389 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4371)
!4390 = !DISubprogram(name: "operator=", linkageName: "_ZN3c109ExtraMetaaSERKS0_", scope: !4371, file: !349, line: 265, type: !4391, scopeLine: 265, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4391 = !DISubroutineType(types: !4392)
!4392 = !{!4393, !4383, !4388}
!4393 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4371, size: 64)
!4394 = !DISubprogram(name: "ExtraMeta", scope: !4371, file: !349, line: 266, type: !4395, scopeLine: 266, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4395 = !DISubroutineType(types: !4396)
!4396 = !{null, !4383, !4397}
!4397 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4371, size: 64)
!4398 = !DISubprogram(name: "operator=", linkageName: "_ZN3c109ExtraMetaaSEOS0_", scope: !4371, file: !349, line: 267, type: !4399, scopeLine: 267, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4399 = !DISubroutineType(types: !4400)
!4400 = !{!4393, !4383, !4397}
!4401 = !DISubprogram(name: "ExtraMeta", scope: !4371, file: !349, line: 269, type: !4402, scopeLine: 269, flags: DIFlagPrototyped, spFlags: 0)
!4402 = !DISubroutineType(types: !4403)
!4403 = !{null, !4383, !3783, !4102, !4376, !4317, !4317}
!4404 = !DISubprogram(name: "clone", linkageName: "_ZNK3c109ExtraMeta5cloneEv", scope: !4371, file: !349, line: 281, type: !4405, scopeLine: 281, flags: DIFlagPrototyped, spFlags: 0)
!4405 = !DISubroutineType(types: !4406)
!4406 = !{!4407, !4725}
!4407 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "unique_ptr<c10::ExtraMeta, std::default_delete<c10::ExtraMeta> >", scope: !2, file: !2996, line: 242, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4408, templateParams: !4656, identifier: "_ZTSSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE")
!4408 = !{!4409, !4668, !4673, !4676, !4680, !4683, !4691, !4695, !4696, !4701, !4706, !4709, !4712, !4715, !4718, !4722}
!4409 = !DIDerivedType(tag: DW_TAG_member, name: "_M_t", scope: !4407, file: !2996, line: 248, baseType: !4410, size: 64)
!4410 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__uniq_ptr_data<c10::ExtraMeta, std::default_delete<c10::ExtraMeta>, true, true>", scope: !2, file: !2996, line: 208, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4411, templateParams: !4667, identifier: "_ZTSSt15__uniq_ptr_dataIN3c109ExtraMetaESt14default_deleteIS1_ELb1ELb1EE")
!4411 = !{!4412, !4658, !4663}
!4412 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4410, baseType: !4413, extraData: i32 0)
!4413 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "__uniq_ptr_impl<c10::ExtraMeta, std::default_delete<c10::ExtraMeta> >", scope: !2, file: !2996, line: 128, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4414, templateParams: !4656, identifier: "_ZTSSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE")
!4414 = !{!4415, !4613, !4617, !4626, !4630, !4634, !4638, !4643, !4646, !4649, !4650, !4653}
!4415 = !DIDerivedType(tag: DW_TAG_member, name: "_M_t", scope: !4413, file: !2996, line: 201, baseType: !4416, size: 64)
!4416 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "tuple<c10::ExtraMeta *, std::default_delete<c10::ExtraMeta> >", scope: !2, file: !3014, line: 981, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4417, templateParams: !4612, identifier: "_ZTSSt5tupleIJPN3c109ExtraMetaESt14default_deleteIS1_EEE")
!4417 = !{!4418, !4583, !4584, !4590, !4594, !4602, !4609}
!4418 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4416, baseType: !4419, flags: DIFlagPublic, extraData: i32 0)
!4419 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Tuple_impl<0, c10::ExtraMeta *, std::default_delete<c10::ExtraMeta> >", scope: !2, file: !3014, line: 258, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4420, templateParams: !4579, identifier: "_ZTSSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE")
!4420 = !{!4421, !4505, !4540, !4544, !4549, !4554, !4559, !4563, !4566, !4569, !4572, !4576}
!4421 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4419, baseType: !4422, extraData: i32 0)
!4422 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Tuple_impl<1, std::default_delete<c10::ExtraMeta> >", scope: !2, file: !3014, line: 416, size: 8, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !4423, templateParams: !4501, identifier: "_ZTSSt11_Tuple_implILm1EJSt14default_deleteIN3c109ExtraMetaEEEE")
!4423 = !{!4424, !4472, !4476, !4481, !4485, !4488, !4491, !4494, !4498}
!4424 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4422, baseType: !4425, flags: DIFlagPrivate, extraData: i32 0)
!4425 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Head_base<1, std::default_delete<c10::ExtraMeta>, true>", scope: !2, file: !3014, line: 78, size: 8, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !4426, templateParams: !4470, identifier: "_ZTSSt10_Head_baseILm1ESt14default_deleteIN3c109ExtraMetaEELb1EE")
!4426 = !{!4427, !4442, !4446, !4450, !4455, !4459, !4462, !4467}
!4427 = !DIDerivedType(tag: DW_TAG_member, name: "_M_head_impl", scope: !4425, file: !3014, line: 129, baseType: !4428, size: 8)
!4428 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "default_delete<c10::ExtraMeta>", scope: !2, file: !2996, line: 63, size: 8, flags: DIFlagTypePassByValue, elements: !4429, templateParams: !4440, identifier: "_ZTSSt14default_deleteIN3c109ExtraMetaEE")
!4429 = !{!4430, !4434}
!4430 = !DISubprogram(name: "default_delete", scope: !4428, file: !2996, line: 66, type: !4431, scopeLine: 66, flags: DIFlagPrototyped, spFlags: 0)
!4431 = !DISubroutineType(types: !4432)
!4432 = !{null, !4433}
!4433 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4428, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4434 = !DISubprogram(name: "operator()", linkageName: "_ZNKSt14default_deleteIN3c109ExtraMetaEEclEPS1_", scope: !4428, file: !2996, line: 79, type: !4435, scopeLine: 79, flags: DIFlagPrototyped, spFlags: 0)
!4435 = !DISubroutineType(types: !4436)
!4436 = !{null, !4437, !4439}
!4437 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4438, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4438 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4428)
!4439 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4371, size: 64)
!4440 = !{!4441}
!4441 = !DITemplateTypeParameter(name: "_Tp", type: !4371)
!4442 = !DISubprogram(name: "_Head_base", scope: !4425, file: !3014, line: 80, type: !4443, scopeLine: 80, flags: DIFlagPrototyped, spFlags: 0)
!4443 = !DISubroutineType(types: !4444)
!4444 = !{null, !4445}
!4445 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4425, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4446 = !DISubprogram(name: "_Head_base", scope: !4425, file: !3014, line: 83, type: !4447, scopeLine: 83, flags: DIFlagPrototyped, spFlags: 0)
!4447 = !DISubroutineType(types: !4448)
!4448 = !{null, !4445, !4449}
!4449 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4438, size: 64)
!4450 = !DISubprogram(name: "_Head_base", scope: !4425, file: !3014, line: 86, type: !4451, scopeLine: 86, flags: DIFlagPrototyped, spFlags: 0)
!4451 = !DISubroutineType(types: !4452)
!4452 = !{null, !4445, !4453}
!4453 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4454, size: 64)
!4454 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4425)
!4455 = !DISubprogram(name: "_Head_base", scope: !4425, file: !3014, line: 87, type: !4456, scopeLine: 87, flags: DIFlagPrototyped, spFlags: 0)
!4456 = !DISubroutineType(types: !4457)
!4457 = !{null, !4445, !4458}
!4458 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4425, size: 64)
!4459 = !DISubprogram(name: "_Head_base", scope: !4425, file: !3014, line: 94, type: !4460, scopeLine: 94, flags: DIFlagPrototyped, spFlags: 0)
!4460 = !DISubroutineType(types: !4461)
!4461 = !{null, !4445, !3037, !3044}
!4462 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm1ESt14default_deleteIN3c109ExtraMetaEELb1EE7_M_headERS4_", scope: !4425, file: !3014, line: 124, type: !4463, scopeLine: 124, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4463 = !DISubroutineType(types: !4464)
!4464 = !{!4465, !4466}
!4465 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4428, size: 64)
!4466 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4425, size: 64)
!4467 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm1ESt14default_deleteIN3c109ExtraMetaEELb1EE7_M_headERKS4_", scope: !4425, file: !3014, line: 127, type: !4468, scopeLine: 127, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4468 = !DISubroutineType(types: !4469)
!4469 = !{!4449, !4453}
!4470 = !{!3066, !4471, !1168}
!4471 = !DITemplateTypeParameter(name: "_Head", type: !4428)
!4472 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c109ExtraMetaEEEE7_M_headERS4_", scope: !4422, file: !3014, line: 424, type: !4473, scopeLine: 424, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4473 = !DISubroutineType(types: !4474)
!4474 = !{!4465, !4475}
!4475 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4422, size: 64)
!4476 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c109ExtraMetaEEEE7_M_headERKS4_", scope: !4422, file: !3014, line: 427, type: !4477, scopeLine: 427, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4477 = !DISubroutineType(types: !4478)
!4478 = !{!4449, !4479}
!4479 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4480, size: 64)
!4480 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4422)
!4481 = !DISubprogram(name: "_Tuple_impl", scope: !4422, file: !3014, line: 430, type: !4482, scopeLine: 430, flags: DIFlagPrototyped, spFlags: 0)
!4482 = !DISubroutineType(types: !4483)
!4483 = !{null, !4484}
!4484 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4422, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4485 = !DISubprogram(name: "_Tuple_impl", scope: !4422, file: !3014, line: 434, type: !4486, scopeLine: 434, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!4486 = !DISubroutineType(types: !4487)
!4487 = !{null, !4484, !4449}
!4488 = !DISubprogram(name: "_Tuple_impl", scope: !4422, file: !3014, line: 444, type: !4489, scopeLine: 444, flags: DIFlagPrototyped, spFlags: 0)
!4489 = !DISubroutineType(types: !4490)
!4490 = !{null, !4484, !4479}
!4491 = !DISubprogram(name: "operator=", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c109ExtraMetaEEEEaSERKS4_", scope: !4422, file: !3014, line: 448, type: !4492, scopeLine: 448, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4492 = !DISubroutineType(types: !4493)
!4493 = !{!4475, !4484, !4479}
!4494 = !DISubprogram(name: "_Tuple_impl", scope: !4422, file: !3014, line: 454, type: !4495, scopeLine: 454, flags: DIFlagPrototyped, spFlags: 0)
!4495 = !DISubroutineType(types: !4496)
!4496 = !{null, !4484, !4497}
!4497 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4422, size: 64)
!4498 = !DISubprogram(name: "_M_swap", linkageName: "_ZNSt11_Tuple_implILm1EJSt14default_deleteIN3c109ExtraMetaEEEE7_M_swapERS4_", scope: !4422, file: !3014, line: 544, type: !4499, scopeLine: 544, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!4499 = !DISubroutineType(types: !4500)
!4500 = !{null, !4484, !4475}
!4501 = !{!3066, !4502}
!4502 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "_Elements", value: !4503)
!4503 = !{!4504}
!4504 = !DITemplateTypeParameter(type: !4428)
!4505 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !4419, baseType: !4506, flags: DIFlagPrivate, extraData: i32 0)
!4506 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Head_base<0, c10::ExtraMeta *, false>", scope: !2, file: !3014, line: 187, size: 64, flags: DIFlagTypePassByValue | DIFlagNonTrivial, elements: !4507, templateParams: !4538, identifier: "_ZTSSt10_Head_baseILm0EPN3c109ExtraMetaELb0EE")
!4507 = !{!4508, !4509, !4513, !4518, !4523, !4527, !4530, !4535}
!4508 = !DIDerivedType(tag: DW_TAG_member, name: "_M_head_impl", scope: !4506, file: !3014, line: 238, baseType: !4439, size: 64)
!4509 = !DISubprogram(name: "_Head_base", scope: !4506, file: !3014, line: 189, type: !4510, scopeLine: 189, flags: DIFlagPrototyped, spFlags: 0)
!4510 = !DISubroutineType(types: !4511)
!4511 = !{null, !4512}
!4512 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4506, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4513 = !DISubprogram(name: "_Head_base", scope: !4506, file: !3014, line: 192, type: !4514, scopeLine: 192, flags: DIFlagPrototyped, spFlags: 0)
!4514 = !DISubroutineType(types: !4515)
!4515 = !{null, !4512, !4516}
!4516 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4517, size: 64)
!4517 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4439)
!4518 = !DISubprogram(name: "_Head_base", scope: !4506, file: !3014, line: 195, type: !4519, scopeLine: 195, flags: DIFlagPrototyped, spFlags: 0)
!4519 = !DISubroutineType(types: !4520)
!4520 = !{null, !4512, !4521}
!4521 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4522, size: 64)
!4522 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4506)
!4523 = !DISubprogram(name: "_Head_base", scope: !4506, file: !3014, line: 196, type: !4524, scopeLine: 196, flags: DIFlagPrototyped, spFlags: 0)
!4524 = !DISubroutineType(types: !4525)
!4525 = !{null, !4512, !4526}
!4526 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4506, size: 64)
!4527 = !DISubprogram(name: "_Head_base", scope: !4506, file: !3014, line: 203, type: !4528, scopeLine: 203, flags: DIFlagPrototyped, spFlags: 0)
!4528 = !DISubroutineType(types: !4529)
!4529 = !{null, !4512, !3037, !3044}
!4530 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm0EPN3c109ExtraMetaELb0EE7_M_headERS3_", scope: !4506, file: !3014, line: 233, type: !4531, scopeLine: 233, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4531 = !DISubroutineType(types: !4532)
!4532 = !{!4533, !4534}
!4533 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4439, size: 64)
!4534 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4506, size: 64)
!4535 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm0EPN3c109ExtraMetaELb0EE7_M_headERKS3_", scope: !4506, file: !3014, line: 236, type: !4536, scopeLine: 236, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4536 = !DISubroutineType(types: !4537)
!4537 = !{!4516, !4521}
!4538 = !{!3137, !4539, !975}
!4539 = !DITemplateTypeParameter(name: "_Head", type: !4439)
!4540 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_headERS5_", scope: !4419, file: !3014, line: 268, type: !4541, scopeLine: 268, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4541 = !DISubroutineType(types: !4542)
!4542 = !{!4533, !4543}
!4543 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4419, size: 64)
!4544 = !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_headERKS5_", scope: !4419, file: !3014, line: 271, type: !4545, scopeLine: 271, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4545 = !DISubroutineType(types: !4546)
!4546 = !{!4516, !4547}
!4547 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4548, size: 64)
!4548 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4419)
!4549 = !DISubprogram(name: "_M_tail", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_tailERS5_", scope: !4419, file: !3014, line: 274, type: !4550, scopeLine: 274, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4550 = !DISubroutineType(types: !4551)
!4551 = !{!4552, !4543}
!4552 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4553, size: 64)
!4553 = !DIDerivedType(tag: DW_TAG_typedef, name: "_Inherited", scope: !4419, file: !3014, line: 264, baseType: !4422)
!4554 = !DISubprogram(name: "_M_tail", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_tailERKS5_", scope: !4419, file: !3014, line: 277, type: !4555, scopeLine: 277, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4555 = !DISubroutineType(types: !4556)
!4556 = !{!4557, !4547}
!4557 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4558, size: 64)
!4558 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4553)
!4559 = !DISubprogram(name: "_Tuple_impl", scope: !4419, file: !3014, line: 279, type: !4560, scopeLine: 279, flags: DIFlagPrototyped, spFlags: 0)
!4560 = !DISubroutineType(types: !4561)
!4561 = !{null, !4562}
!4562 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4419, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4563 = !DISubprogram(name: "_Tuple_impl", scope: !4419, file: !3014, line: 283, type: !4564, scopeLine: 283, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!4564 = !DISubroutineType(types: !4565)
!4565 = !{null, !4562, !4516, !4449}
!4566 = !DISubprogram(name: "_Tuple_impl", scope: !4419, file: !3014, line: 295, type: !4567, scopeLine: 295, flags: DIFlagPrototyped, spFlags: 0)
!4567 = !DISubroutineType(types: !4568)
!4568 = !{null, !4562, !4547}
!4569 = !DISubprogram(name: "operator=", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEEaSERKS5_", scope: !4419, file: !3014, line: 299, type: !4570, scopeLine: 299, flags: DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4570 = !DISubroutineType(types: !4571)
!4571 = !{!4543, !4562, !4547}
!4572 = !DISubprogram(name: "_Tuple_impl", scope: !4419, file: !3014, line: 301, type: !4573, scopeLine: 301, flags: DIFlagPrototyped, spFlags: 0)
!4573 = !DISubroutineType(types: !4574)
!4574 = !{null, !4562, !4575}
!4575 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4419, size: 64)
!4576 = !DISubprogram(name: "_M_swap", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_swapERS5_", scope: !4419, file: !3014, line: 406, type: !4577, scopeLine: 406, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!4577 = !DISubroutineType(types: !4578)
!4578 = !{null, !4562, !4543}
!4579 = !{!3137, !4580}
!4580 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "_Elements", value: !4581)
!4581 = !{!4582, !4504}
!4582 = !DITemplateTypeParameter(type: !4439)
!4583 = !DISubprogram(name: "__nothrow_default_constructible", linkageName: "_ZNSt5tupleIJPN3c109ExtraMetaESt14default_deleteIS1_EEE31__nothrow_default_constructibleEv", scope: !4416, file: !3014, line: 1035, type: !3190, scopeLine: 1035, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!4584 = !DISubprogram(name: "tuple", scope: !4416, file: !3014, line: 1088, type: !4585, scopeLine: 1088, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4585 = !DISubroutineType(types: !4586)
!4586 = !{null, !4587, !4588}
!4587 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4416, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4588 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4589, size: 64)
!4589 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4416)
!4590 = !DISubprogram(name: "tuple", scope: !4416, file: !3014, line: 1090, type: !4591, scopeLine: 1090, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4591 = !DISubroutineType(types: !4592)
!4592 = !{null, !4587, !4593}
!4593 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4416, size: 64)
!4594 = !DISubprogram(name: "operator=", linkageName: "_ZNSt5tupleIJPN3c109ExtraMetaESt14default_deleteIS1_EEEaSERKS5_", scope: !4416, file: !3014, line: 1267, type: !4595, scopeLine: 1267, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4595 = !DISubroutineType(types: !4596)
!4596 = !{!4597, !4587, !4598}
!4597 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4416, size: 64)
!4598 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !4599, file: !764, line: 2221, baseType: !4588)
!4599 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "conditional<true, const std::tuple<c10::ExtraMeta *, std::default_delete<c10::ExtraMeta> > &, const std::__nonesuch &>", scope: !2, file: !764, line: 2220, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !4600, identifier: "_ZTSSt11conditionalILb1ERKSt5tupleIJPN3c109ExtraMetaESt14default_deleteIS2_EEERKSt10__nonesuchE")
!4600 = !{!3209, !4601, !3211}
!4601 = !DITemplateTypeParameter(name: "_Iftrue", type: !4588)
!4602 = !DISubprogram(name: "operator=", linkageName: "_ZNSt5tupleIJPN3c109ExtraMetaESt14default_deleteIS1_EEEaSEOS5_", scope: !4416, file: !3014, line: 1278, type: !4603, scopeLine: 1278, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4603 = !DISubroutineType(types: !4604)
!4604 = !{!4597, !4587, !4605}
!4605 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !4606, file: !764, line: 2221, baseType: !4593)
!4606 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "conditional<true, std::tuple<c10::ExtraMeta *, std::default_delete<c10::ExtraMeta> > &&, std::__nonesuch &&>", scope: !2, file: !764, line: 2220, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !4607, identifier: "_ZTSSt11conditionalILb1EOSt5tupleIJPN3c109ExtraMetaESt14default_deleteIS2_EEEOSt10__nonesuchE")
!4607 = !{!3209, !4608, !3222}
!4608 = !DITemplateTypeParameter(name: "_Iftrue", type: !4593)
!4609 = !DISubprogram(name: "swap", linkageName: "_ZNSt5tupleIJPN3c109ExtraMetaESt14default_deleteIS1_EEE4swapERS5_", scope: !4416, file: !3014, line: 1331, type: !4610, scopeLine: 1331, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4610 = !DISubroutineType(types: !4611)
!4611 = !{null, !4587, !4597}
!4612 = !{!4580}
!4613 = !DISubprogram(name: "__uniq_ptr_impl", scope: !4413, file: !2996, line: 154, type: !4614, scopeLine: 154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4614 = !DISubroutineType(types: !4615)
!4615 = !{null, !4616}
!4616 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4413, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4617 = !DISubprogram(name: "__uniq_ptr_impl", scope: !4413, file: !2996, line: 155, type: !4618, scopeLine: 155, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4618 = !DISubroutineType(types: !4619)
!4619 = !{null, !4616, !4620}
!4620 = !DIDerivedType(tag: DW_TAG_typedef, name: "pointer", scope: !4413, file: !2996, line: 148, baseType: !4621)
!4621 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !4622, file: !2996, line: 133, baseType: !4439)
!4622 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_Ptr<c10::ExtraMeta, std::default_delete<c10::ExtraMeta>, void>", scope: !4413, file: !2996, line: 131, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !4623, identifier: "_ZTSNSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE4_PtrIS1_S3_vEE")
!4623 = !{!4624, !4625, !3244}
!4624 = !DITemplateTypeParameter(name: "_Up", type: !4371)
!4625 = !DITemplateTypeParameter(name: "_Ep", type: !4428)
!4626 = !DISubprogram(name: "__uniq_ptr_impl", scope: !4413, file: !2996, line: 161, type: !4627, scopeLine: 161, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4627 = !DISubroutineType(types: !4628)
!4628 = !{null, !4616, !4629}
!4629 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4413, size: 64)
!4630 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EEaSEOS4_", scope: !4413, file: !2996, line: 165, type: !4631, scopeLine: 165, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4631 = !DISubroutineType(types: !4632)
!4632 = !{!4633, !4616, !4629}
!4633 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4413, size: 64)
!4634 = !DISubprogram(name: "_M_ptr", linkageName: "_ZNSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE6_M_ptrEv", scope: !4413, file: !2996, line: 172, type: !4635, scopeLine: 172, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4635 = !DISubroutineType(types: !4636)
!4636 = !{!4637, !4616}
!4637 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4620, size: 64)
!4638 = !DISubprogram(name: "_M_ptr", linkageName: "_ZNKSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE6_M_ptrEv", scope: !4413, file: !2996, line: 173, type: !4639, scopeLine: 173, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4639 = !DISubroutineType(types: !4640)
!4640 = !{!4620, !4641}
!4641 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4642, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4642 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4413)
!4643 = !DISubprogram(name: "_M_deleter", linkageName: "_ZNSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE10_M_deleterEv", scope: !4413, file: !2996, line: 174, type: !4644, scopeLine: 174, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4644 = !DISubroutineType(types: !4645)
!4645 = !{!4465, !4616}
!4646 = !DISubprogram(name: "_M_deleter", linkageName: "_ZNKSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE10_M_deleterEv", scope: !4413, file: !2996, line: 175, type: !4647, scopeLine: 175, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4647 = !DISubroutineType(types: !4648)
!4648 = !{!4449, !4641}
!4649 = !DISubprogram(name: "reset", linkageName: "_ZNSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE5resetEPS1_", scope: !4413, file: !2996, line: 177, type: !4618, scopeLine: 177, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4650 = !DISubprogram(name: "release", linkageName: "_ZNSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE7releaseEv", scope: !4413, file: !2996, line: 185, type: !4651, scopeLine: 185, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4651 = !DISubroutineType(types: !4652)
!4652 = !{!4620, !4616}
!4653 = !DISubprogram(name: "swap", linkageName: "_ZNSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE4swapERS4_", scope: !4413, file: !2996, line: 193, type: !4654, scopeLine: 193, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4654 = !DISubroutineType(types: !4655)
!4655 = !{null, !4616, !4633}
!4656 = !{!4441, !4657}
!4657 = !DITemplateTypeParameter(name: "_Dp", type: !4428)
!4658 = !DISubprogram(name: "__uniq_ptr_data", scope: !4410, file: !2996, line: 211, type: !4659, scopeLine: 211, flags: DIFlagPrototyped, spFlags: 0)
!4659 = !DISubroutineType(types: !4660)
!4660 = !{null, !4661, !4662}
!4661 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4410, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4662 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4410, size: 64)
!4663 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__uniq_ptr_dataIN3c109ExtraMetaESt14default_deleteIS1_ELb1ELb1EEaSEOS4_", scope: !4410, file: !2996, line: 212, type: !4664, scopeLine: 212, flags: DIFlagPrototyped, spFlags: 0)
!4664 = !DISubroutineType(types: !4665)
!4665 = !{!4666, !4661, !4662}
!4666 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4410, size: 64)
!4667 = !{!4441, !4657, !1168, !1168}
!4668 = !DISubprogram(name: "unique_ptr", scope: !4407, file: !2996, line: 327, type: !4669, scopeLine: 327, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4669 = !DISubroutineType(types: !4670)
!4670 = !{null, !4671, !4672}
!4671 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4407, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4672 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !4407, size: 64)
!4673 = !DISubprogram(name: "~unique_ptr", scope: !4407, file: !2996, line: 355, type: !4674, scopeLine: 355, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4674 = !DISubroutineType(types: !4675)
!4675 = !{null, !4671}
!4676 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEaSEOS4_", scope: !4407, file: !2996, line: 371, type: !4677, scopeLine: 371, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4677 = !DISubroutineType(types: !4678)
!4678 = !{!4679, !4671, !4672}
!4679 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4407, size: 64)
!4680 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEaSEDn", scope: !4407, file: !2996, line: 395, type: !4681, scopeLine: 395, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4681 = !DISubroutineType(types: !4682)
!4682 = !{!4679, !4671, !1004}
!4683 = !DISubprogram(name: "operator*", linkageName: "_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEdeEv", scope: !4407, file: !2996, line: 405, type: !4684, scopeLine: 405, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4684 = !DISubroutineType(types: !4685)
!4685 = !{!4686, !4689}
!4686 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !4687, file: !764, line: 1614, baseType: !4393)
!4687 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__add_lvalue_reference_helper<c10::ExtraMeta, true>", scope: !2, file: !764, line: 1613, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !4688, identifier: "_ZTSSt29__add_lvalue_reference_helperIN3c109ExtraMetaELb1EE")
!4688 = !{!4441, !1168}
!4689 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4690, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4690 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4407)
!4691 = !DISubprogram(name: "operator->", linkageName: "_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEptEv", scope: !4407, file: !2996, line: 413, type: !4692, scopeLine: 413, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4692 = !DISubroutineType(types: !4693)
!4693 = !{!4694, !4689}
!4694 = !DIDerivedType(tag: DW_TAG_typedef, name: "pointer", scope: !4407, file: !2996, line: 251, baseType: !4620)
!4695 = !DISubprogram(name: "get", linkageName: "_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE3getEv", scope: !4407, file: !2996, line: 421, type: !4692, scopeLine: 421, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4696 = !DISubprogram(name: "get_deleter", linkageName: "_ZNSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE11get_deleterEv", scope: !4407, file: !2996, line: 426, type: !4697, scopeLine: 426, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4697 = !DISubroutineType(types: !4698)
!4698 = !{!4699, !4671}
!4699 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4700, size: 64)
!4700 = !DIDerivedType(tag: DW_TAG_typedef, name: "deleter_type", scope: !4407, file: !2996, line: 253, baseType: !4428)
!4701 = !DISubprogram(name: "get_deleter", linkageName: "_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE11get_deleterEv", scope: !4407, file: !2996, line: 431, type: !4702, scopeLine: 431, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4702 = !DISubroutineType(types: !4703)
!4703 = !{!4704, !4689}
!4704 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4705, size: 64)
!4705 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4700)
!4706 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEcvbEv", scope: !4407, file: !2996, line: 435, type: !4707, scopeLine: 435, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!4707 = !DISubroutineType(types: !4708)
!4708 = !{!378, !4689}
!4709 = !DISubprogram(name: "release", linkageName: "_ZNSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE7releaseEv", scope: !4407, file: !2996, line: 442, type: !4710, scopeLine: 442, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4710 = !DISubroutineType(types: !4711)
!4711 = !{!4694, !4671}
!4712 = !DISubprogram(name: "reset", linkageName: "_ZNSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE5resetEPS1_", scope: !4407, file: !2996, line: 452, type: !4713, scopeLine: 452, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4713 = !DISubroutineType(types: !4714)
!4714 = !{null, !4671, !4694}
!4715 = !DISubprogram(name: "swap", linkageName: "_ZNSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE4swapERS4_", scope: !4407, file: !2996, line: 461, type: !4716, scopeLine: 461, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!4716 = !DISubroutineType(types: !4717)
!4717 = !{null, !4671, !4679}
!4718 = !DISubprogram(name: "unique_ptr", scope: !4407, file: !2996, line: 468, type: !4719, scopeLine: 468, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4719 = !DISubroutineType(types: !4720)
!4720 = !{null, !4671, !4721}
!4721 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4690, size: 64)
!4722 = !DISubprogram(name: "operator=", linkageName: "_ZNSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEaSERKS4_", scope: !4407, file: !2996, line: 469, type: !4723, scopeLine: 469, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!4723 = !DISubroutineType(types: !4724)
!4724 = !{!4679, !4671, !4721}
!4725 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4389, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!4726 = !{!0}
!4727 = !{!4728, !4733, !4738, !4740, !4742, !4744, !4746, !4750, !4752, !4754, !4756, !4758, !4760, !4762, !4764, !4766, !4768, !4770, !4772, !4774, !4776, !4778, !4782, !4784, !4786, !4788, !4792, !4797, !4799, !4801, !4805, !4809, !4811, !4813, !4815, !4817, !4819, !4821, !4823, !4825, !4829, !4833, !4835, !4840, !4844, !4846, !4848, !4850, !4852, !4854, !4858, !4860, !4862, !4867, !4872, !4876, !4878, !4880, !4882, !4884, !4888, !4890, !4892, !4896, !4898, !4900, !4902, !4904, !4906, !4908, !4910, !4912, !4914, !4918, !4924, !4926, !4928, !4932, !4934, !4936, !4938, !4940, !4942, !4944, !4946, !4950, !4954, !4956, !4958, !4963, !4965, !4967, !4969, !4971, !4973, !4975, !4978, !4980, !4982, !4984, !4989, !4991, !4993, !4995, !4997, !4999, !5001, !5003, !5005, !5007, !5009, !5011, !5015, !5017, !5019, !5021, !5023, !5025, !5027, !5029, !5031, !5033, !5035, !5037, !5039, !5041, !5043, !5045, !5049, !5051, !5055, !5057, !5059, !5061, !5063, !5065, !5067, !5069, !5071, !5073, !5077, !5079, !5083, !5085, !5087, !5089, !5093, !5095, !5099, !5101, !5103, !5105, !5107, !5109, !5111, !5113, !5115, !5117, !5119, !5121, !5123, !5127, !5129, !5133, !5135, !5137, !5139, !5141, !5143, !5147, !5149, !5151, !5153, !5155, !5157, !5159, !5163, !5167, !5169, !5171, !5173, !5175, !5179, !5181, !5185, !5187, !5189, !5191, !5193, !5195, !5197, !5201, !5203, !5207, !5209, !5211, !5215, !5217, !5219, !5221, !5223, !5225, !5227, !5231, !5235, !5241, !5245, !5249, !5254, !5256, !5258, !5262, !5266, !5274, !5276, !5280, !5284, !5288, !5293, !5295, !5299, !5303, !5307, !5315, !5319, !5323, !5325, !5329, !5333, !5337, !5343, !5347, !5351, !5353, !5361, !5365, !5371, !5373, !5375, !5379, !5383, !5387, !5391, !5395, !5399, !5400, !5401, !5402, !5404, !5405, !5406, !5407, !5408, !5409, !5410, !5412, !5413, !5414, !5415, !5416, !5417, !5418, !5420, !5421, !5422, !5423, !5424, !5425, !5426, !5427, !5428, !5429, !5430, !5431, !5432, !5433, !5434, !5435, !5436, !5437, !5438, !5439, !5440, !5441, !5442, !5443, !5444, !5448, !5450, !5452, !5454, !5456, !5458, !5460, !5462, !5464, !5466, !5468, !5470, !5472, !5474, !5476, !5478, !5480, !5482, !5484, !5486, !5488, !5490, !5492, !5494, !5496, !5498, !5500, !5502, !5504, !5506, !5508, !5510, !5512, !5514, !5516, !5518, !5520, !5522, !5524, !5526, !5528, !5530, !5532, !5534, !5536, !5538, !5540, !5542, !5544, !5546, !5548, !5550, !5552, !5554, !5556, !5557, !5558, !5562, !5564, !5570, !5576, !5581, !5585, !5587, !5589, !5591, !5593, !5600, !5604, !5608, !5612, !5616, !5620, !5625, !5629, !5631, !5635, !5641, !5645, !5650, !5652, !5654, !5658, !5662, !5664, !5666, !5668, !5670, !5674, !5676, !5678, !5682, !5686, !5690, !5694, !5698, !5702, !5704, !5716, !5720, !5724, !5728, !5730, !5732, !5736, !5740, !5741, !5742, !5743, !5744, !5745, !5747, !5750, !5753, !5754, !5757, !5759, !5761, !5763, !5766, !5769, !5772, !5775, !5778, !5780, !5781, !5782, !5783, !5786, !5788, !5790, !5792, !5794, !5797, !5800, !5803, !5806, !5809, !5811, !5816, !5833, !5836, !5841, !5848, !5853, !5857, !5861, !5865, !5869, !5871, !5873, !5877, !5883, !5887, !5893, !5899, !5901, !5905, !5909, !5913, !5917, !5921, !5923, !5927, !5931, !5935, !5937, !5941, !5945, !5949, !5951, !5953, !5957, !5978, !5982, !5986, !5990, !5992, !5998, !6000, !6006, !6010, !6014, !6018, !6022, !6026, !6030, !6032, !6034, !6038, !6042, !6046, !6048, !6052, !6056, !6058, !6060, !6064, !6068, !6072, !6076, !6077, !6078, !6079, !6080, !6081, !6082, !6083, !6084, !6085, !6086, !6090, !6094, !6098, !6102, !6107, !6111, !6113, !6115, !6117, !6119, !6121, !6123, !6125, !6127, !6129, !6131, !6133, !6135, !6137, !6143, !6146, !6147, !6149, !6151, !6153, !6155, !6159, !6161, !6163, !6165, !6167, !6169, !6171, !6173, !6175, !6179, !6183, !6185, !6189, !6193, !6194, !6197, !6199, !6202, !6204, !6207, !6208, !6211, !6222, !6226, !6230, !6234, !6238, !6241, !6247, !6251, !6256, !6258, !6262, !6266, !6268, !6270, !6272, !6276, !6280, !6284, !6288, !6292, !6294, !6296, !6298, !6302, !6306, !6310, !6312, !6314, !6320, !6321, !6322, !6324, !6326, !6356, !6358, !6362, !6391, !6392, !6394, !6400, !6404, !6406, !6408, !6410, !6412, !6414, !6416, !6418, !6420, !6422, !6424, !6426, !6429, !6432, !6433, !6438, !6442, !6443, !6448, !6452, !6457, !6462, !6466, !6472, !6476, !6478, !6482, !6489, !6494, !6499, !6503, !6506, !6507, !6510, !6511, !6513, !6516, !6520, !6523, !6526, !6528, !6534, !6537, !6539, !6545, !6549, !6554, !6560, !6566, !6570, !6577, !6584, !6586, !6588, !6590, !6592, !6594, !6595, !6597, !6599, !6601, !6605, !6607, !6608, !6610, !6611, !6612, !6613, !6617, !6619, !6621, !6622, !6624, !6625, !6627, !6628, !6629, !6630, !6632, !6634, !6636, !6637, !6638, !6639, !6641, !6643, !6645, !6647, !6649, !6651, !6652, !6653, !6655, !6657, !6658, !6659, !6661, !6663, !6664, !6666, !6668, !6670, !6672, !6674, !6676, !6678, !6680, !6682, !6684, !6685, !6686, !6690, !6692, !6695, !6697, !6700, !6702, !6704, !6706, !6709, !6712, !6715, !6717, !6719, !6721, !6724, !6727, !6730, !6733, !6736, !6739, !6741, !6743, !6746, !6749, !6751, !6752, !6755, !6758, !6760, !6763, !6766, !6769, !6772, !6775, !6778, !6781, !6784, !6787, !6790, !6792, !6794, !6796, !6800, !6804, !6806, !6807, !6810, !6813, !6816, !6818, !6820, !6822, !6823, !6826, !6830, !6832, !6835, !6840, !6841, !6843, !6844, !6850, !6853, !6855, !6857, !6861, !6863, !6870, !6872, !6873, !6875, !6877, !6879, !6881, !6885, !6887, !6889, !6891, !6893, !6895, !6896, !6898, !6902}
!4728 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4729, file: !4730, line: 200)
!4729 = !DISubprogram(name: "abs", linkageName: "_ZL3absi", scope: !4730, file: !4730, line: 30, type: !4731, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4730 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/__clang_cuda_math_forward_declares.h", directory: "")
!4731 = !DISubroutineType(types: !4732)
!4732 = !{!256, !256}
!4733 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4734, file: !4730, line: 201)
!4734 = !DISubprogram(name: "acos", linkageName: "_ZL4acosf", scope: !4730, file: !4730, line: 32, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4735 = !DISubroutineType(types: !4736)
!4736 = !{!4737, !4737}
!4737 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!4738 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4739, file: !4730, line: 202)
!4739 = !DISubprogram(name: "acosh", linkageName: "_ZL5acoshf", scope: !4730, file: !4730, line: 34, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4740 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4741, file: !4730, line: 203)
!4741 = !DISubprogram(name: "asin", linkageName: "_ZL4asinf", scope: !4730, file: !4730, line: 36, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4742 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4743, file: !4730, line: 204)
!4743 = !DISubprogram(name: "asinh", linkageName: "_ZL5asinhf", scope: !4730, file: !4730, line: 38, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4744 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4745, file: !4730, line: 205)
!4745 = !DISubprogram(name: "atan", linkageName: "_ZL4atanf", scope: !4730, file: !4730, line: 42, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4746 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4747, file: !4730, line: 206)
!4747 = !DISubprogram(name: "atan2", linkageName: "_ZL5atan2ff", scope: !4730, file: !4730, line: 40, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4748 = !DISubroutineType(types: !4749)
!4749 = !{!4737, !4737, !4737}
!4750 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4751, file: !4730, line: 207)
!4751 = !DISubprogram(name: "atanh", linkageName: "_ZL5atanhf", scope: !4730, file: !4730, line: 44, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4752 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4753, file: !4730, line: 208)
!4753 = !DISubprogram(name: "cbrt", linkageName: "_ZL4cbrtf", scope: !4730, file: !4730, line: 46, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4754 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4755, file: !4730, line: 209)
!4755 = !DISubprogram(name: "ceil", linkageName: "_ZL4ceilf", scope: !4730, file: !4730, line: 48, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4756 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4757, file: !4730, line: 210)
!4757 = !DISubprogram(name: "copysign", linkageName: "_ZL8copysignff", scope: !4730, file: !4730, line: 50, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4758 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4759, file: !4730, line: 211)
!4759 = !DISubprogram(name: "cos", linkageName: "_ZL3cosf", scope: !4730, file: !4730, line: 52, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4760 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4761, file: !4730, line: 212)
!4761 = !DISubprogram(name: "cosh", linkageName: "_ZL4coshf", scope: !4730, file: !4730, line: 54, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4762 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4763, file: !4730, line: 213)
!4763 = !DISubprogram(name: "erf", linkageName: "_ZL3erff", scope: !4730, file: !4730, line: 58, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4764 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4765, file: !4730, line: 214)
!4765 = !DISubprogram(name: "erfc", linkageName: "_ZL4erfcf", scope: !4730, file: !4730, line: 56, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4766 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4767, file: !4730, line: 215)
!4767 = !DISubprogram(name: "exp", linkageName: "_ZL3expf", scope: !4730, file: !4730, line: 62, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4768 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4769, file: !4730, line: 216)
!4769 = !DISubprogram(name: "exp2", linkageName: "_ZL4exp2f", scope: !4730, file: !4730, line: 60, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4770 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4771, file: !4730, line: 217)
!4771 = !DISubprogram(name: "expm1", linkageName: "_ZL5expm1f", scope: !4730, file: !4730, line: 64, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4772 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4773, file: !4730, line: 218)
!4773 = !DISubprogram(name: "fabs", linkageName: "_ZL4fabsf", scope: !4730, file: !4730, line: 66, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4774 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4775, file: !4730, line: 219)
!4775 = !DISubprogram(name: "fdim", linkageName: "_ZL4fdimff", scope: !4730, file: !4730, line: 68, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4776 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4777, file: !4730, line: 220)
!4777 = !DISubprogram(name: "floor", linkageName: "_ZL5floorf", scope: !4730, file: !4730, line: 70, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4778 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4779, file: !4730, line: 221)
!4779 = !DISubprogram(name: "fma", linkageName: "_ZL3fmafff", scope: !4730, file: !4730, line: 72, type: !4780, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4780 = !DISubroutineType(types: !4781)
!4781 = !{!4737, !4737, !4737, !4737}
!4782 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4783, file: !4730, line: 222)
!4783 = !DISubprogram(name: "fmax", linkageName: "_ZL4fmaxff", scope: !4730, file: !4730, line: 74, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4784 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4785, file: !4730, line: 223)
!4785 = !DISubprogram(name: "fmin", linkageName: "_ZL4fminff", scope: !4730, file: !4730, line: 76, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4786 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4787, file: !4730, line: 224)
!4787 = !DISubprogram(name: "fmod", linkageName: "_ZL4fmodff", scope: !4730, file: !4730, line: 78, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4788 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4789, file: !4730, line: 225)
!4789 = !DISubprogram(name: "fpclassify", linkageName: "_ZL10fpclassifyf", scope: !4730, file: !4730, line: 80, type: !4790, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4790 = !DISubroutineType(types: !4791)
!4791 = !{!256, !4737}
!4792 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4793, file: !4730, line: 226)
!4793 = !DISubprogram(name: "frexp", linkageName: "_ZL5frexpfPi", scope: !4730, file: !4730, line: 82, type: !4794, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4794 = !DISubroutineType(types: !4795)
!4795 = !{!4737, !4737, !4796}
!4796 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !256, size: 64)
!4797 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4798, file: !4730, line: 227)
!4798 = !DISubprogram(name: "hypot", linkageName: "_ZL5hypotff", scope: !4730, file: !4730, line: 84, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4799 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4800, file: !4730, line: 228)
!4800 = !DISubprogram(name: "ilogb", linkageName: "_ZL5ilogbf", scope: !4730, file: !4730, line: 86, type: !4790, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4801 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4802, file: !4730, line: 229)
!4802 = !DISubprogram(name: "isfinite", linkageName: "_ZL8isfinitef", scope: !4730, file: !4730, line: 91, type: !4803, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4803 = !DISubroutineType(types: !4804)
!4804 = !{!378, !4737}
!4805 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4806, file: !4730, line: 230)
!4806 = !DISubprogram(name: "isgreater", linkageName: "_ZL9isgreaterff", scope: !4730, file: !4730, line: 95, type: !4807, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4807 = !DISubroutineType(types: !4808)
!4808 = !{!378, !4737, !4737}
!4809 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4810, file: !4730, line: 231)
!4810 = !DISubprogram(name: "isgreaterequal", linkageName: "_ZL14isgreaterequalff", scope: !4730, file: !4730, line: 94, type: !4807, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4811 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4812, file: !4730, line: 232)
!4812 = !DISubprogram(name: "isinf", linkageName: "_ZL5isinff", scope: !4730, file: !4730, line: 100, type: !4803, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4813 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4814, file: !4730, line: 233)
!4814 = !DISubprogram(name: "isless", linkageName: "_ZL6islessff", scope: !4730, file: !4730, line: 104, type: !4807, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4815 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4816, file: !4730, line: 234)
!4816 = !DISubprogram(name: "islessequal", linkageName: "_ZL11islessequalff", scope: !4730, file: !4730, line: 103, type: !4807, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4817 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4818, file: !4730, line: 235)
!4818 = !DISubprogram(name: "islessgreater", linkageName: "_ZL13islessgreaterff", scope: !4730, file: !4730, line: 106, type: !4807, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4819 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4820, file: !4730, line: 236)
!4820 = !DISubprogram(name: "isnan", linkageName: "_ZL5isnanf", scope: !4730, file: !4730, line: 111, type: !4803, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4821 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4822, file: !4730, line: 237)
!4822 = !DISubprogram(name: "isnormal", linkageName: "_ZL8isnormalf", scope: !4730, file: !4730, line: 113, type: !4803, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4823 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4824, file: !4730, line: 238)
!4824 = !DISubprogram(name: "isunordered", linkageName: "_ZL11isunorderedff", scope: !4730, file: !4730, line: 115, type: !4807, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4825 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4826, file: !4730, line: 239)
!4826 = !DISubprogram(name: "labs", linkageName: "_ZL4labsl", scope: !4730, file: !4730, line: 116, type: !4827, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4827 = !DISubroutineType(types: !4828)
!4828 = !{!575, !575}
!4829 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4830, file: !4730, line: 240)
!4830 = !DISubprogram(name: "ldexp", linkageName: "_ZL5ldexpfi", scope: !4730, file: !4730, line: 118, type: !4831, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4831 = !DISubroutineType(types: !4832)
!4832 = !{!4737, !4737, !256}
!4833 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4834, file: !4730, line: 241)
!4834 = !DISubprogram(name: "lgamma", linkageName: "_ZL6lgammaf", scope: !4730, file: !4730, line: 120, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4835 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4836, file: !4730, line: 242)
!4836 = !DISubprogram(name: "llabs", linkageName: "_ZL5llabsx", scope: !4730, file: !4730, line: 121, type: !4837, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4837 = !DISubroutineType(types: !4838)
!4838 = !{!4839, !4839}
!4839 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!4840 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4841, file: !4730, line: 243)
!4841 = !DISubprogram(name: "llrint", linkageName: "_ZL6llrintf", scope: !4730, file: !4730, line: 123, type: !4842, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4842 = !DISubroutineType(types: !4843)
!4843 = !{!4839, !4737}
!4844 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4845, file: !4730, line: 244)
!4845 = !DISubprogram(name: "log", linkageName: "_ZL3logf", scope: !4730, file: !4730, line: 133, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4846 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4847, file: !4730, line: 245)
!4847 = !DISubprogram(name: "log10", linkageName: "_ZL5log10f", scope: !4730, file: !4730, line: 125, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4848 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4849, file: !4730, line: 246)
!4849 = !DISubprogram(name: "log1p", linkageName: "_ZL5log1pf", scope: !4730, file: !4730, line: 127, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4850 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4851, file: !4730, line: 247)
!4851 = !DISubprogram(name: "log2", linkageName: "_ZL4log2f", scope: !4730, file: !4730, line: 129, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4852 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4853, file: !4730, line: 248)
!4853 = !DISubprogram(name: "logb", linkageName: "_ZL4logbf", scope: !4730, file: !4730, line: 131, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4854 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4855, file: !4730, line: 249)
!4855 = !DISubprogram(name: "lrint", linkageName: "_ZL5lrintf", scope: !4730, file: !4730, line: 135, type: !4856, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4856 = !DISubroutineType(types: !4857)
!4857 = !{!575, !4737}
!4858 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4859, file: !4730, line: 250)
!4859 = !DISubprogram(name: "lround", linkageName: "_ZL6lroundf", scope: !4730, file: !4730, line: 137, type: !4856, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4860 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4861, file: !4730, line: 251)
!4861 = !DISubprogram(name: "llround", linkageName: "_ZL7llroundf", scope: !4730, file: !4730, line: 138, type: !4842, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4862 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4863, file: !4730, line: 252)
!4863 = !DISubprogram(name: "modf", linkageName: "_ZL4modffPf", scope: !4730, file: !4730, line: 140, type: !4864, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4864 = !DISubroutineType(types: !4865)
!4865 = !{!4737, !4737, !4866}
!4866 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4737, size: 64)
!4867 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4868, file: !4730, line: 253)
!4868 = !DISubprogram(name: "nan", linkageName: "_ZL3nanPKc", scope: !4730, file: !4730, line: 141, type: !4869, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4869 = !DISubroutineType(types: !4870)
!4870 = !{!4871, !1452}
!4871 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!4872 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4873, file: !4730, line: 254)
!4873 = !DISubprogram(name: "nanf", linkageName: "_ZL4nanfPKc", scope: !4730, file: !4730, line: 142, type: !4874, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4874 = !DISubroutineType(types: !4875)
!4875 = !{!4737, !1452}
!4876 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4877, file: !4730, line: 255)
!4877 = !DISubprogram(name: "nearbyint", linkageName: "_ZL9nearbyintf", scope: !4730, file: !4730, line: 144, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4878 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4879, file: !4730, line: 256)
!4879 = !DISubprogram(name: "nextafter", linkageName: "_ZL9nextafterff", scope: !4730, file: !4730, line: 146, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4880 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4881, file: !4730, line: 257)
!4881 = !DISubprogram(name: "pow", linkageName: "_ZL3powfi", scope: !4730, file: !4730, line: 150, type: !4831, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4882 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4883, file: !4730, line: 258)
!4883 = !DISubprogram(name: "remainder", linkageName: "_ZL9remainderff", scope: !4730, file: !4730, line: 152, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4884 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4885, file: !4730, line: 259)
!4885 = !DISubprogram(name: "remquo", linkageName: "_ZL6remquoffPi", scope: !4730, file: !4730, line: 154, type: !4886, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4886 = !DISubroutineType(types: !4887)
!4887 = !{!4737, !4737, !4737, !4796}
!4888 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4889, file: !4730, line: 260)
!4889 = !DISubprogram(name: "rint", linkageName: "_ZL4rintf", scope: !4730, file: !4730, line: 156, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4890 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4891, file: !4730, line: 261)
!4891 = !DISubprogram(name: "round", linkageName: "_ZL5roundf", scope: !4730, file: !4730, line: 158, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4892 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4893, file: !4730, line: 262)
!4893 = !DISubprogram(name: "scalbln", linkageName: "_ZL7scalblnfl", scope: !4730, file: !4730, line: 160, type: !4894, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4894 = !DISubroutineType(types: !4895)
!4895 = !{!4737, !4737, !575}
!4896 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4897, file: !4730, line: 263)
!4897 = !DISubprogram(name: "scalbn", linkageName: "_ZL6scalbnfi", scope: !4730, file: !4730, line: 162, type: !4831, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4898 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4899, file: !4730, line: 264)
!4899 = !DISubprogram(name: "signbit", linkageName: "_ZL7signbitf", scope: !4730, file: !4730, line: 167, type: !4803, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4900 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4901, file: !4730, line: 265)
!4901 = !DISubprogram(name: "sin", linkageName: "_ZL3sinf", scope: !4730, file: !4730, line: 169, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4902 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4903, file: !4730, line: 266)
!4903 = !DISubprogram(name: "sinh", linkageName: "_ZL4sinhf", scope: !4730, file: !4730, line: 171, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4904 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4905, file: !4730, line: 267)
!4905 = !DISubprogram(name: "sqrt", linkageName: "_ZL4sqrtf", scope: !4730, file: !4730, line: 173, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4906 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4907, file: !4730, line: 268)
!4907 = !DISubprogram(name: "tan", linkageName: "_ZL3tanf", scope: !4730, file: !4730, line: 175, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4908 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4909, file: !4730, line: 269)
!4909 = !DISubprogram(name: "tanh", linkageName: "_ZL4tanhf", scope: !4730, file: !4730, line: 177, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4910 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4911, file: !4730, line: 270)
!4911 = !DISubprogram(name: "tgamma", linkageName: "_ZL6tgammaf", scope: !4730, file: !4730, line: 179, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4912 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4913, file: !4730, line: 271)
!4913 = !DISubprogram(name: "trunc", linkageName: "_ZL5truncf", scope: !4730, file: !4730, line: 181, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!4914 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4915, file: !4917, line: 52)
!4915 = !DISubprogram(name: "abs", scope: !4916, file: !4916, line: 848, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!4916 = !DIFile(filename: "/usr/include/stdlib.h", directory: "")
!4917 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/std_abs.h", directory: "")
!4918 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4919, file: !4923, line: 83)
!4919 = !DISubprogram(name: "acos", scope: !4920, file: !4920, line: 53, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4920 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/mathcalls.h", directory: "")
!4921 = !DISubroutineType(types: !4922)
!4922 = !{!4871, !4871}
!4923 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/cmath", directory: "")
!4924 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4925, file: !4923, line: 102)
!4925 = !DISubprogram(name: "asin", scope: !4920, file: !4920, line: 55, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4926 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4927, file: !4923, line: 121)
!4927 = !DISubprogram(name: "atan", scope: !4920, file: !4920, line: 57, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4928 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4929, file: !4923, line: 140)
!4929 = !DISubprogram(name: "atan2", scope: !4920, file: !4920, line: 59, type: !4930, flags: DIFlagPrototyped, spFlags: 0)
!4930 = !DISubroutineType(types: !4931)
!4931 = !{!4871, !4871, !4871}
!4932 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4933, file: !4923, line: 161)
!4933 = !DISubprogram(name: "ceil", scope: !4920, file: !4920, line: 159, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4934 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4935, file: !4923, line: 180)
!4935 = !DISubprogram(name: "cos", scope: !4920, file: !4920, line: 62, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4936 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4937, file: !4923, line: 199)
!4937 = !DISubprogram(name: "cosh", scope: !4920, file: !4920, line: 71, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4938 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4939, file: !4923, line: 218)
!4939 = !DISubprogram(name: "exp", scope: !4920, file: !4920, line: 95, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4940 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4941, file: !4923, line: 237)
!4941 = !DISubprogram(name: "fabs", scope: !4920, file: !4920, line: 162, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4942 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4943, file: !4923, line: 256)
!4943 = !DISubprogram(name: "floor", scope: !4920, file: !4920, line: 165, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4944 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4945, file: !4923, line: 275)
!4945 = !DISubprogram(name: "fmod", scope: !4920, file: !4920, line: 168, type: !4930, flags: DIFlagPrototyped, spFlags: 0)
!4946 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4947, file: !4923, line: 296)
!4947 = !DISubprogram(name: "frexp", scope: !4920, file: !4920, line: 98, type: !4948, flags: DIFlagPrototyped, spFlags: 0)
!4948 = !DISubroutineType(types: !4949)
!4949 = !{!4871, !4871, !4796}
!4950 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4951, file: !4923, line: 315)
!4951 = !DISubprogram(name: "ldexp", scope: !4920, file: !4920, line: 101, type: !4952, flags: DIFlagPrototyped, spFlags: 0)
!4952 = !DISubroutineType(types: !4953)
!4953 = !{!4871, !4871, !256}
!4954 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4955, file: !4923, line: 334)
!4955 = !DISubprogram(name: "log", scope: !4920, file: !4920, line: 104, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4956 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4957, file: !4923, line: 353)
!4957 = !DISubprogram(name: "log10", scope: !4920, file: !4920, line: 107, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4958 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4959, file: !4923, line: 372)
!4959 = !DISubprogram(name: "modf", scope: !4920, file: !4920, line: 110, type: !4960, flags: DIFlagPrototyped, spFlags: 0)
!4960 = !DISubroutineType(types: !4961)
!4961 = !{!4871, !4871, !4962}
!4962 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4871, size: 64)
!4963 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4964, file: !4923, line: 384)
!4964 = !DISubprogram(name: "pow", scope: !4920, file: !4920, line: 140, type: !4930, flags: DIFlagPrototyped, spFlags: 0)
!4965 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4966, file: !4923, line: 421)
!4966 = !DISubprogram(name: "sin", scope: !4920, file: !4920, line: 64, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4967 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4968, file: !4923, line: 440)
!4968 = !DISubprogram(name: "sinh", scope: !4920, file: !4920, line: 73, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4969 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4970, file: !4923, line: 459)
!4970 = !DISubprogram(name: "sqrt", scope: !4920, file: !4920, line: 143, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4971 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4972, file: !4923, line: 478)
!4972 = !DISubprogram(name: "tan", scope: !4920, file: !4920, line: 66, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4973 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4974, file: !4923, line: 497)
!4974 = !DISubprogram(name: "tanh", scope: !4920, file: !4920, line: 75, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4975 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4976, file: !4923, line: 1065)
!4976 = !DIDerivedType(tag: DW_TAG_typedef, name: "double_t", file: !4977, line: 164, baseType: !4871)
!4977 = !DIFile(filename: "/usr/include/math.h", directory: "")
!4978 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4979, file: !4923, line: 1066)
!4979 = !DIDerivedType(tag: DW_TAG_typedef, name: "float_t", file: !4977, line: 163, baseType: !4737)
!4980 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4981, file: !4923, line: 1069)
!4981 = !DISubprogram(name: "acosh", scope: !4920, file: !4920, line: 85, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4982 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4983, file: !4923, line: 1070)
!4983 = !DISubprogram(name: "acoshf", scope: !4920, file: !4920, line: 85, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!4984 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4985, file: !4923, line: 1071)
!4985 = !DISubprogram(name: "acoshl", scope: !4920, file: !4920, line: 85, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!4986 = !DISubroutineType(types: !4987)
!4987 = !{!4988, !4988}
!4988 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!4989 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4990, file: !4923, line: 1073)
!4990 = !DISubprogram(name: "asinh", scope: !4920, file: !4920, line: 87, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4991 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4992, file: !4923, line: 1074)
!4992 = !DISubprogram(name: "asinhf", scope: !4920, file: !4920, line: 87, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!4993 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4994, file: !4923, line: 1075)
!4994 = !DISubprogram(name: "asinhl", scope: !4920, file: !4920, line: 87, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!4995 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4996, file: !4923, line: 1077)
!4996 = !DISubprogram(name: "atanh", scope: !4920, file: !4920, line: 89, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!4997 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !4998, file: !4923, line: 1078)
!4998 = !DISubprogram(name: "atanhf", scope: !4920, file: !4920, line: 89, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!4999 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5000, file: !4923, line: 1079)
!5000 = !DISubprogram(name: "atanhl", scope: !4920, file: !4920, line: 89, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5001 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5002, file: !4923, line: 1081)
!5002 = !DISubprogram(name: "cbrt", scope: !4920, file: !4920, line: 152, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5003 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5004, file: !4923, line: 1082)
!5004 = !DISubprogram(name: "cbrtf", scope: !4920, file: !4920, line: 152, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5005 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5006, file: !4923, line: 1083)
!5006 = !DISubprogram(name: "cbrtl", scope: !4920, file: !4920, line: 152, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5007 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5008, file: !4923, line: 1085)
!5008 = !DISubprogram(name: "copysign", scope: !4920, file: !4920, line: 198, type: !4930, flags: DIFlagPrototyped, spFlags: 0)
!5009 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5010, file: !4923, line: 1086)
!5010 = !DISubprogram(name: "copysignf", scope: !4920, file: !4920, line: 198, type: !4748, flags: DIFlagPrototyped, spFlags: 0)
!5011 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5012, file: !4923, line: 1087)
!5012 = !DISubprogram(name: "copysignl", scope: !4920, file: !4920, line: 198, type: !5013, flags: DIFlagPrototyped, spFlags: 0)
!5013 = !DISubroutineType(types: !5014)
!5014 = !{!4988, !4988, !4988}
!5015 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5016, file: !4923, line: 1089)
!5016 = !DISubprogram(name: "erf", scope: !4920, file: !4920, line: 231, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5017 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5018, file: !4923, line: 1090)
!5018 = !DISubprogram(name: "erff", scope: !4920, file: !4920, line: 231, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5019 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5020, file: !4923, line: 1091)
!5020 = !DISubprogram(name: "erfl", scope: !4920, file: !4920, line: 231, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5021 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5022, file: !4923, line: 1093)
!5022 = !DISubprogram(name: "erfc", scope: !4920, file: !4920, line: 232, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5023 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5024, file: !4923, line: 1094)
!5024 = !DISubprogram(name: "erfcf", scope: !4920, file: !4920, line: 232, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5025 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5026, file: !4923, line: 1095)
!5026 = !DISubprogram(name: "erfcl", scope: !4920, file: !4920, line: 232, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5027 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5028, file: !4923, line: 1097)
!5028 = !DISubprogram(name: "exp2", scope: !4920, file: !4920, line: 130, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5029 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5030, file: !4923, line: 1098)
!5030 = !DISubprogram(name: "exp2f", scope: !4920, file: !4920, line: 130, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5031 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5032, file: !4923, line: 1099)
!5032 = !DISubprogram(name: "exp2l", scope: !4920, file: !4920, line: 130, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5033 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5034, file: !4923, line: 1101)
!5034 = !DISubprogram(name: "expm1", scope: !4920, file: !4920, line: 119, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5035 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5036, file: !4923, line: 1102)
!5036 = !DISubprogram(name: "expm1f", scope: !4920, file: !4920, line: 119, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5037 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5038, file: !4923, line: 1103)
!5038 = !DISubprogram(name: "expm1l", scope: !4920, file: !4920, line: 119, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5039 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5040, file: !4923, line: 1105)
!5040 = !DISubprogram(name: "fdim", scope: !4920, file: !4920, line: 329, type: !4930, flags: DIFlagPrototyped, spFlags: 0)
!5041 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5042, file: !4923, line: 1106)
!5042 = !DISubprogram(name: "fdimf", scope: !4920, file: !4920, line: 329, type: !4748, flags: DIFlagPrototyped, spFlags: 0)
!5043 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5044, file: !4923, line: 1107)
!5044 = !DISubprogram(name: "fdiml", scope: !4920, file: !4920, line: 329, type: !5013, flags: DIFlagPrototyped, spFlags: 0)
!5045 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5046, file: !4923, line: 1109)
!5046 = !DISubprogram(name: "fma", scope: !4920, file: !4920, line: 340, type: !5047, flags: DIFlagPrototyped, spFlags: 0)
!5047 = !DISubroutineType(types: !5048)
!5048 = !{!4871, !4871, !4871, !4871}
!5049 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5050, file: !4923, line: 1110)
!5050 = !DISubprogram(name: "fmaf", scope: !4920, file: !4920, line: 340, type: !4780, flags: DIFlagPrototyped, spFlags: 0)
!5051 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5052, file: !4923, line: 1111)
!5052 = !DISubprogram(name: "fmal", scope: !4920, file: !4920, line: 340, type: !5053, flags: DIFlagPrototyped, spFlags: 0)
!5053 = !DISubroutineType(types: !5054)
!5054 = !{!4988, !4988, !4988, !4988}
!5055 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5056, file: !4923, line: 1113)
!5056 = !DISubprogram(name: "fmax", scope: !4920, file: !4920, line: 333, type: !4930, flags: DIFlagPrototyped, spFlags: 0)
!5057 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5058, file: !4923, line: 1114)
!5058 = !DISubprogram(name: "fmaxf", scope: !4920, file: !4920, line: 333, type: !4748, flags: DIFlagPrototyped, spFlags: 0)
!5059 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5060, file: !4923, line: 1115)
!5060 = !DISubprogram(name: "fmaxl", scope: !4920, file: !4920, line: 333, type: !5013, flags: DIFlagPrototyped, spFlags: 0)
!5061 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5062, file: !4923, line: 1117)
!5062 = !DISubprogram(name: "fmin", scope: !4920, file: !4920, line: 336, type: !4930, flags: DIFlagPrototyped, spFlags: 0)
!5063 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5064, file: !4923, line: 1118)
!5064 = !DISubprogram(name: "fminf", scope: !4920, file: !4920, line: 336, type: !4748, flags: DIFlagPrototyped, spFlags: 0)
!5065 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5066, file: !4923, line: 1119)
!5066 = !DISubprogram(name: "fminl", scope: !4920, file: !4920, line: 336, type: !5013, flags: DIFlagPrototyped, spFlags: 0)
!5067 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5068, file: !4923, line: 1121)
!5068 = !DISubprogram(name: "hypot", scope: !4920, file: !4920, line: 147, type: !4930, flags: DIFlagPrototyped, spFlags: 0)
!5069 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5070, file: !4923, line: 1122)
!5070 = !DISubprogram(name: "hypotf", scope: !4920, file: !4920, line: 147, type: !4748, flags: DIFlagPrototyped, spFlags: 0)
!5071 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5072, file: !4923, line: 1123)
!5072 = !DISubprogram(name: "hypotl", scope: !4920, file: !4920, line: 147, type: !5013, flags: DIFlagPrototyped, spFlags: 0)
!5073 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5074, file: !4923, line: 1125)
!5074 = !DISubprogram(name: "ilogb", scope: !4920, file: !4920, line: 283, type: !5075, flags: DIFlagPrototyped, spFlags: 0)
!5075 = !DISubroutineType(types: !5076)
!5076 = !{!256, !4871}
!5077 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5078, file: !4923, line: 1126)
!5078 = !DISubprogram(name: "ilogbf", scope: !4920, file: !4920, line: 283, type: !4790, flags: DIFlagPrototyped, spFlags: 0)
!5079 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5080, file: !4923, line: 1127)
!5080 = !DISubprogram(name: "ilogbl", scope: !4920, file: !4920, line: 283, type: !5081, flags: DIFlagPrototyped, spFlags: 0)
!5081 = !DISubroutineType(types: !5082)
!5082 = !{!256, !4988}
!5083 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5084, file: !4923, line: 1129)
!5084 = !DISubprogram(name: "lgamma", scope: !4920, file: !4920, line: 233, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5085 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5086, file: !4923, line: 1130)
!5086 = !DISubprogram(name: "lgammaf", scope: !4920, file: !4920, line: 233, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5087 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5088, file: !4923, line: 1131)
!5088 = !DISubprogram(name: "lgammal", scope: !4920, file: !4920, line: 233, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5089 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5090, file: !4923, line: 1134)
!5090 = !DISubprogram(name: "llrint", scope: !4920, file: !4920, line: 319, type: !5091, flags: DIFlagPrototyped, spFlags: 0)
!5091 = !DISubroutineType(types: !5092)
!5092 = !{!4839, !4871}
!5093 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5094, file: !4923, line: 1135)
!5094 = !DISubprogram(name: "llrintf", scope: !4920, file: !4920, line: 319, type: !4842, flags: DIFlagPrototyped, spFlags: 0)
!5095 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5096, file: !4923, line: 1136)
!5096 = !DISubprogram(name: "llrintl", scope: !4920, file: !4920, line: 319, type: !5097, flags: DIFlagPrototyped, spFlags: 0)
!5097 = !DISubroutineType(types: !5098)
!5098 = !{!4839, !4988}
!5099 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5100, file: !4923, line: 1138)
!5100 = !DISubprogram(name: "llround", scope: !4920, file: !4920, line: 325, type: !5091, flags: DIFlagPrototyped, spFlags: 0)
!5101 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5102, file: !4923, line: 1139)
!5102 = !DISubprogram(name: "llroundf", scope: !4920, file: !4920, line: 325, type: !4842, flags: DIFlagPrototyped, spFlags: 0)
!5103 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5104, file: !4923, line: 1140)
!5104 = !DISubprogram(name: "llroundl", scope: !4920, file: !4920, line: 325, type: !5097, flags: DIFlagPrototyped, spFlags: 0)
!5105 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5106, file: !4923, line: 1143)
!5106 = !DISubprogram(name: "log1p", scope: !4920, file: !4920, line: 122, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5107 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5108, file: !4923, line: 1144)
!5108 = !DISubprogram(name: "log1pf", scope: !4920, file: !4920, line: 122, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5109 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5110, file: !4923, line: 1145)
!5110 = !DISubprogram(name: "log1pl", scope: !4920, file: !4920, line: 122, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5111 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5112, file: !4923, line: 1147)
!5112 = !DISubprogram(name: "log2", scope: !4920, file: !4920, line: 133, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5113 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5114, file: !4923, line: 1148)
!5114 = !DISubprogram(name: "log2f", scope: !4920, file: !4920, line: 133, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5115 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5116, file: !4923, line: 1149)
!5116 = !DISubprogram(name: "log2l", scope: !4920, file: !4920, line: 133, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5117 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5118, file: !4923, line: 1151)
!5118 = !DISubprogram(name: "logb", scope: !4920, file: !4920, line: 125, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5119 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5120, file: !4923, line: 1152)
!5120 = !DISubprogram(name: "logbf", scope: !4920, file: !4920, line: 125, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5121 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5122, file: !4923, line: 1153)
!5122 = !DISubprogram(name: "logbl", scope: !4920, file: !4920, line: 125, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5123 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5124, file: !4923, line: 1155)
!5124 = !DISubprogram(name: "lrint", scope: !4920, file: !4920, line: 317, type: !5125, flags: DIFlagPrototyped, spFlags: 0)
!5125 = !DISubroutineType(types: !5126)
!5126 = !{!575, !4871}
!5127 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5128, file: !4923, line: 1156)
!5128 = !DISubprogram(name: "lrintf", scope: !4920, file: !4920, line: 317, type: !4856, flags: DIFlagPrototyped, spFlags: 0)
!5129 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5130, file: !4923, line: 1157)
!5130 = !DISubprogram(name: "lrintl", scope: !4920, file: !4920, line: 317, type: !5131, flags: DIFlagPrototyped, spFlags: 0)
!5131 = !DISubroutineType(types: !5132)
!5132 = !{!575, !4988}
!5133 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5134, file: !4923, line: 1159)
!5134 = !DISubprogram(name: "lround", scope: !4920, file: !4920, line: 323, type: !5125, flags: DIFlagPrototyped, spFlags: 0)
!5135 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5136, file: !4923, line: 1160)
!5136 = !DISubprogram(name: "lroundf", scope: !4920, file: !4920, line: 323, type: !4856, flags: DIFlagPrototyped, spFlags: 0)
!5137 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5138, file: !4923, line: 1161)
!5138 = !DISubprogram(name: "lroundl", scope: !4920, file: !4920, line: 323, type: !5131, flags: DIFlagPrototyped, spFlags: 0)
!5139 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5140, file: !4923, line: 1163)
!5140 = !DISubprogram(name: "nan", scope: !4920, file: !4920, line: 203, type: !4869, flags: DIFlagPrototyped, spFlags: 0)
!5141 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5142, file: !4923, line: 1164)
!5142 = !DISubprogram(name: "nanf", scope: !4920, file: !4920, line: 203, type: !4874, flags: DIFlagPrototyped, spFlags: 0)
!5143 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5144, file: !4923, line: 1165)
!5144 = !DISubprogram(name: "nanl", scope: !4920, file: !4920, line: 203, type: !5145, flags: DIFlagPrototyped, spFlags: 0)
!5145 = !DISubroutineType(types: !5146)
!5146 = !{!4988, !1452}
!5147 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5148, file: !4923, line: 1167)
!5148 = !DISubprogram(name: "nearbyint", scope: !4920, file: !4920, line: 297, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5149 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5150, file: !4923, line: 1168)
!5150 = !DISubprogram(name: "nearbyintf", scope: !4920, file: !4920, line: 297, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5151 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5152, file: !4923, line: 1169)
!5152 = !DISubprogram(name: "nearbyintl", scope: !4920, file: !4920, line: 297, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5153 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5154, file: !4923, line: 1171)
!5154 = !DISubprogram(name: "nextafter", scope: !4920, file: !4920, line: 262, type: !4930, flags: DIFlagPrototyped, spFlags: 0)
!5155 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5156, file: !4923, line: 1172)
!5156 = !DISubprogram(name: "nextafterf", scope: !4920, file: !4920, line: 262, type: !4748, flags: DIFlagPrototyped, spFlags: 0)
!5157 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5158, file: !4923, line: 1173)
!5158 = !DISubprogram(name: "nextafterl", scope: !4920, file: !4920, line: 262, type: !5013, flags: DIFlagPrototyped, spFlags: 0)
!5159 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5160, file: !4923, line: 1175)
!5160 = !DISubprogram(name: "nexttoward", scope: !4920, file: !4920, line: 264, type: !5161, flags: DIFlagPrototyped, spFlags: 0)
!5161 = !DISubroutineType(types: !5162)
!5162 = !{!4871, !4871, !4988}
!5163 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5164, file: !4923, line: 1176)
!5164 = !DISubprogram(name: "nexttowardf", scope: !4920, file: !4920, line: 264, type: !5165, flags: DIFlagPrototyped, spFlags: 0)
!5165 = !DISubroutineType(types: !5166)
!5166 = !{!4737, !4737, !4988}
!5167 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5168, file: !4923, line: 1177)
!5168 = !DISubprogram(name: "nexttowardl", scope: !4920, file: !4920, line: 264, type: !5013, flags: DIFlagPrototyped, spFlags: 0)
!5169 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5170, file: !4923, line: 1179)
!5170 = !DISubprogram(name: "remainder", scope: !4920, file: !4920, line: 275, type: !4930, flags: DIFlagPrototyped, spFlags: 0)
!5171 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5172, file: !4923, line: 1180)
!5172 = !DISubprogram(name: "remainderf", scope: !4920, file: !4920, line: 275, type: !4748, flags: DIFlagPrototyped, spFlags: 0)
!5173 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5174, file: !4923, line: 1181)
!5174 = !DISubprogram(name: "remainderl", scope: !4920, file: !4920, line: 275, type: !5013, flags: DIFlagPrototyped, spFlags: 0)
!5175 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5176, file: !4923, line: 1183)
!5176 = !DISubprogram(name: "remquo", scope: !4920, file: !4920, line: 310, type: !5177, flags: DIFlagPrototyped, spFlags: 0)
!5177 = !DISubroutineType(types: !5178)
!5178 = !{!4871, !4871, !4871, !4796}
!5179 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5180, file: !4923, line: 1184)
!5180 = !DISubprogram(name: "remquof", scope: !4920, file: !4920, line: 310, type: !4886, flags: DIFlagPrototyped, spFlags: 0)
!5181 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5182, file: !4923, line: 1185)
!5182 = !DISubprogram(name: "remquol", scope: !4920, file: !4920, line: 310, type: !5183, flags: DIFlagPrototyped, spFlags: 0)
!5183 = !DISubroutineType(types: !5184)
!5184 = !{!4988, !4988, !4988, !4796}
!5185 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5186, file: !4923, line: 1187)
!5186 = !DISubprogram(name: "rint", scope: !4920, file: !4920, line: 259, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5187 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5188, file: !4923, line: 1188)
!5188 = !DISubprogram(name: "rintf", scope: !4920, file: !4920, line: 259, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5189 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5190, file: !4923, line: 1189)
!5190 = !DISubprogram(name: "rintl", scope: !4920, file: !4920, line: 259, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5191 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5192, file: !4923, line: 1191)
!5192 = !DISubprogram(name: "round", scope: !4920, file: !4920, line: 301, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5193 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5194, file: !4923, line: 1192)
!5194 = !DISubprogram(name: "roundf", scope: !4920, file: !4920, line: 301, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5195 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5196, file: !4923, line: 1193)
!5196 = !DISubprogram(name: "roundl", scope: !4920, file: !4920, line: 301, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5197 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5198, file: !4923, line: 1195)
!5198 = !DISubprogram(name: "scalbln", scope: !4920, file: !4920, line: 293, type: !5199, flags: DIFlagPrototyped, spFlags: 0)
!5199 = !DISubroutineType(types: !5200)
!5200 = !{!4871, !4871, !575}
!5201 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5202, file: !4923, line: 1196)
!5202 = !DISubprogram(name: "scalblnf", scope: !4920, file: !4920, line: 293, type: !4894, flags: DIFlagPrototyped, spFlags: 0)
!5203 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5204, file: !4923, line: 1197)
!5204 = !DISubprogram(name: "scalblnl", scope: !4920, file: !4920, line: 293, type: !5205, flags: DIFlagPrototyped, spFlags: 0)
!5205 = !DISubroutineType(types: !5206)
!5206 = !{!4988, !4988, !575}
!5207 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5208, file: !4923, line: 1199)
!5208 = !DISubprogram(name: "scalbn", scope: !4920, file: !4920, line: 279, type: !4952, flags: DIFlagPrototyped, spFlags: 0)
!5209 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5210, file: !4923, line: 1200)
!5210 = !DISubprogram(name: "scalbnf", scope: !4920, file: !4920, line: 279, type: !4831, flags: DIFlagPrototyped, spFlags: 0)
!5211 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5212, file: !4923, line: 1201)
!5212 = !DISubprogram(name: "scalbnl", scope: !4920, file: !4920, line: 279, type: !5213, flags: DIFlagPrototyped, spFlags: 0)
!5213 = !DISubroutineType(types: !5214)
!5214 = !{!4988, !4988, !256}
!5215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5216, file: !4923, line: 1203)
!5216 = !DISubprogram(name: "tgamma", scope: !4920, file: !4920, line: 238, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5217 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5218, file: !4923, line: 1204)
!5218 = !DISubprogram(name: "tgammaf", scope: !4920, file: !4920, line: 238, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5219 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5220, file: !4923, line: 1205)
!5220 = !DISubprogram(name: "tgammal", scope: !4920, file: !4920, line: 238, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5221 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5222, file: !4923, line: 1207)
!5222 = !DISubprogram(name: "trunc", scope: !4920, file: !4920, line: 305, type: !4921, flags: DIFlagPrototyped, spFlags: 0)
!5223 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5224, file: !4923, line: 1208)
!5224 = !DISubprogram(name: "truncf", scope: !4920, file: !4920, line: 305, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!5225 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5226, file: !4923, line: 1209)
!5226 = !DISubprogram(name: "truncl", scope: !4920, file: !4920, line: 305, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5227 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !5228, entity: !5229, file: !5230, line: 58)
!5228 = !DINamespace(name: "__gnu_debug", scope: null)
!5229 = !DINamespace(name: "__debug", scope: !2)
!5230 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/debug/debug.h", directory: "")
!5231 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5232, file: !5234, line: 127)
!5232 = !DIDerivedType(tag: DW_TAG_typedef, name: "div_t", file: !4916, line: 63, baseType: !5233)
!5233 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !4916, line: 59, size: 64, flags: DIFlagFwdDecl, identifier: "_ZTS5div_t")
!5234 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/cstdlib", directory: "")
!5235 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5236, file: !5234, line: 128)
!5236 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldiv_t", file: !4916, line: 71, baseType: !5237)
!5237 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !4916, line: 67, size: 128, flags: DIFlagTypePassByValue, elements: !5238, identifier: "_ZTS6ldiv_t")
!5238 = !{!5239, !5240}
!5239 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !5237, file: !4916, line: 69, baseType: !575, size: 64)
!5240 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !5237, file: !4916, line: 70, baseType: !575, size: 64, offset: 64)
!5241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5242, file: !5234, line: 130)
!5242 = !DISubprogram(name: "abort", scope: !4916, file: !4916, line: 598, type: !5243, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!5243 = !DISubroutineType(types: !5244)
!5244 = !{null}
!5245 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5246, file: !5234, line: 132)
!5246 = !DISubprogram(name: "aligned_alloc", scope: !4916, file: !4916, line: 592, type: !5247, flags: DIFlagPrototyped, spFlags: 0)
!5247 = !DISubroutineType(types: !5248)
!5248 = !{!943, !1288, !1288}
!5249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5250, file: !5234, line: 134)
!5250 = !DISubprogram(name: "atexit", scope: !4916, file: !4916, line: 602, type: !5251, flags: DIFlagPrototyped, spFlags: 0)
!5251 = !DISubroutineType(types: !5252)
!5252 = !{!256, !5253}
!5253 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5243, size: 64)
!5254 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5255, file: !5234, line: 137)
!5255 = !DISubprogram(name: "at_quick_exit", scope: !4916, file: !4916, line: 607, type: !5251, flags: DIFlagPrototyped, spFlags: 0)
!5256 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5257, file: !5234, line: 140)
!5257 = !DISubprogram(name: "atof", scope: !4916, file: !4916, line: 102, type: !4869, flags: DIFlagPrototyped, spFlags: 0)
!5258 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5259, file: !5234, line: 141)
!5259 = !DISubprogram(name: "atoi", scope: !4916, file: !4916, line: 105, type: !5260, flags: DIFlagPrototyped, spFlags: 0)
!5260 = !DISubroutineType(types: !5261)
!5261 = !{!256, !1452}
!5262 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5263, file: !5234, line: 142)
!5263 = !DISubprogram(name: "atol", scope: !4916, file: !4916, line: 108, type: !5264, flags: DIFlagPrototyped, spFlags: 0)
!5264 = !DISubroutineType(types: !5265)
!5265 = !{!575, !1452}
!5266 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5267, file: !5234, line: 143)
!5267 = !DISubprogram(name: "bsearch", scope: !4916, file: !4916, line: 828, type: !5268, flags: DIFlagPrototyped, spFlags: 0)
!5268 = !DISubroutineType(types: !5269)
!5269 = !{!943, !3055, !3055, !1288, !1288, !5270}
!5270 = !DIDerivedType(tag: DW_TAG_typedef, name: "__compar_fn_t", file: !4916, line: 816, baseType: !5271)
!5271 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5272, size: 64)
!5272 = !DISubroutineType(types: !5273)
!5273 = !{!256, !3055, !3055}
!5274 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5275, file: !5234, line: 144)
!5275 = !DISubprogram(name: "calloc", scope: !4916, file: !4916, line: 543, type: !5247, flags: DIFlagPrototyped, spFlags: 0)
!5276 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5277, file: !5234, line: 145)
!5277 = !DISubprogram(name: "div", scope: !4916, file: !4916, line: 860, type: !5278, flags: DIFlagPrototyped, spFlags: 0)
!5278 = !DISubroutineType(types: !5279)
!5279 = !{!5232, !256, !256}
!5280 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5281, file: !5234, line: 146)
!5281 = !DISubprogram(name: "exit", scope: !4916, file: !4916, line: 624, type: !5282, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!5282 = !DISubroutineType(types: !5283)
!5283 = !{null, !256}
!5284 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5285, file: !5234, line: 147)
!5285 = !DISubprogram(name: "free", scope: !4916, file: !4916, line: 555, type: !5286, flags: DIFlagPrototyped, spFlags: 0)
!5286 = !DISubroutineType(types: !5287)
!5287 = !{null, !943}
!5288 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5289, file: !5234, line: 148)
!5289 = !DISubprogram(name: "getenv", scope: !4916, file: !4916, line: 641, type: !5290, flags: DIFlagPrototyped, spFlags: 0)
!5290 = !DISubroutineType(types: !5291)
!5291 = !{!5292, !1452}
!5292 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !571, size: 64)
!5293 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5294, file: !5234, line: 149)
!5294 = !DISubprogram(name: "labs", scope: !4916, file: !4916, line: 849, type: !4827, flags: DIFlagPrototyped, spFlags: 0)
!5295 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5296, file: !5234, line: 150)
!5296 = !DISubprogram(name: "ldiv", scope: !4916, file: !4916, line: 862, type: !5297, flags: DIFlagPrototyped, spFlags: 0)
!5297 = !DISubroutineType(types: !5298)
!5298 = !{!5236, !575, !575}
!5299 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5300, file: !5234, line: 151)
!5300 = !DISubprogram(name: "malloc", scope: !4916, file: !4916, line: 540, type: !5301, flags: DIFlagPrototyped, spFlags: 0)
!5301 = !DISubroutineType(types: !5302)
!5302 = !{!943, !1288}
!5303 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5304, file: !5234, line: 153)
!5304 = !DISubprogram(name: "mblen", scope: !4916, file: !4916, line: 930, type: !5305, flags: DIFlagPrototyped, spFlags: 0)
!5305 = !DISubroutineType(types: !5306)
!5306 = !{!256, !1452, !1288}
!5307 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5308, file: !5234, line: 154)
!5308 = !DISubprogram(name: "mbstowcs", scope: !4916, file: !4916, line: 941, type: !5309, flags: DIFlagPrototyped, spFlags: 0)
!5309 = !DISubroutineType(types: !5310)
!5310 = !{!1288, !5311, !5314, !1288}
!5311 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5312)
!5312 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5313, size: 64)
!5313 = !DIBasicType(name: "wchar_t", size: 32, encoding: DW_ATE_signed)
!5314 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1452)
!5315 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5316, file: !5234, line: 155)
!5316 = !DISubprogram(name: "mbtowc", scope: !4916, file: !4916, line: 933, type: !5317, flags: DIFlagPrototyped, spFlags: 0)
!5317 = !DISubroutineType(types: !5318)
!5318 = !{!256, !5311, !5314, !1288}
!5319 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5320, file: !5234, line: 157)
!5320 = !DISubprogram(name: "qsort", scope: !4916, file: !4916, line: 838, type: !5321, flags: DIFlagPrototyped, spFlags: 0)
!5321 = !DISubroutineType(types: !5322)
!5322 = !{null, !943, !1288, !1288, !5270}
!5323 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5324, file: !5234, line: 160)
!5324 = !DISubprogram(name: "quick_exit", scope: !4916, file: !4916, line: 630, type: !5282, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!5325 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5326, file: !5234, line: 163)
!5326 = !DISubprogram(name: "rand", scope: !4916, file: !4916, line: 454, type: !5327, flags: DIFlagPrototyped, spFlags: 0)
!5327 = !DISubroutineType(types: !5328)
!5328 = !{!256}
!5329 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5330, file: !5234, line: 164)
!5330 = !DISubprogram(name: "realloc", scope: !4916, file: !4916, line: 551, type: !5331, flags: DIFlagPrototyped, spFlags: 0)
!5331 = !DISubroutineType(types: !5332)
!5332 = !{!943, !943, !1288}
!5333 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5334, file: !5234, line: 165)
!5334 = !DISubprogram(name: "srand", scope: !4916, file: !4916, line: 456, type: !5335, flags: DIFlagPrototyped, spFlags: 0)
!5335 = !DISubroutineType(types: !5336)
!5336 = !{null, !68}
!5337 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5338, file: !5234, line: 166)
!5338 = !DISubprogram(name: "strtod", scope: !4916, file: !4916, line: 118, type: !5339, flags: DIFlagPrototyped, spFlags: 0)
!5339 = !DISubroutineType(types: !5340)
!5340 = !{!4871, !5314, !5341}
!5341 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5342)
!5342 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5292, size: 64)
!5343 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5344, file: !5234, line: 167)
!5344 = !DISubprogram(name: "strtol", scope: !4916, file: !4916, line: 177, type: !5345, flags: DIFlagPrototyped, spFlags: 0)
!5345 = !DISubroutineType(types: !5346)
!5346 = !{!575, !5314, !5341, !256}
!5347 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5348, file: !5234, line: 168)
!5348 = !DISubprogram(name: "strtoul", scope: !4916, file: !4916, line: 181, type: !5349, flags: DIFlagPrototyped, spFlags: 0)
!5349 = !DISubroutineType(types: !5350)
!5350 = !{!1290, !5314, !5341, !256}
!5351 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5352, file: !5234, line: 169)
!5352 = !DISubprogram(name: "system", scope: !4916, file: !4916, line: 791, type: !5260, flags: DIFlagPrototyped, spFlags: 0)
!5353 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5354, file: !5234, line: 171)
!5354 = !DISubprogram(name: "wcstombs", scope: !4916, file: !4916, line: 945, type: !5355, flags: DIFlagPrototyped, spFlags: 0)
!5355 = !DISubroutineType(types: !5356)
!5356 = !{!1288, !5357, !5358, !1288}
!5357 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5292)
!5358 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5359)
!5359 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5360, size: 64)
!5360 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5313)
!5361 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5362, file: !5234, line: 172)
!5362 = !DISubprogram(name: "wctomb", scope: !4916, file: !4916, line: 937, type: !5363, flags: DIFlagPrototyped, spFlags: 0)
!5363 = !DISubroutineType(types: !5364)
!5364 = !{!256, !5292, !5313}
!5365 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5366, file: !5234, line: 200)
!5366 = !DIDerivedType(tag: DW_TAG_typedef, name: "lldiv_t", file: !4916, line: 81, baseType: !5367)
!5367 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !4916, line: 77, size: 128, flags: DIFlagTypePassByValue, elements: !5368, identifier: "_ZTS7lldiv_t")
!5368 = !{!5369, !5370}
!5369 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !5367, file: !4916, line: 79, baseType: !4839, size: 64)
!5370 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !5367, file: !4916, line: 80, baseType: !4839, size: 64, offset: 64)
!5371 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5372, file: !5234, line: 206)
!5372 = !DISubprogram(name: "_Exit", scope: !4916, file: !4916, line: 636, type: !5282, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!5373 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5374, file: !5234, line: 210)
!5374 = !DISubprogram(name: "llabs", scope: !4916, file: !4916, line: 852, type: !4837, flags: DIFlagPrototyped, spFlags: 0)
!5375 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5376, file: !5234, line: 216)
!5376 = !DISubprogram(name: "lldiv", scope: !4916, file: !4916, line: 866, type: !5377, flags: DIFlagPrototyped, spFlags: 0)
!5377 = !DISubroutineType(types: !5378)
!5378 = !{!5366, !4839, !4839}
!5379 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5380, file: !5234, line: 227)
!5380 = !DISubprogram(name: "atoll", scope: !4916, file: !4916, line: 113, type: !5381, flags: DIFlagPrototyped, spFlags: 0)
!5381 = !DISubroutineType(types: !5382)
!5382 = !{!4839, !1452}
!5383 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5384, file: !5234, line: 228)
!5384 = !DISubprogram(name: "strtoll", scope: !4916, file: !4916, line: 201, type: !5385, flags: DIFlagPrototyped, spFlags: 0)
!5385 = !DISubroutineType(types: !5386)
!5386 = !{!4839, !5314, !5341, !256}
!5387 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5388, file: !5234, line: 229)
!5388 = !DISubprogram(name: "strtoull", scope: !4916, file: !4916, line: 206, type: !5389, flags: DIFlagPrototyped, spFlags: 0)
!5389 = !DISubroutineType(types: !5390)
!5390 = !{!16, !5314, !5341, !256}
!5391 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5392, file: !5234, line: 231)
!5392 = !DISubprogram(name: "strtof", scope: !4916, file: !4916, line: 124, type: !5393, flags: DIFlagPrototyped, spFlags: 0)
!5393 = !DISubroutineType(types: !5394)
!5394 = !{!4737, !5314, !5341}
!5395 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5396, file: !5234, line: 232)
!5396 = !DISubprogram(name: "strtold", scope: !4916, file: !4916, line: 127, type: !5397, flags: DIFlagPrototyped, spFlags: 0)
!5397 = !DISubroutineType(types: !5398)
!5398 = !{!4988, !5314, !5341}
!5399 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5366, file: !5234, line: 240)
!5400 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5372, file: !5234, line: 242)
!5401 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5374, file: !5234, line: 244)
!5402 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5403, file: !5234, line: 245)
!5403 = !DISubprogram(name: "div", linkageName: "_ZN9__gnu_cxx3divExx", scope: !67, file: !5234, line: 213, type: !5377, flags: DIFlagPrototyped, spFlags: 0)
!5404 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5376, file: !5234, line: 246)
!5405 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5380, file: !5234, line: 248)
!5406 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5392, file: !5234, line: 249)
!5407 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5384, file: !5234, line: 250)
!5408 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5388, file: !5234, line: 251)
!5409 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5396, file: !5234, line: 252)
!5410 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5242, file: !5411, line: 38)
!5411 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/stdlib.h", directory: "")
!5412 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5250, file: !5411, line: 39)
!5413 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5281, file: !5411, line: 40)
!5414 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5255, file: !5411, line: 43)
!5415 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5324, file: !5411, line: 46)
!5416 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5232, file: !5411, line: 51)
!5417 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5236, file: !5411, line: 52)
!5418 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5419, file: !5411, line: 54)
!5419 = !DISubprogram(name: "abs", linkageName: "_ZSt3abse", scope: !2, file: !4917, line: 79, type: !4986, flags: DIFlagPrototyped, spFlags: 0)
!5420 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5257, file: !5411, line: 55)
!5421 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5259, file: !5411, line: 56)
!5422 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5263, file: !5411, line: 57)
!5423 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5267, file: !5411, line: 58)
!5424 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5275, file: !5411, line: 59)
!5425 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5403, file: !5411, line: 60)
!5426 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5285, file: !5411, line: 61)
!5427 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5289, file: !5411, line: 62)
!5428 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5294, file: !5411, line: 63)
!5429 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5296, file: !5411, line: 64)
!5430 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5300, file: !5411, line: 65)
!5431 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5304, file: !5411, line: 67)
!5432 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5308, file: !5411, line: 68)
!5433 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5316, file: !5411, line: 69)
!5434 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5320, file: !5411, line: 71)
!5435 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5326, file: !5411, line: 72)
!5436 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5330, file: !5411, line: 73)
!5437 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5334, file: !5411, line: 74)
!5438 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5338, file: !5411, line: 75)
!5439 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5344, file: !5411, line: 76)
!5440 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5348, file: !5411, line: 77)
!5441 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5352, file: !5411, line: 78)
!5442 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5354, file: !5411, line: 80)
!5443 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !5362, file: !5411, line: 81)
!5444 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5445, file: !5447, line: 443)
!5445 = !DISubprogram(name: "acosf", linkageName: "_ZL5acosff", scope: !5446, file: !5446, line: 59, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5446 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/__clang_cuda_math.h", directory: "")
!5447 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/__clang_cuda_cmath.h", directory: "")
!5448 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5449, file: !5447, line: 444)
!5449 = !DISubprogram(name: "acoshf", linkageName: "_ZL6acoshff", scope: !5446, file: !5446, line: 61, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5450 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5451, file: !5447, line: 445)
!5451 = !DISubprogram(name: "asinf", linkageName: "_ZL5asinff", scope: !5446, file: !5446, line: 63, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5452 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5453, file: !5447, line: 446)
!5453 = !DISubprogram(name: "asinhf", linkageName: "_ZL6asinhff", scope: !5446, file: !5446, line: 65, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5454 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5455, file: !5447, line: 447)
!5455 = !DISubprogram(name: "atan2f", linkageName: "_ZL6atan2fff", scope: !5446, file: !5446, line: 68, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5456 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5457, file: !5447, line: 448)
!5457 = !DISubprogram(name: "atanf", linkageName: "_ZL5atanff", scope: !5446, file: !5446, line: 69, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5458 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5459, file: !5447, line: 449)
!5459 = !DISubprogram(name: "atanhf", linkageName: "_ZL6atanhff", scope: !5446, file: !5446, line: 71, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5460 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5461, file: !5447, line: 450)
!5461 = !DISubprogram(name: "cbrtf", linkageName: "_ZL5cbrtff", scope: !5446, file: !5446, line: 73, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5462 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5463, file: !5447, line: 451)
!5463 = !DISubprogram(name: "ceilf", linkageName: "_ZL5ceilff", scope: !5446, file: !5446, line: 75, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5464 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5465, file: !5447, line: 452)
!5465 = !DISubprogram(name: "copysignf", linkageName: "_ZL9copysignfff", scope: !5446, file: !5446, line: 79, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5466 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5467, file: !5447, line: 453)
!5467 = !DISubprogram(name: "cosf", linkageName: "_ZL4cosff", scope: !5446, file: !5446, line: 83, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5468 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5469, file: !5447, line: 454)
!5469 = !DISubprogram(name: "coshf", linkageName: "_ZL5coshff", scope: !5446, file: !5446, line: 87, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5470 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5471, file: !5447, line: 455)
!5471 = !DISubprogram(name: "erfcf", linkageName: "_ZL5erfcff", scope: !5446, file: !5446, line: 96, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5472 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5473, file: !5447, line: 456)
!5473 = !DISubprogram(name: "erff", linkageName: "_ZL4erfff", scope: !5446, file: !5446, line: 101, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5474 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5475, file: !5447, line: 457)
!5475 = !DISubprogram(name: "exp2f", linkageName: "_ZL5exp2ff", scope: !5446, file: !5446, line: 108, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5476 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5477, file: !5447, line: 458)
!5477 = !DISubprogram(name: "expf", linkageName: "_ZL4expff", scope: !5446, file: !5446, line: 109, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5478 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5479, file: !5447, line: 459)
!5479 = !DISubprogram(name: "expm1f", linkageName: "_ZL6expm1ff", scope: !5446, file: !5446, line: 111, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5480 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5481, file: !5447, line: 460)
!5481 = !DISubprogram(name: "fabsf", linkageName: "_ZL5fabsff", scope: !5446, file: !5446, line: 112, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5482 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5483, file: !5447, line: 461)
!5483 = !DISubprogram(name: "fdimf", linkageName: "_ZL5fdimfff", scope: !5446, file: !5446, line: 114, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5484 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5485, file: !5447, line: 462)
!5485 = !DISubprogram(name: "floorf", linkageName: "_ZL6floorff", scope: !5446, file: !5446, line: 124, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5486 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5487, file: !5447, line: 463)
!5487 = !DISubprogram(name: "fmaf", linkageName: "_ZL4fmaffff", scope: !5446, file: !5446, line: 128, type: !4780, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5488 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5489, file: !5447, line: 464)
!5489 = !DISubprogram(name: "fmaxf", linkageName: "_ZL5fmaxfff", scope: !5446, file: !5446, line: 132, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5490 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5491, file: !5447, line: 465)
!5491 = !DISubprogram(name: "fminf", linkageName: "_ZL5fminfff", scope: !5446, file: !5446, line: 134, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5492 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5493, file: !5447, line: 466)
!5493 = !DISubprogram(name: "fmodf", linkageName: "_ZL5fmodfff", scope: !5446, file: !5446, line: 136, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5494 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5495, file: !5447, line: 467)
!5495 = !DISubprogram(name: "frexpf", linkageName: "_ZL6frexpffPi", scope: !5446, file: !5446, line: 138, type: !4794, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5496 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5497, file: !5447, line: 468)
!5497 = !DISubprogram(name: "hypotf", linkageName: "_ZL6hypotfff", scope: !5446, file: !5446, line: 140, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5498 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5499, file: !5447, line: 469)
!5499 = !DISubprogram(name: "ilogbf", linkageName: "_ZL6ilogbff", scope: !5446, file: !5446, line: 142, type: !4790, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5500 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5501, file: !5447, line: 470)
!5501 = !DISubprogram(name: "ldexpf", linkageName: "_ZL6ldexpffi", scope: !5446, file: !5446, line: 155, type: !4831, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5502 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5503, file: !5447, line: 471)
!5503 = !DISubprogram(name: "lgammaf", linkageName: "_ZL7lgammaff", scope: !5446, file: !5446, line: 157, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5504 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5505, file: !5447, line: 472)
!5505 = !DISubprogram(name: "llrintf", linkageName: "_ZL7llrintff", scope: !5446, file: !5446, line: 166, type: !4842, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5506 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5507, file: !5447, line: 473)
!5507 = !DISubprogram(name: "llroundf", linkageName: "_ZL8llroundff", scope: !5446, file: !5446, line: 168, type: !4842, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5508 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5509, file: !5447, line: 474)
!5509 = !DISubprogram(name: "log10f", linkageName: "_ZL6log10ff", scope: !5446, file: !5446, line: 173, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5510 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5511, file: !5447, line: 475)
!5511 = !DISubprogram(name: "log1pf", linkageName: "_ZL6log1pff", scope: !5446, file: !5446, line: 175, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5512 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5513, file: !5447, line: 476)
!5513 = !DISubprogram(name: "log2f", linkageName: "_ZL5log2ff", scope: !5446, file: !5446, line: 177, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5514 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5515, file: !5447, line: 477)
!5515 = !DISubprogram(name: "logbf", linkageName: "_ZL5logbff", scope: !5446, file: !5446, line: 181, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5516 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5517, file: !5447, line: 478)
!5517 = !DISubprogram(name: "logf", linkageName: "_ZL4logff", scope: !5446, file: !5446, line: 182, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5518 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5519, file: !5447, line: 479)
!5519 = !DISubprogram(name: "lrintf", linkageName: "_ZL6lrintff", scope: !5446, file: !5446, line: 187, type: !4856, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5520 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5521, file: !5447, line: 480)
!5521 = !DISubprogram(name: "lroundf", linkageName: "_ZL7lroundff", scope: !5446, file: !5446, line: 189, type: !4856, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5522 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5523, file: !5447, line: 481)
!5523 = !DISubprogram(name: "modff", linkageName: "_ZL5modfffPf", scope: !5446, file: !5446, line: 199, type: !4864, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5524 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5525, file: !5447, line: 482)
!5525 = !DISubprogram(name: "nearbyintf", linkageName: "_ZL10nearbyintff", scope: !5446, file: !5446, line: 201, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5526 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5527, file: !5447, line: 483)
!5527 = !DISubprogram(name: "nextafterf", linkageName: "_ZL10nextafterfff", scope: !5446, file: !5446, line: 205, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5528 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5529, file: !5447, line: 484)
!5529 = !DISubprogram(name: "powf", linkageName: "_ZL4powfff", scope: !5446, file: !5446, line: 231, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5530 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5531, file: !5447, line: 485)
!5531 = !DISubprogram(name: "remainderf", linkageName: "_ZL10remainderfff", scope: !5446, file: !5446, line: 239, type: !4748, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5532 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5533, file: !5447, line: 486)
!5533 = !DISubprogram(name: "remquof", linkageName: "_ZL7remquofffPi", scope: !5446, file: !5446, line: 245, type: !4886, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5534 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5535, file: !5447, line: 487)
!5535 = !DISubprogram(name: "rintf", linkageName: "_ZL5rintff", scope: !5446, file: !5446, line: 256, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5536 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5537, file: !5447, line: 488)
!5537 = !DISubprogram(name: "roundf", linkageName: "_ZL6roundff", scope: !5446, file: !5446, line: 170, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5538 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5539, file: !5447, line: 489)
!5539 = !DISubprogram(name: "scalblnf", linkageName: "_ZL8scalblnffl", scope: !5446, file: !5446, line: 286, type: !4894, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5540 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5541, file: !5447, line: 490)
!5541 = !DISubprogram(name: "scalbnf", linkageName: "_ZL7scalbnffi", scope: !5446, file: !5446, line: 278, type: !4831, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5542 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5543, file: !5447, line: 491)
!5543 = !DISubprogram(name: "sinf", linkageName: "_ZL4sinff", scope: !5446, file: !5446, line: 306, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5544 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5545, file: !5447, line: 492)
!5545 = !DISubprogram(name: "sinhf", linkageName: "_ZL5sinhff", scope: !5446, file: !5446, line: 310, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5546 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5547, file: !5447, line: 493)
!5547 = !DISubprogram(name: "sqrtf", linkageName: "_ZL5sqrtff", scope: !5446, file: !5446, line: 314, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5548 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5549, file: !5447, line: 494)
!5549 = !DISubprogram(name: "tanf", linkageName: "_ZL4tanff", scope: !5446, file: !5446, line: 316, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5550 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5551, file: !5447, line: 495)
!5551 = !DISubprogram(name: "tanhf", linkageName: "_ZL5tanhff", scope: !5446, file: !5446, line: 318, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5552 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5553, file: !5447, line: 496)
!5553 = !DISubprogram(name: "tgammaf", linkageName: "_ZL7tgammaff", scope: !5446, file: !5446, line: 320, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5554 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5555, file: !5447, line: 497)
!5555 = !DISubprogram(name: "truncf", linkageName: "_ZL6truncff", scope: !5446, file: !5446, line: 322, type: !4735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!5556 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !734, file: !11, line: 171)
!5557 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !10, file: !11, line: 172)
!5558 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !5559, file: !11, line: 202)
!5559 = !DISubprogram(name: "is_exactly", linkageName: "_ZN2nv6target6detail10is_exactlyENS1_11sm_selectorE", scope: !12, file: !11, line: 142, type: !5560, flags: DIFlagPrototyped, spFlags: 0)
!5560 = !DISubroutineType(types: !5561)
!5561 = !{!734, !10}
!5562 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !5563, file: !11, line: 203)
!5563 = !DISubprogram(name: "provides", linkageName: "_ZN2nv6target6detail8providesENS1_11sm_selectorE", scope: !12, file: !11, line: 147, type: !5560, flags: DIFlagPrototyped, spFlags: 0)
!5564 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5565, file: !5569, line: 98)
!5565 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !5566, line: 7, baseType: !5567)
!5566 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "")
!5567 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !5568, line: 49, size: 1728, flags: DIFlagFwdDecl, identifier: "_ZTS8_IO_FILE")
!5568 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h", directory: "")
!5569 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/cstdio", directory: "")
!5570 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5571, file: !5569, line: 99)
!5571 = !DIDerivedType(tag: DW_TAG_typedef, name: "fpos_t", file: !5572, line: 84, baseType: !5573)
!5572 = !DIFile(filename: "/usr/include/stdio.h", directory: "")
!5573 = !DIDerivedType(tag: DW_TAG_typedef, name: "__fpos_t", file: !5574, line: 14, baseType: !5575)
!5574 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h", directory: "")
!5575 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_G_fpos_t", file: !5574, line: 10, size: 128, flags: DIFlagFwdDecl, identifier: "_ZTS9_G_fpos_t")
!5576 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5577, file: !5569, line: 101)
!5577 = !DISubprogram(name: "clearerr", scope: !5572, file: !5572, line: 786, type: !5578, flags: DIFlagPrototyped, spFlags: 0)
!5578 = !DISubroutineType(types: !5579)
!5579 = !{null, !5580}
!5580 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5565, size: 64)
!5581 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5582, file: !5569, line: 102)
!5582 = !DISubprogram(name: "fclose", scope: !5572, file: !5572, line: 178, type: !5583, flags: DIFlagPrototyped, spFlags: 0)
!5583 = !DISubroutineType(types: !5584)
!5584 = !{!256, !5580}
!5585 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5586, file: !5569, line: 103)
!5586 = !DISubprogram(name: "feof", scope: !5572, file: !5572, line: 788, type: !5583, flags: DIFlagPrototyped, spFlags: 0)
!5587 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5588, file: !5569, line: 104)
!5588 = !DISubprogram(name: "ferror", scope: !5572, file: !5572, line: 790, type: !5583, flags: DIFlagPrototyped, spFlags: 0)
!5589 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5590, file: !5569, line: 105)
!5590 = !DISubprogram(name: "fflush", scope: !5572, file: !5572, line: 230, type: !5583, flags: DIFlagPrototyped, spFlags: 0)
!5591 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5592, file: !5569, line: 106)
!5592 = !DISubprogram(name: "fgetc", scope: !5572, file: !5572, line: 513, type: !5583, flags: DIFlagPrototyped, spFlags: 0)
!5593 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5594, file: !5569, line: 107)
!5594 = !DISubprogram(name: "fgetpos", scope: !5572, file: !5572, line: 760, type: !5595, flags: DIFlagPrototyped, spFlags: 0)
!5595 = !DISubroutineType(types: !5596)
!5596 = !{!256, !5597, !5598}
!5597 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5580)
!5598 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5599)
!5599 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5571, size: 64)
!5600 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5601, file: !5569, line: 108)
!5601 = !DISubprogram(name: "fgets", scope: !5572, file: !5572, line: 592, type: !5602, flags: DIFlagPrototyped, spFlags: 0)
!5602 = !DISubroutineType(types: !5603)
!5603 = !{!5292, !5357, !256, !5597}
!5604 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5605, file: !5569, line: 109)
!5605 = !DISubprogram(name: "fopen", scope: !5572, file: !5572, line: 258, type: !5606, flags: DIFlagPrototyped, spFlags: 0)
!5606 = !DISubroutineType(types: !5607)
!5607 = !{!5580, !5314, !5314}
!5608 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5609, file: !5569, line: 110)
!5609 = !DISubprogram(name: "fprintf", scope: !5572, file: !5572, line: 350, type: !5610, flags: DIFlagPrototyped, spFlags: 0)
!5610 = !DISubroutineType(types: !5611)
!5611 = !{!256, !5597, !5314, null}
!5612 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5613, file: !5569, line: 111)
!5613 = !DISubprogram(name: "fputc", scope: !5572, file: !5572, line: 549, type: !5614, flags: DIFlagPrototyped, spFlags: 0)
!5614 = !DISubroutineType(types: !5615)
!5615 = !{!256, !256, !5580}
!5616 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5617, file: !5569, line: 112)
!5617 = !DISubprogram(name: "fputs", scope: !5572, file: !5572, line: 655, type: !5618, flags: DIFlagPrototyped, spFlags: 0)
!5618 = !DISubroutineType(types: !5619)
!5619 = !{!256, !5314, !5597}
!5620 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5621, file: !5569, line: 113)
!5621 = !DISubprogram(name: "fread", scope: !5572, file: !5572, line: 675, type: !5622, flags: DIFlagPrototyped, spFlags: 0)
!5622 = !DISubroutineType(types: !5623)
!5623 = !{!1288, !5624, !1288, !1288, !5597}
!5624 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !943)
!5625 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5626, file: !5569, line: 114)
!5626 = !DISubprogram(name: "freopen", scope: !5572, file: !5572, line: 265, type: !5627, flags: DIFlagPrototyped, spFlags: 0)
!5627 = !DISubroutineType(types: !5628)
!5628 = !{!5580, !5314, !5314, !5597}
!5629 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5630, file: !5569, line: 115)
!5630 = !DISubprogram(name: "fscanf", linkageName: "__isoc99_fscanf", scope: !5572, file: !5572, line: 434, type: !5610, flags: DIFlagPrototyped, spFlags: 0)
!5631 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5632, file: !5569, line: 116)
!5632 = !DISubprogram(name: "fseek", scope: !5572, file: !5572, line: 713, type: !5633, flags: DIFlagPrototyped, spFlags: 0)
!5633 = !DISubroutineType(types: !5634)
!5634 = !{!256, !5580, !575, !256}
!5635 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5636, file: !5569, line: 117)
!5636 = !DISubprogram(name: "fsetpos", scope: !5572, file: !5572, line: 765, type: !5637, flags: DIFlagPrototyped, spFlags: 0)
!5637 = !DISubroutineType(types: !5638)
!5638 = !{!256, !5580, !5639}
!5639 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5640, size: 64)
!5640 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5571)
!5641 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5642, file: !5569, line: 118)
!5642 = !DISubprogram(name: "ftell", scope: !5572, file: !5572, line: 718, type: !5643, flags: DIFlagPrototyped, spFlags: 0)
!5643 = !DISubroutineType(types: !5644)
!5644 = !{!575, !5580}
!5645 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5646, file: !5569, line: 119)
!5646 = !DISubprogram(name: "fwrite", scope: !5572, file: !5572, line: 681, type: !5647, flags: DIFlagPrototyped, spFlags: 0)
!5647 = !DISubroutineType(types: !5648)
!5648 = !{!1288, !5649, !1288, !1288, !5597}
!5649 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !3055)
!5650 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5651, file: !5569, line: 120)
!5651 = !DISubprogram(name: "getc", scope: !5572, file: !5572, line: 514, type: !5583, flags: DIFlagPrototyped, spFlags: 0)
!5652 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5653, file: !5569, line: 121)
!5653 = !DISubprogram(name: "getchar", scope: !5572, file: !5572, line: 520, type: !5327, flags: DIFlagPrototyped, spFlags: 0)
!5654 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5655, file: !5569, line: 126)
!5655 = !DISubprogram(name: "perror", scope: !5572, file: !5572, line: 804, type: !5656, flags: DIFlagPrototyped, spFlags: 0)
!5656 = !DISubroutineType(types: !5657)
!5657 = !{null, !1452}
!5658 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5659, file: !5569, line: 127)
!5659 = !DISubprogram(name: "printf", scope: !5572, file: !5572, line: 356, type: !5660, flags: DIFlagPrototyped, spFlags: 0)
!5660 = !DISubroutineType(types: !5661)
!5661 = !{!256, !5314, null}
!5662 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5663, file: !5569, line: 128)
!5663 = !DISubprogram(name: "putc", scope: !5572, file: !5572, line: 550, type: !5614, flags: DIFlagPrototyped, spFlags: 0)
!5664 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5665, file: !5569, line: 129)
!5665 = !DISubprogram(name: "putchar", scope: !5572, file: !5572, line: 556, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!5666 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5667, file: !5569, line: 130)
!5667 = !DISubprogram(name: "puts", scope: !5572, file: !5572, line: 661, type: !5260, flags: DIFlagPrototyped, spFlags: 0)
!5668 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5669, file: !5569, line: 131)
!5669 = !DISubprogram(name: "remove", scope: !5572, file: !5572, line: 152, type: !5260, flags: DIFlagPrototyped, spFlags: 0)
!5670 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5671, file: !5569, line: 132)
!5671 = !DISubprogram(name: "rename", scope: !5572, file: !5572, line: 154, type: !5672, flags: DIFlagPrototyped, spFlags: 0)
!5672 = !DISubroutineType(types: !5673)
!5673 = !{!256, !1452, !1452}
!5674 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5675, file: !5569, line: 133)
!5675 = !DISubprogram(name: "rewind", scope: !5572, file: !5572, line: 723, type: !5578, flags: DIFlagPrototyped, spFlags: 0)
!5676 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5677, file: !5569, line: 134)
!5677 = !DISubprogram(name: "scanf", linkageName: "__isoc99_scanf", scope: !5572, file: !5572, line: 437, type: !5660, flags: DIFlagPrototyped, spFlags: 0)
!5678 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5679, file: !5569, line: 135)
!5679 = !DISubprogram(name: "setbuf", scope: !5572, file: !5572, line: 328, type: !5680, flags: DIFlagPrototyped, spFlags: 0)
!5680 = !DISubroutineType(types: !5681)
!5681 = !{null, !5597, !5357}
!5682 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5683, file: !5569, line: 136)
!5683 = !DISubprogram(name: "setvbuf", scope: !5572, file: !5572, line: 332, type: !5684, flags: DIFlagPrototyped, spFlags: 0)
!5684 = !DISubroutineType(types: !5685)
!5685 = !{!256, !5597, !5357, !256, !1288}
!5686 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5687, file: !5569, line: 137)
!5687 = !DISubprogram(name: "sprintf", scope: !5572, file: !5572, line: 358, type: !5688, flags: DIFlagPrototyped, spFlags: 0)
!5688 = !DISubroutineType(types: !5689)
!5689 = !{!256, !5357, !5314, null}
!5690 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5691, file: !5569, line: 138)
!5691 = !DISubprogram(name: "sscanf", linkageName: "__isoc99_sscanf", scope: !5572, file: !5572, line: 439, type: !5692, flags: DIFlagPrototyped, spFlags: 0)
!5692 = !DISubroutineType(types: !5693)
!5693 = !{!256, !5314, !5314, null}
!5694 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5695, file: !5569, line: 139)
!5695 = !DISubprogram(name: "tmpfile", scope: !5572, file: !5572, line: 188, type: !5696, flags: DIFlagPrototyped, spFlags: 0)
!5696 = !DISubroutineType(types: !5697)
!5697 = !{!5580}
!5698 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5699, file: !5569, line: 141)
!5699 = !DISubprogram(name: "tmpnam", scope: !5572, file: !5572, line: 205, type: !5700, flags: DIFlagPrototyped, spFlags: 0)
!5700 = !DISubroutineType(types: !5701)
!5701 = !{!5292, !5292}
!5702 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5703, file: !5569, line: 143)
!5703 = !DISubprogram(name: "ungetc", scope: !5572, file: !5572, line: 668, type: !5614, flags: DIFlagPrototyped, spFlags: 0)
!5704 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5705, file: !5569, line: 144)
!5705 = !DISubprogram(name: "vfprintf", scope: !5572, file: !5572, line: 365, type: !5706, flags: DIFlagPrototyped, spFlags: 0)
!5706 = !DISubroutineType(types: !5707)
!5707 = !{!256, !5597, !5314, !5708}
!5708 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5709, size: 64)
!5709 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", size: 192, flags: DIFlagTypePassByValue, elements: !5710, identifier: "_ZTS13__va_list_tag")
!5710 = !{!5711, !5713, !5714, !5715}
!5711 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !5709, file: !5712, baseType: !68, size: 32)
!5712 = !DIFile(filename: "vllm9391.cu", directory: "/home/mvh6224/CUDA-BOSolver/bugstudy-gklee/src2")
!5713 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !5709, file: !5712, baseType: !68, size: 32, offset: 32)
!5714 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !5709, file: !5712, baseType: !943, size: 64, offset: 64)
!5715 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !5709, file: !5712, baseType: !943, size: 64, offset: 128)
!5716 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5717, file: !5569, line: 145)
!5717 = !DISubprogram(name: "vprintf", scope: !5572, file: !5572, line: 371, type: !5718, flags: DIFlagPrototyped, spFlags: 0)
!5718 = !DISubroutineType(types: !5719)
!5719 = !{!256, !5314, !5708}
!5720 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5721, file: !5569, line: 146)
!5721 = !DISubprogram(name: "vsprintf", scope: !5572, file: !5572, line: 373, type: !5722, flags: DIFlagPrototyped, spFlags: 0)
!5722 = !DISubroutineType(types: !5723)
!5723 = !{!256, !5357, !5314, !5708}
!5724 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5725, file: !5569, line: 175)
!5725 = !DISubprogram(name: "snprintf", scope: !5572, file: !5572, line: 378, type: !5726, flags: DIFlagPrototyped, spFlags: 0)
!5726 = !DISubroutineType(types: !5727)
!5727 = !{!256, !5357, !1288, !5314, null}
!5728 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5729, file: !5569, line: 176)
!5729 = !DISubprogram(name: "vfscanf", linkageName: "__isoc99_vfscanf", scope: !5572, file: !5572, line: 479, type: !5706, flags: DIFlagPrototyped, spFlags: 0)
!5730 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5731, file: !5569, line: 177)
!5731 = !DISubprogram(name: "vscanf", linkageName: "__isoc99_vscanf", scope: !5572, file: !5572, line: 484, type: !5718, flags: DIFlagPrototyped, spFlags: 0)
!5732 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5733, file: !5569, line: 178)
!5733 = !DISubprogram(name: "vsnprintf", scope: !5572, file: !5572, line: 382, type: !5734, flags: DIFlagPrototyped, spFlags: 0)
!5734 = !DISubroutineType(types: !5735)
!5735 = !{!256, !5357, !1288, !5314, !5708}
!5736 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !5737, file: !5569, line: 179)
!5737 = !DISubprogram(name: "vsscanf", linkageName: "__isoc99_vsscanf", scope: !5572, file: !5572, line: 487, type: !5738, flags: DIFlagPrototyped, spFlags: 0)
!5738 = !DISubroutineType(types: !5739)
!5739 = !{!256, !5314, !5314, !5708}
!5740 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5725, file: !5569, line: 185)
!5741 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5729, file: !5569, line: 186)
!5742 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5731, file: !5569, line: 187)
!5743 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5733, file: !5569, line: 188)
!5744 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5737, file: !5569, line: 189)
!5745 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !37, file: !5746, line: 47)
!5746 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/cstdint", directory: "")
!5747 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5748, file: !5746, line: 48)
!5748 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !38, line: 25, baseType: !5749)
!5749 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !40, line: 39, baseType: !559)
!5750 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5751, file: !5746, line: 49)
!5751 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !38, line: 26, baseType: !5752)
!5752 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !40, line: 41, baseType: !256)
!5753 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !648, file: !5746, line: 50)
!5754 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5755, file: !5746, line: 52)
!5755 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast8_t", file: !5756, line: 58, baseType: !41)
!5756 = !DIFile(filename: "/usr/include/stdint.h", directory: "")
!5757 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5758, file: !5746, line: 53)
!5758 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast16_t", file: !5756, line: 60, baseType: !575)
!5759 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5760, file: !5746, line: 54)
!5760 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast32_t", file: !5756, line: 61, baseType: !575)
!5761 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5762, file: !5746, line: 55)
!5762 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast64_t", file: !5756, line: 62, baseType: !575)
!5763 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5764, file: !5746, line: 57)
!5764 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least8_t", file: !5756, line: 43, baseType: !5765)
!5765 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least8_t", file: !40, line: 52, baseType: !39)
!5766 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5767, file: !5746, line: 58)
!5767 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least16_t", file: !5756, line: 44, baseType: !5768)
!5768 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least16_t", file: !40, line: 54, baseType: !5749)
!5769 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5770, file: !5746, line: 59)
!5770 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least32_t", file: !5756, line: 45, baseType: !5771)
!5771 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least32_t", file: !40, line: 56, baseType: !5752)
!5772 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5773, file: !5746, line: 60)
!5773 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least64_t", file: !5756, line: 46, baseType: !5774)
!5774 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least64_t", file: !40, line: 58, baseType: !649)
!5775 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5776, file: !5746, line: 62)
!5776 = !DIDerivedType(tag: DW_TAG_typedef, name: "intmax_t", file: !5756, line: 101, baseType: !5777)
!5777 = !DIDerivedType(tag: DW_TAG_typedef, name: "__intmax_t", file: !40, line: 72, baseType: !575)
!5778 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5779, file: !5746, line: 63)
!5779 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !5756, line: 87, baseType: !575)
!5780 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !261, file: !5746, line: 65)
!5781 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !75, file: !5746, line: 66)
!5782 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !732, file: !5746, line: 67)
!5783 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5784, file: !5746, line: 68)
!5784 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !76, line: 27, baseType: !5785)
!5785 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !40, line: 45, baseType: !1290)
!5786 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5787, file: !5746, line: 70)
!5787 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast8_t", file: !5756, line: 71, baseType: !263)
!5788 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5789, file: !5746, line: 71)
!5789 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast16_t", file: !5756, line: 73, baseType: !1290)
!5790 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5791, file: !5746, line: 72)
!5791 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast32_t", file: !5756, line: 74, baseType: !1290)
!5792 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5793, file: !5746, line: 73)
!5793 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast64_t", file: !5756, line: 75, baseType: !1290)
!5794 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5795, file: !5746, line: 75)
!5795 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least8_t", file: !5756, line: 49, baseType: !5796)
!5796 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least8_t", file: !40, line: 53, baseType: !262)
!5797 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5798, file: !5746, line: 76)
!5798 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least16_t", file: !5756, line: 50, baseType: !5799)
!5799 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least16_t", file: !40, line: 55, baseType: !77)
!5800 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5801, file: !5746, line: 77)
!5801 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least32_t", file: !5756, line: 51, baseType: !5802)
!5802 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least32_t", file: !40, line: 57, baseType: !733)
!5803 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5804, file: !5746, line: 78)
!5804 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least64_t", file: !5756, line: 52, baseType: !5805)
!5805 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least64_t", file: !40, line: 59, baseType: !5785)
!5806 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5807, file: !5746, line: 80)
!5807 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintmax_t", file: !5756, line: 102, baseType: !5808)
!5808 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uintmax_t", file: !40, line: 73, baseType: !1290)
!5809 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5810, file: !5746, line: 81)
!5810 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !5756, line: 90, baseType: !1290)
!5811 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5812, file: !5815, line: 58)
!5812 = !DIDerivedType(tag: DW_TAG_typedef, name: "max_align_t", file: !5813, line: 24, baseType: !5814)
!5813 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/__stddef_max_align_t.h", directory: "")
!5814 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !5813, line: 19, size: 256, flags: DIFlagFwdDecl, identifier: "_ZTS11max_align_t")
!5815 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/cstddef", directory: "")
!5816 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5817, file: !5832, line: 64)
!5817 = !DIDerivedType(tag: DW_TAG_typedef, name: "mbstate_t", file: !5818, line: 6, baseType: !5819)
!5818 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/mbstate_t.h", directory: "")
!5819 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mbstate_t", file: !5820, line: 21, baseType: !5821)
!5820 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h", directory: "")
!5821 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !5820, line: 13, size: 64, flags: DIFlagTypePassByValue, elements: !5822, identifier: "_ZTS11__mbstate_t")
!5822 = !{!5823, !5824}
!5823 = !DIDerivedType(tag: DW_TAG_member, name: "__count", scope: !5821, file: !5820, line: 15, baseType: !256, size: 32)
!5824 = !DIDerivedType(tag: DW_TAG_member, name: "__value", scope: !5821, file: !5820, line: 20, baseType: !5825, size: 32, offset: 32)
!5825 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !5821, file: !5820, line: 16, size: 32, flags: DIFlagTypePassByValue, elements: !5826, identifier: "_ZTSN11__mbstate_tUt_E")
!5826 = !{!5827, !5828}
!5827 = !DIDerivedType(tag: DW_TAG_member, name: "__wch", scope: !5825, file: !5820, line: 18, baseType: !68, size: 32)
!5828 = !DIDerivedType(tag: DW_TAG_member, name: "__wchb", scope: !5825, file: !5820, line: 19, baseType: !5829, size: 32)
!5829 = !DICompositeType(tag: DW_TAG_array_type, baseType: !571, size: 32, elements: !5830)
!5830 = !{!5831}
!5831 = !DISubrange(count: 4)
!5832 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/cwchar", directory: "")
!5833 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5834, file: !5832, line: 141)
!5834 = !DIDerivedType(tag: DW_TAG_typedef, name: "wint_t", file: !5835, line: 20, baseType: !68)
!5835 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/wint_t.h", directory: "")
!5836 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5837, file: !5832, line: 143)
!5837 = !DISubprogram(name: "btowc", scope: !5838, file: !5838, line: 285, type: !5839, flags: DIFlagPrototyped, spFlags: 0)
!5838 = !DIFile(filename: "/usr/include/wchar.h", directory: "")
!5839 = !DISubroutineType(types: !5840)
!5840 = !{!5834, !256}
!5841 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5842, file: !5832, line: 144)
!5842 = !DISubprogram(name: "fgetwc", scope: !5838, file: !5838, line: 744, type: !5843, flags: DIFlagPrototyped, spFlags: 0)
!5843 = !DISubroutineType(types: !5844)
!5844 = !{!5834, !5845}
!5845 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5846, size: 64)
!5846 = !DIDerivedType(tag: DW_TAG_typedef, name: "__FILE", file: !5847, line: 5, baseType: !5567)
!5847 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__FILE.h", directory: "")
!5848 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5849, file: !5832, line: 145)
!5849 = !DISubprogram(name: "fgetws", scope: !5838, file: !5838, line: 773, type: !5850, flags: DIFlagPrototyped, spFlags: 0)
!5850 = !DISubroutineType(types: !5851)
!5851 = !{!5312, !5311, !256, !5852}
!5852 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5845)
!5853 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5854, file: !5832, line: 146)
!5854 = !DISubprogram(name: "fputwc", scope: !5838, file: !5838, line: 758, type: !5855, flags: DIFlagPrototyped, spFlags: 0)
!5855 = !DISubroutineType(types: !5856)
!5856 = !{!5834, !5313, !5845}
!5857 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5858, file: !5832, line: 147)
!5858 = !DISubprogram(name: "fputws", scope: !5838, file: !5838, line: 780, type: !5859, flags: DIFlagPrototyped, spFlags: 0)
!5859 = !DISubroutineType(types: !5860)
!5860 = !{!256, !5358, !5852}
!5861 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5862, file: !5832, line: 148)
!5862 = !DISubprogram(name: "fwide", scope: !5838, file: !5838, line: 588, type: !5863, flags: DIFlagPrototyped, spFlags: 0)
!5863 = !DISubroutineType(types: !5864)
!5864 = !{!256, !5845, !256}
!5865 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5866, file: !5832, line: 149)
!5866 = !DISubprogram(name: "fwprintf", scope: !5838, file: !5838, line: 595, type: !5867, flags: DIFlagPrototyped, spFlags: 0)
!5867 = !DISubroutineType(types: !5868)
!5868 = !{!256, !5852, !5358, null}
!5869 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5870, file: !5832, line: 150)
!5870 = !DISubprogram(name: "fwscanf", linkageName: "__isoc99_fwscanf", scope: !5838, file: !5838, line: 657, type: !5867, flags: DIFlagPrototyped, spFlags: 0)
!5871 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5872, file: !5832, line: 151)
!5872 = !DISubprogram(name: "getwc", scope: !5838, file: !5838, line: 745, type: !5843, flags: DIFlagPrototyped, spFlags: 0)
!5873 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5874, file: !5832, line: 152)
!5874 = !DISubprogram(name: "getwchar", scope: !5838, file: !5838, line: 751, type: !5875, flags: DIFlagPrototyped, spFlags: 0)
!5875 = !DISubroutineType(types: !5876)
!5876 = !{!5834}
!5877 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5878, file: !5832, line: 153)
!5878 = !DISubprogram(name: "mbrlen", scope: !5838, file: !5838, line: 308, type: !5879, flags: DIFlagPrototyped, spFlags: 0)
!5879 = !DISubroutineType(types: !5880)
!5880 = !{!1288, !5314, !1288, !5881}
!5881 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5882)
!5882 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5817, size: 64)
!5883 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5884, file: !5832, line: 154)
!5884 = !DISubprogram(name: "mbrtowc", scope: !5838, file: !5838, line: 297, type: !5885, flags: DIFlagPrototyped, spFlags: 0)
!5885 = !DISubroutineType(types: !5886)
!5886 = !{!1288, !5311, !5314, !1288, !5881}
!5887 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5888, file: !5832, line: 155)
!5888 = !DISubprogram(name: "mbsinit", scope: !5838, file: !5838, line: 293, type: !5889, flags: DIFlagPrototyped, spFlags: 0)
!5889 = !DISubroutineType(types: !5890)
!5890 = !{!256, !5891}
!5891 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5892, size: 64)
!5892 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5817)
!5893 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5894, file: !5832, line: 156)
!5894 = !DISubprogram(name: "mbsrtowcs", scope: !5838, file: !5838, line: 338, type: !5895, flags: DIFlagPrototyped, spFlags: 0)
!5895 = !DISubroutineType(types: !5896)
!5896 = !{!1288, !5311, !5897, !1288, !5881}
!5897 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5898)
!5898 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1452, size: 64)
!5899 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5900, file: !5832, line: 157)
!5900 = !DISubprogram(name: "putwc", scope: !5838, file: !5838, line: 759, type: !5855, flags: DIFlagPrototyped, spFlags: 0)
!5901 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5902, file: !5832, line: 158)
!5902 = !DISubprogram(name: "putwchar", scope: !5838, file: !5838, line: 765, type: !5903, flags: DIFlagPrototyped, spFlags: 0)
!5903 = !DISubroutineType(types: !5904)
!5904 = !{!5834, !5313}
!5905 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5906, file: !5832, line: 160)
!5906 = !DISubprogram(name: "swprintf", scope: !5838, file: !5838, line: 605, type: !5907, flags: DIFlagPrototyped, spFlags: 0)
!5907 = !DISubroutineType(types: !5908)
!5908 = !{!256, !5311, !1288, !5358, null}
!5909 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5910, file: !5832, line: 162)
!5910 = !DISubprogram(name: "swscanf", linkageName: "__isoc99_swscanf", scope: !5838, file: !5838, line: 664, type: !5911, flags: DIFlagPrototyped, spFlags: 0)
!5911 = !DISubroutineType(types: !5912)
!5912 = !{!256, !5358, !5358, null}
!5913 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5914, file: !5832, line: 163)
!5914 = !DISubprogram(name: "ungetwc", scope: !5838, file: !5838, line: 788, type: !5915, flags: DIFlagPrototyped, spFlags: 0)
!5915 = !DISubroutineType(types: !5916)
!5916 = !{!5834, !5834, !5845}
!5917 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5918, file: !5832, line: 164)
!5918 = !DISubprogram(name: "vfwprintf", scope: !5838, file: !5838, line: 613, type: !5919, flags: DIFlagPrototyped, spFlags: 0)
!5919 = !DISubroutineType(types: !5920)
!5920 = !{!256, !5852, !5358, !5708}
!5921 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5922, file: !5832, line: 166)
!5922 = !DISubprogram(name: "vfwscanf", linkageName: "__isoc99_vfwscanf", scope: !5838, file: !5838, line: 711, type: !5919, flags: DIFlagPrototyped, spFlags: 0)
!5923 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5924, file: !5832, line: 169)
!5924 = !DISubprogram(name: "vswprintf", scope: !5838, file: !5838, line: 626, type: !5925, flags: DIFlagPrototyped, spFlags: 0)
!5925 = !DISubroutineType(types: !5926)
!5926 = !{!256, !5311, !1288, !5358, !5708}
!5927 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5928, file: !5832, line: 172)
!5928 = !DISubprogram(name: "vswscanf", linkageName: "__isoc99_vswscanf", scope: !5838, file: !5838, line: 718, type: !5929, flags: DIFlagPrototyped, spFlags: 0)
!5929 = !DISubroutineType(types: !5930)
!5930 = !{!256, !5358, !5358, !5708}
!5931 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5932, file: !5832, line: 174)
!5932 = !DISubprogram(name: "vwprintf", scope: !5838, file: !5838, line: 621, type: !5933, flags: DIFlagPrototyped, spFlags: 0)
!5933 = !DISubroutineType(types: !5934)
!5934 = !{!256, !5358, !5708}
!5935 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5936, file: !5832, line: 176)
!5936 = !DISubprogram(name: "vwscanf", linkageName: "__isoc99_vwscanf", scope: !5838, file: !5838, line: 715, type: !5933, flags: DIFlagPrototyped, spFlags: 0)
!5937 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5938, file: !5832, line: 178)
!5938 = !DISubprogram(name: "wcrtomb", scope: !5838, file: !5838, line: 302, type: !5939, flags: DIFlagPrototyped, spFlags: 0)
!5939 = !DISubroutineType(types: !5940)
!5940 = !{!1288, !5357, !5313, !5881}
!5941 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5942, file: !5832, line: 179)
!5942 = !DISubprogram(name: "wcscat", scope: !5838, file: !5838, line: 97, type: !5943, flags: DIFlagPrototyped, spFlags: 0)
!5943 = !DISubroutineType(types: !5944)
!5944 = !{!5312, !5311, !5358}
!5945 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5946, file: !5832, line: 180)
!5946 = !DISubprogram(name: "wcscmp", scope: !5838, file: !5838, line: 106, type: !5947, flags: DIFlagPrototyped, spFlags: 0)
!5947 = !DISubroutineType(types: !5948)
!5948 = !{!256, !5359, !5359}
!5949 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5950, file: !5832, line: 181)
!5950 = !DISubprogram(name: "wcscoll", scope: !5838, file: !5838, line: 131, type: !5947, flags: DIFlagPrototyped, spFlags: 0)
!5951 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5952, file: !5832, line: 182)
!5952 = !DISubprogram(name: "wcscpy", scope: !5838, file: !5838, line: 87, type: !5943, flags: DIFlagPrototyped, spFlags: 0)
!5953 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5954, file: !5832, line: 183)
!5954 = !DISubprogram(name: "wcscspn", scope: !5838, file: !5838, line: 188, type: !5955, flags: DIFlagPrototyped, spFlags: 0)
!5955 = !DISubroutineType(types: !5956)
!5956 = !{!1288, !5359, !5359}
!5957 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5958, file: !5832, line: 184)
!5958 = !DISubprogram(name: "wcsftime", scope: !5838, file: !5838, line: 852, type: !5959, flags: DIFlagPrototyped, spFlags: 0)
!5959 = !DISubroutineType(types: !5960)
!5960 = !{!1288, !5311, !1288, !5358, !5961}
!5961 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5962)
!5962 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5963, size: 64)
!5963 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5964)
!5964 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tm", file: !5965, line: 7, size: 448, flags: DIFlagTypePassByValue, elements: !5966, identifier: "_ZTS2tm")
!5965 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_tm.h", directory: "")
!5966 = !{!5967, !5968, !5969, !5970, !5971, !5972, !5973, !5974, !5975, !5976, !5977}
!5967 = !DIDerivedType(tag: DW_TAG_member, name: "tm_sec", scope: !5964, file: !5965, line: 9, baseType: !256, size: 32)
!5968 = !DIDerivedType(tag: DW_TAG_member, name: "tm_min", scope: !5964, file: !5965, line: 10, baseType: !256, size: 32, offset: 32)
!5969 = !DIDerivedType(tag: DW_TAG_member, name: "tm_hour", scope: !5964, file: !5965, line: 11, baseType: !256, size: 32, offset: 64)
!5970 = !DIDerivedType(tag: DW_TAG_member, name: "tm_mday", scope: !5964, file: !5965, line: 12, baseType: !256, size: 32, offset: 96)
!5971 = !DIDerivedType(tag: DW_TAG_member, name: "tm_mon", scope: !5964, file: !5965, line: 13, baseType: !256, size: 32, offset: 128)
!5972 = !DIDerivedType(tag: DW_TAG_member, name: "tm_year", scope: !5964, file: !5965, line: 14, baseType: !256, size: 32, offset: 160)
!5973 = !DIDerivedType(tag: DW_TAG_member, name: "tm_wday", scope: !5964, file: !5965, line: 15, baseType: !256, size: 32, offset: 192)
!5974 = !DIDerivedType(tag: DW_TAG_member, name: "tm_yday", scope: !5964, file: !5965, line: 16, baseType: !256, size: 32, offset: 224)
!5975 = !DIDerivedType(tag: DW_TAG_member, name: "tm_isdst", scope: !5964, file: !5965, line: 17, baseType: !256, size: 32, offset: 256)
!5976 = !DIDerivedType(tag: DW_TAG_member, name: "tm_gmtoff", scope: !5964, file: !5965, line: 20, baseType: !575, size: 64, offset: 320)
!5977 = !DIDerivedType(tag: DW_TAG_member, name: "tm_zone", scope: !5964, file: !5965, line: 21, baseType: !1452, size: 64, offset: 384)
!5978 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5979, file: !5832, line: 185)
!5979 = !DISubprogram(name: "wcslen", scope: !5838, file: !5838, line: 223, type: !5980, flags: DIFlagPrototyped, spFlags: 0)
!5980 = !DISubroutineType(types: !5981)
!5981 = !{!1288, !5359}
!5982 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5983, file: !5832, line: 186)
!5983 = !DISubprogram(name: "wcsncat", scope: !5838, file: !5838, line: 101, type: !5984, flags: DIFlagPrototyped, spFlags: 0)
!5984 = !DISubroutineType(types: !5985)
!5985 = !{!5312, !5311, !5358, !1288}
!5986 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5987, file: !5832, line: 187)
!5987 = !DISubprogram(name: "wcsncmp", scope: !5838, file: !5838, line: 109, type: !5988, flags: DIFlagPrototyped, spFlags: 0)
!5988 = !DISubroutineType(types: !5989)
!5989 = !{!256, !5359, !5359, !1288}
!5990 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5991, file: !5832, line: 188)
!5991 = !DISubprogram(name: "wcsncpy", scope: !5838, file: !5838, line: 92, type: !5984, flags: DIFlagPrototyped, spFlags: 0)
!5992 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5993, file: !5832, line: 189)
!5993 = !DISubprogram(name: "wcsrtombs", scope: !5838, file: !5838, line: 344, type: !5994, flags: DIFlagPrototyped, spFlags: 0)
!5994 = !DISubroutineType(types: !5995)
!5995 = !{!1288, !5357, !5996, !1288, !5881}
!5996 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !5997)
!5997 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5359, size: 64)
!5998 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5999, file: !5832, line: 190)
!5999 = !DISubprogram(name: "wcsspn", scope: !5838, file: !5838, line: 192, type: !5955, flags: DIFlagPrototyped, spFlags: 0)
!6000 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6001, file: !5832, line: 191)
!6001 = !DISubprogram(name: "wcstod", scope: !5838, file: !5838, line: 378, type: !6002, flags: DIFlagPrototyped, spFlags: 0)
!6002 = !DISubroutineType(types: !6003)
!6003 = !{!4871, !5358, !6004}
!6004 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !6005)
!6005 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5312, size: 64)
!6006 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6007, file: !5832, line: 193)
!6007 = !DISubprogram(name: "wcstof", scope: !5838, file: !5838, line: 383, type: !6008, flags: DIFlagPrototyped, spFlags: 0)
!6008 = !DISubroutineType(types: !6009)
!6009 = !{!4737, !5358, !6004}
!6010 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6011, file: !5832, line: 195)
!6011 = !DISubprogram(name: "wcstok", scope: !5838, file: !5838, line: 218, type: !6012, flags: DIFlagPrototyped, spFlags: 0)
!6012 = !DISubroutineType(types: !6013)
!6013 = !{!5312, !5311, !5358, !6004}
!6014 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6015, file: !5832, line: 196)
!6015 = !DISubprogram(name: "wcstol", scope: !5838, file: !5838, line: 429, type: !6016, flags: DIFlagPrototyped, spFlags: 0)
!6016 = !DISubroutineType(types: !6017)
!6017 = !{!575, !5358, !6004, !256}
!6018 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6019, file: !5832, line: 197)
!6019 = !DISubprogram(name: "wcstoul", scope: !5838, file: !5838, line: 434, type: !6020, flags: DIFlagPrototyped, spFlags: 0)
!6020 = !DISubroutineType(types: !6021)
!6021 = !{!1290, !5358, !6004, !256}
!6022 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6023, file: !5832, line: 198)
!6023 = !DISubprogram(name: "wcsxfrm", scope: !5838, file: !5838, line: 135, type: !6024, flags: DIFlagPrototyped, spFlags: 0)
!6024 = !DISubroutineType(types: !6025)
!6025 = !{!1288, !5311, !5358, !1288}
!6026 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6027, file: !5832, line: 199)
!6027 = !DISubprogram(name: "wctob", scope: !5838, file: !5838, line: 289, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6028 = !DISubroutineType(types: !6029)
!6029 = !{!256, !5834}
!6030 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6031, file: !5832, line: 200)
!6031 = !DISubprogram(name: "wmemcmp", scope: !5838, file: !5838, line: 259, type: !5988, flags: DIFlagPrototyped, spFlags: 0)
!6032 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6033, file: !5832, line: 201)
!6033 = !DISubprogram(name: "wmemcpy", scope: !5838, file: !5838, line: 263, type: !5984, flags: DIFlagPrototyped, spFlags: 0)
!6034 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6035, file: !5832, line: 202)
!6035 = !DISubprogram(name: "wmemmove", scope: !5838, file: !5838, line: 268, type: !6036, flags: DIFlagPrototyped, spFlags: 0)
!6036 = !DISubroutineType(types: !6037)
!6037 = !{!5312, !5312, !5359, !1288}
!6038 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6039, file: !5832, line: 203)
!6039 = !DISubprogram(name: "wmemset", scope: !5838, file: !5838, line: 272, type: !6040, flags: DIFlagPrototyped, spFlags: 0)
!6040 = !DISubroutineType(types: !6041)
!6041 = !{!5312, !5312, !5313, !1288}
!6042 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6043, file: !5832, line: 204)
!6043 = !DISubprogram(name: "wprintf", scope: !5838, file: !5838, line: 602, type: !6044, flags: DIFlagPrototyped, spFlags: 0)
!6044 = !DISubroutineType(types: !6045)
!6045 = !{!256, !5358, null}
!6046 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6047, file: !5832, line: 205)
!6047 = !DISubprogram(name: "wscanf", linkageName: "__isoc99_wscanf", scope: !5838, file: !5838, line: 661, type: !6044, flags: DIFlagPrototyped, spFlags: 0)
!6048 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6049, file: !5832, line: 206)
!6049 = !DISubprogram(name: "wcschr", scope: !5838, file: !5838, line: 165, type: !6050, flags: DIFlagPrototyped, spFlags: 0)
!6050 = !DISubroutineType(types: !6051)
!6051 = !{!5312, !5359, !5313}
!6052 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6053, file: !5832, line: 207)
!6053 = !DISubprogram(name: "wcspbrk", scope: !5838, file: !5838, line: 202, type: !6054, flags: DIFlagPrototyped, spFlags: 0)
!6054 = !DISubroutineType(types: !6055)
!6055 = !{!5312, !5359, !5359}
!6056 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6057, file: !5832, line: 208)
!6057 = !DISubprogram(name: "wcsrchr", scope: !5838, file: !5838, line: 175, type: !6050, flags: DIFlagPrototyped, spFlags: 0)
!6058 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6059, file: !5832, line: 209)
!6059 = !DISubprogram(name: "wcsstr", scope: !5838, file: !5838, line: 213, type: !6054, flags: DIFlagPrototyped, spFlags: 0)
!6060 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6061, file: !5832, line: 210)
!6061 = !DISubprogram(name: "wmemchr", scope: !5838, file: !5838, line: 254, type: !6062, flags: DIFlagPrototyped, spFlags: 0)
!6062 = !DISubroutineType(types: !6063)
!6063 = !{!5312, !5359, !5313, !1288}
!6064 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !6065, file: !5832, line: 251)
!6065 = !DISubprogram(name: "wcstold", scope: !5838, file: !5838, line: 385, type: !6066, flags: DIFlagPrototyped, spFlags: 0)
!6066 = !DISubroutineType(types: !6067)
!6067 = !{!4988, !5358, !6004}
!6068 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !6069, file: !5832, line: 260)
!6069 = !DISubprogram(name: "wcstoll", scope: !5838, file: !5838, line: 442, type: !6070, flags: DIFlagPrototyped, spFlags: 0)
!6070 = !DISubroutineType(types: !6071)
!6071 = !{!4839, !5358, !6004, !256}
!6072 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !6073, file: !5832, line: 261)
!6073 = !DISubprogram(name: "wcstoull", scope: !5838, file: !5838, line: 449, type: !6074, flags: DIFlagPrototyped, spFlags: 0)
!6074 = !DISubroutineType(types: !6075)
!6075 = !{!16, !5358, !6004, !256}
!6076 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6065, file: !5832, line: 267)
!6077 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6069, file: !5832, line: 268)
!6078 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6073, file: !5832, line: 269)
!6079 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6007, file: !5832, line: 283)
!6080 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5922, file: !5832, line: 286)
!6081 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5928, file: !5832, line: 289)
!6082 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5936, file: !5832, line: 292)
!6083 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6065, file: !5832, line: 296)
!6084 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6069, file: !5832, line: 297)
!6085 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6073, file: !5832, line: 298)
!6086 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6087, file: !6088, line: 68)
!6087 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "exception_ptr", scope: !6089, file: !6088, line: 90, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSNSt15__exception_ptr13exception_ptrE")
!6088 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/exception_ptr.h", directory: "")
!6089 = !DINamespace(name: "__exception_ptr", scope: !2)
!6090 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6089, entity: !6091, file: !6088, line: 84)
!6091 = !DISubprogram(name: "rethrow_exception", linkageName: "_ZSt17rethrow_exceptionNSt15__exception_ptr13exception_ptrE", scope: !2, file: !6088, line: 80, type: !6092, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!6092 = !DISubroutineType(types: !6093)
!6093 = !{null, !6087}
!6094 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6095, file: !6097, line: 53)
!6095 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "lconv", file: !6096, line: 51, size: 768, flags: DIFlagFwdDecl, identifier: "_ZTS5lconv")
!6096 = !DIFile(filename: "/usr/include/locale.h", directory: "")
!6097 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/clocale", directory: "")
!6098 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6099, file: !6097, line: 54)
!6099 = !DISubprogram(name: "setlocale", scope: !6096, file: !6096, line: 122, type: !6100, flags: DIFlagPrototyped, spFlags: 0)
!6100 = !DISubroutineType(types: !6101)
!6101 = !{!5292, !256, !1452}
!6102 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6103, file: !6097, line: 55)
!6103 = !DISubprogram(name: "localeconv", scope: !6096, file: !6096, line: 125, type: !6104, flags: DIFlagPrototyped, spFlags: 0)
!6104 = !DISubroutineType(types: !6105)
!6105 = !{!6106}
!6106 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6095, size: 64)
!6107 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6108, file: !6110, line: 64)
!6108 = !DISubprogram(name: "isalnum", scope: !6109, file: !6109, line: 108, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6109 = !DIFile(filename: "/usr/include/ctype.h", directory: "")
!6110 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/cctype", directory: "")
!6111 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6112, file: !6110, line: 65)
!6112 = !DISubprogram(name: "isalpha", scope: !6109, file: !6109, line: 109, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6113 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6114, file: !6110, line: 66)
!6114 = !DISubprogram(name: "iscntrl", scope: !6109, file: !6109, line: 110, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6115 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6116, file: !6110, line: 67)
!6116 = !DISubprogram(name: "isdigit", scope: !6109, file: !6109, line: 111, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6117 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6118, file: !6110, line: 68)
!6118 = !DISubprogram(name: "isgraph", scope: !6109, file: !6109, line: 113, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6119 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6120, file: !6110, line: 69)
!6120 = !DISubprogram(name: "islower", scope: !6109, file: !6109, line: 112, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6121 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6122, file: !6110, line: 70)
!6122 = !DISubprogram(name: "isprint", scope: !6109, file: !6109, line: 114, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6123 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6124, file: !6110, line: 71)
!6124 = !DISubprogram(name: "ispunct", scope: !6109, file: !6109, line: 115, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6125 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6126, file: !6110, line: 72)
!6126 = !DISubprogram(name: "isspace", scope: !6109, file: !6109, line: 116, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6127 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6128, file: !6110, line: 73)
!6128 = !DISubprogram(name: "isupper", scope: !6109, file: !6109, line: 117, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6129 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6130, file: !6110, line: 74)
!6130 = !DISubprogram(name: "isxdigit", scope: !6109, file: !6109, line: 118, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6131 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6132, file: !6110, line: 75)
!6132 = !DISubprogram(name: "tolower", scope: !6109, file: !6109, line: 122, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6133 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6134, file: !6110, line: 76)
!6134 = !DISubprogram(name: "toupper", scope: !6109, file: !6109, line: 125, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6135 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6136, file: !6110, line: 87)
!6136 = !DISubprogram(name: "isblank", scope: !6109, file: !6109, line: 130, type: !4731, flags: DIFlagPrototyped, spFlags: 0)
!6137 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6138, file: !6142, line: 82)
!6138 = !DIDerivedType(tag: DW_TAG_typedef, name: "wctrans_t", file: !6139, line: 48, baseType: !6140)
!6139 = !DIFile(filename: "/usr/include/wctype.h", directory: "")
!6140 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6141, size: 64)
!6141 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5752)
!6142 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/cwctype", directory: "")
!6143 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6144, file: !6142, line: 83)
!6144 = !DIDerivedType(tag: DW_TAG_typedef, name: "wctype_t", file: !6145, line: 38, baseType: !1290)
!6145 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/wctype-wchar.h", directory: "")
!6146 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5834, file: !6142, line: 84)
!6147 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6148, file: !6142, line: 86)
!6148 = !DISubprogram(name: "iswalnum", scope: !6145, file: !6145, line: 95, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6149 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6150, file: !6142, line: 87)
!6150 = !DISubprogram(name: "iswalpha", scope: !6145, file: !6145, line: 101, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6151 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6152, file: !6142, line: 89)
!6152 = !DISubprogram(name: "iswblank", scope: !6145, file: !6145, line: 146, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6153 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6154, file: !6142, line: 91)
!6154 = !DISubprogram(name: "iswcntrl", scope: !6145, file: !6145, line: 104, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6155 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6156, file: !6142, line: 92)
!6156 = !DISubprogram(name: "iswctype", scope: !6145, file: !6145, line: 159, type: !6157, flags: DIFlagPrototyped, spFlags: 0)
!6157 = !DISubroutineType(types: !6158)
!6158 = !{!256, !5834, !6144}
!6159 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6160, file: !6142, line: 93)
!6160 = !DISubprogram(name: "iswdigit", scope: !6145, file: !6145, line: 108, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6161 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6162, file: !6142, line: 94)
!6162 = !DISubprogram(name: "iswgraph", scope: !6145, file: !6145, line: 112, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6163 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6164, file: !6142, line: 95)
!6164 = !DISubprogram(name: "iswlower", scope: !6145, file: !6145, line: 117, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6165 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6166, file: !6142, line: 96)
!6166 = !DISubprogram(name: "iswprint", scope: !6145, file: !6145, line: 120, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6167 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6168, file: !6142, line: 97)
!6168 = !DISubprogram(name: "iswpunct", scope: !6145, file: !6145, line: 125, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6169 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6170, file: !6142, line: 98)
!6170 = !DISubprogram(name: "iswspace", scope: !6145, file: !6145, line: 130, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6171 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6172, file: !6142, line: 99)
!6172 = !DISubprogram(name: "iswupper", scope: !6145, file: !6145, line: 135, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6173 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6174, file: !6142, line: 100)
!6174 = !DISubprogram(name: "iswxdigit", scope: !6145, file: !6145, line: 140, type: !6028, flags: DIFlagPrototyped, spFlags: 0)
!6175 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6176, file: !6142, line: 101)
!6176 = !DISubprogram(name: "towctrans", scope: !6139, file: !6139, line: 55, type: !6177, flags: DIFlagPrototyped, spFlags: 0)
!6177 = !DISubroutineType(types: !6178)
!6178 = !{!5834, !5834, !6138}
!6179 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6180, file: !6142, line: 102)
!6180 = !DISubprogram(name: "towlower", scope: !6145, file: !6145, line: 166, type: !6181, flags: DIFlagPrototyped, spFlags: 0)
!6181 = !DISubroutineType(types: !6182)
!6182 = !{!5834, !5834}
!6183 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6184, file: !6142, line: 103)
!6184 = !DISubprogram(name: "towupper", scope: !6145, file: !6145, line: 169, type: !6181, flags: DIFlagPrototyped, spFlags: 0)
!6185 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6186, file: !6142, line: 104)
!6186 = !DISubprogram(name: "wctrans", scope: !6139, file: !6139, line: 52, type: !6187, flags: DIFlagPrototyped, spFlags: 0)
!6187 = !DISubroutineType(types: !6188)
!6188 = !{!6138, !1452}
!6189 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6190, file: !6142, line: 105)
!6190 = !DISubprogram(name: "wctype", scope: !6145, file: !6145, line: 155, type: !6191, flags: DIFlagPrototyped, spFlags: 0)
!6191 = !DISubroutineType(types: !6192)
!6192 = !{!6144, !1452}
!6193 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !34, file: !35, line: 122)
!6194 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6195, entity: !36, file: !6196, line: 154)
!6195 = !DINamespace(name: "caffe2", scope: null)
!6196 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/macros/Macros.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6197 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6198, entity: !36, file: !6196, line: 157)
!6198 = !DINamespace(name: "at", scope: null)
!6199 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6200, entity: !6201, file: !6196, line: 160)
!6200 = !DINamespace(name: "cuda", scope: !6198)
!6201 = !DINamespace(name: "cuda", scope: !36)
!6202 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6200, entity: !6203, file: !6196, line: 172)
!6203 = !DINamespace(name: "hip", scope: !36)
!6204 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6205, entity: !6206, file: !6196, line: 176)
!6205 = !DINamespace(name: "xpu", scope: !6198)
!6206 = !DINamespace(name: "xpu", scope: !36)
!6207 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !65, file: !853, line: 95)
!6208 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6209, file: !853, line: 96)
!6209 = !DIGlobalVariable(name: "__default_lock_policy", linkageName: "_ZN9__gnu_cxxL21__default_lock_policyE", scope: !67, file: !66, line: 53, type: !6210, isLocal: true, isDefinition: false)
!6210 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !65)
!6211 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !6212, file: !6221, line: 10)
!6212 = !DISubprogram(name: "stod", linkageName: "_ZNSt7__cxx114stodERKNS_12basic_stringIwSt11char_traitsIwESaIwEEEPm", scope: !1416, file: !6213, line: 6780, type: !6214, flags: DIFlagPrototyped, spFlags: 0)
!6213 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/basic_string.h", directory: "")
!6214 = !DISubroutineType(types: !6215)
!6215 = !{!4871, !6216, !6220}
!6216 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !6217, size: 64)
!6217 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6218)
!6218 = !DIDerivedType(tag: DW_TAG_typedef, name: "wstring", scope: !2, file: !1413, line: 83, baseType: !6219)
!6219 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "basic_string<wchar_t, std::char_traits<wchar_t>, std::allocator<wchar_t> >", scope: !1416, file: !1415, line: 1650, size: 256, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEEE")
!6220 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1317, size: 64)
!6221 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/string_utils.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6222 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !6223, file: !6221, line: 12)
!6223 = !DISubprogram(name: "stoi", linkageName: "_ZNSt7__cxx114stoiERKNS_12basic_stringIwSt11char_traitsIwESaIwEEEPmi", scope: !1416, file: !6213, line: 6750, type: !6224, flags: DIFlagPrototyped, spFlags: 0)
!6224 = !DISubroutineType(types: !6225)
!6225 = !{!256, !6216, !6220, !256}
!6226 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !6227, file: !6221, line: 14)
!6227 = !DISubprogram(name: "stoll", linkageName: "_ZNSt7__cxx115stollERKNS_12basic_stringIwSt11char_traitsIwESaIwEEEPmi", scope: !1416, file: !6213, line: 6765, type: !6228, flags: DIFlagPrototyped, spFlags: 0)
!6228 = !DISubroutineType(types: !6229)
!6229 = !{!4839, !6216, !6220, !256}
!6230 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !6231, file: !6221, line: 16)
!6231 = !DISubprogram(name: "stoull", linkageName: "_ZNSt7__cxx116stoullERKNS_12basic_stringIwSt11char_traitsIwESaIwEEEPmi", scope: !1416, file: !6213, line: 6770, type: !6232, flags: DIFlagPrototyped, spFlags: 0)
!6232 = !DISubroutineType(types: !6233)
!6233 = !{!16, !6216, !6220, !256}
!6234 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !6235, file: !6221, line: 18)
!6235 = !DISubprogram(name: "to_string", linkageName: "_ZNSt7__cxx119to_stringEe", scope: !1416, file: !6213, line: 6739, type: !6236, flags: DIFlagPrototyped, spFlags: 0)
!6236 = !DISubroutineType(types: !6237)
!6237 = !{!1412, !4988}
!6238 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6239, file: !74, line: 733)
!6239 = !DIGlobalVariable(name: "kAutograd", linkageName: "_ZN3c10L9kAutogradE", scope: !36, file: !74, line: 614, type: !6240, isLocal: true, isDefinition: false)
!6240 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !73)
!6241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6242, file: !6246, line: 77)
!6242 = !DISubprogram(name: "memchr", scope: !6243, file: !6243, line: 89, type: !6244, flags: DIFlagPrototyped, spFlags: 0)
!6243 = !DIFile(filename: "/usr/include/string.h", directory: "")
!6244 = !DISubroutineType(types: !6245)
!6245 = !{!3055, !3055, !256, !1288}
!6246 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/cstring", directory: "")
!6247 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6248, file: !6246, line: 78)
!6248 = !DISubprogram(name: "memcmp", scope: !6243, file: !6243, line: 64, type: !6249, flags: DIFlagPrototyped, spFlags: 0)
!6249 = !DISubroutineType(types: !6250)
!6250 = !{!256, !3055, !3055, !1288}
!6251 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6252, file: !6246, line: 79)
!6252 = !DISubprogram(name: "memcpy", linkageName: "_ZL6memcpyPvPKvm", scope: !6253, file: !6253, line: 1549, type: !6254, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!6253 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/__clang_cuda_device_functions.h", directory: "")
!6254 = !DISubroutineType(types: !6255)
!6255 = !{!943, !943, !3055, !1288}
!6256 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6257, file: !6246, line: 80)
!6257 = !DISubprogram(name: "memmove", scope: !6243, file: !6243, line: 47, type: !6254, flags: DIFlagPrototyped, spFlags: 0)
!6258 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6259, file: !6246, line: 81)
!6259 = !DISubprogram(name: "memset", linkageName: "_ZL6memsetPvim", scope: !6253, file: !6253, line: 1552, type: !6260, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit)
!6260 = !DISubroutineType(types: !6261)
!6261 = !{!943, !943, !256, !1288}
!6262 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6263, file: !6246, line: 82)
!6263 = !DISubprogram(name: "strcat", scope: !6243, file: !6243, line: 149, type: !6264, flags: DIFlagPrototyped, spFlags: 0)
!6264 = !DISubroutineType(types: !6265)
!6265 = !{!5292, !5357, !5314}
!6266 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6267, file: !6246, line: 83)
!6267 = !DISubprogram(name: "strcmp", scope: !6243, file: !6243, line: 156, type: !5672, flags: DIFlagPrototyped, spFlags: 0)
!6268 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6269, file: !6246, line: 84)
!6269 = !DISubprogram(name: "strcoll", scope: !6243, file: !6243, line: 163, type: !5672, flags: DIFlagPrototyped, spFlags: 0)
!6270 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6271, file: !6246, line: 85)
!6271 = !DISubprogram(name: "strcpy", scope: !6243, file: !6243, line: 141, type: !6264, flags: DIFlagPrototyped, spFlags: 0)
!6272 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6273, file: !6246, line: 86)
!6273 = !DISubprogram(name: "strcspn", scope: !6243, file: !6243, line: 293, type: !6274, flags: DIFlagPrototyped, spFlags: 0)
!6274 = !DISubroutineType(types: !6275)
!6275 = !{!1288, !1452, !1452}
!6276 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6277, file: !6246, line: 87)
!6277 = !DISubprogram(name: "strerror", scope: !6243, file: !6243, line: 419, type: !6278, flags: DIFlagPrototyped, spFlags: 0)
!6278 = !DISubroutineType(types: !6279)
!6279 = !{!5292, !256}
!6280 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6281, file: !6246, line: 88)
!6281 = !DISubprogram(name: "strlen", scope: !6243, file: !6243, line: 407, type: !6282, flags: DIFlagPrototyped, spFlags: 0)
!6282 = !DISubroutineType(types: !6283)
!6283 = !{!1288, !1452}
!6284 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6285, file: !6246, line: 89)
!6285 = !DISubprogram(name: "strncat", scope: !6243, file: !6243, line: 152, type: !6286, flags: DIFlagPrototyped, spFlags: 0)
!6286 = !DISubroutineType(types: !6287)
!6287 = !{!5292, !5357, !5314, !1288}
!6288 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6289, file: !6246, line: 90)
!6289 = !DISubprogram(name: "strncmp", scope: !6243, file: !6243, line: 159, type: !6290, flags: DIFlagPrototyped, spFlags: 0)
!6290 = !DISubroutineType(types: !6291)
!6291 = !{!256, !1452, !1452, !1288}
!6292 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6293, file: !6246, line: 91)
!6293 = !DISubprogram(name: "strncpy", scope: !6243, file: !6243, line: 144, type: !6286, flags: DIFlagPrototyped, spFlags: 0)
!6294 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6295, file: !6246, line: 92)
!6295 = !DISubprogram(name: "strspn", scope: !6243, file: !6243, line: 297, type: !6274, flags: DIFlagPrototyped, spFlags: 0)
!6296 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6297, file: !6246, line: 93)
!6297 = !DISubprogram(name: "strtok", scope: !6243, file: !6243, line: 356, type: !6264, flags: DIFlagPrototyped, spFlags: 0)
!6298 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6299, file: !6246, line: 94)
!6299 = !DISubprogram(name: "strxfrm", scope: !6243, file: !6243, line: 166, type: !6300, flags: DIFlagPrototyped, spFlags: 0)
!6300 = !DISubroutineType(types: !6301)
!6301 = !{!1288, !5357, !5314, !1288}
!6302 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6303, file: !6246, line: 95)
!6303 = !DISubprogram(name: "strchr", scope: !6243, file: !6243, line: 228, type: !6304, flags: DIFlagPrototyped, spFlags: 0)
!6304 = !DISubroutineType(types: !6305)
!6305 = !{!1452, !1452, !256}
!6306 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6307, file: !6246, line: 96)
!6307 = !DISubprogram(name: "strpbrk", scope: !6243, file: !6243, line: 305, type: !6308, flags: DIFlagPrototyped, spFlags: 0)
!6308 = !DISubroutineType(types: !6309)
!6309 = !{!1452, !1452, !1452}
!6310 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6311, file: !6246, line: 97)
!6311 = !DISubprogram(name: "strrchr", scope: !6243, file: !6243, line: 255, type: !6304, flags: DIFlagPrototyped, spFlags: 0)
!6312 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6313, file: !6246, line: 98)
!6313 = !DISubprogram(name: "strstr", scope: !6243, file: !6243, line: 332, type: !6308, flags: DIFlagPrototyped, spFlags: 0)
!6314 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6315, entity: !6318, file: !6319, line: 58)
!6315 = !DINamespace(name: "__4", scope: !6316, exportSymbols: true)
!6316 = !DINamespace(name: "std", scope: !6317)
!6317 = !DINamespace(name: "cuda", scope: null)
!6318 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", file: !1289, line: 35, baseType: !575)
!6319 = !DIFile(filename: "/usr/local/cuda/include/cuda/std/detail/libcxx/include/cstddef", directory: "")
!6320 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6315, entity: !1288, file: !6319, line: 59)
!6321 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6315, entity: !5812, file: !6319, line: 64)
!6322 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !744, entity: !6323, file: !742, line: 733)
!6323 = !DIDerivedType(tag: DW_TAG_typedef, name: "true_type", scope: !743, file: !742, line: 64, baseType: !741)
!6324 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !744, entity: !6325, file: !742, line: 734)
!6325 = !DIDerivedType(tag: DW_TAG_typedef, name: "false_type", scope: !743, file: !742, line: 67, baseType: !786)
!6326 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6327, entity: !6328, file: !6329, line: 66)
!6327 = !DINamespace(name: "cpp", scope: !829)
!6328 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tag", scope: !6330, file: !6329, line: 51, size: 8, flags: DIFlagTypePassByValue, elements: !6331, identifier: "_ZTSN6thrust6system3cpp6detail3tagE")
!6329 = !DIFile(filename: "/usr/local/cuda/include/thrust/system/cpp/detail/execution_policy.h", directory: "")
!6330 = !DINamespace(name: "detail", scope: !6327)
!6331 = !{!6332}
!6332 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6328, baseType: !6333, extraData: i32 0)
!6333 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy<thrust::system::cpp::detail::tag>", scope: !6330, file: !6329, line: 45, size: 8, flags: DIFlagTypePassByValue, elements: !6334, templateParams: !6354, identifier: "_ZTSN6thrust6system3cpp6detail16execution_policyINS2_3tagEEE")
!6334 = !{!6335}
!6335 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6333, baseType: !6336, extraData: i32 0)
!6336 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy<thrust::system::cpp::detail::tag>", scope: !827, file: !826, line: 57, size: 8, flags: DIFlagTypePassByValue, elements: !6337, templateParams: !6352, identifier: "_ZTSN6thrust6system6detail10sequential16execution_policyINS0_3cpp6detail3tagEEE")
!6337 = !{!6338, !6347}
!6338 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6336, baseType: !6339, extraData: i32 0)
!6339 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy<thrust::system::cpp::detail::tag>", scope: !744, file: !836, line: 72, size: 8, flags: DIFlagTypePassByValue, elements: !6340, templateParams: !6345, identifier: "_ZTSN6thrust16execution_policyINS_6system3cpp6detail3tagEEE")
!6340 = !{!6341}
!6341 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6339, baseType: !6342, extraData: i32 0)
!6342 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy_base<thrust::system::cpp::detail::tag>", scope: !743, file: !836, line: 43, size: 8, flags: DIFlagTypePassByValue, elements: !6343, templateParams: !6345, identifier: "_ZTSN6thrust6detail21execution_policy_baseINS_6system3cpp6detail3tagEEE")
!6343 = !{!6344}
!6344 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6342, baseType: !842, extraData: i32 0)
!6345 = !{!6346}
!6346 = !DITemplateTypeParameter(name: "DerivedPolicy", type: !6328)
!6347 = !DISubprogram(name: "operator tag", linkageName: "_ZNK6thrust6system6detail10sequential16execution_policyINS0_3cpp6detail3tagEEcvNS2_3tagEEv", scope: !6336, file: !826, line: 61, type: !6348, scopeLine: 61, flags: DIFlagPrototyped, spFlags: 0)
!6348 = !DISubroutineType(types: !6349)
!6349 = !{!825, !6350}
!6350 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6351, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!6351 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6336)
!6352 = !{!6353}
!6353 = !DITemplateTypeParameter(name: "Derived", type: !6328)
!6354 = !{!6355}
!6355 = !DITemplateTypeParameter(type: !6328)
!6356 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6357, entity: !6328, file: !6329, line: 76)
!6357 = !DINamespace(name: "cpp", scope: !744)
!6358 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6359, entity: !6360, file: !6361, line: 144)
!6359 = !DINamespace(name: "cub", scope: !744)
!6360 = !DINamespace(name: "cub", scope: null)
!6361 = !DIFile(filename: "/usr/local/cuda/include/thrust/system/cuda/config.h", directory: "")
!6362 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6363, entity: !6365, file: !6366, line: 78)
!6363 = !DINamespace(name: "detail", scope: !6364)
!6364 = !DINamespace(name: "cuda", scope: !829)
!6365 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tag", scope: !6367, file: !6366, line: 59, size: 8, flags: DIFlagTypePassByValue, elements: !6368, identifier: "_ZTSN6thrust8cuda_cub3tagE")
!6366 = !DIFile(filename: "/usr/local/cuda/include/thrust/system/cuda/detail/execution_policy.h", directory: "")
!6367 = !DINamespace(name: "cuda_cub", scope: !744)
!6368 = !{!6369, !6383, !6388}
!6369 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6365, baseType: !6370, extraData: i32 0)
!6370 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy<thrust::cuda_cub::tag>", scope: !6367, file: !6366, line: 54, size: 8, flags: DIFlagTypePassByValue, elements: !6371, templateParams: !6381, identifier: "_ZTSN6thrust8cuda_cub16execution_policyINS0_3tagEEE")
!6371 = !{!6372}
!6372 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6370, baseType: !6373, extraData: i32 0)
!6373 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy<thrust::cuda_cub::tag>", scope: !744, file: !836, line: 72, size: 8, flags: DIFlagTypePassByValue, elements: !6374, templateParams: !6379, identifier: "_ZTSN6thrust16execution_policyINS_8cuda_cub3tagEEE")
!6374 = !{!6375}
!6375 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6373, baseType: !6376, extraData: i32 0)
!6376 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "execution_policy_base<thrust::cuda_cub::tag>", scope: !743, file: !836, line: 43, size: 8, flags: DIFlagTypePassByValue, elements: !6377, templateParams: !6379, identifier: "_ZTSN6thrust6detail21execution_policy_baseINS_8cuda_cub3tagEEE")
!6377 = !{!6378}
!6378 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6376, baseType: !842, extraData: i32 0)
!6379 = !{!6380}
!6380 = !DITemplateTypeParameter(name: "DerivedPolicy", type: !6365)
!6381 = !{!6382}
!6382 = !DITemplateTypeParameter(type: !6365)
!6383 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6365, baseType: !6384, extraData: i32 0)
!6384 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "allocator_aware_execution_policy<cuda_cub::execution_policy>", scope: !743, file: !6385, line: 41, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !6386, identifier: "_ZTSN6thrust6detail32allocator_aware_execution_policyINS_8cuda_cub16execution_policyEEE")
!6385 = !DIFile(filename: "/usr/local/cuda/include/thrust/detail/allocator_aware_execution_policy.h", directory: "")
!6386 = !{!6387}
!6387 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_template_param, name: "ExecutionPolicyCRTPBase", value: !"thrust::cuda_cub::execution_policy")
!6388 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !6365, baseType: !6389, extraData: i32 0)
!6389 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "dependencies_aware_execution_policy<cuda_cub::execution_policy>", scope: !743, file: !6390, line: 34, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !6386, identifier: "_ZTSN6thrust6detail35dependencies_aware_execution_policyINS_8cuda_cub16execution_policyEEE")
!6390 = !DIFile(filename: "/usr/local/cuda/include/thrust/detail/dependencies_aware_execution_policy.h", directory: "")
!6391 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6364, entity: !6365, file: !6366, line: 86)
!6392 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6393, entity: !6365, file: !6366, line: 94)
!6393 = !DINamespace(name: "cuda", scope: !744)
!6394 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !7, entity: !6395, file: !6399, line: 54)
!6395 = !DISubprogram(name: "modf", linkageName: "_ZSt4modfePe", scope: !2, file: !4923, line: 380, type: !6396, flags: DIFlagPrototyped, spFlags: 0)
!6396 = !DISubroutineType(types: !6397)
!6397 = !{!4988, !4988, !6398}
!6398 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4988, size: 64)
!6399 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/math.h", directory: "")
!6400 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6402, file: !6403, line: 38)
!6401 = !DINamespace(name: "complex", scope: !743)
!6402 = !DISubprogram(name: "log", linkageName: "_ZSt3logf", scope: !2, file: !4923, line: 338, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6403 = !DIFile(filename: "/usr/local/cuda/include/thrust/detail/complex/c99math.h", directory: "")
!6404 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6405, file: !6403, line: 39)
!6405 = !DISubprogram(name: "acos", linkageName: "_ZSt4acosf", scope: !2, file: !4923, line: 87, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6406 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6407, file: !6403, line: 40)
!6407 = !DISubprogram(name: "asin", linkageName: "_ZSt4asinf", scope: !2, file: !4923, line: 106, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6408 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6409, file: !6403, line: 41)
!6409 = !DISubprogram(name: "sqrt", linkageName: "_ZSt4sqrtf", scope: !2, file: !4923, line: 463, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6410 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6411, file: !6403, line: 42)
!6411 = !DISubprogram(name: "sinh", linkageName: "_ZSt4sinhf", scope: !2, file: !4923, line: 444, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6412 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6413, file: !6403, line: 43)
!6413 = !DISubprogram(name: "tan", linkageName: "_ZSt3tanf", scope: !2, file: !4923, line: 482, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6414 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6415, file: !6403, line: 44)
!6415 = !DISubprogram(name: "cos", linkageName: "_ZSt3cosf", scope: !2, file: !4923, line: 184, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6416 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6417, file: !6403, line: 45)
!6417 = !DISubprogram(name: "sin", linkageName: "_ZSt3sinf", scope: !2, file: !4923, line: 425, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6418 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6419, file: !6403, line: 46)
!6419 = !DISubprogram(name: "exp", linkageName: "_ZSt3expf", scope: !2, file: !4923, line: 222, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6420 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6421, file: !6403, line: 47)
!6421 = !DISubprogram(name: "cosh", linkageName: "_ZSt4coshf", scope: !2, file: !4923, line: 203, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6422 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6423, file: !6403, line: 48)
!6423 = !DISubprogram(name: "atan", linkageName: "_ZSt4atanf", scope: !2, file: !4923, line: 125, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6424 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6401, entity: !6425, file: !6403, line: 122)
!6425 = !DISubprogram(name: "atanh", linkageName: "_ZSt5atanhf", scope: !2, file: !4923, line: 1250, type: !4735, flags: DIFlagPrototyped, spFlags: 0)
!6426 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !6427, file: !6428, line: 15)
!6427 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "bad_optional_access", scope: !2, file: !249, line: 89, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt19bad_optional_access")
!6428 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/Optional.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6429 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !6430, file: !6428, line: 19)
!6430 = !DIGlobalVariable(name: "nullopt", linkageName: "_ZSt7nullopt", scope: !2, file: !249, line: 82, type: !6431, isLocal: false, isDefinition: false)
!6431 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !250)
!6432 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !250, file: !6428, line: 21)
!6433 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6434, file: !6437, line: 60)
!6434 = !DIDerivedType(tag: DW_TAG_typedef, name: "clock_t", file: !6435, line: 7, baseType: !6436)
!6435 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/clock_t.h", directory: "")
!6436 = !DIDerivedType(tag: DW_TAG_typedef, name: "__clock_t", file: !40, line: 156, baseType: !575)
!6437 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/ctime", directory: "")
!6438 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6439, file: !6437, line: 61)
!6439 = !DIDerivedType(tag: DW_TAG_typedef, name: "time_t", file: !6440, line: 10, baseType: !6441)
!6440 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/time_t.h", directory: "")
!6441 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !40, line: 160, baseType: !575)
!6442 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !5964, file: !6437, line: 62)
!6443 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6444, file: !6437, line: 64)
!6444 = !DISubprogram(name: "clock", scope: !6445, file: !6445, line: 72, type: !6446, flags: DIFlagPrototyped, spFlags: 0)
!6445 = !DIFile(filename: "/usr/include/time.h", directory: "")
!6446 = !DISubroutineType(types: !6447)
!6447 = !{!6434}
!6448 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6449, file: !6437, line: 65)
!6449 = !DISubprogram(name: "difftime", scope: !6445, file: !6445, line: 79, type: !6450, flags: DIFlagPrototyped, spFlags: 0)
!6450 = !DISubroutineType(types: !6451)
!6451 = !{!4871, !6439, !6439}
!6452 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6453, file: !6437, line: 66)
!6453 = !DISubprogram(name: "mktime", scope: !6445, file: !6445, line: 83, type: !6454, flags: DIFlagPrototyped, spFlags: 0)
!6454 = !DISubroutineType(types: !6455)
!6455 = !{!6439, !6456}
!6456 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5964, size: 64)
!6457 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6458, file: !6437, line: 67)
!6458 = !DISubprogram(name: "time", scope: !6445, file: !6445, line: 76, type: !6459, flags: DIFlagPrototyped, spFlags: 0)
!6459 = !DISubroutineType(types: !6460)
!6460 = !{!6439, !6461}
!6461 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6439, size: 64)
!6462 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6463, file: !6437, line: 68)
!6463 = !DISubprogram(name: "asctime", scope: !6445, file: !6445, line: 179, type: !6464, flags: DIFlagPrototyped, spFlags: 0)
!6464 = !DISubroutineType(types: !6465)
!6465 = !{!5292, !5962}
!6466 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6467, file: !6437, line: 69)
!6467 = !DISubprogram(name: "ctime", scope: !6445, file: !6445, line: 183, type: !6468, flags: DIFlagPrototyped, spFlags: 0)
!6468 = !DISubroutineType(types: !6469)
!6469 = !{!5292, !6470}
!6470 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6471, size: 64)
!6471 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6439)
!6472 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6473, file: !6437, line: 70)
!6473 = !DISubprogram(name: "gmtime", scope: !6445, file: !6445, line: 132, type: !6474, flags: DIFlagPrototyped, spFlags: 0)
!6474 = !DISubroutineType(types: !6475)
!6475 = !{!6456, !6470}
!6476 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6477, file: !6437, line: 71)
!6477 = !DISubprogram(name: "localtime", scope: !6445, file: !6445, line: 136, type: !6474, flags: DIFlagPrototyped, spFlags: 0)
!6478 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6479, file: !6437, line: 72)
!6479 = !DISubprogram(name: "strftime", scope: !6445, file: !6445, line: 100, type: !6480, flags: DIFlagPrototyped, spFlags: 0)
!6480 = !DISubroutineType(types: !6481)
!6481 = !{!1288, !5357, !1288, !5314, !5961}
!6482 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6483, file: !6437, line: 79)
!6483 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !6484, line: 11, size: 128, flags: DIFlagTypePassByValue, elements: !6485, identifier: "_ZTS8timespec")
!6484 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h", directory: "")
!6485 = !{!6486, !6487}
!6486 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !6483, file: !6484, line: 16, baseType: !6441, size: 64)
!6487 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !6483, file: !6484, line: 21, baseType: !6488, size: 64, offset: 64)
!6488 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !40, line: 197, baseType: !575)
!6489 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6490, file: !6437, line: 80)
!6490 = !DISubprogram(name: "timespec_get", scope: !6445, file: !6445, line: 371, type: !6491, flags: DIFlagPrototyped, spFlags: 0)
!6491 = !DISubroutineType(types: !6492)
!6492 = !{!256, !6493, !256}
!6493 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6483, size: 64)
!6494 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6495, entity: !6496, file: !6498, line: 3305)
!6495 = !DINamespace(name: "chrono", scope: !2)
!6496 = !DINamespace(name: "chrono_literals", scope: !6497, exportSymbols: true)
!6497 = !DINamespace(name: "literals", scope: !2, exportSymbols: true)
!6498 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/chrono", directory: "")
!6499 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6500, file: !6502, line: 38)
!6500 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "Stream", scope: !36, file: !6501, line: 70, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c106StreamE")
!6501 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/Stream.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6502 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/ATen_fwd.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6503 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6504, file: !6502, line: 39)
!6504 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Storage", scope: !36, file: !6505, line: 25, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c107StorageE")
!6505 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/Storage.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6506 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !259, file: !6502, line: 40)
!6507 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6508, file: !6502, line: 41)
!6508 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "Scalar", scope: !36, file: !6509, line: 34, size: 256, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c106ScalarE")
!6509 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/Scalar.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6510 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !375, file: !6502, line: 42)
!6511 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6512, file: !6502, line: 43)
!6512 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SymIntList", scope: !36, file: !6502, line: 14, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1010SymIntListE")
!6513 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6514, file: !6502, line: 44)
!6514 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "TensorOptions", scope: !36, file: !6515, line: 134, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1013TensorOptionsE")
!6515 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/TensorOptions.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6516 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6517, file: !6519, line: 10)
!6517 = !DIGlobalVariable(name: "kDimVectorStaticSize", linkageName: "_ZN3c10L20kDimVectorStaticSizeE", scope: !36, file: !370, line: 11, type: !6518, isLocal: true, isDefinition: false)
!6518 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1288)
!6519 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/DimVector.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6520 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6521, file: !6519, line: 11)
!6521 = !DIDerivedType(tag: DW_TAG_typedef, name: "DimVector", scope: !36, file: !370, line: 14, baseType: !6522)
!6522 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SmallVector<long, 5>", scope: !36, file: !372, line: 1274, size: 448, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1011SmallVectorIlLj5EEE")
!6523 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6524, file: !6525, line: 23)
!6524 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "CustomClassHolder", scope: !327, file: !6525, line: 21, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN5torch17CustomClassHolderE")
!6525 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/ivalue.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6526 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !1412, file: !6527, line: 60)
!6527 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/Logging.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6528 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6529, file: !6533, line: 15)
!6529 = !DISubprogram(name: "maybe_wrap_dim", linkageName: "_ZN3c1014maybe_wrap_dimENS_6SymIntES0_b", scope: !36, file: !6530, line: 41, type: !6531, flags: DIFlagPrototyped, spFlags: 0)
!6530 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/WrapDimMinimal.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6531 = !DISubroutineType(types: !6532)
!6532 = !{!375, !375, !375, !378}
!6533 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/WrapDimUtils.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6534 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6535, file: !6536, line: 14)
!6535 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "IValue", scope: !36, file: !6525, line: 221, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c106IValueE")
!6536 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/stack.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6537 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !6538, file: !965, line: 63)
!6538 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "CompilationUnit", scope: !3010, file: !6525, line: 25, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN5torch3jit15CompilationUnitE")
!6539 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6540, file: !6541, line: 238)
!6540 = !DISubprogram(name: "registerCustomClass", linkageName: "_ZN5torch19registerCustomClassESt10shared_ptrIN3c109ClassTypeEE", scope: !327, file: !6541, line: 220, type: !6542, flags: DIFlagPrototyped, spFlags: 0)
!6541 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/custom_class_detail.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6542 = !DISubroutineType(types: !6543)
!6543 = !{null, !6544}
!6544 = !DIDerivedType(tag: DW_TAG_typedef, name: "ClassTypePtr", scope: !36, file: !965, line: 62, baseType: !1077)
!6545 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6546, file: !6541, line: 239)
!6546 = !DISubprogram(name: "registerCustomClassMethod", linkageName: "_ZN5torch25registerCustomClassMethodESt10unique_ptrINS_3jit8FunctionESt14default_deleteIS2_EE", scope: !327, file: !6541, line: 221, type: !6547, flags: DIFlagPrototyped, spFlags: 0)
!6547 = !DISubroutineType(types: !6548)
!6548 = !{null, !3290}
!6549 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6550, file: !6553, line: 471)
!6550 = !DISubprogram(name: "getCustomClass", linkageName: "_ZN5torch14getCustomClassERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE", scope: !327, file: !6541, line: 226, type: !6551, flags: DIFlagPrototyped, spFlags: 0)
!6551 = !DISubroutineType(types: !6552)
!6552 = !{!6544, !1410}
!6553 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/custom_class.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6554 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6555, file: !6553, line: 473)
!6555 = !DISubprogram(name: "isCustomClass", linkageName: "_ZN5torch13isCustomClassERKN3c106IValueE", scope: !327, file: !6541, line: 231, type: !6556, flags: DIFlagPrototyped, spFlags: 0)
!6556 = !DISubroutineType(types: !6557)
!6557 = !{!378, !6558}
!6558 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !6559, size: 64)
!6559 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6535)
!6560 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6561, file: !6562, line: 73)
!6561 = !DISubprogram(name: "getAccelerator", linkageName: "_ZN2at11accelerator14getAcceleratorEb", scope: !6563, file: !6562, line: 24, type: !6564, flags: DIFlagPrototyped, spFlags: 0)
!6562 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/DeviceAccelerator.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6563 = !DINamespace(name: "accelerator", scope: !6198)
!6564 = !DISubroutineType(types: !6565)
!6565 = !{!1222, !378}
!6566 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6567, file: !6562, line: 74)
!6567 = !DISubprogram(name: "isAccelerator", linkageName: "_ZN2at11accelerator13isAcceleratorEN3c1010DeviceTypeE", scope: !6563, file: !6562, line: 27, type: !6568, flags: DIFlagPrototyped, spFlags: 0)
!6568 = !DISubroutineType(types: !6569)
!6569 = !{!378, !34}
!6570 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6198, entity: !6571, file: !6576, line: 118)
!6571 = !DISubprogram(name: "check_size_nonnegative", linkageName: "_ZN2at6detail22check_size_nonnegativeEN3c108ArrayRefINS1_6SymIntEEE", scope: !6573, file: !6572, line: 17, type: !6574, flags: DIFlagPrototyped, spFlags: 0)
!6572 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/EmptyTensor.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6573 = !DINamespace(name: "detail", scope: !6198)
!6574 = !DISubroutineType(types: !6575)
!6575 = !{null, !1281}
!6576 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/Utils.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6577 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6578, entity: !6579, file: !6583, line: 41)
!6578 = !DINamespace(name: "autograd", scope: !327)
!6579 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "CompiledNodeArgs", scope: !6581, file: !6580, line: 9, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN5torch6dynamo8autograd16CompiledNodeArgsE")
!6580 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/autograd/function_hook.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6581 = !DINamespace(name: "autograd", scope: !6582)
!6582 = !DINamespace(name: "dynamo", scope: !327)
!6583 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/autograd/function.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6584 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6578, entity: !6585, file: !6583, line: 42)
!6585 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "PackedArgs", scope: !6581, file: !6580, line: 11, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN5torch6dynamo8autograd10PackedArgsE")
!6586 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6578, entity: !6587, file: !6583, line: 43)
!6587 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SwapSavedVariables", scope: !6581, file: !6580, line: 10, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN5torch6dynamo8autograd18SwapSavedVariablesE")
!6588 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6581, entity: !6578, file: !6589, line: 18)
!6589 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/dynamo/compiled_autograd.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6590 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !271, file: !6591, line: 152)
!6591 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/autograd/generated/variable_factories.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6592 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !327, entity: !6198, file: !6593, line: 39)
!6593 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/api/include/torch/types.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6594 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6430, file: !6593, line: 42)
!6595 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !1395, file: !6596, line: 13)
!6596 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/jit/ir/attributes.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6597 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !1395, file: !6598, line: 27)
!6598 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/jit/ir/scope.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6599 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6535, file: !6600, line: 15)
!6600 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/jit/ir/constants.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6601 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6602, file: !6604, line: 31)
!6602 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Argument", scope: !36, file: !6603, line: 28, size: 896, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c108ArgumentE")
!6603 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/function_schema.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6604 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/jit/runtime/operator.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6605 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6606, file: !6604, line: 32)
!6606 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "FunctionSchema", scope: !36, file: !6603, line: 229, size: 960, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1014FunctionSchemaE")
!6607 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !1395, file: !6604, line: 33)
!6608 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6602, file: !6609, line: 42)
!6609 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/jit/ir/ir.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6610 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6606, file: !6609, line: 43)
!6611 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !1395, file: !6609, line: 44)
!6612 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6535, file: !6609, line: 48)
!6613 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6614, file: !6609, line: 49)
!6614 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Future", scope: !6616, file: !6615, line: 841, size: 2176, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c106ivalue6FutureE")
!6615 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/ivalue_inl.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6616 = !DINamespace(name: "ivalue", scope: !36)
!6617 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6618, file: !6609, line: 51)
!6618 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ConstantString", scope: !6616, file: !6615, line: 297, size: 384, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c106ivalue14ConstantStringE")
!6619 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6620, file: !6609, line: 54)
!6620 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AnyType", scope: !36, file: !1582, line: 64, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c107AnyTypeE")
!6621 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !1472, file: !6609, line: 54)
!6622 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6623, file: !6609, line: 54)
!6623 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AnyEnumType", scope: !36, file: !1582, line: 1241, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1011AnyEnumTypeE")
!6624 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !1581, file: !6609, line: 54)
!6625 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6626, file: !6609, line: 54)
!6626 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "StorageType", scope: !36, file: !1582, line: 1476, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1011StorageTypeE")
!6627 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !1732, file: !6609, line: 54)
!6628 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !1882, file: !6609, line: 54)
!6629 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !2032, file: !6609, line: 54)
!6630 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6631, file: !6609, line: 54)
!6631 = !DICompositeType(tag: DW_TAG_structure_type, name: "NumberType", scope: !36, file: !1582, line: 1268, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!6632 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6633, file: !6609, line: 54)
!6633 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "FloatType", scope: !36, file: !1582, line: 1294, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c109FloatTypeE")
!6634 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6635, file: !6609, line: 54)
!6635 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ComplexType", scope: !36, file: !1582, line: 1320, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1011ComplexTypeE")
!6636 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !2140, file: !6609, line: 54)
!6637 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !2248, file: !6609, line: 54)
!6638 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !2356, file: !6609, line: 54)
!6639 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6640, file: !6609, line: 54)
!6640 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "IntType", scope: !36, file: !1582, line: 1410, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c107IntTypeE")
!6641 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6642, file: !6609, line: 54)
!6642 = !DICompositeType(tag: DW_TAG_structure_type, name: "NoneType", scope: !36, file: !1582, line: 1530, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!6643 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6644, file: !6609, line: 54)
!6644 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "StringType", scope: !36, file: !1582, line: 1454, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1010StringTypeE")
!6645 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6646, file: !6609, line: 54)
!6646 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "GeneratorType", scope: !36, file: !1582, line: 1550, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1013GeneratorTypeE")
!6647 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6648, file: !6609, line: 54)
!6648 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "QuantizerType", scope: !36, file: !1582, line: 1568, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1013QuantizerTypeE")
!6649 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6650, file: !6609, line: 54)
!6650 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "BoolType", scope: !36, file: !1582, line: 1436, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c108BoolTypeE")
!6651 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !2464, file: !6609, line: 54)
!6652 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !2572, file: !6609, line: 54)
!6653 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6654, file: !6609, line: 54)
!6654 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "DeviceObjType", scope: !36, file: !1582, line: 1604, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1013DeviceObjTypeE")
!6655 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6656, file: !6609, line: 54)
!6656 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "StreamObjType", scope: !36, file: !1582, line: 1622, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1013StreamObjTypeE")
!6657 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !2680, file: !6609, line: 54)
!6658 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !964, file: !6609, line: 54)
!6659 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6660, file: !6609, line: 54)
!6660 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "PyObjectType", scope: !36, file: !1582, line: 1686, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1012PyObjectTypeE")
!6661 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6662, file: !6609, line: 54)
!6662 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "CapsuleType", scope: !36, file: !1582, line: 1668, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1011CapsuleTypeE")
!6663 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !3361, file: !6609, line: 54)
!6664 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6665, file: !6609, line: 54)
!6665 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "QSchemeType", scope: !36, file: !1582, line: 1586, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1011QSchemeTypeE")
!6666 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6667, file: !6609, line: 54)
!6667 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ScalarTypeType", scope: !36, file: !1582, line: 2244, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1014ScalarTypeTypeE")
!6668 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6669, file: !6609, line: 54)
!6669 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "LayoutType", scope: !36, file: !1582, line: 2272, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1010LayoutTypeE")
!6670 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6671, file: !6609, line: 54)
!6671 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "MemoryFormatType", scope: !36, file: !1582, line: 2258, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016MemoryFormatTypeE")
!6672 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6673, file: !6609, line: 54)
!6673 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AnyListType", scope: !36, file: !1582, line: 2327, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1011AnyListTypeE")
!6674 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6675, file: !6609, line: 54)
!6675 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AnyTupleType", scope: !36, file: !1582, line: 2346, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1012AnyTupleTypeE")
!6676 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6677, file: !6609, line: 54)
!6677 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AnyClassType", scope: !36, file: !1582, line: 2367, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1012AnyClassTypeE")
!6678 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6679, file: !6609, line: 54)
!6679 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "SymIntType", scope: !36, file: !1582, line: 1349, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1010SymIntTypeE")
!6680 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6681, file: !6609, line: 54)
!6681 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "SymFloatType", scope: !36, file: !1582, line: 1369, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1012SymFloatTypeE")
!6682 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6683, file: !6609, line: 54)
!6683 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "SymBoolType", scope: !36, file: !1582, line: 1389, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1011SymBoolTypeE")
!6684 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !2788, file: !6609, line: 54)
!6685 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !2896, file: !6609, line: 54)
!6686 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6687, file: !6609, line: 58)
!6687 = !DIDerivedType(tag: DW_TAG_typedef, name: "AnyTypePtr", scope: !36, file: !1582, line: 61, baseType: !6688)
!6688 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::AnyType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_7AnyTypeEEE")
!6689 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/type_ptr.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6690 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6691, file: !6609, line: 58)
!6691 = !DIDerivedType(tag: DW_TAG_typedef, name: "EnumTypePtr", scope: !36, file: !1473, line: 10, baseType: !1539)
!6692 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6693, file: !6609, line: 58)
!6693 = !DIDerivedType(tag: DW_TAG_typedef, name: "AnyEnumTypePtr", scope: !36, file: !1582, line: 1240, baseType: !6694)
!6694 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::AnyEnumType>", scope: !36, file: !6689, line: 14, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_11AnyEnumTypeEEE")
!6695 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6696, file: !6609, line: 58)
!6696 = !DIDerivedType(tag: DW_TAG_typedef, name: "TensorTypePtr", scope: !36, file: !1582, line: 576, baseType: !1690)
!6697 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6698, file: !6609, line: 58)
!6698 = !DIDerivedType(tag: DW_TAG_typedef, name: "StorageTypePtr", scope: !36, file: !1582, line: 1475, baseType: !6699)
!6699 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::StorageType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_11StorageTypeEEE")
!6700 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6701, file: !6609, line: 58)
!6701 = !DIDerivedType(tag: DW_TAG_typedef, name: "TupleTypePtr", scope: !36, file: !1582, line: 1144, baseType: !1840)
!6702 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6703, file: !6609, line: 58)
!6703 = !DIDerivedType(tag: DW_TAG_typedef, name: "ListTypePtr", scope: !36, file: !1582, line: 868, baseType: !1990)
!6704 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6705, file: !6609, line: 58)
!6705 = !DIDerivedType(tag: DW_TAG_typedef, name: "DictTypePtr", scope: !36, file: !1582, line: 922, baseType: !2098)
!6706 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6707, file: !6609, line: 58)
!6707 = !DIDerivedType(tag: DW_TAG_typedef, name: "NumberTypePtr", scope: !36, file: !1582, line: 1257, baseType: !6708)
!6708 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::NumberType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_10NumberTypeEEE")
!6709 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6710, file: !6609, line: 58)
!6710 = !DIDerivedType(tag: DW_TAG_typedef, name: "FloatTypePtr", scope: !36, file: !1582, line: 1292, baseType: !6711)
!6711 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::FloatType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_9FloatTypeEEE")
!6712 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6713, file: !6609, line: 58)
!6713 = !DIDerivedType(tag: DW_TAG_typedef, name: "ComplexTypePtr", scope: !36, file: !1582, line: 1318, baseType: !6714)
!6714 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::ComplexType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_11ComplexTypeEEE")
!6715 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6716, file: !6609, line: 58)
!6716 = !DIDerivedType(tag: DW_TAG_typedef, name: "FutureTypePtr", scope: !36, file: !1582, line: 1015, baseType: !2206)
!6717 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6718, file: !6609, line: 58)
!6718 = !DIDerivedType(tag: DW_TAG_typedef, name: "AwaitTypePtr", scope: !36, file: !1582, line: 1057, baseType: !2314)
!6719 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6720, file: !6609, line: 58)
!6720 = !DIDerivedType(tag: DW_TAG_typedef, name: "RRefTypePtr", scope: !36, file: !1582, line: 1099, baseType: !2422)
!6721 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6722, file: !6609, line: 58)
!6722 = !DIDerivedType(tag: DW_TAG_typedef, name: "IntTypePtr", scope: !36, file: !1582, line: 1408, baseType: !6723)
!6723 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::IntType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_7IntTypeEEE")
!6724 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6725, file: !6609, line: 58)
!6725 = !DIDerivedType(tag: DW_TAG_typedef, name: "NoneTypePtr", scope: !36, file: !1582, line: 1528, baseType: !6726)
!6726 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::NoneType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_8NoneTypeEEE")
!6727 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6728, file: !6609, line: 58)
!6728 = !DIDerivedType(tag: DW_TAG_typedef, name: "StringTypePtr", scope: !36, file: !1582, line: 1452, baseType: !6729)
!6729 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::StringType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_10StringTypeEEE")
!6730 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6731, file: !6609, line: 58)
!6731 = !DIDerivedType(tag: DW_TAG_typedef, name: "GeneratorTypePtr", scope: !36, file: !1582, line: 1548, baseType: !6732)
!6732 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::GeneratorType>", scope: !36, file: !6689, line: 14, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_13GeneratorTypeEEE")
!6733 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6734, file: !6609, line: 58)
!6734 = !DIDerivedType(tag: DW_TAG_typedef, name: "QuantizerTypePtr", scope: !36, file: !1582, line: 1566, baseType: !6735)
!6735 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::QuantizerType>", scope: !36, file: !6689, line: 14, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_13QuantizerTypeEEE")
!6736 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6737, file: !6609, line: 58)
!6737 = !DIDerivedType(tag: DW_TAG_typedef, name: "BoolTypePtr", scope: !36, file: !1582, line: 1434, baseType: !6738)
!6738 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::BoolType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_8BoolTypeEEE")
!6739 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6740, file: !6609, line: 58)
!6740 = !DIDerivedType(tag: DW_TAG_typedef, name: "OptionalTypePtr", scope: !36, file: !1582, line: 187, baseType: !2530)
!6741 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6742, file: !6609, line: 58)
!6742 = !DIDerivedType(tag: DW_TAG_typedef, name: "VarTypePtr", scope: !36, file: !1582, line: 1638, baseType: !2638)
!6743 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6744, file: !6609, line: 58)
!6744 = !DIDerivedType(tag: DW_TAG_typedef, name: "DeviceObjTypePtr", scope: !36, file: !1582, line: 1602, baseType: !6745)
!6745 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::DeviceObjType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_13DeviceObjTypeEEE")
!6746 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6747, file: !6609, line: 58)
!6747 = !DIDerivedType(tag: DW_TAG_typedef, name: "StreamObjTypePtr", scope: !36, file: !1582, line: 1620, baseType: !6748)
!6748 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::StreamObjType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_13StreamObjTypeEEE")
!6749 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6750, file: !6609, line: 58)
!6750 = !DIDerivedType(tag: DW_TAG_typedef, name: "FunctionTypePtr", scope: !36, file: !1582, line: 1496, baseType: !2746)
!6751 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6544, file: !6609, line: 58)
!6752 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6753, file: !6609, line: 58)
!6753 = !DIDerivedType(tag: DW_TAG_typedef, name: "PyObjectTypePtr", scope: !36, file: !1582, line: 1684, baseType: !6754)
!6754 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::PyObjectType>", scope: !36, file: !6689, line: 14, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_12PyObjectTypeEEE")
!6755 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6756, file: !6609, line: 58)
!6756 = !DIDerivedType(tag: DW_TAG_typedef, name: "CapsuleTypePtr", scope: !36, file: !1582, line: 1665, baseType: !6757)
!6757 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::CapsuleType>", scope: !36, file: !6689, line: 14, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_11CapsuleTypeEEE")
!6758 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6759, file: !6609, line: 58)
!6759 = !DIDerivedType(tag: DW_TAG_typedef, name: "InterfaceTypePtr", scope: !36, file: !1582, line: 2165, baseType: !3469)
!6760 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6761, file: !6609, line: 58)
!6761 = !DIDerivedType(tag: DW_TAG_typedef, name: "QSchemeTypePtr", scope: !36, file: !1582, line: 1584, baseType: !6762)
!6762 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::QSchemeType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_11QSchemeTypeEEE")
!6763 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6764, file: !6609, line: 58)
!6764 = !DIDerivedType(tag: DW_TAG_typedef, name: "ScalarTypeTypePtr", scope: !36, file: !1582, line: 2243, baseType: !6765)
!6765 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::ScalarTypeType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_14ScalarTypeTypeEEE")
!6766 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6767, file: !6609, line: 58)
!6767 = !DIDerivedType(tag: DW_TAG_typedef, name: "LayoutTypePtr", scope: !36, file: !1582, line: 2271, baseType: !6768)
!6768 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::LayoutType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_10LayoutTypeEEE")
!6769 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6770, file: !6609, line: 58)
!6770 = !DIDerivedType(tag: DW_TAG_typedef, name: "MemoryFormatTypePtr", scope: !36, file: !1582, line: 2257, baseType: !6771)
!6771 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::MemoryFormatType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_16MemoryFormatTypeEEE")
!6772 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6773, file: !6609, line: 58)
!6773 = !DIDerivedType(tag: DW_TAG_typedef, name: "AnyListTypePtr", scope: !36, file: !1582, line: 2326, baseType: !6774)
!6774 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::AnyListType>", scope: !36, file: !6689, line: 14, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_11AnyListTypeEEE")
!6775 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6776, file: !6609, line: 58)
!6776 = !DIDerivedType(tag: DW_TAG_typedef, name: "AnyTupleTypePtr", scope: !36, file: !1582, line: 2345, baseType: !6777)
!6777 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::AnyTupleType>", scope: !36, file: !6689, line: 14, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_12AnyTupleTypeEEE")
!6778 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6779, file: !6609, line: 58)
!6779 = !DIDerivedType(tag: DW_TAG_typedef, name: "AnyClassTypePtr", scope: !36, file: !1582, line: 2366, baseType: !6780)
!6780 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::AnyClassType>", scope: !36, file: !6689, line: 14, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_12AnyClassTypeEEE")
!6781 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6782, file: !6609, line: 58)
!6782 = !DIDerivedType(tag: DW_TAG_typedef, name: "SymIntTypePtr", scope: !36, file: !1582, line: 1348, baseType: !6783)
!6783 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::SymIntType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_10SymIntTypeEEE")
!6784 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6785, file: !6609, line: 58)
!6785 = !DIDerivedType(tag: DW_TAG_typedef, name: "SymFloatTypePtr", scope: !36, file: !1582, line: 1368, baseType: !6786)
!6786 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::SymFloatType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_12SymFloatTypeEEE")
!6787 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6788, file: !6609, line: 58)
!6788 = !DIDerivedType(tag: DW_TAG_typedef, name: "SymBoolTypePtr", scope: !36, file: !1582, line: 1388, baseType: !6789)
!6789 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonTypePtr<c10::SymBoolType>", scope: !36, file: !6689, line: 14, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1016SingletonTypePtrINS_11SymBoolTypeEEE")
!6790 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6791, file: !6609, line: 58)
!6791 = !DIDerivedType(tag: DW_TAG_typedef, name: "UnionTypePtr", scope: !36, file: !1582, line: 130, baseType: !2854)
!6792 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6793, file: !6609, line: 58)
!6793 = !DIDerivedType(tag: DW_TAG_typedef, name: "DynamicTypePtr", scope: !36, file: !2897, line: 75, baseType: !2963)
!6794 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6795, file: !6609, line: 61)
!6795 = !DICompositeType(tag: DW_TAG_structure_type, name: "Type", scope: !36, file: !280, line: 146, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!6796 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6797, file: !6609, line: 62)
!6797 = !DIDerivedType(tag: DW_TAG_typedef, name: "TypeEnv", scope: !36, file: !1582, line: 2128, baseType: !6798)
!6798 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "unordered_map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, c10::Type::SingletonOrSharedTypePtr<c10::Type>, std::hash<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, std::equal_to<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, c10::Type::SingletonOrSharedTypePtr<c10::Type> > > >", scope: !2, file: !6799, line: 102, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt13unordered_mapINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEN3c104Type24SingletonOrSharedTypePtrIS7_EESt4hashIS5_ESt8equal_toIS5_ESaISt4pairIKS5_S9_EEE")
!6799 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/unordered_map.h", directory: "")
!6800 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6801, file: !6609, line: 63)
!6801 = !DIDerivedType(tag: DW_TAG_typedef, name: "TypePtr", scope: !36, file: !280, line: 650, baseType: !6802)
!6802 = !DIDerivedType(tag: DW_TAG_typedef, name: "SingletonOrSharedTypePtr<c10::Type>", scope: !36, file: !280, line: 597, baseType: !6803)
!6803 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SingletonOrSharedTypePtr<c10::Type>", scope: !6795, file: !280, line: 171, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c104Type24SingletonOrSharedTypePtrIS0_EE")
!6804 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6805, file: !6609, line: 66)
!6805 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "MatchTypeReturn", scope: !36, file: !1582, line: 2129, size: 320, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1015MatchTypeReturnE")
!6806 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !279, file: !6609, line: 67)
!6807 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6808, entity: !6809, file: !6609, line: 72)
!6808 = !DINamespace(name: "prim", scope: !3010)
!6809 = !DINamespace(name: "prim", scope: !36)
!6810 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6811, entity: !6812, file: !6609, line: 75)
!6811 = !DINamespace(name: "attr", scope: !3010)
!6812 = !DINamespace(name: "attr", scope: !36)
!6813 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6814, entity: !6815, file: !6609, line: 78)
!6814 = !DINamespace(name: "aten", scope: !3010)
!6815 = !DINamespace(name: "aten", scope: !36)
!6816 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !6817, entity: !6201, file: !6609, line: 82)
!6817 = !DINamespace(name: "cuda", scope: !3010)
!6818 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6614, file: !6819, line: 40)
!6819 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/jit/runtime/interpreter.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6820 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6602, file: !6821, line: 37)
!6821 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/jit/api/module.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6822 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6606, file: !6821, line: 38)
!6823 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !6824, file: !6821, line: 39)
!6824 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "QualifiedName", scope: !36, file: !6825, line: 12, size: 960, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1013QualifiedNameE")
!6825 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/qualified_name.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6826 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6827, file: !6829, line: 19)
!6827 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "Tensor", scope: !6198, file: !6828, line: 92, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN2at6TensorE")
!6828 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/TensorBody.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6829 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/api/include/torch/serialize/input-archive.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6830 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6827, file: !6831, line: 16)
!6831 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/api/include/torch/serialize/output-archive.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6832 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6833, entity: !323, file: !6834, line: 9)
!6833 = !DINamespace(name: "profiler", scope: !6578)
!6834 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/profiler/api.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6835 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6833, entity: !6836, file: !6834, line: 10)
!6836 = !DISubprogram(name: "getProfilerConfig", linkageName: "_ZN5torch8profiler4impl17getProfilerConfigEv", scope: !325, file: !324, line: 196, type: !6837, flags: DIFlagPrototyped, spFlags: 0)
!6837 = !DISubroutineType(types: !6838)
!6838 = !{!6839}
!6839 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ProfilerConfig", scope: !325, file: !324, line: 117, size: 896, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN5torch8profiler4impl14ProfilerConfigE")
!6840 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6833, entity: !6839, file: !6834, line: 11)
!6841 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6833, entity: !6842, file: !6834, line: 12)
!6842 = !DISubprogram(name: "profilerEnabled", linkageName: "_ZN5torch8profiler4impl15profilerEnabledEv", scope: !325, file: !324, line: 194, type: !3190, flags: DIFlagPrototyped, spFlags: 0)
!6843 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6833, entity: !336, file: !6834, line: 13)
!6844 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6845, file: !6849, line: 74)
!6845 = !DISubprogram(name: "manual_seed", linkageName: "_ZN2at11manual_seedEm", scope: !6198, file: !6846, line: 590, type: !6847, flags: DIFlagPrototyped, spFlags: 0)
!6846 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/Context.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6847 = !DISubroutineType(types: !6848)
!6848 = !{null, !5784}
!6849 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/api/include/torch/utils.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6850 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6851, file: !6849, line: 77)
!6851 = !DISubprogram(name: "init_num_threads", linkageName: "_ZN2at16init_num_threadsEv", scope: !6198, file: !6852, line: 14, type: !5243, flags: DIFlagPrototyped, spFlags: 0)
!6852 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/Parallel.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6853 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6854, file: !6849, line: 80)
!6854 = !DISubprogram(name: "get_num_threads", linkageName: "_ZN2at15get_num_threadsEv", scope: !6198, file: !6852, line: 20, type: !5327, flags: DIFlagPrototyped, spFlags: 0)
!6855 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6856, file: !6849, line: 83)
!6856 = !DISubprogram(name: "set_num_threads", linkageName: "_ZN2at15set_num_threadsEi", scope: !6198, file: !6852, line: 17, type: !5282, flags: DIFlagPrototyped, spFlags: 0)
!6857 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6858, file: !6849, line: 86)
!6858 = !DISubprogram(name: "get_num_interop_threads", linkageName: "_ZN2at23get_num_interop_threadsEv", scope: !6198, file: !6852, line: 136, type: !6859, flags: DIFlagPrototyped, spFlags: 0)
!6859 = !DISubroutineType(types: !6860)
!6860 = !{!1288}
!6861 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6862, file: !6849, line: 89)
!6862 = !DISubprogram(name: "set_num_interop_threads", linkageName: "_ZN2at23set_num_interop_threadsEi", scope: !6198, file: !6852, line: 133, type: !5282, flags: DIFlagPrototyped, spFlags: 0)
!6863 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6864, file: !6849, line: 99)
!6864 = !DISubprogram(name: "addGlobalCallback", linkageName: "_ZN2at17addGlobalCallbackENS_22RecordFunctionCallbackE", scope: !6198, file: !6865, line: 715, type: !6866, flags: DIFlagPrototyped, spFlags: 0)
!6865 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/record_function.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6866 = !DISubroutineType(types: !6867)
!6867 = !{!6868, !6869}
!6868 = !DIDerivedType(tag: DW_TAG_typedef, name: "CallbackHandle", scope: !6198, file: !6865, line: 238, baseType: !5784)
!6869 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "RecordFunctionCallback", scope: !6198, file: !6865, line: 128, size: 320, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN2at22RecordFunctionCallbackE")
!6870 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6871, file: !6849, line: 100)
!6871 = !DISubprogram(name: "addThreadLocalCallback", linkageName: "_ZN2at22addThreadLocalCallbackENS_22RecordFunctionCallbackE", scope: !6198, file: !6865, line: 697, type: !6866, flags: DIFlagPrototyped, spFlags: 0)
!6872 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6868, file: !6849, line: 101)
!6873 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6874, file: !6849, line: 102)
!6874 = !DISubprogram(name: "clearCallbacks", linkageName: "_ZN2at14clearCallbacksEv", scope: !6198, file: !6865, line: 750, type: !5243, flags: DIFlagPrototyped, spFlags: 0)
!6875 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6876, file: !6849, line: 103)
!6876 = !DISubprogram(name: "clearGlobalCallbacks", linkageName: "_ZN2at20clearGlobalCallbacksEv", scope: !6198, file: !6865, line: 746, type: !5243, flags: DIFlagPrototyped, spFlags: 0)
!6877 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6878, file: !6849, line: 104)
!6878 = !DISubprogram(name: "clearThreadLocalCallbacks", linkageName: "_ZN2at25clearThreadLocalCallbacksEv", scope: !6198, file: !6865, line: 708, type: !5243, flags: DIFlagPrototyped, spFlags: 0)
!6879 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6880, file: !6849, line: 105)
!6880 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "DisableRecordFunctionGuard", scope: !6198, file: !6865, line: 782, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN2at26DisableRecordFunctionGuardE")
!6881 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6882, file: !6849, line: 106)
!6882 = !DISubprogram(name: "enableRecordFunction", linkageName: "_ZN2at20enableRecordFunctionEb", scope: !6198, file: !6865, line: 755, type: !6883, flags: DIFlagPrototyped, spFlags: 0)
!6883 = !DISubroutineType(types: !6884)
!6884 = !{null, !378}
!6885 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6886, file: !6849, line: 107)
!6886 = !DISubprogram(name: "hasCallbacks", linkageName: "_ZN2at12hasCallbacksEv", scope: !6198, file: !6865, line: 749, type: !3190, flags: DIFlagPrototyped, spFlags: 0)
!6887 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6888, file: !6849, line: 108)
!6888 = !DISubprogram(name: "hasGlobalCallbacks", linkageName: "_ZN2at18hasGlobalCallbacksEv", scope: !6198, file: !6865, line: 741, type: !3190, flags: DIFlagPrototyped, spFlags: 0)
!6889 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6890, file: !6849, line: 109)
!6890 = !DISubprogram(name: "hasThreadLocalCallbacks", linkageName: "_ZN2at23hasThreadLocalCallbacksEv", scope: !6198, file: !6865, line: 703, type: !3190, flags: DIFlagPrototyped, spFlags: 0)
!6891 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6892, file: !6849, line: 110)
!6892 = !DISubprogram(name: "isRecordFunctionEnabled", linkageName: "_ZN2at23isRecordFunctionEnabledEv", scope: !6198, file: !6865, line: 761, type: !3190, flags: DIFlagPrototyped, spFlags: 0)
!6893 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6894, file: !6849, line: 111)
!6894 = !DICompositeType(tag: DW_TAG_structure_type, name: "RecordFunction", scope: !6198, file: !6865, line: 282, size: 2752, flags: DIFlagFwdDecl | DIFlagNonTrivial)
!6895 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6869, file: !6849, line: 112)
!6896 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6897, file: !6849, line: 113)
!6897 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "RecordFunctionGuard", scope: !6198, file: !6865, line: 763, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN2at19RecordFunctionGuardE")
!6898 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6899, file: !6849, line: 114)
!6899 = !DISubprogram(name: "removeCallback", linkageName: "_ZN2at14removeCallbackEm", scope: !6198, file: !6865, line: 723, type: !6900, flags: DIFlagPrototyped, spFlags: 0)
!6900 = !DISubroutineType(types: !6901)
!6901 = !{null, !6868}
!6902 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !6827, file: !6903, line: 24)
!6903 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/torch/csrc/api/include/torch/optim/optimizer.h", directory: "/home/mvh6224/CUDA-BOSolver")
!6904 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !8, producer: "Ubuntu clang version 13.0.1-2ubuntu2.2", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !6905, retainedTypes: !6906, imports: !6994, splitDebugInlining: false, nameTableKind: None)
!6905 = !{!10, !34, !65, !73, !248, !259, !271, !279, !323, !336}
!6906 = !{!37, !734, !741, !786, !825, !250, !852, !867, !915, !954, !1077, !1110, !1111, !1169, !1177, !1222, !1281, !1310, !1395, !1462, !1539, !1571, !1690, !1722, !1840, !1872, !1990, !2022, !2098, !2130, !2206, !2238, !2314, !2346, !2422, !2454, !2530, !2562, !2638, !2670, !2746, !2778, !2854, !2886, !2963, !2995, !3013, !3037, !3068, !3104, !3139, !3186, !3228, !3277, !3290, !3351, !3469, !1643, !1943, !1030, !3422, !1793, !3501, !6907, !6938, !6966}
!6907 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__cuda_builtin_threadIdx_t", file: !6908, line: 52, size: 8, flags: DIFlagTypePassByReference, elements: !6909, identifier: "_ZTS26__cuda_builtin_threadIdx_t")
!6908 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/__clang_cuda_builtin_vars.h", directory: "")
!6909 = !{!6910, !6913, !6914, !6915, !6920, !6923, !6927, !6931, !6934}
!6910 = !DISubprogram(name: "__fetch_builtin_x", linkageName: "_ZN26__cuda_builtin_threadIdx_t17__fetch_builtin_xEv", scope: !6907, file: !6908, line: 53, type: !6911, scopeLine: 53, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!6911 = !DISubroutineType(types: !6912)
!6912 = !{!68}
!6913 = !DISubprogram(name: "__fetch_builtin_y", linkageName: "_ZN26__cuda_builtin_threadIdx_t17__fetch_builtin_yEv", scope: !6907, file: !6908, line: 54, type: !6911, scopeLine: 54, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!6914 = !DISubprogram(name: "__fetch_builtin_z", linkageName: "_ZN26__cuda_builtin_threadIdx_t17__fetch_builtin_zEv", scope: !6907, file: !6908, line: 55, type: !6911, scopeLine: 55, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!6915 = !DISubprogram(name: "operator dim3", linkageName: "_ZNK26__cuda_builtin_threadIdx_tcv4dim3Ev", scope: !6907, file: !6908, line: 58, type: !6916, scopeLine: 58, flags: DIFlagPrototyped, spFlags: 0)
!6916 = !DISubroutineType(types: !6917)
!6917 = !{!3501, !6918}
!6918 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6919, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!6919 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6907)
!6920 = !DISubprogram(name: "operator uint3", linkageName: "_ZNK26__cuda_builtin_threadIdx_tcv5uint3Ev", scope: !6907, file: !6908, line: 59, type: !6921, scopeLine: 59, flags: DIFlagPrototyped, spFlags: 0)
!6921 = !DISubroutineType(types: !6922)
!6922 = !{!3515, !6918}
!6923 = !DISubprogram(name: "__cuda_builtin_threadIdx_t", scope: !6907, file: !6908, line: 62, type: !6924, scopeLine: 62, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!6924 = !DISubroutineType(types: !6925)
!6925 = !{null, !6926}
!6926 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6907, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!6927 = !DISubprogram(name: "__cuda_builtin_threadIdx_t", scope: !6907, file: !6908, line: 62, type: !6928, scopeLine: 62, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!6928 = !DISubroutineType(types: !6929)
!6929 = !{null, !6926, !6930}
!6930 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !6919, size: 64)
!6931 = !DISubprogram(name: "operator=", linkageName: "_ZNK26__cuda_builtin_threadIdx_taSERKS_", scope: !6907, file: !6908, line: 62, type: !6932, scopeLine: 62, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!6932 = !DISubroutineType(types: !6933)
!6933 = !{null, !6918, !6930}
!6934 = !DISubprogram(name: "operator&", linkageName: "_ZNK26__cuda_builtin_threadIdx_tadEv", scope: !6907, file: !6908, line: 62, type: !6935, scopeLine: 62, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: 0)
!6935 = !DISubroutineType(types: !6936)
!6936 = !{!6937, !6918}
!6937 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6907, size: 64)
!6938 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__cuda_builtin_blockIdx_t", file: !6908, line: 65, size: 8, flags: DIFlagTypePassByReference, elements: !6939, identifier: "_ZTS25__cuda_builtin_blockIdx_t")
!6939 = !{!6940, !6941, !6942, !6943, !6948, !6951, !6955, !6959, !6962}
!6940 = !DISubprogram(name: "__fetch_builtin_x", linkageName: "_ZN25__cuda_builtin_blockIdx_t17__fetch_builtin_xEv", scope: !6938, file: !6908, line: 66, type: !6911, scopeLine: 66, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!6941 = !DISubprogram(name: "__fetch_builtin_y", linkageName: "_ZN25__cuda_builtin_blockIdx_t17__fetch_builtin_yEv", scope: !6938, file: !6908, line: 67, type: !6911, scopeLine: 67, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!6942 = !DISubprogram(name: "__fetch_builtin_z", linkageName: "_ZN25__cuda_builtin_blockIdx_t17__fetch_builtin_zEv", scope: !6938, file: !6908, line: 68, type: !6911, scopeLine: 68, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!6943 = !DISubprogram(name: "operator dim3", linkageName: "_ZNK25__cuda_builtin_blockIdx_tcv4dim3Ev", scope: !6938, file: !6908, line: 71, type: !6944, scopeLine: 71, flags: DIFlagPrototyped, spFlags: 0)
!6944 = !DISubroutineType(types: !6945)
!6945 = !{!3501, !6946}
!6946 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6947, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!6947 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6938)
!6948 = !DISubprogram(name: "operator uint3", linkageName: "_ZNK25__cuda_builtin_blockIdx_tcv5uint3Ev", scope: !6938, file: !6908, line: 72, type: !6949, scopeLine: 72, flags: DIFlagPrototyped, spFlags: 0)
!6949 = !DISubroutineType(types: !6950)
!6950 = !{!3515, !6946}
!6951 = !DISubprogram(name: "__cuda_builtin_blockIdx_t", scope: !6938, file: !6908, line: 75, type: !6952, scopeLine: 75, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!6952 = !DISubroutineType(types: !6953)
!6953 = !{null, !6954}
!6954 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6938, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!6955 = !DISubprogram(name: "__cuda_builtin_blockIdx_t", scope: !6938, file: !6908, line: 75, type: !6956, scopeLine: 75, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!6956 = !DISubroutineType(types: !6957)
!6957 = !{null, !6954, !6958}
!6958 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !6947, size: 64)
!6959 = !DISubprogram(name: "operator=", linkageName: "_ZNK25__cuda_builtin_blockIdx_taSERKS_", scope: !6938, file: !6908, line: 75, type: !6960, scopeLine: 75, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!6960 = !DISubroutineType(types: !6961)
!6961 = !{null, !6946, !6958}
!6962 = !DISubprogram(name: "operator&", linkageName: "_ZNK25__cuda_builtin_blockIdx_tadEv", scope: !6938, file: !6908, line: 75, type: !6963, scopeLine: 75, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: 0)
!6963 = !DISubroutineType(types: !6964)
!6964 = !{!6965, !6946}
!6965 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6938, size: 64)
!6966 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__cuda_builtin_blockDim_t", file: !6908, line: 78, size: 8, flags: DIFlagTypePassByReference, elements: !6967, identifier: "_ZTS25__cuda_builtin_blockDim_t")
!6967 = !{!6968, !6969, !6970, !6971, !6976, !6979, !6983, !6987, !6990}
!6968 = !DISubprogram(name: "__fetch_builtin_x", linkageName: "_ZN25__cuda_builtin_blockDim_t17__fetch_builtin_xEv", scope: !6966, file: !6908, line: 79, type: !6911, scopeLine: 79, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!6969 = !DISubprogram(name: "__fetch_builtin_y", linkageName: "_ZN25__cuda_builtin_blockDim_t17__fetch_builtin_yEv", scope: !6966, file: !6908, line: 80, type: !6911, scopeLine: 80, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!6970 = !DISubprogram(name: "__fetch_builtin_z", linkageName: "_ZN25__cuda_builtin_blockDim_t17__fetch_builtin_zEv", scope: !6966, file: !6908, line: 81, type: !6911, scopeLine: 81, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!6971 = !DISubprogram(name: "operator dim3", linkageName: "_ZNK25__cuda_builtin_blockDim_tcv4dim3Ev", scope: !6966, file: !6908, line: 84, type: !6972, scopeLine: 84, flags: DIFlagPrototyped, spFlags: 0)
!6972 = !DISubroutineType(types: !6973)
!6973 = !{!3501, !6974}
!6974 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6975, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!6975 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6966)
!6976 = !DISubprogram(name: "operator uint3", linkageName: "_ZNK25__cuda_builtin_blockDim_tcv5uint3Ev", scope: !6966, file: !6908, line: 85, type: !6977, scopeLine: 85, flags: DIFlagPrototyped, spFlags: 0)
!6977 = !DISubroutineType(types: !6978)
!6978 = !{!3515, !6974}
!6979 = !DISubprogram(name: "__cuda_builtin_blockDim_t", scope: !6966, file: !6908, line: 88, type: !6980, scopeLine: 88, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!6980 = !DISubroutineType(types: !6981)
!6981 = !{null, !6982}
!6982 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6966, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!6983 = !DISubprogram(name: "__cuda_builtin_blockDim_t", scope: !6966, file: !6908, line: 88, type: !6984, scopeLine: 88, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!6984 = !DISubroutineType(types: !6985)
!6985 = !{null, !6982, !6986}
!6986 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !6975, size: 64)
!6987 = !DISubprogram(name: "operator=", linkageName: "_ZNK25__cuda_builtin_blockDim_taSERKS_", scope: !6966, file: !6908, line: 88, type: !6988, scopeLine: 88, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: DISPFlagDeleted)
!6988 = !DISubroutineType(types: !6989)
!6989 = !{null, !6974, !6986}
!6990 = !DISubprogram(name: "operator&", linkageName: "_ZNK25__cuda_builtin_blockDim_tadEv", scope: !6966, file: !6908, line: 88, type: !6991, scopeLine: 88, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: 0)
!6991 = !DISubroutineType(types: !6992)
!6992 = !{!6993, !6974}
!6993 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6966, size: 64)
!6994 = !{!4728, !4733, !4738, !4740, !4742, !4744, !4746, !4750, !4752, !4754, !4756, !4758, !4760, !4762, !4764, !4766, !4768, !4770, !4772, !4774, !4776, !4778, !4782, !4784, !4786, !4788, !4792, !4797, !4799, !4801, !4805, !4809, !4811, !4813, !4815, !4817, !4819, !4821, !4823, !4825, !4829, !4833, !4835, !4840, !4844, !4846, !4848, !4850, !4852, !4854, !4858, !4860, !4862, !4867, !4872, !4876, !4878, !4880, !4882, !4884, !4888, !4890, !4892, !4896, !4898, !4900, !4902, !4904, !4906, !4908, !4910, !4912, !4914, !4918, !4924, !4926, !4928, !4932, !4934, !4936, !4938, !4940, !4942, !4944, !4946, !4950, !4954, !4956, !4958, !4963, !4965, !4967, !4969, !4971, !4973, !4975, !4978, !4980, !4982, !6995, !4989, !4991, !7000, !4995, !4997, !7002, !5001, !5003, !7004, !5007, !5009, !7006, !5015, !5017, !7010, !5021, !5023, !7012, !5027, !5029, !7014, !5033, !5035, !7016, !5039, !5041, !7018, !5045, !5049, !7020, !5055, !5057, !7024, !5061, !5063, !7026, !5067, !5069, !7028, !5073, !5077, !7030, !5083, !5085, !7034, !5089, !5093, !7036, !5099, !5101, !7040, !5105, !5107, !7042, !5111, !5113, !7044, !5117, !5119, !7046, !5123, !5127, !7048, !5133, !5135, !7052, !5139, !5141, !7054, !5147, !5149, !7058, !5153, !5155, !7060, !7062, !7066, !7070, !5169, !5171, !7072, !5175, !5179, !7074, !5185, !5187, !7078, !5191, !5193, !7080, !5197, !5201, !7082, !5207, !5209, !7086, !5215, !5217, !7090, !5221, !5223, !7092, !5227, !5231, !5235, !5241, !5245, !5249, !5254, !5256, !5258, !5262, !5266, !5274, !5276, !5280, !5284, !5288, !5293, !5295, !5299, !5303, !5307, !5315, !5319, !5323, !5325, !5329, !5333, !5337, !5343, !5347, !5351, !5353, !5361, !5365, !5371, !5373, !5375, !5379, !5383, !5387, !5391, !7094, !5399, !5400, !5401, !5402, !5404, !5405, !5406, !5407, !5408, !7098, !7099, !7100, !7101, !7102, !7103, !7104, !7105, !7106, !7108, !7109, !7110, !7111, !7112, !7113, !7114, !7115, !7116, !7117, !7118, !7119, !7120, !7121, !7122, !7123, !7124, !7125, !7126, !7127, !7128, !7129, !7130, !7131, !5444, !5448, !5450, !5452, !5454, !5456, !5458, !5460, !5462, !5464, !5466, !5468, !5470, !5472, !5474, !5476, !5478, !5480, !5482, !5484, !5486, !5488, !5490, !5492, !5494, !5496, !5498, !5500, !5502, !5504, !5506, !5508, !5510, !5512, !5514, !5516, !5518, !5520, !5522, !5524, !5526, !5528, !5530, !5532, !5534, !5536, !5538, !5540, !5542, !5544, !5546, !5548, !5550, !5552, !5554, !5556, !5557, !5558, !5562, !5564, !5570, !5576, !5581, !5585, !5587, !5589, !5591, !5593, !5600, !5604, !5608, !5612, !5616, !5620, !5625, !5629, !5631, !5635, !5641, !5645, !5650, !5652, !5654, !5658, !5662, !5664, !5666, !5668, !5670, !5674, !5676, !5678, !5682, !5686, !5690, !5694, !5698, !5702, !7132, !7139, !7143, !5724, !7147, !7149, !7151, !7155, !5740, !7159, !7160, !7161, !7162, !5745, !5747, !5750, !5753, !5754, !5757, !5759, !5761, !5763, !5766, !5769, !5772, !5775, !5778, !5780, !5781, !5782, !5783, !5786, !5788, !5790, !5792, !5794, !5797, !5800, !5803, !5806, !5809, !5811, !5816, !5833, !5836, !5841, !5848, !5853, !5857, !5861, !5865, !5869, !5871, !5873, !5877, !5883, !5887, !5893, !5899, !5901, !5905, !5909, !5913, !7163, !7167, !7169, !7173, !7177, !7181, !5937, !5941, !5945, !5949, !5951, !5953, !5957, !5978, !5982, !5986, !5990, !5992, !5998, !6000, !6006, !6010, !6014, !6018, !6022, !6026, !6030, !6032, !6034, !6038, !6042, !6046, !6048, !6052, !6056, !6058, !6060, !7183, !6068, !6072, !7187, !6077, !6078, !6079, !7188, !7189, !7190, !7191, !6084, !6085, !6086, !6090, !6094, !6098, !6102, !6107, !6111, !6113, !6115, !6117, !6119, !6121, !6123, !6125, !6127, !6129, !6131, !6133, !6135, !6137, !6143, !6146, !6147, !6149, !6151, !6153, !6155, !6159, !6161, !6163, !6165, !6167, !6169, !6171, !6173, !6175, !6179, !6183, !6185, !6189, !6193, !6194, !6197, !6199, !6202, !6204, !6207, !6208, !6211, !6222, !6226, !6230, !7192, !6238, !6241, !6247, !6251, !6256, !6258, !6262, !6266, !6268, !6270, !6272, !6276, !6280, !6284, !6288, !6292, !6294, !6296, !6298, !6302, !6306, !6310, !6312, !6314, !6320, !6321, !6322, !6324, !6326, !6356, !6358, !6362, !6391, !6392, !7196, !6400, !6404, !6406, !6408, !6410, !6412, !6414, !6416, !6418, !6420, !6422, !6424, !6426, !6429, !6432, !6433, !6438, !6442, !6443, !6448, !6452, !6457, !6462, !6466, !6472, !6476, !6478, !6482, !6489, !6494, !6499, !6503, !6506, !6507, !6510, !6511, !6513, !6516, !6520, !6523, !6526, !6528, !6534, !6537, !6539, !6545, !6549, !6554, !6560, !6566, !6570, !6577, !6584, !6586, !6588, !6590, !6592, !6594, !6595, !6597, !6599, !6601, !6605, !6607, !6608, !6610, !6611, !6612, !6613, !6617, !6619, !7201, !6622, !7203, !6625, !7205, !7207, !7209, !7211, !6632, !6634, !6636, !6637, !6638, !6639, !7213, !6643, !6645, !6647, !6649, !7215, !6652, !6653, !6655, !6657, !7217, !6659, !6661, !7219, !6664, !6666, !6668, !6670, !6672, !6674, !6676, !6678, !6680, !6682, !7221, !7223, !6686, !6690, !6692, !6695, !6697, !6700, !6702, !6704, !6706, !6709, !6712, !6715, !6717, !6719, !6721, !6724, !6727, !6730, !6733, !6736, !6739, !6741, !6743, !6746, !6749, !6751, !6752, !6755, !6758, !6760, !6763, !6766, !6769, !6772, !6775, !6778, !6781, !6784, !6787, !6790, !6792, !7225, !6796, !6800, !6804, !6806, !6807, !6810, !6813, !6816, !6818, !6820, !6822, !6823, !6826, !6830, !6832, !6835, !6840, !6841, !6843, !6844, !6850, !6853, !6855, !6857, !6861, !6863, !6870, !6872, !6873, !6875, !6877, !6879, !6881, !6885, !6887, !6889, !6891, !7227, !6895, !6896, !6898, !6902}
!6995 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !6996, file: !4923, line: 1071)
!6996 = !DISubprogram(name: "acoshl", scope: !4920, file: !4920, line: 85, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!6997 = !DISubroutineType(types: !6998)
!6998 = !{!6999, !6999}
!6999 = !DIBasicType(name: "long double", size: 64, encoding: DW_ATE_float)
!7000 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7001, file: !4923, line: 1075)
!7001 = !DISubprogram(name: "asinhl", scope: !4920, file: !4920, line: 87, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7002 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7003, file: !4923, line: 1079)
!7003 = !DISubprogram(name: "atanhl", scope: !4920, file: !4920, line: 89, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7004 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7005, file: !4923, line: 1083)
!7005 = !DISubprogram(name: "cbrtl", scope: !4920, file: !4920, line: 152, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7006 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7007, file: !4923, line: 1087)
!7007 = !DISubprogram(name: "copysignl", scope: !4920, file: !4920, line: 198, type: !7008, flags: DIFlagPrototyped, spFlags: 0)
!7008 = !DISubroutineType(types: !7009)
!7009 = !{!6999, !6999, !6999}
!7010 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7011, file: !4923, line: 1091)
!7011 = !DISubprogram(name: "erfl", scope: !4920, file: !4920, line: 231, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7012 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7013, file: !4923, line: 1095)
!7013 = !DISubprogram(name: "erfcl", scope: !4920, file: !4920, line: 232, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7014 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7015, file: !4923, line: 1099)
!7015 = !DISubprogram(name: "exp2l", scope: !4920, file: !4920, line: 130, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7016 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7017, file: !4923, line: 1103)
!7017 = !DISubprogram(name: "expm1l", scope: !4920, file: !4920, line: 119, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7018 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7019, file: !4923, line: 1107)
!7019 = !DISubprogram(name: "fdiml", scope: !4920, file: !4920, line: 329, type: !7008, flags: DIFlagPrototyped, spFlags: 0)
!7020 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7021, file: !4923, line: 1111)
!7021 = !DISubprogram(name: "fmal", scope: !4920, file: !4920, line: 340, type: !7022, flags: DIFlagPrototyped, spFlags: 0)
!7022 = !DISubroutineType(types: !7023)
!7023 = !{!6999, !6999, !6999, !6999}
!7024 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7025, file: !4923, line: 1115)
!7025 = !DISubprogram(name: "fmaxl", scope: !4920, file: !4920, line: 333, type: !7008, flags: DIFlagPrototyped, spFlags: 0)
!7026 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7027, file: !4923, line: 1119)
!7027 = !DISubprogram(name: "fminl", scope: !4920, file: !4920, line: 336, type: !7008, flags: DIFlagPrototyped, spFlags: 0)
!7028 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7029, file: !4923, line: 1123)
!7029 = !DISubprogram(name: "hypotl", scope: !4920, file: !4920, line: 147, type: !7008, flags: DIFlagPrototyped, spFlags: 0)
!7030 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7031, file: !4923, line: 1127)
!7031 = !DISubprogram(name: "ilogbl", scope: !4920, file: !4920, line: 283, type: !7032, flags: DIFlagPrototyped, spFlags: 0)
!7032 = !DISubroutineType(types: !7033)
!7033 = !{!256, !6999}
!7034 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7035, file: !4923, line: 1131)
!7035 = !DISubprogram(name: "lgammal", scope: !4920, file: !4920, line: 233, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7036 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7037, file: !4923, line: 1136)
!7037 = !DISubprogram(name: "llrintl", scope: !4920, file: !4920, line: 319, type: !7038, flags: DIFlagPrototyped, spFlags: 0)
!7038 = !DISubroutineType(types: !7039)
!7039 = !{!4839, !6999}
!7040 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7041, file: !4923, line: 1140)
!7041 = !DISubprogram(name: "llroundl", scope: !4920, file: !4920, line: 325, type: !7038, flags: DIFlagPrototyped, spFlags: 0)
!7042 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7043, file: !4923, line: 1145)
!7043 = !DISubprogram(name: "log1pl", scope: !4920, file: !4920, line: 122, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7044 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7045, file: !4923, line: 1149)
!7045 = !DISubprogram(name: "log2l", scope: !4920, file: !4920, line: 133, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7046 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7047, file: !4923, line: 1153)
!7047 = !DISubprogram(name: "logbl", scope: !4920, file: !4920, line: 125, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7048 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7049, file: !4923, line: 1157)
!7049 = !DISubprogram(name: "lrintl", scope: !4920, file: !4920, line: 317, type: !7050, flags: DIFlagPrototyped, spFlags: 0)
!7050 = !DISubroutineType(types: !7051)
!7051 = !{!575, !6999}
!7052 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7053, file: !4923, line: 1161)
!7053 = !DISubprogram(name: "lroundl", scope: !4920, file: !4920, line: 323, type: !7050, flags: DIFlagPrototyped, spFlags: 0)
!7054 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7055, file: !4923, line: 1165)
!7055 = !DISubprogram(name: "nanl", scope: !4920, file: !4920, line: 203, type: !7056, flags: DIFlagPrototyped, spFlags: 0)
!7056 = !DISubroutineType(types: !7057)
!7057 = !{!6999, !1452}
!7058 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7059, file: !4923, line: 1169)
!7059 = !DISubprogram(name: "nearbyintl", scope: !4920, file: !4920, line: 297, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7060 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7061, file: !4923, line: 1173)
!7061 = !DISubprogram(name: "nextafterl", scope: !4920, file: !4920, line: 262, type: !7008, flags: DIFlagPrototyped, spFlags: 0)
!7062 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7063, file: !4923, line: 1175)
!7063 = !DISubprogram(name: "nexttoward", scope: !4920, file: !4920, line: 264, type: !7064, flags: DIFlagPrototyped, spFlags: 0)
!7064 = !DISubroutineType(types: !7065)
!7065 = !{!4871, !4871, !6999}
!7066 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7067, file: !4923, line: 1176)
!7067 = !DISubprogram(name: "nexttowardf", scope: !4920, file: !4920, line: 264, type: !7068, flags: DIFlagPrototyped, spFlags: 0)
!7068 = !DISubroutineType(types: !7069)
!7069 = !{!4737, !4737, !6999}
!7070 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7071, file: !4923, line: 1177)
!7071 = !DISubprogram(name: "nexttowardl", scope: !4920, file: !4920, line: 264, type: !7008, flags: DIFlagPrototyped, spFlags: 0)
!7072 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7073, file: !4923, line: 1181)
!7073 = !DISubprogram(name: "remainderl", scope: !4920, file: !4920, line: 275, type: !7008, flags: DIFlagPrototyped, spFlags: 0)
!7074 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7075, file: !4923, line: 1185)
!7075 = !DISubprogram(name: "remquol", scope: !4920, file: !4920, line: 310, type: !7076, flags: DIFlagPrototyped, spFlags: 0)
!7076 = !DISubroutineType(types: !7077)
!7077 = !{!6999, !6999, !6999, !4796}
!7078 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7079, file: !4923, line: 1189)
!7079 = !DISubprogram(name: "rintl", scope: !4920, file: !4920, line: 259, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7080 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7081, file: !4923, line: 1193)
!7081 = !DISubprogram(name: "roundl", scope: !4920, file: !4920, line: 301, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7082 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7083, file: !4923, line: 1197)
!7083 = !DISubprogram(name: "scalblnl", scope: !4920, file: !4920, line: 293, type: !7084, flags: DIFlagPrototyped, spFlags: 0)
!7084 = !DISubroutineType(types: !7085)
!7085 = !{!6999, !6999, !575}
!7086 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7087, file: !4923, line: 1201)
!7087 = !DISubprogram(name: "scalbnl", scope: !4920, file: !4920, line: 279, type: !7088, flags: DIFlagPrototyped, spFlags: 0)
!7088 = !DISubroutineType(types: !7089)
!7089 = !{!6999, !6999, !256}
!7090 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7091, file: !4923, line: 1205)
!7091 = !DISubprogram(name: "tgammal", scope: !4920, file: !4920, line: 238, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7092 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7093, file: !4923, line: 1209)
!7093 = !DISubprogram(name: "truncl", scope: !4920, file: !4920, line: 305, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7094 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !7095, file: !5234, line: 232)
!7095 = !DISubprogram(name: "strtold", scope: !4916, file: !4916, line: 127, type: !7096, flags: DIFlagPrototyped, spFlags: 0)
!7096 = !DISubroutineType(types: !7097)
!7097 = !{!6999, !5314, !5341}
!7098 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7095, file: !5234, line: 252)
!7099 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5242, file: !5411, line: 38)
!7100 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5250, file: !5411, line: 39)
!7101 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5281, file: !5411, line: 40)
!7102 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5255, file: !5411, line: 43)
!7103 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5324, file: !5411, line: 46)
!7104 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5232, file: !5411, line: 51)
!7105 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5236, file: !5411, line: 52)
!7106 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !7107, file: !5411, line: 54)
!7107 = !DISubprogram(name: "abs", linkageName: "_ZSt3abse", scope: !2, file: !4917, line: 79, type: !6997, flags: DIFlagPrototyped, spFlags: 0)
!7108 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5257, file: !5411, line: 55)
!7109 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5259, file: !5411, line: 56)
!7110 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5263, file: !5411, line: 57)
!7111 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5267, file: !5411, line: 58)
!7112 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5275, file: !5411, line: 59)
!7113 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5403, file: !5411, line: 60)
!7114 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5285, file: !5411, line: 61)
!7115 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5289, file: !5411, line: 62)
!7116 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5294, file: !5411, line: 63)
!7117 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5296, file: !5411, line: 64)
!7118 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5300, file: !5411, line: 65)
!7119 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5304, file: !5411, line: 67)
!7120 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5308, file: !5411, line: 68)
!7121 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5316, file: !5411, line: 69)
!7122 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5320, file: !5411, line: 71)
!7123 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5326, file: !5411, line: 72)
!7124 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5330, file: !5411, line: 73)
!7125 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5334, file: !5411, line: 74)
!7126 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5338, file: !5411, line: 75)
!7127 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5344, file: !5411, line: 76)
!7128 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5348, file: !5411, line: 77)
!7129 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5352, file: !5411, line: 78)
!7130 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5354, file: !5411, line: 80)
!7131 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !5362, file: !5411, line: 81)
!7132 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7133, file: !5569, line: 144)
!7133 = !DISubprogram(name: "vfprintf", scope: !5572, file: !5572, line: 365, type: !7134, flags: DIFlagPrototyped, spFlags: 0)
!7134 = !DISubroutineType(types: !7135)
!7135 = !{!256, !5597, !5314, !7136}
!7136 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !7137, line: 32, baseType: !7138)
!7137 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/stdarg.h", directory: "")
!7138 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !5712, baseType: !5292)
!7139 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7140, file: !5569, line: 145)
!7140 = !DISubprogram(name: "vprintf", scope: !5572, file: !5572, line: 371, type: !7141, flags: DIFlagPrototyped, spFlags: 0)
!7141 = !DISubroutineType(types: !7142)
!7142 = !{!256, !5314, !7136}
!7143 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7144, file: !5569, line: 146)
!7144 = !DISubprogram(name: "vsprintf", scope: !5572, file: !5572, line: 373, type: !7145, flags: DIFlagPrototyped, spFlags: 0)
!7145 = !DISubroutineType(types: !7146)
!7146 = !{!256, !5357, !5314, !7136}
!7147 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !7148, file: !5569, line: 176)
!7148 = !DISubprogram(name: "vfscanf", linkageName: "__isoc99_vfscanf", scope: !5572, file: !5572, line: 479, type: !7134, flags: DIFlagPrototyped, spFlags: 0)
!7149 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !7150, file: !5569, line: 177)
!7150 = !DISubprogram(name: "vscanf", linkageName: "__isoc99_vscanf", scope: !5572, file: !5572, line: 484, type: !7141, flags: DIFlagPrototyped, spFlags: 0)
!7151 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !7152, file: !5569, line: 178)
!7152 = !DISubprogram(name: "vsnprintf", scope: !5572, file: !5572, line: 382, type: !7153, flags: DIFlagPrototyped, spFlags: 0)
!7153 = !DISubroutineType(types: !7154)
!7154 = !{!256, !5357, !1288, !5314, !7136}
!7155 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !7156, file: !5569, line: 179)
!7156 = !DISubprogram(name: "vsscanf", linkageName: "__isoc99_vsscanf", scope: !5572, file: !5572, line: 487, type: !7157, flags: DIFlagPrototyped, spFlags: 0)
!7157 = !DISubroutineType(types: !7158)
!7158 = !{!256, !5314, !5314, !7136}
!7159 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7148, file: !5569, line: 186)
!7160 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7150, file: !5569, line: 187)
!7161 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7152, file: !5569, line: 188)
!7162 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7156, file: !5569, line: 189)
!7163 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7164, file: !5832, line: 164)
!7164 = !DISubprogram(name: "vfwprintf", scope: !5838, file: !5838, line: 613, type: !7165, flags: DIFlagPrototyped, spFlags: 0)
!7165 = !DISubroutineType(types: !7166)
!7166 = !{!256, !5852, !5358, !7136}
!7167 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7168, file: !5832, line: 166)
!7168 = !DISubprogram(name: "vfwscanf", linkageName: "__isoc99_vfwscanf", scope: !5838, file: !5838, line: 711, type: !7165, flags: DIFlagPrototyped, spFlags: 0)
!7169 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7170, file: !5832, line: 169)
!7170 = !DISubprogram(name: "vswprintf", scope: !5838, file: !5838, line: 626, type: !7171, flags: DIFlagPrototyped, spFlags: 0)
!7171 = !DISubroutineType(types: !7172)
!7172 = !{!256, !5311, !1288, !5358, !7136}
!7173 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7174, file: !5832, line: 172)
!7174 = !DISubprogram(name: "vswscanf", linkageName: "__isoc99_vswscanf", scope: !5838, file: !5838, line: 718, type: !7175, flags: DIFlagPrototyped, spFlags: 0)
!7175 = !DISubroutineType(types: !7176)
!7176 = !{!256, !5358, !5358, !7136}
!7177 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7178, file: !5832, line: 174)
!7178 = !DISubprogram(name: "vwprintf", scope: !5838, file: !5838, line: 621, type: !7179, flags: DIFlagPrototyped, spFlags: 0)
!7179 = !DISubroutineType(types: !7180)
!7180 = !{!256, !5358, !7136}
!7181 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7182, file: !5832, line: 176)
!7182 = !DISubprogram(name: "vwscanf", linkageName: "__isoc99_vwscanf", scope: !5838, file: !5838, line: 715, type: !7179, flags: DIFlagPrototyped, spFlags: 0)
!7183 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !67, entity: !7184, file: !5832, line: 251)
!7184 = !DISubprogram(name: "wcstold", scope: !5838, file: !5838, line: 385, type: !7185, flags: DIFlagPrototyped, spFlags: 0)
!7185 = !DISubroutineType(types: !7186)
!7186 = !{!6999, !5358, !6004}
!7187 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7184, file: !5832, line: 267)
!7188 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7168, file: !5832, line: 286)
!7189 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7174, file: !5832, line: 289)
!7190 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7182, file: !5832, line: 292)
!7191 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !7184, file: !5832, line: 296)
!7192 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !36, entity: !7193, file: !6221, line: 18)
!7193 = !DISubprogram(name: "to_string", linkageName: "_ZNSt7__cxx119to_stringEe", scope: !1416, file: !6213, line: 6739, type: !7194, flags: DIFlagPrototyped, spFlags: 0)
!7194 = !DISubroutineType(types: !7195)
!7195 = !{!1412, !6999}
!7196 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !6904, entity: !7197, file: !6399, line: 54)
!7197 = !DISubprogram(name: "modf", linkageName: "_ZSt4modfePe", scope: !2, file: !4923, line: 380, type: !7198, flags: DIFlagPrototyped, spFlags: 0)
!7198 = !DISubroutineType(types: !7199)
!7199 = !{!6999, !6999, !7200}
!7200 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6999, size: 64)
!7201 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7202, file: !6609, line: 54)
!7202 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "EnumType", scope: !36, file: !1473, line: 12, size: 1728, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c108EnumTypeE")
!7203 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7204, file: !6609, line: 54)
!7204 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "TensorType", scope: !36, file: !1582, line: 578, size: 896, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1010TensorTypeE")
!7205 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7206, file: !6609, line: 54)
!7206 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "TupleType", scope: !36, file: !1582, line: 1147, size: 1664, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c109TupleTypeE")
!7207 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7208, file: !6609, line: 54)
!7208 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ListType", scope: !36, file: !1582, line: 869, size: 384, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c108ListTypeE")
!7209 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7210, file: !6609, line: 54)
!7210 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "DictType", scope: !36, file: !1582, line: 923, size: 512, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c108DictTypeE")
!7211 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7212, file: !6609, line: 54)
!7212 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "NumberType", scope: !36, file: !1582, line: 1268, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1010NumberTypeE")
!7213 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7214, file: !6609, line: 54)
!7214 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "NoneType", scope: !36, file: !1582, line: 1530, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c108NoneTypeE")
!7215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7216, file: !6609, line: 54)
!7216 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "OptionalType", scope: !36, file: !1582, line: 196, size: 704, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1012OptionalTypeE")
!7217 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7218, file: !6609, line: 54)
!7218 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ClassType", scope: !36, file: !965, line: 66, size: 3648, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c109ClassTypeE")
!7219 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7220, file: !6609, line: 54)
!7220 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "InterfaceType", scope: !36, file: !1582, line: 2174, size: 1472, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1013InterfaceTypeE")
!7221 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7222, file: !6609, line: 54)
!7222 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "UnionType", scope: !36, file: !1582, line: 131, size: 576, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c109UnionTypeE")
!7223 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7224, file: !6609, line: 54)
!7224 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "DynamicType", scope: !36, file: !2897, line: 117, size: 832, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1011DynamicTypeE")
!7225 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !3010, entity: !7226, file: !6609, line: 61)
!7226 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Type", scope: !36, file: !280, line: 146, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c104TypeE")
!7227 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !327, entity: !7228, file: !6849, line: 111)
!7228 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "RecordFunction", scope: !6198, file: !6865, line: 282, size: 2752, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN2at14RecordFunctionE")
!7229 = !{!"Ubuntu clang version 13.0.1-2ubuntu2.2"}
!7230 = !{!"clang version 3.8.0 (tags/RELEASE_380/final)"}
!7231 = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 2]}
!7232 = !{i32 7, !"Dwarf Version", i32 4}
!7233 = !{i32 2, !"Debug Info Version", i32 3}
!7234 = !{i32 1, !"wchar_size", i32 4}
!7235 = !{i32 7, !"uwtable", i32 1}
!7236 = !{i32 7, !"frame-pointer", i32 2}
!7237 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!7238 = !{void (float*, i8*, float*, i32)* @_Z37static_scaled_int8_quant_kernel_buggyPKfPaS0_i, !"kernel", i32 1}
!7239 = !{i32 2, i32 0}
!7240 = distinct !DISubprogram(linkageName: "_GLOBAL__sub_I_vllm9391.cu", scope: !5712, file: !5712, type: !7241, flags: DIFlagArtificial, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !843)
!7241 = !DISubroutineType(types: !843)
!7242 = !DILocation(line: 0, scope: !7240)
!7243 = distinct !DISubprogram(name: "__cxx_global_var_init", scope: !5712, file: !5712, type: !5243, flags: DIFlagArtificial, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !843)
!7244 = !DILocation(line: 74, column: 25, scope: !7245)
!7245 = !DILexicalBlockFile(scope: !7243, file: !3, discriminator: 0)
!7246 = !DILocation(line: 0, scope: !7243)
!7247 = distinct !DISubprogram(name: "static_scaled_int8_quant_kernel_buggy", linkageName: "_Z52__device_stub__static_scaled_int8_quant_kernel_buggyPKfPaS0_i", scope: !5712, file: !5712, line: 20, type: !7248, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !843)
!7248 = !DISubroutineType(types: !7249)
!7249 = !{null, !7250, !7253, !7250, !256}
!7250 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !7251)
!7251 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7252, size: 64)
!7252 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4737)
!7253 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !7254)
!7254 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!7255 = !DILocalVariable(name: "input", arg: 1, scope: !7247, file: !5712, line: 21, type: !7250)
!7256 = !DILocation(line: 21, column: 31, scope: !7247)
!7257 = !DILocalVariable(name: "out", arg: 2, scope: !7247, file: !5712, line: 22, type: !7253)
!7258 = !DILocation(line: 22, column: 26, scope: !7247)
!7259 = !DILocalVariable(name: "scale_ptr", arg: 3, scope: !7247, file: !5712, line: 23, type: !7250)
!7260 = !DILocation(line: 23, column: 31, scope: !7247)
!7261 = !DILocalVariable(name: "hidden_size", arg: 4, scope: !7247, file: !5712, line: 24, type: !256)
!7262 = !DILocation(line: 24, column: 9, scope: !7247)
!7263 = !DILocation(line: 24, column: 22, scope: !7247)
!7264 = !DILocation(line: 43, column: 1, scope: !7247)
!7265 = distinct !DISubprogram(name: "static_scaled_int8_quant", linkageName: "_Z24static_scaled_int8_quantRN2at6TensorERKS0_S3_", scope: !5712, file: !5712, line: 45, type: !7266, scopeLine: 47, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !843)
!7266 = !DISubroutineType(types: !7267)
!7267 = !{null, !7268, !7269, !7269}
!7268 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !6827, size: 64)
!7269 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !7270, size: 64)
!7270 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6827)
!7271 = !DILocalVariable(name: "out", arg: 1, scope: !7265, file: !5712, line: 45, type: !7268)
!7272 = !DILocation(line: 45, column: 46, scope: !7265)
!7273 = !DILocalVariable(name: "input", arg: 2, scope: !7265, file: !5712, line: 46, type: !7269)
!7274 = !DILocation(line: 46, column: 52, scope: !7265)
!7275 = !DILocalVariable(name: "scale", arg: 3, scope: !7265, file: !5712, line: 47, type: !7269)
!7276 = !DILocation(line: 47, column: 52, scope: !7265)
!7277 = !DILocation(line: 48, column: 3, scope: !7278)
!7278 = distinct !DILexicalBlock(scope: !7265, file: !5712, line: 48, column: 3)
!7279 = !DILocation(line: 48, column: 3, scope: !7265)
!7280 = !DILocation(line: 48, column: 3, scope: !7281)
!7281 = distinct !DILexicalBlock(scope: !7278, file: !5712, line: 48, column: 3)
!7282 = !DILocation(line: 49, column: 3, scope: !7283)
!7283 = distinct !DILexicalBlock(scope: !7265, file: !5712, line: 49, column: 3)
!7284 = !DILocation(line: 49, column: 3, scope: !7265)
!7285 = !DILocation(line: 49, column: 3, scope: !7286)
!7286 = distinct !DILexicalBlock(scope: !7283, file: !5712, line: 49, column: 3)
!7287 = !DILocation(line: 50, column: 3, scope: !7288)
!7288 = distinct !DILexicalBlock(scope: !7265, file: !5712, line: 50, column: 3)
!7289 = !DILocation(line: 50, column: 3, scope: !7265)
!7290 = !DILocation(line: 50, column: 3, scope: !7291)
!7291 = distinct !DILexicalBlock(scope: !7288, file: !5712, line: 50, column: 3)
!7292 = !DILocalVariable(name: "hidden_size", scope: !7265, file: !5712, line: 52, type: !387)
!7293 = !DILocation(line: 52, column: 13, scope: !7265)
!7294 = !DILocation(line: 52, column: 27, scope: !7265)
!7295 = !DILocation(line: 52, column: 33, scope: !7265)
!7296 = !DILocalVariable(name: "num_tokens", scope: !7265, file: !5712, line: 53, type: !387)
!7297 = !DILocation(line: 53, column: 13, scope: !7265)
!7298 = !DILocation(line: 53, column: 26, scope: !7265)
!7299 = !DILocation(line: 53, column: 32, scope: !7265)
!7300 = !DILocation(line: 53, column: 42, scope: !7265)
!7301 = !DILocation(line: 53, column: 40, scope: !7265)
!7302 = !DILocalVariable(name: "grid", scope: !7265, file: !5712, line: 54, type: !7303)
!7303 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7304)
!7304 = !DIDerivedType(tag: DW_TAG_typedef, name: "dim3", file: !3502, line: 434, baseType: !3501)
!7305 = !DILocation(line: 54, column: 14, scope: !7265)
!7306 = !DILocation(line: 54, column: 19, scope: !7265)
!7307 = !DILocalVariable(name: "block", scope: !7265, file: !5712, line: 55, type: !7303)
!7308 = !DILocation(line: 55, column: 14, scope: !7265)
!7309 = !DILocation(line: 55, column: 42, scope: !7265)
!7310 = !DILocation(line: 55, column: 20, scope: !7265)
!7311 = !DILocation(line: 56, column: 43, scope: !7265)
!7312 = !DILocation(line: 56, column: 49, scope: !7265)
!7313 = !DILocation(line: 56, column: 40, scope: !7265)
!7314 = !DILocation(line: 56, column: 3, scope: !7265)
!7315 = !DILocation(line: 57, column: 17, scope: !7265)
!7316 = !DILocation(line: 57, column: 23, scope: !7265)
!7317 = !DILocation(line: 57, column: 42, scope: !7265)
!7318 = !DILocation(line: 57, column: 46, scope: !7265)
!7319 = !DILocation(line: 58, column: 17, scope: !7265)
!7320 = !DILocation(line: 58, column: 23, scope: !7265)
!7321 = !DILocation(line: 58, column: 42, scope: !7265)
!7322 = !DILocation(line: 59, column: 1, scope: !7265)
!7323 = distinct !DISubprogram(name: "is_contiguous", linkageName: "_ZNK2at10TensorBase13is_contiguousEN3c1012MemoryFormatE", scope: !7325, file: !7324, line: 264, type: !7326, scopeLine: 264, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7330, retainedNodes: !843)
!7324 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/ATen/core/TensorBase.h", directory: "/home/mvh6224/CUDA-BOSolver")
!7325 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "TensorBase", scope: !6198, file: !7324, line: 82, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN2at10TensorBaseE")
!7326 = !DISubroutineType(types: !7327)
!7327 = !{!378, !7328, !271}
!7328 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7329, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!7329 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7325)
!7330 = !DISubprogram(name: "is_contiguous", linkageName: "_ZNK2at10TensorBase13is_contiguousEN3c1012MemoryFormatE", scope: !7325, file: !7324, line: 264, type: !7326, scopeLine: 264, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!7331 = !DILocalVariable(name: "this", arg: 1, scope: !7323, type: !7332, flags: DIFlagArtificial | DIFlagObjectPointer)
!7332 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7329, size: 64)
!7333 = !DILocation(line: 0, scope: !7323)
!7334 = !DILocalVariable(name: "memory_format", arg: 2, scope: !7323, file: !7324, line: 264, type: !271)
!7335 = !DILocation(line: 264, column: 39, scope: !7323)
!7336 = !DILocation(line: 265, column: 12, scope: !7323)
!7337 = !DILocation(line: 265, column: 33, scope: !7323)
!7338 = !DILocation(line: 265, column: 19, scope: !7323)
!7339 = !DILocation(line: 265, column: 5, scope: !7323)
!7340 = distinct !DISubprogram(name: "torchCheckMsgImpl", linkageName: "_ZN3c106detail17torchCheckMsgImplEPKc", scope: !7342, file: !7341, line: 468, type: !7343, scopeLine: 468, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !843)
!7341 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/Exception.h", directory: "/home/mvh6224/CUDA-BOSolver")
!7342 = !DINamespace(name: "detail", scope: !36)
!7343 = !DISubroutineType(types: !7344)
!7344 = !{!1452, !1452}
!7345 = !DILocalVariable(name: "msg", arg: 1, scope: !7340, file: !7341, line: 468, type: !1452)
!7346 = !DILocation(line: 468, column: 58, scope: !7340)
!7347 = !DILocation(line: 469, column: 10, scope: !7340)
!7348 = !DILocation(line: 469, column: 3, scope: !7340)
!7349 = distinct !DISubprogram(name: "numel", linkageName: "_ZNK2at10TensorBase5numelEv", scope: !7325, file: !7324, line: 314, type: !7350, scopeLine: 314, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7352, retainedNodes: !843)
!7350 = !DISubroutineType(types: !7351)
!7351 = !{!648, !7328}
!7352 = !DISubprogram(name: "numel", linkageName: "_ZNK2at10TensorBase5numelEv", scope: !7325, file: !7324, line: 314, type: !7350, scopeLine: 314, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!7353 = !DILocalVariable(name: "this", arg: 1, scope: !7349, type: !7332, flags: DIFlagArtificial | DIFlagObjectPointer)
!7354 = !DILocation(line: 0, scope: !7349)
!7355 = !DILocation(line: 315, column: 12, scope: !7349)
!7356 = !DILocation(line: 315, column: 19, scope: !7349)
!7357 = !DILocation(line: 315, column: 5, scope: !7349)
!7358 = distinct !DISubprogram(name: "size", linkageName: "_ZNK2at10TensorBase4sizeEl", scope: !7325, file: !7324, line: 177, type: !7359, scopeLine: 177, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7361, retainedNodes: !843)
!7359 = !DISubroutineType(types: !7360)
!7360 = !{!648, !7328, !648}
!7361 = !DISubprogram(name: "size", linkageName: "_ZNK2at10TensorBase4sizeEl", scope: !7325, file: !7324, line: 177, type: !7359, scopeLine: 177, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!7362 = !DILocalVariable(name: "this", arg: 1, scope: !7358, type: !7332, flags: DIFlagArtificial | DIFlagObjectPointer)
!7363 = !DILocation(line: 0, scope: !7358)
!7364 = !DILocalVariable(name: "dim", arg: 2, scope: !7358, file: !7324, line: 177, type: !648)
!7365 = !DILocation(line: 177, column: 24, scope: !7358)
!7366 = !DILocation(line: 178, column: 12, scope: !7358)
!7367 = !DILocation(line: 178, column: 24, scope: !7358)
!7368 = !DILocation(line: 178, column: 19, scope: !7358)
!7369 = !DILocation(line: 178, column: 5, scope: !7358)
!7370 = distinct !DISubprogram(name: "dim3", linkageName: "_ZN4dim3C2Ejjj", scope: !3501, file: !3502, line: 423, type: !3508, scopeLine: 423, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !3507, retainedNodes: !843)
!7371 = !DILocalVariable(name: "this", arg: 1, scope: !7370, type: !7372, flags: DIFlagArtificial | DIFlagObjectPointer)
!7372 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3501, size: 64)
!7373 = !DILocation(line: 0, scope: !7370)
!7374 = !DILocalVariable(name: "vx", arg: 2, scope: !7370, file: !3502, line: 423, type: !68)
!7375 = !DILocation(line: 423, column: 53, scope: !7370)
!7376 = !DILocalVariable(name: "vy", arg: 3, scope: !7370, file: !3502, line: 423, type: !68)
!7377 = !DILocation(line: 423, column: 74, scope: !7370)
!7378 = !DILocalVariable(name: "vz", arg: 4, scope: !7370, file: !3502, line: 423, type: !68)
!7379 = !DILocation(line: 423, column: 95, scope: !7370)
!7380 = !DILocation(line: 423, column: 105, scope: !7370)
!7381 = !DILocation(line: 423, column: 107, scope: !7370)
!7382 = !DILocation(line: 423, column: 112, scope: !7370)
!7383 = !DILocation(line: 423, column: 114, scope: !7370)
!7384 = !DILocation(line: 423, column: 119, scope: !7370)
!7385 = !DILocation(line: 423, column: 121, scope: !7370)
!7386 = !DILocation(line: 423, column: 126, scope: !7370)
!7387 = distinct !DISubprogram(name: "min<int>", linkageName: "_ZSt3minIiEUa9enable_ifILb1EERKT_S2_S2_", scope: !2, file: !7388, line: 101, type: !7389, scopeLine: 101, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, templateParams: !7392, retainedNodes: !843)
!7388 = !DIFile(filename: "/usr/lib/llvm-13/lib/clang/13.0.1/include/cuda_wrappers/algorithm", directory: "")
!7389 = !DISubroutineType(types: !7390)
!7390 = !{!7391, !7391, !7391}
!7391 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !387, size: 64)
!7392 = !{!7393}
!7393 = !DITemplateTypeParameter(name: "__T", type: !256)
!7394 = !DILocalVariable(name: "__a", arg: 1, scope: !7387, file: !7388, line: 101, type: !7391)
!7395 = !DILocation(line: 101, column: 16, scope: !7387)
!7396 = !DILocalVariable(name: "__b", arg: 2, scope: !7387, file: !7388, line: 101, type: !7391)
!7397 = !DILocation(line: 101, column: 32, scope: !7387)
!7398 = !DILocation(line: 102, column: 10, scope: !7387)
!7399 = !DILocation(line: 102, column: 16, scope: !7387)
!7400 = !DILocation(line: 102, column: 14, scope: !7387)
!7401 = !DILocation(line: 102, column: 22, scope: !7387)
!7402 = !DILocation(line: 102, column: 28, scope: !7387)
!7403 = !DILocation(line: 102, column: 3, scope: !7387)
!7404 = distinct !DISubprogram(name: "operator->", linkageName: "_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv", scope: !7405, file: !4377, line: 422, type: !7406, scopeLine: 422, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7411, retainedNodes: !843)
!7405 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "intrusive_ptr<c10::TensorImpl, c10::UndefinedTensorImpl>", scope: !36, file: !4377, line: 229, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEE")
!7406 = !DISubroutineType(types: !7407)
!7407 = !{!7408, !7409}
!7408 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !350, size: 64)
!7409 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7410, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!7410 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7405)
!7411 = !DISubprogram(name: "operator->", linkageName: "_ZNK3c1013intrusive_ptrINS_10TensorImplENS_19UndefinedTensorImplEEptEv", scope: !7405, file: !4377, line: 422, type: !7406, scopeLine: 422, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!7412 = !DILocalVariable(name: "this", arg: 1, scope: !7404, type: !7413, flags: DIFlagArtificial | DIFlagObjectPointer)
!7413 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7410, size: 64)
!7414 = !DILocation(line: 0, scope: !7404)
!7415 = !DILocation(line: 423, column: 12, scope: !7404)
!7416 = !DILocation(line: 423, column: 5, scope: !7404)
!7417 = distinct !DISubprogram(name: "size", linkageName: "_ZNK3c1010TensorImpl4sizeEl", scope: !350, file: !349, line: 894, type: !7418, scopeLine: 894, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7422, retainedNodes: !843)
!7418 = !DISubroutineType(types: !7419)
!7419 = !{!648, !7420, !648}
!7420 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7421, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!7421 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !350)
!7422 = !DISubprogram(name: "size", linkageName: "_ZNK3c1010TensorImpl4sizeEl", scope: !350, file: !349, line: 894, type: !7418, scopeLine: 894, flags: DIFlagPrototyped, spFlags: 0)
!7423 = !DILocalVariable(name: "this", arg: 1, scope: !7417, type: !7424, flags: DIFlagArtificial | DIFlagObjectPointer)
!7424 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7421, size: 64)
!7425 = !DILocation(line: 0, scope: !7417)
!7426 = !DILocalVariable(name: "d", arg: 2, scope: !7417, file: !349, line: 894, type: !648)
!7427 = !DILocation(line: 894, column: 24, scope: !7417)
!7428 = !DILocation(line: 895, column: 9, scope: !7429)
!7429 = distinct !DILexicalBlock(scope: !7417, file: !349, line: 895, column: 9)
!7430 = !DILocation(line: 895, column: 9, scope: !7417)
!7431 = !DILocation(line: 896, column: 26, scope: !7432)
!7432 = distinct !DILexicalBlock(scope: !7429, file: !349, line: 895, column: 72)
!7433 = !DILocation(line: 896, column: 14, scope: !7432)
!7434 = !DILocation(line: 896, column: 7, scope: !7432)
!7435 = !DILocation(line: 898, column: 24, scope: !7417)
!7436 = !DILocation(line: 898, column: 27, scope: !7417)
!7437 = !DILocation(line: 898, column: 9, scope: !7417)
!7438 = !DILocation(line: 898, column: 7, scope: !7417)
!7439 = !DILocation(line: 899, column: 12, scope: !7417)
!7440 = !DILocation(line: 899, column: 49, scope: !7417)
!7441 = !DILocation(line: 899, column: 31, scope: !7417)
!7442 = !DILocation(line: 899, column: 5, scope: !7417)
!7443 = !DILocation(line: 900, column: 3, scope: !7417)
!7444 = distinct !DISubprogram(name: "matches_policy", linkageName: "_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE", scope: !350, file: !349, line: 947, type: !7445, scopeLine: 947, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7447, retainedNodes: !843)
!7445 = !DISubroutineType(types: !7446)
!7446 = !{!378, !7420, !348}
!7447 = !DISubprogram(name: "matches_policy", linkageName: "_ZNK3c1010TensorImpl14matches_policyENS0_18SizesStridesPolicyE", scope: !350, file: !349, line: 947, type: !7445, scopeLine: 947, flags: DIFlagProtected | DIFlagPrototyped, spFlags: 0)
!7448 = !DILocalVariable(name: "this", arg: 1, scope: !7444, type: !7424, flags: DIFlagArtificial | DIFlagObjectPointer)
!7449 = !DILocation(line: 0, scope: !7444)
!7450 = !DILocalVariable(name: "policy", arg: 2, scope: !7444, file: !349, line: 947, type: !348)
!7451 = !DILocation(line: 947, column: 49, scope: !7444)
!7452 = !DILocation(line: 948, column: 12, scope: !7444)
!7453 = !DILocation(line: 948, column: 58, scope: !7444)
!7454 = !DILocation(line: 948, column: 37, scope: !7444)
!7455 = !DILocation(line: 948, column: 34, scope: !7444)
!7456 = !DILocation(line: 948, column: 5, scope: !7444)
!7457 = distinct !DISubprogram(name: "dim", linkageName: "_ZNK3c1010TensorImpl3dimEv", scope: !350, file: !349, line: 730, type: !7458, scopeLine: 730, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7460, retainedNodes: !843)
!7458 = !DISubroutineType(types: !7459)
!7459 = !{!648, !7420}
!7460 = !DISubprogram(name: "dim", linkageName: "_ZNK3c1010TensorImpl3dimEv", scope: !350, file: !349, line: 730, type: !7458, scopeLine: 730, flags: DIFlagPrototyped, spFlags: 0)
!7461 = !DILocalVariable(name: "this", arg: 1, scope: !7457, type: !7424, flags: DIFlagArtificial | DIFlagObjectPointer)
!7462 = !DILocation(line: 0, scope: !7457)
!7463 = !DILocation(line: 731, column: 9, scope: !7464)
!7464 = distinct !DILexicalBlock(scope: !7457, file: !349, line: 731, column: 9)
!7465 = !DILocation(line: 731, column: 9, scope: !7457)
!7466 = !DILocation(line: 732, column: 14, scope: !7467)
!7467 = distinct !DILexicalBlock(scope: !7464, file: !349, line: 731, column: 72)
!7468 = !DILocation(line: 732, column: 7, scope: !7467)
!7469 = !DILocation(line: 734, column: 33, scope: !7457)
!7470 = !DILocation(line: 734, column: 52, scope: !7457)
!7471 = !DILocation(line: 734, column: 5, scope: !7457)
!7472 = !DILocation(line: 735, column: 3, scope: !7457)
!7473 = distinct !DISubprogram(name: "maybe_wrap_dim", linkageName: "_ZN3c1014maybe_wrap_dimEllb", scope: !36, file: !6530, line: 34, type: !7474, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !843)
!7474 = !DISubroutineType(types: !7475)
!7475 = !{!648, !648, !648, !378}
!7476 = !DILocalVariable(name: "dim", arg: 1, scope: !7473, file: !6530, line: 35, type: !648)
!7477 = !DILocation(line: 35, column: 13, scope: !7473)
!7478 = !DILocalVariable(name: "dim_post_expr", arg: 2, scope: !7473, file: !6530, line: 36, type: !648)
!7479 = !DILocation(line: 36, column: 13, scope: !7473)
!7480 = !DILocalVariable(name: "wrap_scalar", arg: 3, scope: !7473, file: !6530, line: 37, type: !378)
!7481 = !DILocation(line: 37, column: 10, scope: !7473)
!7482 = !DILocation(line: 38, column: 26, scope: !7473)
!7483 = !DILocation(line: 38, column: 31, scope: !7473)
!7484 = !DILocation(line: 38, column: 46, scope: !7473)
!7485 = !DILocation(line: 38, column: 10, scope: !7473)
!7486 = !DILocation(line: 38, column: 3, scope: !7473)
!7487 = distinct !DISubprogram(name: "size_at_unchecked", linkageName: "_ZNK3c104impl15SizesAndStrides17size_at_uncheckedEm", scope: !7489, file: !7488, line: 218, type: !7491, scopeLine: 218, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7495, retainedNodes: !843)
!7488 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/core/impl/SizesAndStrides.h", directory: "/home/mvh6224/CUDA-BOSolver")
!7489 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "SizesAndStrides", scope: !7490, file: !7488, line: 23, size: 704, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSN3c104impl15SizesAndStridesE")
!7490 = !DINamespace(name: "impl", scope: !36)
!7491 = !DISubroutineType(types: !7492)
!7492 = !{!648, !7493, !1288}
!7493 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7494, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!7494 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7489)
!7495 = !DISubprogram(name: "size_at_unchecked", linkageName: "_ZNK3c104impl15SizesAndStrides17size_at_uncheckedEm", scope: !7489, file: !7488, line: 218, type: !7491, scopeLine: 218, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!7496 = !DILocalVariable(name: "this", arg: 1, scope: !7487, type: !7497, flags: DIFlagArtificial | DIFlagObjectPointer)
!7497 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7494, size: 64)
!7498 = !DILocation(line: 0, scope: !7487)
!7499 = !DILocalVariable(name: "idx", arg: 2, scope: !7487, file: !7488, line: 218, type: !1288)
!7500 = !DILocation(line: 218, column: 36, scope: !7487)
!7501 = !DILocation(line: 219, column: 12, scope: !7487)
!7502 = !DILocation(line: 219, column: 25, scope: !7487)
!7503 = !DILocation(line: 219, column: 5, scope: !7487)
!7504 = distinct !DISubprogram(name: "sizes_data", linkageName: "_ZNK3c104impl15SizesAndStrides10sizes_dataEv", scope: !7489, file: !7488, line: 117, type: !7505, scopeLine: 117, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7509, retainedNodes: !843)
!7505 = !DISubroutineType(types: !7506)
!7506 = !{!7507, !7493}
!7507 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7508, size: 64)
!7508 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !648)
!7509 = !DISubprogram(name: "sizes_data", linkageName: "_ZNK3c104impl15SizesAndStrides10sizes_dataEv", scope: !7489, file: !7488, line: 117, type: !7505, scopeLine: 117, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!7510 = !DILocalVariable(name: "this", arg: 1, scope: !7504, type: !7497, flags: DIFlagArtificial | DIFlagObjectPointer)
!7511 = !DILocation(line: 0, scope: !7504)
!7512 = !DILocation(line: 118, column: 9, scope: !7513)
!7513 = distinct !DILexicalBlock(scope: !7504, file: !7488, line: 118, column: 9)
!7514 = !DILocation(line: 118, column: 9, scope: !7504)
!7515 = !DILocation(line: 119, column: 15, scope: !7516)
!7516 = distinct !DILexicalBlock(scope: !7513, file: !7488, line: 118, column: 33)
!7517 = !DILocation(line: 119, column: 7, scope: !7516)
!7518 = !DILocation(line: 121, column: 15, scope: !7519)
!7519 = distinct !DILexicalBlock(scope: !7513, file: !7488, line: 120, column: 12)
!7520 = !DILocation(line: 121, column: 7, scope: !7519)
!7521 = !DILocation(line: 123, column: 3, scope: !7504)
!7522 = distinct !DISubprogram(name: "isInline", linkageName: "_ZNK3c104impl15SizesAndStrides8isInlineEv", scope: !7489, file: !7488, line: 270, type: !7523, scopeLine: 270, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7525, retainedNodes: !843)
!7523 = !DISubroutineType(types: !7524)
!7524 = !{!378, !7493}
!7525 = !DISubprogram(name: "isInline", linkageName: "_ZNK3c104impl15SizesAndStrides8isInlineEv", scope: !7489, file: !7488, line: 270, type: !7523, scopeLine: 270, flags: DIFlagPrototyped, spFlags: 0)
!7526 = !DILocalVariable(name: "this", arg: 1, scope: !7522, type: !7497, flags: DIFlagArtificial | DIFlagObjectPointer)
!7527 = !DILocation(line: 0, scope: !7522)
!7528 = !DILocation(line: 271, column: 12, scope: !7522)
!7529 = !DILocation(line: 271, column: 18, scope: !7522)
!7530 = !DILocation(line: 271, column: 5, scope: !7522)
!7531 = distinct !DISubprogram(name: "_maybe_wrap_dim<long>", linkageName: "_ZN3c1015_maybe_wrap_dimIlEET_S1_S1_b", scope: !36, file: !6530, line: 19, type: !7532, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, templateParams: !7534, retainedNodes: !843)
!7532 = !DISubroutineType(types: !7533)
!7533 = !{!575, !575, !575, !378}
!7534 = !{!7535}
!7535 = !DITemplateTypeParameter(name: "T", type: !575)
!7536 = !DILocalVariable(name: "dim", arg: 1, scope: !7531, file: !6530, line: 19, type: !575)
!7537 = !DILocation(line: 19, column: 21, scope: !7531)
!7538 = !DILocalVariable(name: "dim_post_expr", arg: 2, scope: !7531, file: !6530, line: 19, type: !575)
!7539 = !DILocation(line: 19, column: 28, scope: !7531)
!7540 = !DILocalVariable(name: "wrap_scalar", arg: 3, scope: !7531, file: !6530, line: 19, type: !378)
!7541 = !DILocation(line: 19, column: 48, scope: !7531)
!7542 = !DILocation(line: 21, column: 7, scope: !7543)
!7543 = distinct !DILexicalBlock(scope: !7531, file: !6530, line: 21, column: 7)
!7544 = !DILocation(line: 0, scope: !7543)
!7545 = !DILocation(line: 21, column: 7, scope: !7531)
!7546 = !DILocation(line: 24, column: 9, scope: !7547)
!7547 = distinct !DILexicalBlock(scope: !7548, file: !6530, line: 24, column: 9)
!7548 = distinct !DILexicalBlock(scope: !7543, file: !6530, line: 21, column: 69)
!7549 = !DILocation(line: 24, column: 13, scope: !7547)
!7550 = !DILocation(line: 24, column: 9, scope: !7548)
!7551 = !DILocation(line: 25, column: 14, scope: !7552)
!7552 = distinct !DILexicalBlock(scope: !7547, file: !6530, line: 24, column: 18)
!7553 = !DILocation(line: 25, column: 20, scope: !7552)
!7554 = !DILocation(line: 25, column: 18, scope: !7552)
!7555 = !DILocation(line: 25, column: 7, scope: !7552)
!7556 = !DILocation(line: 27, column: 12, scope: !7548)
!7557 = !DILocation(line: 27, column: 5, scope: !7548)
!7558 = !DILocation(line: 31, column: 7, scope: !7531)
!7559 = !DILocation(line: 31, column: 23, scope: !7531)
!7560 = !DILocation(line: 31, column: 49, scope: !7531)
!7561 = !DILocation(line: 30, column: 10, scope: !7531)
!7562 = !DILocation(line: 30, column: 3, scope: !7531)
!7563 = !DILocation(line: 32, column: 1, scope: !7531)
!7564 = distinct !DISubprogram(name: "move<long &>", linkageName: "_ZSt4moveIRlEONSt16remove_referenceIT_E4typeEOS2_", scope: !2, file: !7565, line: 104, type: !7566, scopeLine: 105, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, templateParams: !7571, retainedNodes: !843)
!7565 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/bits/move.h", directory: "")
!7566 = !DISubroutineType(types: !7567)
!7567 = !{!7568, !7573}
!7568 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !7569, size: 64)
!7569 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !7570, file: !764, line: 1602, baseType: !575)
!7570 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "remove_reference<long &>", scope: !2, file: !764, line: 1601, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !7571, identifier: "_ZTSSt16remove_referenceIRlE")
!7571 = !{!7572}
!7572 = !DITemplateTypeParameter(name: "_Tp", type: !7573)
!7573 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !575, size: 64)
!7574 = !DILocalVariable(name: "__t", arg: 1, scope: !7564, file: !7565, line: 104, type: !7573)
!7575 = !DILocation(line: 104, column: 16, scope: !7564)
!7576 = !DILocation(line: 105, column: 71, scope: !7564)
!7577 = !DILocation(line: 105, column: 7, scope: !7564)
!7578 = distinct !DISubprogram(name: "size", linkageName: "_ZNK3c104impl15SizesAndStrides4sizeEv", scope: !7489, file: !7488, line: 113, type: !7579, scopeLine: 113, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7581, retainedNodes: !843)
!7579 = !DISubroutineType(types: !7580)
!7580 = !{!1288, !7493}
!7581 = !DISubprogram(name: "size", linkageName: "_ZNK3c104impl15SizesAndStrides4sizeEv", scope: !7489, file: !7488, line: 113, type: !7579, scopeLine: 113, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!7582 = !DILocalVariable(name: "this", arg: 1, scope: !7578, type: !7497, flags: DIFlagArtificial | DIFlagObjectPointer)
!7583 = !DILocation(line: 0, scope: !7578)
!7584 = !DILocation(line: 114, column: 12, scope: !7578)
!7585 = !DILocation(line: 114, column: 5, scope: !7578)
!7586 = distinct !DISubprogram(name: "numel", linkageName: "_ZNK3c1010TensorImpl5numelEv", scope: !350, file: !349, line: 697, type: !7458, scopeLine: 697, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7587, retainedNodes: !843)
!7587 = !DISubprogram(name: "numel", linkageName: "_ZNK3c1010TensorImpl5numelEv", scope: !350, file: !349, line: 697, type: !7458, scopeLine: 697, flags: DIFlagPrototyped, spFlags: 0)
!7588 = !DILocalVariable(name: "this", arg: 1, scope: !7586, type: !7424, flags: DIFlagArtificial | DIFlagObjectPointer)
!7589 = !DILocation(line: 0, scope: !7586)
!7590 = !DILocation(line: 698, column: 9, scope: !7591)
!7591 = distinct !DILexicalBlock(scope: !7586, file: !349, line: 698, column: 9)
!7592 = !DILocation(line: 698, column: 9, scope: !7586)
!7593 = !DILocation(line: 699, column: 14, scope: !7594)
!7594 = distinct !DILexicalBlock(scope: !7591, file: !349, line: 698, column: 72)
!7595 = !DILocation(line: 699, column: 7, scope: !7594)
!7596 = !DILocation(line: 701, column: 12, scope: !7586)
!7597 = !DILocation(line: 701, column: 5, scope: !7586)
!7598 = !DILocation(line: 702, column: 3, scope: !7586)
!7599 = distinct !DISubprogram(name: "is_contiguous", linkageName: "_ZNK3c1010TensorImpl13is_contiguousENS_12MemoryFormatE", scope: !350, file: !349, line: 822, type: !7600, scopeLine: 823, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7602, retainedNodes: !843)
!7600 = !DISubroutineType(types: !7601)
!7601 = !{!378, !7420, !271}
!7602 = !DISubprogram(name: "is_contiguous", linkageName: "_ZNK3c1010TensorImpl13is_contiguousENS_12MemoryFormatE", scope: !350, file: !349, line: 822, type: !7600, scopeLine: 822, flags: DIFlagPrototyped, spFlags: 0)
!7603 = !DILocalVariable(name: "this", arg: 1, scope: !7599, type: !7424, flags: DIFlagArtificial | DIFlagObjectPointer)
!7604 = !DILocation(line: 0, scope: !7599)
!7605 = !DILocalVariable(name: "memory_format", arg: 2, scope: !7599, file: !349, line: 823, type: !271)
!7606 = !DILocation(line: 823, column: 24, scope: !7599)
!7607 = !DILocation(line: 824, column: 9, scope: !7608)
!7608 = distinct !DILexicalBlock(scope: !7599, file: !349, line: 824, column: 9)
!7609 = !DILocation(line: 824, column: 9, scope: !7599)
!7610 = !DILocation(line: 825, column: 35, scope: !7611)
!7611 = distinct !DILexicalBlock(scope: !7608, file: !349, line: 824, column: 74)
!7612 = !DILocation(line: 825, column: 14, scope: !7611)
!7613 = !DILocation(line: 825, column: 7, scope: !7611)
!7614 = !DILocation(line: 827, column: 34, scope: !7599)
!7615 = !DILocation(line: 827, column: 12, scope: !7599)
!7616 = !DILocation(line: 827, column: 5, scope: !7599)
!7617 = !DILocation(line: 828, column: 3, scope: !7599)
!7618 = distinct !DISubprogram(name: "is_contiguous_default", linkageName: "_ZNK3c1010TensorImpl21is_contiguous_defaultENS_12MemoryFormatE", scope: !350, file: !349, line: 832, type: !7600, scopeLine: 832, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7619, retainedNodes: !843)
!7619 = !DISubprogram(name: "is_contiguous_default", linkageName: "_ZNK3c1010TensorImpl21is_contiguous_defaultENS_12MemoryFormatE", scope: !350, file: !349, line: 832, type: !7600, scopeLine: 832, flags: DIFlagPrototyped, spFlags: 0)
!7620 = !DILocalVariable(name: "this", arg: 1, scope: !7618, type: !7424, flags: DIFlagArtificial | DIFlagObjectPointer)
!7621 = !DILocation(line: 0, scope: !7618)
!7622 = !DILocalVariable(name: "memory_format", arg: 2, scope: !7618, file: !349, line: 832, type: !271)
!7623 = !DILocation(line: 832, column: 47, scope: !7618)
!7624 = !DILocation(line: 833, column: 9, scope: !7625)
!7625 = distinct !DILexicalBlock(scope: !7618, file: !349, line: 833, column: 9)
!7626 = !DILocation(line: 833, column: 9, scope: !7618)
!7627 = !DILocation(line: 834, column: 11, scope: !7628)
!7628 = distinct !DILexicalBlock(scope: !7629, file: !349, line: 834, column: 11)
!7629 = distinct !DILexicalBlock(scope: !7625, file: !349, line: 833, column: 38)
!7630 = !DILocation(line: 834, column: 25, scope: !7628)
!7631 = !DILocation(line: 834, column: 11, scope: !7629)
!7632 = !DILocation(line: 835, column: 16, scope: !7633)
!7633 = distinct !DILexicalBlock(scope: !7628, file: !349, line: 834, column: 60)
!7634 = !DILocation(line: 835, column: 38, scope: !7633)
!7635 = !DILocation(line: 835, column: 68, scope: !7633)
!7636 = !DILocation(line: 835, column: 9, scope: !7633)
!7637 = !DILocation(line: 837, column: 18, scope: !7638)
!7638 = distinct !DILexicalBlock(scope: !7628, file: !349, line: 837, column: 18)
!7639 = !DILocation(line: 837, column: 32, scope: !7638)
!7640 = !DILocation(line: 837, column: 18, scope: !7628)
!7641 = !DILocation(line: 838, column: 16, scope: !7642)
!7642 = distinct !DILexicalBlock(scope: !7638, file: !349, line: 837, column: 69)
!7643 = !DILocation(line: 839, column: 14, scope: !7642)
!7644 = !DILocation(line: 840, column: 14, scope: !7642)
!7645 = !DILocation(line: 838, column: 9, scope: !7642)
!7646 = !DILocation(line: 842, column: 14, scope: !7629)
!7647 = !DILocation(line: 842, column: 36, scope: !7629)
!7648 = !DILocation(line: 842, column: 52, scope: !7629)
!7649 = !DILocation(line: 842, column: 7, scope: !7629)
!7650 = !DILocation(line: 846, column: 9, scope: !7651)
!7651 = distinct !DILexicalBlock(scope: !7618, file: !349, line: 846, column: 9)
!7652 = !DILocation(line: 846, column: 23, scope: !7651)
!7653 = !DILocation(line: 846, column: 9, scope: !7618)
!7654 = !DILocation(line: 847, column: 14, scope: !7655)
!7655 = distinct !DILexicalBlock(scope: !7651, file: !349, line: 846, column: 58)
!7656 = !DILocation(line: 847, column: 7, scope: !7655)
!7657 = !DILocation(line: 848, column: 16, scope: !7658)
!7658 = distinct !DILexicalBlock(scope: !7651, file: !349, line: 848, column: 16)
!7659 = !DILocation(line: 848, column: 30, scope: !7658)
!7660 = !DILocation(line: 848, column: 16, scope: !7651)
!7661 = !DILocation(line: 849, column: 14, scope: !7662)
!7662 = distinct !DILexicalBlock(scope: !7658, file: !349, line: 848, column: 67)
!7663 = !DILocation(line: 849, column: 7, scope: !7662)
!7664 = !DILocation(line: 851, column: 12, scope: !7618)
!7665 = !DILocation(line: 851, column: 5, scope: !7618)
!7666 = !DILocation(line: 852, column: 3, scope: !7618)
!7667 = distinct !DISubprogram(name: "symbolic_shape_meta", linkageName: "_ZNK3c1010TensorImpl19symbolic_shape_metaEv", scope: !350, file: !349, line: 1732, type: !7668, scopeLine: 1732, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7670, retainedNodes: !843)
!7668 = !DISubroutineType(types: !7669)
!7669 = !{!630, !7420}
!7670 = !DISubprogram(name: "symbolic_shape_meta", linkageName: "_ZNK3c1010TensorImpl19symbolic_shape_metaEv", scope: !350, file: !349, line: 1732, type: !7668, scopeLine: 1732, flags: DIFlagPrivate | DIFlagPrototyped, spFlags: 0)
!7671 = !DILocalVariable(name: "this", arg: 1, scope: !7667, type: !7424, flags: DIFlagArtificial | DIFlagObjectPointer)
!7672 = !DILocation(line: 0, scope: !7667)
!7673 = !DILocation(line: 1733, column: 5, scope: !7674)
!7674 = distinct !DILexicalBlock(scope: !7667, file: !349, line: 1733, column: 5)
!7675 = !DILocation(line: 1733, column: 5, scope: !7667)
!7676 = !DILocation(line: 1733, column: 5, scope: !7677)
!7677 = distinct !DILexicalBlock(scope: !7674, file: !349, line: 1733, column: 5)
!7678 = !DILocation(line: 1734, column: 13, scope: !7667)
!7679 = !DILocation(line: 1734, column: 26, scope: !7667)
!7680 = !DILocation(line: 1734, column: 12, scope: !7667)
!7681 = !DILocation(line: 1734, column: 5, scope: !7667)
!7682 = distinct !DISubprogram(name: "is_channels_last_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta27is_channels_last_contiguousEv", scope: !366, file: !365, line: 92, type: !666, scopeLine: 92, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !670, retainedNodes: !843)
!7683 = !DILocalVariable(name: "this", arg: 1, scope: !7682, type: !7684, flags: DIFlagArtificial | DIFlagObjectPointer)
!7684 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !631, size: 64)
!7685 = !DILocation(line: 0, scope: !7682)
!7686 = !DILocation(line: 93, column: 9, scope: !7687)
!7687 = distinct !DILexicalBlock(scope: !7682, file: !365, line: 93, column: 9)
!7688 = !DILocation(line: 93, column: 9, scope: !7682)
!7689 = !DILocation(line: 94, column: 7, scope: !7690)
!7690 = distinct !DILexicalBlock(scope: !7687, file: !365, line: 93, column: 59)
!7691 = !DILocation(line: 95, column: 5, scope: !7690)
!7692 = !DILocation(line: 96, column: 12, scope: !7682)
!7693 = !DILocation(line: 96, column: 5, scope: !7682)
!7694 = distinct !DISubprogram(name: "is_channels_last_3d_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta30is_channels_last_3d_contiguousEv", scope: !366, file: !365, line: 99, type: !666, scopeLine: 99, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !671, retainedNodes: !843)
!7695 = !DILocalVariable(name: "this", arg: 1, scope: !7694, type: !7684, flags: DIFlagArtificial | DIFlagObjectPointer)
!7696 = !DILocation(line: 0, scope: !7694)
!7697 = !DILocation(line: 100, column: 9, scope: !7698)
!7698 = distinct !DILexicalBlock(scope: !7694, file: !365, line: 100, column: 9)
!7699 = !DILocation(line: 100, column: 9, scope: !7694)
!7700 = !DILocation(line: 101, column: 7, scope: !7701)
!7701 = distinct !DILexicalBlock(scope: !7698, file: !365, line: 100, column: 62)
!7702 = !DILocation(line: 102, column: 5, scope: !7701)
!7703 = !DILocation(line: 103, column: 12, scope: !7694)
!7704 = !DILocation(line: 103, column: 5, scope: !7694)
!7705 = distinct !DISubprogram(name: "is_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta13is_contiguousEv", scope: !366, file: !365, line: 85, type: !666, scopeLine: 85, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !665, retainedNodes: !843)
!7706 = !DILocalVariable(name: "this", arg: 1, scope: !7705, type: !7684, flags: DIFlagArtificial | DIFlagObjectPointer)
!7707 = !DILocation(line: 0, scope: !7705)
!7708 = !DILocation(line: 86, column: 9, scope: !7709)
!7709 = distinct !DILexicalBlock(scope: !7705, file: !365, line: 86, column: 9)
!7710 = !DILocation(line: 86, column: 9, scope: !7705)
!7711 = !DILocation(line: 87, column: 7, scope: !7712)
!7712 = distinct !DILexicalBlock(scope: !7709, file: !365, line: 86, column: 45)
!7713 = !DILocation(line: 88, column: 5, scope: !7712)
!7714 = !DILocation(line: 89, column: 12, scope: !7705)
!7715 = !DILocation(line: 89, column: 5, scope: !7705)
!7716 = distinct !DISubprogram(name: "has_is_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta17has_is_contiguousEv", scope: !366, file: !365, line: 57, type: !652, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !654, retainedNodes: !843)
!7717 = !DILocalVariable(name: "this", arg: 1, scope: !7716, type: !7684, flags: DIFlagArtificial | DIFlagObjectPointer)
!7718 = !DILocation(line: 0, scope: !7716)
!7719 = !DILocation(line: 58, column: 12, scope: !7716)
!7720 = !DILocalVariable(name: "this", arg: 1, scope: !7721, type: !7722, flags: DIFlagArtificial | DIFlagObjectPointer)
!7721 = distinct !DISubprogram(name: "load", linkageName: "_ZNKSt13__atomic_baseIiE4loadESt12memory_order", scope: !384, file: !356, line: 481, type: !467, scopeLine: 482, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !466, retainedNodes: !843)
!7722 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !399, size: 64)
!7723 = !DILocation(line: 0, scope: !7721, inlinedAt: !7724)
!7724 = distinct !DILocation(line: 58, column: 23, scope: !7716)
!7725 = !DILocalVariable(name: "__m", arg: 2, scope: !7721, file: !356, line: 481, type: !462)
!7726 = !DILocation(line: 481, column: 25, scope: !7721, inlinedAt: !7724)
!7727 = !DILocalVariable(name: "__b", scope: !7721, file: !356, line: 483, type: !462)
!7728 = !DILocation(line: 483, column: 15, scope: !7721, inlinedAt: !7724)
!7729 = !DILocation(line: 484, column: 6, scope: !7721, inlinedAt: !7724)
!7730 = !DILocation(line: 484, column: 10, scope: !7721, inlinedAt: !7724)
!7731 = !DILocation(line: 488, column: 26, scope: !7721, inlinedAt: !7724)
!7732 = !DILocation(line: 488, column: 36, scope: !7721, inlinedAt: !7724)
!7733 = !DILocation(line: 488, column: 9, scope: !7721, inlinedAt: !7724)
!7734 = !DILocation(line: 58, column: 30, scope: !7716)
!7735 = !DILocation(line: 58, column: 5, scope: !7716)
!7736 = distinct !DISubprogram(name: "operator&", linkageName: "_ZStanSt12memory_orderSt23__memory_order_modifier", scope: !2, file: !356, line: 104, type: !7737, scopeLine: 105, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !843)
!7737 = !DISubroutineType(types: !7738)
!7738 = !{!462, !462, !725}
!7739 = !DILocalVariable(name: "__m", arg: 1, scope: !7736, file: !356, line: 104, type: !462)
!7740 = !DILocation(line: 104, column: 26, scope: !7736)
!7741 = !DILocalVariable(name: "__mod", arg: 2, scope: !7736, file: !356, line: 104, type: !725)
!7742 = !DILocation(line: 104, column: 55, scope: !7736)
!7743 = !DILocation(line: 106, column: 29, scope: !7736)
!7744 = !DILocation(line: 106, column: 40, scope: !7736)
!7745 = !DILocation(line: 106, column: 34, scope: !7736)
!7746 = !DILocation(line: 106, column: 5, scope: !7736)
!7747 = distinct !DISubprogram(name: "has_is_channels_last_3d_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta34has_is_channels_last_3d_contiguousEv", scope: !366, file: !365, line: 63, type: !652, scopeLine: 63, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !656, retainedNodes: !843)
!7748 = !DILocalVariable(name: "this", arg: 1, scope: !7747, type: !7684, flags: DIFlagArtificial | DIFlagObjectPointer)
!7749 = !DILocation(line: 0, scope: !7747)
!7750 = !DILocation(line: 64, column: 12, scope: !7747)
!7751 = !DILocation(line: 0, scope: !7721, inlinedAt: !7752)
!7752 = distinct !DILocation(line: 64, column: 23, scope: !7747)
!7753 = !DILocation(line: 481, column: 25, scope: !7721, inlinedAt: !7752)
!7754 = !DILocation(line: 483, column: 15, scope: !7721, inlinedAt: !7752)
!7755 = !DILocation(line: 484, column: 6, scope: !7721, inlinedAt: !7752)
!7756 = !DILocation(line: 484, column: 10, scope: !7721, inlinedAt: !7752)
!7757 = !DILocation(line: 488, column: 26, scope: !7721, inlinedAt: !7752)
!7758 = !DILocation(line: 488, column: 36, scope: !7721, inlinedAt: !7752)
!7759 = !DILocation(line: 488, column: 9, scope: !7721, inlinedAt: !7752)
!7760 = !DILocation(line: 64, column: 30, scope: !7747)
!7761 = !DILocation(line: 64, column: 5, scope: !7747)
!7762 = distinct !DISubprogram(name: "has_is_channels_last_contiguous", linkageName: "_ZNK3c1017SymbolicShapeMeta31has_is_channels_last_contiguousEv", scope: !366, file: !365, line: 60, type: !652, scopeLine: 60, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !655, retainedNodes: !843)
!7763 = !DILocalVariable(name: "this", arg: 1, scope: !7762, type: !7684, flags: DIFlagArtificial | DIFlagObjectPointer)
!7764 = !DILocation(line: 0, scope: !7762)
!7765 = !DILocation(line: 61, column: 12, scope: !7762)
!7766 = !DILocation(line: 0, scope: !7721, inlinedAt: !7767)
!7767 = distinct !DILocation(line: 61, column: 23, scope: !7762)
!7768 = !DILocation(line: 481, column: 25, scope: !7721, inlinedAt: !7767)
!7769 = !DILocation(line: 483, column: 15, scope: !7721, inlinedAt: !7767)
!7770 = !DILocation(line: 484, column: 6, scope: !7721, inlinedAt: !7767)
!7771 = !DILocation(line: 484, column: 10, scope: !7721, inlinedAt: !7767)
!7772 = !DILocation(line: 488, column: 26, scope: !7721, inlinedAt: !7767)
!7773 = !DILocation(line: 488, column: 36, scope: !7721, inlinedAt: !7767)
!7774 = !DILocation(line: 488, column: 9, scope: !7721, inlinedAt: !7767)
!7775 = !DILocation(line: 61, column: 30, scope: !7762)
!7776 = !DILocation(line: 61, column: 5, scope: !7762)
!7777 = distinct !DISubprogram(name: "operator bool", linkageName: "_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEcvbEv", scope: !4407, file: !2996, line: 435, type: !4707, scopeLine: 436, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !4706, retainedNodes: !843)
!7778 = !DILocalVariable(name: "this", arg: 1, scope: !7777, type: !7779, flags: DIFlagArtificial | DIFlagObjectPointer)
!7779 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4690, size: 64)
!7780 = !DILocation(line: 0, scope: !7777)
!7781 = !DILocation(line: 436, column: 16, scope: !7777)
!7782 = !DILocation(line: 436, column: 22, scope: !7777)
!7783 = !DILocation(line: 436, column: 9, scope: !7777)
!7784 = distinct !DISubprogram(name: "operator->", linkageName: "_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EEptEv", scope: !4407, file: !2996, line: 413, type: !4692, scopeLine: 414, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !4691, retainedNodes: !843)
!7785 = !DILocalVariable(name: "this", arg: 1, scope: !7784, type: !7779, flags: DIFlagArtificial | DIFlagObjectPointer)
!7786 = !DILocation(line: 0, scope: !7784)
!7787 = !DILocation(line: 416, column: 9, scope: !7784)
!7788 = !DILocation(line: 416, column: 2, scope: !7784)
!7789 = distinct !DISubprogram(name: "operator bool", linkageName: "_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEcvbEv", scope: !3783, file: !2996, line: 435, type: !3825, scopeLine: 436, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !3824, retainedNodes: !843)
!7790 = !DILocalVariable(name: "this", arg: 1, scope: !7789, type: !7791, flags: DIFlagArtificial | DIFlagObjectPointer)
!7791 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3808, size: 64)
!7792 = !DILocation(line: 0, scope: !7789)
!7793 = !DILocation(line: 436, column: 16, scope: !7789)
!7794 = !DILocation(line: 436, column: 22, scope: !7789)
!7795 = !DILocation(line: 436, column: 9, scope: !7789)
!7796 = distinct !DISubprogram(name: "str<>", linkageName: "_ZN3c103strIJEEEDcDpRKT_", scope: !36, file: !7797, line: 124, type: !7798, scopeLine: 124, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, templateParams: !7810, retainedNodes: !843)
!7797 = !DIFile(filename: ".vllm_cuda/lib/python3.10/site-packages/torch/include/c10/util/StringUtil.h", directory: "/home/mvh6224/CUDA-BOSolver")
!7798 = !DISubroutineType(types: !7799)
!7799 = !{!7800}
!7800 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "CompileTimeEmptyString", scope: !7342, file: !7797, line: 28, size: 8, flags: DIFlagTypePassByValue, elements: !7801, identifier: "_ZTSN3c106detail22CompileTimeEmptyStringE")
!7801 = !{!7802, !7807}
!7802 = !DISubprogram(name: "operator const std::basic_string<char> &", linkageName: "_ZNK3c106detail22CompileTimeEmptyStringcvRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEv", scope: !7800, file: !7797, line: 29, type: !7803, scopeLine: 29, flags: DIFlagPrototyped, spFlags: 0)
!7803 = !DISubroutineType(types: !7804)
!7804 = !{!1410, !7805}
!7805 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7806, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!7806 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7800)
!7807 = !DISubprogram(name: "operator const char *", linkageName: "_ZNK3c106detail22CompileTimeEmptyStringcvPKcEv", scope: !7800, file: !7797, line: 33, type: !7808, scopeLine: 33, flags: DIFlagPrototyped, spFlags: 0)
!7808 = !DISubroutineType(types: !7809)
!7809 = !{!1452, !7805}
!7810 = !{!7811}
!7811 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "Args", value: !843)
!7812 = !DILocation(line: 125, column: 10, scope: !7796)
!7813 = !DILocation(line: 125, column: 3, scope: !7796)
!7814 = distinct !DISubprogram(name: "torchInternalAssertFail", linkageName: "_ZN3c106detail23torchInternalAssertFailEPKcS2_jS2_NS0_22CompileTimeEmptyStringE", scope: !7342, file: !7341, line: 516, type: !7815, scopeLine: 521, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !843)
!7815 = !DISubroutineType(types: !7816)
!7816 = !{null, !1452, !1452, !732, !1452, !7800}
!7817 = !DILocalVariable(name: "func", arg: 1, scope: !7814, file: !7341, line: 517, type: !1452)
!7818 = !DILocation(line: 517, column: 17, scope: !7814)
!7819 = !DILocalVariable(name: "file", arg: 2, scope: !7814, file: !7341, line: 518, type: !1452)
!7820 = !DILocation(line: 518, column: 17, scope: !7814)
!7821 = !DILocalVariable(name: "line", arg: 3, scope: !7814, file: !7341, line: 519, type: !732)
!7822 = !DILocation(line: 519, column: 14, scope: !7814)
!7823 = !DILocalVariable(name: "condMsg", arg: 4, scope: !7814, file: !7341, line: 520, type: !1452)
!7824 = !DILocation(line: 520, column: 17, scope: !7814)
!7825 = !DILocalVariable(arg: 5, scope: !7814, file: !7341, line: 521, type: !7800)
!7826 = !DILocation(line: 521, column: 54, scope: !7814)
!7827 = !DILocation(line: 522, column: 18, scope: !7814)
!7828 = !DILocation(line: 522, column: 24, scope: !7814)
!7829 = !DILocation(line: 522, column: 30, scope: !7814)
!7830 = !DILocation(line: 522, column: 36, scope: !7814)
!7831 = !DILocation(line: 522, column: 3, scope: !7814)
!7832 = distinct !DISubprogram(name: "operator*", linkageName: "_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEdeEv", scope: !3783, file: !2996, line: 405, type: !3802, scopeLine: 406, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !3801, retainedNodes: !843)
!7833 = !DILocalVariable(name: "this", arg: 1, scope: !7832, type: !7791, flags: DIFlagArtificial | DIFlagObjectPointer)
!7834 = !DILocation(line: 0, scope: !7832)
!7835 = !DILocation(line: 407, column: 2, scope: !7832)
!7836 = !DILocation(line: 407, column: 2, scope: !7837)
!7837 = distinct !DILexicalBlock(scope: !7832, file: !2996, line: 407, column: 2)
!7838 = !DILocation(line: 408, column: 10, scope: !7832)
!7839 = !DILocation(line: 408, column: 2, scope: !7832)
!7840 = distinct !DISubprogram(name: "get", linkageName: "_ZNKSt10unique_ptrIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE3getEv", scope: !3783, file: !2996, line: 421, type: !3810, scopeLine: 422, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !3813, retainedNodes: !843)
!7841 = !DILocalVariable(name: "this", arg: 1, scope: !7840, type: !7791, flags: DIFlagArtificial | DIFlagObjectPointer)
!7842 = !DILocation(line: 0, scope: !7840)
!7843 = !DILocation(line: 422, column: 16, scope: !7840)
!7844 = !DILocation(line: 422, column: 21, scope: !7840)
!7845 = !DILocation(line: 422, column: 9, scope: !7840)
!7846 = distinct !DISubprogram(name: "_M_ptr", linkageName: "_ZNKSt15__uniq_ptr_implIN3c1017SymbolicShapeMetaESt14default_deleteIS1_EE6_M_ptrEv", scope: !3722, file: !2996, line: 173, type: !3751, scopeLine: 173, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !3750, retainedNodes: !843)
!7847 = !DILocalVariable(name: "this", arg: 1, scope: !7846, type: !7848, flags: DIFlagArtificial | DIFlagObjectPointer)
!7848 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3754, size: 64)
!7849 = !DILocation(line: 0, scope: !7846)
!7850 = !DILocation(line: 173, column: 54, scope: !7846)
!7851 = !DILocation(line: 173, column: 42, scope: !7846)
!7852 = !DILocation(line: 173, column: 35, scope: !7846)
!7853 = distinct !DISubprogram(name: "get<0UL, c10::SymbolicShapeMeta *, std::default_delete<c10::SymbolicShapeMeta> >", linkageName: "_ZSt3getILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_", scope: !2, file: !3014, line: 1399, type: !7854, scopeLine: 1400, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, templateParams: !7865, retainedNodes: !843)
!7854 = !DISubroutineType(types: !7855)
!7855 = !{!7856, !3697}
!7856 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !7857, size: 64)
!7857 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7858)
!7858 = !DIDerivedType(tag: DW_TAG_typedef, name: "__tuple_element_t<0UL, tuple<c10::SymbolicShapeMeta *, std::default_delete<c10::SymbolicShapeMeta> > >", scope: !2, file: !7859, line: 118, baseType: !7860)
!7859 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/11/../../../../include/c++/11/utility", directory: "")
!7860 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !7861, file: !3014, line: 1362, baseType: !3536)
!7861 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tuple_element<0, std::tuple<c10::SymbolicShapeMeta *, std::default_delete<c10::SymbolicShapeMeta> > >", scope: !2, file: !3014, line: 1360, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !7862, identifier: "_ZTSSt13tuple_elementILm0ESt5tupleIJPN3c1017SymbolicShapeMetaESt14default_deleteIS2_EEEE")
!7862 = !{!7863, !7864}
!7863 = !DITemplateValueParameter(name: "_Int", type: !1290, value: i64 0)
!7864 = !DITemplateTypeParameter(name: "_Tp", type: !3689)
!7865 = !{!7866, !3686}
!7866 = !DITemplateValueParameter(name: "__i", type: !1290, value: i64 0)
!7867 = !DILocalVariable(name: "__t", arg: 1, scope: !7853, file: !3014, line: 1399, type: !3697)
!7868 = !DILocation(line: 1399, column: 36, scope: !7853)
!7869 = !DILocation(line: 1400, column: 37, scope: !7853)
!7870 = !DILocation(line: 1400, column: 14, scope: !7853)
!7871 = !DILocation(line: 1400, column: 7, scope: !7853)
!7872 = distinct !DISubprogram(name: "__get_helper<0UL, c10::SymbolicShapeMeta *, std::default_delete<c10::SymbolicShapeMeta> >", linkageName: "_ZSt12__get_helperILm0EPN3c1017SymbolicShapeMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE", scope: !2, file: !3014, line: 1382, type: !3651, scopeLine: 1383, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, templateParams: !7873, retainedNodes: !843)
!7873 = !{!7866, !3641, !7874}
!7874 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "_Tail", value: !3606)
!7875 = !DILocalVariable(name: "__t", arg: 1, scope: !7872, file: !3014, line: 1382, type: !3653)
!7876 = !DILocation(line: 1382, column: 59, scope: !7872)
!7877 = !DILocation(line: 1383, column: 57, scope: !7872)
!7878 = !DILocation(line: 1383, column: 14, scope: !7872)
!7879 = !DILocation(line: 1383, column: 7, scope: !7872)
!7880 = distinct !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c1017SymbolicShapeMetaESt14default_deleteIS1_EEE7_M_headERKS5_", scope: !3642, file: !3014, line: 271, type: !3651, scopeLine: 271, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !3650, retainedNodes: !843)
!7881 = !DILocalVariable(name: "__t", arg: 1, scope: !7880, file: !3014, line: 271, type: !3653)
!7882 = !DILocation(line: 271, column: 34, scope: !7880)
!7883 = !DILocation(line: 271, column: 72, scope: !7880)
!7884 = !DILocation(line: 271, column: 57, scope: !7880)
!7885 = !DILocation(line: 271, column: 50, scope: !7880)
!7886 = distinct !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm0EPN3c1017SymbolicShapeMetaELb0EE7_M_headERKS3_", scope: !3608, file: !3014, line: 236, type: !3638, scopeLine: 236, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !3637, retainedNodes: !843)
!7887 = !DILocalVariable(name: "__b", arg: 1, scope: !7886, file: !3014, line: 236, type: !3623)
!7888 = !DILocation(line: 236, column: 33, scope: !7886)
!7889 = !DILocation(line: 236, column: 56, scope: !7886)
!7890 = !DILocation(line: 236, column: 60, scope: !7886)
!7891 = !DILocation(line: 236, column: 49, scope: !7886)
!7892 = distinct !DISubprogram(name: "call", linkageName: "_ZN3c106detail12_str_wrapperIJEE4callEv", scope: !7893, file: !7797, line: 115, type: !7798, scopeLine: 115, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !7895, retainedNodes: !843)
!7893 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_str_wrapper<>", scope: !7342, file: !7797, line: 114, size: 8, flags: DIFlagTypePassByValue, elements: !7894, templateParams: !7810, identifier: "_ZTSN3c106detail12_str_wrapperIJEEE")
!7894 = !{!7895}
!7895 = !DISubprogram(name: "call", linkageName: "_ZN3c106detail12_str_wrapperIJEE4callEv", scope: !7893, file: !7797, line: 115, type: !7798, scopeLine: 115, flags: DIFlagPrototyped | DIFlagStaticMember, spFlags: 0)
!7896 = !DILocation(line: 116, column: 5, scope: !7892)
!7897 = distinct !DISubprogram(name: "get", linkageName: "_ZNKSt10unique_ptrIN3c109ExtraMetaESt14default_deleteIS1_EE3getEv", scope: !4407, file: !2996, line: 421, type: !4692, scopeLine: 422, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !4695, retainedNodes: !843)
!7898 = !DILocalVariable(name: "this", arg: 1, scope: !7897, type: !7779, flags: DIFlagArtificial | DIFlagObjectPointer)
!7899 = !DILocation(line: 0, scope: !7897)
!7900 = !DILocation(line: 422, column: 16, scope: !7897)
!7901 = !DILocation(line: 422, column: 21, scope: !7897)
!7902 = !DILocation(line: 422, column: 9, scope: !7897)
!7903 = distinct !DISubprogram(name: "_M_ptr", linkageName: "_ZNKSt15__uniq_ptr_implIN3c109ExtraMetaESt14default_deleteIS1_EE6_M_ptrEv", scope: !4413, file: !2996, line: 173, type: !4639, scopeLine: 173, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !4638, retainedNodes: !843)
!7904 = !DILocalVariable(name: "this", arg: 1, scope: !7903, type: !7905, flags: DIFlagArtificial | DIFlagObjectPointer)
!7905 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4642, size: 64)
!7906 = !DILocation(line: 0, scope: !7903)
!7907 = !DILocation(line: 173, column: 54, scope: !7903)
!7908 = !DILocation(line: 173, column: 42, scope: !7903)
!7909 = !DILocation(line: 173, column: 35, scope: !7903)
!7910 = distinct !DISubprogram(name: "get<0UL, c10::ExtraMeta *, std::default_delete<c10::ExtraMeta> >", linkageName: "_ZSt3getILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_", scope: !2, file: !3014, line: 1399, type: !7911, scopeLine: 1400, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, templateParams: !7920, retainedNodes: !843)
!7911 = !DISubroutineType(types: !7912)
!7912 = !{!7913, !4588}
!7913 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !7914, size: 64)
!7914 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7915)
!7915 = !DIDerivedType(tag: DW_TAG_typedef, name: "__tuple_element_t<0UL, tuple<c10::ExtraMeta *, std::default_delete<c10::ExtraMeta> > >", scope: !2, file: !7859, line: 118, baseType: !7916)
!7916 = !DIDerivedType(tag: DW_TAG_typedef, name: "type", scope: !7917, file: !3014, line: 1362, baseType: !4439)
!7917 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tuple_element<0, std::tuple<c10::ExtraMeta *, std::default_delete<c10::ExtraMeta> > >", scope: !2, file: !3014, line: 1360, size: 8, flags: DIFlagTypePassByValue, elements: !843, templateParams: !7918, identifier: "_ZTSSt13tuple_elementILm0ESt5tupleIJPN3c109ExtraMetaESt14default_deleteIS2_EEEE")
!7918 = !{!7863, !7919}
!7919 = !DITemplateTypeParameter(name: "_Tp", type: !4416)
!7920 = !{!7866, !4580}
!7921 = !DILocalVariable(name: "__t", arg: 1, scope: !7910, file: !3014, line: 1399, type: !4588)
!7922 = !DILocation(line: 1399, column: 36, scope: !7910)
!7923 = !DILocation(line: 1400, column: 37, scope: !7910)
!7924 = !DILocation(line: 1400, column: 14, scope: !7910)
!7925 = !DILocation(line: 1400, column: 7, scope: !7910)
!7926 = distinct !DISubprogram(name: "__get_helper<0UL, c10::ExtraMeta *, std::default_delete<c10::ExtraMeta> >", linkageName: "_ZSt12__get_helperILm0EPN3c109ExtraMetaEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE", scope: !2, file: !3014, line: 1382, type: !4545, scopeLine: 1383, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, templateParams: !7927, retainedNodes: !843)
!7927 = !{!7866, !4539, !7928}
!7928 = !DITemplateValueParameter(tag: DW_TAG_GNU_template_parameter_pack, name: "_Tail", value: !4503)
!7929 = !DILocalVariable(name: "__t", arg: 1, scope: !7926, file: !3014, line: 1382, type: !4547)
!7930 = !DILocation(line: 1382, column: 59, scope: !7926)
!7931 = !DILocation(line: 1383, column: 57, scope: !7926)
!7932 = !DILocation(line: 1383, column: 14, scope: !7926)
!7933 = !DILocation(line: 1383, column: 7, scope: !7926)
!7934 = distinct !DISubprogram(name: "_M_head", linkageName: "_ZNSt11_Tuple_implILm0EJPN3c109ExtraMetaESt14default_deleteIS1_EEE7_M_headERKS5_", scope: !4419, file: !3014, line: 271, type: !4545, scopeLine: 271, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !4544, retainedNodes: !843)
!7935 = !DILocalVariable(name: "__t", arg: 1, scope: !7934, file: !3014, line: 271, type: !4547)
!7936 = !DILocation(line: 271, column: 34, scope: !7934)
!7937 = !DILocation(line: 271, column: 72, scope: !7934)
!7938 = !DILocation(line: 271, column: 57, scope: !7934)
!7939 = !DILocation(line: 271, column: 50, scope: !7934)
!7940 = distinct !DISubprogram(name: "_M_head", linkageName: "_ZNSt10_Head_baseILm0EPN3c109ExtraMetaELb0EE7_M_headERKS3_", scope: !4506, file: !3014, line: 236, type: !4536, scopeLine: 236, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, declaration: !4535, retainedNodes: !843)
!7941 = !DILocalVariable(name: "__b", arg: 1, scope: !7940, file: !3014, line: 236, type: !4521)
!7942 = !DILocation(line: 236, column: 33, scope: !7940)
!7943 = !DILocation(line: 236, column: 56, scope: !7940)
!7944 = !DILocation(line: 236, column: 60, scope: !7940)
!7945 = !DILocation(line: 236, column: 49, scope: !7940)
!7946 = distinct !DISubprogram(name: "static_scaled_int8_quant_kernel_buggy", linkageName: "_Z37static_scaled_int8_quant_kernel_buggyPKfPaS0_i", scope: !5712, file: !5712, line: 20, type: !7248, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !6904, retainedNodes: !843)
!7947 = !DILocalVariable(name: "input", arg: 1, scope: !7946, file: !5712, line: 21, type: !7250)
!7948 = !DILocation(line: 21, column: 31, scope: !7946)
!7949 = !DILocalVariable(name: "out", arg: 2, scope: !7946, file: !5712, line: 22, type: !7253)
!7950 = !DILocation(line: 22, column: 26, scope: !7946)
!7951 = !DILocalVariable(name: "scale_ptr", arg: 3, scope: !7946, file: !5712, line: 23, type: !7250)
!7952 = !DILocation(line: 23, column: 31, scope: !7946)
!7953 = !DILocalVariable(name: "hidden_size", arg: 4, scope: !7946, file: !5712, line: 24, type: !256)
!7954 = !DILocation(line: 24, column: 9, scope: !7946)
!7955 = !DILocalVariable(name: "tid", scope: !7946, file: !5712, line: 26, type: !256)
!7956 = !DILocation(line: 26, column: 9, scope: !7946)
!7957 = !DILocation(line: 53, column: 3, scope: !7958, inlinedAt: !7959)
!7958 = distinct !DISubprogram(name: "__fetch_builtin_x", linkageName: "_ZN26__cuda_builtin_threadIdx_t17__fetch_builtin_xEv", scope: !6907, file: !6908, line: 53, type: !6911, scopeLine: 53, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !6904, declaration: !6910, retainedNodes: !843)
!7959 = distinct !DILocation(line: 26, column: 21, scope: !7946)
!7960 = !DILocalVariable(name: "token_idx", scope: !7946, file: !5712, line: 27, type: !256)
!7961 = !DILocation(line: 27, column: 9, scope: !7946)
!7962 = !DILocation(line: 66, column: 3, scope: !7963, inlinedAt: !7964)
!7963 = distinct !DISubprogram(name: "__fetch_builtin_x", linkageName: "_ZN25__cuda_builtin_blockIdx_t17__fetch_builtin_xEv", scope: !6938, file: !6908, line: 66, type: !6911, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !6904, declaration: !6940, retainedNodes: !843)
!7964 = distinct !DILocation(line: 27, column: 21, scope: !7946)
!7965 = !DILocalVariable(name: "scale", scope: !7946, file: !5712, line: 28, type: !4737)
!7966 = !DILocation(line: 28, column: 11, scope: !7946)
!7967 = !DILocation(line: 28, column: 22, scope: !7946)
!7968 = !DILocation(line: 28, column: 21, scope: !7946)
!7969 = !DILocation(line: 31, column: 14, scope: !7946)
!7970 = !DILocation(line: 31, column: 26, scope: !7946)
!7971 = !DILocation(line: 31, column: 24, scope: !7946)
!7972 = !DILocation(line: 31, column: 11, scope: !7946)
!7973 = !DILocation(line: 32, column: 14, scope: !7946)
!7974 = !DILocation(line: 32, column: 26, scope: !7946)
!7975 = !DILocation(line: 32, column: 24, scope: !7946)
!7976 = !DILocation(line: 32, column: 11, scope: !7946)
!7977 = !DILocalVariable(name: "i", scope: !7978, file: !5712, line: 38, type: !256)
!7978 = distinct !DILexicalBlock(scope: !7946, file: !5712, line: 38, column: 5)
!7979 = !DILocation(line: 38, column: 14, scope: !7978)
!7980 = !DILocation(line: 38, column: 18, scope: !7978)
!7981 = !DILocation(line: 38, column: 10, scope: !7978)
!7982 = !DILocation(line: 38, column: 23, scope: !7983)
!7983 = distinct !DILexicalBlock(scope: !7978, file: !5712, line: 38, column: 5)
!7984 = !DILocation(line: 38, column: 27, scope: !7983)
!7985 = !DILocation(line: 38, column: 25, scope: !7983)
!7986 = !DILocation(line: 38, column: 5, scope: !7978)
!7987 = !DILocalVariable(name: "idx", scope: !7988, file: !5712, line: 39, type: !256)
!7988 = distinct !DILexicalBlock(scope: !7983, file: !5712, line: 38, column: 57)
!7989 = !DILocation(line: 39, column: 13, scope: !7988)
!7990 = !DILocation(line: 39, column: 19, scope: !7988)
!7991 = !DILocation(line: 39, column: 31, scope: !7988)
!7992 = !DILocation(line: 39, column: 29, scope: !7988)
!7993 = !DILocation(line: 39, column: 45, scope: !7988)
!7994 = !DILocation(line: 39, column: 43, scope: !7988)
!7995 = !DILocalVariable(name: "v", scope: !7988, file: !5712, line: 40, type: !4737)
!7996 = !DILocation(line: 40, column: 15, scope: !7988)
!7997 = !DILocation(line: 40, column: 19, scope: !7988)
!7998 = !DILocation(line: 40, column: 25, scope: !7988)
!7999 = !DILocation(line: 40, column: 32, scope: !7988)
!8000 = !DILocation(line: 40, column: 30, scope: !7988)
!8001 = !DILocation(line: 41, column: 37, scope: !7988)
!8002 = !DILocation(line: 41, column: 20, scope: !7988)
!8003 = !DILocation(line: 41, column: 9, scope: !7988)
!8004 = !DILocation(line: 41, column: 13, scope: !7988)
!8005 = !DILocation(line: 41, column: 18, scope: !7988)
!8006 = !DILocation(line: 42, column: 5, scope: !7988)
!8007 = !DILocation(line: 79, column: 3, scope: !8008, inlinedAt: !8009)
!8008 = distinct !DISubprogram(name: "__fetch_builtin_x", linkageName: "_ZN25__cuda_builtin_blockDim_t17__fetch_builtin_xEv", scope: !6966, file: !6908, line: 79, type: !6911, scopeLine: 79, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !6904, declaration: !6968, retainedNodes: !843)
!8009 = distinct !DILocation(line: 38, column: 45, scope: !7983)
!8010 = !DILocation(line: 38, column: 42, scope: !7983)
!8011 = !DILocation(line: 38, column: 5, scope: !7983)
!8012 = distinct !{!8012, !7986, !8013, !8014}
!8013 = !DILocation(line: 42, column: 5, scope: !7978)
!8014 = !{!"llvm.loop.mustprogress"}
!8015 = !DILocation(line: 43, column: 1, scope: !7946)
!8016 = distinct !DISubprogram(name: "float_to_int8_rn", linkageName: "_Z16float_to_int8_rnf", scope: !5712, file: !5712, line: 11, type: !8017, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !6904, retainedNodes: !843)
!8017 = !DISubroutineType(types: !8018)
!8018 = !{!37, !4737}
!8019 = !DILocalVariable(name: "x", arg: 1, scope: !8016, file: !5712, line: 11, type: !4737)
!8020 = !DILocation(line: 11, column: 49, scope: !8016)
!8021 = !DILocalVariable(name: "v", scope: !8016, file: !5712, line: 13, type: !256)
!8022 = !DILocation(line: 13, column: 9, scope: !8016)
!8023 = !DILocation(line: 13, column: 28, scope: !8016)
!8024 = !DILocalVariable(name: "__a", arg: 1, scope: !8025, file: !6253, line: 232, type: !4737)
!8025 = distinct !DISubprogram(name: "__float2int_rn", linkageName: "_ZL14__float2int_rnf", scope: !6253, file: !6253, line: 232, type: !4790, scopeLine: 232, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !6904, retainedNodes: !843)
!8026 = !DILocation(line: 232, column: 37, scope: !8025, inlinedAt: !8027)
!8027 = distinct !DILocation(line: 13, column: 13, scope: !8016)
!8028 = !DILocation(line: 232, column: 69, scope: !8025, inlinedAt: !8027)
!8029 = !DILocation(line: 232, column: 51, scope: !8025, inlinedAt: !8027)
!8030 = !DILocation(line: 14, column: 9, scope: !8031)
!8031 = distinct !DILexicalBlock(scope: !8016, file: !5712, line: 14, column: 9)
!8032 = !DILocation(line: 14, column: 11, scope: !8031)
!8033 = !DILocation(line: 14, column: 9, scope: !8016)
!8034 = !DILocation(line: 14, column: 21, scope: !8031)
!8035 = !DILocation(line: 14, column: 19, scope: !8031)
!8036 = !DILocation(line: 15, column: 9, scope: !8037)
!8037 = distinct !DILexicalBlock(scope: !8016, file: !5712, line: 15, column: 9)
!8038 = !DILocation(line: 15, column: 11, scope: !8037)
!8039 = !DILocation(line: 15, column: 9, scope: !8016)
!8040 = !DILocation(line: 15, column: 21, scope: !8037)
!8041 = !DILocation(line: 15, column: 19, scope: !8037)
!8042 = !DILocation(line: 16, column: 32, scope: !8016)
!8043 = !DILocation(line: 16, column: 5, scope: !8016)
