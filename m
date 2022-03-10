Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5428BC433EF
	for <cocci@archiver.kernel.org>; Thu, 10 Mar 2022 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=S1uOaB/qIKzrLSMCJPmyqPe0L7156Sp0mvb8g/27NUA=;
  b=vdGcrVxD53dEzLTJaWx3BHXmwBKaXmcEZDlfxzS9UI1ssTIziu0Mlnxc
   Y3oKTjlNJIHY50TGCtYR8NIRE5LNhqtKlGANdzInF2G2KdBV5XShaXLpU
   nrnkjevlLRRn+E3QFNR1xsv/ycuU+Z8iMjcOLTtLCHMrrIWBmIt+D7k0D
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,169,1643670000"; 
   d="scan'208";a="25384261"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2022 09:40:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BE7FBE2FBB; Thu, 10 Mar 2022 09:40:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 68A2CE2FB8
	for <cocci@sympa.inria.fr>; Thu, 10 Mar 2022 09:40:04 +0100 (CET)
IronPort-SDR: 7vWnrAGp2a44ZOOqU03jafdCCgSyhDsY7u874CabJZnkQtN3ZiV/1eVzdU2OMrp8WYSJjblC75
 bRLJqsnhP/aBTE17AVBMj4mO9eyXHIg0WVUzfwBtkCl+bc9bRteBzIOcUH/If9V8PlcPWEFuwD
 HiDUTsdOvixkWFH2cD7FniwLY1BGLrAKm+SEa04r7hfaazWbN5VFovVeeLwLFU1MVY+wsA8bcJ
 h0R/FumLBFrk8WHasS1F2oSg7P/jipdLvgwGyqTecj0F2hDdeab0ReFYrlwn94OZZb9RmTA9eZ
 loYzJA4SV4+FZ3KTl9OHmkKO
X-IPAS-Result: =?us-ascii?q?A0B5BQATuSli/07ASNlagQmEAgdibCsEC0Rvg2WRG4sjh?=
 =?us-ascii?q?xaMIgsBAwENPgECBAEBhQcChCICHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECAwQBgQgnBl4GZASBSwSBdAs0DYI1KYNlAQQBIx0BAREmAQQLB?=
 =?us-ascii?q?QYaAiYCAlcGJIJzgmUBAw0lrk6BMYEBgggBAQaESB8sIlKBWwmBECyGIIcue?=
 =?us-ascii?q?icQgVVEgUiCdz6HX4JllgKBS4FdX2PAJzQHghKBOoFAC54xMwOWMwaRZZZVo?=
 =?us-ascii?q?ReFYoF4JYFZMxokgzhOAQIBAg0BAgIDAQIBAgkBAQKHfYpFiixANDgCBgsBA?=
 =?us-ascii?q?QMJhUcBAYwmAQE?=
IronPort-PHdr: A9a23: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
 HLhYqBWXho5G6FDYnk=
IronPort-Data: A9a23:20YuvKCVvl3VEBVW/9Pjw5YqxClBgxIJ4kV8jS/XYbTApDwl3j0Hz
 mtKXWzVP66LMWfxeNEiaImyoEJQu5SEzdA2OVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPhUlvR0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoyW1hIAom
 fNkjMOLFy5wDv3Nx+8sYwYNRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvYstHoKAuUDsIq
 qxwxDMlNnhvg8qTyai4V/Iqq8AtNsjtM6sAt3smwTyx4fMOEcmYGPSVvre02h8ouNkWQK39a
 vEbTj1Pb0vHfzZlP0o+XcdWcOCAwyOXnydjgFacuqMz50DBzQl7yrGrMdzPe9XMS989tk2fr
 WnH13/oBwkTct2Z0zuMtHy27tIjhgv+X58OUqK1/LhmjTV/21AuNfHfbnPjydHRt6J0c4s3x
 5U89nV8oK4s2lasS9WhDRS0rGTa7AERUZxcHrRiug2Kz6PV5SefB3QFF2IQNoZ56ZVuHTF6h
 EWUm97JBCB0tOPHQ3yq9oCS8WG4Nx8TIDJQfiQDVwYEv4Lurdhr3BLCR9puCoCvidjxFW2iy
 jyGtnZsmLgZy8IGjv3p8VfCijOqh57IUg9sulSJBD34tFshadf8NYKy6FXd4fJRF6qjTwGM7
 CoehsyTzOESFpXTxiaDd+U6Gu377fiyNjCB00VkGIMs9mj29nOuIdJQ7TV5KBs7O8oIY2awM
 krUpB8X+5JZenenNPclb4W0AsUs7K7hCdW8CqGKNIUTOMApeV/V5jxqaG6Rw3vpzhomn5Y/D
 pHHI8yiOnAXVPZ8xz2sSuZBirImmnIkyWXIScypxhiry+PHNnuSVKtDL1aEKOw0tfvWrALQ+
 tdZFs2L1xQGDLygOHaKq9ZLIABYN2U/CLD3t9dTKLyJLD1mL2d9WfXf9rUsJt5+lKNPm+aUp
 XywVye0ErYkaaEr9OlLVpxiVF8rdZN4sG59IiEme1qls5TmjUBD849HH6bbv5F+nACg8RKwZ
 +YIcYOMD5yjjxzZri8FY8CVQJNKLXyWaMHnA8ZhSCcyddhsSmQlPzMikhTHrEEzM8Z8iSfyT
 3BMGO8WrVrvijmO1PrrVc8=
