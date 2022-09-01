Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A4EECAAD5
	for <cocci@archiver.kernel.org>; Thu,  1 Sep 2022 18:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tNLE677Y4LbbcrKSLlCMADn2HcBnIV39wrGq2TuPWI0=;
  b=OhzxQJJXR+kw069iMrAlWYgEh/yHAEHx08xqeRQkzV7XmhbCHqqwZ2fe
   eRQOwGqePMiQpCwcpI1cbYZbVAUBnCwTNhJ3FSxGuXY4NcVdgAgmkqDXT
   UwuQK9TFcUP4IzUL/Ib9dyEAzZSwPjfcY0VmetHkPm3jTNhSYK1EIi+n6
   I=;
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
X-IronPort-AV: E=Sophos;i="5.93,281,1654552800"; 
   d="scan'208";a="50934293"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Sep 2022 20:12:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01491E779B; Thu,  1 Sep 2022 20:12:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9AF56E7799
	for <cocci@sympa.inria.fr>; Thu,  1 Sep 2022 20:12:40 +0200 (CEST)
IronPort-SDR: 0oGIP8HkZ6VVtnPbOoj4mpxVrjAVRpfahXNlkd4faWEAZiUZtiDYaOOMurmA/TZLNC1rbzu8mx
 rABYOE3vdPoYOBviIk/LVuOGe+OJ9Ias3L3slbULSoMxD8BxjNTgh9aHen5pMVjhHMaP9A4HVT
 fffOFrYJk/Znc8sSH0M9y1b0WiRULyLUX+JJ40dwINgUvOK/zCKhS2BcIKTn9WIyl15NSnKDLs
 03tQL/t5g+38yF6xwGVO6aymmkkb9J3TiAyytUZAOjaCPQitBYpoyl+Tx8FxkoZRi8bdqalPeO
 WiSkuJWazLlQ7noUSZ7pKmhG
X-IPAS-Result: =?us-ascii?q?A0DABACe9RBjhwsR49RaHgEBCxIMQINzgQFXLgQLRYROk?=
 =?us-ascii?q?GIxg1ZPjjKMKAsBAwENNwgBAgQBAYRCRQKEZAIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QBTYGXgZkBIFLBIF0CzQNg?=
 =?us-ascii?q?jUig2wBAgIBIx0BAREnBAsLGgImAgJXBgEMCAEBgnkBgmwBAw0lBwyrN4Exg?=
 =?us-ascii?q?QGCCAEBBoFAAYMNHywiUoFcAwaBESyQGScQgVVEgTyCUzA+gmICgWCDVoJll?=
 =?us-ascii?q?0UmBA4DGiseQgIBC3YDFwMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCB?=
 =?us-ascii?q?hUFAgJNOAgECAQrIw8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHE?=
 =?us-ascii?q?xgbGQEFMicQCSEcCgQaDQUGEwMgbQUKOw8oMzU5Kx0bCoEPKigVAwQEAwIGE?=
 =?us-ascii?q?wMDIgIQLDEUBikTEi0HK3UJAgMiaAUDAwQqLAMJIR8HKCY8B1k6AQQDAxAiP?=
 =?us-ascii?q?QYDCQMCJ1x8ApZwgg6BOyKBQwU1HpJWrms0B4IWgT+BRQyJWpRmBhMug2STA?=
 =?us-ascii?q?g4GkXyXByCNGZoogXgjgVszGiSDNk4BAgECDQECAgMBAgECCQEBAo4dGYNZM?=
 =?us-ascii?q?4otPzQ7AgYBCgEBAwmFRwEBhQkBAQ?=
IronPort-PHdr: A9a23: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
 ybY6NJj8QnOeginzz16TFxRpzwNiI/Z5S1f
