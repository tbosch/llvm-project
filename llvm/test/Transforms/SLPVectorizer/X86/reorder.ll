; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -slp-vectorizer -mcpu=bdver1 < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = common local_unnamed_addr global i32 0, align 4
@c = common local_unnamed_addr global [1 x i32] zeroinitializer, align 4

define i32 @foo() local_unnamed_addr #0 {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> undef, i32 [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <4 x i32> [[TMP1]], i32 [[TMP0]], i32 1
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x i32> [[TMP2]], i32 [[TMP0]], i32 2
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <4 x i32> [[TMP3]], i32 [[TMP0]], i32 3
; CHECK-NEXT:    [[TMP5:%.*]] = add nsw <4 x i32> <i32 8, i32 1, i32 2, i32 3>, [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <4 x i32> [[TMP5]], i32 2
; CHECK-NEXT:    store i32 [[TMP6]], i32* getelementptr inbounds ([1 x i32], [1 x i32]* @c, i64 1, i64 0), align 4
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <4 x i32> [[TMP5]], i32 3
; CHECK-NEXT:    store i32 [[TMP7]], i32* getelementptr ([1 x i32], [1 x i32]* @c, i64 2, i64 0), align 4
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <4 x i32> [[TMP5]], i32 0
; CHECK-NEXT:    store i32 [[TMP8]], i32* getelementptr inbounds ([1 x i32], [1 x i32]* @c, i64 0, i64 0), align 4
; CHECK-NEXT:    store <4 x i32> [[TMP5]], <4 x i32>* bitcast (i32* getelementptr ([1 x i32], [1 x i32]* @c, i64 7, i64 0) to <4 x i32>*), align 4
; CHECK-NEXT:    ret i32 undef
;
entry:
  %0 = load i32, i32* @a, align 4
  %add = add nsw i32 %0, 1
  %add1 = add nsw i32 %0, 2
  %add6 = add nsw i32 %0, 3
  %add11 = add nsw i32 %0, 8
  store i32 %add1, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @c, i64 1, i64 0), align 4
  store i32 %add6, i32* getelementptr ([1 x i32], [1 x i32]* @c, i64 2, i64 0), align 4
  store i32 %add11, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @c, i64 0, i64 0), align 4
  store i32 %add, i32* getelementptr ([1 x i32], [1 x i32]* @c, i64 8, i64 0), align 4
  store i32 %add1, i32* getelementptr ([1 x i32], [1 x i32]* @c, i64 9, i64 0), align 4
  store i32 %add6, i32* getelementptr ([1 x i32], [1 x i32]* @c, i64 10, i64 0), align 4
  store i32 %add11, i32* getelementptr ([1 x i32], [1 x i32]* @c, i64 7, i64 0), align 4
  ret i32 undef
}
