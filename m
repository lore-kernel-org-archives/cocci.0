Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8E4D10374
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 21:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cy+8j0KiIhoKqAngrks4s9EWxnRUpW7WR+jRA4REG34=;
  b=M1nrl99ActL4LaC2LmD06WA/nk01kigNCraxyfNA2f3ySbpIUchUqYVc
   oGYm4E28RcVXrZSa0YpHqnyabIPo7TdglL0oJmxvYWAiG6JKKf/dkHYhA
   oat1q5Slw9to8HiSJqGR7a/HL29HZfmLO+flBJWfE5jpQtJc0ZJH3uDCQ
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.11,230,1725314400"; 
   d="scan'208";a="190627785"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 23:04:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 734E5E0D1D; Thu, 24 Oct 2024 23:04:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F029EE0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 23:04:02 +0200 (CEST)
IronPort-SDR: 671ab642_S+qGH1JxQGz5FNW5fGHu0oRP3lBl12az/2nXIuaJVXOs6rw
 TCNmL7rhyMerASsYLrCK9irhAasCNUaJwiMbxFg==
X-IPAS-Result: =?us-ascii?q?A0FsBQCYtRpn/xOg6VVagQmEFwd2WjMHCEiEVoNPjiKgE?=
 =?us-ascii?q?g8BAwENOwkEAQEDAQOCDIJ0AoonAh8GAQRHAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAoEKCAuFNUYNgls7ghYsDX4BAQECASMVRgsLGgImAgJWG?=
 =?us-ascii?q?wEBgn0BgkEjAwQNsEeBMoEBgxzbF4FmBoEahhiCYgGKYBcQFQaCDYE8CwOCP?=
 =?us-ascii?q?Tg+gmEBgi6DDoJpBJIFi2oliS+SXlJ7HANZIQIRAVUTFwsJBYk1CoMcgW4mh?=
 =?us-ascii?q?BGBMxIBg1+BZwlhiEKBDIE+gVkBgzhKg0yBYQU4SYJNak43Ag0CN4IkgQCCT?=
 =?us-ascii?q?4ElBAWDPIF2HUACAQttPTUJCxtDrCkBgVlHhCB7pgWhaYQkjBaVLgYPBC+Dc?=
 =?us-ascii?q?gGTTRSSeJh3jX2bI4IkgUERB000BIJuAQEyUgsOD44tFoNYyktCNTsCBwsBA?=
 =?us-ascii?q?QMJknWBSwEB?=
IronPort-PHdr: A9a23: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
 iDV6MNt8QjOrw==
IronPort-Data: A9a23:Kc6gZqs5wwlVcEumIKnTMaljnOfnVGNfMUV32f8akzHdYApBsoF/q
 tZmKWHQPPqKYGv9eNlzbo6/8UgEvMWAndBmSQFvqywzFisTgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNsspvlDs15K6u4WtC4gRlDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJEwTGqY51NZxPU516
 OxJMQsXV06EiNvjldpXSsE07igiBNLuIJtZunZ70SqfBvFgXJOrr6fitYIehmxrwJkQRbCHN
 qL1ahI3BPjESxFCIFoUIJE4m/yviD/0dHtFqzp5oIJusjCNllMugOCF3Nz9WPCpFJR8rGih/
 EGc/3/yARMra9PA8G/Qmp6rrqqV9c/hY6oZE7az99ZxkViLzyoSDgcXXB21u5GEZlWWQNdDM
 woU/TEytu458wq2TbERQiGFnZJNhTZEM/I4LgHwwFjlJgf8um512kBsov99hN0aWAseXjk2z
 hmJmMj1Hnpkt/uIShpxM5+K+CiqN3F9wXAqPEc5ockturEPY73fSjrMSNF4F6DzhdqzBDKYL
 /Wisn0ln7tK5SIU//zTwL0E6g5AYrDKSAku4QuRVWXj8wARiEtJoWC3wQCz0Mus57p1grVMU
 LboViReAC0z4UmxqRGw
IronPort-HdrOrdr: A9a23:OKKCx6tNMvxWnp7UqwgtImzV7skDddV00zEX/kB9WHVpm7+j5q
 OTdZMgpHnJYVcqKRYdcL+7VZVoLUmsl6KdpLNhWYtKPzOLhILLFutfBFvZsljd8kTFn4Y36U
 4jSchD4bbLY2SS4/ya3OD1Kbkd/OU=
X-Talos-CUID: 9a23:rpwXPmDb16dk0N36EyRC02U1NPAjTlLm0WeBOnSiMDhuR4TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AFHCpGQ8jVjXlztntfdSFR6SQf+VEwPX/IXIjqM8?=
 =?us-ascii?q?l4cmfPi9yCmiS0w3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,230,1725314400"; 
   d="scan'208";a="190627780"
X-MGA-submission: =?us-ascii?q?MDFL6MTbB8dcdw6Ag6Rb+h/j4jxBgvSrYr9MCC?=
 =?us-ascii?q?xw9eQoXMTqUS13rXNJgr728FYAr+Ht3XEFciukxByGOKLnly49cQElqT?=
 =?us-ascii?q?oTykcCXgimfi1NdGRiuncLcDuapl92F3fT4c9xGjvIapHJpb4oRDZJZD?=
 =?us-ascii?q?Sh8mSX1uMQv94IaKP3SPdt9w=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 23:04:00 +0200
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1t44zn-000000001qZ-86RS
	for cocci@inria.fr;
	Thu, 24 Oct 2024 22:03:52 +0100
Message-ID: <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
Date: Thu, 24 Oct 2024 22:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1936
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/d32d5bc4-3299-4977-bb0a-a3b0a53c829e%40knosof.co.uk>

Markus,

> Which analysis goals did you try to achieve by extracting source code
> position information from function implementations?

An example
https://shape-of-code.com/2024/10/13/if-statement-conditions-some-basic-measurements/

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

