Return-Path: <SRS0=6jWL=P3=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBD7C433F5
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 17:01:24 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569FE61506
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 17:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 569FE61506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AwgiKR6NXQs7WdwnvrR20lsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQi80T5w1DMHnWMWUWGCb66PNDDze953YNmy9EgEv5LTm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM+X9BDpC79SMljPjQFuKlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFEcK?=
 =?us-ascii?q?gir+9c0sQQ7eUMxLmZnh+AvLyxEkZ4HVsiOBiaqJ0hUR/0l1lm/h6z95GtNm3V?=
 =?us-ascii?q?gEkJIXNnv4cWl9WCUmSOIUcpuaXeSfg2SCU5wicG5f2+N1lC0o9PKUR4O13AH9?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qJqxS/J3l8otBMbuNYIb/HpnyFnxBvErR53Fa6rP7N5cm?=
 =?us-ascii?q?jw3g6hmEf/YIchfdjtraBXJZgZnNVIeCZZ4l+Ct7lHzeiNZpEmSo6Y57Gz7wwl?=
 =?us-ascii?q?40byrO93QEvSGSINOmVuKryTN+H70BA0bMvSQzDOE9jSngeqntSjgRYYWBZW38?=
 =?us-ascii?q?fllhFDVzWsWYDUcWF22rfi6lma+VtNZJgoO/SEttsAa/0isScLVXR2zpHmDpVg?=
 =?us-ascii?q?XXN84O+Ez7gCAzuzQ7hSSD24DZjpAbtU8s4kxXzNC/lSJhdLyGTt3sPufTn+d8?=
 =?us-ascii?q?6idqT+/IwARLGkIZDNCRgwAi+QPCqlbYgnnVsxkHOuxj8bpFCrtmmDMrS4khrx?=
 =?us-ascii?q?Vg9Rj6klyxnif6xrEm3QDZlRdCt3rY1+Y?=
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2618077"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2021 18:01:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7F62BE02AF; Mon,  8 Nov 2021 18:01:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A361AE004C
	for <cocci@sympa.inria.fr>; Mon,  8 Nov 2021 18:01:17 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/X9OKK8EmG9AOjR7pcFuk+DVI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZhyY7TiX4rbHIoB1/73XJYVkqKRIdcLy7WZVoBEmskaKdgrNhWItKPjOHhI?=
 =?us-ascii?q?LAFugLhrcKgQePJ8SUzINgPMlbH5SWROeAb2RHsQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398628727"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 18:01:17 +0100
Date: Mon, 8 Nov 2021 18:01:16 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Vlastimil Babka <vbabka@suse.cz>
cc: Luis Chamberlain <mcgrof@kernel.org>, cocci@inria.fr
In-Reply-To: <682ecb85-3c8e-f0c7-8f02-b56cd6e11872@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111081800070.65268@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz> <YYVZva1hfwanXdyB@bombadil.infradead.org> <70748876-5df6-080b-f1da-1f94371001db@suse.cz> <b7aea196-c9d9-6d8d-8ba0-ab2a361ba1ad@suse.cz> <alpine.DEB.2.22.394.2111081542290.2988@hadrien>
 <682ecb85-3c8e-f0c7-8f02-b56cd6e11872@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Need some help with spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 98
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111081800070.65268%40hadrien>



On Mon, 8 Nov 2021, Vlastimil Babka wrote:

> On 11/8/21 15:45, Julia Lawall wrote:
> >> I'll now try to build 1.1.1 to deal with the whitespace issues.
> >
> > Sorry, I got interrupted on this.
> >
> > @initialize:ocaml@
> > @@
> >
> > let ok_function p =
> >   not (List.mem (List.hd p).current_element ["functions";"to";"ignore"])
> >
> > @@
> > position p : script:ocaml() { ok_function p };
> > @@
> >
> > - struct page@p
> > + struct slub
> >
> > julia
>
> Thanks a lot, that did the trick!
>
> Note that this still patched also the struct page *page; field in struct
> kmem_cache_cpu definition, which is not part of any function, but as I was
> patching it anyway, it's no problem.

I'm not sure what is the current element name for a structure definition.
Maybe something not so helpful like "something else".

julia
