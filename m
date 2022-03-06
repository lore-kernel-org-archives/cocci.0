Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C78DC433EF
	for <cocci@archiver.kernel.org>; Sun,  6 Mar 2022 15:44:07 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24633556"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2022 16:44:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D44F4E00D3; Sun,  6 Mar 2022 16:44:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CC53DE004B
	for <cocci@sympa.inria.fr>; Sun,  6 Mar 2022 16:44:04 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-SDR: vBcmzaPi8hRL2qbJK/2porq8tV56p9a1hu1itCu7jCxMSe/5GnzUHYpOxx7D2Q3MtgClK+faaz
 n3vTUQEzHIhmgRwfrJJGSg0tCJOU7P4QOih7JrtAggNPO9AO2qfSQFLWmF+KJaIqkCP/BmVYL9
 +g9kCM7fxM1eRbt+RaU4C6MJRMkiXaUsJeuAr5nRN5gSsZahXyQfg63NVAdlKja72YkAXK11Aj
 3plZ8CNs4J1XMkDjFafINEHctk7NB3HGJTb53fx3FMLT2j8qkwBhEtRr/VCjcp2UAJJpksr+F1
 nTKQs3tTxEfI5MkbQpBHZEtQ
X-IPAS-Result: =?us-ascii?q?A0D/AQCu1SRihwQP49RaHQEBAQEJARIBBQUBQIFagiiBV?=
 =?us-ascii?q?SsEC0SEVI5zgXcxiyOHFowiCwEDAQ0+AQIEAQGCEoF1gQAChBsCHQcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECAwQBEwEBAQwNCQUICgcOEAU2B?=
 =?us-ascii?q?l4GZASBSwSBdAs0DYI1IoNsAQICASMVCAEBESYBBAsLDgwCJgICVwYNCAEBg?=
 =?us-ascii?q?wCCZQEDDSWsQIExgQGCCAEBBoRIHywiUoFbCYEQLI5IJxCBVUSBPIJTMD6HX?=
 =?us-ascii?q?4JllTeEXqFznkA0B4ISgTqBQAueCwYULoNhklcOBpFellWmeYF4gX4zGiSDO?=
 =?us-ascii?q?E4BAgECDQECAgMBAgECCQEBAo4dGR6DboosQDQ4AgYLAQEDCYVHAQGMNgEB?=
IronPort-PHdr: A9a23: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
 d1UbE5H6LGdv3swvw==
