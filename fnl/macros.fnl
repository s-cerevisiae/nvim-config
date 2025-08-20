;; [nfnl-macro]

;; require("a").setup(b)
;; ((. (require "a") :setup) b)
;; (dot (require "a") (setup b))
(fn dot [x & args]
  (fn transform [x form]
    (case form
      ;; (dot x y) => (. x "y")
      (where form (sym? form)) `(. ,x ,(tostring form))
      ;; (dot x [y z]) => (. x y z)
      (where exprs (sequence? exprs)) `(. ,x ,(unpack exprs))
      ;; (dot x (f a)) => ((. x "f") a)
      [symbol & rest] `((. ,x ,(tostring symbol))
                        ,(unpack rest))
      ;; (dot x ()) => (x)
      [] `(,x)))
  (case args
    ;; (dot x form rest ...) => (dot (dot x form) rest ...)
    [form & rest] (dot (transform x form) (unpack rest))
    ;; (dot x) => x
    [] x))

;; produce a mixed table by inserting positional args
;; into the last table
(fn | [& args]
  (let [len (length args)]
    (table.move args 1 (- len 1) 1 (. args len))))

{: dot : |}
