Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78945C433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Jul 2022 08:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NJOpuMQxHBC85877YBril0rwy4vSKWu42Km1SMnhamE=;
  b=YOsgv+48V5ktjIzAJA4WOliMm01w7CraSY6wtckXi2KdgOx776qPKyvI
   P4x4P4eUoGF5saDuh65vMzDpsnppavYsml1hAn9fyYlNrAquu0fqvAKFf
   6lCdncmYccJUO8kTqwOMc3DpT894Fd8ijIHG18Moy5qET9j4w2Q7U0kbU
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,239,1650924000"; 
   d="scan'208";a="43922047"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Jul 2022 10:01:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 30016E034D; Sat,  2 Jul 2022 10:01:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9ACF8E0092
	for <cocci@sympa.inria.fr>; Sat,  2 Jul 2022 10:01:54 +0200 (CEST)
IronPort-SDR: aGamRyaIbbUHFxVibNtLdKgkkmYz59iA2LfySEoQOeRaVuHVs/23Di93pL47SewPhI0UpROk8f
 dhGeW1CCzBCT2Rv+ExQRi/Dn9K4Itrw4FtZAyDHo5sMjKacZGr6DyMhuHinrOJVEe6bpzcpVyZ
 d4g2JN7bvzNAjFIn6FazSIeNfP3NT25rUO8Q8on69tjmzaT+v5JV0ISMrMK8uaCr5jJGINAnbp
 NTzC4ELfb9b1/q57xrWk/zLv+GKeMq+MR/LGhxC2pVC/UETex4lMBxRNtH8bF70zrWKWQsdyCX
 ZDs9LRJMmsyq53YjouRvBYv5
X-IPAS-Result: =?us-ascii?q?A0AGAAD9+r9ihk7ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYIjgVcuBAtEhE6IIYZHgXcxhCSHDocciicUgWgLAQMBD?=
 =?us-ascii?q?T8BAgQBAYIQgnQChUsCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQEARMBAQEMCwkHCAoHDhAFNgZeBmQEgUsEgXQLNA2CNSkBg2QBAgIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCERUCAlcGAQwIAQGCeYJlAQMNIwetD4ExgQGCCAEBBoRLH?=
 =?us-ascii?q?ywiUoFcCYERLAGOAXonEIFVRIEVJ4JTMD6BD4JuRz+DF4JljHWNPSYEDwMaL?=
 =?us-ascii?q?S8SgR9uAQgEAwMHCgUwBgIMGBQEAhMSUxwCEgUHChsOFBwkFwwPAxIDEQEHA?=
 =?us-ascii?q?gkSCBUrCAMCAwgDAgMgCwIDFgkHCgMdCAocEhAUAgQRHgsIAxkeLAkCBA4DQ?=
 =?us-ascii?q?AgLCgMRBAMTGAkWCBAEBgMILw0nCwMFDw0BBgMGAgUFAQMgAxQDBSQHAyEPJ?=
 =?us-ascii?q?g0NBBsHHQMDBSUDAgIbBwICAwIGFQYCAm4uDQgECAQ3JA8FAgcvBQQvAh4EB?=
 =?us-ascii?q?QYRCAIWAgYEBQIEBBYCEAgCCCcXBxMYGxkBBTInEAkhHAofCgYFBhUDIW0FC?=
 =?us-ascii?q?jsPKDQ2PCwfGwqBGiwrFgMEBAMCBhoDAyICECkGMgMVBi0VFREGIgEbAptOa?=
 =?us-ascii?q?wbFDTQHghSBPYFEDJ4yBhMtllYOBpF6lnUgpyWBYYIVMxokgzdOAQIBAg0BA?=
 =?us-ascii?q?gIDAQIBAgkBAQKOHRkeg26KLT80OwIGAQoBAQMJhUcBAYk8AQE?=
IronPort-PHdr: A9a23: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
 sNmdw==
