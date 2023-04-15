Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE57C7619A
	for <cocci@archiver.kernel.org>; Sat, 15 Apr 2023 05:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=1UtPPcEUbFiFpXAEl78PphjtzsPLMg0QnyHXgSTYm74=;
  b=hrtHU/tBYkrHUQ9m8UwkAUItqVdjRfdE4AsNNUL4qAWBw66dToI+BCgT
   TalKV8SIaZa6x5wYzQX80HFhZNj8QNdcGKk2RBUeS7R3ejW9HWhALX2xC
   X2aYlIHF3mB2X8YprMgelzvxPuZChY8Xf+3LqaVYEFTSiSPmeLmbltg8I
   g=;
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
X-IronPort-AV: E=Sophos;i="5.99,199,1677538800"; 
   d="scan'208";a="103195608"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Apr 2023 07:42:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C56C2E033B; Sat, 15 Apr 2023 07:42:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ECBFDE00A8
	for <cocci@sympa.inria.fr>; Sat, 15 Apr 2023 07:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1UtPPcEUbFiFpXAEl78PphjtzsPLMg0QnyHXgSTYm74=;
  b=HkNev3he79ayPShJmNKWOcIRrjo5OQVDGyp9Bedyik3rFzL8qppzS5EY
   2Binwhi3uimWgbsvQUEttvwfmk8zhmb20keDrDt9bEc+66nllW4n1efAo
   S2rF6bMg5rcxANaA7QiHLmmil5alVLhBCfhss0/ytsPPHjA/hZCJ4Oeo5
   M=;
X-IronPort-AV: E=Sophos;i="5.99,199,1677538800"; 
   d="scan'208";a="103195607"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 07:42:57 +0200
Date: Sat, 15 Apr 2023 07:42:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Yudi Yang <jy103@rice.edu>
cc: cocci@inria.fr
In-Reply-To: <bea8e057-44b0-4ae4-a6cc-b23bd0837270@Spark>
Message-ID: <alpine.DEB.2.22.394.2304150740450.2975@hadrien>
References: <eccc2924-6657-4776-84f1-3d8413904cf2@Spark> <bea8e057-44b0-4ae4-a6cc-b23bd0837270@Spark>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-692560742-1681537377=:2975"
Subject: Re: [cocci] Match and print size of allocation
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1054
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/alpine.DEB.2.22.394.2304150740450.2975%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-692560742-1681537377=:2975
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 14 Apr 2023, Yudi Yang wrote:

> Hello,
>
> I would like to match the size of allocation, I am wondering if I write the following:
>
> @print@
> expression N, SIZE;
> @@
>
> (
>   malloc(SIZE);

Code doesn't usually contain just malloc(...); because then the return
value would be thrown away.  You can write x = malloc(SIZE); for an
expression metavariable x.  If malloc can be used in other contexts, eg an
if header, then you can write malloc(SIZE)@S where S is a statement
metavariable.  I think that that will allow the printf to be added after
the innermost statement containing the call to malloc.

julia

> |
>   calloc(N, SIZE);
> )
> + printf(“Allocation: %d\n", (N) * (SIZE));
>
> I am not sure if I could set the default value for N in the malloc case, or is there anything I should do to make it correct.
>
> Best, Yudi
>
>
>
--8323329-692560742-1681537377=:2975--
