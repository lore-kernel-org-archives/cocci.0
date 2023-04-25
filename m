Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EAEC77B61
	for <cocci@archiver.kernel.org>; Tue, 25 Apr 2023 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=9BFjumv2XWn7N7JK2tOTwDQKC43IeYo759HG4jYjyG8=;
  b=bZDeUJOBY/vwiKKZZ+GKjmxR174gOVpF5cUDWFYYm0hbKjt81kDV64Cb
   XYMHQvGr2ZE+GInDJIOgP+5MU3Dq1oGVTVchxB7DRgQ4vloWThh6qbfBI
   PUwYSZtLRtLaveiiKnMPPaRDgH1DuB1/ZlTf9s0RJ2N9tbXE4DF0pfPpf
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,225,1677538800"; 
   d="scan'208";a="104848552"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Apr 2023 11:06:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D86F2E0269; Tue, 25 Apr 2023 11:06:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 67B61E0235
	for <cocci@sympa.inria.fr>; Tue, 25 Apr 2023 11:06:05 +0200 (CEST)
IronPort-SDR: 644797fd_dC/cvLOuIpubaV97jkUD/1JPzZ2e3xd1UH1qMOWTCObAwXm
 9sPoYfB12RaailmUdGvDZp+lGUoaMWfsUTfzGbQ==
