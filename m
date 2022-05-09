Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69997C433F5
	for <cocci@archiver.kernel.org>; Mon,  9 May 2022 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Tr3yNYvhn9k7n2vRi8K/PY7aBsrUNqNEgXkBnOqm5WI=;
  b=hCgohHY/Kit1a9n6R8hePNj6iu0dzMkxYMI7Tg6oalKPFWTGxHlm6eME
   QachX77nOUi5lLFROemsRDV4jHQxCeSaWUw8XZJewzp+1GUW+CcZY9O1/
   FcU3d0I+Icvdhku+RBUYj+hkS0IcQSK5vnE83D02POwiwndiJp0DX9vkO
   8=;
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
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208";a="35328095"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2022 12:11:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 89D1FE01BE; Mon,  9 May 2022 12:11:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 14395E009B
	for <cocci@sympa.inria.fr>; Mon,  9 May 2022 12:11:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Tr3yNYvhn9k7n2vRi8K/PY7aBsrUNqNEgXkBnOqm5WI=;
  b=rsPdWVCxfNnOM4RMrknp8i8c5Jc0tJmhwy8DA+fl/lcmyTVA5u6F3gXd
   MQlMyb4kbKpSEVfdfRjiWT+BxdTjGNM7LBSrsLu4jZcn/2SQuQ7SLviFF
   g+TpzbjlqxG0DwnpIG6MKeRBEJ9bFm6bAufHg02gmQLWqilkTHBJZ3rKj
   k=;
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208";a="35328079"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 12:11:29 +0200
Date: Mon, 9 May 2022 12:11:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Alessandro Carminati <alessandro.carminati@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205091209180.2394@hadrien>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-64328441-1652091089=:2394"
Subject: Re: [cocci] List global variables.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 366
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205091209180.2394%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-64328441-1652091089=:2394
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 9 May 2022, Alessandro Carminati wrote:

> Hello,I need to build a tool that just lists the global variables for a
> given c project.
> It appeared to me to be a straight simple operation using coccinelle, still
> the script I wrote does not return the expected values.
> here the script
> ```
> @g@
> type T;
> global idexpression T x;
> @@
> x
>
> @script:python@
> x << g.x;
> @@
> print (x)
> ```
> And this is the simple file I used to test it.
> ```
> #include <stdio.h>
> #include <stdlib.h>
>
> static char glid[3];
> int cnt;
>
> int function(int a){
> return a;
> }
>
> int main(){
> char *p;
> int i,c;
> p=malloc(100);
> i=function(9);
> c=sprintf(p, "Nice text%d\n", i);
> puts(p);
> free(p);
> return 0;
> }
> ```
> my expectation was to get "glid" and "cnt" as product for the computation,
> instead I just get "function".
>  
> Could anybody clarify why this?

A "global" variable is a variable that is referenced by a function but is
not declared by that function.

Actually, glid and cnt are not expressions.  They are only identifiers.
So they are not matched by idexpression.

You can do what you want using some script code.  I will send you a
solution in a few minutes (I actually wanted to do the same thing :).

julia
--8323329-64328441-1652091089=:2394--
