Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4D1C3DA5D
	for <cocci@archiver.kernel.org>; Fri, 19 Jul 2024 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zjgyOFbPga0V7jDcR6MyesXMmzdclzVw5qSdn3m+z54=;
  b=Jdyw6i4oePQwcEDniBErjYaDXARQdqjeLJPHWnj52jF0KHSovXySQEkj
   qZjR45RZF/de2UPfd5JtQQlENQIG5tVxBrg3x91KSL7t/BduNy9zgkfwt
   y53nbWk+LjSW/WTsqAwI29bNQDPxZ6ko3+mKfJ2EiTsz7e7yUJ8bYSJjN
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.09,220,1716242400"; 
   d="scan'208";a="176187732"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jul 2024 12:31:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 88310E0CCF; Fri, 19 Jul 2024 12:31:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ADEE5E0131
	for <cocci@sympa.inria.fr>; Fri, 19 Jul 2024 12:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zjgyOFbPga0V7jDcR6MyesXMmzdclzVw5qSdn3m+z54=;
  b=qckx3gevZOOkWO6RabOiENsk+tfuIqNewD6DemixLpeGEp5DZK8UxJEJ
   CBjYHiTPRCTXmL3h250YPfyWKl+iGX1xokKwTVSWkv/REPeVOXF9ICtts
   rK2fhOWuCjHMO5i1NRThFPIRX0aX17gy1raBvdpXGV+WXKDwjGjuhaGks
   g=;
X-IronPort-AV: E=Sophos;i="6.09,220,1716242400"; 
   d="scan'208";a="92533878"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 12:31:20 +0200
Date: Fri, 19 Jul 2024 12:31:19 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <76a0d20b-7328-4e5d-a8b8-c687bb11773e@web.de>
Message-ID: <2341dcad-104d-48b8-a2eb-249f16defd7a@inria.fr>
References: <76a0d20b-7328-4e5d-a8b8-c687bb11773e@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-361343214-1721385079=:3368"
Subject: Re: [cocci] How to fix parse errors for two SmPL scripts?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1811
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/2341dcad-104d-48b8-a2eb-249f16defd7a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-361343214-1721385079=:3368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 19 Jul 2024, Markus Elfring wrote:

> Hello,
>
> I stumbled on undesirable behaviour once more also with the software
> combination “Coccinelle 1.2-00021-gac9af0e8”.
>
> A)
>
> @replacement@
> constant char[] format1, format2;
> expression check, input, target;
> expression list el;
> identifier x;
> @@
> -if (check)
> -   target += x(input, format1, el);
> -else
> -   target += x(input, format2, el);
> +target += x(input, (check) ? format1 : format2, el);
>
>
> Questionable test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci use_ternary_operator3.cocci
> …
> minus: parse error:
>   File "use_ternary_operator3.cocci", line 8, column 14, charpos = 144
>   around = 'x',
>   whole content = -   target += x(input, format1, el);
>
>
> B)
>
> @replacement2@
> expression check, context, target;
> expression list inputs;
> format list fl1, fl2;
> identifier action;
> @@
> -if (check)
> -   target += action(context, "%@fl1@", inputs);
> -else
> -   target += action(context, "%@fl2@", inputs);
> +target += action(context, (check) ? "%@fl1@" : "%@fl2@", inputs);
>
>
> Another questionable test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci use_ternary_operator4.cocci
> …
> minus: parse error:
>   File "use_ternary_operator4.cocci", line 8, column 14, charpos = 144
>   around = 'action',
>   whole content = -   target += action(context, "%@fl1@", inputs);

It's not the ideal solution, but in the meantime, both work fine if x and
action are declared as expression rather than identifier.

julia
--8323329-361343214-1721385079=:3368--
