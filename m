Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A701C43217
	for <cocci@archiver.kernel.org>; Fri,  4 Nov 2022 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=v5j7tIy4e4g0S2V0BpcT6WpXKtBDPimkzuxsagCxymI=;
  b=gWAo/GCbyJbqgUmrviNPudkpz+jZPZIcGNhLfZq5DOkAPKd035qy4PL8
   j7MnkkbpOipejvG4J37JwVx+dseOzwrp+3YJCCcoitj8ScpvBYhbRPEVa
   6Px4Z9DxwMf4QhiySYEENJLT+N/fuPEwqEN5KGUS/9SvlrtdjLXeUtbAR
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
X-IronPort-AV: E=Sophos;i="5.96,137,1665439200"; 
   d="scan'208";a="75034699"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2022 10:31:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3EA88E019F; Fri,  4 Nov 2022 10:31:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4BF6FE0157
	for <cocci@sympa.inria.fr>; Fri,  4 Nov 2022 10:31:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v5j7tIy4e4g0S2V0BpcT6WpXKtBDPimkzuxsagCxymI=;
  b=o65D2xs2yeAuttDiuVYyocmO938p3secxpPE2CNNtqmH9ghZYT7oG5V2
   HdXXXp6yZFmKhpbmfHVvI9OqsmKu5cY7dNX55RaelL6b88kRdXu7668bk
   UThVk7ln7VsjUWUYf+2Dzqb0ZjiJYUA8Q30m5L/HsQ44CbxkFCCaf5TQA
   4=;
X-IronPort-AV: E=Sophos;i="5.96,137,1665439200"; 
   d="scan'208";a="37866187"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:31:01 +0100
Date: Fri, 4 Nov 2022 10:31:00 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Sebastiano Miano <mianosebastiano@gmail.com>, cocci@inria.fr
In-Reply-To: <3a2a50ba-8c30-43c5-354c-7b194eea8df0@web.de>
Message-ID: <1baafdcd-4e98-af8e-4697-bf37c43c6135@inria.fr>
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com> <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de> <CAMENy5otzNE3wfm8=PJxP_8T4t_AydhUWs_dmWGmvzrrBeQa7w@mail.gmail.com> <3a2a50ba-8c30-43c5-354c-7b194eea8df0@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-41341025-1667554260=:3891"
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 715
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/1baafdcd-4e98-af8e-4697-bf37c43c6135%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-41341025-1667554260=:3891
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 4 Nov 2022, Markus Elfring wrote:

> >> @searching@
> >> expression path, fn;
> >> @@
> >>  MERGE_FUNCTION_OPENED(path, fn, ...);
>
> Do you find the metavariable type “constant char[]” more appropriate here?

This is a reasonable suggestion.  But if the rule works as is, then it's
already fine.

julia

>
>
>
> >> @script:python generation@
> >> path << searching.path;
> >> fn << searching.fn;
> >> new_fn;
> >> include_name;
> >> @@
> >> coccinelle.new_fn = cocci.make_expr(fn.strip('\"'))
>
>
> Are ordinary function names passed by string literals instead of detailed expressions?
> How do you think about to use the method “make_ident” here?
>
> Regards,
> Markus
>
>
--8323329-41341025-1667554260=:3891--
