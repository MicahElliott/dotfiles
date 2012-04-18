#!/usr/bin/env python

"""
This file contains the sample code for XXX.  Search for the string CONTENT to
skip directly to it.

Executing this file will begin an enhanced interactive Python session.  You
can step through each slide of sample code and explore the results.  If your
explorations hose the environment, just quit, restart and jump directly to the
slide where you left off.

The block of code below sets up the interactive session.  Skip over it to view
the sample code.
"""

##############################################################################
#
# sliderepl - 0.12
#   Copyright (c) Jason Kirtland <jek@discorporate.us>
#   sliderepl lives at http://discorporate.us/projects/sliderepl
#   sliderepl is licensed under the MIT License:
#   http://www.opensource.org/licenses/mit-license.php
#
# sliderepl may be textually included in a file that also contains its input
# data.  The input data may be under a different license. sliderepl's MIT
# License covers only this block of sliderepl code, extensions and other
# derivative works.
#
# Looking for the sample code?
#                        _ _       _
#     ___  ___ _ __ ___ | | |   __| | _____      ___ __
#    / __|/ __| '__/ _ \| | |  / _` |/ _ \ \ /\ / / '_ \
#    \__ \ (__| | | (_) | | | | (_| | (_) \ V  V /| | | |
#    |___/\___|_|  \___/|_|_|  \__,_|\___/ \_/\_/ |_| |_|
#
# This bootstrapping code loads the sample code below into an interactive
# Python session.

environ = globals().copy()
import code, inspect, itertools, logging, re, sys, traceback
try:
    import rlcompleter, readline
except ImportError:
    readline = None


