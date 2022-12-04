Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FA1C4332F
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=55MVdTeY2tTSnNzWs9tvie3UpWs/8YZbG5DmXEqU6Es=;
  b=pqnNGYMGLqOoHYzy3jm9rtI590OtZUYFBvbTP+wAb2Dl7Nvn2Ny68SNa
   dkYzgJgcZUEJyHlYZW3453r9HZYU62Xjzh0hQMyai/Gzwbn6kc0wngZkB
   k79HBpdj/J+6y5stJgL+kyCfEFitLplTogwQilAYT7cUnm5mGon+lV2CV
   4=;
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
   d="scan'208";a="81594362"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 14:40:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EA537E0269; Sun,  4 Dec 2022 14:40:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CF1D8E013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 14:40:13 +0100 (CET)
IronPort-SDR: 638ca33d_szZJQ6aohJ1HIQ9eXYBste8jfAudYlXMfNnBng6EOYRtZ3A
 hnKzCf6YAOI53pXpQ/C+TtenEyPw9gtT2jxruHg==
X-IPAS-Result: =?us-ascii?q?A0HZAQCVooxjmBOg6VVagQmDfIEFVi4HCEWET4NPjVCfM?=
 =?us-ascii?q?w8BAwENNQ8EAQEEA4ILgnMChQ8CHgYBBDQTAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBAQIQAQEBAQEBAQEVCRkFDhAFIoVoDYI1IoIELA1SeAECA?=
 =?us-ascii?q?gEjFUYLCxoCJgICVxMIAQGCegGCfyMDBK5lgTKBAYMWnEGBYQaBFCyRGBcQF?=
 =?us-ascii?q?gaCDYE8D4J0PoURgwqCZwSWd2IlBA4DGSsdQAIBC20KQzUJAhFMEBscGweBD?=
 =?us-ascii?q?CooFQMEBAMCBhMDIgINKDEUBCkTDSsnbwkCAyJhBQMDBCgsAwlABxURJDwHV?=
 =?us-ascii?q?jcBBAMCDyA4BgMJAwIiVHMCLhEVBQMLFSUIBUkECDkFBlMSAgoRAxIPBiZFD?=
 =?us-ascii?q?kg+ORYGJ3IODhMDXYFpBDOBe12YVINapSegGoNzi1GUdAYPBC6DZQGTChSSF?=
 =?us-ascii?q?pc/p3qBeSOBXE00BIMiTwMZD44sDQmDUIpeQTQ7AgcLAQEDCYofAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:SrtV96u1Y6zWbvIBTS7Hv3mU7skDddV00zEX/kB9WHVpm7+j9v
 xG+85rsyMc6QxhP03I9ursBEDtewK/yXcx2/h0AV7AZmXbUQmTRr2KPbGSpgEIcheWnoVgPO
 VbAstD4bbLY2SS4/yb3OD1Kbkd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81594356"
X-MGA-submission: =?us-ascii?q?MDG/EzuHFWdE/YAYoaqKQoLE6aliOGOcVmtv/F?=
 =?us-ascii?q?ft+1u7TGlwldRflj7oAkA6R0RP9L/gVWE9TkFD5BJ3gO7zDMRbyHWcF2?=
 =?us-ascii?q?8K62ZgFWMFUlPlScAZEYyfH2Ny2vSNFrh7cmv9qfvb7voLHLMj7qSrAy?=
 =?us-ascii?q?1crWMQHYRyhw2dcAz/s0dv5Q=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 14:40:12 +0100
Received: from [152.37.86.21] (helo=[192.168.1.100])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1p1pE4-0005ky-B0
	for cocci@inria.fr;
	Sun, 04 Dec 2022 13:40:12 +0000
Message-ID: <4145c1bd-ae8f-fe91-9f52-676b2ea9e857@knosof.co.uk>
Date: Sun, 4 Dec 2022 13:40:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: cocci@inria.fr
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
 <alpine.DEB.2.22.394.2212040832050.3337@hadrien>
 <e9d8231c-9b98-6603-4786-7b61809af4d0@knosof.co.uk>
 <alpine.DEB.2.22.394.2212041426120.3337@hadrien>
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <alpine.DEB.2.22.394.2212041426120.3337@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Searching for ++ of volatile variables
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 765
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/4145c1bd-ae8f-fe91-9f52-676b2ea9e857%40knosof.co.uk>

Julia,

> Maybe
> 
> type t;
> volatile t V_1;
> 
> Not sure if it works.

It works as we hoped it did :-)


-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com
