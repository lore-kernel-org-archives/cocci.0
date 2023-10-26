Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5EAC25B48
	for <cocci@archiver.kernel.org>; Thu, 26 Oct 2023 08:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Gvdx3B2edmjmtQbHl0qV85Wa2qOq12QSdFIlAmPcBRg=;
  b=q8c4M8sOlBzsqJJ8t1Wo8+eAvsWT5kH9P/hSoqlJyoQHPs9ckl2mVbyO
   qkqoOh4fgbdPuX2H3hRr/VTDy/YwsUyqdwqatXHTKn6u583o+I67d1iXg
   rkZkXxFcLERKGBmuhqWkQ/7miVzHWenXYBzRLdwAB4rcoxm8q8QTqd8Mp
   o=;
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
X-IronPort-AV: E=Sophos;i="6.03,253,1694728800"; 
   d="scan'208";a="133264495"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Oct 2023 10:03:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 792BFE0205; Thu, 26 Oct 2023 10:03:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B8A7AE00B7
	for <cocci@sympa.inria.fr>; Thu, 26 Oct 2023 10:03:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Gvdx3B2edmjmtQbHl0qV85Wa2qOq12QSdFIlAmPcBRg=;
  b=hhVj6/oo9b3YbWmj6U4lDbfn6JZrymga5RrKJ09fLQowtI+2+EturN5N
   ESAMzFgq9riUNl+AvZASoffJ+rvvCashM0z6nnGrZHk2ofAxk0IxX8S/j
   Tf4O57cTqxTVI9CaZd74q90XsMWlshqwyCEkeZXXYk4bPJf2JoyKgDg9j
   I=;
X-IronPort-AV: E=Sophos;i="6.03,253,1694728800"; 
   d="scan'208";a="69804419"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:03:44 +0200
Date: Thu, 26 Oct 2023 10:03:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Richard W.M. Jones" <rjones@redhat.com>
cc: cocci@inria.fr
In-Reply-To: <20231026075755.GA19414@redhat.com>
Message-ID: <576bb44-711f-d649-b4f0-8180356be572@inria.fr>
References: <20231026075755.GA19414@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Report that Coccinelle doesn't compile with Python
 3.13.0a1
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1278
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/576bb44-711f-d649-b4f0-8180356be572%40inria.fr>



On Thu, 26 Oct 2023, Richard W.M. Jones wrote:

> https://bugzilla.redhat.com/show_bug.cgi?id=2246276
>
> Longer error message is in the link above, but the guts of it seems to be:
>
> Py.find_library: unable to find the Python library [/lib64/libpython3.13.so.1.0 returned Cannot resolve _PyObject_NextNotImplemented.
>
> I don't see anything about this in the release notes:
>
> https://docs.python.org/3.13/whatsnew/3.13.html

Thanks for the report.  We will look into it.

julia

>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> Fedora Windows cross-compiler. Compile Windows programs, test, and
> build Windows installers. Over 100 libraries supported.
> http://fedoraproject.org/wiki/MinGW
>
>
