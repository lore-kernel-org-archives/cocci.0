Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61CC105F7A6
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LNYgQIhXUd4O//V/uj0eiW1zPDrP1xwnUtPubn3EFnk=;
  b=sLwYNVLMUXzG/8W6v8z8bGCax8eNuIVKKBEREUIJraA7yg9iN0rml3Ti
   eNtF1EPMKfkAWLtIcZBs4ZMYq8h/fGz5AIq8rc+ds1dGEQKL2avNsLzId
   spxGvSUNzihI9w89eWCReYby1BHd+a/7DHnAvAPPQkygCYFTl65c1rtqY
   I=;
X-CSE-ConnectionGUID: SqXYZnsnRX+YUHmSvzBizw==
X-CSE-MsgGUID: 2imbMF27TICfvbzK1U5MgQ==
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
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267693646"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 15:15:32 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3AAB581DE1; Fri, 13 Mar 2026 15:15:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 26C5981DE9
	for <cocci@sympa.inria.fr>; Fri, 13 Mar 2026 15:15:29 +0100 (CET)
X-CSE-ConnectionGUID: AROJnyf5Sz252LPeXTKaPA==
X-CSE-MsgGUID: znAkxU3xTi+rdH3wiyTzxw==
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267693613"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:15:29 +0100
Date: Fri, 13 Mar 2026 15:15:29 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Alice Lee <Alice.Lee@ist.ac.at>
cc: "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <e2cb31cc2b0947d29b50188dab2e1097@ist.ac.at>
Message-ID: <36eb7fe0-99b7-7191-134a-3adbe9d41d68@inria.fr>
References: <e2cb31cc2b0947d29b50188dab2e1097@ist.ac.at>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1946142668-1773411329=:3973"
Subject: Re: [cocci] Python script interacting with non-matching files?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3428
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/7qBo19zUojKX95bop7QudA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1946142668-1773411329=:3973
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 12 Mar 2026, Alice Lee wrote:

>
> Hello,
>
> I am trying to use Coccinelle to search C code bases and I have a few
> questions.
>
>  1. Can a python script within a Coccinelle file somehow access the names of
>     files that are processed without matching the search? (Maybe there is
>     some "match all" idiom that would let me get the name of every file and
>     then move on to the relevant search?)

I don't completely understand the question.  You can attach a position
variable to some matched code and then print the file name associated with
that code:

@r@
position p;
@@

foo@p();

@script:python@
p << r.p;
@@

print p[0].file  // put proper python code here

>  2. Similarly, can a python script tell that parsing failed for a particular
>     file?

No, python doesn't have an access to the information about what could be
parsed.  There is --verbose-parsing.  But parsing rarely fails for a whole
file.  If it can't parse one thing, it will just move on to the next thing
and try from there.

julia

> Thank you,
> Alice Lee    
>
>
>
--8323329-1946142668-1773411329=:3973--
