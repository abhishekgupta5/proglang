(* Let expressions to avoid repeated computation *)
(* Returns the max number from a list of integers *)
fun bad_max (xs : int list) =
    if null xs (* Handle empty list. Horribly handled here. Not imp rn *)
    then 0
    else if null (tl xs) (* Handle 1 element list *)
    then hd xs
    else if hd xs > bad_max (tl xs)
    then hd xs
    else bad_max (tl xs);

(* Helper functions *)
(* Returns [from,from+1,...,to] *)
fun countup (from : int, to : int) =
    if from=to
    then to::[]
    else from::countup (from+1, to);

(* Returns [from,from-1,...,to] *)
fun countdown (from : int, to : int) =
    if from=to
    then to::[]
    else from::countdown (from-1, to);


(* bad_max(countdown(30,1)) - Instant answer *)
(* bad_max(countdown(30000, 1)) - Instant answer *)
(* bm(30,..) -> bm(29,..) -> bm(28,..).. -> bm(1) - Linear time *)

(* bad_max(countup(1,30)) - Takes a lot of time *)
(* bm(1,.) -> 2 times bm(2,..) -> 4 times bm(3,..) - Exponential time(2^30 times) *)

(* Precomputation - storing result of a task which is done repeatedly *)
(* Avoid comuting bad_max twice by remembering it's answer in a variable *)

fun good_max (xs: int list) =
    if null xs
    then 0
    else if null (tl xs)
    then hd xs
    else
        let val tl_ans = good_max (tl xs)
        in
            if hd xs > tl_ans
            then hd xs
            else tl_ans
        end;

(* gm is now linear time *)
