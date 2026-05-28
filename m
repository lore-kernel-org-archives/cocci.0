Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98137CD5BD5
	for <cocci@archiver.kernel.org>; Thu, 28 May 2026 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xdQSLjsIHLonVOJcCvIA0fU3SbPqRxmdpV2coX0onEM=;
  b=PEuVTKJmJhdF8CrG9z8TlOBfQDQXDK7G3Bu7qoyH1bZDdPeHxiGdNT7T
   3UZhp+XJHKGsgJ0pQ8gAGghEyArMyaC81Q/T6kXy8f+4VzM2todeGpfI/
   NDg8M41gKADHgx4g/UybGM1G7G5okAAKYpGINN+727zOO99jvNcz7hb44
   A=;
X-CSE-ConnectionGUID: CZXf7YjrTAquKMaduxbPbw==
X-CSE-MsgGUID: Qrl9BjMCSfeUA8ifALZZsw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="278757703"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 May 2026 18:48:19 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4BE71827EC; Thu, 28 May 2026 18:48:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id ED20181FFD
	for <cocci@sympa.inria.fr>; Thu, 28 May 2026 18:48:16 +0200 (CEST)
X-CSE-ConnectionGUID: Ssxf9oQ6SyG77csxNNoj0Q==
X-CSE-MsgGUID: upNvX/b8SMyxbuBIMMQZNA==
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="278757689"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 18:48:17 +0200
Date: Thu, 28 May 2026 18:48:16 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <83609e44-f30c-428d-80b2-36ac971edc77@web.de>
Message-ID: <31c86a-f2b3-1bbd-6af9-a6666181a8ac@inria.fr>
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr> <44dd7481-648f-4ae2-ad4c-10eb0609fefb@web.de> <bbe18a76-0100-40ed-b6e7-f053931f51eb@irisa.fr> <ad06211-6441-9568-e643-c39df9bf8494@inria.fr> <186417e3-b2d4-4f1c-9790-8fd1b836e946@irisa.fr>
 <4221c671-682-68de-9a94-1634364b6685@inria.fr> <55aadd6c-42a5-4403-8978-87fb579b0df6@web.de> <e919c230-4996-43af-9a2c-ce025399d35e@irisa.fr> <041a14c-d1ee-7181-a617-82b4b294b6fa@inria.fr> <f3b5783f-34cd-430d-be81-a23ff30f4a86@irisa.fr>
 <5a7e76-418c-6b3c-41a8-6156589441e@inria.fr> <43e1b679-ed16-4fd0-8a73-7b5159bff321@irisa.fr> <7f3572e6-61b2-ca57-5dfd-8aa44256f7bd@inria.fr> <354e39ba-82c0-43d0-b894-f90b4e673d13@web.de> <a96a73ea-acaa-b99d-dfb0-476d7b92b6b@inria.fr>
 <f988be3a-e3c7-4a79-9c7f-148359ab6fdd@web.de> <25789c6d-6f2a-9751-cc20-b2391235b572@inria.fr> <5abbbb41-12a2-4888-83dd-a17b4c6760be@web.de> <9b6163db-79e-87c0-e6c4-36f0ef187f42@inria.fr> <83609e44-f30c-428d-80b2-36ac971edc77@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1391246794-1779986896=:10822"
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3550
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/N8rER7tZzm8y4QJ_JzOYdg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1391246794-1779986896=:10822
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 28 May 2026, Markus Elfring wrote:

> >>>                The question is whether it makes the change that is wanted?
> >>
> >> Unfortunately, not with this test case.
> >
> > And with the semantic patch that you sent previously before deciding to
> > "optimize" it?
> Please compare the involved SmPL code in more detail once more.
>
>
> A)
> @simple_display@
> expression E1, E2;
> identifier F, X;
> initialiser I;
> type T;
> @@
> *T F = I;
>  ...
> *memcmp(&F.X, E1, E2)
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch example_by_Pierrick_Philippe-20260527.c suggestion7_for_Pierrick_Philippe-20260528.cocci
> …
> diff =
> …
>
>
> B)
> @adjusted_display@
> expression E1, E2;
> identifier F, X;
> initialiser I;
> type T;
> @@
> *T F = I;
>  ...
> *memcmp(
> (       &F.X, E1
> |       E1, &F.X
> )       , E2
>        )
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch example_by_Pierrick_Philippe-20260527.c suggestion6_for_Pierrick_Philippe-20260528.cocci
> …
> [no diff output]
>
>
> Why does the application of such an SmPL disjunction seem to prevent
> an expected difference display anyhow?

The disjunction does not mean what you think it means.  The C language
contains a comma expression, alloowing you to put two expressions together
with a comma in a place that one expression is expected.  That is how your
second semantic patch is being parsed.  Memcmp is considered to be a
two-argument expression where the first argument is a comma expression.
That will not match any real call to memcmp, which is a three argument
function.

To reiterate, for expressions, a dijunction takes only one expression at a
time.  You can't randomly put a disjunction around some fragment of an
argument list.

julia
--8323329-1391246794-1779986896=:10822--
