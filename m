Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4672FC83038
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=PZbiT6B35hM0c9/4Xc3BIz4NfScqoHZbh7x+fgZLAOw=;
  b=c3rCTE/T3cCKYoLrP/REbW1pwooLziqam+gz8sIvshMP/wau1Qyw1rd0
   LxTgFC7wObiFrYM2XCNHa/cf/TSdruGL2DinAdczXE+kyMQIm3PJaEo9S
   ljEtn6RF80MP6iMMt2KArzNmhX2w++eLwm9SfaG/UTtWZ9wwmmzG0mrcT
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
   d="scan'208";a="229819806"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 15:41:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 836C3E0AF1; Tue,  1 Jul 2025 15:41:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D8C4AE0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 15:41:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PZbiT6B35hM0c9/4Xc3BIz4NfScqoHZbh7x+fgZLAOw=;
  b=HOmbzW6ni3eAzfjyA+1FIrbxfZKtc9Of79Or+V8iWInTKHABMiHObNP0
   whrtISQIX87aKQNKbmFFzkGXvwXsTXUYPLy8uS8aRafjfl1VxB1Q/45nV
   925thVZxM4/T7IgeSptTxNcQ6iJ1C1x7rqNHCd41e8ehWXhNL1M/3wkPg
   c=;
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229819790"
Received: from wifi-eduroam-85-114.paris.inria.fr ([128.93.85.114])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 15:41:11 +0200
Date: Tue, 1 Jul 2025 15:41:10 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <5da0fab5-ebbd-491b-84b1-69db7cec524e@web.de>
Message-ID: <92cfc83e-99b8-409e-8691-e761b3ede15f@inria.fr>
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de> <bd958cff-a9bb-4f6e-8305-e5a09375ccc6@web.de> <5da0fab5-ebbd-491b-84b1-69db7cec524e@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1415295389-1751377270=:7618"
Subject: Re: [cocci] Searching function implementations with variable
 declarations and statements?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2839
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/92cfc83e-99b8-409e-8691-e761b3ede15f%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1415295389-1751377270=:7618
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 1 Jul 2025, Markus Elfring wrote:

> > Should any diff output be produced accordingly?
>
> Would you occasionally really find a source code search approach like the following
> more appropriate?
>
> Another SmPL script example:
> @display3@
> statement s;
> identifier i;
> type t;
> @@
>  t i;
>  <+...
> *s
>  ...+>

You don't need the +

julia

>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --no-loops …/Projekte/Coccinelle/janitor/show_statements_after_variable_declaration2.cocci include/
> …
> @@ -668,7 +668,6 @@ usb_endpoint_maxp_mult(const struct usb_
> …
> @@ -723,17 +722,10 @@ usb_ss_max_streams(const struct usb_ss_e
> …
> real    0m0,243s
> user    0m0,199s
> sys     0m0,042s
>
>
> Is there a need to reconsider the handling of curly brackets (for compound statements)?
>
> Regards,
> Markus
>
--8323329-1415295389-1751377270=:7618--
