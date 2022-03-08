Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E8BC433EF
	for <cocci@archiver.kernel.org>; Tue,  8 Mar 2022 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=liP3tXkdU2/EdzHgQHJMfdVefFNOMyXY5QH3Z0ztX+8=;
  b=K6U725zfjZIgyYAO/jSi8eKm0sx6lY9qSFBAYIfj/9u8GjsCDaOZO1kf
   n5zyQ87R1JNa7MtIQkD+EUOcwwnqT1bVBmgqJn8nxHc36mt7pF3EI253D
   mHHuLQtlMVaWYALq4k0gUU7bKEyyP08mL+EvX/6sAqC2dfgkPN5BEiZox
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,165,1643670000"; 
   d="scan'208";a="25094931"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2022 19:16:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A55CE1D37; Tue,  8 Mar 2022 19:16:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9E1E4E004D
	for <cocci@sympa.inria.fr>; Tue,  8 Mar 2022 19:16:27 +0100 (CET)
IronPort-SDR: syETeRpK1yjpMG07+bQV3wak6BWppZ9VB88d9+TXewWHKblzY4qPqo4r9g7ry4FCpSzWWB/3XL
 GJt4AzVfGtzW+sZ4dw0EZ4bVcYYbPys9g8HvzM6K5jOhrMw8G7bjZQewEdyei5BYDrSQ8ywFHy
 wfHXCRHYGOyZeXeOP42oeSCYBAIKzcJT5hczuwyKcPwiW9LpHbEWp5i5sT0vHowv49NUbPoN/E
 kW6drlsEMY8OeqEJyuf+c59l6c0qOTT2JjbBq6o8iv1PQw+IIM8sCVPN/hQUD6AxeiqCiHO1EE
 VGfEtQANef6ARLqhbUmKMlAw
X-IPAS-Result: =?us-ascii?q?A0BwDADcnCdihk7ASNlaHQEBAQEJARIBBQUBQIFaAoIma?=
 =?us-ascii?q?WwrBAtEhFSOc4F3MYsjhxaKJ4F7CwEDAQ0SASsBAgQBAYR+CQKEHwIdBwEEN?=
 =?us-ascii?q?wMNAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECAwQBEwEBAQwLCQcICgcOB?=
 =?us-ascii?q?QsFNgZeBmQEgUsEgXQLNA2CNSkBg2QBAgIBIxUIAQERJgEECwsODAImAgJXB?=
 =?us-ascii?q?g0IAQGDAIJlAQMNJa5AgTGBAYIIAQEGhEgfLCJSgVsJgRAsAY1NeicQgVVEg?=
 =?us-ascii?q?TyCUzA+hEWDGoJllmmVfK4MNAeCEoE6gUALngsGFC6DYQGSVg4GkV6WVaZ5g?=
 =?us-ascii?q?gsBgWozGiSDOE4BAgECDQECAgMBAgECCQEBAo4dGR6DboosQDQ4AgYBCgEBA?=
 =?us-ascii?q?wmFRwEBjCYBAQ?=
IronPort-PHdr: A9a23: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
 jAqvL3+InFO/oCMlSPzL9fZIoSLPSh4WSc=