IronPort-Data: A9a23:V8wBVa8xvvMBrjX+oCsbDrUD+XiTJUtcMsCJ2f8bNWPcYEJGY0x3x
 mMbD27TOK3YYmumKtBxbIWw8BwD6pPXzoBkGwtu+CxEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b9h6mJUqYLhWVnV4
 ous+5e31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zx
 fAOusyLFwkSZKjPx/UZchZ6EA1iBPgTkFPHCSDXXc27ykrbbz3zzv8oAExe0Y8woL8tRzsUq
 rpBdXZRBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/qVvoIJg2hYasZmB6zlV
 ZIyeyhUahXDXRlQCBQLWJgutbL97pX4W2QF9AzM/PRfD3Lo5Ad227PsGMHEf8SDA8RThEeR4
 Gzcl1kVGTkfM8GDjyWI+DSgi4cjgB8XRqofMf63psU0jmbJw29MGRk3Wnm4jeWA3xvWt81kF
 2QY/S8nrK4X/UOtT8XgUxDQnENoriLwSPINS7Fhsl3lJr78vFbAVjJsoitpNYR+3PLaUwDGw
 XelsrsF7xRKt7uJQHiU6638QdiaZHZJdDdqicMsdwsI4t/nqYc/yyrBR9JxeJNZY/XwHizsh
 S+Hpm4yit3/bPLnNY3rojgrYBr1+PAlqzLZAC2JBwpJCSsnPuaYi3SAswSz0Bq5BN/xoqO9l
 HYFgdOCy+sFEIuAkieAKM1UQu33uq7YaGWE3Qc3d3XEy9hL0yHzFWy3yGEmTHqFzu5fKVcFn
 WeO5VIKu8E70IWCN/QmPt7Z5zsWIVjITIm5CKmNMLKik7AoOlbP/SdyaFSW0nylmUdErE3ME
 cfzTCpYNl5DUf4P5GPuGY81iOZ3rghjmz+7bc2lnnyPjOvGDFbIGOxtGAbfPogRsvjeyC2Lq
 Ik3Cid/404COAEISnKLqtF7wJFjBSRTOK0aXOQMLr/Telc9QTp5YxITqJt4E7FYc21uvr+g1
 hmAtoVwkTITXFXLdleHbG5NcrTqUcotpH43J3J+IluinXQuON794KAafpoxXL8m6O06ka8qF
 aZYIZ3YD6QdUCnD9hQccYL58t5oeiOrsgTSbSCrVz4yIsx7TAvT9964JQbirXFcDie+ucYkj
 aen0wfXHcgKSwh4UpTJZfjpw17o5SoRn+d7Xk3pJNhPeRywodYwdHGr1qc6epheJw/Cyz2W0
 xetLS0Z/eSd8ZUo9NTphLyfq9n7GeVJHn1cQzvR44GwOHSI5WGk24JBDL2FcD2BBmP5/KKuO
 bdcw/3maaRVmVFXr8xjHrwtwa9nv4njoLpTzwJFGnTXbg33W+06fSTchZFC5v9X27tUmQqqQ
 UbRqNNUDrW+Pp+3GlAmIgd4PP+I0usZm2WJ4Plpcl/24jR7oOiOXUlIZkDejStAMP1qPYljz
 ep44Jwa7Am2ixwLNNeaj3kIpjrWcSFaC/0q5sMAHYvmqgs30VUcM5bSPS/B5s3dYdt7NER3c
 CSfg7DPhugHy0fPG5bp+aMhAQaAaVUyVBF2IJsqIlOUhpzai/Vx0BA5HfHbiOhK5k0v7g6xE
 jED245JyWGm4DpiwsRON4xpMx8UHwWXoyQd1HNQ/FA0jCCUuqjlM2A3f+qAlKzcH6SwYRADl
 IylJK3ZvfoGsS0/MubemaKolhA7ceFMyw==
IronPort-HdrOrdr: A9a23:fYB5EqmVdjveqpwPoqKox+1bd97pDfII3DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjkzEnlv4bjJ2wGd3AQV0iM1XYCNu6jeHcGOTWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="7735977"
X-MGA-submission: =?us-ascii?q?MDHO2W5wf+P8oa8aSwmHbqLUzTkb+yDWvXc3a9?=
 =?us-ascii?q?GZLv9EQA44BEiWyO3qbTSiTr/KCqzYzQtoJgxV6ozX3G0wVLefO9+P+r?=
 =?us-ascii?q?YmatJwnVwZp8SRQwTPWe/wlwerccs+1RvOmdFzEPGw4Ok20pMmQXZF57?=
 =?us-ascii?q?MFDYAlE2S4WjYv9sdk2VxU+g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 16:44:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646581443;
	bh=nC284UJ1qXB/TNxsq8yMCQAg9uL24pm1DbAaEvuy7Js=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=qywVKArvF60O21hNTGZjtFG9AlHwGP6qeThZ5E/5zeU9lKrV1cU8+whJQwmZOziaF
	 qbH+c+zhM8qVwkctqc2nfc6mhtsZmo0yDT3d6QqGN6N5Nr3Wrh1dTB+fJTfGZqjbTZ
	 HDKIs8IZggHAVpps9EwI+88Rg1//fH+nBx1nziKo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.90.163]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUU68-1nZeTa3kNk-00Qigb; Sun, 06
 Mar 2022 16:44:02 +0100
