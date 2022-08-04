(* datatype bindings as linked list *)
(* Defining a linked list *)
datatype my_int_list = Empty
                     | Cons of int * my_int_list;

(* Declaring a linkedlist *)
val x = Cons (30, Cons (6, Cons(1961, Empty)));
val y = Cons (28, Cons (6, Cons(1968, Empty)));

fun append_my_list (xs, ys) =
    case xs of
        Empty => ys
      | Cons (x, xs') => Cons(x, append_my_list(xs', ys));

(* usage *)
append_my_list(x, y);
