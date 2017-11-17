From: rjones@redhat.com (Richard W.M. Jones)
Date: Fri, 17 Nov 2017 19:03:08 +0000
Subject: [Cocci] Compiling with OCaml 4.06 / safe-string
Message-ID: <20171117190307.GA26286@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm trying to compile coccinelle with OCaml 4.06, where the default
for strings has been switched to -safe-string.

It currently fails to build in the bundled parmap library:

/usr/bin/ocamlc.opt -unsafe -I parmap.1.0-rc7.1 -custom -cclib -lparmap_stubs   -c parmap.1.0-rc7.1/bytearray.ml -o parmap.1.0-rc7.1/bytearray.cmo
File "parmap.1.0-rc7.1/bytearray.ml", line 38, characters 0-118:
Warning 3: deprecated: [@@noalloc] should be used instead of "noalloc"
File "parmap.1.0-rc7.1/bytearray.ml", line 41, characters 0-116:
Warning 3: deprecated: [@@noalloc] should be used instead of "noalloc"
File "parmap.1.0-rc7.1/bytearray.ml", line 47, characters 10-23:
Warning 3: deprecated: String.create
Use Bytes.create instead.
File "parmap.1.0-rc7.1/bytearray.ml", line 48, characters 28-29:
Error: This expression has type bytes but an expression was expected of type
         string

I tried fixing this, but the library is doing a bunch of stuff with
actually overwriting strings, and I'm not clear how safe that is with
-safe-string.  Anyway, a fix isn't trivial.  Upstream parmap doesn't
have a fix that I could see.

Obviously I could switch to -unsafe-string, but has anyone fixed this?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
