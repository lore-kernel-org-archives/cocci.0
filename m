Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7B9C433FE
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=AHa1pDV7iqzXvhhdJW1pm/rNSbG7c5LPfNSbXUAFTXI=;
  b=spCvF4jIAC9tcGPGJNchqtjhDRxp167h4AVwh0Hu6otlJJSz6dWfb2yW
   74fumAfzuCH53jgiSig3DR5Wk/ARDlihF8hMxIfHbkzWb/M0aIhYAo/2n
   xelDfmR3uyMm2nIaYhfznpKqQjG6CdH/w4DEuNNzFN4+SL2opyr07yodF
   Q=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,235,1665439200"; 
   d="scan'208";a="72854430"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 16:28:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F3543E738A; Thu,  3 Nov 2022 16:28:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6FB7DE7385
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 16:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AHa1pDV7iqzXvhhdJW1pm/rNSbG7c5LPfNSbXUAFTXI=;
  b=iEXWKwGrebMHeFHmLWCcxRdvezdMt6+r6A7nHa+0bHwCezT8fFEGvGBq
   0+C/mtFHCDo3l54KGlEA5fWfaH+/ZkIJamR3pOOaRTgtWcl0hnUsxzfUq
   MSQn7V6PTP/1/xCyY4v8gdo4e9MKHrV/Yn5ldptp/xr8b4wXgK21p1Qk5
   k=;
X-IronPort-AV: E=Sophos;i="5.96,235,1665439200"; 
   d="scan'208";a="36381080"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 16:28:03 +0100
Date: Thu, 3 Nov 2022 16:28:02 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Sebastiano Miano <mianosebastiano@gmail.com>
In-Reply-To: <bac05976-cacf-1a2b-a1d0-712dbad725f1@web.de>
Message-ID: <54b441e8-13e7-be9-23ee-692ccb1ac04f@inria.fr>
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com> <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de> <bac05976-cacf-1a2b-a1d0-712dbad725f1@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1757911623-1667489283=:4442"
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 711
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/54b441e8-13e7-be9-23ee-692ccb1ac04f%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1757911623-1667489283=:4442
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 3 Nov 2022, Markus Elfring wrote:

> >> Any ideas on how to solve this issue?
> > How do you think about to use the following SmPL rule variants instead?
>
> I got the impression that the usage of position variables can have desirable
> data processing effects for the safer evaluation of some SmPL rules.


It's better without position variables.  If the same path and fn are used
in multiple cases, adding the position variables will cause the python
code to be run for each call, whereas now it is only run for each unique
pair of path and fn.

julia

>
> See also previous clarification approaches:
> 2016-10-26
> Propagating values back from Python script to SmPL rule with other metavariable
> type than “identifier”
> https://github.com/coccinelle/coccinelle/issues/86#issuecomment-256453084
>
>
> Thus I tried another SmPL script variant out.
>
> @initialize:python@
> @@
> import os
>
> @searching@
> position pos;
> expression path, fn;
> @@
>  MERGE_FUNCTION_OPENED@pos(path, fn, ...);
>
> @script:python generation@
> pos << searching.pos;
> path << searching.path;
> fn << searching.fn;
> new_fn;
> include_name;
> @@
> coccinelle.new_fn = cocci.make_expr(fn.strip('\"'))
> pre, ext = os.path.splitext(path.strip('\"'))
> coccinelle.include_name = cocci.make_ident("\n#include \"%s.h\"" % (pre))
>
> @replacement@
> position searching.pos;
> expression searching.path, searching.fn, generation.new_fn;
> @@
> -MERGE_FUNCTION_OPENED@pos
> +new_fn
>  (
> - path, fn,
>   ...
>  );
>
> @addition depends on replacement@
> identifier generation.include_name;
> @@
>  #include <...>
> +include_name
>
>
> Will interests grow for remaining development concerns (also according to
> the construction of preprocessor directives)?
>
> Regards,
> Markus
>
--8323329-1757911623-1667489283=:4442--
