.class public Day5
.super java/lang/Object

.method private static calcPartOne : (Ljava/util/List;Ljava/util/List;Ljava/util/Scanner;)I
    .code stack 4 locals 8
        iconst_0
        istore_3
    
LREAD_IDS:
        aload_2
        invokevirtual Method java/util/Scanner hasNextLong ()Z
        ifeq LREAD_IDS_DONE

        aload_2
        invokevirtual Method java/util/Scanner nextLong ()J
        lstore 4

        aload_0
        invokeinterface InterfaceMethod java/util/List iterator ()Ljava/util/Iterator; 1
        astore 6
        aload_1
        invokeinterface InterfaceMethod java/util/List iterator ()Ljava/util/Iterator; 1
        astore 7
        
LCHECK_ID:
        aload 6
        invokeinterface InterfaceMethod java/util/Iterator hasNext ()Z 1
        ifeq LID_SPOILED

        aload 6
        invokeinterface InterfaceMethod java/util/Iterator next ()Ljava/lang/Object; 1
        checkcast java/lang/Long
        invokevirtual Method java/lang/Long longValue ()J
        lload 4
        lcmp
        ifgt LCHECK_ID_FIRST_FAIL

        aload 7
        invokeinterface InterfaceMethod java/util/Iterator next ()Ljava/lang/Object; 1
        checkcast java/lang/Long        
        invokevirtual Method java/lang/Long longValue ()J
        lload 4
        lcmp
        ifge LID_FRESH
        goto LCHECK_ID

LCHECK_ID_FIRST_FAIL:
        aload 7
        invokeinterface InterfaceMethod java/util/Iterator next ()Ljava/lang/Object; 1
        pop
        goto LCHECK_ID

LID_FRESH:
        iload_3
        iconst_1
        iadd
        istore_3

LID_SPOILED:
        goto LREAD_IDS
        
LREAD_IDS_DONE:
        iload_3
        ireturn
    .end code
.end method

.method private static calcPartTwo : (Ljava/util/List;Ljava/util/List;)J
    .code stack 7 locals 14
        new java/util/ArrayList
        dup
        aload_0
        invokespecial Method java/util/ArrayList <init> (Ljava/util/Collection;)V
        astore_0
        new java/util/ArrayList
        dup
        aload_1
        invokespecial Method java/util/ArrayList <init> (Ljava/util/Collection;)V
        astore_1

        new java/util/ArrayList
        dup
        invokespecial Method java/util/ArrayList <init> ()V
        astore_2
        new java/util/ArrayList
        dup
        invokespecial Method java/util/ArrayList <init> ()V
        astore_3

        iconst_0
        istore 4

LRANGE_DEOVERLAP_OUTER:
        aload_0
        iload 4
        invokeinterface InterfaceMethod java/util/List get (I)Ljava/lang/Object; 2
        checkcast java/lang/Long
        invokevirtual Method java/lang/Long longValue ()J
        lstore 6

        aload_1
        iload 4
        invokeinterface InterfaceMethod java/util/List get (I)Ljava/lang/Object; 2
        checkcast java/lang/Long
        invokevirtual Method java/lang/Long longValue ()J
        lstore 8

        aload_2
        invokeinterface InterfaceMethod java/util/Collection clear ()V
        aload_3
        invokeinterface InterfaceMethod java/util/Collection clear ()V

        iconst_0
        istore 5
LRANGE_DEOVERLAP_COPY_START:
        aload_2
        aload_0
        iload 5
        invokeinterface InterfaceMethod java/util/List get (I)Ljava/lang/Object; 2
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        aload_3
        aload_1
        iload 5
        invokeinterface InterfaceMethod java/util/List get (I)Ljava/lang/Object; 2
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        iload 5
        iconst_1
        iadd
        dup
        istore 5
        iload 4
        if_icmple LRANGE_DEOVERLAP_COPY_START

        iload 4
        iconst_1
        iadd
        istore 5
LRANGE_DEOVERLAP_MAIN_INNER:
        aload_0
        iload 5
        invokeinterface InterfaceMethod java/util/List get (I)Ljava/lang/Object; 2
        checkcast java/lang/Long
        invokevirtual Method java/lang/Long longValue ()J
        lstore 10

        aload_1
        iload 5
        invokeinterface InterfaceMethod java/util/List get (I)Ljava/lang/Object; 2
        checkcast java/lang/Long
        invokevirtual Method java/lang/Long longValue ()J
        lstore 12

LRANGE_DEOVERLAP_COND_CONTAINED:
        lload 6
        lload 10
        lcmp
        ifgt LRANGE_DEOVERLAP_COND_NONOVERLAPPING
        lload 8
        lload 12
        lcmp
        iflt LRANGE_DEOVERLAP_COND_NONOVERLAPPING
        goto LRANGE_DEOVERLAP_MAIN_INNER_END

LRANGE_DEOVERLAP_COND_NONOVERLAPPING:
        lload 8
        lload 10
        lcmp
        iflt LRANGE_DEOVERLAP_COND_NONOVERLAPPING_INNER
        lload 6
        lload 12
        lcmp
        ifle LRANGE_DEOVERLAP_COND_LEFT        
LRANGE_DEOVERLAP_COND_NONOVERLAPPING_INNER:
        aload_2
        new java/lang/Long
        dup
        lload 10
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        aload_3
        new java/lang/Long
        dup
        lload 12
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop
        
        goto LRANGE_DEOVERLAP_MAIN_INNER_END

