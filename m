Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB668D44167
	for <cocci@archiver.kernel.org>; Tue, 19 Nov 2024 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8ck593Am/x3nHi7sFIIU/Ty90veWCcVVqxRA5XYoths=;
  b=qSjP1dgwcb/09IvBCHdl14yxxWI/tzSuc+7Py6mw76szXFUUHbHukMup
   //7GJNyG5dme8RU/8G16v+98TFpfjZfYPaC1dbRNfgrTXScRLGAqVBN9q
   PVr9FNLb1DKRVEfjuBIg31wKZxaZHpsFyHO49wCIjPmpDLuAbZeSz2Bez
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194716904"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Nov 2024 16:38:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 039C4E0D1E; Tue, 19 Nov 2024 16:38:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D631AE0133
	for <cocci@sympa.inria.fr>; Tue, 19 Nov 2024 16:38:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8ck593Am/x3nHi7sFIIU/Ty90veWCcVVqxRA5XYoths=;
  b=jnM4+QJnNK6EEVGCYg6AOyQHGUAkh8YGyxuni+yICSQsHG4Y5e1qzE4v
   q6wRvOtLe6OQXqftHuHMcjKXKZTNY3pEU+jNaiiaYphBd0e3ZdJnVtIy2
   Eg1VGnsPAt5qiuiG15WiQO5ZxWtjZFgI3cRc5jJqi4OqYTQZQpiV8yb7p
   M=;
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194716881"
Received: from dt-desouza.paris.inria.fr (HELO [128.93.67.77]) ([128.93.67.77])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 16:38:50 +0100
Message-ID: <78e4e6d2-d3fb-422d-8e41-75f90387caea@inria.fr>
Date: Tue, 19 Nov 2024 16:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <e3af9f65-c923-4fa0-8a7d-be1b27d47fb5@web.de>
 <c46ce4f9-30b1-4791-860c-e93aeda8a0d0@inria.fr>
 <2421b61c-a48e-415b-833d-3493d9b7924f@web.de>
 <ee34ca77-699b-4671-9c7c-61fc1f665171@inria.fr>
 <a63699fe-8219-4014-875e-5bf834c63413@knosof.co.uk>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <a63699fe-8219-4014-875e-5bf834c63413@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Marking several issues as =?UTF-8?Q?=E2=80=9Cnot_plan?=
 =?UTF-8?Q?ned=E2=80=9D?=
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2094
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/78e4e6d2-d3fb-422d-8e41-75f90387caea%40inria.fr>

Hi Derek,
> Colorless green ideas sleep furiously.
:)
>
> I am remiss for not responding to your last email about
> the location issue.  I am planing to check out some
> of the other issues.

No worries! I wasn't expecting a response or any specific action on your 
part, but it is of course welcome. I'm still investigating on my end, I 
will let you know if I make any progress.

Victor

>
>> Victor
>>
>> On 11/19/24 16:20, Markus Elfring wrote:
>>>> Some of those were bugs that have since been fixed …
>>> The corresponding issues can be marked better, can't they?
>>>
>>>
>>>> In most of the conversations that you opened and that I closed, you 
>>>> brought up things that you perceived to be issues. You then were 
>>>> told that this was actually not actually a bug, or that the feature 
>>>> you requested did not fit the direction of the project.
>>> The development interests and resources are evolving for a while.
>>>
>>>
>>>> This was all explained very clearly,
>>> The impressions and understanding challenges varied.
>>>
>>>
>>>> so I'm not sure what else you were hoping would happen with all of 
>>>> these years-old issues.
>>> Usual software improvements.
>>>
>>>
>>>> As a reference, out of 336 total GitHub issues, you opened 198 of 
>>>> them.
>>> Such issues were reported through some years.
>>>
>>>
>>>> The unfortunate reality is that this is not the case - …
>>> We came along some communication difficulties also because of 
>>> different development interests.
>>>
>>>
>>>> - you enjoy the project and want to help it succeed, …
>>> I am trying this also for several years.
>>>
>>> Regards,
>>> Markus
>