Message-ID: <48c05723-cfd4-6c4e-b541-56a9cc89563d@web.de>
Date: Sun, 6 Mar 2022 16:43:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <15f59e89-64e8-ba91-d71b-322e6905763@ewheeler.net>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <15f59e89-64e8-ba91-d71b-322e6905763@ewheeler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uoFN4YoxkTfz8T81UrhqtHpoOe4ylwXBlZFqIiDlKC6UcDHPHoC
 483IQ4zL6FG2LiboAxS/B9jru+Xte2GSSmJYOy85cIoXV/dsG/pubrIrukmNf94TUeeTP3K
 SMrn7ASDZgYMBEL/ek3jNqbWBgyK28tbEgiGihqZzzOlDR9ttHQheZ0yfkaCp8DvLEU2tnN
 hxx1i5o4ZfPzySnpd2ipw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W/hR9b8geWw=:D9SNPrexW7I0l3l26R70ur
 wOzNwnpUVLw8ElSZtxS/nluSeWErr2VbLERrjKREQQGvyvMkb/K5/0Bh2LjGw8x+R+ImU/N3H
 h9fHtITPVhQJOhIyR77f7Pkhc+nvBfAmQH6AI7d52yBW0VRRO2HX/Kih9vCJM+giPGr26mY52
 rYTBZF9XkJVWCz8LGQumFRZRXbwZxsaenDZ5pZZaEsFS2OSgdnwATTy6X0sXHfUiph2FW/frL
 4KFWF8XWo0bRdXTan4amt9stqH43HgzT14ZaDra021LCJKqPCj7JIljhJqgVzGZzT8/dVdjnm
 +q8JpcltWH6Rcop6weZP6/zcySt4ISvyamLBBhzqniGZCaff66Yn11XuqCiQL73091j7RmOBm
 XpGcDiDFKVpE30DQN1S8Aw9v1l8DIOVD8O6si4uMagg39l1dK4J8REKSFCgk3+eJIsst5NFZi
 Cut1oXMUlCV1lKno8NTqwZpWkt7B7XI0Ru3NNznBm4tZgI1PtGtI3itqgYPiB+bdR2FLEqrfT
 3R+Ff1FF75p2JwP3NKvjXfBi/Zc0EOLIwV0+HdbhcmRrFnLiaqCHygH8vYJ/nzDjlQgaDRkNC
 oK4yhgSvCKcn6TN+wyw4CGqhn2wCcXIevekktHEcKU5UIbYfZAs85DEMNxk0DxzsmoU809VXY
 DlALMEWzIqDr9+dVTT8QnifrxbMbrbAUPsD5orRzjdYu4kB6OxWbGyStvFbD5sbudXFeMYUUE
 8qI4Be335agAYyEMUSdFkz1Zs66pYSCG5L3/NZUb5tVzbhtKHGGXQ00cjbWYBLZpmroTvg3x9
 JUTQw4Nz2LJNlEPPBYHDGaDhSM/ZvPl/7CbMRipHioqj5OX6YOOpa8+DfZWluVeQ7NntrXKLS
 ANxRueenSJBawasciauzi0xVfaB0niz3FVwBO0v+ygluM413gldtQfQD9IXe2JjUkAU3RVkka
 3zWzrc031knIYX7bKr8+CFP9WjmWq6KsHopw8zT281HnEXqfmBL+yKp4mcEhiTg3BNnh+Vwd5
 x4Bt44Fognn27J/WKArYjw8kWvvvPJOG009w06zQNZdtdB7bzn1p71Fjh1xLnW3L4MXLbaOWy
 Ezc8qwz8XtkhKQ=
Subject: Re: [cocci] How do you add a function argument when an identifier
 exists in the function?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 170
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/48c05723-cfd4-6c4e-b541-56a9cc89563d%40web.de>


> I'm trying to convert an existing global typedef struct


Would you become interested in any more source code transformations
where data from global variables with selected types should be passed
by additional function arguments?


> to be the first function parameter whenever it is used so we can move away
> from global varaiables and make the code more flexible and thread-safe.


How much does the parameter position matter for your software adjustments?


Regards,
Markus

