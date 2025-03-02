Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3917C282CD
	for <cocci@archiver.kernel.org>; Sun,  2 Mar 2025 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VqYiC/Urv+QeTRVVnQ0nKRDlIMPrDZwnbgoBNCimnCs=;
  b=ZnuehtaucCi57nveCStOFOIiMDz6hy3jjZzw5rIb2LJYdz9o/z1g8K7R
   cVg37Y41qs1Wr6CplUYlvzvml1nunDDWYivu77N37YnFRJvLzvO+aEwvu
   sRkk8cuGAl58DwxkZtJfyiRTcuX6ztGMUHlIomCG9dya06ADFaKst7ZBj
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210730690"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2025 11:55:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 56D2FE0D1E; Sun,  2 Mar 2025 11:55:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7C7C3E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 11:55:44 +0100 (CET)
IronPort-SDR: 67c43930_o5TUzWzXYkg/965a0Q2tGGQRP2NcxKZZj6yZZfKFeGLD2zD
 /TFiz/3kNQHEq5B3AO7fem/IRuXjTEGZ8C18m4Q==
X-IPAS-Result: =?us-ascii?q?A0EiAAA7OMRng07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDYnUzBAtIhFaPT4F0MIQ7hzuHU4h1gVaBfg8BAwENQ?=
 =?us-ascii?q?QECBAEBAwSFAAKLFQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQE6Bw47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECA?=
 =?us-ascii?q?SMdAQERJgEECwsaAiYCAlYGARQBAYJ+gjABAw4jB69TgTKBAYIMAQEG2lwfL?=
 =?us-ascii?q?CJXgWUJgRouAYVrgmMBhiaDQnonD4FVRIE8gwM+gRmHBYJpgjOEQGeaDo5XU?=
 =?us-ascii?q?nscA1ksAVUTFwsHBYEpSAMqNDEjgSMFNEE6ggtpSToCDQI1gh4kWIIragQFg?=
 =?us-ascii?q?SqCN4RChEKFUoIRgV0DAxYPAYMfdxyDTIEthG0dQAIBC209NwkLGwY9oi+FW?=
 =?us-ascii?q?6dAoT00B4I4gWaBYwyfXgYTL4NwAZNUDgaSfZh9IqNLhUSBbgUugVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIRmEFMgaQjU8AgcLAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:mHTyO6FhITeQAjBfpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3A+Qmo+WtL6VE8KOzBTW+K1PcF6IsGY1fw3lmBe3O?=
 =?us-ascii?q?bU1pqVLmZQkWM2KR7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AUxycAQ1qTnawhxTYbDN1wYhAYjUjyqXyDkAStZ8?=
 =?us-ascii?q?/usCZdgJKOG+tjGuyTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210730687"
X-MGA-submission: =?us-ascii?q?MDHy+FrhYm4oyiBVjWYOPKPYwL345AvKWql4I0?=
 =?us-ascii?q?xg/RRX+cbFDSSvHYjtA/eiVQwsmlrrivXZUzXFbTROYPvTW+0nmY8m6c?=
 =?us-ascii?q?eBdUbepUYxIciTZRSeI420GFPTx/KRLBx6Hp5xFg4AckEbwfLti2mkln?=
 =?us-ascii?q?5/xo5znNQTEXosVuqBOb03Mw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 11:55:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740912943; x=1741517743; i=markus.elfring@web.de;
	bh=VqYiC/Urv+QeTRVVnQ0nKRDlIMPrDZwnbgoBNCimnCs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rsRTgk1BilDJKC1ILluzzCvtJtrTrZaOuwy7SpFg28Phcn40yuWntuxSIMk91lAL
	 JBlfF/AZkAkpbyY2+qcHdr8jJagxO/BbZFUU8uKWhXirfAcC/GR38Jj3MWKjPNX17
	 vHKNOuEqBC1kLKLQE6iYo1saKlYPziGG4uiOuGLwjs9CzG7VJ8And1S0UM9G2eJA4
	 skcS47fYtZij1lI0gouxlUuS1/FimLzv/PtTrPHcqxDL03tWEvxN2/mN6mBDfYWN3
	 ZDlXwSpgkvjv4ycjNhQxqvgn5KzOyftIB1IYUokw84GrRZJM+wGrD59fN1PRHwcR7
	 nBwxvdOmWRlc56V4Ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgRM5-1tLw8n45i3-00oWVg; Sun, 02
 Mar 2025 11:55:43 +0100
