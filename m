From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Wed, 14 Oct 2015 16:47:48 +0200
Subject: [Cocci] Compiling latest coccinelle with opensuse
In-Reply-To: <20151013220512.GE14464@wotan.suse.de>
References: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
 <alpine.DEB.2.02.1510132225490.2189@localhost6.localdomain6>
 <CAB=NE6V1K8-dq7A8PNY95+hSDGOFGdL8N=kjed5CF=ABLFqWLA@mail.gmail.com>
 <alpine.DEB.2.02.1510132256380.2189@localhost6.localdomain6>
 <20151013211451.GD14464@wotan.suse.de>
 <alpine.DEB.2.02.1510132317080.2189@localhost6.localdomain6>
 <20151013220512.GE14464@wotan.suse.de>
Message-ID: <20151014144748.GB4635@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Luis,

As the output of your rpm command shows, it seems your system has a
mixture of packages installed, some from ocaml 4.02.1, others from ocaml
4.02.3. So, if completely uninstalling menhir, making sure all its iles
have been removed from your system and then recompiling it is notenough,
one other thing that may be worse trying is to also uninstall every
OCaml related packages and then re-installing them.

S?bastien.
