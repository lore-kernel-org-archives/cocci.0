From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Wed, 14 Oct 2015 09:11:43 +0200
Subject: [Cocci] Compiling latest coccinelle with opensuse
In-Reply-To: <alpine.DEB.2.02.1510140724160.2038@localhost6.localdomain6>
References: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
 <alpine.DEB.2.02.1510132225490.2189@localhost6.localdomain6>
 <CAB=NE6V1K8-dq7A8PNY95+hSDGOFGdL8N=kjed5CF=ABLFqWLA@mail.gmail.com>
 <alpine.DEB.2.02.1510132256380.2189@localhost6.localdomain6>
 <20151013211451.GD14464@wotan.suse.de>
 <alpine.DEB.2.02.1510132317080.2189@localhost6.localdomain6>
 <20151013220512.GE14464@wotan.suse.de>
 <alpine.DEB.2.02.1510140724160.2038@localhost6.localdomain6>
Message-ID: <20151014071143.GA6178@pema>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, Luis,

Normally, when Menhir is not installed, Coccinelle's buil system
should use the one provided in the bundles directory (same for MenhirLib).
At the moment this does not work quite wll and I am currently working on
fixing this issue.
Meanwhile, one other simple thing you could try is to install menhir
either through your distribution if it is packaged, or directly from
sources. Then start from a clean git repository and do the usual
procedure and I believe that shold work and would appreciate to know if it
does not.

hth,

S?bastien.
