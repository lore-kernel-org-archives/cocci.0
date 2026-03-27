Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C29610ED65A
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2026 10:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=l3xa08hwAHQ4cgZoD/RecqRbVCegC4VhLnm9Ug85U4w=;
  b=IZGdhYpdHFfQrTJms+5Bfw7gux4bXD7Qe77An4Gn4Egpu3qWa5KdQa3o
   ntTxaI5Wz7mKUlG6AIh5HW7fZpvF7JZKxACmoeSm5LDgmQgA//mLnCTPZ
   0u6p2q/jEHSglV34Y/ERavpATxS4B2shjCf/kjrpdrPmYTZQ9uwl0UKhJ
   0=;
X-CSE-ConnectionGUID: rbPEpZFPQbK3rV0Kd24bTw==
X-CSE-MsgGUID: nx8NAxkHQ6OcSZBQNJnM8A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="269789379"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2026 11:43:52 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6FDD081910; Fri, 27 Mar 2026 11:43:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C798F8181B
	for <cocci@sympa.inria.fr>; Fri, 27 Mar 2026 11:43:47 +0100 (CET)
X-CSE-ConnectionGUID: i/sysa+KSse0gMtb6/GCgA==
X-CSE-MsgGUID: oHi1syQCSOeHNxZB0wpgeg==
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="269789352"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 11:43:47 +0100
Message-ID: <4b4ae269-e463-47e8-8dc0-b1aa3f0d1b48@inria.fr>
Date: Fri, 27 Mar 2026 11:43:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Ricardo Ribalda <ribalda@chromium.org>
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
 <5123b7fe-b5f6-4446-a792-b5d19873c181@inria.fr>
 <5c5a00f7-8955-483a-9efc-d003972c7a12@web.de>
 <CANiDSCvvO7+qtRUi6NyrKzdKZaSrKNgSUgnnJfOw7HYHHc8nvw@mail.gmail.com>
 <f5449c2-3ce0-1d89-4b74-c288ca2efe58@inria.fr>
 <CANiDSCuWETFziv+DWSCHQVXTPg=wWVmj3zFaXWCydVz-0sYfHg@mail.gmail.com>
 <192127a4-dfe7-66f7-9736-8d6aace958d@inria.fr>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <192127a4-dfe7-66f7-9736-8d6aace958d@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3458
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/yE9ljVkkdKxd6aLh_cfkng>

I'm happy to report this performance issue was identified and will be 
fixed in the next release.

Victor

On 1/5/26 16:05, Julia Lawall wrote:
>
> On Mon, 5 Jan 2026, Ricardo Ribalda wrote:
>
>> Hi Julia
>>
>>
>>
>> On Sun, 4 Jan 2026 at 22:29, Julia Lawall <julia.lawall@inria.fr> wrote:
>>>
>>>
>>> On Tue, 16 Dec 2025, Ricardo Ribalda wrote:
>>>
>>>> Hi Laura
>>>>
>>>> Has there been any progress on this?
>>>>
>>>> I am stuck with an old Debian version in our CI and I would like to
>>>> update to debian stable.
>>> Hello,
>>>
>>> I made some improvements to the minmax semantic patch that made it go 4x
>>> faster on my test machine.  Maybe it will help.
>>>
>> Thanks for the file. Testing with 6.19-rc4.
>>
>> You should be easily be able to repro with docker/podman. If you need
>> help reproducing, let me know
>>
>> With bookworm and old minmax.cocci (baseline)
>> real    3m37.891s
>> user    77m19.816s
>> sys     2m12.033s
>>
>> With trixie and old minmax.cocci
>> eal    9m8.442s
>> user    195m42.341s
>> sys     5m53.336s
>>
>> With trixie and new minmax.cocci
>> real    8m19.803s
>> user    165m8.025s
>> sys     5m52.308s
> Interesting.  I had 32 minutes for old minmax and 8 minutes for the new
> one.
>
>> With these extra warnings:
>> warning: rmaxif: metavariable func not used in the - or context code
>> warning: errcode: metavariable func not used in the - or context code
>> warning: rmin: metavariable func not used in the - or context code
>> warning: rminif: metavariable func not used in the - or context code
>> warning: rmaxif: metavariable func not used in the - or context code
>> warning: errcode: metavariable func not used in the - or context code
>> warning: rmin: metavariable func not used in the - or context code
>> warning: rminif: metavariable func not used in the - or context code
>> warning: rmaxif: metavariable func not used in the - or context code
>> warning: errcode: metavariable func not used in the - or context code
>> warning: rmin: metavariable func not used in the - or context code
>> warning: rminif: metavariable func not used in the - or context code
> This is noise.  I will remove these variables.
>
>> It is definitely better, but it is still ~2.4 times slower
> Interesting.  It's not clear to me what would have ever caused the old
> version to be efficient...  Thanks for the report.
>
> julia
>
>> Best regards!
>>
>>
>>
>>
>> --
>> Ricardo Ribalda
>>
