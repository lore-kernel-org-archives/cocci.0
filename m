Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1567C433EF
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:27:11 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9710A61058
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9710A61058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AX8qcHq5La9USwXjhOto6RgxRtCnGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1TRWxzcfDWuDPv+CNGX2LY1/boSx9ExSucODyYViSVA5pCpnJ55og?=
 =?us-ascii?q?ZqcVI7Bdi8cHAvLc5adFBo/hykmh2ipwPkcFhcwnT/wdOi+xZVA/fvQHOOlUba?=
 =?us-ascii?q?ZYnsZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2Ng1aYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57gY0gSS/jTOxKPgzxYQcBOgDAb/Hx0g/19baRGLx4J011lnPgooDlJnZe3Q?=
 =?us-ascii?q?gwoe6rTnukHexheCSB3e6NckFPCCSLl7JfIlR2un3zEhq8G4FsNFYYf8e12KWh?=
 =?us-ascii?q?U/vwZNj0XKBOOneS7xPS8UOYErs4iN9L6Mo03tXRpzDWfBvEjKbjIRKjM6Nlw0?=
 =?us-ascii?q?zI5h8QIFvHbD+IVYDwpblLfYhlLO14SE7oxme6pgj/0dDgwgF6cu6s7+G/VwAJ?=
 =?us-ascii?q?+1JDiNdPUfpqBQsA9tkqV4HnB4nbwRBodLtGZ1TuD2n2pj+7L2yj8Xeo6H6al8?=
 =?us-ascii?q?vp7qFKUwWMXBVsdUl7TifO0jEOyWtFDA0wZ+ywj67I1/0+wJvH2Wxq/u1aGvhU?=
 =?us-ascii?q?YXN1LVeY97WmlxqPS4gudQGwJXDVIbtsOsM4wTCYtkFiTkLvBDjx1saaJTmqds?=
 =?us-ascii?q?L2ToDO3JiERIWIYTSsFSwEE/5/op4Rbs/5lZr6PC4atlNr5XDXx2CyHtzVn1/M?=
 =?us-ascii?q?Si9QK3uO15zj6b/uXjsChZmYICs//BApJNj9EWbM=3D?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2253328"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 22:27:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06CEEE02AF; Fri,  5 Nov 2021 22:27:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 93B5AE004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 22:27:05 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A//9W76N/6OomT8BcTsajsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfU7SKelfqyV9sjzkCWUtN9zYgBEpTnjAsm9qBrnnPZICMsqTNSftWLd1l?=
 =?us-ascii?q?dAQrsP0WKv+UyDJwTOst8Y76tmfqRkYeecMXFxh6/BjzWFLw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398384329"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 22:27:04 +0100
Date: Fri, 5 Nov 2021 22:27:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Vlastimil Babka <vbabka@suse.cz>
cc: cocci@inria.fr
In-Reply-To: <b7d146ac-c493-db4a-a326-58bb37392634@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111052226350.3000@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz> <alpine.DEB.2.22.394.2111052212190.3000@hadrien> <b7d146ac-c493-db4a-a326-58bb37392634@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Need some help with spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 79
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111052226350.3000%40hadrien>



On Fri, 5 Nov 2021, Vlastimil Babka wrote:

> On 11/5/21 22:13, Julia Lawall wrote:
> >> for example the cocci patch is supposed to change all "page" to "slab", but
> >> some lines are patched like this:
> >>
> >> -       __free_slab(page->slab_cache, page);
> >> +       __free_slab(page->slab_cache, slab);
> >
> > I assume that here you are using the semantic patch in 184d9494c1a4.  I
>
> Yes, that's the slub.cocci one from that commit.
>
> > get that both occurrences of page are changed.  What version of Coccinelle
> > do you have?
>
> It's 1.1.0 in openSUSE Tumbleweed, so it should be the latest?
>
> But that reminds me, yesterday I adjusted just that rule in the semantic
> patch a bit and suddenly it converted almost everything. Today I re-ran
> spatch for some rebasing reason and it again needed the fixup. I assumed
> there was some git snafu on my part and the fixup was already applied.
> But if it works differently for you, I'm not sure now. Is it possible
> for the result to be non-deterministic? E.g. some internal state of
> coccinelle is based on, say, hash table and in some cases the
> non-deterministic order matters?

I haven't seen that before.

>
> And just to be sure, does .config matter for coccinelle (through effects
> on #ifdefs etc)? I assume it doesn't, if I don't use that switch to
> perform preprocessing?

No, the configuration doesn't matter.

julia