LRANGE_DEOVERLAP_COND_LEFT:
        lload 6
        lload 10
        lcmp
        ifgt LRANGE_DEOVERLAP_COND_RIGHT
        lload 10
        lload 8
        lcmp
        ifgt LRANGE_DEOVERLAP_COND_RIGHT
        lload 8
        lload 12
        lcmp
        ifge LRANGE_DEOVERLAP_COND_RIGHT

        aload_2
        new java/lang/Long
        dup
        lload 8
        lconst_1
        ladd
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        aload_3
        new java/lang/Long
        dup
        lload 12
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        goto LRANGE_DEOVERLAP_MAIN_INNER_END

LRANGE_DEOVERLAP_COND_RIGHT:
        lload 6
        lload 12
        lcmp
        ifgt LRANGE_DEOVERLAP_COND_CONTAINED_REVERSE
        lload 12
        lload 8
        lcmp
        ifgt LRANGE_DEOVERLAP_COND_CONTAINED_REVERSE
        lload 6
        lload 10
        lcmp
        ifle LRANGE_DEOVERLAP_COND_CONTAINED_REVERSE

        aload_2
        new java/lang/Long
        dup
        lload 10
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        aload_3
        new java/lang/Long
        dup
        lload 6
        lconst_1
        lsub
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        goto LRANGE_DEOVERLAP_MAIN_INNER_END

LRANGE_DEOVERLAP_COND_CONTAINED_REVERSE:
        aload_2
        new java/lang/Long
        dup
        lload 10
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        aload_3
        new java/lang/Long
        dup
        lload 6
        lconst_1
        lsub
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        aload_2
        new java/lang/Long
        dup
        lload 8
        lconst_1
        ladd
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        aload_3
        new java/lang/Long
        dup
        lload 12
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

LRANGE_DEOVERLAP_MAIN_INNER_END:
        iload 5
        iconst_1
        iadd
        dup
        istore 5
        aload_0
        invokeinterface InterfaceMethod java/util/Collection size ()I
        if_icmplt LRANGE_DEOVERLAP_MAIN_INNER


LRANGE_DEOVERLAP_OUTER_END:
        aload_0
        aload_2
        astore_0
        astore_2
        aload_1
        aload_3
        astore_1
        astore_3

        iload 4
        iconst_1
        iadd
        dup
        istore 4
        aload_0
        invokeinterface InterfaceMethod java/util/Collection size ()I
        iconst_1
        isub
        if_icmplt LRANGE_DEOVERLAP_OUTER

        aload_0
        invokeinterface InterfaceMethod java/util/List iterator ()Ljava/util/Iterator; 1
        astore_0
        aload_1
        invokeinterface InterfaceMethod java/util/List iterator ()Ljava/util/Iterator; 1
        astore_1
        lconst_0
        lstore_2

LSUM:
        aload_0
        invokeinterface InterfaceMethod java/util/Iterator hasNext ()Z 1
        ifeq LSUM_FINISHED

        aload_1
        invokeinterface InterfaceMethod java/util/Iterator next ()Ljava/lang/Object; 1
        checkcast java/lang/Long
        invokevirtual Method java/lang/Long longValue ()J

        aload_0
        invokeinterface InterfaceMethod java/util/Iterator next ()Ljava/lang/Object; 1
        checkcast java/lang/Long
        invokevirtual Method java/lang/Long longValue ()J

        lsub
        lconst_1
        ladd
        lload_2
        ladd
        lstore_2
        goto LSUM

LSUM_FINISHED:
        lload_2
        lreturn
    .end code
.end method

.method public static main : ([Ljava/lang/String;)V
    .code stack 6 locals 3
        new java/util/ArrayList
        dup
        invokespecial Method java/util/ArrayList <init> ()V
        astore_1

        new java/util/ArrayList
        dup
        invokespecial Method java/util/ArrayList <init> ()V
        astore_2
    
        new java/util/Scanner
        dup
        new java/io/File
        dup
        aload_0
        iconst_0
        aaload
        invokespecial Method java/io/File <init> (Ljava/lang/String;)V
        invokespecial Method java/util/Scanner <init> (Ljava/io/File;)V
        ldc "\\n|-"
        invokevirtual Method java/util/Scanner useDelimiter (Ljava/lang/String;)Ljava/util/Scanner;
        astore_0

LREAD_RANGES:
        aload_0
        invokevirtual Method java/util/Scanner hasNextLong ()Z
        ifeq LREAD_RANGES_DONE

        aload_1
        new java/lang/Long
        dup
        aload_0
        invokevirtual Method java/util/Scanner nextLong ()J
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        aload_2
        new java/lang/Long
        dup
        aload_0
        invokevirtual Method java/util/Scanner nextLong ()J
        invokespecial Method java/lang/Long <init> (J)V
        invokevirtual Method java/util/ArrayList add (Ljava/lang/Object;)Z
        pop

        goto LREAD_RANGES

LREAD_RANGES_DONE:
        getstatic Field java/lang/System out Ljava/io/PrintStream;
        aload_1
        aload_2
        aload_0
        ldc "\\n+"
        invokevirtual Method java/util/Scanner useDelimiter (Ljava/lang/String;)Ljava/util/Scanner;
        invokestatic Method Day5 calcPartOne (Ljava/util/List;Ljava/util/List;Ljava/util/Scanner;)I
        invokevirtual Method java/io/PrintStream println (I)V

        getstatic Field java/lang/System out Ljava/io/PrintStream;        
        aload_1
        aload_2
        invokestatic Method Day5 calcPartTwo (Ljava/util/List;Ljava/util/List;)J
        invokevirtual Method java/io/PrintStream println (J)V

        return
    .end code
.end method

.end class