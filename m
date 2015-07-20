From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 20 Jul 2015 19:25:38 +0200 (CEST)
Subject: [Cocci] [PATCH v2 0/4] pycocci: index opts,
 SmPL patch proof support
In-Reply-To: <CAB=NE6UdMhy1WP+apzMKmCwe2eevwRy72h_5f0cx4_aYtQNofQ@mail.gmail.com>
References: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
 <alpine.DEB.2.02.1507181901020.2059@localhost6.localdomain6>
 <CAB=NE6VEpGSU2tY4H+QjuL82ku-Lz80sXN509q9_DgpbLnPEUQ@mail.gmail.com>
 <alpine.DEB.2.10.1507201826320.2475@hadrien>
 <CAB=NE6X2oHaW3VCR5F2o3j6RmEVeEdtwZenarM1U5qPeAB=F4Q@mail.gmail.com>
 <alpine.DEB.2.10.1507201913370.2475@hadrien>
 <CAB=NE6UdMhy1WP+apzMKmCwe2eevwRy72h_5f0cx4_aYtQNofQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1507201924530.2475@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Ah, so it should be safe to just check for the glimpse index on the
> target directory, use it if its there, otherwise default to using
> --use-gitgrep as a second step should be safe, regardless of whether
> or not the target (directory or file) is part of a git tree?

Yep.

julia
