Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB5AD116F3
	for <cocci@archiver.kernel.org>; Mon,  1 Dec 2025 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2pspkEaaVORNDSsp0fCk+YTK6iHhZ0ptzQj1v0iOlGM=;
  b=bqlOzco+lO7a8ddcNX76a8QWoX+HSWlI474NaxPbUP5VQiVPLr2Df6sM
   5vabk6PVXib7GUze4p4Ug9H1Bu/PE09VZ6Mms8HrFTVaxD2eeKwmAdXKQ
   9MPKqc4BDDVRevnlaomo2O8y91qEUlosg9ifTWeqq2vxNVWcFfAekCeXL
   A=;
X-CSE-ConnectionGUID: hWyEPD8dSBmd0EAIAz1I/A==
X-CSE-MsgGUID: +2mxebFMQcizaPJTVJPRSQ==
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
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="252191184"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Dec 2025 17:53:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 497D1E0260; Mon,  1 Dec 2025 17:53:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4D2A0E0157
	for <cocci@sympa.inria.fr>; Mon,  1 Dec 2025 17:53:24 +0100 (CET)
X-CSE-ConnectionGUID: jxCCIwtSRYarpEXoYXu2aA==
X-CSE-MsgGUID: 5XFsoZMzS7e1RfItY2MsbA==
IronPort-SDR: 692dc803_oB7Dg98xvrZj1I4In3TiRRl+TlEgQFMRVN5fw+xD2bdJsml
 4525S+FqNrwzkw3ZbXAklZ1JJDhxh2uPzDXb+PQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F5BAC4xi1pg0EkQ7laHgEBCxIMQIFSghYogQJeMwcIS?=
 =?us-ascii?q?Y1QiHwRkgaNXiQPAQMBDT0SAgQBAQMBA4FMQIJ0AoxlAh8GAQQ1BQ0BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQE5Bw47hk8NgluBG?=
 =?us-ascii?q?xF0AQEBAQEBAQEBAQEBAQEiAgEBAQEBAQEBAQEBAR0CLF8BAQECATgCBgEBO?=
 =?us-ascii?q?A8LRlYhgiJYAYIiAignBwEMsz+BNIEBggwBAQbcJYFkAwaBS4VtgmUBhV6FC?=
 =?us-ascii?q?CcPgVVEhD8+gmEBgXY4hXeCJoEOhiSTLSwmeBwDWSwBDxE1ExcLBwWBIEMDg?=
 =?us-ascii?q?QsjSwUtHYEjIR0YE2A9F0CDSR0GZw8GgREZSQICAgUCQDqBZiIGHBICAwECA?=
 =?us-ascii?q?jpVDIF3AgIEghZ+ggoPiAaBCQUugQ0DCwdmPTcUGwYCAYE1lBFQgiiBQSBAf?=
 =?us-ascii?q?pNfkXihRTQHgjiBZ4FeBgyKLpVBEhwXl2CTC5kGjgiVJIYVggAigVxNJE+CZ?=
 =?us-ascii?q?08DGQ+OIRmEGlHEEkM1PAIHCwEBAwmFaROMIoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:H00c4K9GJIxij0AUnPluk+DRI+orL9Y04lQ7vn2ZLiYlFfBw9v
 re+MjzsCWftN9/Yh4dcLy7VpVoBEmslqKdgrN8AV7BZniChILAFugLhubfKn/bak/DH4VmtZ
 uIHZIeNOHN
X-Talos-CUID: 9a23:Z5sG520Uy7UAE7hjq0+ekrxfGNAOWVzC0EzqEkaiEUtZT4ylVAWZ0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AuxFaew7l2qwM+N5+jWBtu+Sxxow104q1D3Iog65?=
 =?us-ascii?q?ZtpC+Ow1sCm24lz6eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="132457639"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDF22YCjsDnL5PyxgYQH2vvr2nm394iDzm8eh/?=
 =?us-ascii?q?EI2zFR0ddtWfHX1Uv2dimK1EtYX1B1uE+2UYm4bmEnGrrdDEdQxmNe0L?=
 =?us-ascii?q?yx7ysdmxAM3rtICSQoTsxIWGHJ4nwn5IfEhSmFTLuSog0aZ3zjAvNGw1?=
 =?us-ascii?q?QoDmRMivRZNNyzbIlIdNwUKw=3D=3D?=
Received: from mout01.posteo.de ([185.67.36.65])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 17:53:24 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D30AC240027
	for <cocci@inria.fr>; Mon,  1 Dec 2025 17:53:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764608002; bh=2pspkEaaVORNDSsp0fCk+YTK6iHhZ0ptzQj1v0iOlGM=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=ITh27RBOoClH5jBgRVHmlHchDDZY7T5/zYj3EJEcqLqIIqaykX6axOl7rQTsR/n6b
	 kYf17Wj19qYuZZPslvsx4i7tKCOvc2q/khWsyeYaF67QBVPnnas456VHdPeZ7VNgRo
	 z/+KoHKeAHZca3uWw+MZJOgW2OFhXFhWXiv/YiqQhfW5HeBGXr0GnELt+ERR2ucXLd
	 XK2dC8mjZHhEpSVOGMAt61r/lS/GNLNNwvDdgOcZB67xL4TiI4r1vsNU8h7QA33eaM
	 ndSarbCpBxC8ONdOvjP1BiEWzTuql/N9lL7kcZJUXm1xEi0aMh3Hb9ZyxtuI6HMogz
	 cFcb34/xIfSbA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dKqjG2tMqz6ty9
	for <cocci@inria.fr>; Mon,  1 Dec 2025 17:53:22 +0100 (CET)
MIME-Version: 1.0
Date: Mon, 01 Dec 2025 16:53:22 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
In-Reply-To: <6bf5d8ea-5d04-4851-b464-19d2f76379f8@web.de>
References: <7bb043f9fd00c7e20ebc75353e697a51@posteo.de>
 <6bf5d8ea-5d04-4851-b464-19d2f76379f8@web.de>
Message-ID: <d842430fabc5cfbd805bdf6c8da82ec1@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Matching a specific declarer?
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3233
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/d842430fabc5cfbd805bdf6c8da82ec1%40posteo.de>

Am 01.12.2025 17:00 schrieb Markus Elfring:
> [...]
>> but actually stumbled upon the issue in a simpler case: I searched for 
>> all occurrences of DEVICE_ATTR_RO(attr) in the Linux kernel,
> 
> Will it become more interesting to clarify your own source code search
> approaches?

Sorry, not sure I understand the question. Is there anything I should 
do, or should avoid to do, or tell about?

If I manage to compile meaningful results until next week, I maybe add 
some words about the code search approach to my LPC talk:
https://lpc.events/event/19/contributions/2198/

>> but actually found every place where *any* macro was used to declare 
>> something.
> 
> Would you be looking for any better documentation also in this 
> application area?

You mean better Coccinelle documentation? I think it's ok. This list is 
very responsive and helpful, that more than compensates for gaps in 
documentation, if any. Also my use case is in the niche of a niche, so 
really not demanding anything.

>> PS: I'm using spatch 1.3 from Debian trixie.
> 
> It might become also interesting with which delay subsequent software
> tool revisions
> will be usable.

Which revisions of which tool do you mean?

Tobias
