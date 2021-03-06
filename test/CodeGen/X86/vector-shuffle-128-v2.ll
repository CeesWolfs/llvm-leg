; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -x86-experimental-vector-shuffle-lowering | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mattr=+sse3 -x86-experimental-vector-shuffle-lowering | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE3
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mattr=+ssse3 -x86-experimental-vector-shuffle-lowering | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSSE3
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mattr=+sse4.1 -x86-experimental-vector-shuffle-lowering | FileCheck %s --check-prefix=ALL --check-prefix=SSE --check-prefix=SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mattr=+avx -x86-experimental-vector-shuffle-lowering | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -mattr=+avx2 -x86-experimental-vector-shuffle-lowering | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX2

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-unknown"

define <2 x i64> @shuffle_v2i64_00(<2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_00:
; SSE:       # BB#0:
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,1,0,1]
; SSE-NEXT:    retq
;
; AVX1-LABEL: shuffle_v2i64_00:
; AVX1:       # BB#0:
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,1,0,1]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v2i64_00:
; AVX2:       # BB#0:
; AVX2-NEXT:    vpbroadcastq %xmm0, %xmm0
; AVX2-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 0, i32 0>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_10(<2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_10:
; SSE:       # BB#0:
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_10:
; AVX:       # BB#0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_11(<2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_11:
; SSE:       # BB#0:
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,2,3]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_11:
; AVX:       # BB#0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,2,3]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 1, i32 1>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_22(<2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_22:
; SSE:       # BB#0:
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[0,1,0,1]
; SSE-NEXT:    retq
;
; AVX1-LABEL: shuffle_v2i64_22:
; AVX1:       # BB#0:
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm1[0,1,0,1]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v2i64_22:
; AVX2:       # BB#0:
; AVX2-NEXT:    vpbroadcastq %xmm1, %xmm0
; AVX2-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 2, i32 2>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_32(<2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_32:
; SSE:       # BB#0:
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_32:
; AVX:       # BB#0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 3, i32 2>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_33(<2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_33:
; SSE:       # BB#0:
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,2,3]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_33:
; AVX:       # BB#0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm0 = xmm1[2,3,2,3]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 3, i32 3>
  ret <2 x i64> %shuffle
}

