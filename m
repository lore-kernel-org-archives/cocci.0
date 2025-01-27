Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F796C02188
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SV+sbiTDgNR91oICK6vi3eu0XZknwlVAWEuk0sv4IIs=;
  b=WvqT7cx5yn6ewN8Okj02bkN0dOLia2nCZAPPP7b0eH8OzYfs7jqJd4i2
   2WmCCuTa05L2pUyYr2zMzOWoQWU5ISkNzQ1T/XZgYPMfmSJDXOV+Ty6i5
   sx+hyIPrR0FSIhuo4scJKeJ9PGmqVKwV4xSutdVXQ/elsbV1FYZi3sgyZ
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205166473"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 12:43:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 05716E0D1F; Mon, 27 Jan 2025 12:43:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 56783E0035
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 12:43:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SV+sbiTDgNR91oICK6vi3eu0XZknwlVAWEuk0sv4IIs=;
  b=p8KQLXpHQ10YvqSJIcs6Pve938eAr99yq4jS4AxBfzBvBUE2Z4JDXhnu
   hAHDcorxKvhNSruWhc6z2Yb2HKCu8FuJKWpYIpmIJwW4xsPUZuqYoHU57
   ZLXU6JBFq/kK5JLvc3AE11I8L3pzYwlDYhX8T5jw10b/IUUWzj8SLVtkA
   s=;
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="107440508"
Received: from lfbn-idf2-1-396-176.w86-246.abo.wanadoo.fr (HELO [192.168.1.11]) ([86.246.108.176])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 12:43:52 +0100
Message-ID: <e8572652-54bc-475d-a25e-241fdb83b9c1@inria.fr>
Date: Mon, 27 Jan 2025 12:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@google.com>
Cc: cocci@inria.fr
References: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
 <1176708922.5283093.1737643285348.JavaMail.zimbra@inria.fr>
 <CANiDSCsj1r34A5ytx5u_XrJwysyX3n7oOVPO7xGOPvUgHrnHSA@mail.gmail.com>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <CANiDSCsj1r34A5ytx5u_XrJwysyX3n7oOVPO7xGOPvUgHrnHSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] linux-next: virtual rule report not supported
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2223
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/e8572652-54bc-475d-a25e-241fdb83b9c1%40inria.fr>

Hi Ricardo,

Thanks for all the info, especially the patch. Unfortunately I still 
can't reproduce the error.

One thing that stands out to me: Coccinelle 1.3.0 shouldn't be 
compatible with OCaml 5.2.0 - are you sure you managed to compile 1.3.0 
with 5.2.0? If so, could you explain your process?

Either way, could you give me an exact commit for both Coccinelle and 
the kernel? If I manage to reproduce it, I'll merge your patch.

Victor

On 24/01/2025 13:43, Ricardo Ribalda wrote:
> Hi Victor
>
> I can easily repro with:
>
> ```
> spatch -D report --no-show-diff --very-quiet --cocci-file
> scripts/coccinelle/misc/secs_to_jiffies.cocci --dir .
> ```
>
> tested with
> spatch version 1.1.1 compiled with OCaml version 4.14.1
> Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc
> --libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3
> --enable-opt
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: Str
>
> and
> patch version 1.3 compiled with OCaml version 5.2.0
> Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc
> --libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3
> --enable-opt
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: Str
>
> This patch "fixes" it for me:
>
> diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci
> b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> index 8bbb2884ea5d..2d85dca16418 100644
> --- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> @@ -10,6 +10,7 @@
>   //
>
>   virtual patch
> +virtual report
>
>   @depends on patch@ constant C; @@
>
> @@ -20,3 +21,8 @@ virtual patch
>
>   - msecs_to_jiffies(C * MSEC_PER_SEC)
>   + secs_to_jiffies(C)
> +
> +// Dummy rule for report mode that would otherwise be empty and make spatch
> +// fail ("No rules apply.")
> +@script:python depends on report@
> +@@
>
> On Thu, 23 Jan 2025 at 15:41, Victor Gambier <victor.gambier@inria.fr> wrote:
>>> Deleting scripts/coccinelle/misc/secs_to_jiffies.cocci "works"
>> That script was added to the linux kernel in December. Which version of Coccinelle are you using?
>>
>> On my end, with Linux 21266b8d and Coccinelle d4309c2, the following command executes without error:
>>
>> .../linux $ make coccicheck M="drivers/media" MODE=report
>>
>> Victor
>
>