IronPort-Data: A9a23:lPDw76ifTXD4E3gLt/eAVQabX161CBYKZh0ujC45NGQN5FlHY01je
 htvWj3TOancM2anKN1za9/k9EoE6JDTmtcxTws6qX9kECNjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8y6TSFK1nV4
 4mq/JWFYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplsJyJGQpuYKP1p+EPdUZbQxF+HZ9n9+qSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgRs
 6NCbmlcNFbc14paw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcEh2Zq3JgSQJ4yY
 eISSSpPdwTpRSRjGW0XUZIfw+r0qWTWJmgwRFW9/PdrvTGKkmSdyoPFNNPKc9iObddUm0yCr
 yTH+X74C1cULrS3wj2O+XOEnf7KhSq9WYQIFbT++OQCvbGI7mkUFQFQSlax5/W04qKjZz5BA
 0kUw3oj6vY8zXOuXP+iXE2IoF62nxFJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaiSMmedA5/
 gLQxYK4XlSDpJXEFSPErt94uBvoYXB9EIMUWcMTZScoi+QPTak2iQ/TCMluGui5g7UZ+A0cI
 Rja80DSZJ1J1abnMplXG3iZ21pAQbCXF2YICv3/BD7N0++ATNfNi3aUwVba9+1cC42SU0OMu
 nMJ8+DHsr1QUsnVznfWHrhWdF1M2xpjGGKD6bKIN8ZxnwlBB1b/JOi8HRkjeBY3aZxslcHBO
 haK5185CGBv0IuCNPIrPdvoVazGPIC5W42tV/bIY8BIb4Q5fQDvwc2dTR744owZq2B1yftXE
 c7DL66EVC9GYYw6kmbeb7pCidcDm3FmrUuOFMuT50n2gdK2OiXOIZ9bawTmUwzMxPjYyOkj2
 40Cb5fiJtQ2eLGWXxQ7BqZIcAxXdCBhVMumwyGVH8baSjdb9KgaI6e56dscl0ZNxsy5T8/Eo
 SOwXFF20l36iSGVIAmGcC4xd77lG5py9CppMSspNFeu+n4ifYf2sPZBLcRqJ+F/+bwx1+NwQ
 tkEZ96EXKZFRAPHzDJBP5Pzm4pvKUawjgWUMiv5OzUyJsYyRwHA9tL+UBHo8S0CUni+ucck/
 e+/2wmdTZdaH1ZuC8PfafSOyVKtvCFBybwoABaSeoFeIRy+/pJrJir9iu4MD/sNcRiTlCGH0
 wu2AAsDobefqYEC8O7P2fKOobCvHrYsBUFdBWTase27OCSGrGquxYhMDLSBcTzHDTqm/aK/e
 aNKwvu6PPBexARGtI91ErBKy6Mi5oKz9uEAkVk+RC3GPwaxF7dtAniaxs0R5KdD8b9uv1fkU
 Ey4/NQHa66CP9noEQJKKQd5PP6P0+oYxmvb4fgveRyo4Shq4PyYXE8UMxTV0H5RK758MYUEx
 +Y9uZdKulLl1Udwao6L3nJO6mCBDn0cSKF55JsUN4/cjFZ5wF91Z5GBWDT954uCaokXP0QnS
 tNOaHEuW1iBKov+n3sP+bzl2O1AmdIRtRoMwFJqy5FlXDbarqdf4fGT2W1fosdpItFvzO95f
 GRmX6GwDbvb5C9m3aCvQEj1czysx3SlFojZ1FYD0mHUJ6VtuqohM0VlUduwEIslH66ws9SVE
 Hx0CIoobNoyQPzM4w==
IronPort-HdrOrdr: A9a23:NqIZdqlyxtnOieda1toa/gN8LSXpDfII3DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzEnlv4bjJ2wGd3AQV0iM1XYCNu6jeHcGOTWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,239,1650924000"; 
   d="scan'208";a="43922045"
X-MGA-submission: =?us-ascii?q?MDF346Rg/sH6/IuKUqdFSUNVL78BQa+f5NEWy2?=
 =?us-ascii?q?t5o6sj5TqnEtOqmSILTNtNnul6HNbWPqRP7andxWJAt4j3H4YIh549qk?=
 =?us-ascii?q?OYfQda+bi6QLvRomdQMHK1u2zSv9s6StII9AOFy9Mx8mpDu/EsSeaeaX?=
 =?us-ascii?q?CxaMI/o/Dgby1fSZlgpSOzlQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 10:01:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656748912;
	bh=NJOpuMQxHBC85877YBril0rwy4vSKWu42Km1SMnhamE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C/7vqMPmhT3+8P2HuUWIvgs8uXvdEBTG9EENS64kZKPgibv6ZQcTMOGxf43JPf7Ic
	 bVakiinKfYUGcQ4nJtp1YvLVRGPp6nX8fi1Vc9kR1enCxCJjm6Dw1VdJM88gpxig19
	 9PzS5nmxIvA57+b0Zp7wwo0zNJ36HN0GIK3GcyIw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.49.151.168]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCol0-1nyiMy0Que-00962e; Sat, 02
 Jul 2022 10:01:52 +0200
