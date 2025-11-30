Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC03D111A8
	for <cocci@archiver.kernel.org>; Sun, 30 Nov 2025 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=crC1h8xA++BEhDLCCxp1qE2h3waiulvDN8k8GiVtg6g=;
  b=WaaVs6dzVcacfACX6GXKlzLQtefDZd6FT4OTP/5i7QPdXj0Z2R+Z1hHS
   bKNJwaRYKI2gWzqTDgg49B1Y6CbPAQaPt5w+pgluzMOOIjCRC+rGP8Pu4
   jpDCYwUKInHUpSo1Wg/bMab754SgzsgP5WjdUBP8UZFvmpW9ZD6xdWsX5
   U=;
X-CSE-ConnectionGUID: oXAyni64TN2xOFRSYhwviw==
X-CSE-MsgGUID: wtykKKA+TB6s3DnNUEn3KQ==
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
X-IronPort-AV: E=Sophos;i="6.20,239,1758578400"; 
   d="scan'208";a="251964440"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Nov 2025 20:02:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C6ADCE0260; Sun, 30 Nov 2025 20:02:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7BFE1E0157
	for <cocci@sympa.inria.fr>; Sun, 30 Nov 2025 20:02:39 +0100 (CET)
X-CSE-ConnectionGUID: TEpF/w9TQO6wq+273WXjpw==
X-CSE-MsgGUID: LEV3kXfeRGOgWtzWD/SYzA==
IronPort-SDR: 692c94ce_M01nsJKMrfMAG/Vp7pj4ZKDoQjfWX3euS7n9wRfDvDBRK5J
 2latfavR7cGEaUlTJ+DC69y9Wd5KpFizTUY+JhQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FmAwAvlCxpe0IkQ7laHgEBCxIMQINoKIECXjMHCEmNU?=
 =?us-ascii?q?Ih5AxGeHYFrDwEDAQ09EgIEAQEDAQOBTECCdAKMZQIfBgEENBMBAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBIiAOO4ZPDYJbgRsRdAEBA?=
 =?us-ascii?q?QEBAQEBAQIBAQEiAgEBAQEBAQEBAQEBAR0CLF8BAQECATgCBgEBJgoIDwstG?=
 =?us-ascii?q?VYhgiJZgiICKCcHAQyxYYE0gQGCDAEBBtwlgWQDBoFKhW6CZQGFXoUIJw+BV?=
 =?us-ascii?q?USEDjE+gmEBgRpcKoYFgiaBDoYkkzMsJngcA1ksAQ9GExcLBwWBIEMDgQsjD?=
 =?us-ascii?q?zwFLR2BIyEdGBNgPRdAg0kdBmgPBoERGUkCAgIFAkA6gWYiBhwSAgMBAgI6V?=
 =?us-ascii?q?QyBdwICBIIWfoIKD4gLgQkFLoENAwsHZj03FBsGAgGBNZQUUIM0NYIfHwogD?=
 =?us-ascii?q?5JGFJAugTahRTQHgjiBZ4FeBgyKLpVBEhwXhASNE4ZJkwuZBo4IlSRAhVWBf?=
 =?us-ascii?q?yMugS5NJIM2TwMZD44hDBYcg3VRxDJDNTwCBwsBAQMJhWkTjCKBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Xd1hOqny8huUOVREXZmKWxZveEvpDfIl3DAbv31ZSRFFG/Fw8P
 re+8jztCWE7Ar5PUtLpTnuAsa9qB/nm6KdpLNhXotKPzOLhILLFvAG0WKK+VSJcEDDH6xmpM
 VdmsNFaOEYY2IasfrH
X-Talos-CUID: =?us-ascii?q?9a23=3AqdssS2hDU3Js9DNIlrWLdNZvBzJuTlDF4jDPcnO?=
 =?us-ascii?q?BLjh2Uf7PFgSvyKF8jJ87?=
X-Talos-MUID: 9a23:ByrbNggaaHsqxjp5wY3weMMpEOpWuKeeBk03vrIJhNWWCgA3AAaPpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,239,1758578400"; 
   d="scan'208";a="132334083"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDHA/BVX8DSPWkTTlVMUAvHi4khDzK/SGxCeX0?=
 =?us-ascii?q?0s/JSGDw1QN/R/69Kn3TjfMGSmEe37E1wSwiEh5cZCy1BgCWUxTSBcAC?=
 =?us-ascii?q?vHam90DVm+WsUUe+UiMk24ECyfI6WiKrG91deCL8xxPWLk5N4w/lI70r?=
 =?us-ascii?q?VaN0+TgyTm10702kK3EMgFjA=3D=3D?=
