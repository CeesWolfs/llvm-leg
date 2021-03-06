; RUN: llc -filetype=obj < %s | llvm-dwarfdump -debug-dump=info - | FileCheck %s

; Check debug info output for merged global.
; DW_AT_location
; 0x03 DW_OP_addr
; 0x.. .long __MergedGlobals
; 0x10 DW_OP_constu
; 0x.. offset
; 0x22 DW_OP_plus

; CHECK: DW_TAG_variable
; CHECK-NOT: DW_TAG
; CHECK:    DW_AT_name {{.*}} "x1"
; CHECK-NOT: {{DW_TAG|NULL}}
; CHECK:    DW_AT_location [DW_FORM_exprloc]        (<0x8> 03 [[ADDR:.. .. .. ..]] 10 00 22  )
; CHECK: DW_TAG_variable
; CHECK-NOT: DW_TAG
; CHECK:    DW_AT_name {{.*}} "x2"
; CHECK-NOT: {{DW_TAG|NULL}}
; CHECK:    DW_AT_location [DW_FORM_exprloc]        (<0x8> 03 [[ADDR]] 10 04 22  )

target datalayout = "e-p:32:32:32-i1:8:32-i8:8:32-i16:16:32-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:32:64-v128:32:128-a0:0:32-n32"
target triple = "thumbv7-apple-macosx10.7.0"

@x1 = internal unnamed_addr global i32 1, align 4
@x2 = internal unnamed_addr global i32 2, align 4
@x3 = internal unnamed_addr global i32 3, align 4
@x4 = internal unnamed_addr global i32 4, align 4
@x5 = global i32 0, align 4

define i32 @get1(i32 %a) nounwind optsize ssp {
  tail call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !10, metadata !{metadata !"0x102"}), !dbg !30
  %1 = load i32* @x1, align 4, !dbg !31
  tail call void @llvm.dbg.value(metadata !{i32 %1}, i64 0, metadata !11, metadata !{metadata !"0x102"}), !dbg !31
  store i32 %a, i32* @x1, align 4, !dbg !31
  ret i32 %1, !dbg !31
}

define i32 @get2(i32 %a) nounwind optsize ssp {
  tail call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !13, metadata !{metadata !"0x102"}), !dbg !32
  %1 = load i32* @x2, align 4, !dbg !33
  tail call void @llvm.dbg.value(metadata !{i32 %1}, i64 0, metadata !14, metadata !{metadata !"0x102"}), !dbg !33
  store i32 %a, i32* @x2, align 4, !dbg !33
  ret i32 %1, !dbg !33
}

define i32 @get3(i32 %a) nounwind optsize ssp {
  tail call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !16, metadata !{metadata !"0x102"}), !dbg !34
  %1 = load i32* @x3, align 4, !dbg !35
  tail call void @llvm.dbg.value(metadata !{i32 %1}, i64 0, metadata !17, metadata !{metadata !"0x102"}), !dbg !35
  store i32 %a, i32* @x3, align 4, !dbg !35
  ret i32 %1, !dbg !35
}

define i32 @get4(i32 %a) nounwind optsize ssp {
  tail call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !19, metadata !{metadata !"0x102"}), !dbg !36
  %1 = load i32* @x4, align 4, !dbg !37
  tail call void @llvm.dbg.value(metadata !{i32 %1}, i64 0, metadata !20, metadata !{metadata !"0x102"}), !dbg !37
  store i32 %a, i32* @x4, align 4, !dbg !37
  ret i32 %1, !dbg !37
}

define i32 @get5(i32 %a) nounwind optsize ssp {
  tail call void @llvm.dbg.value(metadata !{i32 %a}, i64 0, metadata !27, metadata !{metadata !"0x102"}), !dbg !38
  %1 = load i32* @x5, align 4, !dbg !39
  tail call void @llvm.dbg.value(metadata !{i32 %1}, i64 0, metadata !28, metadata !{metadata !"0x102"}), !dbg !39
  store i32 %a, i32* @x5, align 4, !dbg !39
  ret i32 %1, !dbg !39
}

declare void @llvm.dbg.value(metadata, i64, metadata, metadata) nounwind readnone

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!49}

