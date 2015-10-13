From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 13 Oct 2015 22:58:27 +0200 (CEST)
Subject: [Cocci] Compiling latest coccinelle with opensuse
In-Reply-To: <CAB=NE6V1K8-dq7A8PNY95+hSDGOFGdL8N=kjed5CF=ABLFqWLA@mail.gmail.com>
References: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
 <alpine.DEB.2.02.1510132225490.2189@localhost6.localdomain6>
 <CAB=NE6V1K8-dq7A8PNY95+hSDGOFGdL8N=kjed5CF=ABLFqWLA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1510132256380.2189@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I doubt it will help much, but you can get rid of the need to link with 
menhirLib by removing the option --table in parsing_cocci/Makefile.  You 
will end up with a .ml file of over 100 000 lines, which may cause other 
problems for the ocaml compiler.

julia
