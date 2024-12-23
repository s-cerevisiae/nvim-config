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

{: dot}
