Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7B4C27C79
	for <cocci@archiver.kernel.org>; Mon, 17 Jun 2024 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cwiZUQHyDrqC41GqnLb/x+Rsmc5CnZ1lbD+csWrr0zo=;
  b=nCmeOOjDhBwj9W1kPVjPFgQA38OPvaAkxtRlUoQDDBN3C/fek3G827/F
   IGI1r08B9lk0MynucIXiUweNd/rF8MhG7bDXyoEhMKlViQC85J/vZ5Eiq
   wM9WusYny8uE33aSVL+iHJ+UbBldgmb7pRjw8AsPrWBuejTvcrXQh3xXE
   U=;
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
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="171073047"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jun 2024 16:11:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 199ACE0AF6; Mon, 17 Jun 2024 16:11:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 63022E0131
	for <cocci@sympa.inria.fr>; Mon, 17 Jun 2024 16:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cwiZUQHyDrqC41GqnLb/x+Rsmc5CnZ1lbD+csWrr0zo=;
  b=J8pJjTeWpf9ZRSJHI/PIfR9kv7SAeJBk5dvVswBawYyxZy5nyXF1IZzL
   CgLzwSsJRep3BL+s0e9D67qH6daMPyMPdKtQukTNv2Dm1YYe3yYSJQUjA
   RLQ0+4iGe8AJOqIc7PEXHr5Ef5M34KGbeAYYH3indPERJS3PFmUy/9GR6
   s=;
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="89899819"
Received: from 111.223.107-198.unknown.starhub.net.sg (HELO hadrien) ([111.223.107.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 16:11:25 +0200
Date: Mon, 17 Jun 2024 22:11:21 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Thomas Adam <thomas@xteddy.org>
cc: cocci@inria.fr
In-Reply-To: <CAOhcEPY3QqNFMzfGT4Zy8We5Y0+SLaG=A+5YZ5+O0MZAkGEKhQ@mail.gmail.com>
Message-ID: <b4233baa-7c46-a66a-397d-8c13f32e7d88@inria.fr>
References: <CAOhcEPY3QqNFMzfGT4Zy8We5Y0+SLaG=A+5YZ5+O0MZAkGEKhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1866908347-1718633485=:3149"
Subject: Re: [cocci] Disabling code blocks from cocci
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1793
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/b4233baa-7c46-a66a-397d-8c13f32e7d88%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1866908347-1718633485=:3149
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 17 Jun 2024, Thomas Adam wrote:

> Hey all,
> Is it possible to make a rule to make spatch ignore code sections from being
> changed?
>
> For instance, say I have a rule to change calls to strdup() to xstrdup().
> What I’d like to do is something like:
>
> /* start of ignore block */
> a = strdup(“foo”);
> /* end of ignore block */
>
> Such that, for code defined between those two comments, spatch would ignore
> it.
>
> Is something like this possible?

Is it really totally random blocks that are involved?  You can also just
take a position variable and check that the code is not eg within a
particular range of lines or in a particular function.

For example

@script:ocaml@
@@

let goodcontext p =
  let p = List.hd p in
  p.current_element != "badfunction" &&
  (p.file = "good_file.c" && 10 < p.line && p.line_end < 100)

@@
position p : script:ocaml() { goodcontext(p) };
expression e;
@@

- strdup@p
+ xxx
   (e)

You can also write script code in python.  List.hd p becomes p[0].  I
think that afterwards the member names are the same in python.  Maybe the
file tests/pythonposcon.cocci can be a useful example.

julia
--8323329-1866908347-1718633485=:3149--
