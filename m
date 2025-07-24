Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09F0C87FCC
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=mMPzGnKiD2yUKLD5LDyrioe7Pr5EOQXaxgIb/HYACbc=;
  b=lpb85CYpvEg3+NXKSR2en00nDZiRB7ERvw9tC0R6B1+QPdu5LfplrP9f
   3PDfIDrTNQzCZYpJv19vi8UuXZocKxygETvmHqaScYvEg2a7BmzSDW7Ma
   w3JxnV5QKY0zc/TvvL9NhtCiTxIuvkHcHEOy+SJ9B9re3yDZed1alsCWJ
   o=;
X-CSE-ConnectionGUID: qmdMESiORQKs3eFdBBKIKA==
X-CSE-MsgGUID: 4Fxr01yIR4mGGOWd4nQ9GA==
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
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233017549"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 17:25:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5D4F3E0172; Thu, 24 Jul 2025 17:25:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C7AE4E0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 17:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=mMPzGnKiD2yUKLD5LDyrioe7Pr5EOQXaxgIb/HYACbc=;
  b=RHw38mj7nB/1jqIEypEuCUNHNgWQtVYY9iRxzxtk+QhVPqfmwRqxTuNE
   ZiGnfhmFFkn7JVB9zvFVwYtY1znIUl+6IATvQM6lw6AfwJiWK0OHqQGj3
   QsCpCybJBIiBYxYrAHMewb0fvhOVw0xbgUTfHNkrjMyGCNa4PDN+Bcjma
   A=;
X-CSE-ConnectionGUID: m1kj579SSU2Byj7B//QIhA==
X-CSE-MsgGUID: iZj1R2CwS0yTJawtR5Ar5Q==
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="122131790"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 17:25:39 +0200
Date: Thu, 24 Jul 2025 17:25:38 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <e1366c81-c634-408a-8c53-2d16600f7bfc@web.de>
Message-ID: <7b288440-f620-5376-876d-6239e8545fec@inria.fr>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de> <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr> <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de> <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr> <e1366c81-c634-408a-8c53-2d16600f7bfc@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-985640669-1753370723=:3509"
Content-ID: <c3a19831-da3f-b055-6735-965d55e9d4dc@lip6.fr>
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2912
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/7b288440-f620-5376-876d-6239e8545fec%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-985640669-1753370723=:3509
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <5636153e-8a74-2ae4-6d1d-c1725aea341d@lip6.fr>



On Thu, 24 Jul 2025, Markus Elfring wrote:

> >> * Why is the diff marking missing for the first lock call so far
> >>   (within the implementation of the function “handle_uaudio_stream_req”)?
> >>
> >>
> >> I would appreciate further advices.
> > I would think you should do:
> >
> > @r exists@
> > expression x, y;
> > position p1,p2,p3,p4;
> > @@
> > mutex_lock(x);@p1
> >  ...
> > mutex_lock(y);@p2
> > ...
> > mutex_unlock(x);@p3
> >  ...
> > mutex_unlock(y);@p4
> >
> > And then use a python rule to print p1, p2, p3, p4.  That way you will keep
> > the different matches separated.
>
> I miss still a corresponding answer for my original question.
>
>
> Can the Coccinelle software handle call orders correctly also according to
> passed (different) expressions?

I don't particularly understand the question, but Coccinelle knows about
the control flow, so it would seem that all is ok.

julia
--8323329-985640669-1753370723=:3509--
