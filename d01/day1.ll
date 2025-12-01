declare i32 @printf(i8*, ...)
declare ptr @fopen(i8*, i8*)
declare i32 @fclose(ptr)
declare i64 @getline(i8**, i32*, ptr)
declare void @free(ptr)
declare i32 @atoi(i8*)
declare i32 @llvm.abs.i32(i32, i1)

@fmt = constant [4 x i8] c"%d\0A\00"
@mode = constant [2 x i8] c"r\00"


define i32 @main(i32 %argc, i8** %argv) {
    %lineptr = alloca i8*
    %n = alloca i64
    %position = alloca i32
    %answer = alloca i32
    %answer.p2 = alloca i32
    
    store i32 50, i32* %position
    store i32 0, i32* %answer
    store i32 0, i32* %answer.p2

    %cmp = icmp ugt i32 %argc, 1
    br i1 %cmp, label %handle_args, label %fail
handle_args:
    %arg = getelementptr i8*, i8** %argv, i64 1
    %filename = load i8*, i8** %arg

    %file = call ptr @fopen(i8* %filename, i8* @mode)
    %cmp.1 = icmp ne ptr %file, null
    br i1 %cmp.1, label %file_opened, label %fail

file_opened:
    %read = call i64 @getline(i8** %lineptr, i64* %n, ptr %file)
    %cmp.2 = icmp eq i64 %read, -1
    br i1 %cmp.2, label %finished, label %readline
    
readline:
    %line = load i8*, i8** %lineptr

    %numstr = getelementptr i8, i8* %line, i64 1
    %num = call i32 @atoi(i8* %numstr)

    %first = load i8, i8* %line
    %pos = load i32, i32* %position
    %cmp.3 = icmp eq i8 %first, 76 ; ASCII L
    br i1 %cmp.3, label %line_L, label %line_R
line_L:
    %lres.0 = sub i32 %pos, %num
    %lres.1 = call i32 @mod(i32 %lres.0, i32 100)
    %lzeros = call i32 @numzeros(i32 %pos, i32 %lres.0, i32 %lres.1, i1 1)
    %ans.p2.l = load i32, i32* %answer.p2
    %newans.p2.l = add i32 %ans.p2.l, %lzeros
    store i32 %newans.p2.l, i32* %answer.p2
    store i32 %lres.1, i32* %position
    br label %line_done
line_R:
    %rres.0 = add i32 %pos, %num
    %rres.1 = call i32 @mod(i32 %rres.0, i32 100)
    %rzeros = call i32 @numzeros(i32 %pos, i32 %rres.0, i32 %rres.1, i1 0)
    %ans.p2.r = load i32, i32* %answer.p2
    %newans.p2.r = add i32 %ans.p2.r, %rzeros
    store i32 %newans.p2.r, i32* %answer.p2
    store i32 %rres.1, i32* %position
    br label %line_done

line_done:
    %pos.1 = load i32, i32* %position
    %cmp.4 = icmp eq i32 %pos.1, 0
    br i1 %cmp.4, label %iszero, label %line_loop_end

iszero:
    %ans = load i32, i32* %answer
    %newans = add i32 %ans, 1
    store i32 %newans, i32* %answer
    br label %line_loop_end
    
line_loop_end:
    br label %file_opened

finished:
    %final = load i32, i32* %answer
    call i32 @printf(i8* @fmt, i32 %final)
    %final.p2 = load i32, i32* %answer.p2
    call i32 @printf(i8* @fmt, i32 %final.p2)

    %line.1 = load i8*, i8** %lineptr
    call void @free(i8* %line.1)
    call i32 @fclose(ptr %file)

    ret i32 0
fail:
    ret i32 1
}

define i32 @numzeros(i32 %a, i32 %premod, i32 %final, i1 %is_left) {
    %res = alloca i32

    %abs = call i32 @llvm.abs.i32(i32 %premod, i1 0)
    %n = udiv i32 %abs, 100

    %cmp = icmp slt i32 %premod, 0
    br i1 %cmp, label %negative, label %positive

negative:
    %n.1 = add i32 %n, 1
    store i32 %n.1, i32* %res
    br label %adjust
    
positive:
    store i32 %n, i32* %res
    br label %adjust

adjust:
    %ans = load i32, i32* %res
    br i1 %is_left, label %left, label %right

left:
    %cmp.1 = icmp eq i32 %final, 0
    br i1 %cmp.1, label %lzero, label %lchecka
lzero:
    %cmp.3 = icmp eq i32 %n, 0
    br i1 %cmp.3, label %lzero.1, label %lchecka
lzero.1:
    %ans.1 = add i32 %ans, 1
    store i32 %ans.1, i32* %res
    br label %lchecka
lchecka:
    %ans.2 = load i32, i32* %res
    %cmp.2 = icmp eq i32 %a, 0
    br i1 %cmp.2, label %lazero, label %lanonzero
lazero:
    %ans.3 = sub i32 %ans.2, 1
    ret i32 %ans.3
lanonzero:
    ret i32 %ans.2

right:
    ret i32 %ans  
}

; real modulo (not remainder) - gives positive result for negative numbers
define i32 @mod(i32 %a, i32 %b) {
    %rem = srem i32 %a, %b
    %cmp = icmp slt i32 %rem, 0
    br i1 %cmp, label %isneg, label %ispos
isneg:
    %res = add i32 %rem, %b
    ret i32 %res
ispos:
    ret i32 %rem
}