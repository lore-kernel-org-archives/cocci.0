From: rjones@redhat.com (Richard W.M. Jones)
Date: Tue, 27 Oct 2015 11:57:33 +0000
Subject: [Cocci] version 1.0.3 released
In-Reply-To: <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
Message-ID: <20151027115733.GB14273@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Oct 27, 2015 at 11:25:17AM +0100, S?bastien Hinderer wrote:
> Dear Richard,
> 
> Many thanks for your report!
> 
> In coccinelle's source directory, could you please try the following:
> 
> make distclean
> ./autogen
> ./configure
> ...

Note this is an RPM build, so it always starts from the pristine
unpacked tarball.

I finally worked out how to fix the problem:

  rm parsing_cocci/parser_cocci_menhir.ml parsing_cocci/parser_cocci_menhir.mli
  ./configure --with-menhir=/usr/bin/menhir

so that the intermediate files are regenerated.

BTW the 'spgen' program is installed, but it's broken.  It's built as
a bytecode program using 'ocamlc -custom', RPM strips it (removing the
bytecode), and consequently the binary won't function on Fedora.  It
should have been built as a native program since I requested 'make world'.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
