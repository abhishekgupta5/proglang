fun old_max (xs : int list) =
    if null xs
    then 0 (* Bad *)
    else if null (tl xs)
    then hd xs
    else
        let val tl_ans = old_max(tl xs)
        in
            if hd xs > tl_ans
            then hd xs
            else tl_ans
        end;


(* Using options *)
(* Better: returns an int option *)
(* fn: int list -> int option *)
fun max1 (xs : int) =
    if null xs
    then NONE
    else
        let val tl_ans = max1(tl xs)
        in
            if isSome tl_ans andalso valOf(tl_ans) > hd xs
            then tl_ans
            else SOME (hd xs)
        end;
