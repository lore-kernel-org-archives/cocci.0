From: jglisse@redhat.com (Jerome Glisse)
Date: Wed, 16 May 2018 16:35:23 -0400
Subject: [Cocci] [bug] exists do not work if file group is too big (>49)
In-Reply-To: <alpine.DEB.2.20.1805162228160.3296@hadrien>
References: <20180516191634.GB2994@redhat.com>
 <alpine.DEB.2.20.1805162132050.3296@hadrien>
 <20180516195417.GC2994@redhat.com>
 <alpine.DEB.2.20.1805162200020.3296@hadrien>
 <20180516201559.GD2994@redhat.com>
 <alpine.DEB.2.20.1805162216500.3296@hadrien>
 <20180516202430.GE2994@redhat.com>
 <alpine.DEB.2.20.1805162228160.3296@hadrien>
Message-ID: <20180516203523.GF2994@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, May 16, 2018 at 10:29:30PM +0200, Julia Lawall wrote:
> > [glisse at localhost ~]$ spatch --version
> > spatch version 1.0.6 compiled with OCaml version 4.05.0
> > Flags passed to the configure script: --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --enable-release=yes --with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
> > Python scripting support: yes
> > Syntax of regular expresssions: PCRE
> 
> I don't think this indicates whether it is bytecode or native code, and I
> don't know what the fedora people offer.
> 
> My bytecode executable is 41M and my native code executable is 13M.

I am guessing native code:
-rwxr-xr-x. 1 root root 1.3K May 10 13:51 /usr/bin/spatch

J?r?me
