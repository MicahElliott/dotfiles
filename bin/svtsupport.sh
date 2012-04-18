# This script must be SOURCED after sourcing icssetup.ksh. 
# It will setup for installing and testing svt source.
#
# Until the module Filter::Deeply is fixed to match comparisions with
# the windows defined temp dir format of
# "C:/DOCUME~1/mdelliot/LOCALS~1/Temp", we need to define TEMP, TMP,
# and TMPDIR.

SVT_MODULES="
   SVT-WkSpcMergeCommand
   CVSI-Time
   SvtWSDesc
   Fwd
   SVT-CreateConfigCommand
   Class-Generate-Sugar
   CVSI-Types
   CommandDriver
   UI-Text
   Common-Utils
   SVT-WkSpcConvertCommand
   SVT-ChangeSet
   CVSI
   SVT-MergeCommand
   SVT-WkSpcMakeCommand
   BldConfig
   Hash-TwoWay
   SVT-AdvanceCommand
   SvtUtils
   CVSI-Utils
   WorkingDirStack
   Data-Dumper-IO
   Tree-LabeledChild
   SVT-WkSpcCommitCommand
   SVT-WkSpcUpdateCommand
   SVT
   CVSI-Adder
   Exec-Command
   CVSI-Analyze
   CVSI-Layer2
   CVSI-Versions
   Sort-List-NumOrString
   SvtTypes
   Filter-Deeply
   SVT-CommitCommand
"

if [ x"$ICS_OSFAMILY" = x ]; then
   echo ICS environment not defined. Run icssetup.
   return 1;
fi

export PERLWORKINGDIR="$HOME/local"
export PERLLIB="$ICS_PERLLIB"
export PERL5LIB="$ICS_PERLLIB"
export SVT_PERLLIB="$PERLWORKINGDIR"
export SVT_PERL5LIB="$PERLWORKINGDIR"

alias pmake="perl Makefile.PL PREFIX=$PERLWORKINGDIR"

svtkill() {
   notsvt="Alloy FDB-GenerateNewFDB FDB-MakeTestReport ics
           Intel-NewModule Intel-NewSVTCommand tmt"
   for d in $notsvt; do rm -rf $d; done
}

svtgenmakefiles() {
   cmd='perl Makefile.PL PREFIX=$HOME/local'
   for d in $SVT_MODULES; do
      builtin cd $d
      $cmd
      builtin cd -
   done
}

svttest() {
   make test
}

svtinstall() {
   local args d
   if [ ${#} -lt 1 ]; then
      echo no args
      #args=$(cat MANIFEST-SVT )
      args="$SVT_MODULES"
      test $? || { echo "missing MANIFEST-SVT" ; return 1 ; }
   else
      for d in $*; do
         if test $d != "CVS" && test -d $d ; then
            args="$args $d"
         fi
      done
   fi
   for d in $args ; do
      origdir=$PWD
      echo $d
      cd $d
      perl Makefile.PL PREFIX=$HOME/local 
      make install
      cd $origdir
   done
}

ptest() {
   strtdir=`pwd`
   for direc in $*; do
      if [ -d "$direc/t" ]; then
         cd $direc
         echo "Doing tests in $direc"
         if [ "$direc" == "SVT-CreateConfigCommand" ]; then
            export SVT_TESTING=1
            SAVECVSROOT=$CVSROOT
            SAVEICSCVS=$ICS_CVS
            unset CVSROOT
            unset ICS_CVS
         fi
         pmake > pmake.out 2>&1
         make > make.out 2>&1
         make test > test.out 2>&1
         tail test.out
         if [ "$direc" == "SVT-CreateConfigCommand" ]; then
            unset SVT_TESTING
            CVSROOT=$SAVECVSROOT
            ICS_CVS=$SAVEICSCVS
         fi
      fi
      cd $strtdir
   done
}
