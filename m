Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA175C02196
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2025 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Gtax5EPOwFawYjx6aAXqkY1XCtIDPwzU/nxnNGPHOmo=;
  b=hjG4B4gmd5vzwYZKfEYz084WRyciA3uyiuzRPOBLJuL1Il7YK53Hk75k
   AYcVEDhJouLC6oA/srPGRKjMuiD7YucL+V+43uOL0zrRXZuAKm8Pd1Ct4
   VnXuRkPiuXfSr89+EPmwUVEhLlT8IIH0WpCSPf8nNQc6Rz2O4zKo79ukA
   U=;
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
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="206553173"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 15:56:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B8D24E0D1E; Tue,  4 Feb 2025 15:56:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 830F2E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 15:56:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gtax5EPOwFawYjx6aAXqkY1XCtIDPwzU/nxnNGPHOmo=;
  b=LDpDN24kaUfrFhMZodJAbNOU3zGB24KQHnWoF2DDgP7fF2IVZJuxqFkS
   XajhvHz+XExyr+53UupXsKOyXDDrIzHA6UOPEpGSOG9Hq0+BPMfmOrvQL
   dUEnxYHOkmt9cRgr6pGmJgwIL4RkCizLYM2TVU5Kpa3Ip/gi1VO8l0Mtj
   w=;
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="108183315"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 15:56:27 +0100
Message-ID: <5123b7fe-b5f6-4446-a792-b5d19873c181@inria.fr>
Date: Tue, 4 Feb 2025 15:56:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>,
 Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
 <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
 <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
 <66215b0-f6e-2cef-4022-4dd148fa2790@inria.fr>
 <CANiDSCvsBCrpwOFbwf93ighoMm+ca=jpHs6NAp9AHaEJj9neRg@mail.gmail.com>
 <1c92f6ab-9992-1f5-d911-f8cd52991c66@inria.fr>
 <CANiDSCvXUxdTxXZ9r3SvoVTnChkg1nRN7uAva8nHb6CTFt67KQ@mail.gmail.com>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <CANiDSCvXUxdTxXZ9r3SvoVTnChkg1nRN7uAva8nHb6CTFt67KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2339
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/5123b7fe-b5f6-4446-a792-b5d19873c181%40inria.fr>

I'm realizing I never published the full results of the git bisect I did:

spatch version 1.1.1-00610-gd151c4895 compiled with OCaml version 4.13.1
Flags passed to the configure script: [none]
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

$ time make coccicheck M=drivers/media
real    14m31,975s
user    92m46,656s
sys    0m47,545s

-

spatch version 1.1.1-00611-g4388e1d92 compiled with OCaml version 4.13.1
Flags passed to the configure script: [none]
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

$ time make coccicheck M=drivers/media
real    33m0,638s
user    218m47,039s
sys    1m13,807s

-

The first bad commit could be any of:
312219d
4388e1d
1cbba8f

It's possible there are more regressions.

On 04/02/2025 13:49, Ricardo Ribalda wrote:
> On Tue, 4 Feb 2025 at 13:46, Julia Lawall <julia.lawall@inria.fr> wrote:
>>
>>
>> On Tue, 4 Feb 2025, Ricardo Ribalda wrote:
>>
>>> Hi Julia
>>>
>>> Just FYI, In media-ci tried again with Debian's 1.3.0 and it is better
>>> than  1.2 but still much slower than 1.1.1.
>> Thanks for the update.  Do you have a number?
> 5m35s vs 20m56s
>
> https://gitlab.freedesktop.org/linux-media/users/ci/-/pipelines/1357625/test_report?job_name=static-upstream
> https://gitlab.freedesktop.org/linux-media/users/ci/-/jobs/70476750
>
>
> https://gitlab.freedesktop.org/linux-media/users/ci/-/pipelines/1357095/test_report?job_name=static-upstream
> https://gitlab.freedesktop.org/linux-media/users/ci/-/jobs/70427995
>
>> julia
>>
>>> Regards!
>>>
>>> On Mon, 5 Aug 2024 at 14:12, Julia Lawall <julia.lawall@inria.fr> wrote:
>>>>
>>>>
>>>> On Mon, 5 Aug 2024, Ricardo Ribalda wrote:
>>>>
>>>>> On Mon, 5 Aug 2024 at 13:27, Markus Elfring <Markus.Elfring@web.de> wrote:
>>>>>>> It seems to be related to the cocci version, and not the kernel version.
>>>>>>>
>>>>>>> Debian updated it recently from 1.1.1 to 1.2.
>>>>>> Thanks for such background information.
>>>>>>
>>>>>>
>>>>>>> These are my results for the same kernel code:
>>>>>>>
>>>>>>>
>>>>>>> root@a361d9092793:/workdir# time make coccicheck M=drivers/media/
>>>>>>> MODE=report V=1  > 1.1.1.txt
>>>>>>>
>>>>>>> real    1m59.021s
>>>>>>> user    53m53.038s
>>>>>>> sys     2m17.171s
>>>>>> …
>>>>>>> root@a361d9092793:/workdir# time make coccicheck M=drivers/media/
>>>>>>> MODE=report V=1  > 1.2.txt
>>>>>>>
>>>>>>> real    15m0.552s
>>>>>>> user    371m28.976s
>>>>>>> sys     3m32.884s
>>>>>> Are there any possibilities to increase the measurement granularity for
>>>>>> affected SmPL scripts?
>>>>>> Would you like to compare software run time characteristics in more detail
>>>>>> (in parallel) also according to each SmPL script?
>>>>> Let me know if this is enough:
>>>>>   time make coccicheck M=drivers/media/ MODE=report V=1 | ts -i > 1.2.ts.txt
>>>> Yes, that's helpful, thanks!
>>>>
>>>> julia
>>>
>>>
>>> --
>>> Ricardo Ribalda
>>>
>
>
