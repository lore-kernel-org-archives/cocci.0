Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0947EB64D7
	for <cocci@archiver.kernel.org>; Tue, 20 Jun 2023 21:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RcQxkmi3H+pBUti01RpmMpaFS+X4DBbN5xBhFxMfA7I=;
  b=uJncs9fYcr3xElT1UwKDAI6+KUh8Ie3iDuEfYaKEahjNt4TKnw6q5doE
   bP0ZPxGCvegTXGJRaM/MDXUl7RA3vRL+nHyhYXGl4lxdszEQtCoFrTjRt
   6VdATD4v2cXQMBDONkICY1Nx3b64SmWtu4Gbx2SBD/5TWK0uZGfoOfCTK
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.00,258,1681164000"; 
   d="scan'208";a="113864841"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2023 23:51:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B67F8E0157; Tue, 20 Jun 2023 23:51:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 459D4E0157
	for <cocci@sympa.inria.fr>; Tue, 20 Jun 2023 23:51:26 +0200 (CEST)
IronPort-SDR: 64921f5c_JtJma/py/n41q+aR6I1IL2U2TUwwGg8dKKKi0xmiW1MsS9V
 yitFqVHecPJk5cACKEOGqM4g2fUj0+Is+XsgTXA==
X-IPAS-Result: =?us-ascii?q?A0GcBwBBHpJk/0Xcza1aHgE8DA4LCYQCB25VMQQLRwiTd?=
 =?us-ascii?q?4InhDaaeT4PAQMBDTkLBAEBAwSBTIMzAoYDAh0GBjQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAUBAoEGE4VoDYI3KQERZE07AQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINQjYBAQEBAgEnEz8QCxguVwaDE?=
 =?us-ascii?q?QGCOSMDEQavBniBATOBAa5DBoFCkWAnG0CBTYEVJ4JTMT6CYgICGIgIBI4mh?=
 =?us-ascii?q?WUHi0+BKG+BHoEgegIJAhFngQgIX4FzQAINVAsLY4EcglICAhEnExRSeBsDB?=
 =?us-ascii?q?wOBBRAvBwQyHwkGCRgYFyUGUQUCLSQJExVBBINYCoENPxUOEYJaKzY/G1GCI?=
 =?us-ascii?q?zcDRB1AAwtwPTUUHwYmAUmBVzCBRgojJKAYA4NvIi8QgV5BpD+gKIQSi3yVC?=
 =?us-ascii?q?RkvlyGSN5gZjVuaXYFBOSaBWR8UGggmCoMjTgMZD44sFoNSkBkkMTsCBwsBA?=
 =?us-ascii?q?QMJi0gBAQ?=
IronPort-PHdr: A9a23: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
 TVmNUVAsu/IhR4=