IronPort-Data: A9a23:SNSG+qgX4jeTUsE9/w20kZozX161GRYKZh0ujC45NGQN5FlHY01je
 htvWGHVaa3cN2T2eY9+O9/gpktX756GzN8wSFFr+3xhFnljpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8z6TSFK1nV4
 4mq8pWGYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplnsS+bzUIJbT22+UdXUhoKiQkY6dp5+qSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgUs
 6ZCd3ZUMVba3opaw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcChmls3JsSRZ4yY
 eI2SBlVb0j/TCdIO24+FZtjjcqNwVfwJmgwRFW9/PdrvTGKkmSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyCTCE4T+C727qmeLF2y/2MG4PKFGm3tUyjnuh53cKMl4XVVXqkcC80BC0dM0Kf
 iT45REShaQ18UWqSPz0UBu5vGOIs3YgZjZALwEpwF3dm/uIvm51EkBUFWEcOLTKoedvHWRyv
 mJlie8FEhRDndV5o1q+/62QtimvOSV9wYQqOnFdFlZtDzXLiog/gxSKcct5DLK4i9f4Az6Y/
 txnhC05mqlVksMBkam2lbwmv95OjsiWJuLWzlyGNo5A0u+fTND8D2BPwQaChcus1K7DEjG8U
 IEswqByFtwmA5CXjzCqS+4QBryv7PvtGGSC3wc+QMF/rWr0py7LkWVsDNdWexcB3iEsJm+BX
 aMvkV8JjHOuFCb2PPEsOepd9exznPW5T7wJqcw4nvIXP8QvLVbZlM2fTRfehijsllQhi6cyJ
 d+Sfq6R4YUyWcxaIM6Nb75Fi9cDn3hgrUuKHMyT50n5jdK2OSDEIZ9baAbmRr5jsMus/l6Pm
 /4BbJTi9vmqeLajCsUh2dVJfAhiwLlSLcyelvG7gcbac1M+SDB5WqaJqV7jEqQ895loei7z1
 inVcidlJJDX3BUr8C2GNSJubq3BR5F6oS5pNCAgJwj6xHUpJ4qitf9Ne5wydLgh1epi0f8tE
 6hbIZrdWKwXR2SV4SkZYLn8sJdmKkahizWOCCz5MjIxSJhtGl7S8dj+cwqzryQDV3LltcY3r
 7C6+BncRJ4PG1ZrAMrMNqCwwln3sXVEwLB+WE7BI99yfkTw8dE2enKr0aJte5kBcEyRyCGb2
 gCaBQYjidPM+4JlosPUga2krpuyF7UsFERtH17dseS8Ox7c8zfx2oRHSuuJIWvQWW6oqqWvY
 eJZk6P1PPEdxQ8Yto1hD/B0wKh469a2/+1WyQFtHXPqaVW3C+o8cyfcgpQV7vVAlu1DpA+7e
 kOT4d0Ea7+HD8PSFgJDLgQSaOneh+ofnSPf7KhuLUimtjV7+qGLDRdbMxWW0XUPKbxoLMU6z
 O1ntMNPs16zjR8jM9CniCFI9j3QfyJaDPh97skXUN3xlw4m6lBeepiCWCX415G4bYkeOEcdJ
 DLJ1rHJgK5RxxaZfnc+fZQXMTGxWXjTVNF2IF4+y5Chn93Ymrko0RcX/TlfosG5CPlY+7obB
 4SpHxQdyWayE/NAm8VJGWyhc+2ELAPM4VT/kjPli0WAJ3RFlQXxwKkVJuuHukwUm46Zkv634
 5nAoFvYvf3WkA0dE8f8tYOJaxAucDCpyjD/pQ==
IronPort-HdrOrdr: A9a23:C3XwlKDY93MNyH7lHemC55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMbE3t6fHCBLTKadZ/DBrytHSuQ/mpU0dNz2D4MxbhTtENg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,281,1654552800"; 
   d="scan'208";a="22642340"
