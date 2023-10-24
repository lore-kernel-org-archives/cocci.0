Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC150C00A8F
	for <cocci@archiver.kernel.org>; Tue, 24 Oct 2023 05:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=A5I9uaAbt3Yr/kkIfUR0B98ssivp+RY3QG8ufFNfZpk=;
  b=bP4nTeoyRSLoy+biyBLb3sRJQmeInWf6nY05N3vh1Vh2aDIKO3Pc6hi3
   tyc6fG13BRJutt9h3KvNXvPfJMWpLjHDrEkBxg+jG4HdJg9oQNdbHnJO0
   t+RFoMjK332hyBN5Bk3AAqOW0mGBgsk3nJm1wEcq0u/kZ1mmqWB7RILZi
   M=;
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
X-IronPort-AV: E=Sophos;i="6.03,246,1694728800"; 
   d="scan'208";a="132815140"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2023 07:53:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EEF45E0CD5; Tue, 24 Oct 2023 07:53:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DF280E00B7
	for <cocci@sympa.inria.fr>; Tue, 24 Oct 2023 07:52:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=A5I9uaAbt3Yr/kkIfUR0B98ssivp+RY3QG8ufFNfZpk=;
  b=mtVtbMVDf7LMP4eeuU1Klv0FyVWhPO5irrXO/fv4Af2eS+JX19YoFoSV
   11bnllF7+yn3GRzJ6ImxvpkJAiEw4bt+kpr69rz8P8njJ0Yr2yFdHs+pK
   wcIhMstVC3EoUqJDwRe29/yjqml9Xx461VRksIgaAf1rgTZYxEJVCsTdZ
   o=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694728800"; 
   d="scan'208";a="132815137"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 07:52:57 +0200
Date: Tue, 24 Oct 2023 07:52:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Martin_Schr=F6der?= <info@swedishembedded.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2310240750150.3911@hadrien>
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com> <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr> <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de> <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2082133510-1698126760=:3911"
Content-ID: <alpine.DEB.2.22.394.2310240752410.3911@hadrien>
Subject: Re: [cocci] Finding functions that do not unlock mutex in the same
 function
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1273
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/alpine.DEB.2.22.394.2310240750150.3911%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2082133510-1698126760=:3911
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2310240752411.3911@hadrien>



On Sat, 21 Oct 2023, Martin Schröder wrote:

> Thanks Julia.
> My final script that seems to work looks like this:
>
> virtual report
> virtual patch
>
> @ r exists @
> expression l;
> identifier r, e;
> position p;
> @@
> r = k_mutex_lock(l, ...)
> ... when any
> if(r){ ... }

Put a return ...; after the ... to require the branch to return.  This
will cover the case where there is a goto that leads to the return.

> ... when != e = r
> when any

I would consider it to be more readable to line up the when lines.

julia

> if(e){
> ... when any
> when != k_mutex_unlock(l)
> return@p ...;
> }
>
> First I match k_mutex_lock. Then there can be any statements between that and the first check.
>
> If locking fails then in the first check it is valid to return. Not sure how to capture that this first if statement must return in that case. 
>
> Then there can follow additional if statements and in all of them there must be an unlock if there is also a return.
>
> The sample code looks like this:
>
> struct k_mutex lock;
>
> int function(){
>       int r = k_mutex_lock(&lock, K_FOREVER);
>       if(r){
>             return -ETIMEDOUT; // valid to not unlock here
>
>       }
>       r = produce_something();
>       if(r){
>             k_mutex_unlock(&lock);
>
>             return -EIO;
>
>       }
>       r = produce_something();
>       if(r){
>             return -EINVAL; // here an unlock is missing
>
>       }
>       k_mutex_unlock(&lock);
>       return 0;
>
> }
>
> On Fri, 20 Oct 2023 at 17:01, Markus Elfring <Markus.Elfring@web.de> wrote:
>       > I think you could just put
>       >
>       > ... when any
>       >     when !=  k_mutex_unlock(l)
>       >
>       > and drop the rest.
>
>       How do you think about to check the desired consistency of lock scopes
>       in more detail?
>
>       Will any software extensions become helpful for further source code analyses?
>
>       Regards,
>       Markus
>
>
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
--8323329-2082133510-1698126760=:3911--
