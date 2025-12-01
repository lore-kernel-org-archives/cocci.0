Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B95CD111A8
	for <cocci@archiver.kernel.org>; Mon,  1 Dec 2025 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=S5hbyYLAnTORLMrKL1It0Kf8TMoi1sI0SfzNVzJrbRc=;
  b=FQbGHeXHkooCrlpiHX42uI8g7W5XvAJjLHVKmexPBZzMStZ1lFx8n1F+
   67zQez8x7EA0sVoeorgmEvdsJFxnScTEcK4DBm2QZ8XbzP2aSj+iKqpzi
   hhcwivuSVuvU1aEXpyaWiS2vxvP6AogYCXqnuB989JHbNRVTCTH5hZyzW
   A=;
X-CSE-ConnectionGUID: IVA3qyFOTn+8Bq0o2ACrjQ==
X-CSE-MsgGUID: x9FtOLNyTWi2UcVjz4G29Q==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@posteo.de
X-IronPort-AV: E=Sophos;i="6.20,240,1758578400"; 
   d="scan'208";a="252027639"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Dec 2025 09:32:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35320E0AF1; Mon,  1 Dec 2025 09:32:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 40D83E0157
	for <cocci@sympa.inria.fr>; Mon,  1 Dec 2025 09:32:25 +0100 (CET)
X-CSE-ConnectionGUID: EAseQrBETuGierVAjBGtdg==
X-CSE-MsgGUID: HR87O1CnSEudONv5GhN8oA==
IronPort-SDR: 692d5298_1JasGlgNnQ34y7Q9s4jog+xKVGeaVqv+Zqww2i4cP2+7GG1
 RSrbsYuHQKwDNSYRNnD0cw4+AaXOTavKTSV6s6A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EUBAAYUi1pe0IkQ7laHQEBAQEJARIBBQUBQIFQAoI+g?=
 =?us-ascii?q?WAzBwhJjVCIeRSSBo4CDwEDAQ1PAgQBAQMEgUyDNAKMZQIfBgEENQUNAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABASIgDjuGTw2CW4Esg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAiw/AQEeAgEDOAIGAQE4DwtGViGFHQJPBwGyGYE0g?=
 =?us-ascii?q?QGCDAEBBtwlgWQJgUoBhW2CZQGFXoUIJw+BVUSEDjE+hFg4hXeCJoEOhiSTL?=
 =?us-ascii?q?SwmeBwDWSwBDxE1ExcLBwWBIEMDgQsjDzwFLR2BIyEdGBNgPRdAg0kdBmcPB?=
 =?us-ascii?q?oERGUkCAgIFAkA6gWYiBhwSAgMBAgI6VQyBdwICBIIWfoIKD4gGgQkFLoENA?=
 =?us-ascii?q?wsHZj03FBsGAgGBNZQRUIIogRUBgkpHEZJGFJAugTahRTQHgjiBZ4FeBgyfb?=
 =?us-ascii?q?xIcF5dgkwuZBqlBggAigVxNJIM2TwMZD44hDBYcg3XEfUM1PAIHCwEBAwmFa?=
 =?us-ascii?q?ROMIoFLAQE?=
IronPort-PHdr: A9a23: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
 Vg6h1kmCdk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:1ngF7qlh69gnAdedOPNQLHSRg/LpDfIi3DAbv31ZSRFFG/Fw5P
 rPoB1773XJYVkqNE3I9erwXZVoBEmskaKdgrN/AV7BZmTbUQKTRekI0WKh+UyCJ8SUzI9gPM
 lbAspD4ZHLY2ST0KvBkW6FL+o=
X-Talos-CUID: 9a23:3VARgmxFrAukZRIoZxYmBgU5M9soS2f34UvNDE61E1hASpe6VVOfrfY=
X-Talos-MUID: 9a23:SGvtfwjFVzeYsl3WyZqtGsMpFP04vIP3I0Y2vIgKnO+aaANwHWeapWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,240,1758578400"; 
   d="scan'208";a="132373429"
