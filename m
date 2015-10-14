From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Wed, 14 Oct 2015 23:53:41 +0200
Subject: [Cocci] Common.union_setError (was: Compiling latest coccinelle
 with opensuse)
In-Reply-To: <alpine.DEB.2.02.1510142345000.1977@localhost6.localdomain6>
References: <alpine.DEB.2.02.1510140724160.2038@localhost6.localdomain6>
 <20151014071143.GA6178@pema>
 <alpine.DEB.2.10.1510140956240.2421@hadrien>
 <20151014085350.GB1543@pl-59055.rocqadm.inria.fr>
 <20151014205913.GH14464@wotan.suse.de>
 <alpine.DEB.2.02.1510142301540.1977@localhost6.localdomain6>
 <20151014212301.GJ14464@wotan.suse.de>
 <alpine.DEB.2.02.1510142324400.1977@localhost6.localdomain6>
 <20151014213934.GL14464@wotan.suse.de>
 <alpine.DEB.2.02.1510142345000.1977@localhost6.localdomain6>
Message-ID: <20151014215341.GC2920@pema>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall (2015/10/14 23:47 +0200):
> OK, menhirLib is always needed with Coccinelle.  Maybe Coccinelle manages 
> to use its own version, if you don't have one installed.  I had thought 
> that Sebastien said that the menhir bundle was not being activated, but 
> perhaps I misunderstood.

I'm myself confused, sorry about that Julia. There definitely is an
issue in Coccinelle's uild system regading this. What I noiced (using
INria's tree) is that Coccinelle is not able to use its bundled menhir.
So if no Menhir is installed, things go wrong. I don't remember exactly
what goes wrong but there's deinitely something that needs to be fixed
here.

S?bastien.
