Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF56C4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+WWtIFVlvvW9RqBWVX7m9vlpmSzYf/O7APWy4beP06E=;
  b=s8teXuvB9LDBmSRAFM/dfNPB6k9HZoPpyQHWzBUbcJk+8452P9t0sygK
   lZC5m2gt+dvPfUEORnWS12y28MKy8IRBGDKbVtZm2MmI5VY4ll9CzBH8S
   xZHTiUHFaNKv7Bk2Wjb8lH5vpT8S8Dtlgy5/IBKFQyV08RXfQPG80EM9k
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164271335"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 18:31:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E6315E0133; Thu,  2 May 2024 18:31:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 55BFBE0035
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 18:31:37 +0200 (CEST)
IronPort-SDR: 6633bfe8_GyrGjJijz8dsJ10HyeaL35PxYLyYG+hrufXZPwe8b8AqP5j
 9PnkWG5bLINgLYjjIiRDExjwD2RxcKExeMsQ9kA==
X-IPAS-Result: =?us-ascii?q?A0EDAABhvzNmh3yBCqpaFgQBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBOwUBAQEBCwGCQ3yBCgQLSIxzX4ZKgiIDmC+FW4FAPg8BA?=
 =?us-ascii?q?wELAQE5CwQBAQMEhH8CiC4CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBASIXBw4QJ4VwDYJnEYEOZQk4AQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEYAg17AQEBAQIBEigGAQE3AQQLCxguFEg1gl4BgkEjAxGpZAGMdQEBA?=
 =?us-ascii?q?XaBNIEBggwBAQaCZtsZCYFIAYgtAYlCeicVBoFJRIQ/PoFShwaCL4USlFhBj?=
 =?us-ascii?q?CxUfRwDWSECEQFVExcLPgkWAhYDGxQEMA8JCyYDKgY2AhIMBgYGWSAWCQQjA?=
 =?us-ascii?q?wgEAxA0AyBvEQMEGgQLB3WBfIE1BBNHgTiJfQyBfYE0KYFOKYQhS2yEC4F4D?=
 =?us-ascii?q?mKDYYIiHUADC209NRQbBiIBoGGCUoFwASohNhtgk2gSnWOVAwcDhBOMDpUeB?=
 =?us-ascii?q?BYzhAWBVpFdDDmSNy6HWJBcjXSHTpMbAgoHF4FlOoFccBWDIglGAxkPV41JG?=
 =?us-ascii?q?YNhnSNCNTsCBwsBAQMJiSKBSAEB?=