X-MGA-submission: =?us-ascii?q?MDEvCBwvwwy5zA/8GgGh7Fo6mvaG5UTug1Ey/6?=
 =?us-ascii?q?TL56cZIs7zXecrlVQ3yFrfTmtRDKonOXY62KeIiVb8p/Ui3GDOX+XyBb?=
 =?us-ascii?q?5bh/YDuH7+fib2lFdyEZ2hWWXZZzeg649zBkImIx8EoVkKpYLQvzVEGP?=
 =?us-ascii?q?ApAtNuUZwIMkkPj1KFgyxZ4g=3D=3D?=
Received: from mout02.posteo.de ([185.67.36.66])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 09:32:25 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C67ED240101
	for <cocci@inria.fr>; Mon,  1 Dec 2025 09:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764577943; bh=S5hbyYLAnTORLMrKL1It0Kf8TMoi1sI0SfzNVzJrbRc=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=OGTjwwrDtabLB/4lpgqfBH5KIw1nnxlBlqNzDj51t3xG36dyOrTlZqlBLLpiyPFTi
	 Of+wZGPNnwxWcAmZxhWIxtFFKQuQHcb0/n0wG/WFgu8xsazlI+PK3JcVaPcwDs8vB/
	 niGMHGm0IEBT1epIcu/KhZDyS4bn9v3AQUNPbsZhcoaYM42UR1RxPTfbd1/Qqk5oLD
	 /wd2H0mCP2NJDXTknBuRaaI46hfAFrkHvpCHJdlHPT7JqWtebhzcqbBxpY7lRkpv0l
	 0fYs2lFAGrJnDKnfIa66wRVqsD4IFaUhAru7MJlZnDpqWky8R9e/naDYTWz8rStSWv
	 QlYc36w5ZE4dw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dKcbC3Drmz6v2f
	for <cocci@inria.fr>; Mon,  1 Dec 2025 09:32:23 +0100 (CET)
MIME-Version: 1.0
Date: Mon, 01 Dec 2025 08:32:23 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
In-Reply-To: <893abd46009f5e07e55f6b3f36645eda@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
 <29c204aa0f1f08074279425b7de42dd7@posteo.de>
 <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
 <ded004b275d73e35c46c3d30c057d58e@posteo.de>
 <e88c503c-b2a1-454b-a4a4-ae2dedd79daf@web.de>
 <893abd46009f5e07e55f6b3f36645eda@posteo.de>
Message-ID: <febfffa409763a47d12b330fa455c927@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3226
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/febfffa409763a47d12b330fa455c927%40posteo.de>

Am 30.11.2025 20:02 schrieb Tobias Deiminger:
>>> and then do 'type t =~ "syscall_define_t";' in the rule.
>> 
>> I would like to point out that mentioned implementation details can be 
>> refined.
>> I suggest to reconsider the need for the specification of an SmPL 
>> constraint
>> as a regular expression just for the selection of a single identifier.
> 
> Indeed, thanks! Selecting a specific type in the semantic patch didn't
> work on first try. Meanwhile I figured one needs to add a typedef to
> the meta declaration - then it works and I can avoid the regex.

Sadly, what I said above (adding typedef) only works when calling spatch 
for one specific .c file. It fails when using --dir to recursively scan 
the source tree.

What seems to happen with --dir and using the following rule

@r@
typedef syscall_define_t;
identifier fn;
@@
syscall_define_t fn(...) {...}

is that spatch filters .c files early by raw text search for 
"syscall_define_t", before it actually processes patterns. In my case, 
"syscall_define_t" is not written to .c, but to the built-in macro file. 
The raw text search in .c fails, and the .c file is wrongly filtered 
out.

To verify my hypothesis, simply adding a comment line "// 
syscall_define_t" to the .c file is enough to trick spatch into not 
skipping the file and applying the rule correctly.

This almost appears like a bug. Can you think of a workaround?

Tobias



