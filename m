Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476D0CD98D2
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2026 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SzkqN/e7mc85kDXCaWXr7WSovTcc28GAwrMJDnH02NQ=;
  b=Vo58HKSAcgasd/ZCJXrUD6KkJcJF8pJ8+WJbtIF9inRloPiLn6mSUnmZ
   iDRpWzUd7/0f/H8/2mN0nLf24/XvKWes6lQwz4Pd4SCKK+O7pzVhXpybG
   Lc8WoHpOIOJF7u49FBUpkWcY9GLq1PKJiPwlVeh/xDus2LmtXB2LHi/nV
   4=;
X-CSE-ConnectionGUID: N7jkWhmqQOOUKN65UsbpjA==
X-CSE-MsgGUID: vHSfy/aGSMqwBNB4eJqk2Q==
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
X-IronPort-AV: E=Sophos;i="6.24,205,1774306800"; 
   d="scan'208";a="281447405"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jun 2026 18:20:55 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 43E0580F56; Sun, 14 Jun 2026 18:20:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 74EBB80EEC
	for <cocci@sympa.inria.fr>; Sun, 14 Jun 2026 18:20:51 +0200 (CEST)
X-CSE-ConnectionGUID: c0mAt2iHS1WFY1DM8hJHjA==
X-CSE-MsgGUID: EpIR0awjS16zkT8OcaEZrw==
X-IronPort-AV: E=Sophos;i="6.24,205,1774306800"; 
   d="scan'208";a="149389072"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:20:51 +0200
Date: Sun, 14 Jun 2026 18:20:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de>
Message-ID: <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3566
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/z_lM6AXwRpopdB1zyr5zKA>



On Sun, 14 Jun 2026, Markus Elfring wrote:

> > Could you please make something that doesn't involve a database?
>
> Do you find another test approach helpful for the desired clarification?
>
>
> SmPL script example:
> @initialize:python@
> @@
> import sys
> delimiter = "|"
>
> def display_data(fun, source1, source2, x, y):
>     sys.stdout.write(delimiter.join(("info", fun, x, y))
>                         + "\n")
>     for place in source1:
>        sys.stdout.write(delimiter.join(("first",
>                                         place.file,
>                                         place.line,
>                                         str(int(place.column) + 1)))
>                         + "\n")
>
>     for place in source2:
>        sys.stdout.write(delimiter.join(("tail",
>                                         place.file,
>                                         place.line,
>                                         str(int(place.column) + 1)))
>                         + "\n")
>
> @searching exists@
> expression e, x;
> identifier item, rc, work;
> position p1, p2;
> type t;
> @@
>  t work(...)
>  {
>  ... when any
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x
>  kfree@p1(item);
>  return rc;
>  }
>  ... when any
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x
>  kfree@p2(item);
>  return rc;
>  }
>  ... when any
>  }
>
> @script:python collection@
> fun << searching.work;
> x << searching.item;
> y << searching.rc;
> p1 << searching.p1;
> p2 << searching.p2;
> @@
> display_data(fun, p1, p2, x, y)
>
>
> https://elixir.bootlin.com/linux/v7.1-rc7/source/fs/smb/client/fs_context.c#L1060-L1241

Thank you for making a complete example.  Now take the huge C function and
make a minimal example that illustrates the problem you are concerned
about.  The function is almost 200 lines long.

julia


>
> Extracted function implementation
>
>
> Questionable test result:
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> time /usr/bin/spatch ../janitor/list_selected_duplicate_statements_in_if_branches3.cocci smb3_reconfigure-excerpt2-20260608.c
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> HANDLING: smb3_reconfigure-excerpt2-20260608.c
> info|smb3_reconfigure|old_ctx|rc
> first|smb3_reconfigure-excerpt2-20260608.c|34|3
> tail|smb3_reconfigure-excerpt2-20260608.c|185|2
> info|smb3_reconfigure|old_ctx|rc
> first|smb3_reconfigure-excerpt2-20260608.c|185|2
> tail|smb3_reconfigure-excerpt2-20260608.c|185|2
>
> real    0m0,506s
> user    0m0,400s
> sys     0m0,095s
>
>
>
> How do you think about to avoid repeated data display here (despite of the applied goto chain)?
>
> Regards,
> Markus
>
