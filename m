Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF7BC02198
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2025 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=R+gQbrCAVzlG7AtcaPN6n9Ko//yscMUh7PbOYO6d1H0=;
  b=kjSGR+KBFGA4yBeApWptFbzhTmds8Ddl5oT2velJJPP8T4LA5GjGhYQa
   nMZeiG2JKUGQQRbHnVWXIaGDB4Vws2nfzv6VeXdRSQtqaeDguSmf9kuI8
   yA9UvPg6M2dxV3nK3HeNOHtuvj1Rm7YFK3dJRPKQZrpbsRDgHNGQnH2KO
   M=;
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
X-IronPort-AV: E=Sophos;i="6.13,270,1732575600"; 
   d="scan'208";a="207293237"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2025 16:43:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B8A3BE0D1E; Sat,  8 Feb 2025 16:43:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9594DE0260
	for <cocci@sympa.inria.fr>; Sat,  8 Feb 2025 16:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R+gQbrCAVzlG7AtcaPN6n9Ko//yscMUh7PbOYO6d1H0=;
  b=jb55unhZVeoIz/+OJJ5jfaowuZrz2OS84lAn+ImvfjRzjdlSV7oRgM6i
   aL7aVXg+ybD4brsALysJUnRsNnzgKpqnYUn6qJdlkuDoDEdQohX0ou7DY
   oZzmXuvEHFwoIBy3LpncojV4d2ODkJIZymeueCmB/64ZuuDlygWkO1VTN
   U=;
X-IronPort-AV: E=Sophos;i="6.13,270,1732575600"; 
   d="scan'208";a="207293232"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 16:43:15 +0100
Date: Sat, 8 Feb 2025 16:43:15 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr, 
    Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <e25d4a68-1ef5-4ceb-b3d8-b05dd9ed512c@web.de>
Message-ID: <alpine.DEB.2.22.394.2502081642570.15422@hadrien>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net> <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net> <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr> <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
 <6bbdaca7-2fa0-4bdf-bdc7-ba76a5a1d171@web.de> <alpine.DEB.2.22.394.2502081257090.15422@hadrien> <e25d4a68-1ef5-4ceb-b3d8-b05dd9ed512c@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1077018634-1739029395=:15422"
Subject: Re: [cocci] Checking SmPL test cases?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2375
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/alpine.DEB.2.22.394.2502081642570.15422%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1077018634-1739029395=:15422
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 8 Feb 2025, Markus Elfring wrote:

> > The matched if doesn't occur on every control-flow path.
> Will further collateral evolution happen according to a test result like the following?

Now the pattern occurs on every control-flow path.

julia

>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> time spatch delete_statement3-Johannes_Berg.cocci test3-beacon_len-20250206.c
> …
> diff =
> warning: deletion, node 22: for[1,2,4,5,7,8,10]* in my_beacon_len may be inconsistently modified
> warning: deletion, node 23: [fortrue][1,2,4,5,7,8,10] in my_beacon_len may be inconsistently modified
> warning: deletion, node 40: [fortrue][1,2,13,14,15] in my_beacon_len may be inconsistently modified
> warning: deletion, node 26: statement[1,2,4,5,7,8,10,11] in my_beacon_len may be inconsistently modified
> warning: deletion, node 39: for[1,2,13,14,15]* in my_beacon_len may be inconsistently modified
> warning: deletion, node 43: statement[1,2,13,14,15,16] in my_beacon_len may be inconsistently modified
> …
> @@ -11,18 +11,8 @@ my_beacon_len(struct cfg80211_mbssid_ele
>
>         if (i < elems->cnt) {
>                 len = elems->elem[i].len;
> -               if (rnr_elems) {
> -                       len += rnr_elems->elem[i].len;
> -                       for (i = elems->cnt; i < rnr_elems->cnt; i++)
> -                               len += rnr_elems->elem[i].len;
> -               }
>                 return len;
>         }
>
> -       if (rnr_elems) {
> -               for (i = 0; i < rnr_elems->cnt; i++)
> -                       len += rnr_elems->elem[i].len;
> -       }
> -
>         return len;
>  }
>
> real    0m2,146s
> user    0m2,105s
> sys     0m0,023s
>
>
> Regards,
> Markus
>
--8323329-1077018634-1739029395=:15422--
