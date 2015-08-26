From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Wed, 26 Aug 2015 17:30:32 +0200
Subject: [Cocci] Can we stop supporting OCaml 3.11?
Message-ID: <20150826153032.GA9709@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear all,

At the moment, the oldest version of OCaml which can be used to compile
Coccinelle is 3.11.
However, it turns out that OCaml 3.11.2 (released in January 2010)
has a bug that pevents from compiling the optimized version o
Coccinelle.

We would like to drop our support of OCaml 3.11 and start with OCaml
3.12.0 that has been released in August 2010.

Is anybody still using OCaml 3.11?

Thanks a lot for your reponse,

S?bastien.
