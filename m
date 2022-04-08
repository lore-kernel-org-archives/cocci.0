Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828D3C433F5
	for <cocci@archiver.kernel.org>; Fri,  8 Apr 2022 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=KSF+9ygdekWG++Pv53xWTW6Om9FayfKOP+ghtIk/k8I=;
  b=d3CxP9JSSHEhy6O4QeLN6HhQHicVwuXeR0hcsu+lLW1lRyR4TYYRYRTM
   8Ne0+6yZSYXDjyLoR5Obd4L7kjUhc9kBWREi42ZELfotPf5RWJra/+aKu
   e6RlGrzDKcjShi/o8RJkxM3bqr+E/rdRMlTuaL7nyjHBQhiq0ubJLYNjj
   g=;
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
X-IronPort-AV: E=Sophos;i="5.90,245,1643670000"; 
   d="scan'208";a="30790397"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Apr 2022 13:59:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 308E4E033D; Fri,  8 Apr 2022 13:59:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DDA8E00B8
	for <cocci@sympa.inria.fr>; Fri,  8 Apr 2022 13:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KSF+9ygdekWG++Pv53xWTW6Om9FayfKOP+ghtIk/k8I=;
  b=NIUjMtxt7QImzrvWbQuZrtOZDoKRXEfYuQKajSk19735svehBD3nTWwA
   EnIEB50IO6Ni3X7bJ9qVYL29wpMh5hhp3legBtBs/T516YH38rNMkmfEC
   /6J7XGdRxBV/u1324qUrLqyzCwuW4UyCWn9rlJUKOMATUrK+h0yropoe6
   0=;
X-IronPort-AV: E=Sophos;i="5.90,245,1643670000"; 
   d="scan'208";a="10984334"
Received: from unknown (HELO hadrien) ([95.128.147.62])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 13:59:55 +0200
Date: Fri, 8 Apr 2022 13:59:53 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
cc: cocci@inria.fr
In-Reply-To: <b59aa9b9-8caf-2256-8f1e-6404e56a6410@linbit.com>
Message-ID: <alpine.DEB.2.22.394.2204081357300.2194@hadrien>
References: <b59aa9b9-8caf-2256-8f1e-6404e56a6410@linbit.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-450307192-1649419194=:2194"
Subject: Re: [cocci] Matching a label after a return
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 360
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/alpine.DEB.2.22.394.2204081357300.2194%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-450307192-1649419194=:2194
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 8 Apr 2022, Christoph Böhmwalder wrote:

> Hi all,
>
> Consider some function like this:
>
> void test (int x)
> {
>    if (x)
>        goto label;
>    return;
> label:
>    do_something();
> }
>
>
> and the following coccinelle patch:
>
>
> @@
> identifier x;
> identifier label;
> @@
> if (x)
>     goto label;
> ...
> - label:
> -   do_something();
>
>
> I would expect this to match the label, but it does not:

The problem is that there is no cotrol-flow path from the bottom of the if
to the top of the label, due to the return.  Maybe the following will
work, but I'm mot sure:

 if (x) {
     goto label;
     ...
 -   label:
 -     do_something();
 }

julia

>
>
> $ spatch --sp-file test.cocci test.c
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> HANDLING: test.c
>
>
> Is this a bug or am I holding it wrong?
> It does not appear to be directly related to the label itself, because
>
>
> @@
> identifier label;
> @@
> - label:
> -   do_something();
>
>
> gives the expected result.
>
> $ spatch --version
> spatch version 1.1.0-g69ea912-dirty compiled with OCaml version 4.12.0
>
> --
> Christoph Böhmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA —  Disaster Recovery — Software defined Storage
>
--8323329-450307192-1649419194=:2194--