IronPort-Data: A9a23:lfMUu6x18EePXMPvQlx6t+cywirEfRIJ4+MujC+fZmUNrF6WrkUDz
 TFMXW7VbvyLMWr1edwlb9yx8xgBuZ/cnINkQQBtqVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjg2Yc3l48sfrZ80sx5qyq41v0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFOwzv9cJW8dF7FB0fc0BDsT7
 fpfdQ0CO0Xra+KemNpXS8FploIuM8nmMYcSoDdmwC2x4fQOGM+YBf+SuJkChm922JEm8fX2P
 6L1bRJkax/LYjVLO0wLE9Qzg+eli33yaXtepU79Sa8fujGInFItgOO9WDbTUte2RPcSwRqKn
 GD94X+jGkwWF+bP1BPQpxpAgceUwX2gCd1CfFGizdZhh1aYx0QIGRgOXB26p+O4gwiwQbp3L
 0UL8y4qhboz8UaxR5/8WQe5qTiKpHYht8F4Fv185R6Nx6fQ7hzfAGUYJtJcVDA4nJM7Tw4D+
 HSjo4rCFH9q6uCNTzXAy7jB+FteJhMpBWMFYCYFSy4M7N/ivJw/g3rzczpzLEKmpoaqRmyok
 lhmuAB71upD15dav0mu1Qmf22rEm3TfcuIiCuzqso+N6xM/aZGlaoGs5EKd6/tcRGp4crVjl
 CNU8yR9xLpSZX1oqMBraL9VdF1Oz6/ZWAAweXY1Q/EcG82FohZOvel4uVmS3ntBPMceYiPOa
 0TOow5X75I7FCL0PfAtM9/gVp50nfCI+THZuhb8NYEmjn9ZL1Tvwc2TTRTNgQgBbmBz+U3AB
 XtrWZ3wUy1LVvQPIMueSvgd3LIvyzo/w2iWHcmT8vhU+eH2WZNUIJ9bWGazghcRtfjf/lyPr
 4YHbqNnCXx3CYXDX8UeyqZLRXhiEJTxLcqeRxV/J7bZcDl1UnosEeHQyr4Hcolo1fYd3OTR8
 333HgcSxFPjjDeVYU+He1JyWoPJBJxflHMcOTBzHFCK33N4X52jwp1CfLQKfJ4m1tdZ89hKc
 9c/df6tOM9/Egb8x2xFbL3WjpBTSxCwtAffYwuneGceerBjdSzo+/jlXBDmxA9WBTvqscdko
 7mS6RPfSpteWjZSNcfyQ9CsxmOXonIytr9TXUzJA98LY2Tq0tFgBBLQh88NAfMnCEv81B6F8
 S2JEDEkpeXpiK0kwunj3Kyrgd+gLLpjIxB8AWLe04eTCQDb2WiSmal7T+eCeGHmZlPeoamNS
 71c8KDhDachgl1PjotbFoRrx4IY4//EhedT7iZgLUXxQ2WbMJFSCVjY4pAXrYxI/KFThiWuU
 EHW+tV6B6SACPm4LHEvfjgafsax/tBKvAmK9vkkAlTI1Aku9pq9bEhiFR2tiitcEbhLDL0Y0
 doR4PAx1QjupScpY/Cnjz9V/VuiNnYvcbsqnbBEDZ7JijgE8EBjY5vdAADy8p2vTsh+AkUtE
 ACqn5jypqlWw3SaUnssFEri2fhWqoQOtStrkn4DBQWtsfjUisAn2CZ+9WwMcT1U6RFcwcdfA
 3NONXApFZ6R/jxtutdPb1qsFy5FGhed3E77kHkNq0H0UGiqUTbrAFAmGOPQ4n0czX1QTgJb8
 J6c1mzhdzTgJ+P1/ykqXH9au+7RdsNw+iLCifKYMZy8RbdiWgXcg4iqeWYsgDnkC5lohET4+
 M9bzNwpYqj/bSMts6k3DreB7ospSTeGGj1mYepg96Y3D23jaGmM+TyRGXuQJOJJBdL3qHGdN
 eI/B/hyRyyf1TmPpA81HaQjAaF5t9936csgeoHEH38nsbyepApmraDg+i/Mu1EwceVPjMw4F
 Nvwdi2DIEOUl3B7i2/Al+gaG2uaMP0vRhzw4/Cxy8oNT6k8ieBLdVog95eNpFCXDVdXxA2Vt
 wb9eKPm9exu5oBylY/KEK8YJQGLBf7sdeaPqiafjs9vaI7RDMLwqA8lkFnrEABIN783Wd4st
 7Csssby7XzVroQNTGHVtJmQJZZnvfzocrJsDfv2C31GkQ+peszmuUID8l/lD615qopW483/S
 jaobMe1S8UuZO5c439rOhhuS0NXT+y9a6r7viqyosidEhVXg0SNMNqj8mSvdm1BMDMBP5rlE
 ALvpvKy/ZZioZ9RAAMfTeRTa3OizIQPhYN9HzEwidWZMoVsqlaS/Lb9lRct7TzRTH+JDK4WJ
 H4DqgfWLHyPVGPglbm1cLCeejUTDW1hmq89YUIQ9tp7kXa8AXJuwSHx93kZIsk8r8Exva0Uo
 BnJbXA+EmPwQjRJfBHx+pLlUxv36ini/DvmDmRBwn54oBtayG9N7HWNO8ugD7pLluPf8dya
