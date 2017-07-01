From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 1 Jul 2017 20:44:03 +0200 (CEST)
Subject: [Cocci] possible seg fault
Message-ID: <alpine.DEB.2.20.1707012039560.5929@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

There is a possibility of a random segmentation fault in Coccinelle due a
problem in Intel Skylake/Kaby Lake processors, which were first released
in 2015.  More information about the affected processors and how to fix
them is available here:

https://lists.debian.org/debian-devel/2017/06/msg00308.html

OCaml programs that are compute intensive are apparently particularly
vulnerable to the problem, although the problem is not OCaml specific.

julia
