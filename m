Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29152C36000
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BCmEMv+R0H14bObC5uGwl7mdY1dN9Gu9q+dUJ8x3J2Q=;
  b=vgp6ceUZjJvVwYLf547oVsJplg6LGrH/aTziwk5xyDUbLJMJYvE2xdkp
   5jhkVpSirodcmx89YzkGcIqWcpR/t3//NLbz2R2KfT+4NE8MiGc3rNLPB
   jnhQeqpp6UMJeQ+7HStiBc9HkGyfDY52i7b+6igqOcExuOG7ErpwHiUVX
   Y=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213652459"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 10:29:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1BD3AE0D33; Wed, 19 Mar 2025 10:29:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B6D2BE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 17:31:05 +0100 (CET)
IronPort-SDR: 67d99fc9_IO3yunuJ6zrtCzCRIhQSL2cSglbKlgWtGPa58sitrKtAVqY
 8/ndnfm272jwB1XJDNbCXIQuaKZA/L61Crq1g3A==
X-IPAS-Result: =?us-ascii?q?A0EDAABxntlnhdlUsotaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUECAQEBAQELAYJDfVozBAtIhFaIfIZUgiEDkkyLS?=
 =?us-ascii?q?IF+DwEDAQ07CQQBAQMBA4UAAosgAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQFASYV7DYJiAYETEXQwAgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CDX4BAQEDIwQLAQ0BATcBDwsYAgImAgJWBhODAgGCZAMRrh1/M4EBggwBA?=
 =?us-ascii?q?QbcIIFlAwaBGi4BhWyCYwGGMIM5eicbgg2BFYMqPogeOoIvgjNFgSSDQYhZe?=
 =?us-ascii?q?IhWl3FSexwDWSwBSwoTFwsHBTkoSEMDgQ8jgSIFNDQOOCmBY2lJOgINAjWCC?=
 =?us-ascii?q?BNdH4IogheCN4Q+gzGBEIFlg2uCEYFdAwMiAYIwb3UcgxOBKz6EZC1QgVMdQ?=
 =?us-ascii?q?AMLbT03FBsGo00BOoNaaVkjExwQgV4fAXmTJJFyi3SVEoQlgWOKNZV9E4E4l?=
 =?us-ascii?q?XuTES6YUIwMgXmbLoFuATKBXDMaCCgIgyITPAMZD44hGYh0sQAjNQIBAQE3A?=
 =?us-ascii?q?gcBCgEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
 cXVn6+1KzpY9d/Qu8wGCJqMQP8=
IronPort-Data: A9a23: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
 Z87q6ZhLYxbNrz/dJbFY+4UvJI=
IronPort-HdrOrdr: A9a23:4RfMaa5YdY2FA8ZvewPXwRSBI+orL9Y04lQ7vn2ZFiYlEPBwxv
 re/8jziyWVtN9IYgBYpTnyAtj5fZq8z+8G3WFyVY3JYOCCggaVxe5ZnMvfKlHbamjDHgA079
 Y8T0BRYOeAVGSTFa3BkVOF+zxJ+qjdzEnQv5aH854Pd3AeV0gD1XY5Nu/BKDwxeOAuP/NQf/
 byiKs3wkvFRZ1wVLX5OpArZZmAmzShruOjXfdyPW9A1OD4t0LO1FeVKWne4v98Owk/jYvLrg
 P+4kPEz5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwiy6zDb4RL4GqjXQQmqWC+VwqmN
 7Dr1MLJMJo8U7ceWmzvF/ExxTg6jAz8HXvoGXo9kcL4PaJMg7SOfAxzb6xQSGpoHbIiesMmZ
 6jkVjp/aa/Rimw5xgVr+K4LS2CPHDE7AttrccDy3NYSocQc7lXsMgW+15UCo4JGGbg5JkgC/
 QGNrCu2B96SyLqU5nihBge/DWBZAVMIv7deDl/hiW86UkooJjPpXFoufAiog==