IronPort-Data: A9a23:LNUI6qKDo+IiKkvZFE+RpZMlxSXFcZb7ZxGr2PjKsXjdYENS0zZSx
 zAbWTqOOq6OZTP3e9lxbY2/ph8H6pfWyN43Swsd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFvd4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhpsJWz
 9ZfsLiMExo5EKPMgrskWgNVHHQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RHvLktRzgfr
 7pHeFjhbTjb7w6y6JeyUOpxnYIOKMfxPYUQkm5tx3fVAJ7KRLicEvqauocAtNs2rt9pA8rUS
 8srVRduTjCZaDx3EFMFELtryY9EgVGmLmEG8QvLzUYt2EDXxRN41LzFItvQcMaDA8RThEeR4
 Gzcl0zyBRoRNfSE2D+d+zStgPXOlGX1Quov+KaQ8/l3nBuMy2ZVBBB+uUaHTeeRs1yZXNFNL
 mgooDc+g6Yy7hOSR8PwUEjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblQ5oi59hM8O6ZZsFG1xv
 rOdt4K1VGU32FGAYSjFrt+pQSWO1T89AUJqWMPpZQ4C/sWlv4w5yB7CJjqCLEJXpo2ocd0T6
 2rSxMTbu1n1pZNav0lc1Q6d6w9AXrCTEmYICvz/BwpJFD9Rao+/fJCP4lPG9/tGJ4vxZgDf4
 CZaxJfOtLhVUs3leMmxrAMlQ+HBCxGtYGW0vLKTN8J+n9hQ0yP/LNsPvlmS2m8zaZZZIlcFn
 3M/SSsIucMNZSL0BUOGS9v/Uowry7TtD9LoSrjdYbJzjmtZJGe6ENVVTRfIhQjFyRBy+YlmY
 MvzWZvyUR4yVPs/pBLrFr91+eJ6nUgWmDKDLbillUnP+eTFPxa9F+xaWGZim8hisMtoVi2Or
 o4DXyZLoj0DONDDjt7/rdZDfQpUfCJgWfgbaaV/L4a+H+avI0l5Y9e5/F/rU9UNc319mria8
 3ejdFVfzVaj13TLJR/UOG9uYvXjUM8n/348OCUtO3eu2mQiONr+sv1AKsFvJbR3pvZ+yfNUT
 uUef5vSCPp4SgPBp2YXY677odEwbx+snw+PY3GobWFnLZ5tTgDE4PH+eQ7r+HVcBya7r5Vsv
 LCqkA/WGMJRSwNnBcfQSfSu01Lo4SlDwr0vBROQL4AKKkv28YVsJyjgtdMNIpkBeUfZ2z+X9
 weKGhNG9+PDlI8C9oWbj66zqYr0QfB1GVBXHjWA4Lu7aXva826kzdMSWeqEZ2mEBmbz5bnke
 uhfif3xaaVVkFFPuot6MrBq0aNnu4qx/eAHlFw8ESWZdUmvB5NhPmKCg5tFuJpN8bkF6wG4b
 USCp4tBMrKTNcK5S1MceFg/YuKY2a1GkzXe961sckD9+TMx47eNF0lfZkHehCtYJbpzEYUk3
 eZ45J9IsVPi0EJyP4bUlD1Q+kSNMmcEDfctuKYaN4m32AAl/VdPPM7HASjs7ZDTMNhBPyHG+
 NNPaHYuWlid+qbDT5b3PX3KwPYbmpkE/hxHpLPHy5JlhfKd7sLbHjUImdj0cuiR5gpK2aR/N
 wCH8mVrcL6W8W4AaNdrBgiR9sIoOPFd0lP8wR0FmQU1iqVuunPldAUABApGwKzVH6+wsNSWE
 HF0BVsJiQrXQfw=
IronPort-HdrOrdr: A9a23:IuxhC6s4btkn1rB9lMF3IHPM7skDUtV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,165,1643670000"; 
   d="scan'208";a="7978700"
X-MGA-submission: =?us-ascii?q?MDG/F5rMoRFLd/xVHPFIcETt7lbXX5QGeKvIi8?=
 =?us-ascii?q?Li9R4ofxjqsN/09eaWJeTu6S/TU/PGWSPTdvk+vinx9RIHlxFaUJWMfh?=
 =?us-ascii?q?DSEE8HsGXI/F8Fc2+o5TNH8eb0bXWWUdQ3YAZUeAo5WWPAhzSfvxIa1C?=
 =?us-ascii?q?S3PRixof3kroiGsNDCEGSG1w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:16:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646763385;
	bh=/YJ0ckGRZAo8i1XJMaufen8PXAsvS/TmzqOD1+ZyxPc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TPgYQKHmH/FBmF91KI8zime/uJ4dT6foew+oufpArdLq1PtWHwds7RZiohieZpC03
	 yNOHy/+DMXEIerA+H1SdY0t9uBQeSwlZ82vIVnhCjwD8zC4LndihJnS9m2QxC4pET1
	 FwCJqvlSNMi+aWjzAiVYip2Q2h3EzO9JDYKVbc4M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.173.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYtx4-1new1p1gBc-00Ux3O; Tue, 08
 Mar 2022 19:16:25 +0100
