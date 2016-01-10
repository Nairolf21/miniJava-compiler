type classDeclaration = 
    | ClassDeclaration of classDeclaration
    | EnumDeclaration of enumDeclaration

type normalClassDeclaration = 
    NormalClassDeclaration of ( classmodifiers * jclass * identifier * classbody )

type modifiers = 
    | PUBLIC
    | PROTECTED
    | PRIVATE
    | ABSTRACT
    | STATIC
    | FINAL
    | STRICTFP

type jclass = CLASS

type identifier = IDENTIFIER of string

(* 
 * type classBody = ... ???
 *
 * ) 
