Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30157EA8546
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9iepRrhjVBYYTeAEV0oYDwMdA0DAXCifRgdIS2et9Ec=;
  b=iq1fvjDruWezalIZsx7htqGfGpvDQm74GF88or0aw1nku2C9G2rVU/pm
   p49iDohdkoTZhndLsUiV2ocwVC7C6h9jPxqnY1FHLYxV+WwJmsrFV3MOC
   gxUSwUAOsgXXq4LI97+RmeXBr/P84FUq8GBdAsPHuJWAd9P27YxaIF4ve
   Q=;
X-CSE-ConnectionGUID: wn1s0YW+S9iAeW1b3Mm1Vg==
X-CSE-MsgGUID: vQXt19z3SeqW7QdRg27/sw==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208,217";a="266763331"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 23:12:39 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9076C8167D; Sun,  8 Mar 2026 23:12:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0CA14804B6
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 23:12:33 +0100 (CET)
X-CSE-ConnectionGUID: uhphlnURSY6EgjvzGmri8A==
X-CSE-MsgGUID: mlnetdfGSpWIUl5tZ7Cm4w==
IronPort-SDR: 69adf451_FTluriEhkGs/rccvRzBo6zXZ4voMxVRXpYv5Ntb55xhQ9WM
 aW0GiaO1T4+kHnUd02vzNYdOzEGs+yY4bvn4nHg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FiAgDi861pjww2ttVaHQEBPAEFBQECAQkBgWeCP4FlN?=
 =?us-ascii?q?AcISYRYiHuIfIQ7m1wCDwEDAQ0UEycBAgQBAQMEhQACjSIgBgEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQEBATkFDjuGTw2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQIsPwEVCgEBAQMjHQEBNwEPCwMBFAweAgJWB?=
 =?us-ascii?q?hUBAYJ+giMHSgera4EygQGCDAEBBtwqgWcJgU0BhW6CZQEqgTUDhC2DZXpCg?=
 =?us-ascii?q?UlEgTwLgng+iB6CaYImehQdhy4GgUaKFFJyIgMmMywBVRMXCwcFgSNDA4EGI?=
 =?us-ascii?q?0sFLR2BIyEdFxQfWBsHBRIhKoFpeIIBD4ZoeQMueA4iAigSXEo+C1oFgiUCA?=
 =?us-ascii?q?QttPTcJCxsEjlNcPoQOgh06pD6heYQmgWQMn20GDwQvqmuZBqNxhVCBfyOBX?=
 =?us-ascii?q?E0jgzdPAxkPjjqDZ8k6RjI8AgcLAQEDCYVEAQ8BAYxIgUsBAQ?=
IronPort-PHdr: A9a23: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
 9wFTboJDTTd+dsfA0VhG5oJJ5IlB1sZ
IronPort-Data: A9a23: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
 N0BgKbOx8kwsfSovCgQOOjeYzo=
IronPort-HdrOrdr: A9a23:atsOaKmlJeTD0UsTio8eLYU1vnfpDfIe3DAbv31ZSRFFG/FwWf
 re+cjzpiWE7wr5OUtNpTnkAsK9qBznm6KdjbNhW4tKGTOWwVdAT7sC0WKB+VLd8kTFn4Y26U
 4jSdkbNDSaNykYsS+V2njbLz9t+rm62ZHtqc+b52txTGhRBp1d0w==
X-Talos-CUID: 9a23:ITvzb2BJYAMVQgD6EzRn7E4QHP0fSUyD4XjSPV2XDHxoGJTAHA==
X-Talos-MUID: 9a23:TwQ59QiRx+kOdgobXl+LNsMpMcNu7riiBm82iaonhs3ZKR4vEDLBk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208,217";a="266763319"
X-MGA-submission: =?us-ascii?q?MDGCdCzyk869jzlkEUK6QLl9pYa4i3GMAOR8gs?=
 =?us-ascii?q?iOH5S8DpRpdH39M02+3p4LMTKfG9tzOMX7OCjXkxhyohLxCMUf4Ju7He?=
 =?us-ascii?q?I+sa9FKqg8DxSg+09Z1ha8/mBZs/GgHYwNthDv+V2tDOawrhjwWESqrj?=
 =?us-ascii?q?QOyzq2+acTC/2+o9twvpqLHQ=3D=3D?=
Received: from msg-2.mailo.com (HELO mailo.com) ([213.182.54.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:12:33 +0100
Received: by b221-9.in.mailobj.net [192.168.90.29] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Sun,  8 Mar 2026 23:12:32 +0100 (CET)
X-EA-Auth: N84Qnz+IoB/l2iXkhZi4nuwiWixFBjsoOs99Ovt5cvISjGB2hg7rQPVFcsapSPC4w2p7tR8jLcBUaRGum2uxmFqLXJ8CSxGibm9ZV1gugqY=
Content-Type: multipart/alternative;
 boundary="------------YCGmZdfckDHk0m0FuNH55W8b"
Message-ID: <155c7bec-41ef-4985-bb06-f8315d91e42a@mailo.com>
Date: Sun, 8 Mar 2026 22:12:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <fc5aa4f0-0134-475a-9220-dedc71955fe7@mailo.com>
 <6b795826-177a-4bef-81cd-1b783815114@inria.fr>
Content-Language: en-GB
From: Sam Tygier <samtygier@mailo.com>
In-Reply-To: <6b795826-177a-4bef-81cd-1b783815114@inria.fr>
Subject: Re: [cocci] c++ scope resolution operator
Reply-To: Sam Tygier <samtygier@mailo.com>
X-Loop: cocci@inria.fr
X-Sequence: 3345
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/AT6QN7viRcSBNuYkfGxxWA>

This is a multi-part message in MIME format.
--------------YCGmZdfckDHk0m0FuNH55W8b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/03/2026 21:43, Julia Lawall wrote:
> On Sun, 8 Mar 2026, Sam Tygier wrote:
>> Hi,
>>
>> I am having trouble using Coccinelle with C++ around scope operators, e.g.
>> std::cout.
> Sorry, but the support for :: is still work in progress.
>
> julia

Thanks, I'll keep an eye out for updates. Is there a github issue for 
this that I could subscribe to?

Sam

--------------YCGmZdfckDHk0m0FuNH55W8b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 08/03/2026 21:43, Julia Lawall
      wrote:<span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:6b795826-177a-4bef-81cd-1b783815114@inria.fr">
      <pre wrap="" class="moz-quote-pre">On Sun, 8 Mar 2026, Sam Tygier wrote:</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hi,

I am having trouble using Coccinelle with C++ around scope operators, e.g.
std::cout.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Sorry, but the support for :: is still work in progress.

julia
</pre>
    </blockquote>
    <p>Thanks, I'll keep an eye out for updates. Is there a github issue
      for this that I could subscribe to?</p>
    <p>Sam</p>
  </body>
</html>

--------------YCGmZdfckDHk0m0FuNH55W8b--