Message-ID: <d17e4bc6-f4aa-8bfd-505c-893fc364dfb1@web.de>
Date: Tue, 8 Mar 2022 19:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ed1d7d30-461-8822-7fd2-e1701534c29b@ewheeler.net>
 <alpine.DEB.2.22.394.2203072147580.3091@hadrien>
 <73ca810a-98bc-25db-5202-2ae7305b83fc@web.de>
 <923a1086-8eae-46d-54fa-27b8fff1e@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <923a1086-8eae-46d-54fa-27b8fff1e@ewheeler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ikj52NbGJFLx+WJK3T2SlTHjNLzNt/5uHeIVi3KxrTLieZKELaD
 2zs76EDT3lzQLVaXJ1FF7raHJmTlX9nlU+lgiVg4IKc6fxwLdWPWHtSKPg5wCtQql31+tGB
 VMkr8N35934qV//75eXvnnMimPXXtyDZ4a3yy2O0sV8W0iLgRutEzBC+0PukTEIVb13+yP1
 EHth9QXEH/AO4mBpnEkTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fFrXuR9qi98=:kLpwuFlrDO5UwLmMLYEIH1
 2dw9NT6U4IGiFmNv+xsbicztEQfCUtmGnESymydcrXSCh7uu1l3x0wiioZvXyiircIzVrrnk2
 Xz+kidhO2e9YIyCBnfG8QbKX0dqDP9zKdS1YrKyS88eLPG9K7K2p042aMt9km0yBeHhcjVVuq
 2ZqKZmhepEuUoTvMPK8d8bEhWmdBuwCW1TkD2WtpY9bNZnyH8SuOWSdukveFrzDXn1N+e++DM
 PRN4RuT0bi3MqqXwcCp3goIuVmmqt/uXmdprlQb85Le+f4FmyCH3KEM0gCvS4q7vsd4V7rNb/
 nTrbXWK8g/m1ALMhIWoP3W7oA9aONN2aWMibuPfSVwk40UYxRQ+V1boz74ljTmba3Sg1FVTyQ
 dk1EIRs4bQduzCdrU5z7pJc4nU1A4zmkelJ+fcGkNBGJCbch132WMcec582h5qxkr/9iFvhe5
 GGCjQfpeFtrdSJsQkfRml7LigQbfKU7BG2ZC0fJKGpTT0McKIXEUEnIb33XUwjNf5yH/VFlM2
 n0Sbdw+4IxQV2qaelJwz/VuSqIJT0hsN5wB89zfeIOwHMF5SGlW9wmbBufHgjmh5rfZPDCir1
 EG2dlyWL29Kdn8hZyxc48Gp7JtVvIl9L/n8a3ucVFjJJPIGmtnQL4SgOwXOrNPBi3q7AHJAjE
 d2xeAD8j4Rxt5OUXBmNAl+8+okJTlpimGNpDMnTtaNGSryLpn0A4yBBkjaqEEZxR542fAdkvY
 W5V6Lps952a9yj5kNvXcc8qzMRq0Xu3k0KFZKQ6lqokBh4kLLefUcjaO5M+YfL0A6Jkp0r12v
 Ph3WA9wqzWWPpK3MkWU9ZTUrQAbHdrsGAACosU/efjsomKOaWyLZxjPF0Anfk9Qp+CEWo6c37
 HctdNF9S9dnY+G3eQaXVTiVLEJ7Xn+h9NpM3CQ+JFukJ9wKmgfNc9kF1xX4s2EnqyCOpxsd7Z
 yvID5/ElpopKLOyC6HVNhqd/HZynMOIpjPtDv++ERt3UYqrn62a0hF0n8yyHbA9LWwazN7xW3
 1Zts+ychQa0Y+YLBNdoxOv+RDhO6009OGFXs1vDj7SJJLZp3600gyAFEVtR8iYXUQ3lTR1xRt
 0bxlpHVd9aAiTE=
Subject: Re: [cocci] Does SmPL for functions with prototype disjunctions
 need to be complete?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 188
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/d17e4bc6-f4aa-8bfd-505c-893fc364dfb1%40web.de>


> It just makes it more readable.  I always try to avoid duplicate code no
> matter what language I'm writing for.


How do you think about =E2=80=9Ccode=E2=80=9D which you would not need to =
specify at all?

Regards,
Markus

