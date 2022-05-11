Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BF8C4332F
	for <cocci@archiver.kernel.org>; Wed, 11 May 2022 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QeyYghi6Ab1JtNySP63HUTZ/CGbgaYnbuHPeWVqKi0o=;
  b=Jgglwu4PLuqNZpwwYizg/KyjAYDjQKosYxx8COXXei2Na5UaUg7hXJK4
   ntDuxqCa6u16huSsQsWjxlUrvJWvSdLQ5f8iIlyO3dxMOA0xgKhbRqlZK
   taAwbtieSl09BzrrOoKIaPgLLMG5uDnl16DxgI/ficbWtwPcOfrwHFDwo
   U=;
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
X-IronPort-AV: E=Sophos;i="5.91,217,1647298800"; 
   d="scan'208";a="35823825"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2022 20:11:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4DB95E0098; Wed, 11 May 2022 20:11:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 28CA9E0098
	for <cocci@sympa.inria.fr>; Wed, 11 May 2022 20:11:46 +0200 (CEST)
IronPort-SDR: lWktomoy6EKlP/9Q+CK2MPzT81UmlbV/lT55Lis8Dk7eWiArUHgM8sGSSGpR1jXb2QEY5SkN5s
 90BJlpxQfTBuC4Yl0FUvgAjcrre8YS6yf06Vz3ACex/l9Oj0CWEw23LCJaTJV11+7LXFMHDQMh
 FVsVnP1CLn9bE+J0xK2yYUVYogpvVtKrF2HHuYFhYxb49kSQ8XnMG3VBjatbCQ1W3+rZZXa4cn
 pfZ+bPQcqe3m/11/0QflUZBpr+7k4LVeaU36x/zY+J5XrYqZC0solU792Sg5BfCi6Mpq0sD+Dn
 T59WB4BW8LvDAE0axS59n8S6
X-IPAS-Result: =?us-ascii?q?A0DiFQA4+3tihwwR49RagQmBUYIigVMtBAtDhE6OZoIoi?=
 =?us-ascii?q?yeHGoojE4FoCwEDAQ0SASwBAgQBAYUCAnYBhEcCHQcBBDcDDQECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDgULBTYGXgZkBIFLB?=
 =?us-ascii?q?IF0CzQNgjUpAYNkAQICASMdAQERGwsBBAsLGgImAgJXBg0IAQGCeYJjAQMNK?=
 =?us-ascii?q?KxugTGBAYIIAQEGhEofLCJSgVwJgRAtjl8nEIFVRIE8gwM+hAaEFIJllVQoB?=
 =?us-ascii?q?A8DHTiBBhKBIXEBCgYDAwcKBTIGAgwYFAQCFRFTHgITBQcKHA4UHCQZDA8DE?=
 =?us-ascii?q?gMRAQcCCxIIFSwIAwIDCAMCAyMLAgMYCQcKAx0IChwSEBQCBBMfCwgDGh8tC?=
 =?us-ascii?q?QIEDgNDCAsKAxEEAxMYCxYIEAQGAwkvDSgLAxQPAQYDBgIFBQEDIAMUAwUbD?=
 =?us-ascii?q?AcDIQcLJg0NBBwHHQMDBSYDAgIbBwICAwIGFwYCAnIKKA0IBAgEHB4mEwUCB?=
 =?us-ascii?q?zEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxYZHRkBBTcnBgsJIxwKJ?=
 =?us-ascii?q?A0GBQYWAyckBiIBGwJSj0fMGTQHghGBO4FBDJ4jBhMtg2MBkmYOBpF1lmOnI?=
 =?us-ascii?q?oILAoFpMxokT4JoTgECAQINAQICAwECAQIJAQECjjaEDIotPzQ7AgYBCgEBA?=
 =?us-ascii?q?wmFRwEBhz4BAQ?=
IronPort-PHdr: A9a23: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
 ybY6NJj8QnOegyn1TdtFhZD+G4juQ==