IronPort-PHdr: A9a23:uch3DxHRBmRDskVCmzXn651Gf5hFhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k33RmTBNWQsqodw8Pt8IneGkU4oqy9+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS5bL9oM
 hm6sAbcusYLjYd+N6o61wfErGZPd+lKymxkIk6ekQz76sms4pBo7j5eu+gm985OUKX6e7o3Q
 LlFBzk4MG47+dPmuwDbQQSA+nUTXGMWkgFVAwfe9xH1Qo3xsirhueVj3iSRIND7Qqo1WTSm6
 KdrVQPohSIaPDM37G3blsp9h79ArRm/uxJw3ZLbYICNNPp/YKzde88aRXFcVcpVTiBNH5+wY
 5cKA+cHOulWspT9p0AWrRSgGQasGO3hyjhNhnDs3K061fkqHQXJ0QEkGt4DtmnfotfoO6cIS
 e27wqnGwyvdYv1L2jn95ofHfRIvrv6QQL19atbRxVU1Gg/Zklmds5LpMjWI3eoNqWib6O9gW
 Pqhh2A7qgF+vjivyd02iobUm4kaykrI+yJjzI0oIdO4T0h7bsC/EJdeqiqXMJF2QsElQ2Fup
 ik60aYLuYSlcycXyJQo3QLfZ+abfIiP5xLuTeCcKip3i3x5YrywnQqy8VS+xe3mUMm5yEhHo
 CRBn9TSq30A1RPd5MaER/Z840qtxDaB2h3O5u9KIU05lKXWJ4Auz7M0mJcfrUTOEC/0lUj4k
 KKbakoq9vau5u/6bLvmoZqcOJV1igH4KqkugNKwDvk4MgcUQ2iX4/iz1Lrm/UHhTrRKiec2n
 bTBsJDAO8sbvbW5DxVJ3YYk7hayCSqt3tcAnXQfMV5Ieg6Lg5L0N13SOvz0EOmzjlC2nDt22
 fzLMaXtD5TMI3TZjbvsfrRw51RCxAc9w91T/ZFZB7IHLfnuRELxsMHYDgQlMwOq2ebpFdR91
 4IAVm+XHqOUNr7Zv0WS6eI1OeaMYZcYuDbjJPgh4P7jlWI5mUQEcamy2JsXdGi4Eu17LEqHZ
 Xrsg8kBHnkQvgs+VeDmlUOOXDFJa3a3XqI84y80B568AofYWoChmqCO3CC+HpFOZ2BGDE6DE
 WvweomZWfoAdDieLtJ9njAeSLStVYss2QuzuAPkxLdrNu/U9TcZtZLn2th1/erTlRQq+DxuD
 cSd1GeNQH9vnm4TXT85wr1woUxnxVefy6R3n/tYFdlL6/NPSQg1LYTcwPBiC9DuRgLBec+ER
 Eu+TtW8HT4xVs4xw8MJY0tlB9qiiQzM0DarA7IOjLyKBJk08rrG0HTrJsZ9zWzG1Kg7gFU8T
 MtPLz7uuqkq1RXXBoeBt0yGnqKuPfAewSrM/SGHxHWHuEVwUQhqUKyDU2pJNWXMqtGsrHnDR
 L+nE7hvDU1kj4agLa1HcZeh2U9EQ/HuI/zEbm6xknv2DhGNkODfJLH2cnkQiX2OQHMPlBoeq
 DPbbGDWZw+kqmPaVnl1EE73Jlnr+q94oW+6SUk9y0eLaVdg3vy74E1dnuSSHtUU2L9MoyI9s
 3NsBl/oxdDRDdebjxBscKVVfZU251IUnXnBuVlFN4e7Z7tnmkZYdg12u0300BAiEIdHl8Uxh
 GknwAp7NeST11YSPyiA08XWPbvaYnL34Ajpa6PS3QTG182K/64U9Pkig0j4+RqsClJn/3hj0
 sdYyWrZv8+WSg8TVJ/6W10rsRN9otk2ewEb4IXZnT1pOKiw6HrZ3s4xQfEiwVCmdsteN6WNE
 EnzFdcbDo6gMr5inV/hdR8CMO1Ikcx8d8q7a/uL3rKqN+d8jXqni2pA+oV0zkOL8WJ1VOfJ2
 58Px/zQ0BGAUn/wi1Kos8a/no4hB3laBGi4zyX/LJRcaq17YcAADmLva8y7y9NihoL8DmZC/
 Q3rDFcH1cm1PBuKOgWihUsJjQJO+y3hwHHknFkW23kzo6GS3TLD2bHnfRsDYCtQQXV6yE3rK
 s6yhswbW06ha04okgGk7AD03fs+xuw3Im/NTENPZyWzIXtlV/76rLiFZcNUwIklvSVeTKK3Z
 lXQGduf61MKljjuGWdT3mVxbTOtvJjitwZ3hGKUMDB4q3+TKolggBzY4tLbX/tY2DELETJ5h
 TfgDV+5J9C1/N+Qmv8vq8iGXnm6Ht1WeCjvl8absTejoHdtClu5luyyndvuFU471zX63p9kT
 3eAoBH5a4jtn6O0VIAvNlNqA1nx8OJgF41+m5d2j5YVkXQXnZSa+3MbnHy7aIoDn/umKiNXF
 HhSmYKd6ROtwEB5K3OV24/1MxfVitBsYdW3eCJe2y4w6dxLFLbB6bVFmSVvpV/r5QnVYPV7g
 nIc0a53tyZc2rlP4VB8iHzHXuN3fwEQJyHnmhWW4srrqaxWYDzqar2szA9kmtvnCrieowZaU
 XK/e5E4HCY24N8sVTCEmHD19Izgf8HdKNwJsRjB2Q3CiO5YM7orm/YKjDYhMmX49y5AqaZzn
 Vl10Je2sZLSYX9v+6S0GTZCOzH1bt9V8Tbox/UWjoOd2IahGY9kEzMAUc7zTP6mJzkVsOzuK
 weEFDBvzxXTUaqaBwKU711q6m7eC53+fW/CP2EXlJ8xDAnYPkFUhxoYGSk3joJsXB7/39TvK
 SIbrngQ/gKq80UWjLg0aF+mDD+Z/EDyM381UMTNdUQJqFEToR+TaYvHsapyB30Kp8Px6lbRd
 yrDIVwPVD5sOATMBki/bODxvZ+Zq67BXLr4d7yUPf2PsbAMDqjQg8v3lNI8rnDUcZ/Tdnh6U
 69ihRIFBCg/Qp+C3W1IEXBy9WqFbtbH9k7joWsu/5z5qLKzH1uxrYqXV+kLYYgppkDw0fvFZ
 rXX33wxKC4EhMpdnzmSleBZhgZCzXg3LVzPWfwBrXKfFfOK3PUKV1hBM3M1bZITp6MkglsUa
 JSd0I6pkOch1LhtTA0dHV35xpPwNJxMeSfkbgOBXAHSZNHkbXXK252lOPLsD+cJyr0S71rq4
 H6aCxOxZ2XT0WO1Clb/aacUy3vDdB1G5NPkI0YrUjelFY66LEX8aocS73V+wKVo1CqbZChFa
 2I6KhkV6OXXt3oQg/N0H3FN4yh+Neff3TyU4+nRNtAdtv4jRy1wk6gyDG0S7bxT4WkEQfV0n
 HGXtdtyuxS8leLJzDN7UR1IozINhYSRvEwkN7+Lvp9HEW3J+h4A9wDyQ1wDusdlB9vzuqtR1
 smHlaT9Ly1H+s7V+s1UDtbdKcaOOn4seRTzHzucAAwARD+tfWbR4i4V2OmV7WGQp4Mmp4LEh
 YFLUbpHTBk5G/cbFEl/DZlbessxWzIhnLWSl9JO7n277VHQSMhcopHbR6eSDPHoe1P7xfFPY
 xoFx6+9LJxGb9KjnRU6LAAgzcKTQRaDOLIF6jdsZQI1vkhXpX13T2lpnlngdhvo+ngYU/i9g
 h8xjAJ6J+Ur7jblpVktdT+o7GM9llc8ndL9jHWfajn0ee2qX4ZQBjHcrUU9MprnBQ1yaEfh+
 C4sfCeBXL9Xg7Z6ICpzjxTAvJJUBfNGZbBfJQQV2enSa/gs0EpRsDTinBUbo+7EDJZpnRA2N
 5WrqjgTvmArJM5wLqvWKq1Ty1FWja/bpS6k2Nc6xwoGLloM+mefEMbtkFYFOrkvO2yj+ek+s
 WRqehNeYy0XUuYy5/5n8kIjNv6Rinu6j/hGK0W8POWEM+WSvG2SzaZgrXsq208InlUD9r9zg
 55LTg==
