From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Thu, 4 Dec 2014 12:31:47 -0500
Subject: [Cocci] What is the spatch file for this change and the
 corresponding spatch command line invocation
In-Reply-To: <54805AF2.5060105@inria.fr>
References: <547F4892.6080405@inria.fr> <20141203173449.GX25677@wotan.suse.de>
 <5480584A.30107@inria.fr>
 <alpine.DEB.2.10.1412041354440.2118@hadrien> <54805AF2.5060105@inria.fr>
Message-ID: <CAB=NE6WYTM8RG_hF5unEo3yWQv=XizhyoaZ6pkQrQH7pfGKWPA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Dec 4, 2014 at 8:00 AM, Francois Berenger
<francois.berenger@inria.fr> wrote:
> The availability of a working spdiff tool, shipping and synchronized with
> coccinelle may lower the entry barrier to new  users:
> users could start writing working spatches just by editing
> a working starting example they may have inferred using spdiff
> from an actual source code difference.

Agreed. One must not lightly discard the theoretical complexities and
challenges to even come up with Coccinelle and spdiff, as Coccienlle
matures I'm afraid we haven't yet had much exposure on users to
spdiff, so it may take some time to get users what you describe
seamlessly.

 Luis