X-IPAS-Result: =?us-ascii?q?A0H7AgCxlkdkhwQP49RagQmBT4IugUsvBAtGhFORBoRhh?=
 =?us-ascii?q?y6HPohqgVaBQD4PAQMBDUEBAgQBAQMEij0CHQcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CNyIZZIEIAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQESAkdnHQEBESc0AiYCbAgBAYJ6gigBAzEHr?=
 =?us-ascii?q?0yBMoEBgggBAQaCZZkoHywiVIFeCYEULYdTHlyJKw+BVUSBPIMEhU+DDoJnl?=
 =?us-ascii?q?VdpgTN0gSeBMYEEAgkCEWuBEAhlgXNAAg1kCw5wgUWDFwQCFEIMFwVbJQQOA?=
 =?us-ascii?q?xkrHUACAQt1PTUJCx8GRAKCCQSBCXcKUK8KkBGgNzQHgiuBVoFZDIhrliIGE?=
 =?us-ascii?q?y+DagGTHg4GkiWXeKJehUKBYzqBXDMaJIM2TwMZD445hAyPSD80PQIHCwEBA?=
 =?us-ascii?q?wmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:TzDHvqwRdf90gJlQERZ6t+ckwirEfRIJ4+MujC+fZmUNrF6WrkUBm
 mRNXjrSMqyIN2T8KNt1OYu2pxxX7MXcz9EwHQVuq1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEALjim8c3l48sfrZ80sz5qmq4lv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPnzLZREU5rMbc+0dZVD05H8
 6wRGi40O0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyXo4MwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKmUE+A7F+PBui4TV5CN715mzG4L/RvCTWZp0hRiUm
 lndoU2sV3n2M/TGlGbbqyvy7gPVpgvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRj0mjR5RAJ
 kZS9idGQbUOGFKDRda+YAC3/XK+mDUsedR/Gutq4TOT8/+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+8F4xQx4dV5rlrCrt+pQSOO1Ts9cDZcPn5VJecRy4W9+dtu5v7aZos7SMaIYsvJ9SbY5
 RTiQMIWtbgNgMgB2r+08Favb9mE+seXFGbZCi3xWXi57ktTfoevboq0gWU3AN5FK5uFCEaMt
 j4IlqByDdzi77ndxURho81XRdlFAspp1hWB0DaD+LF8plyQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPdLrUJpzlfO5Soi+PhwxUjaoSscuHONg1H4xDXN8I0i2zyDAbIliZ
 MfGIJ/E4YgyUPU+lWPeqxghPU8Dn31imzqKG/gXPjz+n+PWZXiJRK0DPUfGZ+9R0U93iFW9z
 jqrDOPTk083eLSmPEH/qNdPRXhXcyRTLc2o+qR/KLTfSiI4QztJI6GKntscl3lNxPk9ehHgp
 S3mBSe1CTPX2RX6FOl9Qis5Oei/Bsoh8ypT0O5FFQ/A5kXPqL2HtM83H6bbt5F+nAC65a4rF
 6s2aI+bD+5RSz/K3T0YYNOv5MZhbRmnz0bGdSasfDF1LdYqSh3r6+3UWFLl1BAPKS6r6uo4g
 bmrjT3ATbQ5Gg9NMcfxadCU9W2Xg0QzouxJcnHzEoFhQ3m0qIlOAA7tv8AzOPAJeEnixCPF9
 gO4AiU4hOjqoq1uwubomJKrkoaNOMl9F3p8AGP0w+uXNy7b32z72q5Gcr+CUg78XVPO2peJR
 Ltq3dTjFsYYjXB2s4ZYOJR6/5IUvtfAiedT8VV5IS/tcV+uNIJFHlCH+st+7ot22b5TvFqNa
 HKlo9V1F+2AB5L4LQQ3OgEgU+Wk0MMUkBn06dAeAh3zxA1zzYq9fXRiBTu+ow0DE+ItK6Ig+
 /krh+AO4Q/mihYKDMePvhoJy0uydE4/Q4cVnbBEJr+zkQc66EBwUbqFAA/M3Zy/QdFtME4rH
 zyquJT/l4lsnkrsT1djFFzm//ZsupAViRUbkH4APwuon/TGtN8W3TpQ0yg9FToN6hNL19NyZ
 2tZDGxuBKC05zwzrtNyb2OtPABgBROi5U36zWUSplDZV0WFUm/sLnU3HPSkpmQ11n16RSdK2
 o2YxELOcyfYTOuo0gQcAUda+uHeF/pv/Qj8qeWbNsWiHahiRwH6g6WrNFE6mzG+Dewf3ET49
 PRXpsBuYqjGNAkVka0xK6+e8Z8yEBmkBmhzcctNzZMzP1P3WW+NgGCVCkWLZMlyCeTA8ha4B
 +xQN8t/bUmC+xjUnA8LJ5wnAuFSrKYy6csga4HbAzcMk4GiowpDtLPS8SnDh1EXfeh+rPZlF
 KTvc2OtL2/Bo1pVhG7Hk+dcMEWaf9QvRVPxzcK1wsozBrMBt+BgK38z9r6Ou1SULwpV0BaGt
 yzTZ6Lt7rJDyKY9u6DOA6l8FwGPBterb9ux8Se3qMZrQe7UFMXz6zMutVjsOjpJMYsrW9hYk
 aqHtPj11hjnuIkafn/4mZ7bMYV0/uS3AfRqN/zoIElgnSetXNHm5z0B8TuaLb1LiNZs2dm1d
 TCnacefdc8nZPkF/Sd7MxNhKhc6D7j7SozCpinn9vSFNUU74Dz9ddii8SfkUHFfeio2IKbBM
 w7Tucj/1uAA+c4ITFUBCup9CpB1HE77VOF0P5ftvD2fFS+zjknEprLmkgE65CrWDmWfVvz3+
 o/BWgO0YSHaVHskFz2Fm9caUtwr4HdBbS0Ye0UA55hphjr8AGNuwSHx93kZIsk8r8Aw/MiQi
 PLxgK8KFij3GzhJGfk5yMq2RR+RX4TiJf+gTgHEPCqoh+OeG46KRrdsnsulD7GaZRO7pNyax
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:4spYmaDIXYznTzrlHel755DYdb4zR+YMi2TDj3oQdfUnSL36qy
 nOpoVi6faaslgssR0b8uxoW5PwOk80l6QV3WB5B97LYOCMggaVxfRZgrcKtAeNJ8SRzIRgPO
 xbAspD4ZXLfD1HpNe/4Rf9Ct472oDvytHOuc7Oi3ZyCRhjcbs6hj0JbDqzAwl2Wk1eDYAiSf
 Onl7N6ThSbCBAqUvg=
X-Talos-CUID: 9a23:4z6aZmEpNzymTrMjqmJs+w0rB894fkf750fyLWCxDzZgeqOsHAo=
X-Talos-MUID: 9a23:Ar6Drws5y+Eeo/azr82nqztlFZlDu46SJFkRzrQd5cW4DjcuEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,225,1677538800"; 
   d="scan'208";a="104848521"
