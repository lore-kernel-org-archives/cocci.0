From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 4 Dec 2015 17:16:19 +0100 (CET)
Subject: [Cocci] Using Coccinelle to add #include lines
In-Reply-To: <CAFEAcA-PnYAapj3tc5CiD4r5UROcbrO0x2=7xGTv+XqCjXWFKg@mail.gmail.com>
References: <CAFEAcA-HKiMsz36SbfaGN3Oaz3Jn_h+f8McaHo48zmsngJtyRg@mail.gmail.com>
 <alpine.DEB.2.10.1512041701250.2768@hadrien>
 <CAFEAcA-PnYAapj3tc5CiD4r5UROcbrO0x2=7xGTv+XqCjXWFKg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1512041713520.2768@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Hmm. Maybe I'm better off just using sed or perl for this job?
> #include lines are really pretty much line-based after all.

If you have a good solution for getting the first include with sed or
perl, I think it would be better to do that.  Coccinelle is designed to be
independent of the position of top-level entities in the file, so it is
not very convenient to make it sensitive to that.

julia
