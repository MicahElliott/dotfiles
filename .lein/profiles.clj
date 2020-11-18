{:user {:plugins      [
                       ;; [lein-pprint "1.1.2"]
                       ;; [lein-try "0.4.3"]
                       ;; [lein-bin  "0.3.5"]
                       ;; [lein-midje "3.2.1"]
                       [lein-kibit "0.1.6"]
                       [jonase/eastwood "0.3.5"]
                       ;; Exec tasks when files are modified
                       [lein-auto "0.1.3"]
                       ;; [refactor-nrepl "2.4.0"]
                       ;; [cider/cider-nrepl "0.18.0"]
                       ;; [cider/cider-nrepl "RELEASE"]
                       ;; [http-kit/lein-template "1.0.0-SNAPSHOT"]
                       [com.jakemccrary/lein-test-refresh "0.24.1"]
                       ;; Auto-run expectations
                       ;; [lein-auto expect "1.9.0"]
                       ;; Better stacktraces, colors, etc
                       ;; [venantius/ultra "0.5.2"]
                       ;; Find and automatically update project dependencies
                       [lein-ancient "0.6.15"]
                       ;; Enable requiring new libs without restarting repl
                       ;; [alembic "0.3.2"]
                       ;; Find dead/unused code
                       ;; [venantius/yagni "0.1.7"]
                       ;; Find repeats in code
                       ;; [lein-repetition-hunter "0.1.0-SNAPSHOT"]
                       ;; Create NSs with short names
                       ;; [com.gredericks/lein-shorthand "0.4.1"]
                       [lein-bikeshed "0.5.2"]
                       [lein-cljfmt "0.6.4"]
                       [lein-count "1.0.9"]
                       ]
        :dependencies [
                       [jsofra/data-scope "0.1.2"]
                       [pjstadig/humane-test-output "0.9.0"]
                       [clj-stacktrace "0.2.8"]
                       [com.cemerick/pomegranate "1.1.0"] ; doesn't play nice with data-scope charts
                       ;; [spyscope "0.1.7-SNAPSHOT"]
                       [hashp "0.2.0"]
                       ;; [alembic "0.3.2"]
                       ;; [repetition-hunter "1.0.0"]
                       ]
        :injections   [
                       ;; (require 'spyscope.core)
                       (require 'data-scope.inspect)
                       (require 'data-scope.pprint)
                       ;; Look neat but wonder if these are expensive to load
                       (require 'data-scope.charts)
                       (require 'data-scope.graphs)
                       (require 'hashp.core)
                       (require 'pjstadig.humane-test-output)
                       (pjstadig.humane-test-output/activate!)
                       (let [orig (ns-resolve (doto 'clojure.stacktrace require) 'print-cause-trace)
                             new  (ns-resolve (doto 'clj-stacktrace.repl require) 'pst)]
                         (alter-var-root orig (constantly (deref new))) )

                       (defn add-dependency [dep-vec]
                         (require 'cemerick.pomegranate)
                         ((resolve 'cemerick.pomegranate/add-dependencies)
                          :coordinates [dep-vec]
                          :repositories (merge @(resolve 'cemerick.pomegranate.aether/maven-central)
                                               {"clojars" "https://clojars.org/repo"})))
                       ]
        ;; :shorthand {. [clojure.pprint alembic.still/distill alembic.still/lein]}
        :license      {:author "Micah Elliott" :email "mde@micahelliott.com"}}
 :repl {:plugins      [
                       ;; [refactor-nrepl "2.4.0"]
                       ;; Maybe don't need this since Cider may handle it
                       ;; [cider/cider-nrepl "0.18.0"]
                       ]
        :dependencies [;; rips your namespace form apart and reconstructs it
                       ;; Not needed since cljrefactor
                       ;; [slamhound "RELEASE"]
                       ;; [spyscope "0.1.7-SNAPSHOT"]
                       ;; [org.thnetos/cd-client "0.3.6"] ; May break redl/nrepl
                       ]
        :injections   [
                       ;; (require 'spyscope.core)  ; needed by redl
                       ;; (require '[redl complete core])
                       ]
        }}