IronPort-HdrOrdr: A9a23:Wl+e0q8EhodYDO9Jwaluk+DcI+orL9Y04lQ7vn2ZKCYlC/Bx9a
 iV88jzuiWbtN98YhAdcJW7Scy9qBDnhPhICOsqTNOftWDd0QPCQe1fBMnZslrd8kbFh4xgPM
 lbE5SW1+ebMXFxh6/BkWqFL+o=
X-Talos-CUID: 9a23:b7Dz0G6v27LtSa0oj9ssqEMeKOkLWVfhlVzBYEriVH5vD+CoRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AKNXdFAxa3bWkGSL1+3ClSt0OsNeaqK+SCXJKzsk?=
 =?us-ascii?q?Ugcu/KzcqI2qRrw7nX6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,258,1681164000"; 
   d="scan'208";a="113864838"
X-MGA-submission: =?us-ascii?q?MDGSpvi4t6ak8kwRdjBw8WzhtWPS96RR+epcMw?=
 =?us-ascii?q?kcqQWkCKi/yTkSv/qwsbtvb1r2pEZw2uXq2+eQ0Tu+Kp2QSzF0vOsjF9?=
 =?us-ascii?q?9qkhB3bNnLE1vCxsQk9la/9TAjge18FfQQIXud8FOz5z9inSXF23FiuT?=
 =?us-ascii?q?qh1pUrwSbci24yaqJrJnKsMA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:51:25 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id C8F8685;
	Tue, 20 Jun 2023 14:51:22 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4L2MpMrhIr2F; Tue, 20 Jun 2023 14:51:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id A0BC345;
	Tue, 20 Jun 2023 14:51:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net A0BC345
Date: Tue, 20 Jun 2023 14:51:21 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <b914282b-799c-cbd8-a381-da8d2d3b97b6@inria.fr>
Message-ID: <7911da1f-ccd6-a3ea-fd38-92e6de4c222@ewheeler.net>
References: <b28e953-86e3-a6bb-fc84-1d2794a81135@ewheeler.net> <b914282b-799c-cbd8-a381-da8d2d3b97b6@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Strange spatch behavior while patching an array of
 structs
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 1202
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/7911da1f-ccd6-a3ea-fd38-92e6de4c222%40ewheeler.net>

On Tue, 20 Jun 2023, Julia Lawall wrote:
> > Question:
> >
> > Why did spatch match R in "R->cal[0].X" as "rotors" and drop the array
> > index "[i]" all together to replace as follows?
> >
> > 	-rotors[i].cal[0].deg
> > 	+rotor_cal_min(rotors)->deg
> >
> > Note that the spatch specifies "R->" , not "R." nor even "R[n]." ; it is
> > as though spatch interpreted it as follows:
> > 	-R[n].cal[0].X
> > 	+rotor_cal_min(R)->X
> >
> > ...so for some reason it picked up "rotors[i]" as "R" and replaced it with
> > just "rotors"...which, is indeed a pointer, but looses the meaning as
> > being a pointer to the beginning of the array indexed by "[i]".
> >
> > I am confused as to why it matched "rotors[i].cal" at all. It should not
> > have matched "rotors[i]" at all, right?
> >
> > Is this a bug, or an error in my understanding of SML?
> 
> This is due to an isomorphism, that is apparently not as good an idea as
> it first seemed.
> 
> Put between the initial @@ of your rule:
> 
> disable ptr_to_array

Got it, thanks! 

By the way, I watched the "OS Scheduling with Nest" talk that you gave
at LPC, well done.  It is a great concept and I hope that Nest or
something similar finds its way into Linux.

--
Eric Wheeler


> 
> julia
> 
> >
> > References:
> >
> > [1] https://github.com/KJ7NLL/space-ham/blob/master/main.c
> > [2] "Track the Space Station and OreSat Satellites with a LEGO Rotor..."
> > 	https://www.youtube.com/watch?v=vrlw4QPKMRY
> >
> > --
> > Eric Wheeler
> >
> 
