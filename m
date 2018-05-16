From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 May 2018 22:29:30 +0200 (CEST)
Subject: [Cocci] [bug] exists do not work if file group is too big (>49)
In-Reply-To: <20180516202430.GE2994@redhat.com>
References: <20180516191634.GB2994@redhat.com>
 <alpine.DEB.2.20.1805162132050.3296@hadrien>
 <20180516195417.GC2994@redhat.com>
 <alpine.DEB.2.20.1805162200020.3296@hadrien>
 <20180516201559.GD2994@redhat.com>
 <alpine.DEB.2.20.1805162216500.3296@hadrien>
 <20180516202430.GE2994@redhat.com>
Message-ID: <alpine.DEB.2.20.1805162228160.3296@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> [glisse at localhost ~]$ spatch --version
> spatch version 1.0.6 compiled with OCaml version 4.05.0
> Flags passed to the configure script: --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --enable-release=yes --with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
> Python scripting support: yes
> Syntax of regular expresssions: PCRE

I don't think this indicates whether it is bytecode or native code, and I
don't know what the fedora people offer.

My bytecode executable is 41M and my native code executable is 13M.

julia
