(require hyrule.argmove *)
(require hyrule.anaphoric *)
(import scipy.optimize [milp LinearConstraint])
(import itertools [combinations-with-replacement])
(import sys [argv])

(defn schematic-to-int [schematic]
        (sum (ap-map (** 2 (int it)) schematic)))

(defn lights-to-int [lights]
    (-> (cut lights 1 -1)
        (.replace "." "0")
        (.replace "#" "1")
        (cut None None -1)
        (int 2)))

(defn parse-num-list [nums]
    (list (map int (.split (cut nums 1 -1) ","))))

(defn read-input [filename]
    (->> 
        (with [f (open filename "r")]
            (.readlines f))
        (ap-map (let [line (.split (.strip it) " ")
                      lights (lights-to-int (get line 0))
                      schematics (list (map parse-num-list (cut line 1 -1)))
                      joltages (parse-num-list (get line -1))]
            #(lights schematics joltages)))
        (list)))

(defn get-p1 [line]
    (setv [lights schematics _] line)
    (setv n 0)
    (while True
        (+= n 1)
        (setv correct (ap-map 
            (= lights (ap-reduce (^ it acc) it))
            (combinations-with-replacement (map schematic-to-int schematics) n)))
        (when (any correct) (break)))
    n)

(defn get-p2 [line]
    (setv [_ schematics joltages] line)
    (setv c (list (ap-map (let [joltage it]
        (list (ap-map (in joltage it) schematics)))
        (range (len joltages)))))
    (setv constr (LinearConstraint c :lb joltages :ub joltages))
    (setv a (* [1] (len schematics)))
    (-> (. (milp a :integrality a :constraints constr) x)
        (sum)
        (int)))

(setv inp (read-input (get argv 1)))
(print (sum (map get-p1 inp)))
(print (sum (map get-p2 inp)))