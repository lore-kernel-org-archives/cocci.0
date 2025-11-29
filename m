Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54035D116EA
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Ry82eHt8polF04Qj5ysw5fJlUxJk0wsoSpIdICiIg4E=;
  b=uafoYjkPKWSETwgyaj+GdKrYzMw8ddMw4ZdSxnh69OxfCU6uCojngd8O
   S50uiLF7aEIFCorlu4YV988pF1ny+DoTWPaLlLmjFUnV24nmepPTP7slY
   XDPV8PpDjakgVg4/8plSQo5r6n/8gSi3akp89/uwG2Jk0IRky+oMv5heS
   A=;
X-CSE-ConnectionGUID: cR1hbWhyRuSZtCOavDYiOA==
X-CSE-MsgGUID: 0Pi93sRuTViOrsBUzB03/Q==
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
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251889452"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 14:51:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7AF92E0157; Sat, 29 Nov 2025 14:51:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 52099E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 14:51:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ry82eHt8polF04Qj5ysw5fJlUxJk0wsoSpIdICiIg4E=;
  b=CiFyuaFyLfHh2Cq8mcDNmIxdNKPF94UDwvHSdEAmFXGl15lXb+NqJM3W
   MaRi349cqzFEzO8iXI4IqHKcq3202iVNAteU0+5FlgjpnJW2XPz6zNTyb
   c+Ys9JSPs/GH7To2XZXJ8iSeIa43edDkb+GTm0snZ0iK6LrU4keahZoGR
   I=;
X-CSE-ConnectionGUID: ag4wjsYWSD2it8jvIUSuWw==
X-CSE-MsgGUID: Y85zUTfMTbOXBfIty0kJqw==
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="132281878"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 14:51:44 +0100
Date: Sat, 29 Nov 2025 14:51:42 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Tobias Deiminger <tobias.deiminger@posteo.de>
cc: cocci@inria.fr
In-Reply-To: <2897bda0c438111e967017f6bb3422f0@posteo.de>
Message-ID: <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de> <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr> <2897bda0c438111e967017f6bb3422f0@posteo.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-25751001-1764424303=:16087"
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3208
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/caf02577-eee9-d55d-1f42-7b1f3bd2f60%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-25751001-1764424303=:16087
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 29 Nov 2025, Tobias Deiminger wrote:

> Hi Julia,
>
> Am 29.11.2025 11:56 schrieb Julia Lawall:
> > On Sat, 29 Nov 2025, Tobias Deiminger wrote:
> >
> > > Hi,
> > >
> > > my newbie assumption was we could match the following by macro name
> > >
> > >   // my.c
> > >   SYSCALL_DEFINE0(foo_bar) { return; }
> > >
> > > using this rules
> > >
> > >   // my.cocci
> > >   @r@
> > >   identifier fn =~ "SYSCALL_DEFINE[0-6]+";
> > >   position p;
> > >   @@
> > >   fn@p(...) {...}
> > >
> > >   @script:python@
> > >   fn << r.fn;
> > >   p << r.p;
> > >   @@
> > >   print(f"match: {fn} at line {p[0].current_element_line}")
> > >
> > >
> > > Turns out, SYSCALL_DEFINE0 is a "known macro" from
> > > /usr/lib/coccinelle/standard.h. In this case coccinelle seems to match an
> > > identifier on the expanded function name, not the macro name. I.e., this
> > > would
> > > work:
> > >
> > >   identifier fn =~ "foo.*";
> > >
> > > But I really want to search all syscalls by the conventional macro names,
> > > i.e.
> > > search for SYSCALL_DEFINE[0-6]+. How to do that?
> >
> > The problem is that the code won't parse with the conventional macro
> > name.  Maybe you could change the macro definition in standard.h to put eg
> > __SYSCALL_DEFINE0 in front of the function name?  That would be considered
> > to be an attribute and then you could put __SYSCALL_DEFINE0 as an
> > attribute name in your semantic patch.
>
> sorry for having to ask again. Your suggestion sounds very reasonable. But I
> couldn't figure out how to match on attributes. I guessed it would be
> something like this
>
>   @r@
>   attribute a;
>   identifier fn;
>   @@
>
>   a fn(...) { ... }
>
> But that gives a .cocci parse error:
>
>   minus: parse error:
>     File "my.cocci", line 6, column 2, charpos = 38
>     around = 'fn',
>     whole content = a fn(...) { ... }
>
> Expected, IIUC, since attribute doesn't occur in fundecl from grammar:
>
>   fundecl ::=  [fn_ctype] funinfo * funid ([PARAMSEQ(param, ε)]) { [stmt_seq]
> }
>
> How else to look for functions with attributes then?

The return type for the function is required in this case:

@r@
attribute a;
identifier fn;
types t;
@@

* t a fn(...) { ... }

julia
--8323329-25751001-1764424303=:16087--
