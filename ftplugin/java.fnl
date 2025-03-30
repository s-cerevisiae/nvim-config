(import-macros {: dot} :macros)

(dot (require :jdtls)
     (start_or_attach
       {:cmd ["jdtls"]
        :root_dir (vim.fs.dirname
                    (-> ["gradlew" ".git" "mvnw"]
                        (vim.fs.find {:upward true})
                        (. 1)))}))
