Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38ACD44167
	for <cocci@archiver.kernel.org>; Tue, 19 Nov 2024 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZqtqMv32N0DHX1oumDF8VGDZNe7RcisLvNhaecb/UCI=;
  b=ZzWA5+hbA3TLATxvpsgHkYYNvrkpcA7CecWwiI4SeSVngkCcJE3CHf2C
   Kffw9/stIr+JSpsiLmM6KsHb8D26D8jEj0/GY0LrjMkbIN3+UEJh1eiTj
   PwlVEc7dXXqI+G/kbfUA5OuL6mDQzar6x+1II/QB4OmK+sDVr3c4zgrzp
   0=;
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
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194715550"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Nov 2024 16:34:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DF56BE0D1D; Tue, 19 Nov 2024 16:34:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B41FDE00B7
	for <cocci@sympa.inria.fr>; Tue, 19 Nov 2024 16:34:43 +0100 (CET)
IronPort-SDR: 673cb012_V22WE9eXnDHZduFIPqCvbeDuos4BLWnSKsFI5jpfHdatr76
 sDWQldslo3o/z6hWP7KUgrE1R4XSgUYE16hDKfw==
X-IPAS-Result: =?us-ascii?q?A0GpAQBGrzxnjhOg6VVagQmBU4JEfVozBwhIhFaDT44fA?=
 =?us-ascii?q?54rgWoPAQMBDTUPBAEBAwEDggyCdAKKUAIfBgEEMwYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABAQEBAQE5BQ47hXsNgls7ghYsDX0BAQEBA?=
 =?us-ascii?q?gEjDwEFRgsLGAICJgICVhsBAYJ9AYJBIwMEsSF6gTKBAYMc2xeBZwaBGi6Fa?=
 =?us-ascii?q?oJiAYVZhQcXEBUGgg2BPAsDgnU+hAUJARIBboMOgmkEgkGFDyWIF2iaHVJ7H?=
 =?us-ascii?q?ANZIREBVRMXCwcFgSkhLAOCR3+BNoFRAYMQSoMugV4FN0mCSmlLNwINAjaCJ?=
 =?us-ascii?q?H2CT4ElBAWDaYELg2GEXoQjHUACAQttPTUJCxtDoBZHgy8IDYEsIALIWoQkj?=
 =?us-ascii?q?BaVMgYPBC+XQBSSeph3o3KFNTWBSCRscE00BIMiTwMZD44tDQmDWMYlQzU7A?=
 =?us-ascii?q?gcBCgEBAwkBgVWNaYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:gRURvqBvwhfai7LlHemv55DYdb4zR+YMi2TDpHoBKiC9Ffbo8f
 xG/c5rsiMc5wx9ZJhNo6HjBEDEewK5yXcX2+Us1NWZNjUOaFHYSb2KhLGKq1bd8m/FltK1vp
 0PT0ERMrzN5BRB4vrH3A==
X-Talos-CUID: =?us-ascii?q?9a23=3ACvjblWoFl1X+NfOLZFuNBSfmUesZSFfDl1eLGEO?=
 =?us-ascii?q?fBzxXdKybVFGVwIoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A/cRZIw6eJkBV9LIpghn+fxnjxoxLz4OwS0Ehtqw?=
 =?us-ascii?q?JlPCYKHwtABq8rmm4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194715548"
X-MGA-submission: =?us-ascii?q?MDEmcoltPMQnrRVAWwq2t1vT2a2jvF26TGnxZW?=
 =?us-ascii?q?Ez8EtwWa5QFSjY3qC6l1DIlJBEGoFY7Px062UzJo5KJr5fz2rKLhG7YK?=
 =?us-ascii?q?vjZt9gYOHnVwvbK7XB1gy8lfOghpof+DsDBDeENQ3x1rzElSLQAqxg40?=
 =?us-ascii?q?by24t8nsUdU8VChNHdU3lJCQ=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 16:34:42 +0100
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1tDQFV-000000002aF-9jyb
	for cocci@inria.fr;
	Tue, 19 Nov 2024 15:34:41 +0000
Message-ID: <a63699fe-8219-4014-875e-5bf834c63413@knosof.co.uk>
Date: Tue, 19 Nov 2024 15:34:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <e3af9f65-c923-4fa0-8a7d-be1b27d47fb5@web.de>
 <c46ce4f9-30b1-4791-860c-e93aeda8a0d0@inria.fr>
 <2421b61c-a48e-415b-833d-3493d9b7924f@web.de>
 <ee34ca77-699b-4671-9c7c-61fc1f665171@inria.fr>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <ee34ca77-699b-4671-9c7c-61fc1f665171@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Marking several issues as =?UTF-8?Q?=E2=80=9Cnot_plan?=
 =?UTF-8?Q?ned=E2=80=9D?=
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 2093
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/a63699fe-8219-4014-875e-5bf834c63413%40knosof.co.uk>

Victor,

> This is getting ridiculous.

Colorless green ideas sleep furiously.

I am remiss for not responding to your last email about
the location issue.  I am planing to check out some
of the other issues.


> Victor
> 
> On 11/19/24 16:20, Markus Elfring wrote:
>>> Some of those were bugs that have since been fixed …
>> The corresponding issues can be marked better, can't they?
>>
>>
>>> In most of the conversations that you opened and that I closed, you brought up things that you perceived to be 
>>> issues. You then were told that this was actually not actually a bug, or that the feature you requested did not fit 
>>> the direction of the project.
>> The development interests and resources are evolving for a while.
>>
>>
>>> This was all explained very clearly,
>> The impressions and understanding challenges varied.
>>
>>
>>> so I'm not sure what else you were hoping would happen with all of these years-old issues.
>> Usual software improvements.
>>
>>
>>> As a reference, out of 336 total GitHub issues, you opened 198 of them.
>> Such issues were reported through some years.
>>
>>
>>> The unfortunate reality is that this is not the case - …
>> We came along some communication difficulties also because of different development interests.
>>
>>
>>> - you enjoy the project and want to help it succeed, …
>> I am trying this also for several years.
>>
>> Regards,
>> Markus

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

