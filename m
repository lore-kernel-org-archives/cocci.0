From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Wed, 14 Oct 2015 10:53:50 +0200
Subject: [Cocci] Compiling latest coccinelle with opensuse
In-Reply-To: <alpine.DEB.2.10.1510140956240.2421@hadrien>
References: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
 <alpine.DEB.2.02.1510132225490.2189@localhost6.localdomain6>
 <CAB=NE6V1K8-dq7A8PNY95+hSDGOFGdL8N=kjed5CF=ABLFqWLA@mail.gmail.com>
 <alpine.DEB.2.02.1510132256380.2189@localhost6.localdomain6>
 <20151013211451.GD14464@wotan.suse.de>
 <alpine.DEB.2.02.1510132317080.2189@localhost6.localdomain6>
 <20151013220512.GE14464@wotan.suse.de>
 <alpine.DEB.2.02.1510140724160.2038@localhost6.localdomain6>
 <20151014071143.GA6178@pema>
 <alpine.DEB.2.10.1510140956240.2421@hadrien>
Message-ID: <20151014085350.GB1543@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Luis: here is what I am guessing.

At some point in the past you have installed OCaml and then compiled
Menhir from sources with that version of OCaml. Meanwhile the OCaml
related packages got updated but Menhir has not been recompiled with
the updated version of OCaml, hence the inconsistency.

My suggestion would thus be to make sure you recompile Menhir with the
currently installed version of OCaml.

S?bastien.
