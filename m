Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081C4CDB474
	for <cocci@archiver.kernel.org>; Fri, 20 Oct 2023 07:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4e1qwlcFE+LTtUXU9D03quPjWktCHrZVw3woGmr+aTo=;
  b=hkcmqucL4Ds+rrB4ec+rT8QkjZQUO5DQ9SKJFaZSsTVoWHD1EGAGoVbZ
   2wO3OsDTapCIQA7o3mTHN1tqSoDsWVsg4c0GN34ynNOtlPjNKBVHJe6dj
   opTuyMEhaRaDvM4DzYptKSSVzT/RcnWxPU7q+W+CH0ofoN5pHpC3KR3r5
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.03,238,1694728800"; 
   d="scan'208";a="132268694"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2023 09:58:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 11EF1E00BA; Fri, 20 Oct 2023 09:58:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0EEB8E00B7
	for <cocci@sympa.inria.fr>; Fri, 20 Oct 2023 09:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4e1qwlcFE+LTtUXU9D03quPjWktCHrZVw3woGmr+aTo=;
  b=sc0+sWz87r6c842tr7ujXLeUAdQ9zqc7LT0V8YGI441i1w57kSdUxgQ+
   zM14rC2segmMbcjmn150bq25qiYhsfSgGKpp1EVreL/JvrB+CuPEziVHW
   Zk2Lo5bwA/20lNloZCcAuBvBzQyF/ZWds9MvkQFpunUvvVsHnc1ilQ2xP
   c=;
X-IronPort-AV: E=Sophos;i="6.03,238,1694728800"; 
   d="scan'208";a="132268676"
Received: from dhcp-138-246-3-50.dynamic.eduroam.mwn.de (HELO hadrien) ([138.246.3.50])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 09:58:11 +0200
Date: Fri, 20 Oct 2023 09:58:10 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: =?ISO-8859-15?Q?Martin_Schr=F6der?= <info@swedishembedded.com>
cc: cocci@inria.fr
In-Reply-To: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
Message-ID: <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr>
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-772200014-1697788690=:3251"
Subject: Re: [cocci] Finding functions that do not unlock mutex in the same
 function
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1265
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-772200014-1697788690=:3251
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 20 Oct 2023, Martin Schröder wrote:

> How can I adjust the following code to find all cases where a function locks a mutex but does not call unlock in the same function:
>
> ```
> virtual report
> virtual patch
>
> @ r exists @
> identifier f;
> expression l;
> expression r, e;
> position p;
> @@
> f@p(...){
> ... when != k_mutex_lock(...)

Drop the above two lines.

> r = k_mutex_lock(l, ...)
> ... when != e = r
> if(e){
> ... when != k_mutex_unlock(l)
>     when any
>     when strict
>     when exists

when exists is not needed here, since you have that already.

> }

I think you could just put

... when any
    when !=  k_mutex_unlock(l)

and drop the rest.

> (
> return ...;
> )
> }

Does that work the way you wanted?

julia


>
> @ script:python depends on r@
> p << r.p;
> f << r.f;
> @@
>
> // This Python script runs if a locked mutex is not unlocked in all code paths.
> msg = "In function '%s', there's a path without unlocking the mutex. Ensure that the mutex is always unlocked before returning or exiting the function." % f
> coccilib.report.print_report(p[0], msg)
> ```
> It catches some cases but I'm still not able to make it catch everything but the first error checking if statement:
>
> ```
> int invalid_a(int a1, int a2){
> int r = k_mutex_lock(mutex, K_MSEC(200));
> if(0 != r){
> return 0;
> }
> if(1){
> return 1;
> }
> return 0;
> }
>
> int invalid_b(int a1, int a2){
> int r = k_mutex_lock(mutex, K_MSEC(200));
> if(0 != r){
> return 0;
> }
> return 0;
> }
>
>
> int valid_b(int a1, int a2){
> int r = k_mutex_lock(mutex, K_MSEC(200));
> if(0 != r){
> return 0;
> }
> k_mutex_unlock(&mutex);
> return 0;
> }
>
> int invalid_c(int a1, int a2){
> int r = k_mutex_lock(mutex, K_MSEC(200));
> int b = foo;
> if(0 != r){
> return 0;
> }
> if(0 != b){
> return 0;
> }
> k_mutex_unlock(&mutex);
> return 0;
> }
> ```
>
> Result:
> tests/coccinelle/mutex_lock_unlock.c:1:4-13: In function 'invalid_a', there's a path without unlocking the mutex. Ensure that the mutex is always unlocked before returning or exiting the function.
> tests/coccinelle/mutex_lock_unlock.c:12:4-13: In function 'invalid_b', there's a path without unlocking the mutex. Ensure that the mutex is always unlocked before returning or exiting the function.
>
> Invalid_c is not detected.
>
> --
> Best regards,
>
> [AIorK4wH6aPZe4eYWheYhio282OdbmPN-eMyvcew6PbeQLd1K_qGuSNTnBuq0VT6bSD79PDVrzgSr5c]
> Martin Schröder
> Embedded Firmware Consultant
> Connect on LinkedIn
> Book online meeting
>
> Swedish Embedded Consulting Group AB
> W. https://swedishembedded.com
>
>
>
>
--8323329-772200014-1697788690=:3251--
