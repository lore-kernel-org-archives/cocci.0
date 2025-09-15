Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBE6CAC592
	for <cocci@archiver.kernel.org>; Mon, 15 Sep 2025 21:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QiDGCxit5Thkq1YqgyBcQxkkrEUENVFAPCjDRjSJJ/U=;
  b=SJ1lEPb+ifUanN/ey6+QLgw/yt63Ck3xQCYVGgUX3hWtUXtX7CZqoEhe
   jZ07l86xuMKEGVLobQ4PDcijIPHQwpU0FEQFdLTxMmuC/jUGI7/zLN84l
   btGADgmMLjA+zhjuzvK2rEybNEprNU9T+3mRxpPNqiu5HAndTD5WVXaRi
   E=;
X-CSE-ConnectionGUID: bXiopEmYTZ+LAHmQRjzbcw==
X-CSE-MsgGUID: ZYbZSNjhQEGlVEATugXZvA==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.18,267,1751234400"; 
   d="scan'208";a="239207100"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Sep 2025 23:38:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 21AEBE0B0D; Mon, 15 Sep 2025 23:38:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C2E5CE0171
	for <cocci@sympa.inria.fr>; Mon, 15 Sep 2025 23:37:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QiDGCxit5Thkq1YqgyBcQxkkrEUENVFAPCjDRjSJJ/U=;
  b=fBjS1NQEu6qflicZxvTPMUDTn6pIof5KL9zWqGESGdGC160Vtsk0+L/H
   7lLuCk8DvOFHSWnDiyy7231oRnWnGp7CGzkV8Hn/0nf82i4ytQz6JV/JH
   HCGO4b9je4jQHMcZpqsSFIiEWrbqHwFaJnlrHnXHiX+8e4YTD0XdRUI64
   E=;
X-CSE-ConnectionGUID: 7u+9XSagT2+0+TNWnN736w==
X-CSE-MsgGUID: LQ1jGv+WQ826NRGyjZBVvQ==
X-IronPort-AV: E=Sophos;i="6.18,267,1751234400"; 
   d="scan'208";a="239207099"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 23:37:59 +0200
Date: Mon, 15 Sep 2025 23:37:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Anon Anonson <anon@chud.cyou>
cc: cocci@inria.fr
In-Reply-To: <d04274ea-7bff-4c63-8fc6-55a19ab45b55@chud.cyou>
Message-ID: <a38c126f-8a35-343-f7d0-d2a0da17f521@inria.fr>
References: <d04274ea-7bff-4c63-8fc6-55a19ab45b55@chud.cyou>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2005854455-1757972279=:9740"
Subject: Re: [cocci] Possible bug
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3019
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/a38c126f-8a35-343-f7d0-d2a0da17f521%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2005854455-1757972279=:9740
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 14 Sep 2025, Anon Anonson wrote:

> Greetings,
>
> I was playing around with spatch in an attempt to create a wrapper utility for renaming.
>
> Given the following script:
> @ rn_dec @
> type T;
> identifier I = i;
> @@
>
> - T I
> + T b
> ;
>
> And the following input:
> void f() {
>     int i;
>     for (int i;;) { ; }
> }
>
> The following patch is generated:
> diff =
> --- main.c
> +++ /tmp/cocci-output-9754-fec11b-main.c
> @@ -1,4 +1,4 @@
>  void f() {
> -    int i;
> +    int b;
>      for (int i;;) { ; }
>  }
>
> However, I would expect the declaration inside the 'for' to be replaced too.
> My only questions is: is the observed behaviour intended?

I guess one could go either way on this.  Normally, a for loop header has
the form

 for ( ; ; )

So the semicolons are part of thr for loop header, not part of the
declaration.  So that's why your pattern doesn't match.  I think that
currently the only solution is to make a special case for for loop
headers.

julia
--8323329-2005854455-1757972279=:9740--