!0 = metadata !{metadata !"0x11\0012\00clang\001\00\000\00\001", metadata !47, metadata !48, metadata !48, metadata !40, metadata !41,  metadata !48} ; [ DW_TAG_compile_unit ]
!1 = metadata !{metadata !"0x2e\00get1\00get1\00\005\000\001\000\006\00256\001\005", metadata !47, metadata !2, metadata !3, null, i32 (i32)* @get1, null, null, metadata !42} ; [ DW_TAG_subprogram ] [line 5] [def] [get1]
!2 = metadata !{metadata !"0x29", metadata !47} ; [ DW_TAG_file_type ]
!3 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", metadata !47, metadata !2, null, metadata !4, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!4 = metadata !{metadata !5}
!5 = metadata !{metadata !"0x24\00int\000\0032\0032\000\000\005", null, metadata !0} ; [ DW_TAG_base_type ]
!6 = metadata !{metadata !"0x2e\00get2\00get2\00\008\000\001\000\006\00256\001\008", metadata !47, metadata !2, metadata !3, null, i32 (i32)* @get2, null, null, metadata !43} ; [ DW_TAG_subprogram ] [line 8] [def] [get2]
!7 = metadata !{metadata !"0x2e\00get3\00get3\00\0011\000\001\000\006\00256\001\0011", metadata !47, metadata !2, metadata !3, null, i32 (i32)* @get3, null, null, metadata !44} ; [ DW_TAG_subprogram ] [line 11] [def] [get3]
!8 = metadata !{metadata !"0x2e\00get4\00get4\00\0014\000\001\000\006\00256\001\0014", metadata !47, metadata !2, metadata !3, null, i32 (i32)* @get4, null, null, metadata !45} ; [ DW_TAG_subprogram ] [line 14] [def] [get4]
!9 = metadata !{metadata !"0x2e\00get5\00get5\00\0017\000\001\000\006\00256\001\0017", metadata !47, metadata !2, metadata !3, null, i32 (i32)* @get5, null, null, metadata !46} ; [ DW_TAG_subprogram ] [line 17] [def] [get5]
!10 = metadata !{metadata !"0x101\00a\0016777221\000", metadata !1, metadata !2, metadata !5} ; [ DW_TAG_arg_variable ]
!11 = metadata !{metadata !"0x100\00b\005\000", metadata !12, metadata !2, metadata !5} ; [ DW_TAG_auto_variable ]
!12 = metadata !{metadata !"0xb\005\0019\000", metadata !47, metadata !1} ; [ DW_TAG_lexical_block ]
!13 = metadata !{metadata !"0x101\00a\0016777224\000", metadata !6, metadata !2, metadata !5} ; [ DW_TAG_arg_variable ]
!14 = metadata !{metadata !"0x100\00b\008\000", metadata !15, metadata !2, metadata !5} ; [ DW_TAG_auto_variable ]
!15 = metadata !{metadata !"0xb\008\0017\001", metadata !47, metadata !6} ; [ DW_TAG_lexical_block ]
!16 = metadata !{metadata !"0x101\00a\0016777227\000", metadata !7, metadata !2, metadata !5} ; [ DW_TAG_arg_variable ]
!17 = metadata !{metadata !"0x100\00b\0011\000", metadata !18, metadata !2, metadata !5} ; [ DW_TAG_auto_variable ]
!18 = metadata !{metadata !"0xb\0011\0019\002", metadata !47, metadata !7} ; [ DW_TAG_lexical_block ]
!19 = metadata !{metadata !"0x101\00a\0016777230\000", metadata !8, metadata !2, metadata !5} ; [ DW_TAG_arg_variable ]
!20 = metadata !{metadata !"0x100\00b\0014\000", metadata !21, metadata !2, metadata !5} ; [ DW_TAG_auto_variable ]
!21 = metadata !{metadata !"0xb\0014\0019\003", metadata !47, metadata !8} ; [ DW_TAG_lexical_block ]
!25 = metadata !{metadata !"0x34\00x1\00x1\00\004\001\001", metadata !0, metadata !2, metadata !5, i32* @x1, null} ; [ DW_TAG_variable ]
!26 = metadata !{metadata !"0x34\00x2\00x2\00\007\001\001", metadata !0, metadata !2, metadata !5, i32* @x2, null} ; [ DW_TAG_variable ]
!27 = metadata !{metadata !"0x101\00a\0016777233\000", metadata !9, metadata !2, metadata !5} ; [ DW_TAG_arg_variable ]
!28 = metadata !{metadata !"0x100\00b\0017\000", metadata !29, metadata !2, metadata !5} ; [ DW_TAG_auto_variable ]
!29 = metadata !{metadata !"0xb\0017\0019\004", metadata !47, metadata !9} ; [ DW_TAG_lexical_block ]
!30 = metadata !{i32 5, i32 16, metadata !1, null}
!31 = metadata !{i32 5, i32 32, metadata !12, null}
!32 = metadata !{i32 8, i32 14, metadata !6, null}
!33 = metadata !{i32 8, i32 29, metadata !15, null}
!34 = metadata !{i32 11, i32 16, metadata !7, null}
!35 = metadata !{i32 11, i32 32, metadata !18, null}
!36 = metadata !{i32 14, i32 16, metadata !8, null}
!37 = metadata !{i32 14, i32 32, metadata !21, null}
!38 = metadata !{i32 17, i32 16, metadata !9, null}
!39 = metadata !{i32 17, i32 32, metadata !29, null}
!40 = metadata !{metadata !1, metadata !6, metadata !7, metadata !8, metadata !9}
!41 = metadata !{metadata !25, metadata !26}
!42 = metadata !{metadata !10, metadata !11}
!43 = metadata !{metadata !13, metadata !14}
!44 = metadata !{metadata !16, metadata !17}
!45 = metadata !{metadata !19, metadata !20}
!46 = metadata !{metadata !27, metadata !28}
!47 = metadata !{metadata !"ss3.c", metadata !"/private/tmp"}
!48 = metadata !{}
!49 = metadata !{i32 1, metadata !"Debug Info Version", i32 2}
