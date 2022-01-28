Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BF9C433F5
	for <cocci@archiver.kernel.org>; Fri, 28 Jan 2022 09:23:59 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,323,1635199200"; 
   d="scan'208";a="18411871"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2022 10:23:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C62C8E028F; Fri, 28 Jan 2022 10:23:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2870CE00CE
	for <cocci@sympa.inria.fr>; Fri, 28 Jan 2022 10:23:52 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.88,323,1635199200"; 
   d="scan'208";a="18411848"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:23:52 +0100
Date: Fri, 28 Jan 2022 10:23:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <d8f5fef-dda4-124b-3dc-8847bd4a2be@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2201281022270.9718@hadrien>
References: <d6cf70b7-84b2-5078-f9f7-81ca8acad349@ewheeler.net> <alpine.DEB.2.22.394.2201270709540.3189@hadrien> <d8f5fef-dda4-124b-3dc-8847bd4a2be@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How do you match complex double's in Coccinelle?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 119
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-01/alpine.DEB.2.22.394.2201281022270.9718%40hadrien>

> > Do you expect a "double complex" metavariable to match a complex double
> > variable?
>
> Actually I've never called something a "double complex" as shown in the
> spatch code.  I've only ever seen it used as "complex double", but it
> seems that GCC will compile either---so you would want to support both and
> equate the datatype as being the same.

This page only indicates complex being after float or double:

https://www.gnu.org/software/libc/manual/html_node/Complex-Numbers.html

julia
