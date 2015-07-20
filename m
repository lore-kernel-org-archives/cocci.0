From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 20 Jul 2015 10:31:52 -0700
Subject: [Cocci] [PATCH v2 0/4] pycocci: index opts,
	SmPL patch proof support
In-Reply-To: <alpine.DEB.2.10.1507201924530.2475@hadrien>
References: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
 <alpine.DEB.2.02.1507181901020.2059@localhost6.localdomain6>
 <CAB=NE6VEpGSU2tY4H+QjuL82ku-Lz80sXN509q9_DgpbLnPEUQ@mail.gmail.com>
 <alpine.DEB.2.10.1507201826320.2475@hadrien>
 <CAB=NE6X2oHaW3VCR5F2o3j6RmEVeEdtwZenarM1U5qPeAB=F4Q@mail.gmail.com>
 <alpine.DEB.2.10.1507201913370.2475@hadrien>
 <CAB=NE6UdMhy1WP+apzMKmCwe2eevwRy72h_5f0cx4_aYtQNofQ@mail.gmail.com>
 <alpine.DEB.2.10.1507201924530.2475@hadrien>
Message-ID: <CAB=NE6WWVSNUWyZThBe+eXoUCV+RrDuDPjUqa8bJ5Uf0Dw93NQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jul 20, 2015 at 10:25 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> Ah, so it should be safe to just check for the glimpse index on the
>> target directory, use it if its there, otherwise default to using
>> --use-gitgrep as a second step should be safe, regardless of whether
>> or not the target (directory or file) is part of a git tree?
>
> Yep.

Great thanks, can you confirm if that safe for Coccinelle 1.0.1 or
will that only be a safe bet for 1.0.2 ? If only safe for 1.0.2 then I
can have it default only for 1.0.2 and for 1.0.2 leave the check in
place?

 Luis
