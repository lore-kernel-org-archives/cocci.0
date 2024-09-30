Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54645CE8362
	for <cocci@archiver.kernel.org>; Mon, 30 Sep 2024 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=oRVvNVjNlpil2gpAjIz1Jc65Tpy09k9CLyJrC4IzccQ=;
  b=k4TpXK1iBKVjYMUUVLSkRMciFVz/lVZaEMfE1irteLbnAWwgRTUI/cMS
   dkRr0qFu4i9vjNiHRalgqqFNGzyDHPvb7k7zopNYU9nO5sSfe9J2gTrln
   5TxMZ3rNFQXtoIqVXJypHN7XdJ9tTg+gQV4MBum71MqFKoV+VT1AhxoIB
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="186040891"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2024 18:19:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CE655E0CD0; Mon, 30 Sep 2024 18:19:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 88BC7E0035
	for <cocci@sympa.inria.fr>; Mon, 30 Sep 2024 18:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=oRVvNVjNlpil2gpAjIz1Jc65Tpy09k9CLyJrC4IzccQ=;
  b=Kyg6SqDE3ifClhTYQvWjh8xNtJShBkPu9xN92aGWNb27rzUgeoVi2xK7
   K0PrpG/XFN2pX4jYEageumlhXz8SK+jhpKZsAVOAEANQPpqqwCfBYQacs
   RHsupBaaUhIE4ajjkwNOtnFF/EqTekZVGhjrSoTXRdCizYnmEnluOiPS4
   A=;
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="97808153"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 18:19:23 +0200
Date: Mon, 30 Sep 2024 18:19:22 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
cc: cocci@inria.fr, efremov@linux.com, nicolas.palix@univ-grenoble-alpes.fr
In-Reply-To: <CACzwLxiaXLLSZH=rufJkkyr07u45W40ENd=BXqU4B1NoyS1iag@mail.gmail.com>
Message-ID: <cc52b64d-d76f-1647-9e23-22fa78b51689@inria.fr>
References: <CACzwLxiohvUHUxm2XM8B08RwY6VCLuK1p32Ek2Y0M+t1wTfX8g@mail.gmail.com> <d3f5836b-9a4e-5974-b649-e6f75c5183f8@inria.fr> <CACzwLxiaXLLSZH=rufJkkyr07u45W40ENd=BXqU4B1NoyS1iag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1786173308-1727713077=:3991"
Content-ID: <ca381563-556f-aa21-c260-6f99cf85e06e@lip6.fr>
Subject: Re: [cocci] Assistance in Coccinelle script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1899
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/cc52b64d-d76f-1647-9e23-22fa78b51689%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1786173308-1727713077=:3991
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <a936821-b87e-aae6-27a5-6226ef37abb9@lip6.fr>



On Mon, 30 Sep 2024, Sabyrzhan Tasbolatov wrote:

> On Mon, Sep 30, 2024 at 8:41 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > Hello,
> >
> > I haven't studied it in detail, but I have the impression you want:
> >
> > position p != {r1.p,r2.p};
> >
> > and not depends on !r1 && !r2.  The depends on will check that the rules
> > r1 and r2 match nowhere in the file.  The fact that the position variables
> > are all called p doesn't mean there is any connection between them.
>
> Thanks. It solves the current problem, though it false-positively matches
> https://elixir.bootlin.com/linux/v6.11/source/arch/x86/kvm/svm/sev.c#L1161
>
> $ spatch --sp-file copy_from_user.cocci arch/x86/kvm/svm/sev.c
> ....
> arch/x86/kvm/svm/sev.c:1161:6-20: match !!!
> arch/x86/kvm/svm/sev.c:1199:7-21: match !!!
> arch/x86/kvm/svm/sev.c:1393:5-19: match !!!
> arch/x86/kvm/svm/sev.c:2293:7-21: match !!!
>
> I expected to cover #L1161 in @r1@ to ignore it via position p != {r1.p, r2.p};
>
> Will try to work with these rules and @missing@ against them. If you spot
> the obvious problem, please let me know. Thanks.
>
> Here is the modified script:
>
> // __user exists in parent function parameter.
> @r1@

You are missing exists here.

> identifier f, param;
> attribute name __user;
> expression E2;
> position p;
> type T;
> @@
> f(..., T __user *param, ...)
> {
> ...
> (
> copy_from_user@p(..., param, ...)
> |
> copy_from_user@p(..., param + E2, ...)
> )
> ...

This also requires that there is no other copy_from_user call before or
after the matches one.  To get rid of this constraint, put when any after
each ... Likewise in the next rule.

julia

> }
>
> // __user exists inline copy_from_user() casting.
> @r2 exists@
> identifier f, ptr;
> position p;
> type T;
> @@
> f(...)
> {
> ...
> (
> T __user *ptr = ...;
> ...
> copy_from_user@p(..., ptr, ...)
> |
> copy_from_user@p(..., u64_to_user_ptr(...), ...)
> )
> ...
> }
>
> @missing@
> position p != {r1.p, r2.p};
> @@
> copy_from_user@p(...)
>
> @script:python@
> p << missing.p;
> @@
> msg = "match !!!"
> coccilib.report.print_report(p[0], msg)
>
--8323329-1786173308-1727713077=:3991--