X-MGA-submission: =?us-ascii?q?MDFG3+FxabC8YEwn2T7irS2HJ1U0pznZM/U38P?=
 =?us-ascii?q?Ee7/kv7O0wWD2W3pUdyxqB36dcgc3cjvf9PUrQl9mS8YPsO+kGaSGl89?=
 =?us-ascii?q?ULrBMg3cbWZPre7z7lAfYhhIAaMAFEOJQKud/YGloooF81vLsrmyuDqM?=
 =?us-ascii?q?fISN91v43GfEzklH2mQkYn3w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 11:06:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682413564; i=markus.elfring@web.de;
	bh=9BFjumv2XWn7N7JK2tOTwDQKC43IeYo759HG4jYjyG8=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=R+l6jBgsWy3DG8/eah+g6ZS5US3aRgjRs8ybgiUt2aunzvTaAIVBRTFcrpHx6jobN
	 8N0+anGzc+QhEiNCQoRu+Hme0K4pKHo4fq3MptnNyc/PptENCeD9Kg6fjERZcUS4E1
	 1Ciq/9wsCp6DIbhC7KxwYQFN3jdSy5OCdm9O0Ljf0uT2q5BwFE7n5niSKZIb5/I8Et
	 LONgRCaIyrtAwFKLa4Qttjq4zvRPaaq8l9rfWN6f5ZqvT7etmbfnfheMYHIRscnTh0
	 dJw2noxCx3bxe/ZNtgOHPzVElvy0vAwoxH//eeheUljRsqJ0Rb9nb7YMnH7T23qBIe
	 oKQEt3K0UpFkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpL4-1qfAPu1o8A-00pTAW for
 <cocci@inria.fr>; Tue, 25 Apr 2023 11:06:04 +0200
Message-ID: <f3fc1b12-f0d7-377c-d2cf-cde9db1c7a9b@web.de>
Date: Tue, 25 Apr 2023 11:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fCJARS3IU81M4NNXGaEOnSLO8B3XbD8vE4MV0avz3noiuCPZKrK
 i4GL/9mkvmtGIhowErh+etNPyNFasibOnt4J/I16MdKbkFykTsZXAM2yR49w/ZBNFuRfyGM
 7QkFJ/ivZqpLBmzMo1MygaAvPhCxznAjA56tmqZ1omoLIF/X4LRABdtbxUgDrPeLLdWQZwC
 UQTkm/ubGpIpT/vayLtHw==
UI-OutboundReport: notjunk:1;M01:P0:+FP0IM9AkM0=;F0xhI5sJuhiqarZ35Y9jlZI0Qwx
 azeAlssG0lntQgelsipua5FvwEQqhMQculn/IgdhIB3E1ZKCZ5JKx7qKbj2NnfzxbqMF+nv0C
 9siGGk6VrjQmDO+N90Idnx1C5aytymK+grT7hFJqZJ9lnYeEJ+VKea3+NmNIGdV4d0myw3dw5
 QTfJYWJQRJA/BpDPce/ejC3AMxMBRqSWL2lk/R5uLKbqHw7mIWKIhXXrwANfuMhGGoHIWeyc3
 v4+468pjITBuY5Wnub686BVJ+xeRC09BPabGihqN0GO1QsDVYCw6bJaBMuDQ/MQ97pxf6qdwB
 icN3C5YUlwx6AMJ2N+ZbnFNcYu7VzJ6KpfIaJU9USEYMxQbp1s3wK0ad11db62Na470zjIG4L
 EgliBrfSCaZrR9TsyntZ70elYRnjLcqxhKkdnbsPxeMnsE3LSJDK3UwUbwfU6dYnAoAMOzfmj
 lB3imEdI6nwmPutTHqB4uAsDMUw6LD6HRRgRS57V72/+KsOL/7o+aCvuT9SemYr/JlCouzBie
 KvqLgsc2tK6x/dmTdNPyX+HipuOhcjOXkPlnyjTjPD6M3rd4U80k/y4BC8T4KzKZAbgYLjnUY
 pj1TLPvVD2CQxmtMoYcbmnVrVlemy06Dhbo4XWXNTJM+fvzu/+apx6HwktHmZGKn3gSzlUnoR
 7Ck4XNHkeRoCATCqibf1B28B5qoRQZJCcDt6V2inmf1OdsNbsVqStVtFSsR4XZeqRPi3TYqpW
 uGJMthSxnMTVUK0nI1CpIk23CaAQnHJLYgXNbtgJlCVDsiacRo6QoDSQ0NIovKsYD7RoJLEBB
 5Y+neSfVvmYOOpUCt4GUKzxnpcXGeikiE9SD88bNdALS6LXDMh00VVxFEcAr4jk9bnP4yLj1g
 dZclYGd0bjpueUvi6pFHXYEBkRPUmOwbnvW8cRK3yD39ZwTAJiOtkxnOW/ydmMUhMwLreNGX+
 gN0Gjg==
Subject: [cocci] Reconsidering redundant function calls (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1128
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/f3fc1b12-f0d7-377c-d2cf-cde9db1c7a9b%40web.de>

Hello,

Script variants for the semantic patch language can help also to take another look
at the usage of various function calls.

Will development interests grow for the avoidance of undesirable data processing efforts?

Regards,
Markus
