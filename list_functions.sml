(* This will have several functions that take and return lists *)

(* sum of elements of a list *)
(* int list -> int *)
fun sum_list (xs : int list) =
    if null xs
    then 0
    else hd xs + sum_list(tl xs)

(* int -> int list *)
fun countdown (x: int) =
    if x = 0
    then []
    else x::countdown(x-1)

(* append two lists *)
(* int list * int list -> int list *)
fun append (xs : int list, ys: int list) =
    if null xs
    then ys
    else (hd xs) :: append ((tl xs), ys)

(* functions over pairs of lists *)
(* (int * int) list -> int *)
fun sum_pair_list (xs: (int * int) list) =
    if null xs
    then 0
    else #1 (hd xs) + #2 (hd xs) + sum_pair_list(tl xs)

(* (int * int) list -> int list *)
fun firsts (xs: (int * int) list) =
    if null xs
    then []
    else (#1 (hd xs)) :: firsts (tl xs)


(* (int * int) list -> int list *)
fun seconds (xs: (int * int) list) =
    if null xs
    then []
    else (#2 (hd xs)) :: seconds (tl xs)

fun sum_pair_list2 (xs: (int * int) list) =
    (sum_list (firsts xs)) + (sum_list (seconds xs))

(* product of elements of a list *)
(* int list -> int *)
fun product_list (xs : int list) =
    if null xs
    then 1
    else hd xs * product_list(tl xs)

fun factorial (x : int) =
    product_list (countdown x)
