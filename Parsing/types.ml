type classDeclaration = 
    | ClassDeclaration of classDeclaration

type normalClassDeclaration = 
    NormalClassDeclaration of classModifiers * jclass * identifier * classbody

type classModifiers = 
    | EMPTY
    | PUBLIC
    | PROTECTED
    | PRIVATE
    | ABSTRACT
    | STATIC
    | FINAL
    | STRICTFP

type jclass = CLASS

type identifier = IDENTIFIER of string

type classbody = CLASSBODY of string
