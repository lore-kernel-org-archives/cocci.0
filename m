Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2D8C433FE
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Wu/DSZDrroSwbhg5X3F/FNQ5OJ5qe3UIWjp7IoT17GQ=;
  b=G4HLX9DW/C/OjYK7YwWCZ7CTew+qzo4B6a1t6SAK38riMX2csg7dTp6J
   2ulRbalmtgZWIc87i0Xso1zMj/nHQBfk4wQ8GiH9YFJ8zcaYztvcGOUsv
   9DIvAykQYQfN/CbwtOHJCaydwr8oz7xmVwalHK80Lf5W17OetI2numalT
   k=;
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
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="72818593"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 13:33:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B6D78E7389; Thu,  3 Nov 2022 13:33:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 55431E7385
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 13:33:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Wu/DSZDrroSwbhg5X3F/FNQ5OJ5qe3UIWjp7IoT17GQ=;
  b=urFNTukj9irSmOvmo3nxx6wkluz6jjE8uEsv95KgS88fUK0UBTlkd4Ni
   W7h8FtDPcm9U1mrhbQP63YLj6i2E+5SHQst8s5yhUBswOXsqHuTKLicoV
   ztkGEglMtvBslnL73BS7KeDT4dTh/w3ZBQDcMkvDAv6GYeMHBdocqxymu
   g=;
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="72818590"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:33:41 +0100
Date: Thu, 3 Nov 2022 13:33:41 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sebastiano Miano <mianosebastiano@gmail.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <CAMENy5otzNE3wfm8=PJxP_8T4t_AydhUWs_dmWGmvzrrBeQa7w@mail.gmail.com>
Message-ID: <65edcc8f-c047-92d5-aa7f-36506ffa987a@inria.fr>
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com> <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de> <CAMENy5otzNE3wfm8=PJxP_8T4t_AydhUWs_dmWGmvzrrBeQa7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-326385217-1667478821=:4182"
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 705
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/65edcc8f-c047-92d5-aa7f-36506ffa987a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-326385217-1667478821=:4182
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 3 Nov 2022, Sebastiano Miano wrote:

> Thanks Markus.
> It definitely looks cleaner now.
>
> On Wed, 2 Nov 2022 at 20:15, Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> >
> > > Any ideas on how to solve this issue?
> >
> >
> > How do you think about to use the following SmPL rule variants instead?
> >
> > @initialize:python@
> > @@
> > import os
> >
> > @searching@
> > expression path, fn;
> > @@
> >  MERGE_FUNCTION_OPENED(path, fn, ...);
> >
> > @script:python generation@
> > path << searching.path;
> > fn << searching.fn;
> > new_fn;
> > include_name;
> > @@
> > coccinelle.new_fn = cocci.make_expr(fn.strip('\"'))
> > pre, ext = os.path.splitext(path.strip('\"'))
> > coccinelle.include_name = cocci.make_ident("\n#include \"%s.h\"" % (pre))
> >
> > @replacement@
> > expression searching.path, searching.fn, generation.new_fn;
> > @@
> > -MERGE_FUNCTION_OPENED
> > +new_fn
> >  (
> > - path, fn,
> >   ...
> >  );
> >
> > @addition depends on replacement@
> > identifier generation.include_name;
> > @@
> >  #include <...>
> > +include_name
> >
> >
> > Would you like to reconsider also the implementation detail that an “identifier”
> > is used for the construction of a preprocessor directive so far?
>
> I would love to reconsider it, but I didn't find an alternate solution.
> Do you have any suggestions?

I don't think any other solution is available.  There is not much
functionality available around includes.

julia
--8323329-326385217-1667478821=:4182--
