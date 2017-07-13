From: dave@stgolabs.net (Davidlohr Bueso)
Date: Thu, 13 Jul 2017 08:42:25 -0700
Subject: [Cocci] coccinelle and libpython problems
Message-ID: <20170713154225.GM30414@linux-80c1.suse>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

In my first attempt to create a semantic patch, I'm having
trouble running anything related to coccinelle (both in the
kernel via coccicheck and directly calling 'spfile'). The
program errors out with:

Py.find_library: unable to find the Python library [libpython2.7m.so returned Library not found][libpython2.7.so returned Library not found]

This is freshly cloned (github) version of coccinelle. I
also tried going back a few versions and with checkout
to commits in 2016 and 2015 I'm getting the exact
same issue.

System is OpenSuse Leap 42.1, with the libpython packages
installed:

S | Name                   | Summary                           | Type   
--+------------------------+-----------------------------------+--------
i | libpython2_7-1_0       | Python Interpreter shared library | package
i | libpython2_7-1_0-32bit | Python Interpreter shared library | package
i | libpython3_4m1_0       | Python Interpreter shared library | package
  | libpython3_4m1_0-32bit | Python Interpreter shared library | package

Output of coccinelle's configure script (no parameters):

------------------------------------------------------------------------------
Summary, fwiw:

configure flags:  
findlib:          /usr/bin/ocamlfind	(an actual version is strongly recommended)
menhir:           /home/dave/code/coccinelle/bundles/menhirLib/menhir  (for local package use --without-menhir, install the menhir package otherwise)

ocaml scripting:  yes						       (overridable with --enable-ocaml)
python scripting: yes						       (overridable with --enable-python)

pcre regexes:     						       (overridable with --enable-pcre-syntax)
pcre module:      local						       (for local package use --disable-pcre)
pcre library:     yes						       (requires the libpcre-ocaml-dev package)

optimized spatch: yes						       (overridable with --disable-opt)

------------------------------------------------------------------------------
Coccinelle can now be compiled and installed.


If you compile coccinelle again after source code changes or
configuration changes, you may need to run first:
  $ make clean

To compile coccinelle, run:
  $ make

To install coccinelle, run:
  $ make install

Then, to test coccinelle, run for example:
  $ spatch -sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c

Or when coccinelle is not installed yet:
  $ COCCINELLE_HOME=/home/dave/code/coccinelle ./scripts/spatch -sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c
------------------------------------------------------------------------------
You may need to set some environment variables so that the python
libraries are found. The frontend 'spatch' sets the following variables:

  $ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
  $ export PYTHONPATH=$PYTHONPATH:${exec_prefix}/lib64/coccinelle/python

------------------------------------------------------------------------------

Setting the above vars explicitly I still run into the same libpython issue.
Even when everything is dully in /usr/local/lib64/coccinelle/

Does this ring any bells?

Thanks,
Davidlohr
