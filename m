Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420F5C83038
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=F/54avQSw48HLm0iZchQw0Nu9HELAma+GxtJv2ZRTJs=;
  b=C/LLet7vEBu4l90+HMqO4zspMkjPUrpjLCiUwZl5c0vUH1BzKvpuuCGt
   EvSAfrX3cQuBBkpmqNu7Tx6EfXNZw/urTFyAx9YxOb+v1n2pHe6hQfa3I
   7kuJrYebNniYIcdJPQA5Do/9SYGNjKDmAdrbWX33Gkt4pcKzagqYobFoq
   s=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229819676"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 15:40:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 07F18E0AF1; Tue,  1 Jul 2025 15:40:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9CEBEE0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 15:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F/54avQSw48HLm0iZchQw0Nu9HELAma+GxtJv2ZRTJs=;
  b=McIxWugPPx5qhVvjNlczSRS6vMLSoZK+yB8JESxzJCXYS+9/zQ4RWFDV
   gO83vmyRDyQfFvljZLze/fKPvcRVgpCbqmzqVluooNewA96qmFynYsulo
   I52ZZnlVx5WK6Q5ML35UMfh+KcCNEK/mYsjKPjIi/unlstbJGAnVFGjzP
   0=;
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="120408577"
Received: from wifi-eduroam-85-114.paris.inria.fr ([128.93.85.114])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 15:40:37 +0200
Date: Tue, 1 Jul 2025 15:40:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de>
Message-ID: <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr>
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de> <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1190323019-1751377237=:7618"
Subject: Re: [cocci] Searching function implementations with more than a
 single return?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2838
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/5ce5048-db22-67f-aceb-a358c54a62ee%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1190323019-1751377237=:7618
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 1 Jul 2025, Markus Elfring wrote:

> > Another SmPL script example:
>
> for further development considerations?
>
> @display@
> identifier i;
> statement s;
> statement list sl;
> type t;
> @@
> (return ...;
> |t i;
> (
>  <+...
> *s
>  ...+>
> |
> *sl
> )
> )

This one makes no sense, because return and t i; can't match the same
thing.  So the disjunction has no impact.

julia

>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --no-loops …/Projekte/Coccinelle/janitor/show_functions_with_more_than_single_return2.cocci include/uapi/linux/usb/ch9.h
> …
> @@ -668,7 +668,6 @@ usb_endpoint_maxp_mult(const struct usb_
> …
> @@ -723,17 +722,10 @@ usb_ss_max_streams(const struct usb_ss_e
> …
> real    0m0,250s
> user    0m0,217s
> sys     0m0,030s
>
>
> Regards,
> Markus
>
--8323329-1190323019-1751377237=:7618--
