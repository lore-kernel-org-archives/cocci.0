Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E765ACD98C5
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2026 10:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3zwHDd4pclyHvTEojAJya/nHpPIghxHJDFb+Lwg8k9E=;
  b=rYQXWE/0SB+Uh01bisiYMdWUV0PTa0E7m3lT11aQjqsCQUtwrtM03UeC
   464CGsaH+RdZiJqmcPL7ngZ/wmO30KBRgXDLQrJqx8l5EigJeXwWERV/S
   0LE7lWjeUhUM1ZEfJcz5zcpavU6BrkEtgK16/9idztiWn4jkjQyzv38m9
   I=;
X-CSE-ConnectionGUID: 0DFz4+flRvCQ4So6WJXZqw==
X-CSE-MsgGUID: kUqfrQSHQFuSS/cgskdheQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.24,204,1774306800"; 
   d="scan'208";a="281430155"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jun 2026 12:44:10 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DC6B080EBD; Sun, 14 Jun 2026 12:44:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DC09580622
	for <cocci@sympa.inria.fr>; Sun, 14 Jun 2026 12:44:03 +0200 (CEST)
X-CSE-ConnectionGUID: AFxki5nCS5SQnfRMXdqF+A==
X-CSE-MsgGUID: VO5o0rNyQTapWs+H5IwNRg==
X-IronPort-AV: E=Sophos;i="6.24,204,1774306800"; 
   d="scan'208";a="281430144"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 12:44:04 +0200
Date: Sun, 14 Jun 2026 12:44:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <7adfccf8-c656-4084-b5ca-9e3849e1aa70@web.de>
Message-ID: <38c5ff80-44bb-47dc-f65e-caef3bdb3398@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <7adfccf8-c656-4084-b5ca-9e3849e1aa70@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-249745368-1781433843=:28904"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3565
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/C6OjKI98Dt2GxNI817xeWg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-249745368-1781433843=:28904
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 14 Jun 2026, Markus Elfring wrote:

> …
> > @script:ocaml@
> > p1 << searching.p1;
> > p2 << searching.p2;
> > @@
> >
> > Printf.eprintf "duplicate on lines %d and %d\n" (List.hd p1).line (List.hd p2).line
> >
> > This does print a report on your test data.
>
> A)
> It is obvious that the implementation of the function “snd_seq_fifo_new” does not apply
> a goto chain so far.
> https://elixir.bootlin.com/linux/v7.1-rc7/source/sound/core/seq/seq_fifo.c#L17-L47
>
> B)
> How would the test output look like on your development system for another mentioned example
> with the function “smb3_reconfigure”?
> https://elixir.bootlin.com/linux/v7.1-rc7/source/fs/smb/client/fs_context.c#L1060-L1241
>
>
> Will further ideas appear also according to such a clarification approach?

I haven't tried your example, but it is likely that you just want exists
on your SmPL rule, ie

@searching exists@

julia


>
> Regards,
> Markus
>
--8323329-249745368-1781433843=:28904--
