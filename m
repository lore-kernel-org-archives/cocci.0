Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01871C433EF
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 18:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nH/5NRYvcUVrmcICgM1ijFQeb6BxsPLNSXzIDmw3DEo=;
  b=uONQjbLq1Q0VLhIN8sLwvMd5zwmROWJgpOPy9yW8v7dFbrMg4sRxsR6Z
   Odylw8bvVHo9LKMSrpy3+djxh8P0Vm2HcfOTqw81iTn6BVr/+r8sDVgoe
   TmdjGDrcKZRzw523bNauoVU+r+URGkEoNLvTz2F7ibeYofH6+KUzvl+f+
   s=;
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
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27306413"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 19:30:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0EBC8E0219; Mon, 21 Mar 2022 19:30:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8801CE020F
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 19:30:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nH/5NRYvcUVrmcICgM1ijFQeb6BxsPLNSXzIDmw3DEo=;
  b=ippikVUb4X49gmQEHVtariPpzWcaCLBX8gnRTgDUGEVeqpw+QvzLptII
   TTF8wjG6fz8Ovf1+feE9Aa3xMY/BkjoXnyDfKhsn7UaE2BAWWp/MBLIi9
   YPqqNZ8cr0JoMQAVraLZbI37p6pbhjjiyyn1ZUh5lxFmIGCDWPUUcXjxl
   Q=;
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="9181330"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 19:30:38 +0100
Date: Mon, 21 Mar 2022 19:30:38 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr, Thierry.Martinez@inria.fr
In-Reply-To: <ac59aaae-6e1d-a5e6-e568-2049dc961f93@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203211928000.40128@hadrien>
References: <ac59aaae-6e1d-a5e6-e568-2049dc961f93@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How does Coccinelle call a script language from OCaml?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 277
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203211928000.40128%40hadrien>



On Mon, 21 Mar 2022, Eric Wheeler wrote:

> Hello,
>
> I'm curious how easy it would be to add Perl, since that is my most
> comfortable scripting language.
>
> Does Coccinelle dynamic-link directly to the python interpreter or
> is piping through |python ?
>
> What source file(s) handle the script invocation?

If you want to add perl, I have no problem with that.  I think that the
Coccinelle part is in python/pycocci.ml.  But it relies on an existing
connection between OCaml and python.  If you don't have that, it would
probably be a lot more complex.

Thierry, who I added to the CC list, should be able to explain how exactly
OCaml interacts with python.

julia
