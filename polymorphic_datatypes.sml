(* type is int list -> int *)
fun sum_list xs =
    case xs of
      | x::xs' => x + sum_list xs';

(* type is 'a list * 'a list -> 'a list *)
fun append (xs, ys) =
    case xs of
        [] => ys
      | x::xs' => x :: append(xs', ys);

(* polymorphic options - are implemented like this *)
datatype 'a option = NONE | SOME of 'a;

(* polymorphic lists *)
datatype 'a mylist = EMPTY | Cons of 'a * 'a list;

(* A btree that can have any type *)
datatype ('a, 'b) tree = Node of 'a * ('a, 'b) tree * ('a, 'b) tree
       | Leaf 'b;
(* a tree with leaves of one type and nodes with values of different types *)
(* Helper functions *)

(* type is (int, int) tree -> int *)
(* type checker knows this because we have i + in the case below *)
fun sum_tree tr =
    case tr of
        Leaf i => i
      | Node(i, lft, rgt) => i + sum_tree lft + sum_tree rgt;

(* type is ('a * int) tree -> int *)
(* type checker knows the type is this^ to have the definition legal *)
fun sum_leaves tr =
    case tr of
        Leaf i => i
      | Node(i, lgt, rgt) => sum_leaves lgt + sum_leaves rgt;

(* type is ('a * 'b) tree -> int *)
fun num_leaves tr =
    case tr of
        Leaf i => 1
      | Node(i, lgt, rgt) => num_leaves lgt + num_leaves rgt;
