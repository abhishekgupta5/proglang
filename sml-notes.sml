(* SML cheatsheat *)

(* Week1 *)
(* Overview: Basics of ML, language constructs, variables, data structures *)

(* How to learn a programming language *)
(* 5 different things *)
(*
1. Syntax - How do you write language constructs?
2. Semantics - What do programs mean? (Type-checking rules and evaluation rules)
3. Idioms - What are typical patterns for using language features to express
            your goals?
4. Libraries - What facilities does the language provides?
               (Standard library, file IO, data structures like hash tables, trees, etc)
5. Tools - What do language implementations provide to make your job easier?
           (Eg - REPL, debugger, code formatter)
           These are not actually part of the language.

This course focuses on 2 and 3.
Syntax is subjective and usually trivial.
Syntax is needed to understand semantics though,
Libraries and tools. You'll always have new ones.
Can do on the job.
Understanding Semantics and Idioms can help in learning libraries and tools

*)

(* Syntax is just how you write something *)
(* Semantics is what that something means.
   - Type-checking (before program runs)
   - Evaluation (as program runs)*)

(* Every expression has -
   1. Syntax
   2. Type-checking rules
   3. Evaluation rules (used only on things that type checks)*)

(* Including an sml file in a repl *)
use "file_name.sml";

(* Declaring a variable *)
val x = 34;
(* Static environment: x : int *)
(* Dynamic environment: x : 34 *)
(* First type-checking happens in static env and then evaluation
   happens in dynamic env *)

(* Conditional *)
val abs_of_z = if z < 0 then 0 - z else z;
(* type checking rule for conditional
   the if expression should be a bool
   and both then and else can have any type but should
   be same. In this case int.
   Also the type of the entire expression should also be same *)


(* Shadowing *)
val a = 10;
val b = a * 2;
val a = 5; (* this is not an assignment statement. This is shadowing
             There is no way to "assign to" a variable in ML.
             Can only shadow in a later env *)

(* functions *)
(* int * int -> int *)
fun pow(x : int, y : int) =
    if y=0
    then 1
    else x * pow(x, y-1);

(* Can't refer to later function bindings. Helper functions
   must come before their use *)

(* datatypes *)
(* 1. Pairs *)
val x = (1, 4);
val z = pow x;
val y = (true, 4);

