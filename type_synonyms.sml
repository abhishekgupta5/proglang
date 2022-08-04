datatype suit = Club | Diamond | Heart | Spade;
datatype rank = Jack | Queen | King | Ace | Num of int;

type card = suit * rank;

(* You can also give a type to a record *)
type name_record = { student_num : int option,
                     first : string,
                     middle : string option,
                     last : string };

(* Checks whether a card is a queen of spade *)
fun is_queen_of_spades (c : card) =
    #1 c = Spade andalso #2 c = Queen;

(* 3 variable bindings that can be treated as a card *)
val c1 : card = (Diamond,Ace);
val c2 : suit * rank = (Heart,Ace);
val c3 = (Spade,Ace);
(* All c1, c2 and c3 are of same types i.e 'card' or 'suit * rank' *)


(* We can also leave the type of c in the above function if we use case expression  *)
fun is_queen_of_spades2 c =
    case c of
        (Spade,Queen) => true
      | _ => false; (* For any other case use _  *)
