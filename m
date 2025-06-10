Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9F6C71136
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=umcZeKbZ0X54bScCEOCTXGAU3+QgdJ62r0B59TeumYk=;
  b=hgrzfYDeAkOtSbjslCRus3omBhuSqS5/+UI2QXPUJA2xlM7zbO5gMV21
   RZ+Q1WC2eXF88WRdBzzK+WnI3GSxoMpj3dbevQ+iJqYXcrGvyB5XZEIqv
   SqplPC3Te4nYWdkVNeM1GXY7AwxFURaZ9cI3uPrw3M9K2v68XfTFK0318
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226896037"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 966D5E0D20; Thu, 12 Jun 2025 15:49:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DE714E0131
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 19:35:56 +0200 (CEST)
IronPort-SDR: 68486cfc_qZYKNLTEHhpt61GQgOK63AyuIF7yO6VMwb1DWkDm+cEgLOd
 Xwu7PTB2C1lzTPCCymftG/kXtHg1luy5GXEilWg==
X-IPAS-Result: =?us-ascii?q?A0EBAABPbEhohbaaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVozBwhJhFWIHIlVA4ETimGSIoFAPQIPA?=
 =?us-ascii?q?QMBWwECBAEBAwSFAAKLZQIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABAQEBQEmFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARECDV4BAR4BAQEDERIdAQE3AQ8LGAICJgICVgYTAgEBgn6CIgdGB?=
 =?us-ascii?q?gKdQgGHYAEBAoopeoEygQGCDAEBBtwjgWUJgRsuAYhPAYYHKYQzJxuBSUSBF?=
 =?us-ascii?q?ScOgQaBNzg+aYNvg0aCaYIoRFKQH4UTi1NSeBwDWSwBVRMXCwcFgSBDA4EPI?=
 =?us-ascii?q?0sFLR2CDYUZH4FzgVkDAxYPAYQCHIRihANGK0+DIoF/ZUGDYR4Gcg8HKkACA?=
 =?us-ascii?q?QttPTcJCxtDmG+DcHsTggY5AQsTkwkdkBuBNmuBNZ9WhCWhWAYPBC+XX5MCL?=
 =?us-ascii?q?odlkHGjUoU0gho6gVxGByMVgyJPAxkPjiEZg2e3dyM1PAIHCwEBAwmFRgEBi?=
 =?us-ascii?q?wOBSwEB?=
IronPort-PHdr: A9a23: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
 lg9jQ4sOYwQ
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KhMbHKjBtmEDTp2GCbQxAGEc83BQXuoji2hC6mlwRA09TyVXra
 CTdYcgpHjJYVEqKQkdcLG7SdC9qRG1z/RICOwqUItKMzOIhILFFvAH0WKm+UyHJ8SczIBgPM
 VbH5SWYeeYZTNHZITBkWyF+r0bsbq6Gc6T9IXjJjtWLD1XVw==
X-Talos-CUID: =?us-ascii?q?9a23=3AiR+g4mlLCsAKAfiCacmkT4ICAbzXOVSa9U+OCGu?=
 =?us-ascii?q?eMj1WZOC4cxipu5tbkPM7zg=3D=3D?=
X-Talos-MUID: 9a23:m74ylQS84JMShFR3RXTRoA5dOMRh6p//S3AzkNIhmeDfLSBJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="118688116"
X-MGA-submission: =?us-ascii?q?MDFiUDTXxPaK6AIpGUeg+tSKvJ/nMqcuxznHZr?=
 =?us-ascii?q?ky5ckUdrZKr9NzJoAH16rKNy9SltZ6XeIIZH7jlwuNdGJ603IE3QEmNm?=
 =?us-ascii?q?tYryF3Df5zVEgxoGKIFpZ414A/WRgGMdQZyAwnEXhjG4w90CNoRiNwWW?=
 =?us-ascii?q?Md5JOiHRRvgM+WJFJaohNhFA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 10 Jun 2025 19:35:56 +0200
Received: from [100.65.129.218] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id AEA0B2078629;
	Tue, 10 Jun 2025 10:35:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEA0B2078629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749576952;
	bh=umcZeKbZ0X54bScCEOCTXGAU3+QgdJ62r0B59TeumYk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=flmXs/dXHK/B+qHt9LU9IhLoj3HuHe0sBJ/1ZbNarOMnqmasmi4QVMbJMA501IsBe
	 GAwrz/bY9lYDN9HWZbrW0IAehElO8J+hWCDKUk34bWlkErk6FnklvC7bdpMI7iz/Cc
	 F2allUsgFGgTI1sMgi7uThujt4wfIMzd8Rrbr8/k=
Message-ID: <588d5a4b-72cf-4d2c-8eee-c4240ae067b5@linux.microsoft.com>
Date: Tue, 10 Jun 2025 10:35:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Andrew Morton <akpm@linux-foundation.org>, cocci@inria.fr,
 linux-kernel@vger.kernel.org
To: Ricardo Ribalda <ribalda@chromium.org>
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
 <aeacb653-efb8-42ed-a7ed-3e7be31b8f9d@linux.microsoft.com>
 <CANiDSCviy5SjOwEcEM8_1gtvQzFUS3d=S6vFdvZzVqbif7NKfA@mail.gmail.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <CANiDSCviy5SjOwEcEM8_1gtvQzFUS3d=S6vFdvZzVqbif7NKfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: misc: secs_to_jiffies script:
 Create dummy report
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2770
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/588d5a4b-72cf-4d2c-8eee-c4240ae067b5%40linux.microsoft.com>

On 6/10/2025 6:09 AM, Ricardo Ribalda wrote:
> Hi
> 
> On Wed, 29 Jan 2025 at 18:38, Easwar Hariharan
> <eahariha@linux.microsoft.com> wrote:
>>
>> On 1/29/2025 12:06 AM, Ricardo Ribalda wrote:
>>> When running cocci in report mode, eg:
>>> $make coccicheck M="$dir" MODE=report
>>>
>>> It returns this error:
>>> virtual rule report not supported
>>> coccicheck failed
>>> make: *** [Makefile:251: __sub-make] Error 2
>>>
>>> Create a dummy rule to avoid this error and run the other cocci scripts.
>>>
>>> Fixes: 551dbd1ec7ff ("coccinelle: misc: add secs_to_jiffies script")
>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>> ---
>>>  scripts/coccinelle/misc/secs_to_jiffies.cocci | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
>>> index 8bbb2884ea5d..2d85dca16418 100644
>>> --- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
>>> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
>>> @@ -10,6 +10,7 @@
>>>  //
>>>
>>>  virtual patch
>>> +virtual report
>>>
>>>  @depends on patch@ constant C; @@
>>>
>>> @@ -20,3 +21,8 @@ virtual patch
>>>
>>>  - msecs_to_jiffies(C * MSEC_PER_SEC)
>>>  + secs_to_jiffies(C)
>>> +
>>> +// Dummy rule for report mode that would otherwise be empty and make spatch
>>> +// fail ("No rules apply.")
>>> +@script:python depends on report@
>>> +@@
>>>
>>
>> Sorry about that, and thanks for the patch!
>>
>> FWIW,
>>
>> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> I just checked on 6.16rc1 and it is still failing.
> 
> Could we land this while Mark's series is under review?
> 
> Thanks!
> 

Can you provide a pointer to Mark's series? I actually just implemented a proper report and context mode
which I'm glad to send out.

Thanks,
Easwar (he/him)