(* 2. Tuples *)
val x1 = (1, true, (false, ~5), 9.4);
(* type - (int * bool * (bool * int) * real) *)
(* access tuple elements by, #1 x, #2 x, #1 (#2 x) *)

(* 3. Lists *)
(* Lists can have any number of elements unlike tuples.
   All list elements have the same type unlike tuples *)

[]; (* a list - empty list *)
[1,2,3]; (* int list *)
[1.2, 2.3, 4.5]; (* real list *)
[(1, 2.4), (  3, 4.5)]; (* (int * real) list *)

(* Prepend something in a list *)
2::[1,2,3,4]; (* int list *)
(* you can only prepend the same type of element which is inside *)
[1,2]::[[2,3], [4], []]; (* int list list *)

(* Accessing a list *)
val list = [1,2,3,4,5];
val is_list_empty = null list; (* Returns true for an empty list *)
(* false *)
val head_of_list = hd list; (* Returns the head element of the list *)
(* 1 *)
val tail_of_list = tl list; (* Returns the list except the first element *)
(* [2,3,4,5] *)

(* let expressions - an idea of scope *)
let
    (* Any binding *)
in
    (* expression *)
end;

(* The bindings inside let and in are only available inside in and end
   and nothing else *)

(* Let expressions can help avoid repeated computation in recursive functions *)

(* options *)
(* Building *)
(* NONE has type 'a options (Like [] has type 'a list. Any type)  *)
(* SOME e has type t option if e is type t (Like e::[])*)
(* Accessing *)
(* isSome has type 'a option -> bool *)
(* valOf has type 'a option -> 'a (exception if given NONE) *)

(* More conditional operations *)
e1 andalso e2; (* e1 and e2 should be bool. e1 && e2 *)
e1 orelse e2; (* e1 || e2 *)
not e1; (* !e1 *)

(* =, <>, >, <, >=, <=  *)
(* last 4, either they need both operands as int, or real. not hybrid *)
(* convert int -> real *)
Real.fromInt 10;

(* = and <> don't work with real numbers *)

(* Mutation *)
(* ML is immutable. Means, you can't alter a list once it's build *)
(* In functional programming, immutability is a 'helpful non-feature'
   Not being able to assign to (a.k.a mutate) variables
   or parts of tuples and lists *)

(* This is a major difference b/w ML and imperative languages.
   In ML, we can create aliases without thinking about it because it's
 impossible to tell where there is aliasing.
 In languages with mutable data, writer has to be careful about where
 he is aliasing and where he is making a copy since the data can be mutated *)


(* Week2 *)
(* Overview: Compound types, pattern matching, exceptions *)

(* Compound types *)
(* building blocks for building types in any language *)
(* "Each of" - where the new type value contains values each of t1, t2,.. tn
   "One of" - where the new type value contains values one o f t1, t2,.. tn
   "Self reference" - where the new type value refer to other values of the same type *)

(* Examples -
1. Tuples build each-of types
   - (2, false, 5.6) = int * bool * real -> contains an int and a bool and a real
2. Options build one-of types
   - SOME [5, 7] = int list option -> contains a list of int or doesn't contain
     anything
3. Lists are combination of all 3. One-of, each-of and self referencing
 *)

(* Records *)
val x = {foo=1+3, bar=true andalso true, baz= (1, 4.56, false)};
(* type of x is a compound type i.e
   { bar:bool, baz:int * real * bool, foo:int } *)
(* Accessing record elements *)
val foo = #foo x; (* 4 *)
val baz = #baz x; (* (1,4.56,false *)
(* Order of the fields doesn't matter in a record *)
(* Accessing a field that doesn't exist in a record will give
   a type error since the type checker can tell statically that
   there is no field by that name in the record *)

(* Records are a lot like tuples -
   (4, 5.6, false) <-> {f=4, g=5.6, h=false} *)
(* Common decision which one to use is made whether the elements are
   to be accessed via position (as in tuple)
   or via names (as in record) *)

(* Tuples are records only. In fact, there is nothing like tuples.
   There are only records.
   (10,20,30) is same as {1=10, 3=30, 2=20}
   Hence tuples are just syntactic sugar for records
   with fields named 1,2,3...n *)

(* Syntactic: Because we can describe the semantics i.e the evaluation
   and typing rules of tuples completely in terms of something else *)
(* Sugars: Because it makes the language sweeter *)
(* Syntactic sugar simplifies the understanding and implementation of the
   language *)

(* Another examples of syntactic sugars are 'andalso', 'orelse' *)

(* Datatype bindings - A way to make one-of types *)
(* variable binding starts with 'val'
   function binding starts with 'fun'
   datatype binding starts with 'datatype' *)

(* building datatype values *)
datatype mytype = TwoInts of int * int
                | Str of string
                | Pizza;
(* The expressions separated by | are called constructors.
   Any value of mytype is made from one of the constructors.
   A value = tag i.e the constructor name. eg - TwoInts, Str, Pizza.
             the corresponsing data eg - "hi" for Str, (4,5) for Twoints *)

(* using datatype values *)
(* We want to check 1) the tag/variant (what constructor made it) and *)
(* 2) extract the data (if that variant has any) *)

(* As compared to other one-of types - list and options
   - null and isSome check the variants/tags
   - hd, tl, and valOf extract the data (raise exception on wrong variant) *)

(* For datatype bindings, something like 'isStr' and 'isStrData' would have
   made sense but ML did something better *)

(* Case expressions *)

fun f x = (* f has type mytype -> int *)
    case x of
        Pizza => 3
      | TwoInts(i1, i2) => i1 + i2
      | Str s => String.size s;

(* This is called pattern-matching *)
(* The variables of a a constructor are available in their respective bracnhes *)
(* Eg - i1 and i2 are accessible in the 2nd branch
        s is accessible in the 3rd branch
        just like let expressions *)
(* Type-checking rule
   All branches must have same type *)
(* Evaluation rule - evaluate all cases one by one *)

(* General syntax of patterns *)
case e0 of
    p1 => e1
  | p2 => e2
  ...
  | pn => en;
(* Note: patterns aren't expressions. They look like them.
 They are used for matching and variable bindings.
 We don't evaluate them
 We see if the result of e0 matches them, get the variables of the same branch
 and then evaluate the right hand side of the branch *)

(* Why is this better then 'isStr' or 'isStrData' like model *)
(* 1. You can write 'isStr'/'isStrData' like functions using case expressions.
      Don't need to do that since it's a bad style but it can be done.
   2. You can't forget a case (you get an inexhaustive pattern-match warning)
   3. You can't duplicate a case (type-checking error)
   4. You won't forget to test a variant correctly and get an exception (like hd [])
      (You'll take care of such things while writing branches/cases)
   5. Pattern-matching can be generalized and made more powerful,
      leading to elegant and concise code *)

(* More examples of Datatype bindings *)
(* Enums - including carrying other data *)
datatype suit = Club | Diamond | Heart | Spade;
datatype rank = Jack | Queen | King | Ace | Num of int;
(* Now you can write an eachOf type containing a suit and a rank
 and that'll represent a card *)

(* Alternate ways of identifying real-world things/people *)
(* Want to represent an student by id which can be a student number or
  a name containing first and last name *)
datatype id = StudentNum of int
            | Name of string
                      * (string option)
                      * string;
(* A bad style here will be to use a record. Since that, will imply that, the student
 has all of these fields *)
{ student_num: int option,
  first : string,
  middle : string option,
  last : string };
(* Note: Record is a eachOf type. This makes sense when each field makes sense
  for a student *)

(* Correct data modeling and binding are crucial in a programming language *)

(* Datatype binding -> Expression trees *)
(* recursive *)
datatype exp = Constant of int
             | Negate of exp
             | Add of exp * exp
             | Multiply of exp * exp;
(* This is essentially a set of trees with,
   a Constant at leaves,
   a Negate with 1 child,
   a Add or Multiply with 2 children each *)
(* It can represent a collection of arithmatic expressions *)

(* Eg - Add (Constant (10+9), Negate (Constant 4)) will actually be read as -
             Add
             / \
     Constant   Negate
         |         |
        19      Constant
                   |
                   4
 *)

(* Now I can write functions that operate on type 'exp'...
   and the most obvious one is that takes exp and returns the resultant integer *)

(* Evaluates an expression - exp -> int *)
fun eval e =
    case e of
        Constant i => i
      | Negate e2 => ~ (eval e2)
      | Add(e1,e2) => (eval e1) + (eval e2)
      | Multiply(e1,e2) => (eval e1) * (eval e2);

eval (Add (Constant 10, Negate (Constant 4))); (* 6 *)
(* Functions using recursive dataype bindings end up being recursive *)

(* Doesn't evaluate the expression but tells you number of adds in exp *)
(* exp -> int *)
fun number_of_adds e =
    case e of
        Constant i => 0 (* no adds *)
      | Negate e2 => number_of_adds e2 (* Same no of adds as e2 *)
      | Add(e1,e2) => 1 + number_of_adds e1 + number_of_adds e2
      | Multiply(e1,e2) => number_of_adds e1 + number_of_adds e2;

(* generalizing datatype bindings *)
datatype t = C1 of t1 | C2 of t2 | Cn of tn;
(* Values of type t will have the tag/constructor type and the underlying value
   of that tag.
 Constructor that doesn't have any value is not a function, but instead a value
 of type t
 Use case expressions to -
 - see which variant(tag) it has
 - Extract underlying data once you know which variant *)

(* Creating new types *)
type aname = t;
(* - Just creates another name for a type *)
(* - The type and the name are interchangeble in every way *)

(* Linked list as a recursive datatype *)
datatype my_int_list = Empty
                     | Cons of int * my_int_list;

(* Lists and options are predefined datatypes *)

(* options are datatypes *)
(* - NONE and SOME are constructors, not just functions *)
(* - use pattern matching, not isSome or valOf *)

fun inc_or_zero intoption =
    case intoption of
        NONE => 0
      | SOME i => i+i;

(* lists are datatypes *)
(* Don't use hd, tl, null. [] and :: are constructors too *)

fun sum_list xs =
    case xs of
        [] => 0
      | x::x' => x + sum_list xs';

fun append (xs, ys) =
    case xs of
        [] => ys
      | x::xs' => x :: append (xs', ys);


(* User defined polymorphic datatypes *)
(* Note: list, options are not types. int list, a' list, string option etc are types *)
(* check polymorphic_datatypes.sml *)

(* each-of pattern matching *)
(* check eachof_patterns.sml in course *)

(* In ML, every function takes exactly 1 argument and returns 1 value *)

fun abcd (x, y, z) =
    x+y+z;
(* this function doesn't take 3 arguments, instead it just take one tuple as arg *)
(* It's all just pattern matching all along *)
(* There's no concept of having multi-argument functions *)

fun full_name1 {first=x, middle=y, last=z} =
    x ^ " " ^ y ^ " " ^ z;