class Deck(object):
    expose = ('commands', 'next', 'goto', 'show', 'info', 'quick')

    def __init__(self, path=None):
        self.path = path or '<no file>'
        self.slides = []
        self.current = 0
        self.enter_advances = False

    def start(self):
        pass

    def next(self):
        """Advance to the next slide."""
        if self.current >= len(self.slides):
            print "% The slideshow is over."
            return
        slide = self.slides[self.current]
        self.current += 1
        print "%%\n%% Running slide %s\n%%" % (self.current)
        if (slide.name and
            not (slide.name.isdigit() and int(slide.name) == self.current)):
            print "%% %s" % slide.name
        slide.run()

    def slide_actor(fn):
        def decorated(self, slide_number):
            if isinstance(slide_number, str) and not slide_number.isdigit():
                print "%% Usage: %s slide_number" % fn.__name__
                return
            num = int(slide_number)
            if num < 1 or num > len(self.slides):
                print "%% Slide #%s is out of range (1 - %s)." % (
                    num, len(self.slides))
            else:
                return fn(self, num)
        decorated.__doc__ = fn.__doc__
        return decorated

    def show(self, slide_number):
        """show NUM, display a slide without executing it."""
        print str(self.slides[slide_number - 1]).strip()
    show = slide_actor(show)

    def goto(self, slide_number):
        """goto NUM, skip forward to another slide."""
        if slide_number <= self.current:
            print "% Cowardly refusing to re-run slides."
        else:
            for _ in range(slide_number - self.current):
                self.next()
    goto = slide_actor(goto)

    def info(self):
        """Display information about this slide deck."""
        print "%% Now at slide %s of %s from deck %s" % (
            self.current, len(self.slides), self.path)

    def commands(self):
        """Display this help message."""
        for cmd in self.expose:
            print "% " + cmd
            print "%\t" + getattr(self, cmd).__doc__


    def quick(self, toggle):
        """quick on|off, type enter to advance to the next slide."""
        if toggle not in ('on', 'off'):
            print 'usage: quick on|off'
        else:
            self.enter_advances = (toggle == 'on')
            print "%% Quick mode %s (enter will advance to the next slide)" % (
                toggle)
    del slide_actor

    class Slide(object):
        def __init__(self, name=None):
            self.name = name
            self.codeblocks = []
            self.lines = []
            self._stack = []
            self._level = None
        def run(self):
            for display, co in self.codeblocks:
                if not getattr(self, 'no_echo', False):
                    shown = [getattr(sys, 'ps1', '>>> ') + display[0]]
                    shown.extend([getattr(sys, 'ps2', '... ') + l
                                          for l in display[1:]])
                    Deck._add_history(''.join(display).rstrip())
                    print ''.join(shown).rstrip()
                try:
                    exec co in environ
                except:
                    traceback.print_exc()
        def __str__(self):
            return ''.join(self.lines)
        def _append(self, line):
            self.lines.append(line)
            if not self._stack and line.isspace():
                return
            indent = len(line) - len(line.lstrip())
            if not self._stack:
                self._level = indent
            elif indent <= self._level:
                try:
                    co = self._compile()
                    if co:
                        self.codeblocks.append((self._pop(), co))
                except SyntaxError:
                    pass
            self._stack.append(line)
        def _close(self):
            if self._stack:
                co = self._compile()
                assert co
                self.codeblocks.append((self._pop(), co))
        def _compile(self):
            style = getattr(self, 'no_return', False) and 'exec' or 'single'
            return code.compile_command(''.join(self._stack), '<input>', style)
        def _pop(self):
            self._stack.reverse()
            lines = list(itertools.dropwhile(str.isspace, self._stack))
            lines.reverse()
            self._stack = []
            return lines

    def run(cls, path=None):
        """Run an interactive session for this Deck and exit when complete.

        If '--run-all' is first on the command line, all slides are executed
        immediately and the script will exit.  Useful for sanity testing.
        """
        if path is None:
            path = sys.argv[0]
        deck = cls.from_path(path)
        if not deck:
            sys.stderr.write("Aborting: no slides!\n")
            sys.exit(-1)

        deck.start()

        if sys.argv[1:] and sys.argv[1] == '--run-all':
            deck.goto(len(deck.slides))
            sys.exit(0)

        console = code.InteractiveConsole()
        global environ
        environ = console.locals
        console.raw_input = deck.readfunc
        if readline:
            readline.parse_and_bind('tab: complete')
            readline.set_completer(rlcompleter.Completer(environ).complete)
        console.interact(deck.banner)
        sys.exit(0)
    run = classmethod(run)

    def from_path(cls, path):
        """Create a Deck from slides embedded in a file at path."""
        sl_re = re.compile(r'### +slide::\s*')
        a_re = re.compile(r',\s*')

        fh, deck, slide = open(path), cls(path), None
        for line in fh:
            if not sl_re.match(line):
                if slide:
                    slide._append(line)
                continue
            if slide:
                slide._close()
                deck.slides.append(slide)
            metadata = sl_re.split(line, 2)[1].split('-*-', 2)
            name = metadata[0].strip()
            if name == 'end':
                break
            slide = cls.Slide(name=name or None)
            if len(metadata) >= 2:
                for option in (metadata[1] and a_re.split(metadata[1]) or []):
                    setattr(slide, option.strip(), True)
        fh.close()
        return deck.slides and deck or None
    from_path = classmethod(from_path)

    def banner(self):
        return """\
%% This is an interactive Python prompt.
%% Extra commands: %s
%% Type "next" to start the presentation.""" % ', '.join(self.expose)
    banner = property(banner)

    def readfunc(self, prompt=''):
        line = raw_input(prompt)
        if prompt == getattr(sys, 'ps1', '>>> '):
            tokens = line.split()
            if line == '' and self.enter_advances:
                tokens = ('next',)
            if tokens and tokens[0] in self.expose:
                fn = getattr(self, tokens[0])
                if len(tokens) != len(inspect.getargspec(fn)[0]):
                    print "usage: %s %s" % (
                        tokens[0], ' '.join(inspect.getargspec(fn)[0][1:]))
                else:
                    self._add_history(line)
                    fn(*tokens[1:])
                return ''
        return line

    def _add_history(cls, line):
        if readline and line:
            readline.add_history(line)
    _add_history = classmethod(_add_history)