define <2 x double> @shuffle_v2f64_00(<2 x double> %a, <2 x double> %b) {
; SSE2-LABEL: shuffle_v2f64_00:
; SSE2:       # BB#0:
; SSE2-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0,0]
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2f64_00:
; SSE3:       # BB#0:
; SSE3-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0,0]
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2f64_00:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0,0]
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2f64_00:
; SSE41:       # BB#0:
; SSE41-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0,0]
; SSE41-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_00:
; AVX:       # BB#0:
; AVX-NEXT:    vunpcklpd {{.*#+}} xmm0 = xmm0[0,0]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> %b, <2 x i32> <i32 0, i32 0>
  ret <2 x double> %shuffle
}
define <2 x double> @shuffle_v2f64_10(<2 x double> %a, <2 x double> %b) {
; SSE-LABEL: shuffle_v2f64_10:
; SSE:       # BB#0:
; SSE-NEXT:    shufpd {{.*#+}} xmm0 = xmm0[1,0]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_10:
; AVX:       # BB#0:
; AVX-NEXT:    vpermilpd {{.*#+}} xmm0 = xmm0[1,0]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> %b, <2 x i32> <i32 1, i32 0>
  ret <2 x double> %shuffle
}
define <2 x double> @shuffle_v2f64_11(<2 x double> %a, <2 x double> %b) {
; SSE-LABEL: shuffle_v2f64_11:
; SSE:       # BB#0:
; SSE-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_11:
; AVX:       # BB#0:
; AVX-NEXT:    vmovhlps {{.*#+}} xmm0 = xmm0[1,1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> %b, <2 x i32> <i32 1, i32 1>
  ret <2 x double> %shuffle
}
define <2 x double> @shuffle_v2f64_22(<2 x double> %a, <2 x double> %b) {
; SSE2-LABEL: shuffle_v2f64_22:
; SSE2:       # BB#0:
; SSE2-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0,0]
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2f64_22:
; SSE3:       # BB#0:
; SSE3-NEXT:    unpcklpd {{.*#+}} xmm1 = xmm1[0,0]
; SSE3-NEXT:    movapd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2f64_22:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    unpcklpd {{.*#+}} xmm1 = xmm1[0,0]
; SSSE3-NEXT:    movapd %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2f64_22:
; SSE41:       # BB#0:
; SSE41-NEXT:    unpcklpd {{.*#+}} xmm1 = xmm1[0,0]
; SSE41-NEXT:    movapd %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_22:
; AVX:       # BB#0:
; AVX-NEXT:    vunpcklpd {{.*#+}} xmm0 = xmm1[0,0]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> %b, <2 x i32> <i32 2, i32 2>
  ret <2 x double> %shuffle
}
define <2 x double> @shuffle_v2f64_32(<2 x double> %a, <2 x double> %b) {
; SSE-LABEL: shuffle_v2f64_32:
; SSE:       # BB#0:
; SSE-NEXT:    shufpd {{.*#+}} xmm1 = xmm1[1,0]
; SSE-NEXT:    movapd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_32:
; AVX:       # BB#0:
; AVX-NEXT:    vpermilpd {{.*#+}} xmm0 = xmm1[1,0]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> %b, <2 x i32> <i32 3, i32 2>
  ret <2 x double> %shuffle
}
define <2 x double> @shuffle_v2f64_33(<2 x double> %a, <2 x double> %b) {
; SSE-LABEL: shuffle_v2f64_33:
; SSE:       # BB#0:
; SSE-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE-NEXT:    movaps %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_33:
; AVX:       # BB#0:
; AVX-NEXT:    vmovhlps {{.*#+}} xmm0 = xmm1[1,1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> %b, <2 x i32> <i32 3, i32 3>
  ret <2 x double> %shuffle
}
define <2 x double> @shuffle_v2f64_03(<2 x double> %a, <2 x double> %b) {
; SSE2-LABEL: shuffle_v2f64_03:
; SSE2:       # BB#0:
; SSE2-NEXT:    movsd %xmm0, %xmm1
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2f64_03:
; SSE3:       # BB#0:
; SSE3-NEXT:    movsd %xmm0, %xmm1
; SSE3-NEXT:    movaps %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2f64_03:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movsd %xmm0, %xmm1
; SSSE3-NEXT:    movaps %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2f64_03:
; SSE41:       # BB#0:
; SSE41-NEXT:    blendpd {{.*#+}} xmm0 = xmm0[0],xmm1[1]
; SSE41-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_03:
; AVX:       # BB#0:
; AVX-NEXT:    vblendpd {{.*#+}} xmm0 = xmm0[0],xmm1[1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> %b, <2 x i32> <i32 0, i32 3>
  ret <2 x double> %shuffle
}
define <2 x double> @shuffle_v2f64_21(<2 x double> %a, <2 x double> %b) {
; SSE2-LABEL: shuffle_v2f64_21:
; SSE2:       # BB#0:
; SSE2-NEXT:    movsd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2f64_21:
; SSE3:       # BB#0:
; SSE3-NEXT:    movsd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2f64_21:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movsd %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2f64_21:
; SSE41:       # BB#0:
; SSE41-NEXT:    blendpd {{.*#+}} xmm1 = xmm1[0],xmm0[1]
; SSE41-NEXT:    movapd %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_21:
; AVX:       # BB#0:
; AVX-NEXT:    vblendpd {{.*#+}} xmm0 = xmm1[0],xmm0[1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> %b, <2 x i32> <i32 2, i32 1>
  ret <2 x double> %shuffle
}


define <2 x i64> @shuffle_v2i64_02(<2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_02:
; SSE:       # BB#0:
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_02:
; AVX:       # BB#0:
; AVX-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 0, i32 2>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_02_copy(<2 x i64> %nonce, <2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_02_copy:
; SSE:       # BB#0:
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_02_copy:
; AVX:       # BB#0:
; AVX-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm2[0]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 0, i32 2>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_03(<2 x i64> %a, <2 x i64> %b) {
; SSE2-LABEL: shuffle_v2i64_03:
; SSE2:       # BB#0:
; SSE2-NEXT:    movsd %xmm0, %xmm1
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2i64_03:
; SSE3:       # BB#0:
; SSE3-NEXT:    movsd %xmm0, %xmm1
; SSE3-NEXT:    movaps %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2i64_03:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movsd %xmm0, %xmm1
; SSSE3-NEXT:    movaps %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2i64_03:
; SSE41:       # BB#0:
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    retq
;
; AVX1-LABEL: shuffle_v2i64_03:
; AVX1:       # BB#0:
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1,2,3],xmm1[4,5,6,7]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v2i64_03:
; AVX2:       # BB#0:
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3]
; AVX2-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 0, i32 3>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_03_copy(<2 x i64> %nonce, <2 x i64> %a, <2 x i64> %b) {
; SSE2-LABEL: shuffle_v2i64_03_copy:
; SSE2:       # BB#0:
; SSE2-NEXT:    movsd %xmm1, %xmm2
; SSE2-NEXT:    movaps %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2i64_03_copy:
; SSE3:       # BB#0:
; SSE3-NEXT:    movsd %xmm1, %xmm2
; SSE3-NEXT:    movaps %xmm2, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2i64_03_copy:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movsd %xmm1, %xmm2
; SSSE3-NEXT:    movaps %xmm2, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2i64_03_copy:
; SSE41:       # BB#0:
; SSE41-NEXT:    pblendw {{.*#+}} xmm1 = xmm1[0,1,2,3],xmm2[4,5,6,7]
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: shuffle_v2i64_03_copy:
; AVX1:       # BB#0:
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0,1,2,3],xmm2[4,5,6,7]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v2i64_03_copy:
; AVX2:       # BB#0:
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm1[0,1],xmm2[2,3]
; AVX2-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 0, i32 3>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_12(<2 x i64> %a, <2 x i64> %b) {
; SSE2-LABEL: shuffle_v2i64_12:
; SSE2:       # BB#0:
; SSE2-NEXT:    shufpd {{.*#+}} xmm0 = xmm0[1],xmm1[0]
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2i64_12:
; SSE3:       # BB#0:
; SSE3-NEXT:    shufpd {{.*#+}} xmm0 = xmm0[1],xmm1[0]
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2i64_12:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    palignr {{.*#+}} xmm1 = xmm0[8,9,10,11,12,13,14,15],xmm1[0,1,2,3,4,5,6,7]
; SSSE3-NEXT:    movdqa %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2i64_12:
; SSE41:       # BB#0:
; SSE41-NEXT:    palignr {{.*#+}} xmm1 = xmm0[8,9,10,11,12,13,14,15],xmm1[0,1,2,3,4,5,6,7]
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_12:
; AVX:       # BB#0:
; AVX-NEXT:    vpalignr {{.*#+}} xmm0 = xmm0[8,9,10,11,12,13,14,15],xmm1[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 1, i32 2>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_12_copy(<2 x i64> %nonce, <2 x i64> %a, <2 x i64> %b) {
; SSE2-LABEL: shuffle_v2i64_12_copy:
; SSE2:       # BB#0:
; SSE2-NEXT:    shufpd {{.*#+}} xmm1 = xmm1[1],xmm2[0]
; SSE2-NEXT:    movapd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2i64_12_copy:
; SSE3:       # BB#0:
; SSE3-NEXT:    shufpd {{.*#+}} xmm1 = xmm1[1],xmm2[0]
; SSE3-NEXT:    movapd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2i64_12_copy:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    palignr {{.*#+}} xmm2 = xmm1[8,9,10,11,12,13,14,15],xmm2[0,1,2,3,4,5,6,7]
; SSSE3-NEXT:    movdqa %xmm2, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2i64_12_copy:
; SSE41:       # BB#0:
; SSE41-NEXT:    palignr {{.*#+}} xmm2 = xmm1[8,9,10,11,12,13,14,15],xmm2[0,1,2,3,4,5,6,7]
; SSE41-NEXT:    movdqa %xmm2, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_12_copy:
; AVX:       # BB#0:
; AVX-NEXT:    vpalignr {{.*#+}} xmm0 = xmm1[8,9,10,11,12,13,14,15],xmm2[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 1, i32 2>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_13(<2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_13:
; SSE:       # BB#0:
; SSE-NEXT:    punpckhqdq {{.*#+}} xmm0 = xmm0[1],xmm1[1]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_13:
; AVX:       # BB#0:
; AVX-NEXT:    vpunpckhqdq {{.*#+}} xmm0 = xmm0[1],xmm1[1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 1, i32 3>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_13_copy(<2 x i64> %nonce, <2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_13_copy:
; SSE:       # BB#0:
; SSE-NEXT:    punpckhqdq {{.*#+}} xmm1 = xmm1[1],xmm2[1]
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_13_copy:
; AVX:       # BB#0:
; AVX-NEXT:    vpunpckhqdq {{.*#+}} xmm0 = xmm1[1],xmm2[1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 1, i32 3>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_20(<2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_20:
; SSE:       # BB#0:
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_20:
; AVX:       # BB#0:
; AVX-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 2, i32 0>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_20_copy(<2 x i64> %nonce, <2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_20_copy:
; SSE:       # BB#0:
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm2 = xmm2[0],xmm1[0]
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_20_copy:
; AVX:       # BB#0:
; AVX-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm2[0],xmm1[0]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 2, i32 0>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_21(<2 x i64> %a, <2 x i64> %b) {
; SSE2-LABEL: shuffle_v2i64_21:
; SSE2:       # BB#0:
; SSE2-NEXT:    movsd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2i64_21:
; SSE3:       # BB#0:
; SSE3-NEXT:    movsd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2i64_21:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movsd %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2i64_21:
; SSE41:       # BB#0:
; SSE41-NEXT:    pblendw {{.*#+}} xmm1 = xmm1[0,1,2,3],xmm0[4,5,6,7]
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: shuffle_v2i64_21:
; AVX1:       # BB#0:
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0,1,2,3],xmm0[4,5,6,7]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v2i64_21:
; AVX2:       # BB#0:
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm1[0,1],xmm0[2,3]
; AVX2-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 2, i32 1>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_21_copy(<2 x i64> %nonce, <2 x i64> %a, <2 x i64> %b) {
; SSE2-LABEL: shuffle_v2i64_21_copy:
; SSE2:       # BB#0:
; SSE2-NEXT:    movsd %xmm2, %xmm1
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2i64_21_copy:
; SSE3:       # BB#0:
; SSE3-NEXT:    movsd %xmm2, %xmm1
; SSE3-NEXT:    movaps %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2i64_21_copy:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movsd %xmm2, %xmm1
; SSSE3-NEXT:    movaps %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2i64_21_copy:
; SSE41:       # BB#0:
; SSE41-NEXT:    pblendw {{.*#+}} xmm2 = xmm2[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    movdqa %xmm2, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: shuffle_v2i64_21_copy:
; AVX1:       # BB#0:
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm2[0,1,2,3],xmm1[4,5,6,7]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v2i64_21_copy:
; AVX2:       # BB#0:
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm2[0,1],xmm1[2,3]
; AVX2-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 2, i32 1>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_30(<2 x i64> %a, <2 x i64> %b) {
; SSE2-LABEL: shuffle_v2i64_30:
; SSE2:       # BB#0:
; SSE2-NEXT:    shufpd {{.*#+}} xmm1 = xmm1[1],xmm0[0]
; SSE2-NEXT:    movapd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2i64_30:
; SSE3:       # BB#0:
; SSE3-NEXT:    shufpd {{.*#+}} xmm1 = xmm1[1],xmm0[0]
; SSE3-NEXT:    movapd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2i64_30:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    palignr {{.*#+}} xmm0 = xmm1[8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4,5,6,7]
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2i64_30:
; SSE41:       # BB#0:
; SSE41-NEXT:    palignr {{.*#+}} xmm0 = xmm1[8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4,5,6,7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_30:
; AVX:       # BB#0:
; AVX-NEXT:    vpalignr {{.*#+}} xmm0 = xmm1[8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 3, i32 0>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_30_copy(<2 x i64> %nonce, <2 x i64> %a, <2 x i64> %b) {
; SSE2-LABEL: shuffle_v2i64_30_copy:
; SSE2:       # BB#0:
; SSE2-NEXT:    shufpd {{.*#+}} xmm2 = xmm2[1],xmm1[0]
; SSE2-NEXT:    movapd %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2i64_30_copy:
; SSE3:       # BB#0:
; SSE3-NEXT:    shufpd {{.*#+}} xmm2 = xmm2[1],xmm1[0]
; SSE3-NEXT:    movapd %xmm2, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2i64_30_copy:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    palignr {{.*#+}} xmm1 = xmm2[8,9,10,11,12,13,14,15],xmm1[0,1,2,3,4,5,6,7]
; SSSE3-NEXT:    movdqa %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2i64_30_copy:
; SSE41:       # BB#0:
; SSE41-NEXT:    palignr {{.*#+}} xmm1 = xmm2[8,9,10,11,12,13,14,15],xmm1[0,1,2,3,4,5,6,7]
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_30_copy:
; AVX:       # BB#0:
; AVX-NEXT:    vpalignr {{.*#+}} xmm0 = xmm2[8,9,10,11,12,13,14,15],xmm1[0,1,2,3,4,5,6,7]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 3, i32 0>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_31(<2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_31:
; SSE:       # BB#0:
; SSE-NEXT:    punpckhqdq {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_31:
; AVX:       # BB#0:
; AVX-NEXT:    vpunpckhqdq {{.*#+}} xmm0 = xmm1[1],xmm0[1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 3, i32 1>
  ret <2 x i64> %shuffle
}
define <2 x i64> @shuffle_v2i64_31_copy(<2 x i64> %nonce, <2 x i64> %a, <2 x i64> %b) {
; SSE-LABEL: shuffle_v2i64_31_copy:
; SSE:       # BB#0:
; SSE-NEXT:    punpckhqdq {{.*#+}} xmm2 = xmm2[1],xmm1[1]
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_31_copy:
; AVX:       # BB#0:
; AVX-NEXT:    vpunpckhqdq {{.*#+}} xmm0 = xmm2[1],xmm1[1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> %b, <2 x i32> <i32 3, i32 1>
  ret <2 x i64> %shuffle
}

define <2 x i64> @shuffle_v2i64_0z(<2 x i64> %a) {
; SSE-LABEL: shuffle_v2i64_0z:
; SSE:       # BB#0:
; SSE-NEXT:    movq %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_0z:
; AVX:       # BB#0:
; AVX-NEXT:    vmovq %xmm0, %xmm0
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> zeroinitializer, <2 x i32> <i32 0, i32 3>
  ret <2 x i64> %shuffle
}

define <2 x i64> @shuffle_v2i64_1z(<2 x i64> %a) {
; SSE-LABEL: shuffle_v2i64_1z:
; SSE:       # BB#0:
; SSE-NEXT:    pxor %xmm1, %xmm1
; SSE-NEXT:    punpckhqdq {{.*#+}} xmm0 = xmm0[1],xmm1[1]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_1z:
; AVX:       # BB#0:
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpunpckhqdq {{.*#+}} xmm0 = xmm0[1],xmm1[1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> zeroinitializer, <2 x i32> <i32 1, i32 3>
  ret <2 x i64> %shuffle
}

define <2 x i64> @shuffle_v2i64_z0(<2 x i64> %a) {
; SSE-LABEL: shuffle_v2i64_z0:
; SSE:       # BB#0:
; SSE-NEXT:    movq %xmm0, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2i64_z0:
; AVX:       # BB#0:
; AVX-NEXT:    vmovq %xmm0, %xmm0
; AVX-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> zeroinitializer, <2 x i32> <i32 2, i32 0>
  ret <2 x i64> %shuffle
}

define <2 x i64> @shuffle_v2i64_z1(<2 x i64> %a) {
; SSE2-LABEL: shuffle_v2i64_z1:
; SSE2:       # BB#0:
; SSE2-NEXT:    xorps %xmm1, %xmm1
; SSE2-NEXT:    movsd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2i64_z1:
; SSE3:       # BB#0:
; SSE3-NEXT:    xorps %xmm1, %xmm1
; SSE3-NEXT:    movsd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2i64_z1:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    xorps %xmm1, %xmm1
; SSSE3-NEXT:    movsd %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2i64_z1:
; SSE41:       # BB#0:
; SSE41-NEXT:    pxor %xmm1, %xmm1
; SSE41-NEXT:    pblendw {{.*#+}} xmm1 = xmm1[0,1,2,3],xmm0[4,5,6,7]
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: shuffle_v2i64_z1:
; AVX1:       # BB#0:
; AVX1-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0,1,2,3],xmm0[4,5,6,7]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v2i64_z1:
; AVX2:       # BB#0:
; AVX2-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm1[0,1],xmm0[2,3]
; AVX2-NEXT:    retq
  %shuffle = shufflevector <2 x i64> %a, <2 x i64> zeroinitializer, <2 x i32> <i32 2, i32 1>
  ret <2 x i64> %shuffle
}

define <2 x double> @shuffle_v2f64_0z(<2 x double> %a) {
; SSE-LABEL: shuffle_v2f64_0z:
; SSE:       # BB#0:
; SSE-NEXT:    movq %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_0z:
; AVX:       # BB#0:
; AVX-NEXT:    vmovq %xmm0, %xmm0
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> zeroinitializer, <2 x i32> <i32 0, i32 3>
  ret <2 x double> %shuffle
}

define <2 x double> @shuffle_v2f64_1z(<2 x double> %a) {
; SSE-LABEL: shuffle_v2f64_1z:
; SSE:       # BB#0:
; SSE-NEXT:    xorpd %xmm1, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm0 = xmm0[1],xmm1[1]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_1z:
; AVX:       # BB#0:
; AVX-NEXT:    vxorpd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vunpckhpd {{.*#+}} xmm0 = xmm0[1],xmm1[1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> zeroinitializer, <2 x i32> <i32 1, i32 3>
  ret <2 x double> %shuffle
}

define <2 x double> @shuffle_v2f64_z0(<2 x double> %a) {
; SSE-LABEL: shuffle_v2f64_z0:
; SSE:       # BB#0:
; SSE-NEXT:    xorpd %xmm1, %xmm1
; SSE-NEXT:    unpcklpd {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE-NEXT:    movapd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_z0:
; AVX:       # BB#0:
; AVX-NEXT:    vxorpd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vunpcklpd {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> zeroinitializer, <2 x i32> <i32 2, i32 0>
  ret <2 x double> %shuffle
}

define <2 x double> @shuffle_v2f64_z1(<2 x double> %a) {
; SSE2-LABEL: shuffle_v2f64_z1:
; SSE2:       # BB#0:
; SSE2-NEXT:    xorps %xmm1, %xmm1
; SSE2-NEXT:    movsd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: shuffle_v2f64_z1:
; SSE3:       # BB#0:
; SSE3-NEXT:    xorps %xmm1, %xmm1
; SSE3-NEXT:    movsd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: shuffle_v2f64_z1:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    xorps %xmm1, %xmm1
; SSSE3-NEXT:    movsd %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: shuffle_v2f64_z1:
; SSE41:       # BB#0:
; SSE41-NEXT:    xorpd %xmm1, %xmm1
; SSE41-NEXT:    blendpd {{.*#+}} xmm1 = xmm1[0],xmm0[1]
; SSE41-NEXT:    movapd %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: shuffle_v2f64_z1:
; AVX:       # BB#0:
; AVX-NEXT:    vxorpd %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vblendpd {{.*#+}} xmm0 = xmm1[0],xmm0[1]
; AVX-NEXT:    retq
  %shuffle = shufflevector <2 x double> %a, <2 x double> zeroinitializer, <2 x i32> <i32 2, i32 1>
  ret <2 x double> %shuffle
}

define <2 x i64> @insert_reg_and_zero_v2i64(i64 %a) {
; SSE-LABEL: insert_reg_and_zero_v2i64:
; SSE:       # BB#0:
; SSE-NEXT:    movd %rdi, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: insert_reg_and_zero_v2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovq %rdi, %xmm0
; AVX-NEXT:    retq
  %v = insertelement <2 x i64> undef, i64 %a, i32 0
  %shuffle = shufflevector <2 x i64> %v, <2 x i64> zeroinitializer, <2 x i32> <i32 0, i32 3>
  ret <2 x i64> %shuffle
}

define <2 x i64> @insert_mem_and_zero_v2i64(i64* %ptr) {
; SSE-LABEL: insert_mem_and_zero_v2i64:
; SSE:       # BB#0:
; SSE-NEXT:    movq (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: insert_mem_and_zero_v2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovq (%rdi), %xmm0
; AVX-NEXT:    retq
  %a = load i64* %ptr
  %v = insertelement <2 x i64> undef, i64 %a, i32 0
  %shuffle = shufflevector <2 x i64> %v, <2 x i64> zeroinitializer, <2 x i32> <i32 0, i32 3>
  ret <2 x i64> %shuffle
}

define <2 x double> @insert_reg_and_zero_v2f64(double %a) {
; SSE-LABEL: insert_reg_and_zero_v2f64:
; SSE:       # BB#0:
; SSE-NEXT:    movq %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: insert_reg_and_zero_v2f64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovq %xmm0, %xmm0
; AVX-NEXT:    retq
  %v = insertelement <2 x double> undef, double %a, i32 0
  %shuffle = shufflevector <2 x double> %v, <2 x double> zeroinitializer, <2 x i32> <i32 0, i32 3>
  ret <2 x double> %shuffle
}

define <2 x double> @insert_mem_and_zero_v2f64(double* %ptr) {
; SSE-LABEL: insert_mem_and_zero_v2f64:
; SSE:       # BB#0:
; SSE-NEXT:    movsd (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: insert_mem_and_zero_v2f64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovsd (%rdi), %xmm0
; AVX-NEXT:    retq
  %a = load double* %ptr
  %v = insertelement <2 x double> undef, double %a, i32 0
  %shuffle = shufflevector <2 x double> %v, <2 x double> zeroinitializer, <2 x i32> <i32 0, i32 3>
  ret <2 x double> %shuffle
}

define <2 x i64> @insert_reg_lo_v2i64(i64 %a, <2 x i64> %b) {
; SSE2-LABEL: insert_reg_lo_v2i64:
; SSE2:       # BB#0:
; SSE2-NEXT:    movd %rdi, %xmm1
; SSE2-NEXT:    movsd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: insert_reg_lo_v2i64:
; SSE3:       # BB#0:
; SSE3-NEXT:    movd %rdi, %xmm1
; SSE3-NEXT:    movsd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: insert_reg_lo_v2i64:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movd %rdi, %xmm1
; SSSE3-NEXT:    movsd %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: insert_reg_lo_v2i64:
; SSE41:       # BB#0:
; SSE41-NEXT:    movd %rdi, %xmm1
; SSE41-NEXT:    pblendw {{.*#+}} xmm1 = xmm1[0,1,2,3],xmm0[4,5,6,7]
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: insert_reg_lo_v2i64:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovq %rdi, %xmm1
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0,1,2,3],xmm0[4,5,6,7]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: insert_reg_lo_v2i64:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovq %rdi, %xmm1
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm1[0,1],xmm0[2,3]
; AVX2-NEXT:    retq
  %v = insertelement <2 x i64> undef, i64 %a, i32 0
  %shuffle = shufflevector <2 x i64> %v, <2 x i64> %b, <2 x i32> <i32 0, i32 3>
  ret <2 x i64> %shuffle
}

define <2 x i64> @insert_mem_lo_v2i64(i64* %ptr, <2 x i64> %b) {
; SSE2-LABEL: insert_mem_lo_v2i64:
; SSE2:       # BB#0:
; SSE2-NEXT:    movlpd (%rdi), %xmm0
; SSE2-NEXT:    retq
;
; SSE3-LABEL: insert_mem_lo_v2i64:
; SSE3:       # BB#0:
; SSE3-NEXT:    movlpd (%rdi), %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: insert_mem_lo_v2i64:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movlpd (%rdi), %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: insert_mem_lo_v2i64:
; SSE41:       # BB#0:
; SSE41-NEXT:    movq (%rdi), %xmm1
; SSE41-NEXT:    pblendw {{.*#+}} xmm1 = xmm1[0,1,2,3],xmm0[4,5,6,7]
; SSE41-NEXT:    movdqa %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: insert_mem_lo_v2i64:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovq (%rdi), %xmm1
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0,1,2,3],xmm0[4,5,6,7]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: insert_mem_lo_v2i64:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovq (%rdi), %xmm1
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm1[0,1],xmm0[2,3]
; AVX2-NEXT:    retq
  %a = load i64* %ptr
  %v = insertelement <2 x i64> undef, i64 %a, i32 0
  %shuffle = shufflevector <2 x i64> %v, <2 x i64> %b, <2 x i32> <i32 0, i32 3>
  ret <2 x i64> %shuffle
}

define <2 x i64> @insert_reg_hi_v2i64(i64 %a, <2 x i64> %b) {
; SSE-LABEL: insert_reg_hi_v2i64:
; SSE:       # BB#0:
; SSE-NEXT:    movd %rdi, %xmm1
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE-NEXT:    retq
;
; AVX-LABEL: insert_reg_hi_v2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovq %rdi, %xmm1
; AVX-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX-NEXT:    retq
  %v = insertelement <2 x i64> undef, i64 %a, i32 0
  %shuffle = shufflevector <2 x i64> %v, <2 x i64> %b, <2 x i32> <i32 2, i32 0>
  ret <2 x i64> %shuffle
}

define <2 x i64> @insert_mem_hi_v2i64(i64* %ptr, <2 x i64> %b) {
; SSE-LABEL: insert_mem_hi_v2i64:
; SSE:       # BB#0:
; SSE-NEXT:    movq (%rdi), %xmm1
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE-NEXT:    retq
;
; AVX-LABEL: insert_mem_hi_v2i64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovq (%rdi), %xmm1
; AVX-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX-NEXT:    retq
  %a = load i64* %ptr
  %v = insertelement <2 x i64> undef, i64 %a, i32 0
  %shuffle = shufflevector <2 x i64> %v, <2 x i64> %b, <2 x i32> <i32 2, i32 0>
  ret <2 x i64> %shuffle
}

define <2 x double> @insert_reg_lo_v2f64(double %a, <2 x double> %b) {
; SSE-LABEL: insert_reg_lo_v2f64:
; SSE:       # BB#0:
; SSE-NEXT:    movsd %xmm0, %xmm1
; SSE-NEXT:    movaps %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: insert_reg_lo_v2f64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovsd %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
  %v = insertelement <2 x double> undef, double %a, i32 0
  %shuffle = shufflevector <2 x double> %v, <2 x double> %b, <2 x i32> <i32 0, i32 3>
  ret <2 x double> %shuffle
}

define <2 x double> @insert_mem_lo_v2f64(double* %ptr, <2 x double> %b) {
; SSE-LABEL: insert_mem_lo_v2f64:
; SSE:       # BB#0:
; SSE-NEXT:    movlpd (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: insert_mem_lo_v2f64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovlpd (%rdi), %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = load double* %ptr
  %v = insertelement <2 x double> undef, double %a, i32 0
  %shuffle = shufflevector <2 x double> %v, <2 x double> %b, <2 x i32> <i32 0, i32 3>
  ret <2 x double> %shuffle
}

define <2 x double> @insert_reg_hi_v2f64(double %a, <2 x double> %b) {
; SSE-LABEL: insert_reg_hi_v2f64:
; SSE:       # BB#0:
; SSE-NEXT:    unpcklpd {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE-NEXT:    movapd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: insert_reg_hi_v2f64:
; AVX:       # BB#0:
; AVX-NEXT:    vunpcklpd {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; AVX-NEXT:    retq
  %v = insertelement <2 x double> undef, double %a, i32 0
  %shuffle = shufflevector <2 x double> %v, <2 x double> %b, <2 x i32> <i32 2, i32 0>
  ret <2 x double> %shuffle
}

define <2 x double> @insert_mem_hi_v2f64(double* %ptr, <2 x double> %b) {
; SSE-LABEL: insert_mem_hi_v2f64:
; SSE:       # BB#0:
; SSE-NEXT:    movhpd (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: insert_mem_hi_v2f64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovhpd (%rdi), %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = load double* %ptr
  %v = insertelement <2 x double> undef, double %a, i32 0
  %shuffle = shufflevector <2 x double> %v, <2 x double> %b, <2 x i32> <i32 2, i32 0>
  ret <2 x double> %shuffle
}

define <2 x double> @insert_dup_reg_v2f64(double %a) {
; FIXME: We should match movddup for SSE3 and higher here.
;
; SSE2-LABEL: insert_dup_reg_v2f64:
; SSE2:       # BB#0:
; SSE2-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0,0]
; SSE2-NEXT:    retq
;
; SSE3-LABEL: insert_dup_reg_v2f64:
; SSE3:       # BB#0:
; SSE3-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0,0]
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: insert_dup_reg_v2f64:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0,0]
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: insert_dup_reg_v2f64:
; SSE41:       # BB#0:
; SSE41-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0,0]
; SSE41-NEXT:    retq
;
; AVX-LABEL: insert_dup_reg_v2f64:
; AVX:       # BB#0:
; AVX-NEXT:    vunpcklpd {{.*#+}} xmm0 = xmm0[0,0]
; AVX-NEXT:    retq
  %v = insertelement <2 x double> undef, double %a, i32 0
  %shuffle = shufflevector <2 x double> %v, <2 x double> undef, <2 x i32> <i32 0, i32 0>
  ret <2 x double> %shuffle
}
define <2 x double> @insert_dup_mem_v2f64(double* %ptr) {
; SSE2-LABEL: insert_dup_mem_v2f64:
; SSE2:       # BB#0:
; SSE2-NEXT:    movsd (%rdi), %xmm0
; SSE2-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0,0]
; SSE2-NEXT:    retq
;
; SSE3-LABEL: insert_dup_mem_v2f64:
; SSE3:       # BB#0:
; SSE3-NEXT:    movddup (%rdi), %xmm0
; SSE3-NEXT:    retq
;
; SSSE3-LABEL: insert_dup_mem_v2f64:
; SSSE3:       # BB#0:
; SSSE3-NEXT:    movddup (%rdi), %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: insert_dup_mem_v2f64:
; SSE41:       # BB#0:
; SSE41-NEXT:    movddup (%rdi), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: insert_dup_mem_v2f64:
; AVX:       # BB#0:
; AVX-NEXT:    vmovddup (%rdi), %xmm0
; AVX-NEXT:    retq
  %a = load double* %ptr
  %v = insertelement <2 x double> undef, double %a, i32 0
  %shuffle = shufflevector <2 x double> %v, <2 x double> undef, <2 x i32> <i32 0, i32 0>
  ret <2 x double> %shuffle
}

define <2 x double> @shuffle_mem_v2f64_10(<2 x double>* %ptr) {
; SSE-LABEL: shuffle_mem_v2f64_10:
; SSE:       # BB#0:
; SSE-NEXT:    movapd (%rdi), %xmm0
; SSE-NEXT:    shufpd {{.*#+}} xmm0 = xmm0[1,0]
; SSE-NEXT:    retq
;
; AVX-LABEL: shuffle_mem_v2f64_10:
; AVX:       # BB#0:
; AVX-NEXT:    vpermilpd {{.*#+}} xmm0 = mem[1,0]
; AVX-NEXT:    retq
  %a = load <2 x double>* %ptr
  %shuffle = shufflevector <2 x double> %a, <2 x double> undef, <2 x i32> <i32 1, i32 0>
  ret <2 x double> %shuffle
}
