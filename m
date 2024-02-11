Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B158FC4829B
	for <cocci@archiver.kernel.org>; Sun, 11 Feb 2024 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aPv+GPhFLMj+o3q5UJMwI9V/su/kkKNMmZFd/FnTAG8=;
  b=CDijPoGJzFdAFGbHp4b4q9UUHBQcrUJOsani4huQOQ3vdp110ofQqqsf
   xUOXu1KcT1jHsV4jmL1wXMRGgJKTuGVukYgXs7Rzwy+sHeDJ4CAUZkGg5
   Z594PUu0vZOGvMF2XwLj63dANcaBHOpu5zjPYxKVw9JmvMrnPAxfjSSKA
   c=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.05,260,1701126000"; 
   d="scan'208";a="151352383"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2024 11:29:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E059CE0CD5; Sun, 11 Feb 2024 11:29:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 72212E008A
	for <cocci@sympa.inria.fr>; Sun, 11 Feb 2024 11:29:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aPv+GPhFLMj+o3q5UJMwI9V/su/kkKNMmZFd/FnTAG8=;
  b=RF91rPSHPLBRo6bi6FhnSfQmt26VOD66TAnx8DKrN4S+ps/g7Io8Iuw4
   JN47BKHLgCrYBmYXjPT3lorIKdTaenJQKzTeOsMUi2JVanMiirLEBX1k9
   s2DCFyAw0mZu8yRFnt9AmsMfHF0cbeJpMVumqqbNbRrNWPV1Ehety1w75
   A=;
X-IronPort-AV: E=Sophos;i="6.05,260,1701126000"; 
   d="scan'208";a="151352382"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 11:29:08 +0100
Date: Sun, 11 Feb 2024 11:29:08 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <3c9ba0a0-d428-42c3-a6d0-08d2d27780f4@web.de>
Message-ID: <alpine.DEB.2.22.394.2402111128400.53569@hadrien>
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de> <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de> <alpine.DEB.2.22.394.2402110938330.53569@hadrien> <3c9ba0a0-d428-42c3-a6d0-08d2d27780f4@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1596820201-1707647348=:53569"
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1544
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402111128400.53569%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1596820201-1707647348=:53569
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 11 Feb 2024, Markus Elfring wrote:

> >> Will such data achieve any software improvements?
> >
> > Since you haven't provided any test data and since the file that you
> > reference is not part of Linux 6.8-rc3,
>
> I referred to a source file from the software “Linux next-20240209”
> which is obviously available.
>
>
> > I'm not going to look into this.
>
> I suggest to reconsider this response.
>
>
> > First, please use --debug --verbose-ctl-engine and see if you can figure
> > out the answer yourself from the output.
>
> I hope that development interests will grow for better software run time characteristics.
>
>
> > If you can't figure out the answer and you want to pursue this, please
> > send back one email that includes both the esmntic patch above and a
> > single function that illustrates the problem.
>
> Would you become interested to extend software tests also together with
> the attached two files?

Thanks for providing the semantic patch and a small excerpt of C code in a
single email.

julia

>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> time spatch ../Probe/slab-depot-excerpt-20240209.c delete_redundant_if_statement4.cocci
> …
> real    0m0,249s
> user    0m0,221s
> sys     0m0,018s
>
>
> Regards,
> Markus
>
--8323329-1596820201-1707647348=:53569--
