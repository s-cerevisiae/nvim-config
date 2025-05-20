-- [nfnl] ftplugin/java.fnl
return require("jdtls").start_or_attach({cmd = {"jdtls"}, root_dir = vim.fs.dirname(vim.fs.find({"gradlew", ".git", "mvnw"}, {upward = true})[1])})
