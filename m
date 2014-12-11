From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Dec 2014 09:56:55 +0100 (CET)
Subject: [Cocci] Initialization thrown away
In-Reply-To: <CAGxBnffpDpnrVNnyE1Fqc=sm-2A8E8Q6NvHe+K_B9PDyOX90Lg@mail.gmail.com>
References: <CAGxBnffpDpnrVNnyE1Fqc=sm-2A8E8Q6NvHe+K_B9PDyOX90Lg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1412110955440.2772@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Actually, the problem is the following isomorphism:

Declaration
@ const_decl_init @
type T;
identifier Z;
constant C;
@@
T Z; => T Z = C;

In between the initial @@, you can put disable const_del_init.

julia
