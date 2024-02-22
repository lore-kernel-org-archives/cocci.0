Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB77C54788
	for <cocci@archiver.kernel.org>; Thu, 22 Feb 2024 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=WN9nBmYpJifSQZN0FtHV2S+OVO/TLevTMIyC6S3j2/I=;
  b=a9AM+WdG2ILO0wsBAl0pPEsiaV2M7MYcUvM7kmyU+1Rlx44xEcCxqeKj
   Qy4LWUAwtnRZqxVbRNMsKqyYx2/Pa+4UDPIxBhDIpBok79Hl4EIfcrvvw
   l+bCQUWf3YtKEdO5ACTP99BIZv41RIgy6IGL5VRcBAl+7CrtYFs9f4xFA
   8=;
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
X-IronPort-AV: E=Sophos;i="6.06,177,1705359600"; 
   d="scan'208";a="153262870"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Feb 2024 14:22:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 93E57E0CD7; Thu, 22 Feb 2024 14:22:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 82D50E00B7
	for <cocci@sympa.inria.fr>; Thu, 22 Feb 2024 14:22:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WN9nBmYpJifSQZN0FtHV2S+OVO/TLevTMIyC6S3j2/I=;
  b=cBXXwHNUwQUgu8gYvcO6El5ENgGbjYRZV1aWVSSACf8gb6WQRbga76xI
   ZMX+yiILonGy1b22ZflZmgWhQgOd/25hGHio78iOVzmpLGxKP58sOlUeX
   h43+4Ykiaj18mnFYdkmhQqq8Pl7n58WpFC65PCE3uy2Ht8XgIBPSDjTxF
   4=;
X-IronPort-AV: E=Sophos;i="6.06,177,1705359600"; 
   d="scan'208";a="80345704"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 14:22:06 +0100
Date: Thu, 22 Feb 2024 14:22:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <814fc9f8-9ef1-42fc-ae9f-ef8d4a82979a@web.de>
Message-ID: <8548519-fb2f-5860-bd86-3a4d20669c5c@inria.fr>
References: <814fc9f8-9ef1-42fc-ae9f-ef8d4a82979a@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1378869451-1708608125=:10348"
Subject: Re: [cocci] Detecting misused expressions with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1594
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/8548519-fb2f-5860-bd86-3a4d20669c5c%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1378869451-1708608125=:10348
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 22 Feb 2024, Markus Elfring wrote:

> Hello,
>
> I noticed another contribution by Dan Carpenter.
>
> [PATCH 1/2] iio: adc: ti-ads1298: Fix error code in probe()
> https://lore.kernel.org/lkml/5f393a87-ca8b-4e68-a6f4-a79f75a91ccb@moroto.mountain/
> https://lkml.org/lkml/2024/2/22/175
>
>
> I became curious how good such a known source code search pattern
> could be expressed by the means of the semantic patch language
> also together with the software combination “Coccinelle 1.1.1-00739-g68c580f1”
> for the implementation of a function like “ads1298_probe”.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/iio/adc/ti-ads1298.c
>
> Unfortunately, I stumble on the following test result for another
> small SmPL script.
>
>
> @find@
> expression e;
> position p;
> @@
>  if (IS_ERR(e))
>  {
>     if@p (PTR_ERR(e) != -ENODEV)
>     {
>        ... when != e
>        ;
>     }
>     ...
>  }
>
> @display@
> position find.p;
> @@
>  if@p (...)
>  {
> *     ...
>       ;
>  }
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci show_questionable_PTR_ERR_usage.cocci
> …
> No rules apply.  Perhaps your semantic patch doesn't contain any +/-/* code, or you have a failed dependency.  If the problem is not clear, try --debug-parse-cocci.
>
>
> I observed that help information is displayed instead of a corresponding
> representation of debug data if I try the mentioned program parameter out.
>
> Will there any further software improvements become possible?

What do you expect the ... with the * in front of it to match?  I think it
will match a single expression.

The fact that no * is detected does seem like a problem.

julia
--8323329-1378869451-1708608125=:10348--
