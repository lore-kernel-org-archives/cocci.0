Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7075C4829E
	for <cocci@archiver.kernel.org>; Sun, 18 Feb 2024 08:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5LyFCiqzXp2Bctpxz7f3vnjkiDMXlw6w0w4kushvaYQ=;
  b=bmw204HTeaOItDJDrmxdcEaVxAjlZZmCw52qsS9tcEnO/pwmmOMeLxZ4
   mPrqK+bd3MysdmFmGbPVZdX7JSv7xx0oqBek2DpwDuLZdHlToT1YqnmnL
   ysZkHCvY5LWKVfY4kKgx+fNMp279Gs3ynbmL+fgEOJTERohpLTp3nhvP/
   M=;
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
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152482428"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Feb 2024 09:11:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 797D8E00B7; Sun, 18 Feb 2024 09:11:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 048C1E008A
	for <cocci@sympa.inria.fr>; Sun, 18 Feb 2024 09:11:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5LyFCiqzXp2Bctpxz7f3vnjkiDMXlw6w0w4kushvaYQ=;
  b=HlxcbwseWpozvQiW5F4poAnoeNQ+0FiYOT10pqSxtea6bziDEWVH8yff
   mjZiFWAUnXxo4TIhmQ+C9dh4yM902CaBUzzKnAXLCK5Xhjfb0IymK+Aus
   AK+mQIkJoWtCUpI5m2irBFvxO2xO7mA3JbtjUbbCSpbhDTE3qCh+JGUM0
   s=;
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="79934192"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:11:03 +0100
Date: Sun, 18 Feb 2024 09:11:02 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <6a89e704-5561-4f44-b9d7-7c8f78976e71@web.de>
Message-ID: <alpine.DEB.2.22.394.2402180908440.3095@hadrien>
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de> <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de> <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de> <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr> <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
 <6a89e704-5561-4f44-b9d7-7c8f78976e71@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-929407155-1708243862=:3095"
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1576
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402180908440.3095%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-929407155-1708243862=:3095
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 18 Feb 2024, Markus Elfring wrote:

> > I became curious how the corresponding software run time characteristics
> > will evolve further.
>
> Another contribution was published yesterday:
> binops and assignops need to be stripped before being put into metavariables
>
> Thus data processing can be measured after such a development progress
> also together with the software combination “Coccinelle 1.1.1-00736-gcf3ea16c”
> for the following SmPL script variant.
>
>
> @deletion2@
> binary operator bo;
> constant c;
> identifier var;
> @@
>  if (var bo c)
>     return var;
>  ... when != var
> -if (var bo c)
> -   return var;
>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> git checkout next-20240209 && time spatch drivers/md/dm-vdo/slab-depot.c …/Projekte/Coccinelle/janitor/delete_redundant_if_statement2.cocci
> …
> @@ -4100,9 +4100,6 @@ static int allocate_components(struct sl
> …
> real    0m1,211s
> user    0m0,981s
> sys     0m0,095s


I don't understand what is the issue.  If it takes more times than before,
then post the old running time too.  If it takes a little more time than
before, then that's normal, because when the match succeeds, it does more
work.

julia

>
>
> * Can such a test result trigger any development concerns for wider applications
>   of SmPL conjunctions?
>   https://lore.kernel.org/cocci/01fe8b37-9fff-4137-818c-8a851ce588a3@web.de/
>
> * How will comparisons of source code search and transformation algorithms
>   evolve further?
>
>
> Regards,
> Markus
>
--8323329-929407155-1708243862=:3095--
