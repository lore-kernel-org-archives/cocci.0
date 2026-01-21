Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BCCC44536
	for <cocci@archiver.kernel.org>; Wed, 21 Jan 2026 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LgiuRd2JcPKDIImCouUG3CT0DcPDtLt2FmWfpztLsqc=;
  b=YG7GiEMV1L+JhBIjFC0VliQ9KIj/+2rp7CTPav+QcpnVeRUKPe4wP7fM
   QRk+5VUGSRjlEH9/lfg8JIk0cKxWj6n7bl37Z60JUIu9Ytv2pivQBGSfE
   HrnV1y5PfrtDJgYltpUeHmGrvuHDZs5R+HAo1VQiFG7/EinNGUF3PZxst
   U=;
X-CSE-ConnectionGUID: giA9qclIRVyfLdCCxXikWQ==
X-CSE-MsgGUID: FN4CETHVTn61hKGvs/MMaA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259677190"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2026 15:51:04 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DD2EB819FA; Wed, 21 Jan 2026 15:51:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 438D4819FA
	for <cocci@sympa.inria.fr>; Wed, 21 Jan 2026 15:51:00 +0100 (CET)
X-CSE-ConnectionGUID: Uy0xRkUzQxKy+DBgcfYSKg==
X-CSE-MsgGUID: yP9XhGdKRKSeiL3i/N7O3Q==
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="136626351"
Received: from unknown (HELO hadrien) ([4.26.64.170])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 15:51:00 +0100
Date: Wed, 21 Jan 2026 09:50:57 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Felix Gu <gu_0233@qq.com>
In-Reply-To: <fb3420c5-a510-4d72-8d6f-6f0d44ad9289@web.de>
Message-ID: <54744c7e-71b1-ef69-f0f8-bb67dcdffe47@inria.fr>
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de> <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr> <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de> <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr> <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr> <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de> <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de> <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr> <93ad7521-d583-4997-b21e-91433aa602ec@web.de>
 <fb3420c5-a510-4d72-8d6f-6f0d44ad9289@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-63236799-1769007059=:3230"
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3294
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/h1HmA7bxTAxNQ8QxV0SY8Q>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-63236799-1769007059=:3230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 21 Jan 2026, Markus Elfring wrote:

> > Another SmPL script variant can be tried out:
> > @refined_display@
> > expression action;
> > expression * pointer;
> > identifier member;
> > @@
> > *pointer = action(...);
> >  (
> >  <+...
> > *pointer->member
> >  ...+>
> >  );
>
> Another test result:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --timeout 23 -j4 --chunksize 1 --no-loops -dir . …/Projekte/Coccinelle/janitor/show_questionable_statement_combination7.cocci > …/Projekte/Bau/Linux/scripts/Coccinelle/show_questionable_statement_combination7-20260120.diff 2> …/Projekte/Bau/Linux/scripts/Coccinelle/show_questionable_statement_combination7-errors-20260120.txt
>
> real    56m58,910s
> user    215m49,097s
> sys     2m22,875s
>
>
> The generated data would indicate then that 6018 source files of the software
> “Linux next-20260120” would contain implementation details for further
> development considerations.
> It seems that this source code search approach is “too simple” so far.
> How would you like to improve it for the avoidance of unwanted false positives?

Lots of research papers have worked on this problem.  You can find the
definition and see if it returns NULL.  YOu can find other calls to the
function and see if they test for NULL.  But you may always get false
positives, because there may be some combinations of arguments that can
never lead to a failure.

julia
--8323329-63236799-1769007059=:3230--