IronPort-HdrOrdr: A9a23:cJFu0KGBiKVt9f4OpLqEJMeALOsnbusQ8zAXPo5KKSC9E/bo9f
 xG+c5x6faaskd1ZJhNo7690Yi7MBfhHNtOkO8s1NSZMDUO2lHGEGgK1+KLrgEIWReOj9K0EM
 xbAs9D4bbLfDtHZKjBgTVQaOxQu+Vu68qT9J3jJppWPHxXQpAl0yc8LgqACEV5SE16FYM0fa
 DsnvaunlCbCAgqhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,169,1643670000"; 
   d="scan'208";a="8133973"
X-MGA-submission: =?us-ascii?q?MDHBbh4ktzYN6Tp3f+1NBFzmaPRoGmQbiD4Qed?=
 =?us-ascii?q?oVbhzlDrvZEScJUV4aW9G753IrjScxtTfY3iUNleN3fagc46bQKF+B7Z?=
 =?us-ascii?q?ryxKFSflV4HF76jjiBqrUb4Ab8E+iV6p0pPteB7hFKTSXfDxAYFbsH0L?=
 =?us-ascii?q?sue9f1eoKwbi3DKh9E0loHQQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:40:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646901592;
	bh=S1uOaB/qIKzrLSMCJPmyqPe0L7156Sp0mvb8g/27NUA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c36WilR+Xve57+C2FSLNLqO+Avdt+j7PO4vbg0FwKo/NdFJpkCKkZAOJio5lBMzxz
	 9Lhx9NkATtIknRiNwFXjQtgBb/mixzR2L8Jt9A0sELAPCy6Jp9TLFlg1e/P5lYDORn
	 lGHdk3eQG80j8kVlhabK4DerCjDNT07i4VKSD9NU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bap20.server.lan [172.19.172.20]) (via HTTP); Thu, 10 Mar
 2022 09:39:52 +0100
MIME-Version: 1.0
Message-ID: <trinity-2c0db42e-6a80-475f-ab88-5eea2e166e18-1646901592696@3c-app-webde-bap20>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Mar 2022 09:39:52 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <alpine.DEB.2.22.394.2203092218430.35182@hadrien>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
 <alpine.DEB.2.22.394.2203090654100.4094@hadrien>
 <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net>
 <alpine.DEB.2.22.394.2203092218430.35182@hadrien>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:/Sn76+ZYNdN/Qs1o1gORb2BqQmr0SiOw838IXa+qUtjYJjE+6kCWt983+w+vXxP4qLGn1
 saaskv56HLBK0GpdPWOsMxQym8UHR+a9IC9IvAoroeQHbGKC8zZLpU0/ExN715KcIzWHTlL9FsEJ
 Y8hPN7aY2tWczxErqqqMfF8Z6VBRZhlrQCTyyZlgRthKKSPY6YmKKktvmm/2sSw9FSj29myGOFXq
 /JOmxr2DEI7+TGykhpj4VFWbrIreuai9y1ncsqnigLp1ZT37W4oIDG/oby/haSjqT+UcpJ270rNe
 zo=
X-UI-Out-Filterresults: notjunk:1;V03:K0:LQzyHCnAxM0=:HNizLUZgDr7El0opaMs/DL
 YvREZbYbx6G/OtBYKW9/P5B4JXN23g55BXMYVF/Ik7WQ7ab1Sjoa58Qmb0a9wVuGggDkzwHpF
 Dpjx1+ASh6QiKqIdc4cXz77LSyhPD65UZbfWKUCqN5a2Os8EUFJNFfYU4PS6He64ZTm7/8kgK
 Gud29/Zrg3U6ewRq0pseco0KSicbs7NBTwq/83xs3rbwuG2UueDwgZ3mWlVTwG4r6U5D27FNd
 4bM0Au/+uMWsg4MGaLo0EaGqxd1r3fknqhlzZPQac73gaFqub3RJlFL6PNI8XtVW1Ux5rBRp5
 u+ycp2CyIaPaj+YcS1HK0XDoVAfQZkdFlQeZZOBSJ9/Vs+J6qchmn5q8GoSptXiahJHGR1xhd
 42xPa4n0JOr8LyBgGJKyq3Ai/yzWAkgmM3H8E5XnYrcnf3VGut/Hthqn6ZBjId/6R22voPmzr
 W+gz8BIDy+QXXNiy3Bks1wtjqLGs6Fj53lViGoQsyO5/FMgOO0iUkuGvJdmuBHRt0IyB40u62
 hACn3/uiQ74uEeSf8+fnk6R3BQ0CIR+giLGOp74KR0RkBsUO5DL8KiVEIPJMwJisnbRWknf/j
 3dbPZ36jWYTNBw78e3K3elKorfVzdtsfK09wCeuL63ZjFVlGv5KRFfjm2q75sON1FoWIVHRv3
 3hHgJgBLqJ+SMZ5fBDTGpQfG+Ory094veCLTkkZ4nFwgnnszQ/dfbjVSaUmHhvBmgzqhQjQeA
 /VVipwGR5yKMcGjGjqRrNytthov6lWgUd7Q2QYsw0CEjWFhcbAYH3qB1CLrGJTXBDsrjl6NIb
 kncm8tt
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 201
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/trinity-2c0db42e-6a80-475f-ab88-5eea2e166e18-1646901592696%403c-app-webde-bap20>

> I have no idea what one would even want from grouping.

I find this feedback surprising.


> That is, what notation do you expect to use to refer to the groups.
> And which group, if there are multiple metavariables that use regular expressions?

I see possibilities like the following.

A)
The specification of these regular expressions is connected with a constraint
for specific metavariables.
Such metavariables could provide additional data by special access operators
and corresponding programming interfaces.

B)
If direct access to special information would not be offered, I imagine that
additional options could be specified for the evaluation of capture groups
(and the selection of regex engines).
Additional variables could store captured contents.


Regards,
Markus
