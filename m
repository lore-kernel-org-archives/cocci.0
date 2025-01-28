Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39509C0218A
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=WERz3bWxzdFywSnK6V4G7KzfP/3BVg7ypNt/VA4N0yQ=;
  b=Es9xo2NGhRmgnZ1lb0kne+jKK7J8qWlZCYwGAmBoTna/LYyzA72PmlXL
   k9o29U26NWSyYP60YFvDRm2tco+lvbYTzcKUVs1DgJ+iOWFY98YThZuCb
   DZuMlsgINlBT8uA593tFSZ/6YuazEdrATSpaDhQthEe4r1hMwD28pa0uh
   4=;
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
X-IronPort-AV: E=Sophos;i="6.13,241,1732575600"; 
   d="scan'208,217";a="205417390"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 16:41:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6C0E6E0D1E; Tue, 28 Jan 2025 16:41:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 67105E00A5
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 16:41:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=WERz3bWxzdFywSnK6V4G7KzfP/3BVg7ypNt/VA4N0yQ=;
  b=gHmdzG5Jxqtj8+mOMbeqyD54uK3THldY4CB3nHQQYL87i+meN1OqnPIW
   vGlCs/WDVRufz+Mp2wZT54pgoUBpuh7UmqqxD3Mayj2O2C7NCvmr7/2Xj
   HkXhuxw4rPSU4y+DMp8mNfJA758hMRnidg99DLVyAQQCGUV01dUzBs2JD
   s=;
X-IronPort-AV: E=Sophos;i="6.13,241,1732575600"; 
   d="scan'208,217";a="205417389"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 16:41:10 +0100
Content-Type: multipart/alternative;
 boundary="------------pCr3QhPeIIFvbaetPbMAaj5V"
Message-ID: <f8d227a6-848d-4857-9857-2ae279e1f8b4@inria.fr>
Date: Tue, 28 Jan 2025 16:41:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@google.com>
Cc: cocci@inria.fr
References: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
 <1176708922.5283093.1737643285348.JavaMail.zimbra@inria.fr>
 <CANiDSCsj1r34A5ytx5u_XrJwysyX3n7oOVPO7xGOPvUgHrnHSA@mail.gmail.com>
 <e8572652-54bc-475d-a25e-241fdb83b9c1@inria.fr>
 <CANiDSCtHhG4Cm2OXovD=B-NgrD=U9JewpJQhNpzve2EZEuz1vg@mail.gmail.com>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <CANiDSCtHhG4Cm2OXovD=B-NgrD=U9JewpJQhNpzve2EZEuz1vg@mail.gmail.com>
Subject: Re: [cocci] linux-next: virtual rule report not supported
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2271
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/f8d227a6-848d-4857-9857-2ae279e1f8b4%40inria.fr>

This is a multi-part message in MIME format.
--------------pCr3QhPeIIFvbaetPbMAaj5V
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi again,

On 27/01/2025 12:46, Ricardo Ribalda wrote:
> I have just used the Debian packaged binaries.
> https://tracker.debian.org/pkg/coccinelle
>
> You can try them with something like
> podman run --rm -it debian:unstable
Ah, I see. Thanks.
>> Either way, could you give me an exact commit for both Coccinelle and
>> the kernel? If I manage to reproduce it, I'll merge your patch.
> For the kernel I am using from
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Thanks for the info, I can now easily reproduce the error. I can also 
confirm it's not just linux-next, the same issue occurs on the regular 
linux tree (9c5968db9). The issue has been present ever since 
secs_to_jiffies.cocci was added.

I also misspoke, since your patch is on the Linux kernel side and not on 
the Coccinelle, I can't merge it... But it looks to me like that's the 
right approach. If the script never worked, it's not Coccinelle's fault. 
Do you want to submit the patch to the Linux kernel, or should I do it?

Unrelated, but I also noticed there are a few warnings with 
api/stream_open.cocci, misc/do_div.cocci, and locks/mini_lock.cocci

Victor

--------------pCr3QhPeIIFvbaetPbMAaj5V
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi again,</p>
    <div class="moz-cite-prefix">On 27/01/2025 12:46, Ricardo Ribalda
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CANiDSCtHhG4Cm2OXovD=B-NgrD=U9JewpJQhNpzve2EZEuz1vg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">I have just used the Debian packaged binaries.
<a class="moz-txt-link-freetext" href="https://tracker.debian.org/pkg/coccinelle">https://tracker.debian.org/pkg/coccinelle</a>

You can try them with something like
podman run --rm -it debian:unstable
</pre>
    </blockquote>
    Ah, I see. Thanks.<br>
    <blockquote type="cite"
cite="mid:CANiDSCtHhG4Cm2OXovD=B-NgrD=U9JewpJQhNpzve2EZEuz1vg@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Either way, could you give me an exact commit for both Coccinelle and
the kernel? If I manage to reproduce it, I'll merge your patch.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">For the kernel I am using from
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git</pre>
    </blockquote>
    <p>Thanks for the info, I can now easily reproduce the error. I can
      also confirm it's not just linux-next, the same issue occurs on
      the regular linux tree (9c5968db9). The issue has been present
      ever since secs_to_jiffies.cocci was added.<br>
    </p>
    <p>I also misspoke, since your patch is on the Linux kernel side and
      not on the Coccinelle, I can't merge it... But it looks to me like
      that's the right approach. If the script never worked, it's not
      Coccinelle's fault. Do you want to submit the patch to the Linux
      kernel, or should I do it?<br>
    </p>
    <p>Unrelated, but I also noticed there are a few warnings with
      api/stream_open.cocci, misc/do_div.cocci, and
      locks/mini_lock.cocci<br>
    </p>
    <p>Victor<span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------pCr3QhPeIIFvbaetPbMAaj5V--