Message-ID: <51130aa6-1a1b-51fb-c4b7-c0dcda1d78d1@web.de>
Date: Sat, 2 Jul 2022 10:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <632c81ca-3d53-4ff5-505e-f8da998e47db@web.de>
 <alpine.DEB.2.22.394.2207011647580.4779@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2207011647580.4779@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qHAWaW2D3EZmUD0bSSHQauDmnU2LaP5v4LaBdsYfIBWXOFVA0cm
 3myQv8Udx4WYJkdUAwaMaPvwRnn5jAeI/bcPTOGbI657ku9Ivcnp23GX+zcIKxDBwW4Ahb5
 hi1MRie42IJivnTb8cwCpYuTfgxy+vbBYDuBamlcpHUKQQCKLLheAd8T/xU+LUhNjzctB9C
 2zq6CwZCgwEIpiPRjIIZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:obq7TcYzrmo=:QfTOFedaHIVSnnKe4Yo8b3
 BHBmrWvWduis2DaOAMBnIoVkCt+18XYNphYHVJ432/cqhlCayoBvyLC+EduTikh9yV5skW/u3
 VrKZd21wgUw+46JMoA/x+HLllYLVxODoAb9KbrTb6CzArJtK5usP4TshNvJ5XTLLGECbSGs4v
 Nevc3HQ73/5ZUXMwHYsf8sdIqgeWv5cmCkW4o8N2lyv6iknP/98ojm8EI9DnlbwHXW/BTOt5F
 u6F/v2YP8krsKsbrLMTR/aC2slFftpz8d8kLA/O6Yj5GbB4/2up1QvLkHGXhMAOlApJwVDjg1
 B7BpG2RUJpOu1EvnFSI0MkuM0dAi0Nyl19IsBa+EuqA0hYneJ7WE0r9a/LI5fWtlonmBg48BI
 Sjng8kymx2cPq5g8dY7AiRyJFs0g9JwTie2cumIgNmqNcISlI0Su1sR9Ljo3Xu1OStDdRp/AJ
 +UApEsu3m0kbaP5OUGWcV433CmX3wsUmizxXsRZuR/gja5tBl5J2oEUhDadaN2ZEtVf+111Fx
 yeYVU2VMrhXVHGwRoqDo8BzMCL1DEi4XWl1+IJdyUFAUq97AILw/EbK4FllDACnwmGfYSfbuP
 6HJpg03qIw0tYMG1WKo47pvGeeLEWiXohQIBhGyAa1Ob4VBJel+hjLhfSLpeRt84E0zY3tVRU
 yIvzDx5J5646lVu+D5Q8Eg4e4ifG3J+gpKxZw4SDoOSEO/yQDIlzbVm5byG5a+cYKS9NcbIZM
 sizVR96e8y5Tdw9d7b3E4v72AnWmetqHKpmzeJ+0/S0HHAvsaMQp8TFAN5vNnKPfQwHXoQQ/G
 krKNK/6iJGtOZ7lcWiuiyamwIhh8OrDB8kn8a9rjGIGloTX2Y7jZIN0Z9hJ2N20rYhUMR/Wf5
 TFE8VS/rbE0WmWJseKCBIcTaUU1zJaL80zuHxCLWbOZSOt+93OHdJzsveKsDTpoYvpKKd4ZOH
 sUc2Ng6lLW05Uvclr4UkZV3s4Ay2kKVH/7SqwVWWcJQvYfR4pbzC3xTTahGTQWWRtWKyqPO5S
 ekMpkrmOLV5qsMcMeMcLx1PNdckO8J0reovht2c+EdTo92qX/l7HTUAXv/mvO46nWtNVkoMAy
 Kx5BasgcmNzPlqRcvkS9hW6F2PAeec4RJ9aLKQfUZ7uAue2Sj+p/1VOgA==
Subject: Re: [cocci] [PATCH v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 476
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/51130aa6-1a1b-51fb-c4b7-c0dcda1d78d1%40web.de>


> The whole point of the proposed change is to trigger some isomorphisms.
> I really doubt that any isomorphisms will be triggered with this suggest=
ion.


Such expectations are interesting for further clarification, aren't they?

Will any extensions become relevant also for the handling of isomorphisms
by the Coccinelle software?

Would you like to extend the following SmPL code variant anyhow
so that more case distinctions will be taken better into account?

@display@
statement is, es;
expression x;
binary operator bo;
@@
(
*if (&x)
=C2=A0=C2=A0=C2=A0 is
=C2=A0else
=C2=A0=C2=A0=C2=A0 es
|
* &x bo NULL
|
* NULL bo &x
|
* !(&x)
)


Regards,
Markus
