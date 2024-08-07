;; [nfnl-macro]

(fn require. [module field ...]
  `(. (require ,module) ,field ,...))

{: require.}
