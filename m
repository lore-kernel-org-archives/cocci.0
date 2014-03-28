From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 28 Mar 2014 07:06:23 +0100 (CET)
Subject: [Cocci] Bug#742779: coccinelle introduces spurious whitespace
 changes
In-Reply-To: <20140328001518.GA4526@localhost.localdomain>
References: <20140327113728.14719.79688.reportbug@localhost>
 <20140328001518.GA4526@localhost.localdomain>
Message-ID: <alpine.DEB.2.02.1403280705540.2003@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thanks for forwarding the problem.  I know where it is, and will try to 
fix it shortly.

julia

On Fri, 28 Mar 2014, Eugeniy Meshcheryakov wrote:

> forwarded 742779 cocci at systeme.lip6.fr
> thanks
> 
> Hello,
> 
> I've got the following bug report from a Debian user. It can be easily
> reproduced with RC20. Note that there is no space before equals signs in
> the generated patch.
> 
> Regards,
> Eugeniy Meshcheryakov
> 
> 27 ??????? 2014 ? 12:37 +0100 Justus Winter ???????(-??):
> > Package: coccinelle
> > Version: 1.0.0~rc20.deb-1
> > Severity: normal
> > 
> > Dear Maintainer,
> > 
> > coccinelle recently (since I upgraded to jessie I guess) began to
> > introduce spurious whitespace changes for a certain semantic patch.  I
> > made a minimal test case:
> > 
> > % tail test.*
> > ==> test.c <==
> > int main () {
> >   int a = 4;
> >   a = 2;
> >   return a;
> > }
> > 
> > ==> test.cocci <==
> > @@
> > @@
> > +  char *f = "%lu";
> > 
> > main (...) {
> > ...
> > }
> > 
> > Curiously, the string %lu seems to trigger this.  Bad, e.g. the
> > current sid version:
> > 
> > % spatch --version
> > spatch version 1.0.0-rc20 with Python support and with PCRE support
> > % spatch --sp-file test.cocci test.c
> > init_defs_builtins: /usr/share/coccinelle/standard.h
> > HANDLING: test.c
> > diff = 
> > --- test.c
> > +++ /tmp/cocci-output-14372-7762e6-test.c
> > @@ -1,5 +1,6 @@
> > -int main () {
> > -  int a = 4;
> > -  a = 2;
> > +char *f= "%lu";
> > +int main() {
> > +  int a= 4;
> > +  a= 2;
> >    return a;
> >  }
> > 
> > Good, e.g. the version from wheezy:
> > 
> > % spatch --version
> > spatch version 1.0.0-rc12 with Python support and with PCRE support
> > % spatch --sp-file test.cocci test.c
> > init_defs_builtins: /usr/share/coccinelle/standard.h
> > HANDLING: test.c
> > diff = 
> > --- test.c
> > +++ /tmp/cocci-output-17254-5327d1-test.c
> > @@ -1,3 +1,4 @@
> > +char *f = "%lu";
> >  int main () {
> >    int a = 4;
> >    a = 2;
> > 
> > Thanks for your attention :)
> > 
> > -- System Information:
> > Distributor ID:	Debian
> > Description:	Debian GNU/Linux testing (jessie)
> > Release:	testing
> > Codename:	jessie
> > Architecture: amd64 (x86_64)
> > Foreign Architectures: i386
> > 
> > Kernel: Linux 3.13-1-amd64 (SMP w/2 CPU cores)
> > Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8)
> > Shell: /bin/sh linked to /bin/dash
> > 
> > Versions of packages coccinelle depends on:
> > ii  libc6                                   2.18-4
> > ii  libpcre-ocaml [libpcre-ocaml-36gi0]     7.0.4-1
> > ii  libpcre3                                1:8.31-2
> > ii  libpycaml-ocaml                         0.82-14+b3
> > ii  libpython2.7                            2.7.6-7
> > ii  ocaml-base-nox [ocaml-base-nox-4.01.0]  4.01.0-3
> > ii  ocaml-findlib                           1.4-2
> > ii  python-glade2                           2.24.0-3+b1
> > ii  python-gobject                          3.10.2-2
> > ii  python-gtk2                             2.24.0-3+b1
> > pn  python:any                              <none>
> > 
> > coccinelle recommends no packages.
> > 
> > Versions of packages coccinelle suggests:
> > pn  coccinelle-doc     <none>
> > pn  vim-addon-manager  <none>
> > 
> > -- no debconf information
> > 
> 