X-Talos-CUID: 9a23:WuWs6W1H1dNfsOR98wMTNrxfQOYsI2fw4FLsGV6AMDdAR6WPQGK30fYx
X-Talos-MUID: 9a23:+b46HwVWsoJQjM7q/G7rpQ5nP/VN356nS0kAtog+spHVFzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="111936092"
X-MGA-submission: =?us-ascii?q?MDGZUPlgUoWLD4UdeVxZ4rQdEnJn1vv4ah8SUd?=
 =?us-ascii?q?NtrqsHm5ySThwcl2AApOtAAEnDxnfCQYHgLhwlWzKMS/Dd9be+HcvTZX?=
 =?us-ascii?q?hFrIx2h1d+IkwpJd+RNhts3Chb1PJZKB7rJ19tVC5JdeJPCj6pHBhYHT?=
 =?us-ascii?q?zU5INPLXeky6YjDZRE85e30Q=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 17:31:05 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2C76D5C549A;
	Tue, 18 Mar 2025 16:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3453C4CEDD;
	Tue, 18 Mar 2025 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742315461;
	bh=a+c8za/m6bgDUrAWb42UYqYgWc2kWxct8/3Z8/LCuOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pdzcz0Mh27npR5K6QZwSfIHXO20rEUOWPWynObeVEPNz/h3cQ2ezxZuFoFi/RUSuL
	 OpHcoNFc2/1SL0P42zAMvfb11uXR7J+LlK/n9L9Dtop0NnPefEOkeD1o6jfIBVjeHH
	 SrmzBz0bQMu9UmBLBtRzI8wQfr4SoFh41XdOtDYhtX7AIpgITiRKL4CFeo485yVB2r
	 AJw7YqqQGqbqT9wHryBwwD+wZUXxZ9ISPL6EUrLT4w383VQHQfaXHWt+wbDrz987YR
	 4LpeNahuXo3x1SU3B9Y5adYLh/2h9k05unYgp6QQSehlw1xklcc+uiZFUUiskBoX7W
	 FcO4ywOxknL+Q==
Date: Tue, 18 Mar 2025 09:30:58 -0700
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <202503180924.2135CF8FD@keescook>
References: <202503180837.790801EF6@keescook>
 <14B17EC1-3D43-4D47-8A0C-9DFFA06D23E8@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14B17EC1-3D43-4D47-8A0C-9DFFA06D23E8@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2639
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/202503180924.2135CF8FD%40keescook>

On Tue, Mar 18, 2025 at 04:43:30PM +0100, Julia Lawall wrote:
> > On 18 Mar 2025, at 16:39, Kees Cook <kees@kernel.org> wrote:
> > 
> > ﻿On Tue, Mar 18, 2025 at 12:13:15AM +0100, Julia Lawall wrote:
> >> It makes the call just disappear.
> > 
> > Right, unfortunately this breaks replacement, because the __free
> > vanishes completely even in the replacement:
> > 
> > -       struct platform_profile_handler *pprof __free(kfree) = kzalloc(
> > -               sizeof(*pprof), GFP_KERNEL);
> > +       struct platform_profile_handler *pprof = kzalloc_obj(*pprof, GFP_KERNEL);
> > 
> > How do we get __free to be treated like any other variable attribute?
> > 
> 
> It would certainly be good to suppôt it better. But I have the impression that you are removing and recreating the whole part to the left of the equal? It could work better to remove and recreate only the kzalloc call.

Oh! Yes, thank you. That works. :)

Okay, next question. Based on your advise on constructing matches for
arbitrarily long dereferences[1], I am trying to apply the same logic,
but to also tie identifiers to types:

@direct depends on !(file in "tools") && !(file in "samples")@
type TYPE;
TYPE *P;
TYPE *MEMBER;
TYPE INST;
expression COMP;
identifier ALLOC =~ "^kv?[mz]alloc";
fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
@@

        \(\(P\|COMP.MEMBER\|COMP->MEMBER\) \& VAR\)
-       = ALLOC((\(sizeof(*VAR)\|sizeof(TYPE)\|sizeof(INST)\)), GFP);
+       = ALLOC_OBJ(*VAR, GFP);

This won't parse:

minus: parse error: 
  File "scripts/coccinelle/api/kmalloc_objs.cocci", line 58, column 13, charpos = 1303
  around = 'MEMBER',
  whole content =       \(\(P\|COMP.MEMBER\|COMP->MEMBER\) \& VAR\)


If I change MEMBER to:

identifier MEMBER;

it parses, but then I lose the association of "MEMBER" being a "TYPE"
pointer. Is there some why to make that work?

Thanks!

-Kees

[1] https://lore.kernel.org/cocci/alpine.DEB.2.22.394.2006182155260.2367@hadrien/

-- 
Kees Cook
