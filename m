From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 13 Jan 2016 16:10:22 +0100 (CET)
Subject: [Cocci] Build failure on ppc64le: Failure("dump: impossible tag
 (1002)")
In-Reply-To: <20160113150133.GO1766@redhat.com>
References: <20160113134818.GA30557@redhat.com>
 <alpine.DEB.2.10.1601131516180.5214@hadrien>
 <20160113142332.GM1766@redhat.com> <5696652C.5080903@users.sourceforge.net>
 <20160113150133.GO1766@redhat.com>
Message-ID: <alpine.DEB.2.10.1601131602430.5214@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I think I can get rid of the reliance on dump for normal execution.  It
won't solve the problem, but it should avoid it.

julia
