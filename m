Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0AAC7618E
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=bB6/+qPGuzUb1MnCqY+G6M4fK08qHmxJ4Y2Ny/stYRA=;
  b=JXxkzylg6So1L5AbnNXBo+ivknftJleeM20Bdpge6Ldq6nV8AwZhoBnY
   vI0WqpKp1Wl9kYkOS8cTWiCu3Dmfnh7iiF/0s9+43oqGymDEN+KN0iujY
   iBi5QES9NzoknCz+PaDRCgR1Fjj2Uwcnzk2y4GT9RmaBr/89b1pqiL45Y
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104298377"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 17:22:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 04B94E01D1; Sat, 22 Apr 2023 17:22:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 09E83E019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 17:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bB6/+qPGuzUb1MnCqY+G6M4fK08qHmxJ4Y2Ny/stYRA=;
  b=S9NFcorbH64c8CYie9w9ncl2JRycTz3JDb6nXPOdnzF589rbcE9jmXpl
   28DDAyEUiosBuu8C5Q+pKr0pYKEXkRxjmb2PDoR1NCD0+nwVdz04C6lkR
   pOCUZHTPy0kZqSv6PRbmM/jAD/U73JiYq/ffzI1RkPaHxRGr2AetCfZGH
   g=;
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="54042299"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 17:22:47 +0200
Date: Sat, 22 Apr 2023 17:22:46 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
In-Reply-To: <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de>
Message-ID: <alpine.DEB.2.22.394.2304221719080.2766@hadrien>
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de> <alpine.DEB.2.22.394.2304221031370.2766@hadrien> <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-298801863-1682176966=:2766"
Subject: Re: [cocci] Checking data processing for capturing groups in
 regular expressions (with SmPL)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1117
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/alpine.DEB.2.22.394.2304221719080.2766%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-298801863-1682176966=:2766
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 22 Apr 2023, Markus Elfring wrote:

> > If you want a response, greatly simplify your semantic patch to the minimum necessary
> > to show the problem, and provide the .c file, which should also be the minimum necessary
> > to show the problem.
>
> Will the understanding grow for a questionable software situation with the following test code?
>
> Another SmPL script variant:
> @initialize:python@
> @@
> import re, sys
>
> @find_update_candidate@
> constant char[] input_string;
> expression input_context;
> @@
>  action(input_context, input_string);
>
> @script:python selection3@
> text << find_update_candidate.input_string;
> @@
> sys.stderr.write('text: ' + text + '\n')
> match = re.match('"([^"]+)"', text)
> if match:
>    sys.stderr.write('content: ' + match.group(1) + '\n')
> else:
>    sys.stderr.write('no match\n')
>
>
> Another corresponding source file example:
> void f(void)
> {
> action(x, "X");
> action(y, "++");
> }
>
>
> How reasonable do you find the following test result?
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch check_string_literal3-20230422-debug.cocci string_literal_usage4.c
> …
> text:   "++"
> no match
> text:   "X"
> no match

OK, it seems that you expect the value of a metavariable bound to a string
to have extra string quotes inside of it.  Maybe it would be useful.

julia


>
>
> How do you think about to omit extra white-space characters here
> before a double quotation character?
> https://en.cppreference.com/w/cpp/language/string_literal
>
> Regards,
> Markus
>
--8323329-298801863-1682176966=:2766--