X-MGA-submission: =?us-ascii?q?MDG2dQ8Ic/yBp1ehTpQ6futRn5FHHkOPY+Rb53?=
 =?us-ascii?q?oFmEHua9X4LrjEdeamK37vsgOXNXRydEE50Acy+UgzyF4s/5Ht3UIG5v?=
 =?us-ascii?q?Ra468CjIlsQDKKt7BvEdNV6g9tojqpH10wo8xD74y7LN9quhTZUJz/P6?=
 =?us-ascii?q?tK4gFRXm789srT/vMMoM3ArA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 20:12:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1662055958;
	bh=tNLE677Y4LbbcrKSLlCMADn2HcBnIV39wrGq2TuPWI0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=P9J/bnz2BTGnBlbWr4L8xWs2k5T42ODgS8iXuvVFg2i9vhZNGiBBDvWoXv/vTPkmN
	 KLpvg5SYKxqtMEWLPgzWueeDTH+gcIPyzd/t4r36RGqQrWlXUhOdCiEk5JkvGBR2e8
	 bbuJrXQ7mVO7LfqIPfTnsUXUOfxDDdrDursbKdeo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.21] ([94.31.85.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9Za2-1oQUks0kxI-005fcM; Thu, 01
 Sep 2022 20:12:38 +0200
Message-ID: <568e61b3-03fd-6eeb-b723-c11205479765@web.de>
Date: Thu, 1 Sep 2022 20:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 cocci@inria.fr
References: <220901.8635dbjfko.gmgdl@evledraar.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <220901.8635dbjfko.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:08+n439WA94GSSAuF3ApU1TYCZMGFk4TQodYpsSGjeUCcgGgXY8
 W58yJGoEUwFEPtKtiR/7GK1jYmdlB8kk3awzpMcruODqLGJOMU5pgMydV/d5RPcAFLLFzdX
 +cHoiXa8d9FL3/qOOG7L+FEh2Vcu/grksUkYiKxC+4DZsCvkgO8N27UU9O/plb63z9oWK+1
 4AWL41S9OvYkDBqZV6nlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TslpnjCp67w=:GmEqhOWW2Q8zlroGnzrOqd
 bHRhJ1dl2oT3OcToeVkBE+b5E7LN/g+rgwL4mxoI8sbgRsP9gzEOFw6sorM+WEqBHduRr9uo/
 hiKgudjQ8uYOO4HmFLGRD74medhNVnv2MiEak/B5KdTSpl+33Gw/zMLz0YH/TfetXMKfpgod1
 c000EPhymuKFT/HC58WqHaSSTbegjNQ7RSKWu4y3nEp6JM48850iw6AXkJu/9Xq8pObnJ2v2j
 vwHTN1EowY01Ca92u2iwx7Oau0ZrzXIR5jw9+BB6FgmDALKBXuAVA7PnF7uRbJ0Ia5v70otFN
 UvkZz0I9p8u9XwbjRQuij9CWSFQOkbtyR6CXuXSe9NutdAaWMvY5uZhmYLcFW4H2i1BnCCxyZ
 ANzsn+neC1jiyIAgN0szFr9sbDs/rXJxy+JWwkh9tJjAEe6Dcn6idGXkw4IGd1eA2By4oX8s0
 InA2c0dF69akueWjKMZ/XIaYyYMY/v8l0auc6+NmJu1ckpSzZQwDUtWD8UFXYBtuUxCWb5OFp
 sVwNqdN+S7zm656QH02FDQnUeLk5CNWYxH8JYa9DrbirmaloR0ZjoTINzGlGjHJfMoDFg1wxc
 f/KbycK2feHDX2NkLcaFjeuSHcpk4K2naJVOyi/8GUV+PjEBjAczUZwpnL8PcpiqD1xq4oP43
 AnxiJs7oot7e1tfV0NHOdecsTtUT26H29+c9IWLeWVUVzaogyrebShYlQZl6lssPJeXiXh8t3
 NNG1h42ObJ8YViFvO+01WQ0il9WqvlD70eu0ciivrOf1EeOQ/c6mxg0tPKQf+v/xnqcFJ59uY
 xlFUw21KCk9+ttoTJ2pcery58nGYg64aE0CNeJDSkVmq9PayC8pAODmAOrGOKSkM+XkmOMedb
 NVmNfETpw2obVfc4oXC6WwX6wyB4tzsFdXsnAI2z2Myr81hXGkWL0ve0eU7KYiQknHJH5FWO8
 0itld9HF0RV0jHb22kqTiklPRSEHSt7kaC9tVAbunLrwoSMw3CADef3SRRStxFCkqAYGlstiX
 xOXRycg1m051OfzJOScS5glXw8Wld7JulWodxMbjRbv+dTHK/KtLfe8hslSqMu07nizYJaAYc
 LUmVPgzW++vcwcxbhXTjJqRl9TnNyOoA9VGn7/iFgKgYFXNMGVKA1qTHd0sbI9DPFNUgptbKe
 tCUiCnDjFOGjmSE/k/RunLsl/k
Subject: Re: [cocci] Checking consequences from concatenation of SmPL rules
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 533
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/568e61b3-03fd-6eeb-b723-c11205479765%40web.de>

> Are there reasons for why this is a Bad Idea?


* Do you care for the uniqueness of SmPL rules?

* Special identifiers: initialize:python, finalize:python

* I recommend to handle operation modes for SmPL scripts in consistent way=
s.

* Would you like to reconsider risks for undesirable change mixtures?

* How do you think about previous feature requests?

=C2=A0 Example:
=C2=A0 2019-04-07
=C2=A0 Support for SmPL rule groups
=C2=A0 https://github.com/coccinelle/coccinelle/issues/164


Regards,
Markus


