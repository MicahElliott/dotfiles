(try (require 'leiningen.hooks.clj-stacktrace-test)
     (def settings {:repl-options [:init (require 'clj-stacktrace.repl)
                                   :caught 'clj-stacktrace.repl/pst+]})
  (catch java.io.FileNotFoundException _))