Message-ID: <68eb40b5-4b3b-495c-a0a7-cdeb9c9ae216@web.de>
Date: Sun, 2 Mar 2025 11:55:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <410c55e5-0a41-4c7e-84ba-55e936795813@web.de>
 <E43F88D1-E2A5-456F-9315-D5788162848F@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <E43F88D1-E2A5-456F-9315-D5788162848F@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Fk3HDHq/PcPkckEn10Y1EtL8I9cShRYKrUDFWpzKAJZTAJtyfiY
 F/vyCc5hhfyr7DOJnWSKP7Arub72kATxDRTbqdmDGw4OcCZCYwfmZc/pHpgh4vCL7Q0dAor
 UI8Oq9/0WCjDXCar44esQ914Vf6KkdJ7EGHUB0YNU7ApIyfCcu7/YWNl/o1P/LEhi+QNr79
 c2EHQ3pIF0b9o/ECayxTQ==
UI-OutboundReport: notjunk:1;M01:P0:QMG7AklwXzU=;9VyOu3CP+kmt6B0J8FKaPVOdbGD
 CYssOf7gAtJ1ldpPs4vKcPel5PZInZH6RBcHfpYOoCXZBjbW9XDuWdQC9+iAVdt/R/hmUeNJK
 b7FDRAJs78MiGODPGvPt93UGhnsiKHKzfr6qYYyi6Elve1Z0FZa9LrzjtUGtZPDYjtf/kTjYa
 bEwt/cbZJWvcugMle2n5+TNDK6DAUpFP3aV3rf6yIxVOqbEPlMg5eBZdvzjcAs+8lTQ3JurW7
 7KwWDG13yagsl0Y6z+PlVQ0Qxk1nr8AF4NRFDSA+dXZ2YYxJaXDjFQstPWFEkqQDW+oUFwxeB
 aF+IW1x91ZUZar0arHoVt/RcrvqMRjzRUQwMzQaJgJ0zQ50S4LfUIPKDZTCgs7IDP/PiTI/OW
 ioSbXMthrKqeXataMNkbUBNLVM5kQHHjROln8j5pGwD/krY15tCGa0zbbhKsj/ApoEnzBryGo
 2YZWwZxO0EWlW+PIqcUTC3bt28WI5SJOqg4jGnS35SS3clv0xBuSHDscMyQB4oMNFamYoUF8J
 adQsx6dcJWEcXYtoP28VRC5GJZ/TrrcPnSQ2Ht4RlqMeBp/pzDlkV5GjueHIzU1Zg9hwo+JnL
 sAr57kELRtIC+iS0cns2znfrxTB02fKVO9R9w+LjV3xDh6OrySlJ1pzOrDC/+lmOn9TdxXg8Z
 vQ1PxumiB08YIhEidUJl+UdpKhPe/vEJWvejB+mE70/CLlSxfpgq11czNX2HBBbdvLQ4LWHBn
 r6CLWe4bz9qf4M/y+38goVVYcUYY55IZD/fJATgWFbqP8YOdMmn33cRdadv68tBscWpR3+2bJ
 KBmQGYNqsvzEG5gdJF04XLiGMZStNuv+h97O5HXqSlpoOAbPiyJkACGG4iulNz+ybhpibBLIr
 Gu1m3VTpaIhPjXfrTPIHKJ3tzjErhJOKpNa3Eb9kkzLRxjA3Ei36Ydz4YLv5rOrfe44qQy4pp
 izc/Y+TiCGCMye5rurxbAtTK0Jl+o1JbTo135Gxy9ZjagxTzUksf49f/3GG8ARO7KyZx3cBGR
 LW047+/zXNW7dPX5e2zdexJ5sxD4SymRppakIos6hJ70ZKYHZcdSzzLSX1XiftMe+hr2+HmT4
 N6mQ8MuXwfUW9/vXvqEUUcNMPef8veFNM8cMnHEpn9dV0QavBtzEIGGAoD9Rm8Wk6uOSSrJzf
 ZzUDsbu9Uf4izVYX+aWkUW3525RFl/6JeYC4ySeC74G6EYvestnXw+luKfgoIyKLOAtIqlD11
 BemnkXjqGo9BPxx65kynVLGHeIOVPvY+lX50JfP/8+hB9k/8U3W0iCMz7f9FDIKW4SUGf3GaC
 yN3r2AAgcFTXpaWPAXBMmPkudatSORADtYR6rw8j+TDzH1dFhqGLMo8ivZYFNU21tJnaF3iGF
 x/0C5/O/Lme9wgN+P4Rx8VN/dDkYMIiaAGruf67SipFyYr54kXSe2VK9cB7i7tpFRk2EKLzZR
 hVyXOoQ==
Subject: Re: [cocci] Replacement of the form `x |= function()`
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2465
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/68eb40b5-4b3b-495c-a0a7-cdeb9c9ae216%40web.de>

> Probably you are missing a space after + ?

Do you really insist on the usage of extra whitespace characters
at the shown positions of SmPL code?

Regards,
Markus
