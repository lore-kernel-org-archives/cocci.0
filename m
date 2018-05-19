From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Sat, 19 May 2018 13:57:04 +0530
Subject: [Cocci] Need help compiling coccinelle on Ubuntu 16.04
In-Reply-To: <CAF_dkJCyP-2Yc-fynAGWp5D7YZP5ybaLXrYK4EHc_Z7XSP9kiA@mail.gmail.com>
References: <CAF_dkJCyP-2Yc-fynAGWp5D7YZP5ybaLXrYK4EHc_Z7XSP9kiA@mail.gmail.com>
Message-ID: <20180519082704.GA2797@himanshu-Vostro-3559>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, May 16, 2018 at 09:48:19AM -0400, Patrick Doyle wrote:
> TherI just tried compiling coccinelle on a Ubuntu 16.04 system, having
> installed all the dependencies that seem to make sense, and it fails
> to compile.
> 
> I need to use a version of spatch >= 1.0.6 for another project, and
> the version supplied with Ubuntu is 1.0.4.
> 
> So I:
> 
> $ git clone https://github.com/coccinelle/coccinelle.git
> $ cd coccinelle
> $ ./autogen
> $ ./configure --prefix=/home/wpd/local
> $ make
> 
> and that fails with
> 
> ...
> cp /usr/lib/ocaml/parmap/parmap.cmi ocaml/parmap.cmi
> cp /usr/lib/ocaml/parmap/parmap.cmx ocaml/parmap.cmx
> cp: cannot stat '/usr/lib/ocaml/parmap/parmap.cmx': No such file or directory
> Makefile:620: recipe for target 'ocaml/parmap.cmi' failed
> make: [ocaml/parmap.cmi] Error 1 (ignored)
> rm parsing_cocci/lexer_cli.ml parsing_cocci/parser_cocci_menhir.ml.d
> tools/spgen/source/spgen_lexer.ml
> parsing_cocci/parser_cocci_menhir.mli.d parsing_cocci/lexer_script.ml
> parsing_cocci/lexer_cocci.ml parsing_c/lexer_c.ml
> 
> I have installed libparmap-ocaml-dev:
> 
> $ apt search libparmap-ocaml-dev
> Sorting... Done
> Full Text Search... Done
> libparmap-ocaml-dev/xenial,now 1.0~rc7-1 amd64 [installed]
>   small OCaml library allowing to exploit multicore architectures
> 
> and /usr/lib/ocaml/parmp shows:
> 
> $ ls -l /usr/lib/ocaml/parmap
> total 312
> -rw-r--r-- 1 root root   2379 Jan 18  2016 bytearray.cmi
> -rw-r--r-- 1 root root   1615 Jan 18  2016 bytearray.mli
> -rw-r--r-- 1 root root   5218 Jan 18  2016 libparmap_stubs.a
> -rw-r--r-- 1 root root    219 Jan 18  2016 META
> -rw-r--r-- 1 root root 117954 Jan 18  2016 parmap.a
> -rw-r--r-- 1 root root  27116 Jan 18  2016 parmap.cma
> -rw-r--r-- 1 root root   5814 Jan 18  2016 parmap.cmi
> -rw-r--r-- 1 root root   1898 Jan 18  2016 parmap.cmxa
> -rw-r--r-- 1 root root 106712 Jan 18  2016 parmap.cmxs
> -rw-r--r-- 1 root root  10472 Jan 18  2016 parmap.mli
> -rw-r--r-- 1 root root    906 Jan 18  2016 parmap_utils.cmi
> -rw-r--r-- 1 root root    270 Jan 18  2016 parmap_utils.mli
> -rw-r--r-- 1 root root    363 Jan 18  2016 setcore.cmi
> -rw-r--r-- 1 root root    207 Jan 18  2016 setcore.mli

I had a similar issue previously due paramap dependency.
https://pastebin.com/teDP8R18

So, what I would suggest is first purge the Ubuntu supplied Coccinelle.
And then install all the packages as suggested in install.txt

-----------------------------------------------------------------------
himanshu at himanshu-Vostro-3559:~/coccinelle$ sudo apt-get install
pkg-config ocaml-native-compilers ocaml-findlib menhir and
libmenhir-ocaml-dev libpcre-ocaml-dev
[sudo] password for himanshu: 
Reading package lists... Done
Building dependency tree       
Reading state information... Done
pkg-config is already the newest version (0.29.1-0ubuntu1).
and is already the newest version (1.2.2-4.1).
libmenhir-ocaml-dev is already the newest version (20151112.dfsg-1).
libpcre-ocaml-dev is already the newest version (7.0.4-2build1).
menhir is already the newest version (20151112.dfsg-1).
ocaml-findlib is already the newest version (1.5.5-2build1).
ocaml-native-compilers is already the newest version (4.02.3-5ubuntu2).
The following packages were automatically installed and are no longer
required:
  libparmap-ocaml libpycaml-ocaml
  Use 'sudo apt autoremove' to remove them.

------------------------------------------------------------------------

This above is the result what I had got on my system when I had the issue.
Most important is that you *must* remove these packages "libparmap-ocaml
libpycaml-ocaml" as they are not required and were installed when you
installed the old Coccinelle version from Ubuntu.

After removing these packages, do 'make distclean' and then
./autogen 
...

as suggested in the instructions.

I also use Ubuntu 16.04.4 LTS and now Coccinelle works fine!

Hope this helps.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
