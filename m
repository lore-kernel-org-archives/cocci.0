Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4E3C4332F
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YDGlD+MzjSU/m+SnQFFIB8QoqkK4S4OrTcEntSeBQis=;
  b=YQItZ5CyWLyJSJFXry4uc/KBpthuNx5Uh0xmQQCKj0P5NTEB2Ag4MH9J
   TF5CeL7eE4TC/T1ILsWHz+4xLy34+Y49n4i/CJKa9E+y0TnNb2uRQm1iO
   HUhUFeNnoixum2ucoxkcxZVwhKm+E+7UGfe6jQPVNx868sC40CF5eeFB2
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81594850"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 14:48:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DB012E0269; Sun,  4 Dec 2022 14:48:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E2D04E013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 14:48:28 +0100 (CET)
IronPort-SDR: 638ca52c_hiT/AsPVnVduL1CmN6MAPFrF51p5hnfunI9CRSk1gIRf4uu
 eYBBYiTtJ3bMoFEHUoKbb5U4v2UTcRH5BmOvL4g==
X-IPAS-Result: =?us-ascii?q?A0GLAQCJo4xjmBOg6VVagQmBT4ItgQVWLgcIRYRPg0+NU?=
 =?us-ascii?q?J01gX4PAQMBDTUPBAEBBAOCC4JzAoUPAh4GAQQyBw4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBAEBAhABAQEBAQEBARUJGQUOEAUihWgNgjUiggQsD?=
 =?us-ascii?q?VJ4AQICASMVNhsLGgImAgJXEwgBAYJ6AYJ/IwMErmWBMoEBgxacQYFhBoEUL?=
 =?us-ascii?q?JEYFxAWBoINgTwMA4J0PoURgwqCZwSWd2IlBA4DGSsdQAIBC20KQzUJAhFMK?=
 =?us-ascii?q?xwbB4EMKigVAwQEAwIGEwMiAg0oMRQEKRMNKydvCQIDImEFAwMEKCwDCUAHF?=
 =?us-ascii?q?REkPAdWNwEEAwIPIDgGAwkDAiJUcwIuERUFAwsVJQgFSQQIOQUGUxICChEDE?=
 =?us-ascii?q?g8GJkUOSD45FgYncg4OEwNdgWkEM4F7XZhUg1oggSWBNaItoBqDc4tRlHQGD?=
 =?us-ascii?q?wQug2WTCxSSFpc/p3qBaQ0mgVxNNAQ7gmdPAxkPjjmDWYpeQTQ7AgcLAQEDC?=
 =?us-ascii?q?YofAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:Ejv96aMTKxh+f8BcTsKjsMiBIKoaSvp037BZ7SFMoHtuA6qlfq
 GV7ZMmPHDP5Qr5NEtQ++xofZPwJU80lqQY3WByB92ftdndyQ6VxehZhOOI/9SjIVycygc378
 ldmsZFaOEYQWIUsfrH
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="41670091"
X-MGA-submission: =?us-ascii?q?MDFOTlvUkGRDHmwl5zLF/v1FLsOWfNtDKFUY6/?=
 =?us-ascii?q?JnZqzMhrfDVXwdDCXvBtNYvLySRapU7RnrmPp6m/QqP4QsVpvq3VvgsU?=
 =?us-ascii?q?zUndhQgksEuqWJHKJcDSsavaFtbnPFxN/Yqh+fD4udq5jNhjjMxy/AYV?=
 =?us-ascii?q?aG018+NIUQ8eEBwz+G0cjVng=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 14:48:29 +0100
Received: from [152.37.86.21] (helo=[192.168.1.100])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1p1pM3-0007op-4K
	for cocci@inria.fr;
	Sun, 04 Dec 2022 13:48:27 +0000
Message-ID: <414c04de-1014-d41d-dfb6-774a8666f22e@knosof.co.uk>
Date: Sun, 4 Dec 2022 13:48:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: cocci@inria.fr
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
 <alpine.DEB.2.22.394.2212040832050.3337@hadrien>
 <b404ba8b-df56-1f22-c0c4-a3d3be6aea30@web.de>
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <b404ba8b-df56-1f22-c0c4-a3d3be6aea30@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Clarification for SmPL search techniques
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 766
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/414c04de-1014-d41d-dfb6-774a8666f22e%40knosof.co.uk>

Markus,

>>> I' having the usual problem that occurs when using Coccinelle
>>> after a long time away, I cannot find the example I need
> 
> Would you get any further development ideas from information in mailing list archives
> or issue trackers?> 

The problem is that a lot of information is duplicated.

I'm probably going to be using Coccinelle a lot next year,
and will write a verbose cheat sheet of ideas (as much for
me as anyone else).

I think a lot more people would use Coccinelle if it had
more documentation.

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com
