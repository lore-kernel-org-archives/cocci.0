Return-Path: <SRS0=6jWL=P3=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F92BC433F5
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 14:45:20 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69168611C1
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 14:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69168611C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2573353"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2021 15:45:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DFB37E02AF; Mon,  8 Nov 2021 15:45:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 443ACE004C
	for <cocci@sympa.inria.fr>; Mon,  8 Nov 2021 15:45:13 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3AMAnBwawHLY9VAs/X+Bx6t+fyxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApD4j12dTmzNJW2zSM6uNMGvzL4hyPY62pBxX6sTcnNZhHQtv/xmBbVoa8?=
 =?us-ascii?q?JufXYzxwmTYZn7JcJWbFCqL1yivAzX5BJhcokT0+1H9bdANkVEmjfvRH+OkWLa?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAfNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?Nkr/3aEwHRNY+PyDe1zwIC+772EEE/3Npuko4HKN0hUN/iSiNntk3zNxSvJi0Y?=
 =?us-ascii?q?QYvJKzF3uoHO/VdO3sjYvYdo+WvzX+X9Jb7I1f9W2Xmyv9tBWktIJYVvO1laUl?=
 =?us-ascii?q?L/vMCLz4lbR2Zge+yhrWhRYFEjcMoJ8jDJ5IaongmzDfDDP9gT4qrfklgzbe0x?=
 =?us-ascii?q?x9p2ZsIRKyHIZRJL2oyKg7NfVtUNE1RDp8i9NpET0LXK1VwwG95b4Jti4QL8DF?=
 =?us-ascii?q?M7Q=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ag94LNax6W5VKHvBNK+xFKrPw4b1zdoMgy1kn?=
 =?us-ascii?q?xilNoNJuA6+lfqeV9sjztCWetN9/Yh8dcLy7VZVoBEmsl6Kdn7NxAV7SZmXbUQ?=
 =?us-ascii?q?KTRelfBMnZowEIcBeQygcp79YaT0EIMqyJMbEVt7ee3ODBKadY/DDRytHPuc7u?=
 =?us-ascii?q?i0R9aQdga6Rtqy1+DgKSFUAefngjObMJUKmMwsxNpz+tPUsadd66AH5tZZmlm+?=
 =?us-ascii?q?H2?=
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2573332"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 15:45:14 +0100
Date: Mon, 8 Nov 2021 15:45:12 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Vlastimil Babka <vbabka@suse.cz>
cc: Luis Chamberlain <mcgrof@kernel.org>, cocci@inria.fr
In-Reply-To: <b7aea196-c9d9-6d8d-8ba0-ab2a361ba1ad@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111081542290.2988@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz> <YYVZva1hfwanXdyB@bombadil.infradead.org> <70748876-5df6-080b-f1da-1f94371001db@suse.cz> <b7aea196-c9d9-6d8d-8ba0-ab2a361ba1ad@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Need some help with spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 96
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111081542290.2988%40hadrien>



On Mon, 8 Nov 2021, Vlastimil Babka wrote:

> On 11/8/21 00:08, Vlastimil Babka wrote:
> > On 11/5/21 17:20, Luis Chamberlain wrote:
> >> On Fri, Nov 05, 2021 at 05:12:09PM +0100, Vlastimil Babka wrote:
> >>> 1) patching complex variable declarations;
> >>>
> >>> I need to perform changes such as:
> >>> -struct page *page;
> >>> +struct slab *slab;
> >>>
> >>> This I was able to somehow specify in the .cocci, but not for situations
> >>> where the original declarations looks like this:
> >>>
> >>> struct page *page, *page2;
> >>>
> >>> or
> >>>
> >>> struct page *page = NULL;
> >>
> >> For this, this seems to work well:
> >>
> >> @@
> >> @@
> >>
> >> -struct page
> >> +struct slab
> >
> > Written exactly like above it works, but then it affects code in all
> > functions, and I need some exceptions.
>
> Still not full success, but I was able to make work at least some
> combinations of declaration and initial assignement, such as
>
> struct page *page = NULL;
>
> by a rule like this:
>
> @@
> expression E;
> @@
> - struct page *page = E;
> + struct slab *slab = E;
>
> But still not luck for e.g.
> struct page *page, *page2;
>
> where rules such as
>
> - struct page *page, *page2;
> + struct slab *slab, *slab2;
>
> don't work. Also no luck for this case:
>
> struct page *page, *discard_page = NULL;
>
> And thanks to the hints from Julia I was able to split up the rules so that
> I no longer have unconverted expressions at places where two changes apply
> to a single line.
>
> I'll now try to build 1.1.1 to deal with the whitespace issues.

Sorry, I got interrupted on this.

@initialize:ocaml@
@@

let ok_function p =
  not (List.mem (List.hd p).current_element ["functions";"to";"ignore"])

@@
position p : script:ocaml() { ok_function p };
@@

- struct page@p
+ struct slub

julia
