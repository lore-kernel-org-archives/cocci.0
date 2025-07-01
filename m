Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7085BC83038
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 12:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=jOLL8TjrMNJ/zSkWaCVat/DFYC8QxViKm+dE+ChUCM8=;
  b=nroqWD+knAg4D9NO2EvcH/3UwRCJt8jufEyQ0HYElwIa35ioMdptUs65
   QWUcibSceEpd6Hcqq8/fKZQkUNINEgLjSldikCTd39zvNEqP1thV307dU
   nzkPFQ/ddDhpNHHBva1aES0s0h5iywWCzOA5TnoCKrG91oF6K0igIy7AF
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
   d="scan'208";a="229800066"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 14:29:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E4612E01A8; Tue,  1 Jul 2025 14:29:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 242CDE0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 14:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jOLL8TjrMNJ/zSkWaCVat/DFYC8QxViKm+dE+ChUCM8=;
  b=IPcdcOKqkKmvLPf+9eyZeUm9n2XeEOKIB1hnD3W05VmzCzQvLeA5IxPk
   cpHzbS/GjPum7zu9U2k45ciLr9ohFI4dLNASNkhM376vJdUA3J2I1gD63
   2Jy0bLR6mA1/EQZM8DzaZ4BT1QTfPVQIVo+x8NoDWZLfWEsEdYq+jEHRC
   A=;
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="120398802"
Received: from wifi-eduroam-85-114.paris.inria.fr ([128.93.85.114])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:29:31 +0200
Date: Tue, 1 Jul 2025 14:29:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <b05db8f8-9902-46d2-8c2f-844ff426973a@web.de>
Message-ID: <5c912323-7165-681a-5039-1bd986e2439@inria.fr>
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de> <701689c5-3003-417e-91bf-866355e2fe65@web.de> <4fe8ff5-73f8-2362-078-2b1c8432ade@inria.fr> <b05db8f8-9902-46d2-8c2f-844ff426973a@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1658867975-1751372970=:7618"
Subject: Re: [cocci] Searching function implementations with variable
 declarations and statements?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2835
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/5c912323-7165-681a-5039-1bd986e2439%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1658867975-1751372970=:7618
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 1 Jul 2025, Markus Elfring wrote:

> >> Should any diff output be produced accordingly?
> > Probably not.  Statement list metavariables only match the list of
> > statements that occur at top level within {}.
>
> Do you occasionally prefer a source code search approach like the following?
>
> Another SmPL script example:
> @display2@
> statement s;
> identifier i;
> type t;
> @@
>  <+...
> *t i;
>  ...+>
>  s

This seems more promising.

julia

>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --no-loops …/Projekte/Coccinelle/janitor/show_variable_declarations_before_statements2.cocci include/…
> @@ -666,7 +666,6 @@ static inline int usb_endpoint_maxp(cons
> …
> @@ -721,7 +720,6 @@ struct usb_ss_ep_comp_descriptor {
> …
> real    0m0,250s
> user    0m0,202s
> sys     0m0,048s
>
>
> Regards,
> Markus
>
--8323329-1658867975-1751372970=:7618--