IronPort-Data: A9a23:fwhnCK27igd+xMa+KfbD5dl3kn2cJEfYwER7XKvMYLTBsI5bpzUBx
 mJLX2CEPP+OMGbxfY1yYdiz9hxVsJ+EmN81TwRl3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywobVvqYy2YLjW17U4
 IuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt+1M8
 fNU6Z6tcD0CMOrvocIADRoIIz4raMWq+JefSZS+mcmU0lGAbHbmhfljZK00FddBoKAtWz4Ir
 KNecWplghOr34paxJqeQ/Nvm99lAc3lJoIZtVl/wDufAftOrZXrGPiav4QIhmtYasZmG9/vZ
 sM2djRTXR38Ujdhal4JB50jg7L97pX4W2QF9AzM/PRfD3Lo5Ad227PsGMHEf8SDA8RThEeR4
 Gzcl1kVGTkfM8GDjyWI+DSgi4cjgB8XRqovKYSe76JonWSp7WJUKyQwSAW48cmm3xvWt81kF
 2QY/S8nrK4X/UOtT8XgUxDQnENoriLwSPINS7Fks1zlJr78vFnCVjhsoitpMoR+3PLaUwDGw
 XelsrsF7xRVubuOQ3uW9vK+pC63MyEeLQfujgdZE1FevrEPTKkJjh/OSNJqFqLwttP8HSOY/
 txnhC05mqlVksMBkam2lbwmv95OjsiXJuLWzlyJNo5A0u+fTND/D2BPwQaBhcus1K7DEjG8U
 IEswqByFtwmA5CXjzCqS+4QBryv7PvtGGSC3AQ1R8Z9rGn2oy7LkWVsDNdWexYB3iEsJm6BX
 aMvkV8NjHOuFCb2PPEsOepd9exwkfG6T7wJqcw4nvIXP8QvLVbZlM2fTRfehijsllQhi6cyJ
 d+Sfq6R4YUyWcxaIM6Nb75Fi9cDn3hgrUuKHMyT50n5jdK2OSDEIZ9YYQPmRr1ot8us/VSFm
 /4BbZfi40sFDYXWPHKNmaZNdg9iEJTOLcurwyChXrXfeVUO9aBII6O5/I7NjKQ/wfsPyreTr
 iHVt40x4AOXuEAr4D6iMhhLAI4Dl74mxZ7iFSBzb1uuxVY5ZoOjsPUWe5ctI+s4+eYlwfMtF
 6sJfMCJA/JuTDXb+m1BPMen89E4LEym1VCUIi6oQDkjZJo+FQbHzd/TeFe9/ic5CCfq59A1p
 Ket11+ATJdaH1ZiAc/aZeiB1VS0uXRByut+U1GWcMZecgPg/dEyeSD2i/Y2JeAKKAnCn2fLi
 VzJXE1A/eSU+t076tjEg6yAvryFKeomExoIBXTf4Ja3KTLeoDipz7hAZ+DULzrTY2X5pfe5b
 uJPwvCga/AKkQoYs4d4FLo3n6sy68G2/u1fyRl4WmrGZRKnB+o4cHWB2MBOsIxLx6NY4FfnB
 BjQp4MCYbjZatn4FFMxJRY+arrR3/8jmg7UsaY/LnL86XIl57GAS0hTY0KBhXAPNrdzK495k
 +4ttNRPsl66jQc2dMmLhGZY+j3UfHAHVqwmsLAcAZPq01Z6lAsdPMaEUiKmsouSb9hsM1UxJ
 mHGjqT1h4NamhjIfU01GCWfxuFan5kP5EtHwVJqy45lQTYZaiLbHSG98AjbiixQyQhblf1+M
 C5nOiWZ4ElIEyhA3KB+s6KEQmmtxyF1PmTuxlFPmGCxo4yASDnWNGNkUQqS1Blxzo+fFwS3O
 JmHxWyjXTuCkAQdGMctcRYNlsEPhuCdOuEPdA5L0ihF81QHjeLZv5KT
IronPort-HdrOrdr: A9a23:d2iqlKxskFjtOBorhqebKrPwCL1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcerIjOPnzEiy792utEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,217,1647298800"; 
   d="scan'208";a="35823824"
X-MGA-submission: =?us-ascii?q?MDEI1wWIqPRC/rgvFCa3yj/8PHik/KLkXdEndE?=
 =?us-ascii?q?JzZFVntlY2BOGSprVyBPuoK6hXRZwzybPbfbsPACyOq5HBtJC+PcSYlp?=
 =?us-ascii?q?jPzOOr2t0zV8Q9SFYLyVDVNdsXjXdpxJXospHo/2pQ3dh+kSVO71JJQM?=
 =?us-ascii?q?3QKiGOpQJGPxkKCj45M17kVA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 20:11:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1652292704;
	bh=QeyYghi6Ab1JtNySP63HUTZ/CGbgaYnbuHPeWVqKi0o=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=EGnOUN9KVetNL7rcBNE7C/KxoqoFCS9zY4brc/jgpAm6rrAWgw46ylYE+tw4i6cMB
	 0wUhTQB9Syz4qK7Hj1HJkYGZies3IQeLqY5v1Rc4mOoNy+hArUxclkQjzocBJ8w6OT
	 jxcgcN6LRNTudOJujsZIRfJOXpQCE3kreQOr4FiI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.6.210]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyNwk-1o0iJv3K2e-00ykhZ; Wed, 11
 May 2022 20:11:43 +0200