IronPort-Data: A9a23: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
 vdALpT+6Im4xJht5YCr
IronPort-HdrOrdr: A9a23:U60be6ju0rsUu/pyHSmS+AbElHBQXvkji2hC6mlwRA09TyVXrb
 HMoB0+726JtN9xYgBcpTnkAsK9qBznm6KdjbNxAV7mZniBhILKFvAE0WKB+UyEJ8SWzIc0v8
 sOT0E9MqyVMbEQt7eZ3ODXKbYdKZW8gdmVbUq09RpQpYYAUdAb0++sYTzraXGfKGR9dOIEKK
 Y=
X-Talos-CUID: =?us-ascii?q?9a23=3AWfmmkWgtXtEAbOzIpU7lK0YtLDJuLnPB6lvtKGW?=
 =?us-ascii?q?BVzw3bqaoaHTN2Y95up87?=
X-Talos-MUID: 9a23:eAlMogjlNpPTNhoviFj6+8MpMcdi+/qFMGU2vq5cm+C/JzJzODa7k2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164271328"
X-MGA-submission: =?us-ascii?q?MDFblw3xNf88SSm+zpvspPla4Ntv4cmiE6zjXH?=
 =?us-ascii?q?06fGLTcMiWU6o/gOcHjc5wd9L0Plo1deiq5TLBnwA2xhgzd1eKsvQZGC?=
 =?us-ascii?q?uTudhbz3iOxkjgXTQGn6eLmwpxSHKi6m3rzWj0MdDYLo5ygVC/22Ly6x?=
 =?us-ascii?q?KdC4qCY5vh5dnJpgL+oxNYVA=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 18:31:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714667495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+WWtIFVlvvW9RqBWVX7m9vlpmSzYf/O7APWy4beP06E=;
	b=CW2V5XBBF8rDkLQm91hApuOibrPIjTas8Qny9otUtFe01+sWe0iQnc9+9X/E10ydyr7VkP
	ydAwlwryaKmx93S9b5H8B7P3ntJ7uOj1NiERTQ4bF0du8i4Nue9MB9H0blwWNRelcnu1EZ
	VyzsLlefRRrD/GJu2WYTKvWi19vkU3Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-0psBbRuaOMW5ubtySWLEKg-1; Thu, 02 May 2024 12:31:33 -0400
