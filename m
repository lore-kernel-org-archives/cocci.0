Return-Path: <SRS0=h9ga=P2=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC540C433EF
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 12:22:26 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7B161378
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 12:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE7B161378
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2372617"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2021 13:22:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0380E006A; Sun,  7 Nov 2021 13:22:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 868B1E004C
	for <cocci@sympa.inria.fr>; Sun,  7 Nov 2021 13:22:18 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3APMPuxam6h+81qIeSqg/uks/o5gxAJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzcDzzdLC2vTb6uCYTf1etlwbY2//R8GusKGndNmQQpp+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?cZXgoLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTckQGWL/fO2BiiFIGBu780l4b/HV0i/lgXBYfQR4/ZzGhnc11ydwLsZWvQ?=
 =?us-ascii?q?AMtFqzKguUUFRdCe817Ffcdp+WZeSjXXcu7iheun2HX69BnFkIrJss1/uhtAGd?=
 =?us-ascii?q?B3eMVInYBY3irmei/yrGyYvJxncllJ9uDFIgYsXph5SrICO4vB5HFWaTDo9FCt?=
 =?us-ascii?q?ArcLOgm8e32PpVCL2M1NVKeM1sfZxENBYx4h+mywH/yb1VlRJuujfJfywDuIMZ?=
 =?us-ascii?q?ZidAB6OboR+E=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQtgHrKzHiju/Tf2FxkyqKrPwPr1zdoMgy1kn?=
 =?us-ascii?q?xilNoHtuEvBw9vrOoB1173DJYVoqNU3I+urrBEDjewK/yXcd2+B4VotKNDOW21?=
 =?us-ascii?q?dAR7sN0WKN+VHd82aXzJ856Ztd?=
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2372608"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 13:22:18 +0100
Date: Sun, 7 Nov 2021 13:22:18 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Vlastimil Babka <vbabka@suse.cz>, cocci@inria.fr
In-Reply-To: <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de>
Message-ID: <alpine.DEB.2.22.394.2111071321530.2988@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz> <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-638194770-1636287738=:2988"
Subject: Re: [cocci] mm/slab: prepare for struct patch conversion by spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 88
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111071321530.2988%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-638194770-1636287738=:2988
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 7 Nov 2021, Markus Elfring wrote:

> > Because a lot of the changes there are mechanistic, I thought it would be a
> > good idea to perform them via coccinelle semantic patch. But it's my first
> > attempt at large real usage of spatch, and it probably shows.
>
> I guess that your clarification request will trigger further collateral
> evolution.
> Thus I suggest to reconsider also another commit message from your software
> development branch accordingly.
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/commit/?h=slab-struct_slab-v1r8&id=8a685ebb3b2a10c1d781d5b3e6ad0315ce9323d6
>
> “This patch splits several declarations of multiple variables, or declarations
> that include initial assignments, to separate lines, due to my inability to
> make a coccinelle semantic patch match on those declarations.”
>
> * How do you think about to specify desirable change preparations by the means
> of
>   the semantic patch language?
>
> * Will any guidance help to find nicer solutions?

Luis already proposed a perfectly reasonable solution.

julia
--8323329-638194770-1636287738=:2988--
