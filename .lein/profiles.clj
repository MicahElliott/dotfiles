{:user {:plugins [
                  ;; [lein-pprint "1.1.2"]
                  ;; [lein-try "0.4.3"]
                  ;; [lein-bin  "0.3.5"]
                  ;; [lein-midje "3.2.1"]
                  [lein-kibit "0.1.5"]
                  ;; [jonase/eastwood "0.2.3"]
                  ;; Exec tasks when files are modified
                  ;; [lein-auto "0.1.3"]
                  [refactor-nrepl "2.4.0-SNAPSHOT"]
                  ;; [refactor-nrepl "RELEASE"]
                  [cider/cider-nrepl "0.16.0-SNAPSHOT"]
                  ;; [cider/cider-nrepl "RELEASE"]
                  ;; [http-kit/lein-template "1.0.0-SNAPSHOT"]
                  [com.jakemccrary/lein-test-refresh "0.20.0"]
                  ;; Auto-run expectations
                  ;; [lein-autoexpect "1.9.0"]
                  ;; Better stacktraces, colors, etc
                  [venantius/ultra "0.5.1"]
                 ]
        :dependencies [[pjstadig/humane-test-output "0.8.0"]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]
        :license {:author "Micah Elliott" :email "mde@micahelliott.com"}}
 :repl {:dependencies [;; rips your namespace form apart and reconstructs it
                       ;; Not needed since cljrefactor
                       ;; [slamhound "RELEASE"]
                       ;; enable requiring new libs without restarting repl
                       [alembic "RELEASE"]
                       ;; [spyscope "0.1.5"]
                       ;; [org.thnetos/cd-client "0.3.6"] ; May break redl/nrepl
                       [clj-stacktrace "0.2.8"]
                      ]
        :injections [
                     ;; (require 'spyscope.core)  ; needed by redl
                     ;; (require '[redl complete core])
                     ;; (let [orig (ns-resolve (doto 'clojure.stacktrace require) 'print-cause-trace)
                     ;;       new  (ns-resolve (doto 'clj-stacktrace.repl require) 'pst)]
                     ;;   (alter-var-root orig (constantly (derefnew))) )
                    ]
        :plugins [
                 ]}}