Received: from mout02.posteo.de ([185.67.36.66])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 20:02:38 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3F1DA240101
	for <cocci@inria.fr>; Sun, 30 Nov 2025 20:02:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764529357; bh=crC1h8xA++BEhDLCCxp1qE2h3waiulvDN8k8GiVtg6g=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=IVDi2pMWlDw7MMdH3rMsxK6KxT0PCp/C7XvEQ3FzlIlP1zKYkB8vudrlE9WEsG971
	 UxdfNYNvjQaR91OaMLT7GphHWLtIXpqV0DiIJKpZMpG1Tzq/uBUgqMaqemWJPjR2ry
	 BQvZe5XDuiN3JFrWPlLCx9695bMkb3PP0ORElYhPJq8Qjm4Pb8+9slAutt3qmZ+A8/
	 HXQuDm5cYTkcbwsdzOVtbC2NhCLvPitk9bqCIehuVqXKkDn7hfsxIupHWigl3RlX5E
	 6s3rVYz5xgME+Kjlty1D1eyX0dol7jqht5FhfCVqK2+oS0kiKPNtxvEnW7fQvH03+h
	 wTk1AzcjIxdOQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dKGcr6k0jz9rxG
	for <cocci@inria.fr>; Sun, 30 Nov 2025 20:02:36 +0100 (CET)
MIME-Version: 1.0
Date: Sun, 30 Nov 2025 19:02:37 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
In-Reply-To: <e88c503c-b2a1-454b-a4a4-ae2dedd79daf@web.de>
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
Message-ID: <893abd46009f5e07e55f6b3f36645eda@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3225
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/893abd46009f5e07e55f6b3f36645eda%40posteo.de>

Hi,

Am 30.11.2025 09:05 schrieb Markus Elfring:
>> What also works is to fake the return type to syscall_define_t in 
>> standard.h,
> 
> I became curious if such observations can be clarified further.

I observed this while looking for standard.h modifications that avoid 
numbering 1..6 in the 12 macro variants, so that there can be 1 simple 
common rule for all 12 variants.

 From Julia's example I found by trial that macro name and first 
parameter must have same name, otherwise it wouldn't work:

   // standard.h, try either 1st or 2nd line
   #define SYSCALL_DEFINE1(func, t1, a1) int func(int SYSCALL_DEFINE1, t1 
a1)  // works
   #define SYSCALL_DEFINE1(func, t1, a1) int func(int SYSCALL_DEFINE, t1 
a1)  // doesn't work (rule adjusted, or course)

Can you explain why the 2nd doesn't work? Looks like if there was some 
conventional relation between macro name and first parameter.

>> and then do 'type t =~ "syscall_define_t";' in the rule.
> 
> I would like to point out that mentioned implementation details can be 
> refined.
> I suggest to reconsider the need for the specification of an SmPL 
> constraint
> as a regular expression just for the selection of a single identifier.

Indeed, thanks! Selecting a specific type in the semantic patch didn't 
work on first try. Meanwhile I figured one needs to add a typedef to the 
meta declaration - then it works and I can avoid the regex.

>> But as said, I'm not in a position to make such suggestions
> 
> Please reconsider such a view once more.

So far I think Coccinelle is an amazing tool.

Macro handling maybe was a bit surprising, quoting Julia: "Coccinelle 
expands macros when it has them available and when it is not able to 
parse the code without doing the expansion". As a user I have to know if 
a macro will be expanded or not, since match patterns have to look 
different accordingly. But the exact conditions for expansion are not 
too easy to anticipate.

>> and believe I understand how it's not well suited if the engine is 
>> designed to match on the AST.
> 
> The understanding is still improvable.
> Various development challenges are involved.
> 
> 
>> *) There's an ongoing effort to add testable code expectations / 
>> requirements to important functions in the Linux kernel [1].
> 
> Thanks for such background information.
> 
> Linux Plumbers Conference
> Adding Testable Code Specifications in the Linux Kernel
> https://lpc.events/event/19/contributions/2085/
> 
> 
>> I'm involved, and one thing that IMO would help is if we could 
>> quantify what "important" exactly means, i.e. how many functions are 
>> to be documented (100? 10000? 1000000?), and where exactly are they.
> 
> Software documentation is also a known challenging topic.
> 
> Special constraints can become more interesting when even macro 
> definitions
> need to be taken better into account.
> 
> 
>> Raw grep is obviously not well suited. Coccinelle is already used for 
>> similar tasks, so it's an obvious candidate. tree-sitter queries could 
>> also work.
> 
> There are promising software tools available.

Probably :) Do you have other suggestions?

Tobias
