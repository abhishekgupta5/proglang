
(* Count from 1 to x *)
(* Via regular function programming *)
fun count_out(from: int, to: int) =
    if from = to
    then to::[]
    else from :: count_out(from+1, to)

fun count_from1(x: int) =
    count_out(1, x)

(* Via let expression - Inferior *)
(* count is only in scope of count_from1_let *)
fun count_from1_let(x: int) =
    let
        fun count(from: int, to: int) =
            if from = to
            then to::[]
            else from :: count(from+1, to)
    in
        count(1, x)
    end


(* Better *)
fun count_from1_let_better(x: int) =
    let
        fun count(from: int) =
            if from = x
            then x::[]
            else from :: count(from+1)
    in
        count(1)
    end