X-MC-Unique: 0psBbRuaOMW5ubtySWLEKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C20CF1049C93;
	Thu,  2 May 2024 16:31:31 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9294240B4979;
	Thu,  2 May 2024 16:31:31 +0000 (UTC)
Date: Thu, 2 May 2024 17:31:31 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240502163131.GC30267@redhat.com>
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
MIME-Version: 1.0
In-Reply-To: <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1681
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240502163131.GC30267%40redhat.com>

On Thu, May 02, 2024 at 11:44:00AM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 2 May 2024, Richard W.M. Jones wrote:
> 
> > OCAMLOPT  parsing_cocci/parser_cocci_menhir.ml
> >
> > This single file takes a very long time to compile, about 34 minutes
> > on my 2 year old Intel laptop.  It's quite large too ...
> >
> > 139201 ./coccinelle-1.2/parsing_cocci/parser_cocci_menhir.ml
> >
> > I've observed in the past that the OCaml compiler doesn't handle
> > single large files well.  It seems to have some O(n^k) behaviour.
> >
> > Is this a known issue?
> 
> I agree that it's slow, but I haven't seen it take 34 minutes.

I just tried it on a much faster AMD desktop machine, but essentially
the same OCaml and menhir, and it still takes a very long time to
compile this one file: 17:35 minutes

I tried it on a (different) machine with OCaml 4.11.1 and that was
considerably faster, taking under a minute.

Rich.

> The point is that it is a parser, so the code is generated.  I use OCaml
> 4.13.1 or 5.0, not 5.1.1.  I have the same version of menhir as the one
> you mention.
> 
> I can try to make it smaller.
> 
> julia
> 
> >
> > Rich.
> >
> > coccinelle 1.2 from tarball
> > ocaml-5.1.1-4.fc40.x86_64
> > ocaml-menhir-20231231-3.fc40.x86_64
> >
> > --
> > Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> > Read my programming and virtualization blog: http://rwmj.wordpress.com
> > virt-top is 'top' for virtual machines.  Tiny program with many
> > powerful monitoring features, net stats, disk stats, logging, etc.
> > http://people.redhat.com/~rjones/virt-top
> >
> >

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

