Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4839CC43334
	for <cocci@archiver.kernel.org>; Sat, 25 Jun 2022 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=U/c6A5OWjqYBDrW+c+VUoGvvO4Sc4mNc8OKZ7bjkZgE=;
  b=KmyyXhs56vjdPsxNRcAJKId2R1p/foENRIOExvjUaQyxxG5xQaPClL8L
   6SoIvsa6ePNx6WOkaoTmC+ScYLuMUmIN8iCaFD7WqxbljOoxQAo51UHIs
   QI+tQSANMgJi+Lkk9KCJfNa+TQwdVo7ZX8ACxUWOjVEH9PUvmb6B8mav0
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208";a="42853200"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2022 20:33:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7A8BAE00F5; Sat, 25 Jun 2022 20:33:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6386DE00BE
	for <cocci@sympa.inria.fr>; Sat, 25 Jun 2022 20:32:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U/c6A5OWjqYBDrW+c+VUoGvvO4Sc4mNc8OKZ7bjkZgE=;
  b=NAW5TrgIUTAecUirjYiJGpfaP7v6Bi1Ngazo/f5VvDRLtpN9gWuSQcyZ
   lGlzK9bBlnf7q5m3hv7Oc3nOtR4crFm6qHOHNastRX5qBZNgZ8cReHeau
   TTFF+m7frDhgWYQXKuS8+7mq/0lqWlRPIal8245qQ0RNQDiRWEypnPbvK
   w=;
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208";a="17765084"
Received: from 71-51-169-39.chvl.centurylink.net (HELO hadrien.PK5001Z) ([71.51.169.39])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 20:32:55 +0200
Date: Sat, 25 Jun 2022 14:32:52 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Lucian Popescu <lucian.popescu187@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAEUDFgXAX=0ECa4Um9uOzRCBtF2arHjTAF+Kp_UAvkzEafboOg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206251431460.2146@hadrien>
References: <CAEUDFgXAX=0ECa4Um9uOzRCBtF2arHjTAF+Kp_UAvkzEafboOg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-462688887-1656181975=:2146"
Subject: Re: [cocci] Coccinelle does not parse macros ending in a comma
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 460
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206251431460.2146%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-462688887-1656181975=:2146
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 25 Jun 2022, Lucian Popescu wrote:

> Hi,
> I ran spatch --parse-c on the following code:
>
> #define something 0,
>
> int main() {
>     return 0;
> }
>
> This code compiles fine according to the C standard, however the output of
> spatch is:
>
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
>
> PARSING: test.c
> ERROR-RECOV: found sync end of #define, line 1
> parsing pass2: try again
> ERROR-RECOV: found sync end of #define, line 1
> parse error
>  = File "test.c", line 1, column 20, charpos = 20
>   around = '',
>   whole content = #define something 0,
> badcount: 0
> BAD:!!!!! #define something 0,
> -----------------------------------------------------------------------
> maybe 10 most problematic tokens
> -----------------------------------------------------------------------
> something: present in 1 parsing errors
> example:
>        
>        #define something 0,
>        
> -----------------------------------------------------------------------
>
> Is this a known limitation? If not, is there a way to solve this issue?

This is the expected behavior.  Is there something that ou want to do
withe macro definition?  The inability to parse that shouldn't impact the
ability to treat other code, at least not other code that doesn't use the
macro.

julia
--8323329-462688887-1656181975=:2146--
