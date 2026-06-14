Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3EFCD8CA8
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2026 21:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=C4KDtlEB4+SJQ2oYUJbDCc/07+73SnixkQW4vOhIdic=;
  b=JbRPjRMoCtdb8ucqXNvxkHbZVMRwah9VlezRPAD7lSUhRoGd6vbhXVL/
   j0bEH6EFHxK+YsyqPIiZ4IXdy+NtdlDjS6RLuXcpnhCMCEpbKgfkGIwH4
   6TXAnp2fYfZKZFreVl8yosJ3NbUOxwThwWYvhso97kQCoyesII/+8FwRv
   w=;
X-CSE-ConnectionGUID: Sgs0tDPcRH+1PeMy0v3V/Q==
X-CSE-MsgGUID: ijlPL5HOQBqZisB3VJCAaQ==
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
   d="scan'208";a="281464063"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jun 2026 23:28:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E5191812CA; Sun, 14 Jun 2026 23:28:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 37F0480437
	for <cocci@sympa.inria.fr>; Sun, 14 Jun 2026 23:28:50 +0200 (CEST)
X-CSE-ConnectionGUID: mmAkaY3iS6GJOp+B3SKvMg==
X-CSE-MsgGUID: VMykO3k7R3mA0gERWnpZQw==
X-IronPort-AV: E=Sophos;i="6.24,205,1774306800"; 
   d="scan'208";a="281464049"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 23:28:50 +0200
Date: Sun, 14 Jun 2026 23:28:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <b6742f17-1963-4c37-be09-3f79fb8a7812@web.de>
Message-ID: <b33f13ff-b2aa-22df-71-1d776789cf4@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <d72cea11-74ae-477a-ac45-6e866343190c@web.de>
 <a9fc1de2-ea5b-d081-1d1d-79b576c0ac86@inria.fr> <6d119768-1a82-4e5d-9a2b-b183942a3003@web.de> <891da31-ab4c-fec8-2fe8-23ff69411ce2@inria.fr> <b6742f17-1963-4c37-be09-3f79fb8a7812@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1915855904-1781472530=:99844"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3568
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/hviqJPs3cn3TqavzDl5PvA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1915855904-1781472530=:99844
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 14 Jun 2026, Markus Elfring wrote:

> >> Questionable test result:
> >> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> time /usr/bin/spatch ../janitor/list_selected_duplicate_statements_in_if_branches3.cocci test-insufficient_goto_chain_usage.c
> >> …
> >> info|my_test|md1|rc
> >> first|test-insufficient_goto_chain_usage.c|12|5
> >> tail|test-insufficient_goto_chain_usage.c|36|2
> >> info|my_test|md1|rc
> >> first|test-insufficient_goto_chain_usage.c|36|2
> >> tail|test-insufficient_goto_chain_usage.c|36|2
> >
> > Could you please explain what the output actually means?
>
> Data are displayed from fields of SmPL position variables,
> aren't they?
>
> Did you notice that the data display amount is different between the discussed implementations
> of the functions “my_test” and “snd_seq_fifo_new”?
> How would you explain such a remarkable information difference?

I suspect that your problem is just that the control flow in an if leads
across a goto, and two ifs that least to the same place are considered to
contain the same code.  It should be sufficient to say when != goto l1;
and when != goto l2; on the ...s before the kfree calls to avoid this
behavior.

julia
--8323329-1915855904-1781472530=:99844--
