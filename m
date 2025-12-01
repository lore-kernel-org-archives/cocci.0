Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986E4D116F3
	for <cocci@archiver.kernel.org>; Mon,  1 Dec 2025 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pUlRExZepxjSGHh/il1QsR95kmdMiDs5qalj6YwmbG0=;
  b=Bb/97ns5h7+VjoM5qUKEh27ZohPpQ2tygz1zYSkxkYOtrWNWO8fkTsMa
   amqZXil7jHeCe1L0YiLAFWOlj4T3vqZeSA9xX3D8GOOelzOstrS3EOEm7
   37tiQKoU81BSmxnogT1UncTu1yrnaCkuUMbIIh2n5xVZKDE5aGC4SBsWt
   c=;
X-CSE-ConnectionGUID: 1tjv8rmVSjKbnPasrxtJ0g==
X-CSE-MsgGUID: bMc21ABXRwCn/VYn6EpBKw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@posteo.de
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="252183562"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Dec 2025 17:18:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 89715E0AF6; Mon,  1 Dec 2025 17:18:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B4E6AE0157
	for <cocci@sympa.inria.fr>; Mon,  1 Dec 2025 17:18:50 +0100 (CET)
X-CSE-ConnectionGUID: 7CyK3P+pR0WJXU8GeNBCOg==
X-CSE-MsgGUID: jb0NvxUsSO69ypYyO+M4+Q==
IronPort-SDR: 692dbfea_ucA+1XfGBd2FwranYYB9yNcEZqY04gtZ2+dd27ILC9sexjk
 ECXpr27AHV7T9MsQgWCXJzYJPgsPTNS7wFvhO7Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EQCgAbvy1pe0IkQ7laHgEBCxIMQIFSgj6BYDMHCEmNU?=
 =?us-ascii?q?IkNkgaMBIF+DwEDAQ1PAgQBAQMEgUyDNAKMZQIfBgEENgQNAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAUIOO4ZPDYJbgSyBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CLD8BHwIBAzgCBgEBOA8LRlYhhR0CTwcBs0uBNIEBggwBAQaCa?=
 =?us-ascii?q?Nk8gWQJgUuFbYJlAYpmJw+BVUSEDjE+hFg4hXeCJoEOhiSLaodDLCZ4HANZL?=
 =?us-ascii?q?AEPETUTFwsHBYEgQwOBCyMPPAUtHYEjIR0YE2A9F0CDSR0GZw8GgREZSQICA?=
 =?us-ascii?q?gUCQDqBZiIGHBICAwECAjpVDIF3AgIEghZ+ggoPiAaBCQUugQ0DCwdmPTcUG?=
 =?us-ascii?q?wYCAYE1lBFQqWiBNoxilGM0B4I4gWeBXgYMn28SHBeDcQGTbpMLmQapQYICA?=
 =?us-ascii?q?x2BXE0kgzZPAxkPjiGEM8RkQzU8AgcLAQEDCYVpE4wigUsBAQ?=
IronPort-PHdr: A9a23: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
 QI7jU1ybLZ1nAo=
IronPort-Data: A9a23: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
 RzyOpE9A/Rp/qxUeA==
IronPort-HdrOrdr: A9a23:+RvfOKoBkG1fS/KuUBFaG1YaV5oieYIsimQD101hICG9Ffbo8P
 xG/c5rsSMc7Qx6ZJhOo7+90cW7L080sKQFgrX5Xo3PYOCFghrMEGgK1+KLqFDd8m/Fh4xgPM
 xbE5SWZueQMWRH
X-Talos-CUID: 9a23:BvNCT29Dt2d5gwS91TuVvxE/C+N+Sj7F9i/vAX+FWUlkbpe+blDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AnSx52g7IA2aaysb5JbT71QzVxoxq6fyIFlAwiq4?=
 =?us-ascii?q?h5ZiVLR1hHHS40HeOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="252183476"
X-MGA-submission: =?us-ascii?q?MDGCNKCtEnJMkvgdJUVaJZx/G7JTnsaLszKglg?=
 =?us-ascii?q?lVsiPaS9gOxSCmMvuHTnOHG8WAdu23/shyFiAtV3XDZzlgBBowXWNjZk?=
 =?us-ascii?q?E2ocLdNnnT0fp1A0B0RTzxwABe6hk11k485C8xeMUFR2uF5nkj6qAbel?=
 =?us-ascii?q?jSjEqI+DkFbXz1Iqr3jTxgjg=3D=3D?=
Received: from mout02.posteo.de ([185.67.36.66])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 17:18:50 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 8CF37240101
	for <cocci@inria.fr>; Mon,  1 Dec 2025 17:18:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764605929; bh=pUlRExZepxjSGHh/il1QsR95kmdMiDs5qalj6YwmbG0=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=FTAt/TUljuasHDj7ufsOFsKlME7cSFJcSxGLYj/4Ozgtxm54Rt+W0X1hhn323SgMM
	 P4IyHKPnlKNPodlFLRP4GkldRA5YKFK1k6bVQ15KiuRv2J3GLFabTePR1WKtM2QGmj
	 JAOg1XRvGJxSHbQw/ods+Pg7doxWRx/8bqMlE5cZQ0eSA32S/h6/EK0VFRbf5GqKaJ
	 SuAh9Jbr+UInKuWe88rUxDoB2NJS39EpQEOZAhZuwfMYetjwOtXJ2U61vER7JZwutQ
	 5K44ttQVfSi83opk0iqTXnwO5341QVGM6sBvHSjVi6r/HFlAHbVIv3eyeEpV3ETuDe
	 32pRqb9ogOL5g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dKpxP16pHz6twB
	for <cocci@inria.fr>; Mon,  1 Dec 2025 17:18:49 +0100 (CET)
MIME-Version: 1.0
Date: Mon, 01 Dec 2025 16:18:49 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
In-Reply-To: <5013c5b-d899-bd2d-520-f3216077fc@inria.fr>
References: <7bb043f9fd00c7e20ebc75353e697a51@posteo.de>
 <5013c5b-d899-bd2d-520-f3216077fc@inria.fr>
Message-ID: <7b05bb0f9d61a639c9aa6b4d728f2090@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] bug: Matching a specific declarer actually matches any
 declarer
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3232
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/7b05bb0f9d61a639c9aa6b4d728f2090%40posteo.de>

Am 01.12.2025 16:35 schrieb Julia Lawall:
> On Mon, 1 Dec 2025, Tobias Deiminger wrote:
[...]
>> // mutex2.cocci
>> @def@
>> declarer DEFINE_MUTEX;
> 
> This should be declarer name, not declarer.  Declarer matches any 
> declarer
> name.

That works => not a bug.

Thanks a lot.

Tobias