#  end of sliderepl
#
##############################################################################

Deck.run()

#        ____ ___  _   _ _____ _____ _   _ _____ _
#       / ___/ _ \| \ | |_   _| ____| \ | |_   _| |
#      | |  | | | |  \| | | | |  _| |  \| | | | | |
#      | |__| |_| | |\  | | | | |___| |\  | | | |_|
#       \____\___/|_| \_| |_| |_____|_| \_| |_| (_)
#
# Slide CONTENT starts here.

### slide::

welcome = ['Welcome to the demo slide content.',
           'Type "next" to advance to the next slide.']
print '\n'.join(welcome)

### slide::

msg = ('sliderepl was written to provide an interactive accompaniment '
       'to an in-person presentation.  Slides of sample code '
       'corresponded to sample code shown on screen.  With sliderepl, '
       'participants could run the code themselves without retyping or '
       'copy-and-pasting from a text file.')

more = ('The >>> prompt is a regular interactive session, with tab '
        'completion enabled if the host supports it.'
        'Type "show 2" to see the source for this slide.')

### slide::

# A basic deck with sliderepl embedded will read its own source file
# for slide definitions.
#
# Just include sliderepl before your slides and call Deck.run().

### slide::

s = 234
s

### slide::

print s

# the execution environment is preserved from slide to slide.

### slide::

try:
    Deck
    assert False
except NameError:
    print "Slides are executed in an isolated Python environment."
    print "sliderepl and its imports will not be visible to "
    print "the code in your slides."

### slide::

s = """\
Slides are delimited with ### slide:: markers in the text.
They must start at the beginning of a line.  If you like, you
can number them for folks reading the slide source:

   ### slide:: 12

The last slide must be marked:

   ### slide:: end

sliderepl ignores everything in the slide source file except the lines
between the first slide and the last.
"""

### slide:: -*- no_echo -*-

print """\
There are a couple of additional tricks available when defining slides.
If you want to do a purely messaging slide, like this one, you can mark
the slide -*- no_echo -*- and its code won't be shown: just the output.

Type "show 8" to see the source for this slide.
"""

### slide::

# but most of the time you'll probably just comment to illustrate a point
stuff = [i ** 2 for i in range(1, 10)]

### slide:: -*- no_echo -*-

print """\
  This is about walking through code interactively, not projecting
  onto a screen.  There are other tools that combine a Python prompt
  with "bullet points and graphics" style presentation.

  That said, this deck will keep acting like a presentation anyways.
  Consider it a kind of doctest.
"""

### slide::

a = "Does your terminal have readline support?"
b = "Each bit of code is added to the readline history as if you typed it."""

### slide:: -*- no_return -*-

"Adding -*- no_return -*- suppresses the auto-repr of a statement's result."

"Both options can be used in combination, -*- no_echo, no_return -*-"

### slide:: -*- no_echo -*-

print """\
If you execute this script with --run-all, it will run all the slides
and exit.  Useful for testing that the code still works.
"""

### slide:: -*- no_echo, no_return -*-

print """\
You can extend Deck to add custom initialization and commands.

A Deck calls .start() as its first action.  In start() you can do
things like run commands (self.quick('on')) and ensure that the
user has the correct versions of required libraries installed.

To add commands, just provide an extended .expose in your subclass and
add the command as a method.  It's simple, see Deck for examples.

sliderepl has been tested with Python 2.3, 2.4, 2.5. and 2,6a.
"""

### slide:: -*- no_echo -*

print """That's it!

Test cases follow."""

### slide::

class Foo(object):
    def __init__(self):
        self._bar = 123

    def bar(self):
        return self._bar

f = Foo()

### slide::

assert f.bar() == 123

### slide:: end