Message-ID: <a4e74094-c6de-d23f-4d42-3b68c73687ea@web.de>
Date: Wed, 11 May 2022 20:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-GB
To: Alessandro Carminati <alessandro.carminati@gmail.com>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien>
 <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de>
 <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien>
 <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien>
 <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101236050.2667@hadrien>
 <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9yG/PHCuTgJHiax4Yl8pAqYRQwGdXkVjU104VEF7NJACv2k4ysF
 akKKNp9NTm/4oBTLDzrRQq+2untF3i2t+wxwMSFWuSdRmaX6kvJhpoQbtdPjeDP9F1yzHlc
 aIRPnl00BL3wIqr2/07V6w2wZ3HstyF3qc000CwP4FOGgWdu6EVCroe53Y1Ui85PwDBJHnz
 srhl10EUmmJpcyCuHV/KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0dNzVexTM98=:ZvzaiNaG7FRxwZwpthpN08
 CTEwUY+97aHXsDWkPoERLRh6ny8LYEmK3DSAu3QSEyPWlBOeaNR71A3OMIXh9f47HtV68BnyS
 K0bVCEZ1oQMFhbJ4iKXA35/jYFTF8qbyTdRsrb/HuqvSxnM54psNP6gpJtBrOgXjd/cQHyt7R
 HP4zgcj9IIkJrdJW9jmbDCuDI59zajkYD3vQ6MhTma5l49rEKyllvwAUv1NlH8Tpyz22ebftx
 VKA2yROYgAm92gzkmq0BNOiXVV4znDkDA878RbgPFY70g/n75iicpaJ4efuvHWoTndj49k7zU
 QsZatC8yKKoFrm99t8+PhwCX91VD0hBkR45nraiTyHV4Cde5FzD+vNSPld2UF74bOri/SLch8
 JF7eHQEZjc2gZrnhQ9dCg3OBBS0IpNeXKnXYcUyy9RB0LS2QqGecTIHaABgJ6h+zQVz79PYAO
 kID19/2Bc60mLyc3U/Qmc4OhDJB+oFVkDH7+M+kDEnl66FhMrD4GzC8XEwJsG2/arklp0NJKL
 9JeXG69nFduzeuo7+XFPrRbRYw5eBDJMucLfd+pm2swApeNxdexgQ2X+Ac191XbNyZYLJak5k
 RC04XUJKy3YzeK/3inYb5cwnP0FtmJ8ibqSB4woXB5fVOqmSViefmb/2YtXA40QfokfWWoYEA
 Qrf6rWSLPsAOnk3gSZZgNLsdfFRG0TWS719OHvzr0KgGdKvITJ6MWObNqQ203ih0PiQUfHJFK
 XoTktoWZ9e17jyufpZs5dmIoMue4EaFVQc+SIsgHKi8l0uaffLU5udvd4EK0ml6i+ldieAmgJ
 bjN6H+DGjmlcXejsTfIrwf6zZKNFY6Hq+n+nTA3/46hS0fVmUFGkQGdFUrTJkA24yTYvPtcso
 krcFVFeLu5z1JSFeTOmRutSr8Q6O+Y0yp1PiiT32AKHN5fw4PAT/USX7olURqMO82kKuB6fMn
 PilhgNM2Kn3mLBkGkIgwyKlxTSOu0fG2NGHGx8MwxGZ89Ryi1ycgBte41GckIor0jbYAckkha
 YAldkoMr8Ko/5GzCwsKpgR5XqoTh2lvX3EJ7sUcg+byGdb1DA43V0Ojzp2dqaI5bB7L3hwQ6/
 ZM+yBawR9E17XeoqJHGvc2wvC8UshGDZRkHi4M2uLwGpF1y8qDDX3Xf2Q==
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 384
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/a4e74094-c6de-d23f-4d42-3b68c73687ea%40web.de>

> I'm planning to stop bugging this mailing list, =E2=80=A6


Why do you think in such a direction at the moment?

Would you like to benefit from this communication interface any more?

Regards,
Markus

