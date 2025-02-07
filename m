Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C4BC02192
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2025 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Nf5hrrRrQgk71r5k/UccHKJNWTsQk+y0ZaQYqnPp+HU=;
  b=MfO0qROidZLyKMjyn/Ffrg9Eg3BfMfyfOWqqtcjuqLzmPQ70n9jZlnnP
   /zV1BHdHMtGP9zX4698SHe8ZI4aazTnkZkAQYCaW39QtizY+21aDovV1z
   h1XJiZmkcbastQSPlTD9+b7R3d9boplfNUII1N9NoSvDvPKKq/werPdcg
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.13,266,1732575600"; 
   d="scan'208";a="207093496"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2025 08:55:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 92229E0D1E; Fri,  7 Feb 2025 08:55:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 45A33E0264
	for <cocci@sympa.inria.fr>; Fri,  7 Feb 2025 08:55:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nf5hrrRrQgk71r5k/UccHKJNWTsQk+y0ZaQYqnPp+HU=;
  b=NDHV9lPaCqakly8/hqVNmRmGHGskKpxRVHFiYMaNfe64RRAcBslLt5qI
   XOD5A0MU9LsstTtmpL09+pIdpRLGBT8OSVKDpqJcEeWRxzQ4WaKjYgIqp
   ffUgfnklgg2yIPZ5BrOS4NP5E9ExopgEtwfC8HQmTgO41uKPnng4v/uSA
   I=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732575600"; 
   d="scan'208";a="207093468"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:55:07 +0100
Date: Fri, 7 Feb 2025 08:55:07 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <9bfe9c42-ef0c-44ae-a71b-26207e9083ad@web.de>
Message-ID: <be231f53-bc7e-6aae-497d-ec83859957b@inria.fr>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net> <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net> <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr> <9bfe9c42-ef0c-44ae-a71b-26207e9083ad@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-629933016-1738914907=:3651"
Subject: Re: [cocci] Checking software run time characteristics
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2367
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/be231f53-bc7e-6aae-497d-ec83859957b%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-629933016-1738914907=:3651
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 7 Feb 2025, Markus Elfring wrote:

> > You can try --profile to find out what it is spending the most time on.
> Would you like to clarify measurement data (like the following) any further?

It seems that the rule starting on line 4 is very slow?

Maybe that is the only rule in the semantic patch and the information is
not very helpful.

julia

>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> time spatch --profile delete_statement1-Johannes_Berg.cocci extract-ieee80211_get_mbssid_beacon_len-20250206.h
> …
> diff =
> warning: rule starting on line 4, node 52: [fortrue][1,2,17,18,19] in ieee80211_get_mbssid_beacon_len may be inconsistently modified
> warning: rule starting on line 4, node 55: statement[1,2,17,18,19,20] in ieee80211_get_mbssid_beacon_len may be inconsistently modified
> warning: rule starting on line 4, node 30: [fortrue][1,2,6,7,9,10,12] in ieee80211_get_mbssid_beacon_len may be inconsistently modified
> warning: rule starting on line 4, node 33: statement[1,2,6,7,9,10,12,13] in ieee80211_get_mbssid_beacon_len may be inconsistently modified
> warning: rule starting on line 4, node 51: for[1,2,17,18,19]* in ieee80211_get_mbssid_beacon_len may be inconsistently modified
> warning: rule starting on line 4, node 29: for[1,2,6,7,9,10,12]* in ieee80211_get_mbssid_beacon_len may be inconsistently modified
> …
> Note: processing took  1083.7s: extract-ieee80211_get_mbssid_beacon_len-20250206.h
> ---------------------
> profiling result
> ---------------------
> Main total                               : 1083.707616 sec          1 count
> Main.outfiles computation                : 1083.691804 sec          1 count
> full_engine                              : 1083.691654 sec          1 count
> bigloop                                  : 1083.679190 sec          1 count
> Rule rule starting on line 4             : 1083.679188 sec          1 count
> process_a_ctl_a_env_a_toplevel           : 1083.676273 sec          1 count
> mysat                                    : 1083.676131 sec          1 count
> ctl                                      : 1083.674814 sec         35 count
> pre_engine                               : 0.015786 sec          1 count
> parse cocci                              : 0.015455 sec          1 count
> show_xxx                                 : 0.010977 sec         11 count
> HACK                                     : 0.010574 sec          5 count
> Common.full_charpos_to_pos               : 0.002770 sec          2 count
> C unparsing                              : 0.001845 sec          2 count
> Parsing: 1st pass                        : 0.000956 sec          8 count
> YACC                                     : 0.000933 sec          8 count
> C parsing.fix_define                     : 0.000724 sec          5 count
> C parsing.lex_ident                      : 0.000611 sec       1418 count
> LEXING                                   : 0.000462 sec          4 count
> flow                                     : 0.000359 sec          4 count
> C parsing.fix_cpp                        : 0.000349 sec          4 count
> MACRO mgmt prep 1                        : 0.000301 sec          4 count
> asttoctl2                                : 0.000281 sec          1 count
> TAC.annotate_program                     : 0.000257 sec          2 count
> C parsing.lookahead                      : 0.000182 sec        546 count
> C consistencycheck                       : 0.000140 sec          4 count
> Transformation3.transform                : 0.000127 sec          1 count
> Type_c.type_of_s                         : 0.000085 sec         23 count
> Common.info_from_charpos                 : 0.000070 sec          2 count
> worth_trying                             : 0.000058 sec          1 count
> fix_flow                                 : 0.000051 sec          2 count
> C parsing.mk_info_item                   : 0.000050 sec          8 count
> Common.=~                                : 0.000043 sec          6 count
> MACRO mgmt prep 2                        : 0.000017 sec          4 count
> Main.result analysis                     : 0.000010 sec          1 count
> TAC.typedef_fix                          : 0.000009 sec         58 count
> TAC.add_binding                          : 0.000008 sec         10 count
> C parsing                                : 0.000006 sec          4 count
> check_duplicate                          : 0.000006 sec          1 count
> post_engine                              : 0.000006 sec          1 count
> Main.infiles computation                 : 0.000001 sec          1 count
> TOTAL                                    : 0.000000 sec          4 count
>
>
> real    18m3,734s
> user    18m1,192s
> sys     0m1,021s
>
>
> Regards,
> Markus
>
--8323329-629933016-1738914907=:3651--
