From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Tue, 6 Jan 2015 16:39:10 +0100
Subject: [Cocci] Error: Unbound value Common.union_set
In-Reply-To: <54AB0D0B.3030909@Freescale.com>
References: <54AB026A.50909@Freescale.com>
 <alpine.DEB.2.02.1501052253220.2025@localhost6.localdomain6>
 <54AB0D0B.3030909@Freescale.com>
Message-ID: <20150106153910.GA11683@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Emil,

I'm an engineer working with Julia on Coccinelle.

Many thanks to you for having reported this issue. It is due to a change
in the OCaml compiler between versions 4.01 and 4.02. We will do our
best to fix Coccinelle as soon as possible so that it also works with
OCaml 4.02, but meanwhile, you can always make it work with an older
version of OCaml such as 4.01. Thismeans  to recompile coccinelle
e.g.with OCaml 4.01.

Hope this helps,
S?bastien.
