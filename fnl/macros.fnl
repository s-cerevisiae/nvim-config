;; [nfnl-macro]

;; require("a").setup(b)
;; ((. (require "a") :setup) b)
;; (dot (require "a") (setup b))
(fn dot [x form & rest]
  (fn transform [x form]
    (if (sym? form)
        `(. ,x ,(tostring form))
        (let [[symbol & rest] form]
          `((. ,x ,(tostring symbol))
            ,(unpack rest)))))
  (if (= 0 (length rest))
    (transform x form)
    (dot (transform x form) (unpack rest))))

;; produce a mixed table by inserting positional args
;; into the last table
(fn | [& args]
  (let [len (length args)]
    (table.move args 1 (- len 1) 1 (. args len))))

{: dot : |}
