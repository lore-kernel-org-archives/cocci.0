Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2EFCCD183
	for <cocci@archiver.kernel.org>; Mon, 13 Oct 2025 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/KSGh+mz1eb7Y8G+KxS/eYv2a9owUNpbOQ1PhTDWdKA=;
  b=DCn027CVGOqTi/fDbipnaa0awCIPQoDALk/S5HJhPE8E/el690hME81P
   snuDFdh2icJiWIhiW7zCBfwE0bEk16YAXs+p52oLG7D/kjCTWqJbyODzn
   xPN3c2tuq2ZwL/OIHq909/lz6WStjvUnP/9ptPBtzPmlbOlFKOBrhZZgV
   I=;
X-CSE-ConnectionGUID: iByTiKJhStSVnNRNQjLLgA==
X-CSE-MsgGUID: 3LCsoZXoTkie7DYqfe+D2g==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="243948745"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Oct 2025 16:53:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9BB6EE0CF9; Mon, 13 Oct 2025 16:53:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 721BCE0C55
	for <cocci@sympa.inria.fr>; Mon, 13 Oct 2025 16:49:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/KSGh+mz1eb7Y8G+KxS/eYv2a9owUNpbOQ1PhTDWdKA=;
  b=KvMr5ajps0lMsstnqNnIiV+mwheM9xCWDqk5MTbSdWAjLflwwttT9ifT
   geVBv4YzcNIIq69TC4UdDPCjrpEtt94QKzg20KVtn8KzC5viWgxYzS4JQ
   bXdHZKo0IfTclTGXSMx0QDwCuU5h9p0XdxBu0tN6s46vjVkH3SFKJusEs
   o=;
X-CSE-ConnectionGUID: snjf87YOR5q4s1+MPM3jyQ==
X-CSE-MsgGUID: dUvK5BosRYOuCeyUGjvDyg==
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="128049442"
Received: from bb116-15-226-202.singnet.com.sg (HELO hadrien) ([116.15.226.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:49:33 +0200
Date: Mon, 13 Oct 2025 22:49:28 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, linux-cifs@vger.kernel.org
In-Reply-To: <8480276b-ee1e-454e-954f-b25890c79add@web.de>
Message-ID: <dcfb5c63-ce1a-f487-df23-cadef6c45a32@inria.fr>
References: <335b0fe9-313f-4e3d-a01d-1954f3c46489@web.de> <805f36f6-ea15-cbc9-f510-45856eb6f6d7@inria.fr> <8480276b-ee1e-454e-954f-b25890c79add@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-107936897-1760366974=:3281"
Subject: Re: [cocci] Improving source code parsing for =?UTF-8?Q?=E2=80=9C?=
 =?UTF-8?Q?fs/smb/client/dir=2Ec=E2=80=9D=3F?=
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3071
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/dcfb5c63-ce1a-f487-df23-cadef6c45a32%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-107936897-1760366974=:3281
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 13 Oct 2025, Markus Elfring wrote:

> > If you want the problem to be solved, please make some effort to narrow it
> > down to a smaller number of lines. …
>
> How do you think about to improve data processing for another source file example
> like the following?
>
>
> static int my_test_condition(void)
> {
> #ifdef MY_CONFIG_LEGACY_OPTION
>  if (0)
>     {
>         my_log("working?");
>     }
>  else
>     {
>         /* Test comment */
>     }
> my_info:
>  if (0)
>     my_log("reminder!");
>  else
>     {
> #else
>     {
> #endif
>      my_log("special part");
>     }
>  return 0;
> }

Thank you for the more understanable example.  I think it should ignore
the code under the #else since parsing is not successful when that is
taken into account.  I will try to look into it at some point.

julia

>
>
> Questionable test result (according to the software combination “Coccinelle 1.3.0”):
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch --parse-c test-ifdef-legacy3.c
> …
> PB: not found closing brace in fuzzy parsing
> ERROR-RECOV: found sync '}' at line 23
> …
> parse error
>  = File "test-ifdef-legacy3.c", line 24, column 0, charpos = 282
>   around = '',
>   whole content =
> badcount: 22
> bad: static int my_test_condition(void)
> …
> bad:  return 0;
> BAD:!!!!! }
> …
> nb good = 0,  nb passed = 3 =========> 12.00% passed
> nb good = 0,  nb bad = 22 =========> 12.00% good or passed
>
>
> Will similar test cases trigger more desirable improvements?
>
> Regards,
> Markus
>
--8323329-107936897-1760366974=:3281--
