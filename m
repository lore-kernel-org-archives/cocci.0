Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0446D116F3
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 10:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:message-id:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=iCBuMXPMprryxGGnly5C1OJVWdhPRgc1He5gZbodPcI=;
  b=m6Tm4lZgRaJo38rRvQpiEo0xyj8yNqSk5oSdjgFktEQmB47ldwhyh8Ba
   owZZ3r1XTnQcC6iln+Ms+ZWrRHgWo4JHonBhEpjUCn5w/OBeNNSr3Zm5H
   RtC61pADQSOvY+7nuBQlyOXLUlbljkNYxBWtC80TiTaFxaxiR5z06yNtA
   s=;
X-CSE-ConnectionGUID: 5elLQBy/QoG9RnbNEU2zSg==
X-CSE-MsgGUID: jFXuqQBQRaSx4RvsTCtWNQ==
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
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251880193"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 11:38:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7A9CCE01A8; Sat, 29 Nov 2025 11:38:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CF289E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 11:38:14 +0100 (CET)
X-CSE-ConnectionGUID: W8x2VqC2SiirDsP+EUTluw==
X-CSE-MsgGUID: vUlmPQ0KQeWkk1fjbY9TNQ==
IronPort-SDR: 692acd16_s+vmooxv9leeiUZrz+pEwrXccTxF2pVKpGy8gWb4QIzvLMF
 2kK1KDRLgwqcDGMeZ2QZNcjCENeXz1Hs9jac4Uw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HgBADkyyppe0IkQ7lagQmBUoI+gWAzBwhJjVCJDZIGj?=
 =?us-ascii?q?gIPAQMBDU8CBAEBAwSBTIM0jGcCHwYBBDUFDQECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQEiIA47hk8NgluBLIEmAQEBAQEBAQEBAQEBH?=
 =?us-ascii?q?QIsP14CBgEBOIFXhR0CTwcBsRCBNIEBggwBAQaCaNk9gWQJgUuFbYJlAYVeh?=
 =?us-ascii?q?S8PgVVEhA6FRziFd4ImgQ6ZViyBHhwDWSwBDxE1ExcLBwWBYwOBCzI8Mh2BI?=
 =?us-ascii?q?z4YcT1Xg0kjZw8GgRGDT4kXD4pUAwsHZj03FBsGAgGBNZQSUIIohDijCIE2o?=
 =?us-ascii?q?UU0B4I4gWcFgVkGDJ9vEhwXl2CTC5kGqUGCACIugS5NJIM2TwMZD5JUxFtDN?=
 =?us-ascii?q?TwCBwsBAQMJhWkTjCKBSwEB?=
IronPort-PHdr: A9a23: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
 hMxzAdzM71FyQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:u840rqnQE/rmKdwQJB5cmK6oMVzpDfIx3DAbv31ZSRFFG/Fw8P
 re+cjztCWE6gr5PUtLpTnuAsa9qB/nm6KdgrN8AV7BZniEhILAFugLhubfKlbbexEWmNQ96Z
 td
X-Talos-CUID: 9a23:RyJTNG+rzrRHdL2AgjKVv3FECpoba1aH93bROWOjMSVEdYGRVEDFrQ==
X-Talos-MUID: 9a23:SRLjvQlSDi1FuhE59Mfgdnp8CcNt2532K3kArpYF4seGPx0hBxGk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="132275658"
X-MGA-submission: =?us-ascii?q?MDGwM4eARG5dfsFR7YC9gbbKquyujeHFNmmte0?=
 =?us-ascii?q?NjjfQVXIfF7eo9fNOYEa2yM8j0P5l+YHKRKCEisc0vFUWP7waQeyLkhH?=
 =?us-ascii?q?4PD3n/wLh0LfDQFN+bai16j/hB/3yPZGA5kTgM16+ckdjOpW81gP68ZN?=
 =?us-ascii?q?TMbpqpNWFcySc61m4FTBIOFg=3D=3D?=
Received: from mout02.posteo.de ([185.67.36.66])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 11:38:15 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C931E240101
	for <cocci@inria.fr>; Sat, 29 Nov 2025 11:38:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764412692; bh=iCBuMXPMprryxGGnly5C1OJVWdhPRgc1He5gZbodPcI=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=ipMAH49x+hh+fPzdrF3x1sRFzPHI5D4IYYYrEkmTRQaqqYlWJlsb1G0v7nzqWV2wW
	 6+izknfemfRLGV3P4jAi1/KSVe/Ha0UJr5ivJMhUgY2+QEo/NlomWG2n42fs2TZH1V
	 aNJp2mj5tlpO9D3MsVcwPEKjLGJdA7JrBEkcypYXLV1bI3RFNylezwIc3jr9Pcfevk
	 Z6IXNLAzYNIKabK5lvIbAHnvSjpQ7AK21KAYgnGREF5qnWPExAzgCUXf2MIw4smvfC
	 w3Li2W6ks6NebzvguqfXwmtHKD2WPrLZAVf1rewtz0/Gtw+v2Yd2ZUQlFvRlF5hzFw
	 6/CgB9qI7kNRQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dJRTJ3R6Fz9rxD
	for <cocci@inria.fr>; Sat, 29 Nov 2025 11:38:12 +0100 (CET)
MIME-Version: 1.0
Date: Sat, 29 Nov 2025 10:38:12 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
Message-ID: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3203
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/4f6e259891de0666aa1fa10b810a5dd3%40posteo.de>

Hi,

my newbie assumption was we could match the following by macro name

   // my.c
   SYSCALL_DEFINE0(foo_bar) { return; }

using this rules

   // my.cocci
   @r@
   identifier fn =~ "SYSCALL_DEFINE[0-6]+";
   position p;
   @@
   fn@p(...) {...}

   @script:python@
   fn << r.fn;
   p << r.p;
   @@
   print(f"match: {fn} at line {p[0].current_element_line}")


Turns out, SYSCALL_DEFINE0 is a "known macro" from 
/usr/lib/coccinelle/standard.h. In this case coccinelle seems to match 
an identifier on the expanded function name, not the macro name. I.e., 
this would work:

   identifier fn =~ "foo.*";

But I really want to search all syscalls by the conventional macro 
names, i.e. search for SYSCALL_DEFINE[0-6]+. How to do that?

Tobias
